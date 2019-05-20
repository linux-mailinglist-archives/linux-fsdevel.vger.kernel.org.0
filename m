Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB323843
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfETNf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 09:35:57 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:10828 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfETNf4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 09:35:56 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C59DBA1156;
        Mon, 20 May 2019 15:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id MekZNDxt4WEW; Mon, 20 May 2019 15:35:47 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RFC v8 10/10] selftests: add resolveat(2) selftests
Date:   Mon, 20 May 2019 23:33:05 +1000
Message-Id: <20190520133305.11925-11-cyphar@cyphar.com>
In-Reply-To: <20190520133305.11925-1-cyphar@cyphar.com>
References: <20190520133305.11925-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test all of the various resolveat(2) flags, as well as how file
descriptor re-opening works. A small stress-test of a symlink-rename
attack is included to show that the protections against ".."-based
attacks are sufficient.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/resolveat/.gitignore  |   1 +
 tools/testing/selftests/resolveat/Makefile    |   6 +
 tools/testing/selftests/resolveat/helpers.h   | 195 +++++++++
 .../selftests/resolveat/linkmode_test.c       | 306 ++++++++++++++
 .../selftests/resolveat/resolveat_test.c      | 400 ++++++++++++++++++
 6 files changed, 909 insertions(+)
 create mode 100644 tools/testing/selftests/resolveat/.gitignore
 create mode 100644 tools/testing/selftests/resolveat/Makefile
 create mode 100644 tools/testing/selftests/resolveat/helpers.h
 create mode 100644 tools/testing/selftests/resolveat/linkmode_test.c
 create mode 100644 tools/testing/selftests/resolveat/resolveat_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 971fc8428117..f558d6f21c4b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -37,6 +37,7 @@ TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += resolveat
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += seccomp
diff --git a/tools/testing/selftests/resolveat/.gitignore b/tools/testing/selftests/resolveat/.gitignore
new file mode 100644
index 000000000000..bd68f6c3fd07
--- /dev/null
+++ b/tools/testing/selftests/resolveat/.gitignore
@@ -0,0 +1 @@
+/*_test
diff --git a/tools/testing/selftests/resolveat/Makefile b/tools/testing/selftests/resolveat/Makefile
new file mode 100644
index 000000000000..375eaf4a55e7
--- /dev/null
+++ b/tools/testing/selftests/resolveat/Makefile
@@ -0,0 +1,6 @@
+CFLAGS += -g -I../../../../usr/include/
+
+TEST_GEN_PROGS := linkmode_test resolveat_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/resolveat/helpers.h b/tools/testing/selftests/resolveat/helpers.h
new file mode 100644
index 000000000000..c765f606cdbc
--- /dev/null
+++ b/tools/testing/selftests/resolveat/helpers.h
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#ifndef __RESOLVEAT_H__
+#define __RESOLVEAT_H__
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <syscall.h>
+#include <limits.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+#define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
+
+#ifndef __NR_resolveat
+#define __NR_resolveat 435
+#define RESOLVE_UPGRADE_NOWRITE	0x002 /* Disallow re-opening for write. */
+#define RESOLVE_UPGRADE_NOREAD	0x004 /* Disallow re-opening for read. */
+#define RESOLVE_NO_FOLLOW	0x008 /* Don't follow trailing symlinks. */
+#define RESOLVE_BENEATH		0x010 /* Block "lexical" trickery like "..", symlinks, absolute paths, etc. */
+#define RESOLVE_XDEV		0x020 /* Block mount-point crossings (includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x040 /* Block procfs-style "magic" symlinks. */
+#define RESOLVE_NO_SYMLINKS	0x080 /* Block all symlinks (implies AT_NO_MAGICLINKS). */
+#define RESOLVE_IN_ROOT		0x100 /* Scope ".." and "/" resolution to dirfd (like chroot(2)). */
+#endif /* __NR_resolveat */
+
+#ifndef O_EMPTYPATH
+#define O_EMPTYPATH 040000000
+#endif /* O_EMPTYPATH */
+
+#define E_func(func, ...)						\
+	do {								\
+		if (func(__VA_ARGS__) < 0)				\
+			ksft_exit_fail_msg("%s:%d %s failed\n", \
+					   __FILE__, __LINE__, #func);\
+	} while (0)
+
+#define E_mkdirat(...)   E_func(mkdirat,   __VA_ARGS__)
+#define E_symlinkat(...) E_func(symlinkat, __VA_ARGS__)
+#define E_touchat(...)   E_func(touchat,   __VA_ARGS__)
+#define E_readlink(...)  E_func(readlink,  __VA_ARGS__)
+#define E_fstatat(...)   E_func(fstatat,   __VA_ARGS__)
+#define E_asprintf(...)  E_func(asprintf,  __VA_ARGS__)
+#define E_fchdir(...)    E_func(fchdir,    __VA_ARGS__)
+#define E_mount(...)     E_func(mount,     __VA_ARGS__)
+#define E_unshare(...)   E_func(unshare,   __VA_ARGS__)
+#define E_setresuid(...) E_func(setresuid, __VA_ARGS__)
+#define E_chmod(...)     E_func(chmod,     __VA_ARGS__)
+
+#define E_assert(expr, msg, ...)					\
+	do {								\
+		if (!(expr))						\
+			ksft_exit_fail_msg("ASSERT(%s:%d) failed (%s): " msg "\n", \
+					   __FILE__, __LINE__, #expr, ##__VA_ARGS__); \
+	} while (0)
+
+typedef int (*openfunc_t)(int dfd, const char *path, unsigned int flags);
+
+static int sys_resolveat(int dfd, const char *path, unsigned int flags)
+{
+	int ret = syscall(__NR_resolveat, dfd, path, flags);
+	return ret >= 0 ? ret : -errno;
+}
+
+static int sys_openat(int dfd, const char *path, unsigned int flags)
+{
+	int ret = openat(dfd, path, flags);
+	return ret >= 0 ? ret : -errno;
+}
+
+static int sys_execveat(int dfd, const char *path,
+			char *const argv[], char *const envp[], int flags)
+{
+	int ret = syscall(SYS_execveat, dfd, path, argv, envp, flags);
+	return ret >= 0 ? ret : -errno;
+}
+
+static char *resolveat_flags(unsigned int flags)
+{
+	char *flagset, *p;
+
+	E_asprintf(&flagset, "%s%s%s%s%s%s%s%s0",
+		   (flags & RESOLVE_UPGRADE_NOWRITE)	? "RESOLVE_UPGRADE_NOWRITE|" : "",
+		   (flags & RESOLVE_UPGRADE_NOREAD)	? "RESOLVE_UPGRADE_NOREAD|" : "",
+		   (flags & RESOLVE_NO_FOLLOW)		? "RESOLVE_NO_FOLLOW|" : "",
+		   (flags & RESOLVE_BENEATH)		? "RESOLVE_BENEATH|" : "",
+		   (flags & RESOLVE_XDEV)		? "RESOLVE_XDEV|" : "",
+		   (flags & RESOLVE_NO_MAGICLINKS)	? "RESOLVE_NO_MAGICLINKS|" : "",
+		   (flags & RESOLVE_NO_SYMLINKS)	? "RESOLVE_NO_SYMLINKS|" : "",
+		   (flags & RESOLVE_IN_ROOT)		? "RESOLVE_IN_ROOT|" : "");
+
+	/* Fix up the trailing |0. */
+	p = strstr(flagset, "|0");
+	if (p)
+		*p = '\0';
+	return flagset;
+}
+
+static char *openat_flags(unsigned int flags)
+{
+	char *flagset;
+	const char *modeflag = "(none)";
+
+	/* Handle the peculiarity of the ACC_MODE flags. */
+	switch (flags & 0x03) {
+		case O_RDWR:
+			modeflag = "O_RDWR";
+			break;
+		case O_RDONLY:
+			modeflag = "O_RDONLY";
+			break;
+		case O_WRONLY:
+			modeflag = "O_WRONLY";
+			break;
+	}
+
+	/* TODO: Add more open flags. */
+	E_asprintf(&flagset, "%s", modeflag);
+	return flagset;
+}
+
+static int touchat(int dfd, const char *path)
+{
+	int fd = openat(dfd, path, O_CREAT);
+	if (fd >= 0)
+		close(fd);
+	return fd;
+}
+
+static char *fdreadlink(int fd)
+{
+	char *target, *tmp;
+
+	E_asprintf(&tmp, "/proc/self/fd/%d", fd);
+
+	target = malloc(PATH_MAX);
+	if (!target)
+		ksft_exit_fail_msg("fdreadlink: malloc failed\n");
+	memset(target, 0, PATH_MAX);
+
+	E_readlink(tmp, target, PATH_MAX);
+	free(tmp);
+	return target;
+}
+
+static bool fdequal(int fd, int dfd, const char *path)
+{
+	char *fdpath, *dfdpath, *other;
+	bool cmp;
+
+	fdpath = fdreadlink(fd);
+	dfdpath = fdreadlink(dfd);
+
+	if (!path)
+		E_asprintf(&other, "%s", dfdpath);
+	else if (*path == '/')
+		E_asprintf(&other, "%s", path);
+	else
+		E_asprintf(&other, "%s/%s", dfdpath, path);
+
+	cmp = !strcmp(fdpath, other);
+	if (!cmp)
+		ksft_print_msg("fdequal: expected '%s' but got '%s'\n", other, fdpath);
+
+	free(fdpath);
+	free(dfdpath);
+	free(other);
+	return cmp;
+}
+
+static void test_resolveat_supported(void)
+{
+	int fd = sys_resolveat(AT_FDCWD, ".", 0);
+	if (fd == -ENOSYS)
+		ksft_exit_skip("resolveat(2) unsupported on this kernel\n");
+	if (fd < 0)
+		ksft_exit_fail_msg("resolveat(2) supported check failed: %s\n", strerror(-fd));
+	close(fd);
+}
+
+#endif /* __RESOLVEAT_H__ */
diff --git a/tools/testing/selftests/resolveat/linkmode_test.c b/tools/testing/selftests/resolveat/linkmode_test.c
new file mode 100644
index 000000000000..b60375099494
--- /dev/null
+++ b/tools/testing/selftests/resolveat/linkmode_test.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <libgen.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <syscall.h>
+#include <limits.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "helpers.h"
+
+static mode_t fdmode(int fd)
+{
+	char *fdpath;
+	struct stat statbuf;
+	mode_t mode;
+
+	E_asprintf(&fdpath, "/proc/self/fd/%d", fd);
+	E_fstatat(AT_FDCWD, fdpath, &statbuf, AT_SYMLINK_NOFOLLOW);
+	mode = (statbuf.st_mode & ~S_IFMT);
+	free(fdpath);
+
+	return mode;
+}
+
+static int reopen_proc(int fd, unsigned int flags)
+{
+	int ret, saved_errno;
+	char *fdpath;
+
+	E_asprintf(&fdpath, "/proc/self/fd/%d", fd);
+	ret = open(fdpath, flags);
+	saved_errno = errno;
+	free(fdpath);
+
+	return ret >= 0 ? ret : -saved_errno;
+}
+
+static int reopen_oemptypath(int fd, unsigned int flags)
+{
+	int ret = openat(fd, "", O_EMPTYPATH | flags);
+	return ret >= 0 ? ret : -errno;
+}
+
+struct reopen_test {
+	openfunc_t open;
+	mode_t chmod_mode;
+	struct {
+		unsigned int flags;
+		mode_t mode;
+		int err;
+	} orig, new;
+};
+
+static bool reopen(int fd, struct reopen_test *test)
+{
+	int newfd;
+	mode_t proc_mode;
+	bool failed = false;
+
+	/* Check that the proc mode is correct. */
+	proc_mode = fdmode(fd);
+	if (proc_mode != test->orig.mode) {
+		ksft_print_msg("incorrect fdmode (got[%o] != want[%o])\n",
+			       proc_mode, test->orig.mode);
+		failed = true;
+	}
+
+	/* Re-open through /proc. */
+	newfd = reopen_proc(fd, test->new.flags);
+	if (newfd != test->new.err && (newfd < 0 || test->new.err < 0)) {
+		ksft_print_msg("/proc failure (%d != %d [%s])\n",
+			       newfd, test->new.err, strerror(-test->new.err));
+		failed = true;
+	}
+	if (newfd >= 0) {
+		proc_mode = fdmode(newfd);
+		if (proc_mode != test->new.mode) {
+			ksft_print_msg("/proc wrong fdmode (got[%o] != want[%o])\n",
+				       proc_mode, test->new.mode);
+			failed = true;
+		}
+		close(newfd);
+	}
+
+	/* Re-open with O_EMPTYPATH. */
+	newfd = reopen_oemptypath(fd, test->new.flags);
+	if (newfd != test->new.err && (newfd < 0 || test->new.err < 0)) {
+		ksft_print_msg("O_EMPTYPATH failure (%d != %d [%s])\n",
+			       newfd, test->new.err, strerror(-test->new.err));
+		failed = true;
+	}
+	if (newfd >= 0) {
+		proc_mode = fdmode(newfd);
+		if (proc_mode != test->new.mode) {
+			ksft_print_msg("O_EMPTYPATH wrong fdmode (got[%o] != want[%o])\n",
+				       proc_mode, test->new.mode);
+			failed = true;
+		}
+		close(newfd);
+	}
+
+	return failed;
+}
+
+void test_reopen_ordinary(bool privileged)
+{
+	int fd;
+	int err_access = privileged ? 0 : -EACCES;
+	char tmpfile[] = "/tmp/reopen-testfile.XXXXXX";
+
+	fd = mkstemp(tmpfile);
+	E_assert(fd >= 0, "mkstemp failed: %m\n");
+	close(fd);
+
+	struct reopen_test tests[] = {
+		/* Re-opening with the same mode should succeed. */
+		{ .open = sys_openat,	  .chmod_mode = 0400,
+		  .orig.flags = O_RDONLY, .orig.mode  = privileged ? 0777 : 0555,
+		  .new.flags  = O_RDONLY, .new.mode   = privileged ? 0777 : 0555},
+		{ .open = sys_openat,	  .chmod_mode = 0200,
+		  .orig.flags = O_WRONLY, .orig.mode  = privileged ? 0777 : 0333,
+		  .new.flags  = O_WRONLY, .new.mode   = privileged ? 0777 : 0333 },
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags =   O_RDWR, .orig.mode  = 0777,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags =   O_RDWR, .orig.mode  = 0777,
+		  .new.flags  = O_RDONLY, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags =   O_RDWR, .orig.mode  = 0777,
+		  .new.flags  = O_WRONLY, .new.mode   = 0777 },
+
+		/*
+		 * Upgrading the mode of a normal file works if the user had the
+		 * required access at original-open time.
+		 */
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags = O_RDONLY, .orig.mode  = 0777,
+		  .new.flags  = O_WRONLY, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags = O_WRONLY, .orig.mode  = 0777,
+		  .new.flags  = O_RDONLY, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags = O_RDONLY, .orig.mode  = 0777,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0600,
+		  .orig.flags = O_WRONLY, .orig.mode  = 0777,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777 },
+
+		/* However, re-open will be blocked given insufficient permissions. */
+		{ .open = sys_openat,	  .chmod_mode = 0400,
+		  .orig.flags = O_RDONLY, .orig.mode  = privileged ? 0777 : 0555,
+		  .new.flags  = O_WRONLY, .new.mode   = 0777, .new.err = err_access },
+		{ .open = sys_openat,	  .chmod_mode = 0200,
+		  .orig.flags = O_WRONLY, .orig.mode  = privileged ? 0777 : 0333,
+		  .new.flags  = O_RDONLY, .new.mode   = 0777, .new.err = err_access },
+		{ .open = sys_openat,	  .chmod_mode = 0400,
+		  .orig.flags = O_RDONLY, .orig.mode  = privileged ? 0777 : 0555,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777, .new.err = err_access },
+		{ .open = sys_openat,	  .chmod_mode = 0200,
+		  .orig.flags = O_WRONLY, .orig.mode  = privileged ? 0777 : 0333,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777, .new.err = err_access },
+
+		/* O_PATH re-opens (of ordinary files) will always work. */
+		{ .open = sys_openat,	  .chmod_mode = 0000,
+		  .orig.flags =   O_PATH, .orig.mode  = 0777,
+		  .new.flags  = O_WRONLY, .new.mode   = 0777 },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags =        0, .orig.mode  = 0777,
+		  .new.flags  = O_WRONLY, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0000,
+		  .orig.flags =   O_PATH, .orig.mode  = 0777,
+		  .new.flags  = O_RDONLY, .new.mode   = 0777 },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags =        0, .orig.mode  = 0777,
+		  .new.flags  = O_RDONLY, .new.mode   = 0777 },
+		{ .open = sys_openat,	  .chmod_mode = 0000,
+		  .orig.flags =   O_PATH, .orig.mode  = 0777,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777 },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags =        0, .orig.mode  = 0777,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777 },
+
+		/*
+		 * resolveat(2) RESOLVE_UPGRADE_NO* flags. In the privileged case, the
+		 * re-open will work but the mode will still be scoped to the mode
+		 * (or'd with the open acc_mode).
+		 */
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOREAD | RESOLVE_UPGRADE_NOWRITE,
+		                          .orig.mode  = 0111,
+		  .new.flags  = O_RDONLY, .new.mode   = 0555, .new.err = err_access },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOREAD | RESOLVE_UPGRADE_NOWRITE,
+		                          .orig.mode  = 0111,
+		  .new.flags  = O_WRONLY, .new.mode   = 0333, .new.err = err_access },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOREAD | RESOLVE_UPGRADE_NOWRITE,
+		                          .orig.mode  = 0111,
+		  .new.flags  =   O_RDWR, .new.mode   = 0777, .new.err = err_access },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOWRITE,
+		                          .orig.mode  = 0555,
+		  .new.flags  = O_RDONLY, .new.mode   = 0555 },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOREAD,
+		                          .orig.mode  = 0333,
+		  .new.flags  = O_WRONLY, .new.mode   = 0333 },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOWRITE,
+		                          .orig.mode  = 0555,
+		  .new.flags  = O_RDONLY, .new.mode   = 0555 },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOREAD,
+		                          .orig.mode  = 0333,
+		  .new.flags  = O_RDONLY, .new.mode   = 0777, .new.err = err_access },
+		{ .open = sys_resolveat,  .chmod_mode = 0000,
+		  .orig.flags = RESOLVE_UPGRADE_NOWRITE,
+		                          .orig.mode  = 0555,
+		  .new.flags  = O_WRONLY, .new.mode   = 0777, .new.err = err_access },
+	};
+
+	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+		int fd;
+		char *orig_flagset, *new_flagset;
+		struct reopen_test *test = &tests[i];
+		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+		E_chmod(tmpfile, test->chmod_mode);
+
+		fd = test->open(AT_FDCWD, tmpfile, test->orig.flags);
+		E_assert(fd >= 0, "open '%s' failed: %m\n", tmpfile);
+
+		/* Make sure that any EACCES we see is not from inode permissions. */
+		E_chmod(tmpfile, 0777);
+
+		if (reopen(fd, test))
+			resultfn = ksft_test_result_fail;
+
+		close(fd);
+
+		new_flagset = openat_flags(test->new.flags);
+		if (test->open == sys_openat)
+			orig_flagset = openat_flags(test->orig.flags);
+		else if (test->open == sys_resolveat)
+			orig_flagset = resolveat_flags(test->orig.flags);
+		else
+			ksft_exit_fail_msg("unknown test->open\n");
+
+		resultfn("%sordinary reopen of (orig[%s]=%s, new=%s) chmod=%.3o %s\n",
+			 privileged ? "privileged " : "",
+			 test->open == sys_openat ? "openat" : "resolveat",
+			 orig_flagset, new_flagset, test->chmod_mode,
+			 test->new.err < 0 ? strerror(-test->new.err) : "works");
+
+		free(new_flagset);
+		free(orig_flagset);
+	}
+
+	unlink(tmpfile);
+}
+
+
+int main(int argc, char **argv)
+{
+	bool privileged;
+
+	ksft_print_header();
+	test_resolveat_supported();
+
+	/*
+	 * Technically we should be checking CAP_DAC_OVERRIDE, but it's easier to
+	 * just assume that euid=0 has the full capability set.
+	 */
+	privileged = (geteuid() == 0);
+	if (!privileged)
+		ksft_test_result_skip("privileged tests require euid == 0\n");
+	else {
+		test_reopen_ordinary(privileged);
+
+		E_setresuid(65534, 65534, 65534);
+		privileged = (geteuid() == 0);
+	}
+
+	test_reopen_ordinary(privileged);
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/resolveat/resolveat_test.c b/tools/testing/selftests/resolveat/resolveat_test.c
new file mode 100644
index 000000000000..72f2e8c5dfe0
--- /dev/null
+++ b/tools/testing/selftests/resolveat/resolveat_test.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <libgen.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <syscall.h>
+#include <limits.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "helpers.h"
+
+/*
+ * Construct a test directory with the following structure:
+ *
+ * root/
+ * |-- procexe -> /proc/self/exe
+ * |-- procroot -> /proc/self/root
+ * |-- root/
+ * |-- mnt/ [mountpoint]
+ * |   |-- self -> ../mnt/
+ * |   `-- absself -> /mnt/
+ * |-- etc/
+ * |   `-- passwd
+ * |-- relsym -> etc/passwd
+ * |-- abssym -> /etc/passwd
+ * |-- abscheeky -> /cheeky
+ * |-- abscheeky -> /cheeky
+ * `-- cheeky/
+ *     |-- absself -> /
+ *     |-- self -> ../../root/
+ *     |-- garbageself -> /../../root/
+ *     |-- passwd -> ../cheeky/../cheeky/../etc/../etc/passwd
+ *     |-- abspasswd -> /../cheeky/../cheeky/../etc/../etc/passwd
+ *     |-- dotdotlink -> ../../../../../../../../../../../../../../etc/passwd
+ *     `-- garbagelink -> /../../../../../../../../../../../../../../etc/passwd
+ */
+int setup_testdir(void)
+{
+	int dfd, tmpfd;
+	char dirname[] = "/tmp/resolveat-testdir.XXXXXX";
+
+	/* Unshare and make /tmp a new directory. */
+	E_unshare(CLONE_NEWNS);
+	E_mount("", "/tmp", "", MS_PRIVATE, "");
+
+	/* Make the top-level directory. */
+	if (!mkdtemp(dirname))
+		ksft_exit_fail_msg("setup_testdir: failed to create tmpdir\n");
+	dfd = open(dirname, O_PATH | O_DIRECTORY);
+	if (dfd < 0)
+		ksft_exit_fail_msg("setup_testdir: failed to open tmpdir\n");
+
+	/* A sub-directory which is actually used for tests. */
+	E_mkdirat(dfd, "root", 0755);
+	tmpfd = openat(dfd, "root", O_PATH | O_DIRECTORY);
+	if (tmpfd < 0)
+		ksft_exit_fail_msg("setup_testdir: failed to open tmpdir\n");
+	close(dfd);
+	dfd = tmpfd;
+
+	E_symlinkat("/proc/self/exe", dfd, "procexe");
+	E_symlinkat("/proc/self/root", dfd, "procroot");
+	E_mkdirat(dfd, "root", 0755);
+
+	/* There is no mountat(2), so use chdir. */
+	E_mkdirat(dfd, "mnt", 0755);
+	E_fchdir(dfd);
+	E_mount("tmpfs", "./mnt", "tmpfs", MS_NOSUID | MS_NODEV, "");
+	E_symlinkat("../mnt/", dfd, "mnt/self");
+	E_symlinkat("/mnt/", dfd, "mnt/absself");
+
+	E_mkdirat(dfd, "etc", 0755);
+	E_touchat(dfd, "etc/passwd");
+
+	E_symlinkat("etc/passwd", dfd, "relsym");
+	E_symlinkat("/etc/passwd", dfd, "abssym");
+	E_symlinkat("/cheeky", dfd, "abscheeky");
+
+	E_mkdirat(dfd, "cheeky", 0755);
+
+	E_symlinkat("/", dfd, "cheeky/absself");
+	E_symlinkat("../../root/", dfd, "cheeky/self");
+	E_symlinkat("/../../root/", dfd, "cheeky/garbageself");
+
+	E_symlinkat("../cheeky/../etc/../etc/passwd", dfd, "cheeky/passwd");
+	E_symlinkat("/../cheeky/../etc/../etc/passwd", dfd, "cheeky/abspasswd");
+
+	E_symlinkat("../../../../../../../../../../../../../../etc/passwd",
+		    dfd, "cheeky/dotdotlink");
+	E_symlinkat("/../../../../../../../../../../../../../../etc/passwd",
+		    dfd, "cheeky/garbagelink");
+
+	return dfd;
+}
+
+struct basic_test {
+	const char *dir;
+	const char *path;
+	unsigned int flags;
+	bool pass;
+	union {
+		int err;
+		const char *path;
+	} out;
+};
+
+void test_resolveat_basic_tests(void)
+{
+	int rootfd;
+	char *procselfexe;
+
+	E_asprintf(&procselfexe, "/proc/%d/exe", getpid());
+	rootfd = setup_testdir();
+
+	struct basic_test tests[] = {
+		/** RESOLVE_BENEATH **/
+		/* Attempts to cross dirfd should be blocked. */
+		{ .path = "/",			.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "cheeky/absself",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abscheeky/absself",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "..",			.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "../root/",		.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "cheeky/self",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abscheeky/self",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "cheeky/garbageself",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abscheeky/garbageself", .flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Only relative paths that stay inside dirfd should work. */
+		{ .path = "root",		.flags = RESOLVE_BENEATH,
+		  .out.path = "root",		.pass = true },
+		{ .path = "etc",		.flags = RESOLVE_BENEATH,
+		  .out.path = "etc",		.pass = true },
+		{ .path = "etc/passwd",		.flags = RESOLVE_BENEATH,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "relsym",		.flags = RESOLVE_BENEATH,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "cheeky/passwd",	.flags = RESOLVE_BENEATH,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "abscheeky/passwd",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abssym",		.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "/etc/passwd",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "cheeky/abspasswd",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abscheeky/abspasswd", .flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Tricky paths should fail. */
+		{ .path = "cheeky/dotdotlink",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abscheeky/dotdotlink", .flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "cheeky/garbagelink",	.flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "abscheeky/garbagelink", .flags = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+
+		/** RESOLVE_IN_ROOT **/
+		/* All attempts to cross the dirfd will be scoped-to-root. */
+		{ .path = "/",			.flags = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .path = "cheeky/absself",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .path = "abscheeky/absself",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .path = "..",			.flags = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .path = "../root/",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .path = "../root/",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .path = "cheeky/self",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .path = "cheeky/garbageself",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .path = "abscheeky/garbageself", .flags = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .path = "root",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .path = "etc",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc",		.pass = true },
+		{ .path = "etc/passwd",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "relsym",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "cheeky/passwd",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "abscheeky/passwd",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "abssym",		.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "/etc/passwd",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "cheeky/abspasswd",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "abscheeky/abspasswd",.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "cheeky/dotdotlink",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "abscheeky/dotdotlink", .flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "/../../../../abscheeky/dotdotlink", .flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "cheeky/garbagelink",	.flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "abscheeky/garbagelink", .flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .path = "/../../../../abscheeky/garbagelink", .flags = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+
+		/** RESOLVE_XDEV **/
+		/* Crossing *down* into a mountpoint is disallowed. */
+		{ .path = "mnt",		.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "mnt/",		.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "mnt/.",		.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Crossing *up* out of a mountpoint is disallowed. */
+		{ .dir = "mnt", .path = ".",	.flags = RESOLVE_XDEV,
+		  .out.path = "mnt",		.pass = true },
+		{ .dir = "mnt", .path = "..",	.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .dir = "mnt", .path = "../mnt", .flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .dir = "mnt", .path = "self",	.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .dir = "mnt", .path = "absself", .flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Jumping to "/" is ok, but later components cannot cross. */
+		{ .dir = "mnt", .path = "/",	.flags = RESOLVE_XDEV,
+		  .out.path = "/",		.pass = true },
+		{ .dir = "/", .path = "/",	.flags = RESOLVE_XDEV,
+		  .out.path = "/",		.pass = true },
+		{ .path = "/proc/1",		.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .path = "/tmp",		.flags = RESOLVE_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+
+		/** RESOLVE_NO_MAGICLINKS **/
+		/* Regular symlinks should work. */
+		{ .path = "relsym",		.flags = RESOLVE_NO_MAGICLINKS,
+		  .out.path = "etc/passwd",	.pass = true },
+		/* Magic-links should not work. */
+		{ .path = "procexe",		.flags = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "/proc/self/exe",	.flags = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "procroot/etc",	.flags = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "/proc/self/root/etc", .flags = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "/proc/self/root/etc", .flags = RESOLVE_NO_MAGICLINKS | RESOLVE_NO_FOLLOW,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "/proc/self/exe",	.flags = RESOLVE_NO_MAGICLINKS | RESOLVE_NO_FOLLOW,
+		  .out.path = procselfexe,	.pass = true },
+
+		/** RESOLVE_NO_SYMLINKS **/
+		/* Normal paths should work. */
+		{ .path = ".",			.flags = RESOLVE_NO_SYMLINKS,
+		  .out.path = NULL,		.pass = true },
+		{ .path = "root",		.flags = RESOLVE_NO_SYMLINKS,
+		  .out.path = "root",		.pass = true },
+		{ .path = "etc",		.flags = RESOLVE_NO_SYMLINKS,
+		  .out.path = "etc",		.pass = true },
+		{ .path = "etc/passwd",		.flags = RESOLVE_NO_SYMLINKS,
+		  .out.path = "etc/passwd",	.pass = true },
+		/* Regular symlinks are blocked. */
+		{ .path = "relsym",		.flags = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "abssym",		.flags = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "cheeky/garbagelink",	.flags = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "abscheeky/garbagelink", .flags = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "abscheeky/absself",	.flags = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		/* Trailing symlinks with NO_FOLLOW. */
+		{ .path = "relsym",		.flags = RESOLVE_NO_SYMLINKS | RESOLVE_NO_FOLLOW,
+		  .out.path = "relsym",		.pass = true },
+		{ .path = "abssym",		.flags = RESOLVE_NO_SYMLINKS | RESOLVE_NO_FOLLOW,
+		  .out.path = "abssym",		.pass = true },
+		{ .path = "cheeky/garbagelink",	.flags = RESOLVE_NO_SYMLINKS | RESOLVE_NO_FOLLOW,
+		  .out.path = "cheeky/garbagelink", .pass = true },
+		{ .path = "abscheeky/garbagelink", .flags = RESOLVE_NO_SYMLINKS | RESOLVE_NO_FOLLOW,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .path = "abscheeky/absself",	.flags = RESOLVE_NO_SYMLINKS | RESOLVE_NO_FOLLOW,
+		  .out.err = -ELOOP,		.pass = false },
+	};
+
+	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+		int dfd, fd;
+		bool failed;
+		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+		struct basic_test *test = &tests[i];
+		char *flagstr = resolveat_flags(test->flags);
+
+		if (test->dir)
+			dfd = openat(rootfd, test->dir, O_PATH | O_DIRECTORY);
+		else
+			dfd = dup(rootfd);
+		if (dfd < 0) {
+			resultfn = ksft_test_result_error;
+			goto next;
+		}
+
+		fd = sys_resolveat(dfd, test->path, test->flags);
+		if (test->pass)
+			failed = (fd < 0 || !fdequal(fd, rootfd, test->out.path));
+		else
+			failed = (fd != test->out.err);
+		if (fd >= 0)
+			close(fd);
+		close(dfd);
+
+		if (failed)
+			resultfn = ksft_test_result_fail;
+
+next:
+		if (test->pass)
+			resultfn("resolveat(root[%s], %s, %s) ==> %s\n",
+				 test->dir ?: ".", test->path, flagstr,
+				 test->out.path ?: ".");
+		else
+			resultfn("resolveat(root[%s], %s, %s) ==> %d (%s)\n",
+				 test->dir ?: ".", test->path, flagstr,
+				 test->out.err, strerror(-test->out.err));
+		free(flagstr);
+	}
+
+	free(procselfexe);
+	close(rootfd);
+}
+
+
+static int proc_exec(int fd)
+{
+	int err, saved_errno;
+	char *procpath;
+	char *argv[] = {"foo", NULL};
+	char *envp[] = {"bar", NULL};
+
+	E_asprintf(&procpath, "/proc/self/fd/%d", fd);
+	err = execve(procpath, argv, envp);
+	saved_errno = errno;
+	free(procpath);
+
+	return err >= 0 ? err : -saved_errno;
+}
+
+static int fd_exec(int fd)
+{
+	char *argv[] = {"foo", NULL};
+	char *envp[] = {"bar", NULL};
+
+	return sys_execveat(fd, "", argv, envp, AT_EMPTY_PATH);
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	test_resolveat_supported();
+
+	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
+	if (geteuid() != 0)
+		ksft_exit_skip("resolveat(2) tests require euid == 0\n");
+
+	test_resolveat_basic_tests();
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
-- 
2.21.0

