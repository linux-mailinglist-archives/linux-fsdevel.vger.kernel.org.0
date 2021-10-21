Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0676A43611A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhJUMOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUMOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:14:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F229C06161C;
        Thu, 21 Oct 2021 05:11:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z69so571710iof.9;
        Thu, 21 Oct 2021 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MX4RTUKipBxn3GCRAnSGv3+ePA+aZeTzUhawOp96TW8=;
        b=PQ/IuCFj6sfDuj4uFzeSnYRXNd9+IoguIe2jXnM7jxhtYB0uQ5A3jtgH7mlrvuuM9c
         aw0C8rf0ErqIwyB9aKV4/uS9fcGdlCgpAxC3Xyad4rmxNKzm3obkMVRJd2Y/1um9I200
         UmzuQKHWlAU84DoRptaFjqIz7Grvxy3dcSUxRwrN2pplTXc07nH4qUs6sdfyJf5P3p+6
         3fCBdQXnl/xthhJ79UkhUe03FhTy13NaZY3c3jQ5wOx7YgerHY3cMnNLtqtUlbcOhksm
         9fLu+02U/s1hOgwbW3XftBY+P6PpYGe0Z70w+GO1L4GXcqvw51UmSvXbQbjkErKUiN5u
         T0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MX4RTUKipBxn3GCRAnSGv3+ePA+aZeTzUhawOp96TW8=;
        b=faU0j4BrUluTTpX47uxCfwF2cV+nv5mkX16R3YCwRmuXGTet8/l9ZljEZ/8TxreqsT
         Bl+BbrZtoUQwrgltzZUwUECgrOGGn1E41zC+wLs8ihaLHIP+HQG8rPSIkz7WGR3vGcIy
         ZuQUe+0F+4eLtc/OItN+HE5vftQ+JPDTEkhzRVQebV5u5YOGRr9LcQZFOIzEqD+LvhFm
         vwb8cPhqGQyYL3iC32AygYHwmZ6alhJiqgbXbncx6bbNzV/NvdcaIF3J1g+oiJ5fdYy+
         bDT6jnveZ474jWfZwDBobzQpvSEc+tn5GgKP4MnExJMReWyFnNyJ9WPOoXZtyalxDMhW
         vbJw==
X-Gm-Message-State: AOAM532etRzfYUIkK8JsAxvt7mHW/5S/vKSGsWsqDgE4HMnxsOJcvUth
        lR7An5wtY/xiENvXz/Vm+1w8MEWt52nATGkgJ5U=
X-Google-Smtp-Source: ABdhPJxV0eGA4bNjneusaPELr/dMv86GyC9/N6znoBxjMYTCykwAIxGIu48HEmACrqNXko9UhJPiObo6SbLSmM3GG08=
X-Received: by 2002:a6b:7302:: with SMTP id e2mr3734611ioh.41.1634818314460;
 Thu, 21 Oct 2021 05:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <20211020173729.GF16460@quack2.suse.cz> <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
 <20211021080304.GB5784@quack2.suse.cz>
In-Reply-To: <20211021080304.GB5784@quack2.suse.cz>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Thu, 21 Oct 2021 20:11:43 +0800
Message-ID: <CAOOPZo7DfbwO5tmpbpNw7T9AgN7ALDc2S8N+0TsDnvEqMZzMmg@mail.gmail.com>
Subject: Re: Problem with direct IO
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        tytso@mit.edu, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 4:03 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 21-10-21 10:21:55, Zhengyuan Liu wrote:
> > On Thu, Oct 21, 2021 at 1:37 AM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 13-10-21 09:46:46, Zhengyuan Liu wrote:
> > > > we are encounting following Mysql crash problem while importing tables :
> > > >
> > > >     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
> > > >     fsync() returned EIO, aborting.
> > > >     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
> > > >     Assertion failure: ut0ut.cc:555 thread 281472996733168
> > > >
> > > > At the same time , we found dmesg had following message:
> > > >
> > > >     [ 4328.838972] Page cache invalidation failure on direct I/O.
> > > >     Possible data corruption due to collision with buffered I/O!
> > > >     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
> > > >     625 Comm: kworker/42:1
> > > >
> > > > Firstly, we doubled Mysql has operating the file with direct IO and
> > > > buffered IO interlaced, but after some checking we found it did only
> > > > do direct IO using aio. The problem is exactly from direct-io
> > > > interface (__generic_file_write_iter) itself.
> > > >
> > > > ssize_t __generic_file_write_iter()
> > > > {
> > > > ...
> > > >         if (iocb->ki_flags & IOCB_DIRECT) {
> > > >                 loff_t pos, endbyte;
> > > >
> > > >                 written = generic_file_direct_write(iocb, from);
> > > >                 /*
> > > >                  * If the write stopped short of completing, fall back to
> > > >                  * buffered writes.  Some filesystems do this for writes to
> > > >                  * holes, for example.  For DAX files, a buffered write will
> > > >                  * not succeed (even if it did, DAX does not handle dirty
> > > >                  * page-cache pages correctly).
> > > >                  */
> > > >                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
> > > >                         goto out;
> > > >
> > > >                 status = generic_perform_write(file, from, pos = iocb->ki_pos);
> > > > ...
> > > > }
> > > >
> > > > From above code snippet we can see that direct io could fall back to
> > > > buffered IO under certain conditions, so even Mysql only did direct IO
> > > > it could interleave with buffered IO when fall back occurred. I have
> > > > no idea why FS(ext3) failed the direct IO currently, but it is strange
> > > > __generic_file_write_iter make direct IO fall back to buffered IO, it
> > > > seems  breaking the semantics of direct IO.
> > > >
> > > > The reproduced  environment is:
> > > > Platform:  Kunpeng 920 (arm64)
> > > > Kernel: V5.15-rc
> > > > PAGESIZE: 64K
> > > > Mysql:  V8.0
> > > > Innodb_page_size: default(16K)
> > >
> > > Thanks for report. I agree this should not happen. How hard is this to
> > > reproduce? Any idea whether the fallback to buffered IO happens because
> > > iomap_dio_rw() returns -ENOTBLK or because it returns short write?
> >
> > It is easy to reproduce in my test environment, as I said in the previous
> > email replied to Andrew this problem is related to kernel page size.
>
> Ok, can you share a reproducer?

I don't have a simple test case to reproduce, the whole procedure shown as
following is somewhat complex.

1. Prepare Mysql installation environment
a.  Prepare a SSD partition  (at least 100G) as the Mysql data
partition, format to Ext3 and mount to /data
# mkfs.ext3 /dev/sdb1
# mount /dev/sdb1 /data
b. Create Mysql user and user group
# groupadd mysql
# useradd -g mysql mysql
c. Create Mysql directory
# mkdir -p /data/mysql
# cd /data/mysql
#  mkdir data tmp run log

2. Install Mysql
a. Download mysql-8.0.25-1.el8.aarch64.rpm-bundle.tar from
https://downloads.mysql.com/archives/community/
b. Install Mysql
#  tar -xvf mysql-8.0.25-1.el8.aarch64.rpm-bundle.tar
# yum install openssl openssl-devel
# rpm -ivh mysql-community-common-8.0.25-1.el8.aarch64.rpm
mysql-community-client-plugins-8.0.25-1.el8.aarch64.rpm \
mysql-community-libs-8.0.25-1.el8.aarch64.rp
mysql-community-client-8.0.25-1.el8.aarch64.rpm \
 mysql-community-server-8.0.25-1.el8.aarch64.rpm
mysql-community-devel-8.0.25-1.el8.aarch64.rpm

3. Configure Mysql
a. # chown mysql:mysql /etc/my.cnf
b. # vim /etc/my.cnf
innodb_flush_method = O_DIRECT
default-storage-engine=INNODB
datadir=/data/mysql/data
socket=/data/mysql/run/mysql.sock
tmpdir=/data/mysql/tmp
log-error=/data/mysql/log/mysqld.log
pid-file=/data/mysql/run/mysqld.pid
port=3306
user=mysql
c. initialize Mysql (problem may reproduce at this stage)
# mysqld --defaults-file=/etc/my.cnf --initialize
d. Start Mysql
# mysqld --defaults-file=/etc/my.cnf &
e. Login into Mysql
# mysql -uroot -p -S /data/mysql/run/mysql.sock
You can see the temporary password from step 3.c
f. Configure access
mysql> alter user 'root'@'localhost' identified by "123456";
mysql> create user 'root'@'%' identified by '123456';
mysql> grant all privileges on *.* to 'root'@'%'; flush privileges;
mysql> create database sysbench;

4. Use sysbench to test Mysql
a. Install sysbench from https://github.com/akopytov/sysbench/archive/master.zip
b. Use following script to reproduce problem (may need dozens of minutes)
    while true ; do
      sysbench /usr/local/share/sysbench/oltp_write_only.lua
--table-size=1000000 --tables=100 \
      --threads=32 --db-driver=mysql --mysql-db=sysbench
--mysql-host=127.0.0.1 --mysql- port=3306 \
      --mysql-user=root --mysql-password=123456
--mysql-socket=/var/lib/mysql/mysql.sock  prepare

      sleep 5
      sysbench /usr/local/share/sysbench/oltp_write_only.lua
--table-size=1000000 --tables=100 \
      --threads=32 --db-driver=mysql --mysql-db=sysbench
--mysql-host=127.0.0.1 --mysql- port=3306 \
      --mysql-user=root --mysql-password=123456
--mysql-socket=/var/lib/mysql/mysql.sock  cleanup

      sleep 5
  done

If you can't reproduce, we could provide a remote environment for you or
connect to your machine to build a reproduced environment.

> > > Can you post output of "dumpe2fs -h <device>" for the filesystem where the
> > > problem happens? Thanks!
> >
> > Sure, the output is:
> >
> > # dumpe2fs -h /dev/sda3
> > dumpe2fs 1.45.3 (14-Jul-2019)
> > Filesystem volume name:   <none>
> > Last mounted on:          /data
> > Filesystem UUID:          09a51146-b325-48bb-be63-c9df539a90a1
> > Filesystem magic number:  0xEF53
> > Filesystem revision #:    1 (dynamic)
> > Filesystem features:      has_journal ext_attr resize_inode dir_index
> > filetype needs_recovery sparse_super large_file
>
> Thanks for the data. OK, a filesystem without extents. Does your test by
> any chance try to do direct IO to a hole in a file? Because that is not
> (and never was) supported without extents. Also the fact that you don't see
> the problem with ext4 (which means extents support) would be pointing in
> that direction.

I am not sure if it trys to do direct IO to a hole or not, is there
any way to check?
If you have a simple test to reproduce please let me know, we are glad to try.

Thanks,
