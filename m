Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B09117107
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLIQCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 11:02:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfLIQCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575907358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qqguRS2sZ6tk2OnjGSKB//hXkycAUa7HqfffaRcdFxw=;
        b=BTFn/h06B04T67HvZjrhQ7RGUL3vZ+C1lq7JE6GWtlEw4VPLbuN6KcgFHmiS2oUl91on8t
        WfEHHq+vA5l1DD1UzsOmxU9ZkaGVevo84FndVmKwiGpGgbzpPLwQj1Renp2FzyYt6FjmFV
        Eob8Z9tZlj+cUx1lH9fRDIv6JvzlgCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-IhDie2L4MBqcAt-hnms6KQ-1; Mon, 09 Dec 2019 11:02:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24B49800C7C;
        Mon,  9 Dec 2019 16:02:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-160.pek2.redhat.com [10.72.12.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 118F06BF9B;
        Mon,  9 Dec 2019 16:02:32 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     ltp@lists.linux.it
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] syscalls/newmount: new test case for new mount API
Date:   Tue, 10 Dec 2019 00:02:27 +0800
Message-Id: <20191209160227.16125-1-zlang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IhDie2L4MBqcAt-hnms6KQ-1
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

V3 test passed on ext2/3/4 and xfs[1], on upstream mainline kernel. Thanks
all your review points:)
But I have a question, how to test other filesystems, likes nfs, cifs?

Thanks,
Zorro

 configure.ac                                  |   1 +
 include/lapi/newmount.h                       |  95 +++++++++++++++
 include/lapi/syscalls/aarch64.in              |   4 +
 include/lapi/syscalls/powerpc64.in            |   4 +
 include/lapi/syscalls/s390x.in                |   4 +
 include/lapi/syscalls/x86_64.in               |   4 +
 m4/ltp-newmount.m4                            |  10 ++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/newmount/.gitignore |   1 +
 testcases/kernel/syscalls/newmount/Makefile   |   9 ++
 .../kernel/syscalls/newmount/newmount01.c     | 114 ++++++++++++++++++
 11 files changed, 248 insertions(+)
 create mode 100644 include/lapi/newmount.h
 create mode 100644 m4/ltp-newmount.m4
 create mode 100644 testcases/kernel/syscalls/newmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/newmount/Makefile
 create mode 100644 testcases/kernel/syscalls/newmount/newmount01.c

diff --git a/configure.ac b/configure.ac
index 50d14967d..28f840c51 100644
--- a/configure.ac
+++ b/configure.ac
@@ -229,6 +229,7 @@ LTP_CHECK_MADVISE
 LTP_CHECK_MKDTEMP
 LTP_CHECK_MMSGHDR
 LTP_CHECK_MREMAP_FIXED
+LTP_CHECK_NEWMOUNT
 LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_PERF_EVENT
 LTP_CHECK_PRCTL_SUPPORT
diff --git a/include/lapi/newmount.h b/include/lapi/newmount.h
new file mode 100644
index 000000000..13f9fbb9c
--- /dev/null
+++ b/include/lapi/newmount.h
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+ * Author: Zorro Lang <zlang@redhat.com>
+ */
+
+#ifndef NEWMOUNT_H__
+#define NEWMOUNT_H__
+
+#include <stdint.h>
+#include <unistd.h>
+#include "config.h"
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
+#endif=09/* HAVE_FSOPEN */
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
+#endif=09/* HAVE_FSCONFIG */
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
+#endif=09/* HAVE_FSMOUNT */
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
+#endif=09/* HAVE_MOVE_MOUNT */
+
+#endif /* NEWMOUNT_H__ */
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
diff --git a/m4/ltp-newmount.m4 b/m4/ltp-newmount.m4
new file mode 100644
index 000000000..e13a6f0b1
--- /dev/null
+++ b/m4/ltp-newmount.m4
@@ -0,0 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+
+AC_DEFUN([LTP_CHECK_NEWMOUNT],[
+AC_CHECK_FUNCS(fsopen,,)
+AC_CHECK_FUNCS(fsconfig,,)
+AC_CHECK_FUNCS(fsmount,,)
+AC_CHECK_FUNCS(move_mount,,)
+AC_CHECK_HEADER(sys/mount.h,,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 15dbd9971..fac1c62d2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -794,6 +794,8 @@ nanosleep01 nanosleep01
 nanosleep02 nanosleep02
 nanosleep04 nanosleep04
=20
+newmount01 newmount01
+
 nftw01 nftw01
 nftw6401 nftw6401
=20
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
index 000000000..7d0920df6
--- /dev/null
+++ b/testcases/kernel/syscalls/newmount/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+
+top_srcdir=09=09?=3D ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/newmount/newmount01.c b/testcases/ke=
rnel/syscalls/newmount/newmount01.c
new file mode 100644
index 000000000..464ecb699
--- /dev/null
+++ b/testcases/kernel/syscalls/newmount/newmount01.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+ * Author: Zorro Lang <zlang@redhat.com>
+ *
+ * Use new mount API (fsopen, fsconfig, fsmount, move_mount) to mount
+ * a filesystem without any specified mount options.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mount.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/newmount.h"
+
+#define LINELENGTH 256
+#define MNTPOINT "newmount_point"
+static int sfd, mfd;
+static int is_mounted =3D 0;
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
+static void cleanup(void)
+{
+=09if (is_mounted) {
+=09=09TEST(tst_umount(MNTPOINT));
+=09=09if (TST_RET !=3D 0)
+=09=09=09tst_brk(TFAIL | TTERRNO, "umount failed in cleanup");
+=09}
+}
+
+static void test_newmount(void)
+{
+=09TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO,
+=09=09        "fsopen %s", tst_device->fs_type);
+=09}
+=09sfd =3D TST_RET;
+=09tst_res(TPASS, "fsopen %s", tst_device->fs_type);
+
+=09TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO,
+=09=09        "fsconfig set source to %s", tst_device->dev);
+=09}
+=09tst_res(TPASS, "fsconfig set source to %s", tst_device->dev);
+
+
+=09TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO,
+=09=09        "fsconfig create superblock");
+=09}
+=09tst_res(TPASS, "fsconfig create superblock");
+
+=09TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO, "fsmount");
+=09}
+=09mfd =3D TST_RET;
+=09tst_res(TPASS, "fsmount");
+=09SAFE_CLOSE(sfd);
+
+=09TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+=09if (TST_RET < 0) {
+=09=09tst_brk(TFAIL | TTERRNO, "move_mount attach to mount point");
+=09}
+=09is_mounted =3D 1;
+=09tst_res(TPASS, "move_mount attach to mount point");
+=09SAFE_CLOSE(mfd);
+
+=09if (ismount(MNTPOINT)) {
+=09=09tst_res(TPASS, "new mount works");
+=09=09TEST(tst_umount(MNTPOINT));
+=09=09if (TST_RET !=3D 0)
+=09=09=09tst_brk(TFAIL | TTERRNO, "umount failed");
+=09=09is_mounted =3D 0;
+=09} else {
+=09=09tst_res(TFAIL, "new mount fails");
+=09}
+}
+
+static struct tst_test test =3D {
+=09.test_all=09=3D test_newmount,
+=09.cleanup=09=3D cleanup,
+=09.needs_root=09=3D 1,
+=09.mntpoint=09=3D MNTPOINT,
+=09.needs_device=09=3D 1,
+=09.format_device=09=3D 1,
+=09.all_filesystems =3D 1,
+};
--=20
2.20.1

