#!/bin/bash
CONFIG="$1"
COMMAND="$2"

if [ $# -ne 2 ]
then
    echo "ERROR: $0 requires two paramters {virtual-host} {restart|reload}"
    exit 1
fi

# reload is allowed
if [ "$COMMAND" == "reload" ] || [ "$COMMAND" == "restart" ]
then
    # Move the current execution state to the proper directory
    cd /etc/apache2/sites-available

    echo "$CONFIG"
    VHOSTS_PATH = /etc/apache2/sites-available/*.conf

    if [ "$CONFIG" ne $VHOSTS_PATH ]
    then
        #Return an error message if argument $1 is zero or empty
        echo "ERROR: File $1 does not exist in the directory"
        exit 1
    fi

    # Disable a vhost configuration
    sudo a2dissite "$CONFIG"
    sudo service apache2 "$COMMAND"

    # Enable a vhost configuration
    sudo a2ensite "$CONFIG"
    sudo service apache2 "$COMMAND"
else
    echo "ERROR: $COMMAND is an invalid service command {restart|reload}"
    exit 1
fi
