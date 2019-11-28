Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1110CDFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfK1Rfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 12:35:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbfK1Rfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574962544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CbRmUtJWirT2qui5wovpHwsGGioEnHtdLzpjLUCDKBU=;
        b=fwYCj9iEPc/BtMi4MwjC2Z5oZOAKPAXchAPHp2evank+hRZf0C40vLNrY6OK6SpcPekGoZ
        cBm5aRTOdqwK79xO6dSoAHpKxVY0f0SI+0fY98l9EMA8ZPCHMwfisXOVYQj4c1bC9Kim1U
        orLAV9tFdn7o8rpOlGyusH4yDz9uZMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-uARu1Yx8PgOhewfXXR5TXQ-1; Thu, 28 Nov 2019 12:35:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48A780183C;
        Thu, 28 Nov 2019 17:35:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2174A60BE1;
        Thu, 28 Nov 2019 17:35:37 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     ltp@lists.linux.it
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] syscalls/newmount: new test case for new mount API
Date:   Fri, 29 Nov 2019 01:35:32 +0800
Message-Id: <20191128173532.6468-1-zlang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uARu1Yx8PgOhewfXXR5TXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux supports new mount syscalls from 5.2, so add new test cases
to cover these new API. This newmount01 case make sure new API -
fsopen(), fsconfig(), fsmount() and move_mount() can mount a
filesystem, then can be unmounted.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This's the 1st case for LTP to test current new mount API. So I have to add
lots of new things to include/lapi/* and m4/ltp-*(as below), I'm not famili=
ar
with LTP code, so please help to review. There might be lot of things need =
to
be improved.

I'll try to add more test if this 1st case can be merged. I've tested this
patch on latest upstream xfs-linux for-next branch, due to xfs supports
the new mount API now.

# ./runltp -B xfs -f newmount
...
...
Running tests.......
<<<test_start>>>
tag=3Dnewmount01 stime=3D1574961655
cmdline=3D"newmount01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
incrementing stop
tst_device.c:238: INFO: Using test device LTP_DEV=3D'/dev/loop1'
tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
tst_mkfs.c:90: INFO: Formatting /dev/loop1 with xfs opts=3D'' extra opts=3D=
''
newmount01.c:87: PASS: fsopen xfs
newmount01.c:96: PASS: fsconfig set source to /dev/loop1
newmount01.c:105: PASS: fsconfig create superblock
newmount01.c:113: PASS: fsmount
newmount01.c:121: PASS: move_mount attach to mount point
newmount01.c:124: PASS: new mount works

Summary:
passed   6
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D8
<<<test_end>>>

Thanks,
Zorro

 configure.ac                                  |   4 +
 include/lapi/newmount.h                       | 106 +++++++++++++
 include/lapi/syscalls/aarch64.in              |   4 +
 include/lapi/syscalls/powerpc64.in            |   4 +
 include/lapi/syscalls/s390x.in                |   4 +
 include/lapi/syscalls/x86_64.in               |   4 +
 m4/ltp-fsconfig.m4                            |   7 +
 m4/ltp-fsmount.m4                             |   7 +
 m4/ltp-fsopen.m4                              |   7 +
 m4/ltp-move_mount.m4                          |   7 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/newmount/.gitignore |   1 +
 testcases/kernel/syscalls/newmount/Makefile   |  29 ++++
 .../kernel/syscalls/newmount/newmount01.c     | 150 ++++++++++++++++++
 14 files changed, 336 insertions(+)
 create mode 100644 include/lapi/newmount.h
 create mode 100644 m4/ltp-fsconfig.m4
 create mode 100644 m4/ltp-fsmount.m4
 create mode 100644 m4/ltp-fsopen.m4
 create mode 100644 m4/ltp-move_mount.m4
 create mode 100644 testcases/kernel/syscalls/newmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/newmount/Makefile
 create mode 100644 testcases/kernel/syscalls/newmount/newmount01.c

diff --git a/configure.ac b/configure.ac
index 50d14967d..f17ab2e96 100644
--- a/configure.ac
+++ b/configure.ac
@@ -217,6 +217,9 @@ LTP_CHECK_CRYPTO
 LTP_CHECK_FANOTIFY
 LTP_CHECK_FIDEDUPE
 LTP_CHECK_FORTIFY_SOURCE
+LTP_CHECK_FSOPEN
+LTP_CHECK_FSCONFIG
+LTP_CHECK_FSMOUNT
 LTP_CHECK_FTS_H
 LTP_CHECK_IF_LINK
 LTP_CHECK_IOVEC
@@ -228,6 +231,7 @@ LTP_CHECK_LINUXRANDOM
 LTP_CHECK_MADVISE
 LTP_CHECK_MKDTEMP
 LTP_CHECK_MMSGHDR
+LTP_CHECK_MOVE_MOUNT
 LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_PERF_EVENT
diff --git a/include/lapi/newmount.h b/include/lapi/newmount.h
new file mode 100644
index 000000000..07d57ff96
--- /dev/null
+++ b/include/lapi/newmount.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __NEWMOUNT_H__
+#define __NEWMOUNT_H__
+
+#include <stdint.h>
+#include <unistd.h>
+#include "lapi/syscalls.h"
+
+#if !defined(HAVE_FSOPEN)
+static inline int fsopen(const char *fs_name, unsigned int flags)
+{
+=09return tst_syscall(__NR_fsopen, fs_name, flags);
+}
+
+/*
+ * fsopen() flags.
+ */
+#define FSOPEN_CLOEXEC=09=090x00000001
+#endif
+
+#if !defined(HAVE_FSCONFIG)
+static inline int fsconfig(int fsfd, unsigned int cmd,
+                           const char *key, const void *val, int aux)
+{
+=09return tst_syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
+}
+
+/*
+ * The type of fsconfig() call made.
+ */
+enum fsconfig_command {
+=09FSCONFIG_SET_FLAG=09=3D 0,    /* Set parameter, supplying no value */
+=09FSCONFIG_SET_STRING=09=3D 1,    /* Set parameter, supplying a string va=
lue */
+=09FSCONFIG_SET_BINARY=09=3D 2,    /* Set parameter, supplying a binary bl=
ob value */
+=09FSCONFIG_SET_PATH=09=3D 3,    /* Set parameter, supplying an object by =
path */
+=09FSCONFIG_SET_PATH_EMPTY=09=3D 4,    /* Set parameter, supplying an obje=
ct by (empty) path */
+=09FSCONFIG_SET_FD=09=09=3D 5,    /* Set parameter, supplying an object by=
 fd */
+=09FSCONFIG_CMD_CREATE=09=3D 6,    /* Invoke superblock creation */
+=09FSCONFIG_CMD_RECONFIGURE =3D 7,   /* Invoke superblock reconfiguration =
*/
+};
+#endif
+
+#if !defined(HAVE_FSMOUNT)
+static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_fl=
ags)
+{
+=09return tst_syscall(__NR_fsmount, fsfd, flags, ms_flags);
+}
+
+/*
+ * fsmount() flags.
+ */
+#define FSMOUNT_CLOEXEC=09=090x00000001
+
+/*
+ * Mount attributes.
+ */
+#define MOUNT_ATTR_RDONLY=090x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID=090x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV=090x00000004 /* Disallow access to device special=
 files */
+#define MOUNT_ATTR_NOEXEC=090x00000008 /* Disallow program execution */
+#define MOUNT_ATTR__ATIME=090x00000070 /* Setting on how atime should be u=
pdated */
+#define MOUNT_ATTR_RELATIME=090x00000000 /* - Update atime relative to mti=
me/ctime. */
+#define MOUNT_ATTR_NOATIME=090x00000010 /* - Do not update access times. *=
/
+#define MOUNT_ATTR_STRICTATIME=090x00000020 /* - Always perform atime upda=
tes */
+#define MOUNT_ATTR_NODIRATIME=090x00000080 /* Do not update directory acce=
ss times */
+#endif
+
+#if !defined(HAVE_MOVE_MOUNT)
+static inline int move_mount(int from_dfd, const char *from_pathname,
+                             int to_dfd, const char *to_pathname,
+                             unsigned int flags)
+{
+=09return tst_syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
+=09                   to_pathname, flags);
+}
+
+/*
+ * move_mount() flags.
+ */
+#define MOVE_MOUNT_F_SYMLINKS=09=090x00000001 /* Follow symlinks on from p=
ath */
+#define MOVE_MOUNT_F_AUTOMOUNTS=09=090x00000002 /* Follow automounts on fr=
om path */
+#define MOVE_MOUNT_F_EMPTY_PATH=09=090x00000004 /* Empty from path permitt=
ed */
+#define MOVE_MOUNT_T_SYMLINKS=09=090x00000010 /* Follow symlinks on to pat=
h */
+#define MOVE_MOUNT_T_AUTOMOUNTS=09=090x00000020 /* Follow automounts on to=
 path */
+#define MOVE_MOUNT_T_EMPTY_PATH=09=090x00000040 /* Empty to path permitted=
 */
+#define MOVE_MOUNT__MASK=09=090x00000077
+#endif
+
+#endif /* __NEWMOUNT_H__ */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch=
64.in
index 0e00641bc..5b9e1d9a4 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -270,4 +270,8 @@ pkey_mprotect 288
 pkey_alloc 289
 pkey_free 290
 pidfd_send_signal 424
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
 _sysctl 1078
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/pow=
erpc64.in
index 660165d7a..3aaed64e0 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -359,3 +359,7 @@ pidfd_send_signal 424
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.i=
n
index 7d632d1dc..bd427555a 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -341,3 +341,7 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64=
.in
index b1cbd4f2f..94f0b562e 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -320,3 +320,7 @@ pkey_alloc 330
 pkey_free 331
 statx 332
 pidfd_send_signal 424
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
diff --git a/m4/ltp-fsconfig.m4 b/m4/ltp-fsconfig.m4
new file mode 100644
index 000000000..397027f1b
--- /dev/null
+++ b/m4/ltp-fsconfig.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+
+AC_DEFUN([LTP_CHECK_FSCONFIG],[
+AC_CHECK_FUNCS(fsconfig,,)
+AC_CHECK_HEADER(sys/mount.h,,,)
+])
diff --git a/m4/ltp-fsmount.m4 b/m4/ltp-fsmount.m4
new file mode 100644
index 000000000..ee32ef713
--- /dev/null
+++ b/m4/ltp-fsmount.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+
+AC_DEFUN([LTP_CHECK_FSMOUNT],[
+AC_CHECK_FUNCS(fsmount,,)
+AC_CHECK_HEADER(sys/mount.h,,,)
+])
diff --git a/m4/ltp-fsopen.m4 b/m4/ltp-fsopen.m4
new file mode 100644
index 000000000..6e23d437d
--- /dev/null
+++ b/m4/ltp-fsopen.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+
+AC_DEFUN([LTP_CHECK_FSOPEN],[
+AC_CHECK_FUNCS(fsopen,,)
+AC_CHECK_HEADER(sys/mount.h,,,)
+])
diff --git a/m4/ltp-move_mount.m4 b/m4/ltp-move_mount.m4
new file mode 100644
index 000000000..d6bfd82e9
--- /dev/null
+++ b/m4/ltp-move_mount.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+
+AC_DEFUN([LTP_CHECK_MOVE_MOUNT],[
+AC_CHECK_FUNCS(move_mount,,)
+AC_CHECK_HEADER(sys/mount.h,,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 15dbd9971..d11a87dd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -716,6 +716,8 @@ mount04 mount04
 mount05 mount05
 mount06 mount06
=20
+newmount01 newmount01
+
 move_pages01 move_pages01
 move_pages02 move_pages02
 move_pages03 move_pages03
diff --git a/testcases/kernel/syscalls/newmount/.gitignore b/testcases/kern=
el/syscalls/newmount/.gitignore
new file mode 100644
index 000000000..dc78edd5b
--- /dev/null
+++ b/testcases/kernel/syscalls/newmount/.gitignore
@@ -0,0 +1 @@
+/newmount01
diff --git a/testcases/kernel/syscalls/newmount/Makefile b/testcases/kernel=
/syscalls/newmount/Makefile
new file mode 100644
index 000000000..8b0a60332
--- /dev/null
+++ b/testcases/kernel/syscalls/newmount/Makefile
@@ -0,0 +1,29 @@
+#
+#  Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
+#
+# HISTORY:
+#  27/11/2019 zlang@redhat.com  Create newmount01.c
+#
+##########################################################################=
###
+
+top_srcdir=09=09?=3D ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS=09=09=09+=3D -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/newmount/newmount01.c b/testcases/ke=
rnel/syscalls/newmount/newmount01.c
new file mode 100644
index 000000000..35e355506
--- /dev/null
+++ b/testcases/kernel/syscalls/newmount/newmount01.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+ * Author: Zorro Lang <zlang@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+/*
+ *  DESCRIPTION
+ *=09Use new mount API (fsopen, fsconfig, fsmount, move_mount) to mount
+ *=09a filesystem.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <sys/mount.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/newmount.h"
+
+#define LINELENGTH 256
+#define MNTPOINT "newmount_point"
+static int sfd, mfd;
+static int mount_flag =3D 0;
+
+static int ismount(char *mntpoint)
+{
+=09int ret =3D 0;
+=09FILE *file;
+=09char line[LINELENGTH];
+
+=09file =3D fopen("/proc/mounts", "r");
+=09if (file =3D=3D NULL)
+=09=09tst_brk(TFAIL | TTERRNO, "Open /proc/mounts failed");
+
+=09while (fgets(line, LINELENGTH, file) !=3D NULL) {
+=09=09if (strstr(line, mntpoint) !=3D NULL) {
+=09=09=09ret =3D 1;
+=09=09=09break;
+=09=09}
+=09}
+=09fclose(file);
+=09return ret;
+}
+
+static void setup(void)
+{
+=09SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+}
+
+static void cleanup(void)
+{
+=09if (mount_flag =3D=3D 1) {
+=09=09TEST(tst_umount(MNTPOINT));
+=09=09if (TST_RET !=3D 0)
+=09=09=09tst_brk(TBROK | TTERRNO, "umount failed");
+=09}
+}
+
+
+static void test_newmount(void)
+{
+=09TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO,
+=09=09        "fsopen %s", tst_device->fs_type);
+=09} else {
+=09=09sfd =3D TST_RET;
+=09=09tst_res(TPASS,
+=09=09=09"fsopen %s", tst_device->fs_type);
+=09}
+
+=09TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO,
+=09=09        "fsconfig set source to %s", tst_device->dev);
+=09} else {
+=09=09tst_res(TPASS,
+=09=09=09"fsconfig set source to %s", tst_device->dev);
+=09}
+
+=09TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO,
+=09=09        "fsconfig create superblock");
+=09} else {
+=09=09tst_res(TPASS,
+=09=09=09"fsconfig create superblock");
+=09}
+
+=09TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO, "fsmount");
+=09} else {
+=09=09mfd =3D TST_RET;
+=09=09tst_res(TPASS, "fsmount");
+=09=09SAFE_CLOSE(sfd);
+=09}
+
+=09TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO, "move_mount attach to mount point");
+=09} else {
+=09=09tst_res(TPASS, "move_mount attach to mount point");
+=09=09mount_flag =3D 1;
+=09=09if (ismount(MNTPOINT))
+=09=09=09tst_res(TPASS, "new mount works");
+=09=09else
+=09=09=09tst_res(TFAIL, "new mount fails");
+=09}
+=09SAFE_CLOSE(mfd);
+}
+
+struct test_cases {
+=09void (*tfunc)(void);
+} tcases[] =3D {
+=09{&test_newmount},
+};
+
+static void run(unsigned int i)
+{
+=09tcases[i].tfunc();
+}
+
+static struct tst_test test =3D {
+=09.test=09=09=3D run,
+=09.tcnt=09=09=3D ARRAY_SIZE(tcases),
+=09.setup=09=09=3D setup,
+=09.cleanup=09=3D cleanup,
+=09.needs_root=09=3D 1,
+=09.mntpoint=09=3D MNTPOINT,
+=09.needs_device=09=3D 1,
+};
--=20
2.20.1

