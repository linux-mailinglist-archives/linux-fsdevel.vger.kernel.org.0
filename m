Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88A49C1AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 04:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiAZDCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 22:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiAZDCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:02:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966EFC06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 19:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tQTJF5XHS5VQSQJitBR3CocNG27uBLA0OWBRDBnJOEo=; b=sfhHdib7fe8us6vfqa/qqJYauc
        Kq8KbgbY3yKIXaHpJH43pCa8zrjPj/VLlm4GaBYHg6aes19/BkxqUdYsmPn37XHC/InRxY7mOjyvU
        q7ru7y4C397XSYhat1QaRYu6wV/AZmibMwxl9nzvEveoleUBglrXaZJXVDRrVQT6Yp8UcZE4z3gWO
        iPdT5CW8xtCXbCUg60r7KJtGqjXV8255GpeKrigc0jjaSnfAcQohk2PSCN0POxbS/a6eVxb/LtkOC
        Qn2FCbFNu5XwBTx1x6BDJ6ZgSOha0s6YjNFVmjIHJSupt5yZ2Tujmx+GqjSHlpZvrc1J208vgCQf/
        vJoxwTcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCYZi-003eQ2-Hk; Wed, 26 Jan 2022 03:02:22 +0000
Date:   Wed, 26 Jan 2022 03:02:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Black <daniel@mariadb.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
Message-ID: <YfC5vuwQyxoMfWLP@casper.infradead.org>
References: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:05:48AM +1100, Daniel Black wrote:
On Wed, Jan 26, 2022 at 09:05:48AM +1100, Daniel Black wrote:
> Folks,
> 
> I've been testing the following on a 5.15.14-200.fc35.x86_64 kernel
> with /mnt/nas as a CIFS mount.
> 
> //192.168.178.171/dan on /mnt/nas type cifs
> (rw,relatime,vers=3.0,cache=strict,username=dan,domain=WORKGROUP,uid=0,noforceuid,gid=0,noforcegid,addr=192.168.178.171,file_mode=0777,dir_mode=0777,iocharset=utf8,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
> 
> The following is on MariaDB-10.5 but I've tested on MariaDB-10.2 and
> it looks to be similarly implemented in MySQL-5.7 and MySQL-8.0.
> /mnt/nas/datadir is empty so its an initialization failure for
> simplicity.
> 
> strace -f -s 99   -e trace=%file,fcntl,io_submit,write,io_getevents -o
> /tmp/mysqld.strace sql/mysqld --no-defaults --bootstrap
> --datadir=/mnt/nas/datadir --innodb_flush_method=O_DIRECT
> 
> an extracted summary is:
> 
> 65412 openat(AT_FDCWD, "./ibdata1", O_RDWR|O_CLOEXEC) = 10
> 65412 fcntl(10, F_SETFL, O_RDONLY|O_DIRECT) = 0
> ...
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\4\377\377\377\377\377\377\377\377\0\0\0\0\0\0#\373E\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\10\1\0\0\3"...,
> aio_nbytes=16384, aio_offset=65536}]) = 1
> 65411 <... io_getevents resumed>[{data=0, obj=0x7f4efb46c740, res=-22,
> res2=0}], NULL) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\0\377\377\377\377\377\377\377\377\0\0\0\0\0\0(M\0\10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\1@\0\0\0\25\0\0\0\r\0\0\0\4\0\0\0\0\0\306\0\0\0\0\1>\0\0\0\1\0\0\0\0\0\236\0\0\0\0\0\236\0\0\0\0\377"...,
> aio_nbytes=16384, aio_offset=0}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\2\377\377\377\377\377\377\377\377\0\0\0\0\0\0(M\0\3\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\377"...,
> aio_nbytes=16384, aio_offset=32768}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\3\377\377\377\377\377\377\377\377\0\0\0\0\0\0#\373\0\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> aio_nbytes=16384, aio_offset=49152}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\1\377\377\377\377\377\377\377\377\0\0\0\0\0\0#\373\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> aio_nbytes=16384, aio_offset=16384}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\6\377\377\377\377\377\377\377\377\0\0\0\0\0\0$\335\0\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\0\0\0\2\1\262\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"...,
> aio_nbytes=16384, aio_offset=98304}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\5\377\377\377\377\377\377\377\377\0\0\0\0\0\0$\335\0\7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0\362\0\0\0\0\0\0\0\6\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"...,
> aio_nbytes=16384, aio_offset=81920}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\f\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\2\t\362\0\0\0\0\0\0\0\2\t2\10\1\0\0\3"...,
> aio_nbytes=16384, aio_offset=196608}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\v\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0\0\2\10r\0\0\0\0\0\0\0\2\7\262\10\1\0\0\3"...,
> aio_nbytes=16384, aio_offset=180224}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\n\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\2\6\362\0\0\0\0\0\0\0\2\0062\10\1\0\0\3"...,
> aio_nbytes=16384, aio_offset=163840}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\t\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\2\5r\0\0\0\0\0\0\0\2\4\262\10\1\0\0\3"...,
> aio_nbytes=16384, aio_offset=147456}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\10\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\2\3\362\0\0\0\0\0\0\0\2\0032\10\1\0\0\3"...,
> aio_nbytes=16384, aio_offset=131072}]) = 1
> 65412 io_submit(0x7f4efb83b000, 1, [{aio_data=0,
> aio_lio_opcode=IOCB_CMD_PWRITE, aio_fildes=10,
> aio_buf="\0\0\0\0\0\0\0\7\377\377\377\377\377\377\377\377\0\0\0\0\0\0(M\0\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\n\0\0\0\10\0\0\0\t\0\0\0\n\0\0\0\v\0\0\0\f\0\0\0\0\0\0\0\0\0"...,
> aio_nbytes=16384, aio_offset=114688}]) = 1
> 65411 io_getevents(0x7f4efb83b000, 1, 256, [{data=0,
> obj=0x7f4efb46c680, res=-22, res2=0}, {data=0, obj=0x7f4efb46c5c0,
> res=-22, res2=0}, {data=0, obj=0x7f4efb46c500, res=-22, res2=0},
> {data=0, obj=0x7f4efb46c440, res=-22, res2=0}, {data=0,
> obj=0x7f4efb46c380, res=-22, res2=0}, {data=0, obj=0x7f4efb46c2c0,
> res=-22, res2=0}, {data=0, obj=0x7f4efb46c200, res=-22, res2=0},
> {data=0, obj=0x7f4efb46c140, res=-22, res2=0}, {data=0,
> obj=0x7f4efb46c080, res=-22, res2=0}, {data=0, obj=0x7f4efb46bfc0,
> res=-22, res2=0}, {data=0, obj=0x7f4efb46bf00, res=-22, res2=0},
> {data=0, obj=0x7f4efb46be40, res=-22, res2=0}], NULL) = 12
> 65413 write(2, "2022-01-25 10:36:50 0 [ERROR] [FATAL] InnoDB: IO Error
> Invalid argument on file descriptor 10 writi"..., 130) = 130
> 
> The error message I added is for clarity that the errno=-22 EVINAL is
> getting returned for the writes.
> 
> The same with --innodb_flush_method=fsync omits the fcntl(10, F_SETFL,
> O_RDONLY|O_DIRECT) = 0 (btw no idea how O_RDONLY is there, its not in
> the code - masked out by SETFL_MASK anyway) succeeds without a
> problem.

O_RDONLY is defined to be 0, so don't worry about it.

> The kernel code in setfl seems to want to return EINVAL for
> filesystems without a direct_IO structure member assigned,
> 
> A noop_direct_IO seems to be used frequently to just return EINVAL
> (like cifs_direct_io).

Sorry for the confusion.  You've caught us mid-transition.  Eventually,
->direct_IO will be deleted, but for now it signifies whether or not the
filesystem supports O_DIRECT, even though it's not used (except in some
scenarios you don't care about).

> Lastly on the list of peculiar behaviors here, is tmpfs will return
> EINVAL from the fcntl call however it works fine with O_DIRECT
> (https://bugs.mysql.com/bug.php?id=26662). MySQL (and MariaDB still
> has the same code) that currently ignores EINVAL, but I'm willing to
> make that code better.

Out of interest, what behaviour do you _want_ from doing O_DIRECT
to tmpfs?  O_DIRECT is defined to bypass the page cache, but tmpfs
only stores data in the page cache.  So what do you intend to happen?

> Does a userspace have to fully try to write to an O_DIRECT file, note
> the failure, reopen or clear O_DIRECT, and resubmit to use O_DIRECT?
> 
> While I see that the success/failure of a O_DIRECT read/write can be
> related to the capabilities of the underlying block device depending
> on offset/length of the read/write, are there other traps?

It also must be aligned in memory, but I'm not quite sure what
limitations cifs imposes.
