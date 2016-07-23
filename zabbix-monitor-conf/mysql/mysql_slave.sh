#!/bin/bash

MYSQL_SOCK="/tmp/mysql.sock" 
MYSQL_PWD="xxx"
MYSQL="/usr/local/mysql/bin/mysql"
MYSQL_ADMIN="/usr/local/mysql/bin/mysqladmin"
ARGS=1 
if [ $# -ne "$ARGS" ];then 
    echo "Please input one arguement:" 
fi 
case $1 in 
        Slave_Running) 
                slave_is=($($MYSQL -uzabbix -p${MYSQL_PWD} -S $MYSQL_SOCK -e "show slave status\G" 2> /dev/null|egrep "\bSlave_.*_Running\b"|awk '{print $2}'))
                if [ "${slave_is[0]}" = "Yes" -a "${slave_is[1]}" = "Yes" ];then
                     result="1"
                else
                     result="0"
                fi
                echo $result
        ;;
        Slave_Seconds)
                result=$($MYSQL -uzabbix -p${MYSQL_PWD} -S $MYSQL_SOCK -e "show slave status\G" 2> /dev/null|egrep "\bSeconds_Behind_Master\b"|awk '{print $2}')
                echo $result
        ;;
        *) 
                echo "Usage:$0(Slave_Running|Slave_Seconds)" 
        ;; 
esac 

