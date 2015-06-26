RM=rm -f
socket=localhost:8080
phpini=php.ini-development

test3: phpwin/php php.ini vendor/autoload.php vendor/monolog
	-taskkill /F /IM php.exe 2>/dev/null
	(PATH=phpwin/php php.exe -c . -S "$(socket)" -t . form2.php &)
	cygstart "http://$(socket)"

vendor/autoload.php vendor/monolog: phpwin/php
	phpwin/composer require monolog/monolog

test2: phpwin/php php.ini
	-taskkill /F /IM php.exe 2>/dev/null
	(PATH=phpwin/php php.exe -c . -S "$(socket)" -t . form2.php &)
	cygstart "http://$(socket)"

test: phpwin/php
	-taskkill /F /IM php.exe 2>/dev/null
	(PATH=phpwin/php php -c . -S "$(socket)" -t . phpinfo.php &)
	cygstart "http://$(socket)"

php.ini: phpwin/php/$(phpini)
	cp $< $@

phpwin/php:
	$(MAKE) -C phpwin

phpwin/php/$(phpinin):
	$(MAKE) -C phpwin

clean:
	$(RM) php.ini

veryclean:
	$(MAKE) clean
	$(MAKE) -C phpwin veryclean
	$(RM) -r vendor
