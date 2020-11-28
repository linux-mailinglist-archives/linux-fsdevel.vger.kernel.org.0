Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1046A2C73E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbgK1WO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 17:14:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55600 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgK1WOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:14:51 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kj83l-0002aM-KR; Sat, 28 Nov 2020 21:47:14 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org, fstests@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 38/38] generic/618: add fstests for idmapped mounts
Date:   Sat, 28 Nov 2020 22:35:27 +0100
Message-Id: <20201128213527.2669807-39-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a test suite to verify the behavior of idmapped mounts. The test
suite also includes a range of vfs tests to verify that no regressions
are introduced by idmapped mounts. The following tests are currently
available with more to come in the future:

01. posix acls on regular and idmapped mounts
02. create operations in user namespace
03. device node creation in user namespace
04. expected ownership on idmapped mounts
05. fscaps on regular mounts
06. fscaps on idmapped mounts
07. fscaps on idmapped mounts in user namespace
08. fscaps on idmapped mounts in user namespace with different id mappings
09. mapped fsids
10. unmapped fsids
11. cross mount hardlink
12. cross idmapped mount hardlink
13. hardlinks from idmapped mounts
14. hardlinks from idmapped mounts in user namespace
15. io_uring
16. io_uring in user namespace
17. io_uring from idmapped mounts
18. io_uring from idmapped mounts in user namespace
19. io_uring from idmapped mounts with unmapped ids
20. io_uring from idmapped mounts with unmapped ids in user namespace
21. following protected symlinks on regular mounts
22. following protected symlinks on idmapped mounts
23. following protected symlinks on idmapped mounts in user namespace
24. cross mount rename
25. cross idmapped mount rename
26. rename from idmapped mounts
27. rename from idmapped mounts in user namespace
28. symlink from regular mounts
29. symlink from idmapped mounts
30. symlink from idmapped mounts in user namespace
31. setid binaries on regular mounts
32. setid binaries on idmapped mounts
33. setid binaries on idmapped mounts in user namespace
34. setid binaries on idmapped mounts in user namespace with different id mappings
35. sticky bit unlink operations on regular mounts
36. sticky bit unlink operations on idmapped mounts
37. sticky bit unlink operations on idmapped mounts in user namespace
38. sticky bit rename operations on regular mounts
39. sticky bit rename operations on idmapped mounts
40. sticky bit rename operations on idmapped mounts in user namespace

Output:
 ubuntu@focal:~/src/git/linux/xfstests$ sudo ./check generic/618
 FSTYP         -- ext4
 PLATFORM      -- Linux/x86_64 focal 5.10.0-rc4-idmapped-mounts #212 SMP Sat Nov 28 16:52:10 UTC 2020
 MKFS_OPTIONS  -- /dev/sdb
 MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /mnt/scratch

 generic/618 20s ...  21s
 Ran: generic/618
 Passed all 1 tests

Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 common/rc                             |   25 +
 configure.ac                          |    2 +
 include/builddefs.in                  |    1 +
 m4/Makefile                           |    1 +
 m4/package_libcap.m4                  |    4 +
 src/Makefile                          |    5 +
 src/feature.c                         |   29 +-
 src/idmapped-mounts/Makefile          |   34 +
 src/idmapped-mounts/idmapped-mounts.c | 7423 +++++++++++++++++++++++++
 src/idmapped-mounts/missing.h         |  155 +
 src/idmapped-mounts/utils.c           |  134 +
 src/idmapped-mounts/utils.h           |   29 +
 tests/generic/618                     |   43 +
 tests/generic/618.out                 |    2 +
 tests/generic/group                   |    1 +
 15 files changed, 7884 insertions(+), 4 deletions(-)
 create mode 100644 m4/package_libcap.m4
 create mode 100644 src/idmapped-mounts/Makefile
 create mode 100644 src/idmapped-mounts/idmapped-mounts.c
 create mode 100644 src/idmapped-mounts/missing.h
 create mode 100644 src/idmapped-mounts/utils.c
 create mode 100644 src/idmapped-mounts/utils.h
 create mode 100755 tests/generic/618
 create mode 100644 tests/generic/618.out

diff --git a/common/rc b/common/rc
index e6a5b07b..fb53f52a 100644
--- a/common/rc
+++ b/common/rc
@@ -1972,6 +1972,31 @@ _require_io_uring()
 	esac
 }
 
+# test whether the mount_setattr syscall is available
+_require_mount_setattr()
+{
+	$here/src/feature -r
+	case $? in
+	0)
+		;;
+	1)
+		_notrun "kernel does not support mount_setattr syscall"
+		;;
+	*)
+		_fail "unexpected error testing for mount_setattr support"
+		;;
+	esac
+}
+
+# test whether idmapped mounts are supported
+_require_idmapped_mounts()
+{
+        IDMAPPED_MOUNTS_TEST=$here/src/idmapped-mounts/idmapped-mounts
+        [ -x $IDMAPPED_MOUNTS_TEST ] || _notrun "idmapped-mounts utilities required"
+
+	_require_mount_setattr
+}
+
 # this test requires that a test program exists under src/
 # $1 - command (require)
 #
diff --git a/configure.ac b/configure.ac
index 8922c47e..24bb8ae6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,6 +63,7 @@ AC_PACKAGE_WANT_GDBM
 AC_PACKAGE_WANT_AIO
 AC_PACKAGE_WANT_URING
 AC_PACKAGE_WANT_DMAPI
+AC_PACKAGE_WANT_LIBCAP
 AC_PACKAGE_WANT_LINUX_FIEMAP_H
 AC_PACKAGE_WANT_FALLOCATE
 AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT
@@ -73,6 +74,7 @@ AC_PACKAGE_WANT_LIBBTRFSUTIL
 AC_HAVE_COPY_FILE_RANGE
 
 AC_CHECK_FUNCS([renameat2])
+AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
 
 AC_CONFIG_HEADER(include/config.h)
 AC_CONFIG_FILES([include/builddefs])
diff --git a/include/builddefs.in b/include/builddefs.in
index fded3230..814e852f 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -62,6 +62,7 @@ ENABLE_SHARED = @enable_shared@
 HAVE_DB = @have_db@
 HAVE_AIO = @have_aio@
 HAVE_URING = @have_uring@
+HAVE_LIBCAP = @have_libcap@
 HAVE_FALLOCATE = @have_fallocate@
 HAVE_OPEN_BY_HANDLE_AT = @have_open_by_handle_at@
 HAVE_DMAPI = @have_dmapi@
diff --git a/m4/Makefile b/m4/Makefile
index 0352534d..ac9d7945 100644
--- a/m4/Makefile
+++ b/m4/Makefile
@@ -13,6 +13,7 @@ LSRCFILES = \
 	package_attrdev.m4 \
 	package_dmapidev.m4 \
 	package_globals.m4 \
+	package_libcap.m4 \
 	package_libcdev.m4 \
 	package_liburing.m4 \
 	package_ncurses.m4 \
diff --git a/m4/package_libcap.m4 b/m4/package_libcap.m4
new file mode 100644
index 00000000..f1ea139c
--- /dev/null
+++ b/m4/package_libcap.m4
@@ -0,0 +1,4 @@
+AC_DEFUN([AC_PACKAGE_WANT_LIBCAP],
+  [ AC_CHECK_HEADERS(sys/capability.h, [ have_libcap=true ], [ have_libcap=false ])
+    AC_SUBST(have_libcap)
+  ])
diff --git a/src/Makefile b/src/Makefile
index 919d77c4..a5446a18 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -70,6 +70,11 @@ ifeq ($(HAVE_URING), true)
 LLDLIBS += -luring
 endif
 
+SUBDIRS += idmapped-mounts
+ifeq ($(HAVE_LIBCAP), true)
+LLDLIBS += -lcap
+endif
+
 CFILES = $(TARGETS:=.c)
 LDIRT = $(TARGETS) fssum
 
diff --git a/src/feature.c b/src/feature.c
index df550cf6..433ac376 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -19,6 +19,7 @@
  *
  * Test for machine features
  *   -A  test whether AIO syscalls are available
+ *   -r  test whether mount_setattr syscall is supported
  *   -R  test whether IO_URING syscalls are available
  *   -o  report a number of online cpus
  *   -s  report pagesize
@@ -30,6 +31,7 @@
 #include <sys/quota.h>
 #include <sys/resource.h>
 #include <signal.h>
+#include <syscall.h>
 #include <unistd.h>
 
 #ifdef HAVE_XFS_XQM_H
@@ -44,6 +46,8 @@
 #include <liburing.h>
 #endif
 
+#include "idmapped-mounts/missing.h"
+
 #ifndef USRQUOTA
 #define USRQUOTA  0
 #endif
@@ -64,7 +68,7 @@ usage(void)
 	fprintf(stderr, "Usage: feature [-v] -<q|u|g|p|U|G|P> <filesystem>\n");
 	fprintf(stderr, "       feature [-v] -c <file>\n");
 	fprintf(stderr, "       feature [-v] -t <file>\n");
-	fprintf(stderr, "       feature -A | -R | -o | -s | -w\n");
+	fprintf(stderr, "       feature -A | -r | -R | -o | -s | -w\n");
 	exit(1);
 }
 
@@ -243,6 +247,16 @@ check_uring_support(void)
 #endif
 }
 
+static int
+check_mount_setattr_support(void)
+{
+	int err;
+	err = sys_mount_setattr(-EBADF, "", AT_EMPTY_PATH, NULL, 0);
+	if (err && errno == ENOSYS)
+		return 1;
+
+	return 0;
+}
 
 int
 main(int argc, char **argv)
@@ -256,6 +270,7 @@ main(int argc, char **argv)
 	int	pflag = 0;
 	int	Pflag = 0;
 	int	qflag = 0;
+	int	rflag = 0;
 	int	Rflag = 0;
 	int	sflag = 0;
 	int	uflag = 0;
@@ -264,7 +279,7 @@ main(int argc, char **argv)
 	int	oflag = 0;
 	char	*fs = NULL;
 
-	while ((c = getopt(argc, argv, "ActgGopPqRsuUvw")) != EOF) {
+	while ((c = getopt(argc, argv, "ActgGopPqrRsuUvw")) != EOF) {
 		switch (c) {
 		case 'A':
 			Aflag++;
@@ -293,6 +308,9 @@ main(int argc, char **argv)
 		case 'q':
 			qflag++;
 			break;
+		case 'r':
+			rflag++;
+			break;
 		case 'R':
 			Rflag++;
 			break;
@@ -321,10 +339,10 @@ main(int argc, char **argv)
 		if (optind != argc-1)	/* need a device */
 			usage();
 		fs = argv[argc-1];
-	} else if (Aflag || Rflag || wflag || sflag || oflag) {
+	} else if (Aflag || rflag || Rflag || wflag || sflag || oflag) {
 		if (optind != argc)
 			usage();
-	} else 
+	} else
 		usage();
 
 	if (cflag)
@@ -349,6 +367,9 @@ main(int argc, char **argv)
 	if (Aflag)
 		return(check_aio_support());
 
+	if (rflag)
+		return(check_mount_setattr_support());
+
 	if (Rflag)
 		return(check_uring_support());
 
diff --git a/src/idmapped-mounts/Makefile b/src/idmapped-mounts/Makefile
new file mode 100644
index 00000000..e7e5324e
--- /dev/null
+++ b/src/idmapped-mounts/Makefile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+TARGETS = idmapped-mounts
+
+CFILES = idmapped-mounts.c utils.c
+HFILES = missing.h utils.h
+LDIRT = $(TARGETS)
+
+ifeq ($(HAVE_LIBCAP), true)
+LLDLIBS += -lcap
+endif
+
+ifeq ($(HAVE_URING), true)
+LLDLIBS += -luring
+endif
+
+default: depend $(TARGETS)
+
+depend: .dep
+
+include $(BUILDRULES)
+
+$(TARGETS): $(CFILES)
+	@echo "    [CC]    $@"
+	$(Q)$(LTLINK) $(CFILES) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+
+install:
+	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/idmapped-mounts
+	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/idmapped-mounts
+
+-include .dep
diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
new file mode 100644
index 00000000..d031edd7
--- /dev/null
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -0,0 +1,7423 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include "../global.h"
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <grp.h>
+#include <limits.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <sys/acl.h>
+#include <sys/fsuid.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/sysmacros.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#ifdef HAVE_SYS_CAPABILITY_H
+#include <sys/capability.h>
+#endif
+
+#ifdef HAVE_LIBURING_H
+#include <liburing.h>
+#endif
+
+#include "missing.h"
+#include "utils.h"
+
+#define T_DIR1 "idmapped_mounts_1"
+#define FILE1 "file1"
+#define FILE1_RENAME "file1_rename"
+#define FILE2 "file2"
+#define FILE2_RENAME "file2_rename"
+#define DIR1 "dir1"
+#define DIR2 "dir2"
+#define DIR3 "dir3"
+#define DIR1_RENAME "dir1_rename"
+#define HARDLINK1 "hardlink1"
+#define SYMLINK1 "symlink1"
+#define SYMLINK_USER1 "symlink_user1"
+#define SYMLINK_USER2 "symlink_user2"
+#define SYMLINK_USER3 "symlink_user3"
+#define CHRDEV1 "chrdev1"
+
+#define log_stderr(format, ...)                                                         \
+	fprintf(stderr, "%s: %d: %s - %m - " format "\n", __FILE__, __LINE__, __func__, \
+		##__VA_ARGS__);
+
+#define log_error_errno(__ret__, __errno__, format, ...)      \
+	({                                                    \
+		typeof(__ret__) __internal_ret__ = (__ret__); \
+		errno = (__errno__);                          \
+		log_stderr(format, ##__VA_ARGS__);            \
+		__internal_ret__;                             \
+	})
+
+#define log_errno(__ret__, format, ...) log_error_errno(__ret__, errno, format, ##__VA_ARGS__)
+
+#define die_errno(__errno__, format, ...)          \
+	({                                         \
+		errno = (__errno__);               \
+		log_stderr(format, ##__VA_ARGS__); \
+		exit(EXIT_FAILURE);                \
+	})
+
+#define die(format, ...) die_errno(errno, format, ##__VA_ARGS__)
+
+/* path of the test device */
+const char *t_device;
+
+/* mountpoint of the test device */
+const char *t_mountpoint;
+
+/* fd for @t_mountpoint */
+int t_mnt_fd;
+
+/* fd for @T_DIR1 */
+int t_dir1_fd;
+
+/* temporary buffer */
+char t_buf[PATH_MAX];
+
+static bool protected_symlinks_enabled(void)
+{
+	int fd;
+	ssize_t ret;
+	char buf[256];
+
+	fd = open("/proc/sys/fs/protected_symlinks", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+
+	ret = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (ret < sizeof(int))
+		return false;
+
+	return atoi(buf) >= 1;
+}
+
+static inline bool caps_supported(void)
+{
+	bool ret = false;
+
+#ifdef HAVE_SYS_CAPABILITY_H
+	ret = true;
+#endif
+
+	return ret;
+}
+
+/**
+ * caps_down - lower all effective caps
+ */
+static int caps_down(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_clear_flag(caps, CAP_EFFECTIVE);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
+/**
+ * caps_down - raise all permitted caps
+ */
+static int caps_up(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	cap_value_t cap;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	for (cap = 0; cap <= CAP_LAST_CAP; cap++) {
+		cap_flag_value_t flag;
+
+		ret = cap_get_flag(caps, cap, CAP_PERMITTED, &flag);
+		if (ret) {
+			if (errno == EINVAL)
+				break;
+			else
+				goto out;
+		}
+
+		ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, flag);
+		if (ret)
+			goto out;
+	}
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
+/**
+ * expected_uid_gid - check whether file is owned by the provided uid and gid
+ */
+static bool expected_uid_gid(int dfd, const char *path, int flags,
+			     uid_t expected_uid, gid_t expected_gid)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	if (st.st_uid != expected_uid)
+		log_stderr("failure: uid(%d) != expected_uid(%d)", st.st_uid, expected_uid);
+
+	if (st.st_gid != expected_gid)
+		log_stderr("failure: gid(%d) != expected_gid(%d)", st.st_gid, expected_gid);
+
+	return st.st_uid == expected_uid && st.st_gid == expected_gid;
+}
+
+/**
+ * is_setid - check whether file is S_ISUID and S_ISGID
+ */
+static bool is_setid(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return (st.st_mode & S_ISUID) || (st.st_mode & S_ISGID);
+}
+
+/**
+ * is_sticky - check whether file is S_ISUID and S_ISGID
+ */
+static bool is_sticky(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return (st.st_mode & S_ISVTX) > 0;
+}
+
+static inline int set_cloexec(int fd)
+{
+	return fcntl(fd, F_SETFD, FD_CLOEXEC);
+}
+
+static inline bool switch_fsids(uid_t fsuid, gid_t fsgid)
+{
+	if (setfsgid(fsgid))
+		return log_errno(false, "failure: setfsgid");
+
+	if (setfsgid(-1) != fsgid)
+		return log_errno(false, "failure: setfsgid(-1)");
+
+	if (setfsuid(fsuid))
+		return log_errno(false, "failure: setfsuid");
+
+	if (setfsuid(-1) != fsuid)
+		return log_errno(false, "failure: setfsuid(-1)");
+
+	return true;
+}
+
+static inline bool switch_ids(uid_t uid, gid_t gid)
+{
+	if (setgroups(0, NULL))
+		return log_errno(false, "failure: setgroups");
+
+	if (setresgid(gid, gid, gid))
+		return log_errno(false, "failure: setresgid");
+
+	if (setresuid(uid, uid, uid))
+		return log_errno(false, "failure: setresuid");
+
+	return true;
+}
+
+static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
+{
+	if (setns(fd, CLONE_NEWUSER))
+		return log_errno(false, "failure: setns");
+
+	if (!switch_ids(uid, gid))
+		return log_errno(false, "failure: switch_ids");
+
+	if (drop_caps && !caps_down())
+		return log_errno(false, "failure: caps_down");
+
+	return true;
+}
+
+/**
+ * rm_r - recursively remove all files
+ */
+static int rm_r(int fd, const char *path)
+{
+	int dfd, ret;
+	DIR *dir;
+	struct dirent *direntp;
+
+	if (!path || strcmp(path, "") == 0)
+		return -1;
+
+	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
+	if (dfd < 0)
+		return -1;
+
+	dir = fdopendir(dfd);
+	if (!dir) {
+		close(dfd);
+		return -1;
+	}
+
+	while ((direntp = readdir(dir))) {
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = rm_r(dfd, direntp->d_name);
+		else
+			ret = unlinkat(dfd, direntp->d_name, 0);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	ret = unlinkat(fd, path, AT_REMOVEDIR);
+	closedir(dir);
+	return ret;
+}
+
+/**
+ * chown_r - recursively change ownership of all files
+ */
+static int chown_r(int fd, const char *path, uid_t uid, gid_t gid)
+{
+	int dfd, ret;
+	DIR *dir;
+	struct dirent *direntp;
+
+	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
+	if (dfd < 0)
+		return -1;
+
+	dir = fdopendir(dfd);
+	if (!dir) {
+		close(dfd);
+		return -1;
+	}
+
+	while ((direntp = readdir(dir))) {
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = chown_r(dfd, direntp->d_name, uid, gid);
+		else
+			ret = fchownat(dfd, direntp->d_name, uid, gid, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	ret = fchownat(fd, path, uid, gid, AT_SYMLINK_NOFOLLOW);
+	closedir(dir);
+	return ret;
+}
+
+#ifdef DEBUG_HELPER /* debugging helper */
+static int print_r(int fd, const char *path)
+{
+	int ret = 0;
+	int dfd;
+	DIR *dir;
+	struct dirent *direntp;
+	struct stat st;
+
+	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
+	if (dfd < 0)
+		return -1;
+
+	dir = fdopendir(dfd);
+	if (!dir) {
+		close(dfd);
+		return -1;
+	}
+
+	while ((direntp = readdir(dir))) {
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = print_r(dfd, direntp->d_name);
+		else
+			ret = fprintf(stderr, "uid(%d):gid(%d) -> %s/%s\n",
+				      st.st_uid, st.st_gid, path, direntp->d_name);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+	closedir(dir);
+
+	ret = fstatat(fd, path, &st, AT_SYMLINK_NOFOLLOW);
+	if (ret)
+		return -1;
+	else
+		ret = log_stderr("uid(%d):gid(%d) -> %s", st.st_uid, st.st_gid, path);
+	return ret;
+}
+#endif /* debugging helper */
+
+/**
+ * fd_to_fd - transfer data from one fd to another
+ */
+static int fd_to_fd(int from, int to)
+{
+	for (;;) {
+		uint8_t buf[PATH_MAX];
+		uint8_t *p = buf;
+		ssize_t bytes_to_write;
+		ssize_t bytes_read;
+
+		bytes_read = read_nointr(from, buf, sizeof buf);
+		if (bytes_read < 0)
+			return -1;
+		if (bytes_read == 0)
+			break;
+
+		bytes_to_write = (size_t)bytes_read;
+		do {
+			ssize_t bytes_written;
+
+			bytes_written = write_nointr(to, p, bytes_to_write);
+			if (bytes_written < 0)
+				return -1;
+
+			bytes_to_write -= bytes_written;
+			p += bytes_written;
+		} while (bytes_to_write > 0);
+	}
+
+	return 0;
+}
+
+static int sys_execveat(int fd, const char *path, char **argv, char **envp,
+			int flags)
+{
+#ifdef __NR_execveat
+	return syscall(__NR_execveat, fd, path, argv, envp, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+#ifndef CAP_NET_RAW
+#define CAP_NET_RAW 13
+#endif
+
+#ifndef VFS_CAP_FLAGS_EFFECTIVE
+#define VFS_CAP_FLAGS_EFFECTIVE 0x000001
+#endif
+
+#ifndef VFS_CAP_U32_3
+#define VFS_CAP_U32_3 2
+#endif
+
+#ifndef VFS_CAP_U32
+#define VFS_CAP_U32 VFS_CAP_U32_3
+#endif
+
+#ifndef VFS_CAP_REVISION_1
+#define VFS_CAP_REVISION_1 0x01000000
+#endif
+
+#ifndef VFS_CAP_REVISION_2
+#define VFS_CAP_REVISION_2 0x02000000
+#endif
+
+#ifndef VFS_CAP_REVISION_3
+#define VFS_CAP_REVISION_3 0x03000000
+struct vfs_ns_cap_data {
+	__le32 magic_etc;
+	struct {
+		__le32 permitted;
+		__le32 inheritable;
+	} data[VFS_CAP_U32];
+	__le32 rootid;
+};
+#endif
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define cpu_to_le16(w16) le16_to_cpu(w16)
+#define le16_to_cpu(w16) ((u_int16_t)((u_int16_t)(w16) >> 8) | (u_int16_t)((u_int16_t)(w16) << 8))
+#define cpu_to_le32(w32) le32_to_cpu(w32)
+#define le32_to_cpu(w32)                                                                       \
+	((u_int32_t)((u_int32_t)(w32) >> 24) | (u_int32_t)(((u_int32_t)(w32) >> 8) & 0xFF00) | \
+	 (u_int32_t)(((u_int32_t)(w32) << 8) & 0xFF0000) | (u_int32_t)((u_int32_t)(w32) << 24))
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(w16) ((u_int16_t)(w16))
+#define le16_to_cpu(w16) ((u_int16_t)(w16))
+#define cpu_to_le32(w32) ((u_int32_t)(w32))
+#define le32_to_cpu(w32) ((u_int32_t)(w32))
+#else
+#error Expected endianess macro to be set
+#endif
+
+/**
+ * expected_dummy_vfs_caps_uid - check vfs caps are stored with the provided uid
+ */
+static bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid)
+{
+#define __cap_raised_permitted(x, ns_cap_data)                                 \
+	((ns_cap_data.data[(x) >> 5].permitted) & (1 << ((x)&31)))
+	struct vfs_ns_cap_data ns_xattr = {};
+	ssize_t ret;
+
+	ret = fgetxattr(fd, "security.capability", &ns_xattr, sizeof(ns_xattr));
+	if (ret < 0 || ret == 0)
+		return false;
+
+	if (ns_xattr.magic_etc & VFS_CAP_REVISION_3) {
+
+		if (le32_to_cpu(ns_xattr.rootid) != expected_uid) {
+			errno = EINVAL;
+			log_stderr("failure: rootid(%d) != expected_rootid(%d)", le32_to_cpu(ns_xattr.rootid), expected_uid);
+		}
+
+		return (le32_to_cpu(ns_xattr.rootid) == expected_uid) &&
+		       (__cap_raised_permitted(CAP_NET_RAW, ns_xattr) > 0);
+	} else {
+		log_stderr("failure: fscaps version");
+	}
+
+	return false;
+}
+
+/**
+ * set_dummy_vfs_caps - set dummy vfs caps for the provided uid
+ */
+static int set_dummy_vfs_caps(int fd, int flags, int rootuid)
+{
+#define __raise_cap_permitted(x, ns_cap_data)                                  \
+	ns_cap_data.data[(x) >> 5].permitted |= (1 << ((x)&31))
+
+	struct vfs_ns_cap_data ns_xattr;
+
+	memset(&ns_xattr, 0, sizeof(ns_xattr));
+	__raise_cap_permitted(CAP_NET_RAW, ns_xattr);
+	ns_xattr.magic_etc |= VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE;
+	ns_xattr.rootid = cpu_to_le32(rootuid);
+
+	return fsetxattr(fd, "security.capability",
+			 &ns_xattr, sizeof(ns_xattr), flags);
+}
+
+#define safe_close(fd)      \
+	if (fd >= 0) {           \
+		int _e_ = errno; \
+		close(fd);       \
+		errno = _e_;     \
+		fd = -EBADF;     \
+	}
+
+static void test_setup(void)
+{
+	if (mkdirat(t_mnt_fd, T_DIR1, 0777))
+		die("failure: mkdirat");
+
+	t_dir1_fd = openat(t_mnt_fd, T_DIR1, O_CLOEXEC | O_DIRECTORY);
+	if (t_dir1_fd < 0)
+		die("failure: openat");
+}
+
+static void test_cleanup(void)
+{
+	safe_close(t_dir1_fd);
+	if (rm_r(t_mnt_fd, T_DIR1))
+		die("failure: rm_r");
+}
+
+/**
+ * Validate that basic file operations on idmapped mounts.
+ */
+static int fsids_unmapped(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, hardlink_target_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create hardlink target */
+	hardlink_target_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (hardlink_target_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create directory for rename test */
+	if (mkdirat(t_dir1_fd, DIR1, 0700)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	if (!switch_fsids(0, 0)) {
+		log_stderr("failure: switch_fsids");
+		goto out;
+	}
+
+	/*
+	 * The caller's fsids don't have a mappings in the idmapped mount so
+	 * any file creation must fail.
+	 */
+
+	/* create hardlink */
+	if (!linkat(open_tree_fd, FILE1, open_tree_fd, HARDLINK1, 0)) {
+		log_stderr("failure: linkat");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* try to rename a file */
+	if (!renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0)) {
+		log_stderr("failure: renameat2");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* try to rename a directory */
+	if (!renameat2(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME, 0)) {
+		log_stderr("failure: renameat2");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/*
+	 * The caller is privileged over the inode so file deletion must work.
+	 */
+
+	/* remove file */
+	if (unlinkat(open_tree_fd, FILE1, 0)) {
+		log_stderr("failure: unlinkat");
+		goto out;
+	}
+
+	/* remove directory */
+	if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR)) {
+		log_stderr("failure: unlinkat");
+		goto out;
+	}
+
+	/*
+	 * The caller's fsids don't have a mappings in the idmapped mount so
+	 * any file creation must fail.
+	 */
+
+	/* create regular file via open() */
+	file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd >= 0) {
+		log_stderr("failure: create");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (!mknodat(open_tree_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* create character device */
+	if (!mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1))) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* create symlink */
+	if (!symlinkat(FILE2, open_tree_fd, SYMLINK1)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	/* create directory */
+	if (!mkdirat(open_tree_fd, DIR1, 0700)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(hardlink_target_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int fsids_mapped(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, hardlink_target_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create hardlink target */
+	hardlink_target_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (hardlink_target_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create directory for rename test */
+	if (mkdirat(t_dir1_fd, DIR1, 0700)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_up())
+			die("failure: raise caps");
+
+		/*
+		 * The caller's fsids now have mappings in the idmapped mount so any
+		 * file creation must fail.
+		 */
+
+		/* create hardlink */
+		if (linkat(open_tree_fd, FILE1, open_tree_fd, HARDLINK1, 0))
+			die("failure: create hardlink");
+
+		/* try to rename a file */
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: rename");
+
+		/* try to rename a directory */
+		if (renameat2(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME, 0))
+			die("failure: rename");
+
+		/* remove file */
+		if (unlinkat(open_tree_fd, FILE1_RENAME, 0))
+			die("failure: delete");
+
+		/* remove directory */
+		if (unlinkat(open_tree_fd, DIR1_RENAME, AT_REMOVEDIR))
+			die("failure: delete");
+
+		/*
+		 * The caller's fsids have mappings in the idmapped mount so
+		 * any file creation must fail.
+		 */
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* create regular file via mknod */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | 0000, 0))
+			die("failure: create");
+
+		/* create character device */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1)))
+			die("failure: create");
+
+		/* create symlink */
+		if (symlinkat(FILE2, open_tree_fd, SYMLINK1))
+			die("failure: create");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0700))
+			die("failure: create");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(hardlink_target_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that basic file operations on idmapped mounts from a user
+ * namespace.
+ */
+static int create_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	/* change ownership of all files to uid 0 */
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		if (file1_fd < 0)
+			die("failure: open file");
+		safe_close(file1_fd);
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* create regular file via mknod */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | 0000, 0))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* create symlink */
+		if (symlinkat(FILE2, open_tree_fd, SYMLINK1))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 0, 0))
+			die("failure: check ownership");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0700))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* try to rename a file */
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1_RENAME, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* try to rename a file */
+		if (renameat2(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME, 0))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, DIR1_RENAME, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* remove file */
+		if (unlinkat(open_tree_fd, FILE1_RENAME, 0))
+			die("failure: remove");
+
+		/* remove directory */
+		if (unlinkat(open_tree_fd, DIR1_RENAME, AT_REMOVEDIR))
+			die("failure: remove");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int hardlink_crossing_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+
+        if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (mkdirat(open_tree_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/*
+	 * We're crossing a mountpoint so this must fail.
+	 *
+	 * Note that this must also fail for non-idmapped mounts but here we're
+	 * interested in making sure we're not introducing an accidental way to
+	 * violate that restriction or that suddenly this becomes possible.
+	 */
+	if (!linkat(open_tree_fd, FILE1, t_dir1_fd, HARDLINK1, 0)) {
+		log_stderr("failure: linkat");
+		goto out;
+	}
+	if (errno != EXDEV) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int hardlink_crossing_idmapped_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd1 = -EBADF, open_tree_fd2 = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd1 = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd1 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd1, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd = openat(open_tree_fd1, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	if (mkdirat(open_tree_fd1, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	open_tree_fd2 = sys_open_tree(t_dir1_fd, DIR1,
+				      AT_NO_AUTOMOUNT |
+				      AT_SYMLINK_NOFOLLOW |
+				      OPEN_TREE_CLOEXEC |
+				      OPEN_TREE_CLONE |
+				      AT_RECURSIVE);
+	if (open_tree_fd2 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd2, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * We're crossing a mountpoint so this must fail.
+	 *
+	 * Note that this must also fail for non-idmapped mounts but here we're
+	 * interested in making sure we're not introducing an accidental way to
+	 * violate that restriction or that suddenly this becomes possible.
+	 */
+	if (!linkat(open_tree_fd1, FILE1, open_tree_fd2, HARDLINK1, 0)) {
+		log_stderr("failure: linkat");
+		goto out;
+	}
+	if (errno != EXDEV) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd1);
+	safe_close(open_tree_fd2);
+
+	return fret;
+}
+
+static int hardlink_from_idmapped_mount(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* We're not crossing a mountpoint so this must succeed. */
+	if (linkat(open_tree_fd, FILE1, open_tree_fd, HARDLINK1, 0)) {
+		log_stderr("failure: linkat");
+		goto out;
+	}
+
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int hardlink_from_idmapped_mount_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* We're not crossing a mountpoint so this must succeed. */
+		if (linkat(open_tree_fd, FILE1, open_tree_fd, HARDLINK1, 0))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, HARDLINK1, 0, 0, 0))
+			die("failure: check ownership");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int rename_crossing_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+
+	if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (mkdirat(open_tree_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/*
+	 * We're crossing a mountpoint so this must fail.
+	 *
+	 * Note that this must also fail for non-idmapped mounts but here we're
+	 * interested in making sure we're not introducing an accidental way to
+	 * violate that restriction or that suddenly this becomes possible.
+	 */
+	if (!renameat2(open_tree_fd, FILE1, t_dir1_fd, FILE1_RENAME, 0)) {
+		log_stderr("failure: renameat2");
+		goto out;
+	}
+	if (errno != EXDEV) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int rename_crossing_idmapped_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd1 = -EBADF, open_tree_fd2 = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd1 = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd1 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd1, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd = openat(open_tree_fd1, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (mkdirat(open_tree_fd1, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	open_tree_fd2 = sys_open_tree(t_dir1_fd, DIR1,
+				      AT_NO_AUTOMOUNT |
+				      AT_SYMLINK_NOFOLLOW |
+				      OPEN_TREE_CLOEXEC |
+				      OPEN_TREE_CLONE |
+				      AT_RECURSIVE);
+	if (open_tree_fd2 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd2, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * We're crossing a mountpoint so this must fail.
+	 *
+	 * Note that this must also fail for non-idmapped mounts but here we're
+	 * interested in making sure we're not introducing an accidental way to
+	 * violate that restriction or that suddenly this becomes possible.
+	 */
+	if (!renameat2(open_tree_fd1, FILE1, open_tree_fd2, FILE1_RENAME, 0)) {
+		log_stderr("failure: renameat2");
+		goto out;
+	}
+	if (errno != EXDEV) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd1);
+	safe_close(open_tree_fd2);
+
+	return fret;
+}
+
+static int rename_from_idmapped_mount(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* We're not crossing a mountpoint so this must succeed. */
+	if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0)) {
+		log_stderr("failure: renameat2");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int rename_from_idmapped_mount_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/* We're not crossing a mountpoint so this must succeed. */
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: create");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1_RENAME, 0, 0, 0))
+			die("failure: check ownership");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int symlink_regular_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct stat st;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (chown_r(t_mnt_fd, T_DIR1, 10000, 10000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, open_tree_fd, FILE2)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+
+	if (fchownat(open_tree_fd, FILE2, 15000, 15000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	if (fstatat(open_tree_fd, FILE2, &st, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fstatat");
+		goto out;
+	}
+
+	if (st.st_uid != 15000 || st.st_gid != 15000) {
+		log_stderr("failure: compare ids");
+		goto out;
+	}
+
+	if (fstatat(open_tree_fd, FILE1, &st, 0)) {
+		log_stderr("failure: fstatat");
+		goto out;
+	}
+
+	if (st.st_uid != 10000 || st.st_gid != 10000) {
+		log_stderr("failure: compare ids");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int symlink_idmapped_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_fsids(10000, 10000))
+			die("failure: switch fsids");
+
+		if (!caps_up())
+			die("failure: raise caps");
+
+		if (symlinkat(FILE1, open_tree_fd, FILE2))
+			die("failure: create");
+
+		if (fchownat(open_tree_fd, FILE2, 15000, 15000, AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW, 15000, 15000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int symlink_idmapped_mounts_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (chown_r(t_mnt_fd, T_DIR1, 0, 0)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		if (file1_fd < 0)
+			die("failure: create");
+		safe_close(file1_fd);
+
+		if (symlinkat(FILE1, open_tree_fd, FILE2))
+			die("failure: create");
+
+		if (fchownat(open_tree_fd, FILE2, 5000, 5000, AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW, 5000, 5000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_uid_gid(t_dir1_fd, FILE2, AT_SYMLINK_NOFOLLOW, 5000, 5000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that a caller whose fsids map into the idmapped mount within it's
+ * user namespace cannot create any device nodes.
+ */
+static int device_node_in_userns(void)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* create character device */
+		if (!mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1)))
+			die("failure: create");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+
+/**
+ * Validate that changing file ownership works correctly on idmapped mounts.
+ */
+static int expected_uid_gid_idmapped_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd1 = -EBADF, open_tree_fd2 = -EBADF;
+	struct mount_attr attr1 = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	struct mount_attr attr2 = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!switch_fsids(0, 0)) {
+		log_stderr("failure: switch_fsids");
+		goto out;
+	}
+
+	/* create regular file via open() */
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(t_dir1_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+
+	/* create character device */
+	if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1))) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+
+	/* create hardlink */
+	if (linkat(t_dir1_fd, FILE1, t_dir1_fd, HARDLINK1, 0)) {
+		log_stderr("failure: linkat");
+		goto out;
+	}
+
+	/* create symlink */
+	if (symlinkat(FILE2, t_dir1_fd, SYMLINK1)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0700)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr1.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr1.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd1 = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd1 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd1, "", AT_EMPTY_PATH, &attr1, sizeof(attr1))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * Validate that all files created through the image mountpoint are
+	 * owned by the callers fsuid and fsgid.
+	 */
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, HARDLINK1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/*
+	 * Validate that all files are owned by the uid and gid specified in
+	 * the idmapping of the mount they are accessed from.
+	 */
+	if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, FILE2, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, DIR1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr2.userns_fd	= get_userns_fd(0, 30000, 2001);
+	if (attr2.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd2 = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd2 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd2, "", AT_EMPTY_PATH, &attr2, sizeof(attr2))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * Validate that all files are owned by the uid and gid specified in
+	 * the idmapping of the mount they are accessed from.
+	 */
+	if (!expected_uid_gid(open_tree_fd2, FILE1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, FILE2, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, DIR1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Change ownership throught original image mountpoint. */
+	if (fchownat(t_dir1_fd, FILE1, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchownat(t_dir1_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchownat(t_dir1_fd, HARDLINK1, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchownat(t_dir1_fd, CHRDEV1, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchownat(t_dir1_fd, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchownat(t_dir1_fd, SYMLINK1, 2000, 2000, AT_EMPTY_PATH)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchownat(t_dir1_fd, DIR1, 2000, 2000, AT_EMPTY_PATH)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	/* Check ownership through original mount. */
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, HARDLINK1, 0, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 3000, 3000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, 0, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Check ownership through first idmapped mount. */
+	if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 12000, 12000)) {
+		log_stderr("failure:expected_uid_gid ");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, FILE2, 0, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 13000, 13000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, 0, 12000, 12000)) {
+		log_stderr("failure:expected_uid_gid ");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, DIR1, 0, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Check ownership through second idmapped mount. */
+	if (!expected_uid_gid(open_tree_fd2, FILE1, 0, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, FILE2, 0, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 65534, 65534)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, 0, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, DIR1, 0, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr1.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!fchownat(t_dir1_fd, FILE1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, FILE2, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, HARDLINK1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, CHRDEV1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, SYMLINK1, 2000, 2000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, SYMLINK1, 1000, 1000, AT_EMPTY_PATH))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, DIR1, 1000, 1000, AT_EMPTY_PATH))
+			die("failure: fchownat");
+
+		if (!fchownat(open_tree_fd2, FILE1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, FILE2, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, HARDLINK1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, CHRDEV1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, SYMLINK1, 2000, 2000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, SYMLINK1, 1000, 1000, AT_EMPTY_PATH))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, DIR1, 1000, 1000, AT_EMPTY_PATH))
+			die("failure: fchownat");
+
+		if (fchownat(open_tree_fd1, FILE1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd1, FILE2, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd1, HARDLINK1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd1, CHRDEV1, 1000, 1000, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd1, SYMLINK1, 2000, 2000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd1, SYMLINK1, 1000, 1000, AT_EMPTY_PATH))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd1, DIR1, 1000, 1000, AT_EMPTY_PATH))
+			die("failure: fchownat");
+
+		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, HARDLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, SYMLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd2, FILE1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, FILE2, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, SYMLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, DIR1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 1000, 1000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, FILE2, 0, 1000, 1000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 1000, 1000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 1000, 1000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 2000, 2000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, SYMLINK1, 0, 1000, 1000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, DIR1, 0, 1000, 1000))
+			die("failure: expected_uid_gid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Check ownership through original mount. */
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, HARDLINK1, 0, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, 0, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Check ownership through first idmapped mount. */
+	if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, FILE2, 0, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, 0, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, DIR1, 0, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Check ownership through second idmapped mount. */
+	if (!expected_uid_gid(open_tree_fd2, FILE1, 0, 31000, 31000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, FILE2, 0, 31000, 31000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 31000, 31000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 31000, 31000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, 0, 31000, 31000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, DIR1, 0, 31000, 31000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr2.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!fchownat(t_dir1_fd, FILE1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, HARDLINK1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, SYMLINK1, 0, 0, AT_EMPTY_PATH))
+			die("failure: fchownat");
+		if (!fchownat(t_dir1_fd, DIR1, 0, 0, AT_EMPTY_PATH))
+			die("failure: fchownat");
+
+		if (!fchownat(open_tree_fd1, FILE1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd1, FILE2, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd1, HARDLINK1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd1, CHRDEV1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd1, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd1, SYMLINK1, 0, 0, AT_EMPTY_PATH))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd1, DIR1, 0, 0, AT_EMPTY_PATH))
+			die("failure: fchownat");
+
+		if (fchownat(open_tree_fd2, FILE1, 0, 0, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd2, FILE2, 0, 0, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd2, HARDLINK1, 0, 0, 0))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd2, CHRDEV1, 0, 0, 0))
+			die("failure: fchownat");
+		if (!fchownat(open_tree_fd2, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd2, SYMLINK1, 0, 0, AT_EMPTY_PATH))
+			die("failure: fchownat");
+		if (fchownat(open_tree_fd2, DIR1, 0, 0, AT_EMPTY_PATH))
+			die("failure: fchownat");
+
+		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, HARDLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, SYMLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, FILE2, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, SYMLINK1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd1, DIR1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+
+		if (!expected_uid_gid(open_tree_fd2, FILE1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, FILE2, 0, 0, 0))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 2000, 2000))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, SYMLINK1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+		if (!expected_uid_gid(open_tree_fd2, DIR1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Check ownership through original mount. */
+	if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, HARDLINK1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, SYMLINK1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Check ownership through first idmapped mount. */
+	if (!expected_uid_gid(open_tree_fd1, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, FILE2, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, SYMLINK1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd1, DIR1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Check ownership through second idmapped mount. */
+	if (!expected_uid_gid(open_tree_fd2, FILE1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, FILE2, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 32000, 32000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, SYMLINK1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(open_tree_fd2, DIR1, 0, 30000, 30000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr1.userns_fd);
+	safe_close(attr2.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd1);
+	safe_close(open_tree_fd2);
+
+	return fret;
+}
+
+static int fscaps(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* Skip if vfs caps are unsupported. */
+	if (set_dummy_vfs_caps(file1_fd, 0, 1000))
+		return 0;
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 1000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 1000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+	if (expected_dummy_vfs_caps_uid(file1_fd, -1)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+	if (errno != ENODATA) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	if (set_dummy_vfs_caps(file1_fd, 0, 10000)) {
+		log_stderr("failure: set_dummy_vfs_caps");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 10000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 0))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+	if (expected_dummy_vfs_caps_uid(file1_fd, -1)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+	if (errno != ENODATA) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+
+	return fret;
+}
+
+static int fscaps_idmapped_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* Skip if vfs caps are unsupported. */
+	if (set_dummy_vfs_caps(file1_fd, 0, 1000))
+		return 0;
+
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd2 = openat(open_tree_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
+	if (file1_fd2 < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (!set_dummy_vfs_caps(file1_fd2, 0, 1000)) {
+		log_stderr("failure: set_dummy_vfs_caps");
+		goto out;
+	}
+
+	if (set_dummy_vfs_caps(file1_fd2, 0, 10000)) {
+		log_stderr("failure: set_dummy_vfs_caps");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd2, 10000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 0)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (fremovexattr(file1_fd2, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+	if (expected_dummy_vfs_caps_uid(file1_fd2, -1)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+	if (errno != ENODATA) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	if (set_dummy_vfs_caps(file1_fd2, 0, 12000)) {
+		log_stderr("failure: set_dummy_vfs_caps");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd2, 12000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 2000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 2000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(file1_fd2);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int fscaps_idmapped_mounts_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* Skip if vfs caps are unsupported. */
+	if (set_dummy_vfs_caps(file1_fd, 0, 1000))
+		return 0;
+
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd2 = openat(open_tree_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
+	if (file1_fd2 < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (set_dummy_vfs_caps(file1_fd2, 0, 0))
+			die("failure: set_dummy_vfs_caps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
+			die("failure: set_dummy_vfs_caps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 0))
+			die("failure: set_dummy_vfs_caps");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 0)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (fremovexattr(file1_fd2, "security.capability"))
+			die("failure: fremovexattr");
+		if (expected_dummy_vfs_caps_uid(file1_fd2, -1))
+			die("failure: expected_dummy_vfs_caps_uid");
+		if (errno != ENODATA)
+			die("failure: errno");
+
+		if (set_dummy_vfs_caps(file1_fd2, 0, 1000))
+			die("failure: set_dummy_vfs_caps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 1000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 1000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 1000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(file1_fd2);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int fscaps_idmapped_mounts_in_userns_separate_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* Skip if vfs caps are unsupported. */
+	if (set_dummy_vfs_caps(file1_fd, 0, 1000)) {
+		log_stderr("failure: set_dummy_vfs_caps");
+		goto out;
+	}
+
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+
+	/* change ownership of all files to uid 0 */
+	if (chown_r(t_mnt_fd, T_DIR1, 20000, 20000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(20000, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	file1_fd2 = openat(open_tree_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
+	if (file1_fd2 < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int userns_fd;
+
+		userns_fd = get_userns_fd(0, 10000, 10000);
+		if (userns_fd < 0)
+			die("failure: get_userns_fd");
+
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (set_dummy_vfs_caps(file1_fd2, 0, 0))
+			die("failure: set fscaps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 20000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 20000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int userns_fd;
+
+		userns_fd = get_userns_fd(0, 10000, 10000);
+		if (userns_fd < 0)
+			die("failure: get_userns_fd");
+
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (fremovexattr(file1_fd2, "security.capability"))
+			die("failure: fremovexattr");
+		if (expected_dummy_vfs_caps_uid(file1_fd2, -1))
+			die("failure: expected_dummy_vfs_caps_uid");
+		if (errno != ENODATA)
+			die("failure: errno");
+
+		if (set_dummy_vfs_caps(file1_fd2, 0, 1000))
+			die("failure: set_dummy_vfs_caps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 1000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 21000))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 21000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(file1_fd2);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that when the IDMAP_MOUNT_TEST_RUN_SETID environment variable is
+ * set to 1 that we are executed with setid privileges and if set to 0 we are
+ * not. If the env variable isn't set the tests are not run.
+ */
+static void __attribute__((constructor)) setuid_rexec(void)
+{
+	const char *expected_euid_str, *expected_egid_str, *rexec;
+
+	rexec = getenv("IDMAP_MOUNT_TEST_RUN_SETID");
+	/* This is a regular test-suite run. */
+	if (!rexec)
+		return;
+
+	expected_euid_str = getenv("EXPECTED_EUID");
+	expected_egid_str = getenv("EXPECTED_EGID");
+
+	if (expected_euid_str && expected_egid_str) {
+		uid_t expected_euid;
+		gid_t expected_egid;
+
+		expected_euid = atoi(expected_euid_str);
+		expected_egid = atoi(expected_egid_str);
+
+		if (strcmp(rexec, "1") == 0) {
+			/* we're expecting to run setid */
+			if ((getuid() != geteuid()) && (expected_euid == geteuid()) &&
+			    (getgid() != getegid()) && (expected_egid == getegid()))
+				exit(EXIT_SUCCESS);
+		} else if (strcmp(rexec, "0") == 0) {
+			/* we're expecting to not run setid */
+			if ((getuid() == geteuid()) && (expected_euid == geteuid()) &&
+			    (getgid() == getegid()) && (expected_egid == getegid()))
+				exit(EXIT_SUCCESS);
+			else
+				die("failure: non-setid");
+		}
+	}
+
+	exit(EXIT_FAILURE);
+}
+
+/**
+ * Validate that setid transitions are handled correctly.
+ */
+static int setid_binaries(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, exec_fd = -EBADF;
+	pid_t pid;
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC | O_RDWR, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	if (exec_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* copy our own executable into the file we created */
+	if (fd_to_fd(exec_fd, file1_fd)) {
+		log_stderr("failure: fd_to_fd");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 5000, 5000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	/* set the setid bits and grant execute permissions to the group */
+	if (fchmod(file1_fd, S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(exec_fd);
+	safe_close(file1_fd);
+
+	/*
+	 * Verify we run setid binary as uid and gid 5000 from the original
+	 * mount.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=5000",
+			"EXPECTED_EGID=5000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 5000, 5000))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(t_dir1_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+
+	return fret;
+}
+
+/**
+ * Validate that setid transitions are handled correctly on idmapped mounts.
+ */
+static int setid_binaries_idmapped_mounts(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, exec_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (mkdirat(t_mnt_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC | O_RDWR, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	if (exec_fd < 0) {
+		log_stderr("failure:openat ");
+		goto out;
+	}
+
+	/* copy our own executable into the file we created */
+	if (fd_to_fd(exec_fd, file1_fd)) {
+		log_stderr("failure: fd_to_fd");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 5000, 5000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	/* set the setid bits and grant execute permissions to the group */
+	if (fchmod(file1_fd, S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(exec_fd);
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * A detached mount will have an anonymous mount namespace attached to
+	 * it. This means that we can't execute setid binaries on a detached
+	 * mount because the mnt_may_suid() helper will fail the check_mount()
+	 * part of its check which compares the caller's mount namespace to the
+	 * detached mount's mount namespace. Since by definition an anonymous
+	 * mount namespace is not equale to any mount namespace currently in
+	 * use this can't work. So attach the mount to the filesystem first
+	 * before performing this check.
+	 */
+	if (sys_move_mount(open_tree_fd, "", t_mnt_fd, DIR1, MOVE_MOUNT_F_EMPTY_PATH)) {
+		log_stderr("failure: sys_move_mount");
+		goto out;
+	}
+
+	/* Verify we run setid binary as uid and gid 10000 from idmapped mount mount. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=15000",
+			"EXPECTED_EGID=15000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 15000, 15000))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+out:
+	safe_close(exec_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	snprintf(t_buf, sizeof(t_buf), "%s/" DIR1, t_mountpoint);
+	sys_umount2(t_buf, MNT_DETACH);
+	rm_r(t_mnt_fd, DIR1);
+
+	return fret;
+}
+
+/**
+ * Validate that setid transitions are handled correctly on idmapped mounts
+ * running in a user namespace where the uid and gid of the setid binary have
+ * no mapping.
+ */
+static int setid_binaries_idmapped_mounts_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, exec_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (mkdirat(t_mnt_fd, DIR1, 0777)) {
+		log_stderr("failure: ");
+		goto out;
+	}
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC | O_RDWR, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	if (exec_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* copy our own executable into the file we created */
+	if (fd_to_fd(exec_fd, file1_fd)) {
+		log_stderr("failure: fd_to_fd");
+		goto out;
+	}
+
+	safe_close(exec_fd);
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 5000, 5000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	/* set the setid bits and grant execute permissions to the group */
+	if (fchmod(file1_fd, S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * A detached mount will have an anonymous mount namespace attached to
+	 * it. This means that we can't execute setid binaries on a detached
+	 * mount because the mnt_may_suid() helper will fail the check_mount()
+	 * part of its check which compares the caller's mount namespace to the
+	 * detached mount's mount namespace. Since by definition an anonymous
+	 * mount namespace is not equale to any mount namespace currently in
+	 * use this can't work. So attach the mount to the filesystem first
+	 * before performing this check.
+	 */
+	if (sys_move_mount(open_tree_fd, "", t_mnt_fd, DIR1, MOVE_MOUNT_F_EMPTY_PATH)) {
+		log_stderr("failure: sys_move_mount");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=5000",
+			"EXPECTED_EGID=5000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 5000, 5000))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDWR | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	/* set the setid bits and grant execute permissions to the group */
+	if (fchmod(file1_fd, S_IXOTH | S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=0",
+			"EXPECTED_EGID=0",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		if (!switch_userns(attr.userns_fd, 5000, 5000, true))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDWR | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 30000, 30000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	if (fchmod(file1_fd, S_IXOTH | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	/*
+	 * Verify that we can't assume a uid and gid of a setid binary for
+	 * which we have no mapping in our user namespace.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		char expected_euid[100];
+		char expected_egid[100];
+		static char *envp[4] = {
+			NULL,
+			NULL,
+			NULL,
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		envp[0] = "IDMAP_MOUNT_TEST_RUN_SETID=0";
+		snprintf(expected_euid, sizeof(expected_euid), "EXPECTED_EUID=%d", geteuid());
+		envp[1] = expected_euid;
+		snprintf(expected_egid, sizeof(expected_egid), "EXPECTED_EGID=%d", getegid());
+		envp[2] = expected_egid;
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(exec_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	snprintf(t_buf, sizeof(t_buf), "%s/" DIR1, t_mountpoint);
+	sys_umount2(t_buf, MNT_DETACH);
+	rm_r(t_mnt_fd, DIR1);
+
+	return fret;
+}
+
+/**
+ * Validate that setid transitions are handled correctly on idmapped mounts
+ * running in a user namespace where the uid and gid of the setid binary have
+ * no mapping.
+ */
+static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, exec_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (mkdirat(t_mnt_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC | O_RDWR, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	if (exec_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* copy our own executable into the file we created */
+	if (fd_to_fd(exec_fd, file1_fd)) {
+		log_stderr("failure: fd_to_fd");
+		goto out;
+	}
+
+	safe_close(exec_fd);
+
+	/* change ownership of all files to uid 0 */
+	if (chown_r(t_mnt_fd, T_DIR1, 20000, 20000)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 25000, 25000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	/* set the setid bits and grant execute permissions to the group */
+	if (fchmod(file1_fd, S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(20000, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * A detached mount will have an anonymous mount namespace attached to
+	 * it. This means that we can't execute setid binaries on a detached
+	 * mount because the mnt_may_suid() helper will fail the check_mount()
+	 * part of its check which compares the caller's mount namespace to the
+	 * detached mount's mount namespace. Since by definition an anonymous
+	 * mount namespace is not equale to any mount namespace currently in
+	 * use this can't work. So attach the mount to the filesystem first
+	 * before performing this check.
+	 */
+	if (sys_move_mount(open_tree_fd, "", t_mnt_fd, DIR1, MOVE_MOUNT_F_EMPTY_PATH)) {
+		log_stderr("failure: sys_move_mount");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int userns_fd;
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=5000",
+			"EXPECTED_EGID=5000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		userns_fd = get_userns_fd(0, 10000, 10000);
+		if (userns_fd < 0)
+			die("failure: get_userns_fd");
+
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 5000, 5000))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDWR | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 20000, 20000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	/* set the setid bits and grant execute permissions to the group */
+	if (fchmod(file1_fd, S_IXOTH | S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int userns_fd;
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=0",
+			"EXPECTED_EGID=0",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		userns_fd = get_userns_fd(0, 10000, 10000);
+		if (userns_fd < 0)
+			die("failure: get_userns_fd");
+
+		if (!switch_userns(userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDWR | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* chown the file to the uid and gid we want to assume */
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	if (fchmod(file1_fd, S_IXOTH | S_IEXEC | S_ISUID | S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setid(t_dir1_fd, FILE1, 0)) {
+		log_stderr("failure: is_setid");
+		goto out;
+	}
+
+	safe_close(file1_fd);
+
+	/*
+	 * Verify that we can't assume a uid and gid of a setid binary for
+	 * which we have no mapping in our user namespace.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int userns_fd;
+		char expected_euid[100];
+		char expected_egid[100];
+		static char *envp[4] = {
+			NULL,
+			NULL,
+			NULL,
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		userns_fd = get_userns_fd(0, 10000, 10000);
+		if (userns_fd < 0)
+			die("failure: get_userns_fd");
+
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		envp[0] = "IDMAP_MOUNT_TEST_RUN_SETID=0";
+		snprintf(expected_euid, sizeof(expected_euid), "EXPECTED_EUID=%d", geteuid());
+		envp[1] = expected_euid;
+		snprintf(expected_egid, sizeof(expected_egid), "EXPECTED_EGID=%d", getegid());
+		envp[2] = expected_egid;
+
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 65534, 65534))
+			die("failure: expected_uid_gid");
+
+		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
+		die("failure: sys_execveat");
+
+		exit(EXIT_FAILURE);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(exec_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	snprintf(t_buf, sizeof(t_buf), "%s/" DIR1, t_mountpoint);
+	sys_umount2(t_buf, MNT_DETACH);
+	rm_r(t_mnt_fd, DIR1);
+
+	return fret;
+}
+
+static int sticky_bit_unlink(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF;
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (fchown(dir_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	if (fchmod(dir_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* set sticky bit */
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (!unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* change ownership */
+		if (fchownat(dir_fd, FILE1, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE1, 0, 1000, 0))
+			die("failure: expected_uid_gid");
+		if (fchownat(dir_fd, FILE2, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000))
+			die("failure: expected_uid_gid");
+
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* change uid to unprivileged user */
+	if (fchown(dir_fd, 1000, -1)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(dir_fd);
+
+	return fret;
+}
+
+static int sticky_bit_unlink_idmapped_mounts(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 10000, 10000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 10000, 10000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 12000, 12000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(dir_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* set sticky bit */
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 10000, 10000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 12000, 12000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (!unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* change ownership */
+		if (fchownat(dir_fd, FILE1, 11000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE1, 0, 11000, 10000))
+			die("failure: expected_uid_gid");
+		if (fchownat(dir_fd, FILE2, 11000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE2, 0, 11000, 12000))
+			die("failure: expected_uid_gid");
+
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* change uid to unprivileged user */
+	if (fchown(dir_fd, 11000, -1)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 10000, 10000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 12000, 12000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(dir_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on idmapped mounts for unlink
+ * operations in a user namespace.
+ */
+static int sticky_bit_unlink_idmapped_mounts_in_userns(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(dir_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* set sticky bit */
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (!unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* change ownership */
+		if (fchownat(dir_fd, FILE1, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE1, 0, 1000, 0))
+			die("failure: expected_uid_gid");
+		if (fchownat(dir_fd, FILE2, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000))
+			die("failure: expected_uid_gid");
+
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (!unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* change uid to unprivileged user */
+	if (fchown(dir_fd, 1000, -1)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		/* we don't own the directory from the original mount */
+		if (!unlinkat(dir_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!unlinkat(dir_fd, FILE2, 0))
+			die("failure: unlinkat");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* we own the file from the idmapped mount */
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: unlinkat");
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: unlinkat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(dir_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int sticky_bit_rename(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF;
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* set sticky bit */
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* change ownership */
+		if (fchownat(dir_fd, FILE1, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE1, 0, 1000, 0))
+			die("failure: expected_uid_gid");
+		if (fchownat(dir_fd, FILE2, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000))
+			die("failure: expected_uid_gid");
+
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* change uid to unprivileged user */
+	if (fchown(dir_fd, 1000, -1)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(dir_fd);
+
+	return fret;
+}
+
+static int sticky_bit_rename_idmapped_mounts(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (fchown(dir_fd, 10000, 10000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	if (fchmod(dir_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 10000, 10000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 12000, 12000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(dir_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* set sticky bit */
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (!renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* change ownership */
+		if (fchownat(dir_fd, FILE1, 11000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE1, 0, 11000, 10000))
+			die("failure: expected_uid_gid");
+		if (fchownat(dir_fd, FILE2, 11000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE2, 0, 11000, 12000))
+			die("failure: expected_uid_gid");
+
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* change uid to unprivileged user */
+	if (fchown(dir_fd, 11000, -1)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(dir_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on idmapped mounts for unlink
+ * operations in a user namespace.
+ */
+static int sticky_bit_rename_idmapped_mounts_in_userns(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE2, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE2, 2000, 2000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE2, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(dir_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* set sticky bit */
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* change ownership */
+		if (fchownat(dir_fd, FILE1, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE1, 0, 1000, 0))
+			die("failure: expected_uid_gid");
+		if (fchownat(dir_fd, FILE2, 1000, -1, 0))
+			die("failure: fchownat");
+		if (!expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000))
+			die("failure: expected_uid_gid");
+
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/* change uid to unprivileged user */
+	if (fchown(dir_fd, 1000, -1)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		/* we don't own the directory from the original mount */
+		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* we own the file from the idmapped mount */
+		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
+			die("failure: renameat2");
+
+		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
+			die("failure: renameat2");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(open_tree_fd);
+	safe_close(attr.userns_fd);
+	safe_close(dir_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that protected symlinks work correctly.
+ */
+static int protected_symlinks(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, fd = -EBADF;
+	pid_t pid;
+
+	if (!protected_symlinks_enabled())
+		return 0;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create symlinks */
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER1)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER1, 0, 0, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER1, AT_SYMLINK_NOFOLLOW, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER2)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER2, 1000, 1000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER2, AT_SYMLINK_NOFOLLOW, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER3)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER3, 2000, 2000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER3, AT_SYMLINK_NOFOLLOW, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* validate file can be directly read */
+	fd = openat(dir_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+	if (fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(fd);
+
+	/* validate file can be read through own symlink */
+	fd = openat(dir_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+	if (fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		/* validate file can be directly read */
+		fd = openat(dir_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through own symlink */
+		fd = openat(dir_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through root symlink */
+		fd = openat(dir_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(dir_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		if (fd >= 0)
+			die("failure: openat");
+		if (errno != EACCES)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(2000, 2000))
+			die("failure: switch_ids");
+
+		/* validate file can be directly read */
+		fd = openat(dir_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through own symlink */
+		fd = openat(dir_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through root symlink */
+		fd = openat(dir_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(dir_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		if (fd >= 0)
+			die("failure: openat");
+		if (errno != EACCES)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(fd);
+	safe_close(dir_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that protected symlinks work correctly on idmapped mounts.
+ */
+static int protected_symlinks_idmapped_mounts(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!protected_symlinks_enabled())
+		return 0;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 10000, 10000)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 10000, 10000, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create symlinks */
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER1)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER1, 10000, 10000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER1, AT_SYMLINK_NOFOLLOW, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER2)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER2, 11000, 11000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER2, AT_SYMLINK_NOFOLLOW, 11000, 11000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER3)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER3, 12000, 12000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER3, AT_SYMLINK_NOFOLLOW, 12000, 12000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 10000, 10000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: open_tree_fd");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/* validate file can be directly read */
+	fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+	if (fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(fd);
+
+	/* validate file can be read through own symlink */
+	fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+	if (fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		if (fd >= 0)
+			die("failure: openat");
+		if (errno != EACCES)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(2000, 2000))
+			die("failure: switch_ids");
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		if (fd >= 0)
+			die("failure: openat");
+		if (errno != EACCES)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(fd);
+	safe_close(dir_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/**
+ * Validate that protected symlinks work correctly on idmapped mounts inside a
+ * user namespace.
+ */
+static int protected_symlinks_idmapped_mounts_in_userns(void)
+{
+	int fret = -1;
+	int dir_fd = -EBADF, fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (!protected_symlinks_enabled())
+		return 0;
+
+	if (!caps_supported())
+		return 0;
+
+	/* create directory */
+	if (mkdirat(t_dir1_fd, DIR1, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	dir_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(dir_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir_fd, 0777 | S_ISVTX)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	/* validate sticky bit is set */
+	if (!is_sticky(t_dir1_fd, DIR1, 0)) {
+		log_stderr("failure: is_sticky");
+		goto out;
+	}
+
+	/* create regular file via mknod */
+	if (mknodat(dir_fd, FILE1, S_IFREG | 0000, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+	if (fchownat(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (fchmodat(dir_fd, FILE1, 0644, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* create symlinks */
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER1)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER1, 0, 0, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER1, AT_SYMLINK_NOFOLLOW, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER2)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER2, 1000, 1000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER2, AT_SYMLINK_NOFOLLOW, 1000, 1000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	if (symlinkat(FILE1, dir_fd, SYMLINK_USER3)) {
+		log_stderr("failure: symlinkat");
+		goto out;
+	}
+	if (fchownat(dir_fd, SYMLINK_USER3, 2000, 2000, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, SYMLINK_USER3, AT_SYMLINK_NOFOLLOW, 2000, 2000)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+	if (!expected_uid_gid(dir_fd, FILE1, 0, 0, 0)) {
+		log_stderr("failure: expected_uid_gid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/* validate file can be directly read */
+	fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+	if (fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(fd);
+
+	/* validate file can be read through own symlink */
+	fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+	if (fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	safe_close(fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		if (fd >= 0)
+			die("failure: openat");
+		if (errno != EACCES)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 2000, 2000, true))
+			die("failure: switch_userns");
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		if (fd < 0)
+			die("failure: openat");
+		safe_close(fd);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		if (fd >= 0)
+			die("failure: openat");
+		if (errno != EACCES)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	safe_close(dir_fd);
+	safe_close(open_tree_fd);
+	safe_close(attr.userns_fd);
+
+	return fret;
+}
+
+static int acls(void)
+{
+	int fret = -1;
+	int dir1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	if (mkdirat(t_dir1_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+	if (fchmodat(t_dir1_fd, DIR1, 0777, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	if (mkdirat(t_dir1_fd, DIR2, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+	if (fchmodat(t_dir1_fd, DIR2, 0777, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd = get_userns_fd(100010, 100020, 5);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, DIR1,
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	if (sys_move_mount(open_tree_fd, "", t_dir1_fd, DIR2, MOVE_MOUNT_F_EMPTY_PATH)) {
+		log_stderr("failure: sys_move_mount");
+		goto out;
+	}
+
+	dir1_fd = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (dir1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	if (mkdirat(dir1_fd, DIR3, 0000)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+	if (fchown(dir1_fd, 100010, 100010)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(dir1_fd, 0777)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	snprintf(t_buf, sizeof(t_buf), "setfacl -m u:100010:rwx %s/%s/%s/%s", t_mountpoint, T_DIR1, DIR1, DIR3);
+	if (system(t_buf)) {
+		log_stderr("failure: system");
+		goto out;
+	}
+
+	snprintf(t_buf, sizeof(t_buf), "getfacl -p %s/%s/%s/%s | grep -q user:100010:rwx", t_mountpoint, T_DIR1, DIR1, DIR3);
+	if (system(t_buf)) {
+		log_stderr("failure: system");
+		goto out;
+	}
+
+	snprintf(t_buf, sizeof(t_buf), "getfacl -p %s/%s/%s/%s | grep -q user:100020:rwx", t_mountpoint, T_DIR1, DIR2, DIR3);
+	if (system(t_buf)) {
+		log_stderr("failure: system");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 100010, 100010, true))
+			die("failure: switch_userns");
+
+		snprintf(t_buf, sizeof(t_buf), "getfacl -p %s/%s/%s/%s | grep -q user:%lu:rwx",
+			 t_mountpoint, T_DIR1, DIR1, DIR3, 4294967295LU);
+		if (system(t_buf))
+			die("failure: system");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 100010, 100010, true))
+			die("failure: switch_userns");
+
+		snprintf(t_buf, sizeof(t_buf), "getfacl -p %s/%s/%s/%s | grep -q user:%lu:rwx",
+			 t_mountpoint, T_DIR1, DIR2, DIR3, 100010LU);
+		if (system(t_buf))
+			die("failure: system");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * now, dir is owned by someone else in the user namespace, but we can
+	 * still read it because of acls
+	 */
+	if (fchown(dir1_fd, 100012, 100012)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int fd;
+
+		if (!switch_userns(attr.userns_fd, 100010, 100010, true))
+			die("failure: switch_userns");
+
+		fd = openat(open_tree_fd, DIR3, O_CLOEXEC | O_DIRECTORY);
+		if (fd < 0)
+			die("failure: openat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	/*
+	 * if we delete the acls, the ls should fail because it's 700.
+	 */
+	snprintf(t_buf, sizeof(t_buf), "%s/%s/%s/%s", t_mountpoint, T_DIR1, DIR1, DIR3);
+	if (removexattr(t_buf, "system.posix_acl_access")) {
+		log_stderr("failure: removexattr");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		int fd;
+
+		if (!switch_userns(attr.userns_fd, 100010, 100010, true))
+			die("failure: switch_userns");
+
+		fd = openat(open_tree_fd, DIR3, O_CLOEXEC | O_DIRECTORY);
+		if (fd >= 0)
+			die("failure: openat");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	snprintf(t_buf, sizeof(t_buf), "%s/" T_DIR1 "/" DIR2, t_mountpoint);
+	sys_umount2(t_buf, MNT_DETACH);
+
+	fret = 0;
+out:
+	safe_close(attr.userns_fd);
+	safe_close(dir1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+#ifdef HAVE_LIBURING_H
+static int io_uring_openat_with_creds(struct io_uring *ring, int dfd, const char *path, int cred_id,
+				      bool with_link)
+{
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	int ret, i, to_submit = 1;
+
+	if (with_link) {
+		sqe = io_uring_get_sqe(ring);
+		io_uring_prep_nop(sqe);
+		sqe->flags |= IOSQE_IO_LINK;
+		sqe->user_data = 1;
+		to_submit++;
+	}
+
+	sqe = io_uring_get_sqe(ring);
+	io_uring_prep_openat(sqe, dfd, path, O_RDONLY | O_CLOEXEC, 0);
+	sqe->user_data = 2;
+
+	if (cred_id != -1)
+		sqe->personality = cred_id;
+
+	ret = io_uring_submit(ring);
+	if (ret != to_submit) {
+		log_stderr("failure: io_uring_submit");
+		goto out;
+	}
+
+	for (i = 0; i < to_submit; i++) {
+		ret = io_uring_wait_cqe(ring, &cqe);
+		if (ret < 0) {
+			log_stderr("failure: io_uring_wait_cqe");
+			goto out;
+		}
+
+		ret = cqe->res;
+		io_uring_cqe_seen(ring, cqe);
+	}
+out:
+	return ret;
+}
+
+static int io_uring(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	struct io_uring ring = {};
+	int cred_id, ret;
+	pid_t pid;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret)
+		return log_error_errno(-1, -ret, "failure: io_uring_queue_init");
+
+	ret = io_uring_register_personality(&ring);
+	if (ret < 0)
+		return 0; /* personalities not supported */
+	cred_id = ret;
+
+	/* create file only owner can open */
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0000);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(file1_fd, 0600)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* Verify we can open it with our current credentials. */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, -1, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		/* Verify we can't open it with our current credentials. */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, -1, false);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(1000, 1000))
+			die("failure: switch_ids");
+
+		/* Verify we can open it with the registered credentials. */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, cred_id, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		/*
+		 * Verify we can open it with the registered credentials and as
+		 * a link.
+		 */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, cred_id, true);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	ret = io_uring_unregister_personality(&ring, cred_id);
+	if (ret)
+		log_stderr("failure: io_uring_unregister_personality");
+
+	safe_close(file1_fd);
+
+	return fret;
+}
+
+static int io_uring_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, userns_fd = -EBADF;
+	struct io_uring ring;
+	int cred_id, ret;
+	pid_t pid;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret)
+		return log_error_errno(-1, -ret, "failure: io_uring_queue_init");
+
+	ret = io_uring_register_personality(&ring);
+	if (ret < 0)
+		return 0; /* personalities not supported */
+	cred_id = ret;
+
+	/* create file only owner can open */
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0000);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(file1_fd, 0600)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	userns_fd = get_userns_fd(0, 10000, 10000);
+	if (userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* Verify we can open it with our current credentials. */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, -1, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* Verify we can't open it with our current credentials. */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, -1, false);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* Verify we can open it with the registered credentials. */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, cred_id, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		/*
+		 * Verify we can open it with the registered credentials and as
+		 * a link.
+		 */
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, cred_id, true);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	ret = io_uring_unregister_personality(&ring, cred_id);
+	if (ret)
+		log_stderr("failure: io_uring_unregister_personality");
+
+	safe_close(file1_fd);
+	safe_close(userns_fd);
+
+	return fret;
+}
+
+static int io_uring_idmapped(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct io_uring ring = {};
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	int cred_id, ret;
+	pid_t pid;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret)
+		return log_error_errno(-1, -ret, "failure: io_uring_queue_init");
+
+	ret = io_uring_register_personality(&ring);
+	if (ret < 0)
+		return 0; /* personalities not supported */
+	cred_id = ret;
+
+	/* create file only owner can open */
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0000);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(file1_fd, 0600)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0)
+		return log_errno(-1, "failure: create user namespace");
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0)
+		return log_errno(-1, "failure: create detached mount");
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return log_errno(-1, "failure: set mount attributes");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(10000, 10000))
+			die("failure: switch_ids");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, -1, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(10001, 10001))
+			die("failure: switch_ids");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, true);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	ret = io_uring_unregister_personality(&ring, cred_id);
+	if (ret)
+		log_stderr("failure: io_uring_unregister_personality");
+
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/*
+ * Create an idmapped mount where the we leave the owner of the file unmapped.
+ * In no circumstances, even with recorded credentials can it be allowed to
+ * open the file.
+ */
+static int io_uring_idmapped_unmapped(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct io_uring ring = {};
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	int cred_id, ret;
+	pid_t pid;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret)
+		return log_error_errno(-1, -ret, "failure: io_uring_queue_init");
+
+	ret = io_uring_register_personality(&ring);
+	if (ret < 0)
+		return 0; /* personalities not supported */
+	cred_id = ret;
+
+	/* create file only owner can open */
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0000);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(file1_fd, 0600)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(1, 10000, 10000);
+	if (attr.userns_fd < 0)
+		return log_errno(-1, "failure: create user namespace");
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0)
+		return log_errno(-1, "failure: create detached mount");
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return log_errno(-1, "failure: set mount attributes");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(10000, 10000))
+			die("failure: switch_ids");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, false);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, true);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	ret = io_uring_unregister_personality(&ring, cred_id);
+	if (ret)
+		log_stderr("failure: io_uring_unregister_personality");
+
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int io_uring_idmapped_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct io_uring ring = {};
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	int cred_id, ret;
+	pid_t pid;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret)
+		return log_error_errno(-1, -ret, "failure: io_uring_queue_init");
+
+	ret = io_uring_register_personality(&ring);
+	if (ret < 0)
+		return 0; /* personalities not supported */
+	cred_id = ret;
+
+	/* create file only owner can open */
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0000);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(file1_fd, 0600)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0)
+		return log_errno(-1, "failure: create user namespace");
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0)
+		return log_errno(-1, "failure: create detached mount");
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return log_errno(-1, "failure: set mount attributes");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, -1, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
+			die("failure: switch_userns");
+
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, -1, false);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		file1_fd = io_uring_openat_with_creds(&ring, t_dir1_fd, FILE1, -1, true);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, -1, false);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, -1, true);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, false);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, true);
+		if (file1_fd < 0)
+			die("failure: io_uring_open_file");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	ret = io_uring_unregister_personality(&ring, cred_id);
+	if (ret)
+		log_stderr("failure: io_uring_unregister_personality");
+
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int io_uring_idmapped_unmapped_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct io_uring ring = {};
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	int cred_id, ret;
+	pid_t pid;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret)
+		return log_error_errno(-1, -ret, "failure: io_uring_queue_init");
+
+	ret = io_uring_register_personality(&ring);
+	if (ret < 0)
+		return 0; /* personalities not supported */
+	cred_id = ret;
+
+	/* create file only owner can open */
+	file1_fd = openat(t_dir1_fd, FILE1, O_RDONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0000);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+	if (fchown(file1_fd, 0, 0)) {
+		log_stderr("failure: fchown");
+		goto out;
+	}
+	if (fchmod(file1_fd, 0600)) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+	safe_close(file1_fd);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(1, 10000, 10000);
+	if (attr.userns_fd < 0)
+		return log_errno(-1, "failure: create user namespace");
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0)
+		return log_errno(-1, "failure: create detached mount");
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return log_errno(-1, "failure: set mount attributes");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 10000, 10000, true))
+			die("failure: switch_ids");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, false);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		file1_fd = io_uring_openat_with_creds(&ring, open_tree_fd, FILE1, cred_id, true);
+		if (file1_fd >= 0)
+			die("failure: io_uring_open_file");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid)) {
+		log_stderr("failure: wait_for_pid");
+		goto out;
+	}
+
+	fret = 0;
+out:
+	ret = io_uring_unregister_personality(&ring, cred_id);
+	if (ret)
+		log_stderr("failure: io_uring_unregister_personality");
+
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+#endif
+
+static void usage(void)
+{
+	fprintf(stderr, "Description:\n");
+	fprintf(stderr, "    Run idmapped mount tests\n\n");
+
+	fprintf(stderr, "Arguments:\n");
+	fprintf(stderr, "-d --device        Device used in the tests\n");
+	fprintf(stderr, "-m --mountpoint    Mountpoint of device\n");
+
+	_exit(EXIT_SUCCESS);
+}
+
+static const struct option longopts[] = {
+	{"device",	required_argument,	0,	'd'},
+	{"mountpoint",	required_argument,	0,	'm'},
+	{"help",	no_argument,		0,	'h'},
+	{NULL,		0,			0,	0  },
+};
+
+struct t_idmapped_mounts {
+	int (*test)(void);
+	const char *description;
+} t_idmapped_mounts[] = {
+	{ acls,								"posix acls on regular mounts",								},
+	{ create_in_userns,						"create operations in user namespace",							},
+	{ device_node_in_userns,					"device node in user namespace",							},
+	{ expected_uid_gid_idmapped_mounts,				"expected ownership on idmapped mounts",						},
+	{ fscaps,							"fscaps on regular mounts",								},
+	{ fscaps_idmapped_mounts,					"fscaps on idmapped mounts",								},
+	{ fscaps_idmapped_mounts_in_userns,				"fscaps on idmapped mounts in user namespace",						},
+	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings ",		},
+	{ fsids_mapped,							"mapped fsids",										},
+	{ fsids_unmapped,						"unmapped fsids",									},
+	{ hardlink_crossing_mounts,					"cross mount hardlink",									},
+	{ hardlink_crossing_idmapped_mounts,				"cross idmapped mount hardlink",							},
+	{ hardlink_from_idmapped_mount,					"hardlinks from idmapped mounts",							},
+	{ hardlink_from_idmapped_mount_in_userns,			"hardlinks from idmapped mounts in user namespace",					},
+#ifdef HAVE_LIBURING_H
+	{ io_uring,							"io_uring",										},
+	{ io_uring_userns,						"io_uring in user namespace",								},
+	{ io_uring_idmapped,						"io_uring from idmapped mounts",							},
+	{ io_uring_idmapped_userns,					"io_uring from idmapped mounts in user namespace",					},
+	{ io_uring_idmapped_unmapped,					"io_uring from idmapped mounts with unmapped ids",					},
+	{ io_uring_idmapped_unmapped_userns,				"io_uring from idmapped mounts with unmapped ids in user namespace",			},
+#endif
+	{ protected_symlinks,						"following protected symlinks on regular mounts",					},
+	{ protected_symlinks_idmapped_mounts,				"following protected symlinks on idmapped mounts",					},
+	{ protected_symlinks_idmapped_mounts_in_userns,			"following protected symlinks on idmapped mounts in user namespace",			},
+	{ rename_crossing_mounts,					"cross mount rename",									},
+	{ rename_crossing_idmapped_mounts,				"cross idmapped mount rename",								},
+	{ rename_from_idmapped_mount,					"rename from idmapped mounts",								},
+	{ rename_from_idmapped_mount_in_userns,				"rename from idmapped mounts in user namespace",					},
+	{ symlink_regular_mounts,					"symlink from regular mounts",								},
+	{ symlink_idmapped_mounts,					"symlink from idmapped mounts",								},
+	{ symlink_idmapped_mounts_in_userns,				"symlink from idmapped mounts in user namespace",					},
+	{ setid_binaries,						"setid binaries on regular mounts",							},
+	{ setid_binaries_idmapped_mounts,				"setid binaries on idmapped mounts",							},
+	{ setid_binaries_idmapped_mounts_in_userns,			"setid binaries on idmapped mounts in user namespace",					},
+	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	"setid binaries on idmapped mounts in user namespace with different id mappings",	},
+	{ sticky_bit_unlink,						"sticky bit unlink operations on regular mounts",					},
+	{ sticky_bit_unlink_idmapped_mounts,				"sticky bit unlink operations on idmapped mounts",					},
+	{ sticky_bit_unlink_idmapped_mounts_in_userns,			"sticky bit unlink operations on idmapped mounts in user namespace",			},
+	{ sticky_bit_rename,						"sticky bit rename operations on regular mounts",					},
+	{ sticky_bit_rename_idmapped_mounts,				"sticky bit rename operations on idmapped mounts",					},
+	{ sticky_bit_rename_idmapped_mounts_in_userns,			"sticky bit rename operations on idmapped mounts in user namespace",			},
+};
+
+int main(int argc, char *argv[])
+{
+	int i, fret, ret;
+	int index = 0;
+
+	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
+		switch (ret) {
+		case 'd':
+			t_device = optarg;
+			break;
+		case 'm':
+			t_mountpoint = optarg;
+			break;
+		case 'h':
+			/* fallthrough */
+		default:
+			usage();
+		}
+	}
+
+	if (!t_device)
+		die_errno(EINVAL, "test device missing");
+
+	if (!t_mountpoint)
+		die_errno(EINVAL, "mountpoint of test device missing");
+
+	/* create separate mount namespace */
+	if (unshare(CLONE_NEWNS))
+		die("failure: create new mount namespace");
+
+	/* turn off mount propagation */
+	if (sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
+		die("failure: turn mount propagation off");
+
+	t_mnt_fd = openat(-EBADF, t_mountpoint, O_CLOEXEC | O_DIRECTORY);
+	if (t_mnt_fd < 0)
+		die("failed to open %s", t_mountpoint);
+
+	fret = EXIT_FAILURE;
+	for (i = 0; i < (sizeof(t_idmapped_mounts) / sizeof(t_idmapped_mounts[0])); i++) {
+		struct t_idmapped_mounts *t = &t_idmapped_mounts[i];
+		pid_t pid;
+
+		test_setup();
+
+		pid = fork();
+		if (pid < 0)
+			goto out;
+
+		if (pid == 0) {
+			ret = t->test();
+			if (ret) {
+				fprintf(stderr, "failure: %s\n", t->description);
+				exit(EXIT_FAILURE);
+			}
+
+			exit(EXIT_SUCCESS);
+		}
+
+		ret = wait_for_pid(pid);
+		test_cleanup();
+
+		if (ret)
+			goto out;
+	}
+
+	fret = EXIT_SUCCESS;
+
+out:
+	exit(fret);
+}
diff --git a/src/idmapped-mounts/missing.h b/src/idmapped-mounts/missing.h
new file mode 100644
index 00000000..71a39225
--- /dev/null
+++ b/src/idmapped-mounts/missing.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __IDMAP_MISSING_H
+#define __IDMAP_MISSING_H
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include "../global.h"
+
+#include <errno.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#ifndef __NR_mount_setattr
+	#if defined __alpha__
+		#define __NR_mount_setattr 551
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_mount_setattr 4441
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_mount_setattr 6441
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_mount_setattr 5441
+		#endif
+	#elif defined __ia64__
+		#define __NR_mount_setattr (441 + 1024)
+	#else
+		#define __NR_mount_setattr 441
+	#endif
+#endif
+
+#ifndef __NR_open_tree
+	#if defined __alpha__
+		#define __NR_open_tree 538
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree 4428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree 6428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree 5428
+		#endif
+	#elif defined __ia64__
+		#define __NR_open_tree (428 + 1024)
+	#else
+		#define __NR_open_tree 428
+	#endif
+#endif
+
+#ifndef __NR_move_mount
+	#if defined __alpha__
+		#define __NR_move_mount 539
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_move_mount 4429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_move_mount 6429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_move_mount 5429
+		#endif
+	#elif defined __ia64__
+		#define __NR_move_mount (428 + 1024)
+	#else
+		#define __NR_move_mount 429
+	#endif
+#endif
+
+#ifndef MNT_DETACH
+#define MNT_DETACH 2
+#endif
+
+#ifndef MS_REC
+#define MS_REC 1638
+#endif
+
+#ifndef MS_PRIVATE
+#define MS_PRIVATE (1 << 18)
+#endif
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
+#ifndef MOUNT_ATTR_IDMAP
+#define MOUNT_ATTR_IDMAP 0x00100000
+#endif
+
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE 1
+#endif
+
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC O_CLOEXEC
+#endif
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
+#endif
+
+#ifndef MAKE_PROPAGATION_PRIVATE
+#define MAKE_PROPAGATION_PRIVATE 2
+#endif
+
+#ifndef HAVE_STRUCT_MOUNT_ATTR
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+#endif
+
+static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
+				    struct mount_attr *attr, size_t size)
+{
+	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+}
+
+static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
+				 const char *to_pathname, unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
+}
+
+static inline int sys_mount(const char *source, const char *target, const char *fstype,
+			    unsigned long int flags, const void *data)
+{
+	return syscall(__NR_mount, source, target, fstype, flags, data);
+}
+
+static inline int sys_umount2(const char *path, int flags)
+{
+	return syscall(__NR_umount2, path, flags);
+}
+
+#endif /* __IDMAP_MISSING_H */
diff --git a/src/idmapped-mounts/utils.c b/src/idmapped-mounts/utils.c
new file mode 100644
index 00000000..b27ba445
--- /dev/null
+++ b/src/idmapped-mounts/utils.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "utils.h"
+
+ssize_t read_nointr(int fd, void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = read(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int map_ids(pid_t pid, unsigned long nsid, unsigned long hostid,
+		   unsigned long range)
+{
+	char map[100], procfile[256];
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/uid_map", pid);
+	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
+	if (write_file(procfile, map, strlen(map)))
+		return -1;
+
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/gid_map", pid);
+	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
+	if (write_file(procfile, map, strlen(map)))
+		return -1;
+
+	return 0;
+}
+
+#define __STACK_SIZE (8 * 1024 * 1024)
+pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	void *stack;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#else
+	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#endif
+}
+
+static int get_userns_fd_cb(void *data)
+{
+	return kill(getpid(), SIGSTOP);
+}
+
+int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
+{
+	int ret;
+	pid_t pid;
+	char path[256];
+
+	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER);
+	if (pid < 0)
+		return -errno;
+
+	ret = map_ids(pid, nsid, hostid, range);
+	if (ret < 0)
+		return ret;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	ret = open(path, O_RDONLY | O_CLOEXEC);
+	kill(pid, SIGKILL);
+	wait_for_pid(pid);
+	return ret;
+}
+
+int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
diff --git a/src/idmapped-mounts/utils.h b/src/idmapped-mounts/utils.h
new file mode 100644
index 00000000..93425731
--- /dev/null
+++ b/src/idmapped-mounts/utils.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __IDMAP_UTILS_H
+#define __IDMAP_UTILS_H
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "missing.h"
+
+extern pid_t do_clone(int (*fn)(void *), void *arg, int flags);
+extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
+			 unsigned long range);
+extern ssize_t read_nointr(int fd, void *buf, size_t count);
+extern int wait_for_pid(pid_t pid);
+extern ssize_t write_nointr(int fd, const void *buf, size_t count);
+
+#endif /* __IDMAP_UTILS_H */
diff --git a/tests/generic/618 b/tests/generic/618
new file mode 100755
index 00000000..5ad43690
--- /dev/null
+++ b/tests/generic/618
@@ -0,0 +1,43 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Christian Brauner.  All Rights Reserved.
+#
+# FS QA Test 618
+#
+# Test that idmapped mounts behave correctly.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_idmapped_mounts
+_require_test
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/idmapped-mounts --device "$TEST_DEV" --mount "$TEST_DIR"
+
+status=$?
+exit
diff --git a/tests/generic/618.out b/tests/generic/618.out
new file mode 100644
index 00000000..8940b72f
--- /dev/null
+++ b/tests/generic/618.out
@@ -0,0 +1,2 @@
+QA output created by 618
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 94e860b8..2277505b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -620,3 +620,4 @@
 615 auto rw
 616 auto rw io_uring stress
 617 auto rw io_uring stress
+618 auto rw mount

base-commit: ac23422a8c7d7307287ddb3d97b8818fcb8f8eab
-- 
2.29.2

