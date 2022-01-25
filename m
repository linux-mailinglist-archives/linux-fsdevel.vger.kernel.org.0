Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0848A49BE32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 23:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiAYWGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 17:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAYWGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:06:01 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B57C06173B
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 14:06:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id h7so33924389ejf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A+cTJ1SVa26aTL7zI1ILPpNADyxpv2jShc7RzkaGH2c=;
        b=WmvSy0Ckei55Wd9dBFx+lermpeznFGtDOV8uvkzZpP3D1WCrrwZxEVTWA3nddWxHoK
         3jhXRYD6FYP578YAfH9/Gq8mv58Fb/1G3EAHOFXE3d1+2bAFZTaMRsd16Qv4PFESz+0W
         KUFmTw7O04+x18maAVwgpRWtiQeJOb4QPtN0I92XQLVdfNsz+1tigLdMMJsGdq3B25sI
         5JSmyqiRtCm0lf/5yBOQYXA7/gRk95rqUefaml+hZGNz0e5lIUWs1H3JQ67j4x87VVkr
         +aG7a0FBnxgZXSCqMu0ELHDMHTz6qY62SZw4Oy/u4BQMpbHx/pGLwhVtEHnH8MuaGoSh
         d7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A+cTJ1SVa26aTL7zI1ILPpNADyxpv2jShc7RzkaGH2c=;
        b=pbjMA5uKT1BKVC9r8C9nvO5aXyZiqYbkYJtw9sqHESCGbX0psSGFWeNfzOQChKdo7J
         cl7gOLDQh4UIXJQzP+K/MSb4y93+70MSHYxa6gY2cLRbK//eRWaQRflaKAWPyMeeJk/c
         nx5bhDZbuR3vFNSWK6dnCY0XyDpQgQvN42Jl5y1No1LnYoNMMUu2D454lVYJFP7pRJ+P
         NqeOt8xgzGn+2wqUJfSNDMzLZ7yEZH05DM0tfSa+5QZHGgRuHUpvXY5eHW/ljfDhqzTJ
         UrFY3cDF0ZStDUDqlMkJ4owCHRsQskb3lcySI/0VwgQbMqIkgi4om9D1gfKiFe1hGjJz
         nAsQ==
X-Gm-Message-State: AOAM532JB8BO30yarkz6A+16cz7heySMsnERofv2Ieil83bj8U5biz72
        8b+nXLsZO2N6ccDsegMZWVbZ6BxhCSbSa165x95HLSkL/56kvw==
X-Google-Smtp-Source: ABdhPJw/GJED2sCxoY5DdeQjW4ueqifIXAm51KWao7SPLrpg7OA6QekstoLigGoc+CHsG/mK62BkyvocuMoB1HxX02Q=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr17273508ejo.290.1643148359212;
 Tue, 25 Jan 2022 14:05:59 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Black <daniel@mariadb.org>
Date:   Wed, 26 Jan 2022 09:05:48 +1100
Message-ID: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
Subject: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Folks,

I've been testing the following on a 5.15.14-200.fc35.x86_64 kernel
with /mnt/nas as a CIFS mount.

//192.168.178.171/dan on /mnt/nas type cifs
(rw,relatime,vers=3D3.0,cache=3Dstrict,username=3Ddan,domain=3DWORKGROUP,ui=
d=3D0,noforceuid,gid=3D0,noforcegid,addr=3D192.168.178.171,file_mode=3D0777=
,dir_mode=3D0777,iocharset=3Dutf8,soft,nounix,serverino,mapposix,rsize=3D41=
94304,wsize=3D4194304,bsize=3D1048576,echo_interval=3D60,actimeo=3D1)

The following is on MariaDB-10.5 but I've tested on MariaDB-10.2 and
it looks to be similarly implemented in MySQL-5.7 and MySQL-8.0.
/mnt/nas/datadir is empty so its an initialization failure for
simplicity.

strace -f -s 99   -e trace=3D%file,fcntl,io_submit,write,io_getevents -o
/tmp/mysqld.strace sql/mysqld --no-defaults --bootstrap
--datadir=3D/mnt/nas/datadir --innodb_flush_method=3DO_DIRECT

an extracted summary is:

65412 openat(AT_FDCWD, "./ibdata1", O_RDWR|O_CLOEXEC) =3D 10
65412 fcntl(10, F_SETFL, O_RDONLY|O_DIRECT) =3D 0
...
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\4\377\377\377\377\377\377\377\377\0\0\0\0\0\0#\37=
3E\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\377\377\377\377\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\=
377\0\0\0\0\0\0\10\1\0\0\3"...,
aio_nbytes=3D16384, aio_offset=3D65536}]) =3D 1
65411 <... io_getevents resumed>[{data=3D0, obj=3D0x7f4efb46c740, res=3D-22=
,
res2=3D0}], NULL) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\0\377\377\377\377\377\377\377\377\0\0\0\0\0\0(M\0=
\10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\1@\0\0\0\25\0\0\0\r=
\0\0\0\4\0\0\0\0\0\306\0\0\0\0\1>\0\0\0\1\0\0\0\0\0\236\0\0\0\0\0\236\0\0\0=
\0\377"...,
aio_nbytes=3D16384, aio_offset=3D0}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\2\377\377\377\377\377\377\377\377\0\0\0\0\0\0(M\0=
\3\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\=
0\0\0\1\0\0\0\0\0\0\0\0\377\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\377=
\377\377\377\0\0\377\377\377\377\0\0\0\0\0\0\377"...,
aio_nbytes=3D16384, aio_offset=3D32768}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\3\377\377\377\377\377\377\377\377\0\0\0\0\0\0#\37=
3\0\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0"...,
aio_nbytes=3D16384, aio_offset=3D49152}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\1\377\377\377\377\377\377\377\377\0\0\0\0\0\0#\37=
3\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0"...,
aio_nbytes=3D16384, aio_offset=3D16384}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\6\377\377\377\377\377\377\377\377\0\0\0\0\0\0$\33=
5\0\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\0\0\3=
77\377\377\377\0\0\0\0\0\0\0\0\0\2\1\262\377\377\377\377\377\377\377\377\37=
7\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377".=
..,
aio_nbytes=3D16384, aio_offset=3D98304}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\5\377\377\377\377\377\377\377\377\0\0\0\0\0\0$\33=
5\0\7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0\362\0\0\0\0=
\0\0\0\6\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\37=
7\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377".=
..,
aio_nbytes=3D16384, aio_offset=3D81920}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\f\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\=
277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\2\t\362\0\0\0\0\0\0\0\2\t2\10\1\0\0\3=
"...,
aio_nbytes=3D16384, aio_offset=3D196608}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\v\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\=
277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0\0\2\10r\0\0\0\0\0\0\0\2\7\262\10\1\0\0\=
3"...,
aio_nbytes=3D16384, aio_offset=3D180224}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\n\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\=
277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\2\6\362\0\0\0\0\0\0\0\2\0062\10\1\0\0=
\3"...,
aio_nbytes=3D16384, aio_offset=3D163840}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\t\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME\=
277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\2\5r\0\0\0\0\0\0\0\2\4\262\10\1\0\0\3=
"...,
aio_nbytes=3D16384, aio_offset=3D147456}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\10\377\377\377\377\377\377\377\377\0\0\0\0\0\0(ME=
\277\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0}\0\2\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\2\3\362\0\0\0\0\0\0\0\2\0032\10\1\0\=
0\3"...,
aio_nbytes=3D16384, aio_offset=3D131072}]) =3D 1
65412 io_submit(0x7f4efb83b000, 1, [{aio_data=3D0,
aio_lio_opcode=3DIOCB_CMD_PWRITE, aio_fildes=3D10,
aio_buf=3D"\0\0\0\0\0\0\0\7\377\377\377\377\377\377\377\377\0\0\0\0\0\0(M\0=
\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\n\=
0\0\0\0\0\0\0\n\0\0\0\10\0\0\0\t\0\0\0\n\0\0\0\v\0\0\0\f\0\0\0\0\0\0\0\0\0"=
...,
aio_nbytes=3D16384, aio_offset=3D114688}]) =3D 1
65411 io_getevents(0x7f4efb83b000, 1, 256, [{data=3D0,
obj=3D0x7f4efb46c680, res=3D-22, res2=3D0}, {data=3D0, obj=3D0x7f4efb46c5c0=
,
res=3D-22, res2=3D0}, {data=3D0, obj=3D0x7f4efb46c500, res=3D-22, res2=3D0}=
,
{data=3D0, obj=3D0x7f4efb46c440, res=3D-22, res2=3D0}, {data=3D0,
obj=3D0x7f4efb46c380, res=3D-22, res2=3D0}, {data=3D0, obj=3D0x7f4efb46c2c0=
,
res=3D-22, res2=3D0}, {data=3D0, obj=3D0x7f4efb46c200, res=3D-22, res2=3D0}=
,
{data=3D0, obj=3D0x7f4efb46c140, res=3D-22, res2=3D0}, {data=3D0,
obj=3D0x7f4efb46c080, res=3D-22, res2=3D0}, {data=3D0, obj=3D0x7f4efb46bfc0=
,
res=3D-22, res2=3D0}, {data=3D0, obj=3D0x7f4efb46bf00, res=3D-22, res2=3D0}=
,
{data=3D0, obj=3D0x7f4efb46be40, res=3D-22, res2=3D0}], NULL) =3D 12
65413 write(2, "2022-01-25 10:36:50 0 [ERROR] [FATAL] InnoDB: IO Error
Invalid argument on file descriptor 10 writi"..., 130) =3D 130

The error message I added is for clarity that the errno=3D-22 EVINAL is
getting returned for the writes.

The same with --innodb_flush_method=3Dfsync omits the fcntl(10, F_SETFL,
O_RDONLY|O_DIRECT) =3D 0 (btw no idea how O_RDONLY is there, its not in
the code - masked out by SETFL_MASK anyway) succeeds without a
problem.

The kernel code in setfl seems to want to return EINVAL for
filesystems without a direct_IO structure member assigned,

A noop_direct_IO seems to be used frequently to just return EINVAL
(like cifs_direct_io).

So fcntl( SET_FL, O_DIRECT) frequently succeeds on filesystems that
will EINVAL as soon as a write/read occurs. Can this be corrected?
Maybe with something better than:

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de5..ff55a904bb4e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -58,7 +58,8 @@ static int setfl(int fd, struct file * filp,
unsigned long arg)
        /* Pipe packetized mode is controlled by O_DIRECT flag */
        if (!S_ISFIFO(inode->i_mode) && (arg & O_DIRECT)) {
                if (!filp->f_mapping || !filp->f_mapping->a_ops ||
-                       !filp->f_mapping->a_ops->direct_IO)
+                       !filp->f_mapping->a_ops->direct_IO ||
+                       filp->f_mapping->a_ops->direct_IO =3D=3D noop_direc=
t_IO)
                                return -EINVAL;
        }


Can cifs_direct_io be replaced with noop_direct_IO?

Lastly on the list of peculiar behaviors here, is tmpfs will return
EINVAL from the fcntl call however it works fine with O_DIRECT
(https://bugs.mysql.com/bug.php?id=3D26662). MySQL (and MariaDB still
has the same code) that currently ignores EINVAL, but I'm willing to
make that code better.

Does a userspace have to fully try to write to an O_DIRECT file, note
the failure, reopen or clear O_DIRECT, and resubmit to use O_DIRECT?

While I see that the success/failure of a O_DIRECT read/write can be
related to the capabilities of the underlying block device depending
on offset/length of the read/write, are there other traps?
