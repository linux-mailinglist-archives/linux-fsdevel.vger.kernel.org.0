Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A745A4AB0B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbiBFQrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiBFQrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:47:46 -0500
Received: from mail.namespace.at (mail.namespace.at [IPv6:2a01:190:1801:100::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBFDC06173B;
        Sun,  6 Feb 2022 08:47:44 -0800 (PST)
Date:   Sun, 6 Feb 2022 17:47:34 +0100
From:   Chris Hofstaedtler <zeha@debian.org>
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     matorola@gmail.com, kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220206164734.cgdrkcuvwzy76pyy@zeha.at>
References: <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
 <CADxRZqwq=XmXZnnENU+vD7_2oC_VtqhG40P-xg=QAzKchT-3Ng@mail.gmail.com>
 <20220202.232106.1642450897216370276.yamato@redhat.com>
 <20220205.030324.1280110384368183671.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205.030324.1280110384368183671.yamato@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Masatake YAMATO,

Thank you for the followup.

* Masatake YAMATO <yamato@redhat.com> [220204 19:03]:
> > Could you tell me what kind of file system for /etc/passwd do you use for testing?

sbuild/schroot can use different mechanisms, but in this case / is
overlayfs (the underlying fs is ext4):
   unstable-amd64-sbuild on / type overlay (rw,relatime,...)

ls -la /etc/passwd
-rw-r--r-- 1 root root 2397 Feb  6 16:41 /etc/passwd
stat /etc/passwd
  File: /etc/passwd
  Size: 2397            Blocks: 8          IO Block: 4096   regular file
Device: 33h/51d Inode: 1311528     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-06 16:41:26.880589326 +0000
Modify: 2022-02-06 16:41:26.720591039 +0000
Change: 2022-02-06 16:41:26.720591039 +0000
 Birth: -
mount

> As I commented on GitHub, I made a pull request for fixing this issue.
> I found a bug in the test case, not in lsfd itself.
> 
> https://github.com/util-linux/util-linux/pull/1595
> https://github.com/util-linux/util-linux/pull/1595/commits/abd93fcecfbb1a1fac7032fac9d2903c5d2d3a38
>
> > When trying to reproduce the bug, could you applying the following change?

I have applied abd93fcecfbb1a1fac7032fac9d2903c5d2d3a38 alone, which
does not help in my case (DEV[STR] is 0 instead of 1).

I have also applied #1595 in full in a second build, see output
below.

Many thanks,
Chris



     script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file
   commands: /<<PKGBUILDDIR>>/
    helpers: /<<PKGBUILDDIR>>/
    sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
    top dir: /<<PKGBUILDDIR>>/tests
       self: /<<PKGBUILDDIR>>/tests/ts/lsfd
  test name: mkfds-ro-regular-file
  test desc: read-only regular file
  component: lsfd
  namespace: lsfd/mkfds-ro-regular-file
    verbose: yes
     output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file
  error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.err
  exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.exit_code
   valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.vgdump
   expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file{.err}
 mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file-mnt

         lsfd: read-only regular file         ... FAILED (lsfd/mkfds-ro-regular-file)
========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file =================
================= OUTPUT =====================
     1	ABC         3  r--  REG /etc/passwd   1
     2	COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
     3	PID[RUN]: 0
     4	PID[STR]: 0
     5	INODE[RUN]: 0
     6	INODE[STR]: 0
     7	UID[RUN]: 0
     8	UID[STR]: 0
     9	USER[RUN]: 0
    10	USER[STR]: 0
    11	SIZE[RUN]: 0
    12	SIZE[STR]: 0
    13	MNTID[RUN]: 0
    14	DEV[RUN]: 0
    15	FINDMNT[RUN]: 0
    16	DEV[STR]: 1
    17	MNTID: 312
    18	DEV: 0:50
    19	MNTID DEV: 312 0:50
    20	FINDMNT_MNTID_DEV: 312 0:48
================= EXPECTED ===================
     1	ABC         3  r--  REG /etc/passwd   1
     2	COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
     3	PID[RUN]: 0
     4	PID[STR]: 0
     5	INODE[RUN]: 0
     6	INODE[STR]: 0
     7	UID[RUN]: 0
     8	UID[STR]: 0
     9	USER[RUN]: 0
    10	USER[STR]: 0
    11	SIZE[RUN]: 0
    12	SIZE[STR]: 0
    13	MNTID[RUN]: 0
    14	DEV[RUN]: 0
    15	FINDMNT[RUN]: 0
    16	DEV[STR]: 0
================= O/E diff ===================
--- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file	2022-02-06 16:37:28.111146267 +0000
+++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file	2022-01-31 14:57:47.000000000 +0000
@@ -13,8 +13,4 @@
 MNTID[RUN]: 0
 DEV[RUN]: 0
 FINDMNT[RUN]: 0
-DEV[STR]: 1
-MNTID: 312
-DEV: 0:50
-MNTID DEV: 312 0:50
-FINDMNT_MNTID_DEV: 312 0:48
+DEV[STR]: 0
==============================================

     script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device
   commands: /<<PKGBUILDDIR>>/
    helpers: /<<PKGBUILDDIR>>/
    sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
    top dir: /<<PKGBUILDDIR>>/tests
       self: /<<PKGBUILDDIR>>/tests/ts/lsfd
  test name: mkfds-rw-character-device
  test desc: character device with O_RDWR
  component: lsfd
  namespace: lsfd/mkfds-rw-character-device
    verbose: yes
     output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device
  error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.err
  exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.exit_code
   valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.vgdump
   expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device{.err}
 mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device-mnt

         lsfd: character device with O_RDWR   ... FAILED (lsfd/mkfds-rw-character-device)
========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device =================
================= OUTPUT =====================
     1	    3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
     2	ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
     3	MNTID[RUN]: 0
     4	DEV[RUN]: 0
     5	FINDMNT[RUN]: 0
     6	DEV[STR]: 1
     7	MNTID: 312
     8	DEV: 0:50
     9	MNTID DEV: 312 0:50
    10	FINDMNT_MNTID_DEV: 312 0:48
================= EXPECTED ===================
     1	    3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
     2	ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
     3	MNTID[RUN]: 0
     4	DEV[RUN]: 0
     5	FINDMNT[RUN]: 0
     6	DEV[STR]: 0
================= O/E diff ===================
--- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device	2022-02-06 16:37:28.675140230 +0000
+++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device	2022-01-31 14:57:47.000000000 +0000
@@ -3,8 +3,4 @@
 MNTID[RUN]: 0
 DEV[RUN]: 0
 FINDMNT[RUN]: 0
-DEV[STR]: 1
-MNTID: 312
-DEV: 0:50
-MNTID DEV: 312 0:50
-FINDMNT_MNTID_DEV: 312 0:48
+DEV[STR]: 0
==============================================

