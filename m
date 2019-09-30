Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D24C27FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfI3VD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:03:26 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16816 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732008AbfI3VDZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:25 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 231C1A199E;
        Mon, 30 Sep 2019 20:37:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 8TTKbj95OASI; Mon, 30 Sep 2019 20:37:11 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v13 8/9] selftests: add openat2(2) selftests
Date:   Tue,  1 Oct 2019 04:33:15 +1000
Message-Id: <20190930183316.10190-9-cyphar@cyphar.com>
In-Reply-To: <20190930183316.10190-1-cyphar@cyphar.com>
References: <20190930183316.10190-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test all of the various openat2(2) flags, as well as how file
descriptor re-opening works. A small stress-test of a symlink-rename
attack is included to show that the protections against ".."-based
attacks are sufficient. In addition, the memfd selftest is fixed to no
longer depend on the now-disallowed functionality of upgrading an
O_RDONLY descriptor to O_RDWR.

The main things these self-tests are enforcing are:

  * The struct+usize ABI for openat2(2) and copy_struct_from_user() to
    ensure that upgrades will be handled gracefully (in addition,
    ensuring that misaligned structures are also handled correctly).

  * All of the RESOLVE_* semantics (including errno values) are
    correctly handled with various combinations of paths and flags.

  * RESOLVE_IN_ROOT correctly protects against the symlink rename(2)
    attack that has been responsible for several CVEs (and likely will
    be responsible for several more).

  * The magic-link trailing mode semantics correctly block re-opens in
    all of the relevant cases, as well as checking that the "flip-flop"
    attack is correctly protected against.

  * O_PATH has the correct semantics (the mode is g+rwx for ordinary
    files, but for trailing magic-links the mode gets inherited).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/memfd/memfd_test.c    |   7 +-
 tools/testing/selftests/openat2/.gitignore    |   1 +
 tools/testing/selftests/openat2/Makefile      |   8 +
 tools/testing/selftests/openat2/helpers.c     |  98 +++
 tools/testing/selftests/openat2/helpers.h     | 114 ++++
 .../testing/selftests/openat2/linkmode_test.c | 590 ++++++++++++++++++
 .../testing/selftests/openat2/openat2_test.c  | 152 +++++
 .../selftests/openat2/rename_attack_test.c    | 149 +++++
 .../testing/selftests/openat2/resolve_test.c  | 522 ++++++++++++++++
 10 files changed, 1640 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/openat2/.gitignore
 create mode 100644 tools/testing/selftests/openat2/Makefile
 create mode 100644 tools/testing/selftests/openat2/helpers.c
 create mode 100644 tools/testing/selftests/openat2/helpers.h
 create mode 100644 tools/testing/selftests/openat2/linkmode_test.c
 create mode 100644 tools/testing/selftests/openat2/openat2_test.c
 create mode 100644 tools/testing/selftests/openat2/rename_attack_test.c
 create mode 100644 tools/testing/selftests/openat2/resolve_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..7e91d7f03afb 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -37,6 +37,7 @@ TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += openat2
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += seccomp
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index c67d32eeb668..e71df3d3e55d 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -925,7 +925,7 @@ static void test_share_mmap(char *banner, char *b_suffix)
  */
 static void test_share_open(char *banner, char *b_suffix)
 {
-	int fd, fd2;
+	int procfd, fd, fd2;
 
 	printf("%s %s %s\n", memfd_str, banner, b_suffix);
 
@@ -950,13 +950,16 @@ static void test_share_open(char *banner, char *b_suffix)
 	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
 	mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
 
+	/* We cannot do a MAY_WRITE re-open of an O_RDONLY fd. */
+	procfd = mfd_assert_open(fd2, O_PATH, 0);
 	close(fd2);
-	fd2 = mfd_assert_open(fd, O_RDWR, 0);
+	fd2 = mfd_assert_open(procfd, O_WRONLY, 0);
 
 	mfd_assert_add_seals(fd2, F_SEAL_SEAL);
 	mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
 	mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
 
+	close(procfd);
 	close(fd2);
 	close(fd);
 }
diff --git a/tools/testing/selftests/openat2/.gitignore b/tools/testing/selftests/openat2/.gitignore
new file mode 100644
index 000000000000..bd68f6c3fd07
--- /dev/null
+++ b/tools/testing/selftests/openat2/.gitignore
@@ -0,0 +1 @@
+/*_test
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
new file mode 100644
index 000000000000..bd6ce6cfaa59
--- /dev/null
+++ b/tools/testing/selftests/openat2/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+TEST_GEN_PROGS := linkmode_test openat2_test resolve_test rename_attack_test
+
+include ../lib.mk
+
+$(TEST_GEN_PROGS): helpers.c
diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
new file mode 100644
index 000000000000..5a9d6e36357f
--- /dev/null
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <string.h>
+#include <syscall.h>
+#include <limits.h>
+
+#include "helpers.h"
+
+int raw_openat2(int dfd, const char *path, const void *how, size_t size)
+{
+	int ret = syscall(__NR_openat2, dfd, path, how, size);
+	return ret >= 0 ? ret : -errno;
+}
+
+int sys_openat2(int dfd, const char *path, const struct open_how *how)
+{
+	return raw_openat2(dfd, path, how, sizeof(*how));
+}
+
+int sys_openat(int dfd, const char *path, const struct open_how *how)
+{
+	int ret = openat(dfd, path, how->flags, how->mode);
+	return ret >= 0 ? ret : -errno;
+}
+
+int sys_renameat2(int olddirfd, const char *oldpath,
+		  int newdirfd, const char *newpath, unsigned int flags)
+{
+	int ret = syscall(__NR_renameat2, olddirfd, oldpath,
+					  newdirfd, newpath, flags);
+	return ret >= 0 ? ret : -errno;
+}
+
+int touchat(int dfd, const char *path)
+{
+	int fd = openat(dfd, path, O_CREAT);
+	if (fd >= 0)
+		close(fd);
+	return fd;
+}
+
+char *fdreadlink(int fd)
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
+bool fdequal(int fd, int dfd, const char *path)
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
+
+	free(fdpath);
+	free(dfdpath);
+	free(other);
+	return cmp;
+}
+
+void test_openat2_supported(void)
+{
+	struct open_how how = {};
+	int fd = sys_openat2(AT_FDCWD, ".", &how);
+	if (fd == -ENOSYS)
+		ksft_exit_skip("openat2(2) unsupported on this kernel\n");
+	if (fd < 0)
+		ksft_exit_fail_msg("openat2(2) supported check failed: %s\n", strerror(-fd));
+	close(fd);
+}
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
new file mode 100644
index 000000000000..911c6861bf00
--- /dev/null
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -0,0 +1,114 @@
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
+#include <stdint.h>
+#include <errno.h>
+#include "../kselftest.h"
+
+#define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
+#define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
+
+#ifndef SYS_openat2
+#ifndef __NR_openat2
+#define __NR_openat2 437
+#endif /* __NR_openat2 */
+#define SYS_openat2 __NR_openat2
+#endif /* SYS_openat2 */
+
+/*
+ * Arguments for how openat2(2) should open the target path. If @extra is zero,
+ * then openat2 is identical to openat(2). Only one of @mode or @upgrade_mask
+ * may be set at any given time.
+ *
+ * @flags: O_* flags (unknown flags ignored).
+ * @mode: O_CREAT file mode (ignored otherwise).
+ * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored otherwise).
+ * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).
+ */
+struct open_how {
+	uint32_t flags;
+	union {
+		uint16_t mode;
+		uint16_t upgrade_mask;
+	};
+	uint16_t resolve;
+};
+
+#define	OPEN_HOW_SIZE_VER0	8 /* sizeof first published struct */
+
+#ifndef RESOLVE_IN_ROOT
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+#endif /* RESOLVE_IN_ROOT */
+
+#ifndef UPGRADE_NOREAD
+/* how->upgrade flags for openat2(2). */
+/* First bit is reserved for a future UPGRADE_NOEXEC flag. */
+#define UPGRADE_NOREAD		0x02 /* Block re-opening with MAY_READ. */
+#define UPGRADE_NOWRITE		0x04 /* Block re-opening with MAY_WRITE. */
+#endif /* UPGRADE_NOREAD */
+
+#ifndef O_EMPTYPATH
+#define	O_EMPTYPATH 040000000
+#endif /* O_EMPTYPATH */
+
+#define E_func(func, ...)						\
+	do {								\
+		if (func(__VA_ARGS__) < 0)				\
+			ksft_exit_fail_msg("%s:%d %s failed\n", \
+					   __FILE__, __LINE__, #func);\
+	} while (0)
+
+#define E_asprintf(...)		E_func(asprintf,	__VA_ARGS__)
+#define E_chmod(...)		E_func(chmod,		__VA_ARGS__)
+#define E_dup2(...)		E_func(dup2,		__VA_ARGS__)
+#define E_fchdir(...)		E_func(fchdir,		__VA_ARGS__)
+#define E_fstatat(...)		E_func(fstatat,		__VA_ARGS__)
+#define E_kill(...)		E_func(kill,		__VA_ARGS__)
+#define E_mkdirat(...)		E_func(mkdirat,		__VA_ARGS__)
+#define E_mount(...)		E_func(mount,		__VA_ARGS__)
+#define E_prctl(...)		E_func(prctl,		__VA_ARGS__)
+#define E_readlink(...)		E_func(readlink,	__VA_ARGS__)
+#define E_setresuid(...)	E_func(setresuid,	__VA_ARGS__)
+#define E_symlinkat(...)	E_func(symlinkat,	__VA_ARGS__)
+#define E_touchat(...)		E_func(touchat,		__VA_ARGS__)
+#define E_unshare(...)		E_func(unshare,		__VA_ARGS__)
+
+#define E_assert(expr, msg, ...)					\
+	do {								\
+		if (!(expr))						\
+			ksft_exit_fail_msg("ASSERT(%s:%d) failed (%s): " msg "\n", \
+					   __FILE__, __LINE__, #expr, ##__VA_ARGS__); \
+	} while (0)
+
+int raw_openat2(int dfd, const char *path, const void *how, size_t size);
+int sys_openat2(int dfd, const char *path, const struct open_how *how);
+int sys_openat(int dfd, const char *path, const struct open_how *how);
+int sys_renameat2(int olddirfd, const char *oldpath,
+		  int newdirfd, const char *newpath, unsigned int flags);
+
+int touchat(int dfd, const char *path);
+char *fdreadlink(int fd);
+bool fdequal(int fd, int dfd, const char *path);
+
+void test_openat2_supported(void);
+
+#endif /* __RESOLVEAT_H__ */
diff --git a/tools/testing/selftests/openat2/linkmode_test.c b/tools/testing/selftests/openat2/linkmode_test.c
new file mode 100644
index 000000000000..b7337ef2d9a1
--- /dev/null
+++ b/tools/testing/selftests/openat2/linkmode_test.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <string.h>
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
+static int reopen_proc(int fd, struct open_how how)
+{
+	int ret, saved_errno;
+	char *fdpath;
+
+	E_asprintf(&fdpath, "/proc/self/fd/%d", fd);
+	ret = sys_openat2(AT_FDCWD, fdpath, &how);
+	saved_errno = errno;
+	free(fdpath);
+
+	return ret >= 0 ? ret : -saved_errno;
+}
+
+static int reopen_oemptypath(int fd, struct open_how how)
+{
+	int ret;
+
+	how.flags |= O_EMPTYPATH;
+	ret = sys_openat2(fd, "", &how);
+	return ret >= 0 ? ret : -errno;
+}
+
+struct reopen_test {
+	const char *name, *srcpath;
+	bool openat2_only;
+	mode_t chmod_mode;
+	struct {
+		struct open_how how;
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
+	newfd = reopen_proc(fd, test->new.how);
+	if (newfd != test->new.err && (newfd < 0 || test->new.err < 0)) {
+		ksft_print_msg("/proc failure (got[%d] != want[%d] [%s])\n",
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
+	/* Re-open with O_EMPTYPATH -- but O_PATH is not supported. */
+	if (!(test->new.how.flags & O_PATH)) {
+		newfd = reopen_oemptypath(fd, test->new.how);
+		if (newfd != test->new.err && (newfd < 0 || test->new.err < 0)) {
+			ksft_print_msg("O_EMPTYPATH failure (got[%d] != want[%d] [%s])\n",
+				       newfd, test->new.err, strerror(-test->new.err));
+			failed = true;
+		}
+		if (newfd >= 0) {
+			proc_mode = fdmode(newfd);
+			if (proc_mode != test->new.mode) {
+				ksft_print_msg("O_EMPTYPATH wrong fdmode (got[%o] != want[%o])\n",
+					       proc_mode, test->new.mode);
+				failed = true;
+			}
+			close(newfd);
+		}
+	}
+
+	return failed;
+}
+
+#define NUM_REOPEN_ORDINARY_TESTS 44
+
+void test_reopen_ordinary(bool privileged)
+{
+	int fd;
+	int err_access = privileged ? 0 : -EACCES;
+	char tmpfile[] = "/tmp/ksft-openat2-reopen-testfile.XXXXXX";
+
+	fd = mkstemp(tmpfile);
+	E_assert(fd >= 0, "mkstemp failed: %m\n");
+	close(fd);
+
+	struct reopen_test tests[] = {
+		/* Re-opening with the same mode should succeed. */
+		{ .name = "same mode (mode:r old:r new:r)",
+		  .chmod_mode = 0400,
+		  .orig.how.flags = O_RDONLY, .orig.mode  = 0500,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500 },
+		{ .name = "same mode (mode:w old:w new:w)",
+		  .chmod_mode = 0200,
+		  .orig.how.flags = O_WRONLY, .orig.mode  = 0300,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300 },
+		{ .name = "same mode (mode:rw old:rw new:rw)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags =   O_RDWR, .orig.mode  = 0700,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700 },
+		{ .name = "same mode (mode:rw old:rw new:r)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags =   O_RDWR, .orig.mode  = 0700,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500 },
+		{ .name = "same mode (mode:rw old:rw new:w)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags =   O_RDWR, .orig.mode  = 0700,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300 },
+
+		/*
+		 * Re-opening with a different mode will always fail (with an obvious
+		 * carve-out for privileged users).
+		 */
+		{ .name = "different mode (mode:rw old:r new:w)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags = O_RDONLY, .orig.mode  = 0500,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300, .new.err = err_access },
+		{ .name = "different mode (mode:rw old:w new:r)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags = O_WRONLY, .orig.mode  = 0300,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500, .new.err = err_access },
+		{ .name = "different mode (mode:rw old:r new:rw)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags = O_RDONLY, .orig.mode  = 0500,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+		{ .name = "different mode (mode:rw old:w new:rw)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags = O_WRONLY, .orig.mode  = 0300,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+
+		/* Doubly so if they didn't even have permissions at open-time. */
+		{ .name = "different mode (mode:r old:r new:w)",
+		  .chmod_mode = 0400,
+		  .orig.how.flags = O_RDONLY, .orig.mode  = 0500,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300, .new.err = err_access },
+		{ .name = "different mode (mode:w old:w new:r)",
+		  .chmod_mode = 0200,
+		  .orig.how.flags = O_WRONLY, .orig.mode  = 0300,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500, .new.err = err_access },
+		{ .name = "different mode (mode:r old:r new:rw)",
+		  .chmod_mode = 0400,
+		  .orig.how.flags = O_RDONLY, .orig.mode  = 0500,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+		{ .name = "different mode (mode:w old:w new:rw)",
+		  .chmod_mode = 0200,
+		  .orig.how.flags = O_WRONLY, .orig.mode  = 0300,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+
+		/* O_PATH re-opens (of ordinary files) will always work. */
+		{ .name = "O_PATH ordinary file (mode:_ old:RW new:w)",
+		  .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300 },
+		{ .name = "O_PATH ordinary file (mode:_ old:RW new:r)",
+		  .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500 },
+		{ .name = "O_PATH ordinary file (mode:_ old:RW new:rw)",
+		  .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700 },
+
+		/* O_PATH inherits the original magic-link mode. */
+		{ .name = "O_PATH magic-link (mode:rw old:r new:R)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags = O_RDONLY, .orig.mode  = 0500,
+		  .new.how.flags  =   O_PATH, .new.mode   = 0050 },
+		{ .name = "O_PATH magic-link (mode:rw old:w new:W)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags = O_WRONLY, .orig.mode  = 0300,
+		  .new.how.flags  =   O_PATH, .new.mode   = 0030 },
+		{ .name = "O_PATH magic-link (mode:rw old:rw new:RW)",
+		  .chmod_mode = 0600,
+		  .orig.how.flags =   O_RDWR, .orig.mode  = 0700,
+		  .new.how.flags  =   O_PATH, .new.mode   = 0070 },
+
+		/*
+		 * openat2(2) UPGRADE_NO* flags. In the privileged case, the re-open
+		 * will work but the mode will still be scoped to the mode (or'd with
+		 * the open acc_mode).
+		 */
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-RW] new:r)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0010,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD | UPGRADE_NOWRITE,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500, .new.err = err_access },
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-RW] new:w)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0010,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD | UPGRADE_NOWRITE,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300, .new.err = err_access },
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-RW] new:rw)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0010,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD | UPGRADE_NOWRITE,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-W] new:r)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0050,
+		  .orig.how.upgrade_mask = UPGRADE_NOWRITE,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500 },
+
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-R] new:w)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0030,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300 },
+
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-R] new:r)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0030,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500, .new.err = err_access },
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-W] new:w)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0050,
+		  .orig.how.upgrade_mask = UPGRADE_NOWRITE,
+		  .new.how.flags  = O_WRONLY, .new.mode   = 0300, .new.err = err_access },
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-R] new:rw)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0030,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+		{ .name = "O_PATH upgrade mask (mode:_ old:RW[-W] new:rw)",
+		  .openat2_only = true,       .chmod_mode = 0000,
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0050,
+		  .orig.how.upgrade_mask = UPGRADE_NOWRITE,
+		  .new.how.flags  =   O_RDWR, .new.mode   = 0700, .new.err = err_access },
+
+		/*
+		 * O_PATH chained magic-links will inherit the limitations of
+		 * the first magic-link.
+		 *
+		 * TODO: Really this should also be done with /proc/self/fd/.
+		 */
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R new:r)",
+		  .srcpath = "/proc/self/exe",
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0050,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500 },
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R new:R)",
+		  .srcpath = "/proc/self/exe",
+		  .orig.how.flags = O_PATH, .orig.mode  = 0050,
+		  .new.how.flags  = O_PATH, .new.mode   = 0050 },
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R new:w)",
+		  .srcpath = "/proc/self/exe",
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0050,
+		  .new.how.flags  = O_WRONLY, .new.err    = err_access ?: -ETXTBSY },
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R new:rw)",
+		  .srcpath = "/proc/self/exe",
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0050,
+		  .new.how.flags  =   O_RDWR, .new.err    = err_access ?: -ETXTBSY },
+
+		/* O_PATH chained magic-links using UPGRADE_NO* flags. */
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R new:R[-R])",
+		  .srcpath = "/proc/self/exe",
+		  .orig.how.flags = O_PATH, .orig.mode  = 0050,
+		  .new.how.flags  = O_PATH, .new.mode   = 0010,
+		  .new.how.upgrade_mask = UPGRADE_NOREAD },
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R[-R] new:_)",
+		  .openat2_only = true,     .srcpath = "/proc/self/exe",
+		  .orig.how.flags = O_PATH, .orig.mode  = 0010,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  = O_PATH, .new.mode   = 0010},
+		{ .name = "O_PATH chained magic-link of /proc/self/exe (old:R[-R] new:r)",
+		  .openat2_only = true,       .srcpath = "/proc/self/exe",
+		  .orig.how.flags =   O_PATH, .orig.mode  = 0010,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  = O_RDONLY, .new.mode   = 0500, .new.err = err_access },
+
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW new:RW)",
+		  .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  = O_PATH, .new.mode   = 0070 },
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW new:RW[-RW])",
+		  .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  = O_PATH, .new.mode   = 0010,
+		  .new.how.upgrade_mask = UPGRADE_NOREAD | UPGRADE_NOWRITE },
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW new:RW[-R])",
+		  .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  = O_PATH, .new.mode   = 0030,
+		  .new.how.upgrade_mask = UPGRADE_NOREAD },
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW new:RW[-W])",
+		  .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0070,
+		  .new.how.flags  = O_PATH, .new.mode   = 0050,
+		  .new.how.upgrade_mask = UPGRADE_NOWRITE },
+
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW[-RW] new:_)",
+		  .openat2_only = true,     .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0010,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD | UPGRADE_NOWRITE,
+		  .new.how.flags  = O_PATH, .new.mode   = 0010 },
+
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW[-R] new:W)",
+		  .openat2_only = true,     .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0030,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  = O_PATH, .new.mode   = 0030 },
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW[-R] new:W[-W])",
+		  .openat2_only = true,     .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0030,
+		  .orig.how.upgrade_mask = UPGRADE_NOREAD,
+		  .new.how.flags  = O_PATH, .new.mode   = 0010,
+		  .new.how.upgrade_mask = UPGRADE_NOWRITE },
+
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW[-W] new:R)",
+		  .openat2_only = true,     .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0050,
+		  .orig.how.upgrade_mask = UPGRADE_NOWRITE,
+		  .new.how.flags  = O_PATH, .new.mode   = 0050 },
+		{ .name = "O_PATH chained magic-link (mode:_ old:RW[-W] new:R[-R])",
+		  .openat2_only = true,     .chmod_mode = 0000,
+		  .orig.how.flags = O_PATH, .orig.mode  = 0050,
+		  .orig.how.upgrade_mask = UPGRADE_NOWRITE,
+		  .new.how.flags  = O_PATH, .new.mode   = 0010,
+		  .new.how.upgrade_mask = UPGRADE_NOREAD },
+	};
+
+	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_REOPEN_ORDINARY_TESTS);
+
+	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+		int fd;
+		const char *src = tmpfile;
+		struct reopen_test *test = &tests[i];
+		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+		if (test->srcpath)
+			src = test->srcpath;
+
+		if (test->openat2_only)
+			goto openat2;
+
+		if (src == tmpfile)
+			E_chmod(src, test->chmod_mode);
+		fd = sys_openat(AT_FDCWD, src, &test->orig.how);
+		E_assert(fd >= 0, "open '%s' failed: %m\n", src);
+		if (src == tmpfile)
+			E_chmod(src, 0700);
+
+		if (reopen(fd, test)) {
+			resultfn = ksft_test_result_fail;
+			ksft_print_msg("openat reopen failed\n");
+		}
+		close(fd);
+
+openat2:
+		if (src == tmpfile)
+			E_chmod(src, test->chmod_mode);
+		fd = sys_openat2(AT_FDCWD, src, &test->orig.how);
+		E_assert(fd >= 0, "open '%s' failed: %m\n", src);
+		if (src == tmpfile)
+			E_chmod(src, 0700);
+
+		if (reopen(fd, test)) {
+			resultfn = ksft_test_result_fail;
+			ksft_print_msg("openat2 reopen failed\n");
+		}
+		close(fd);
+
+		if (!test->new.err)
+			resultfn("%s%s %s succeeds\n",
+				 privileged ? "privileged " : "",
+				 test->openat2_only ? "openat2" : "openat(+2)",
+				 test->name);
+		else
+			resultfn("%s%s %s fails with %d (%s)\n",
+				 privileged ? "privileged " : "",
+				 test->openat2_only ? "openat2" : "openat(+2)",
+				 test->name, test->new.err,
+				 strerror(-test->new.err));
+		fflush(stdout);
+	}
+
+	unlink(tmpfile);
+}
+
+#define NUM_FLIPFLOP_RACE_TESTS 2
+
+struct flipflop_test {
+	int target_fd, dummy_fd, attacker_fd;
+};
+
+int flipflopper(void *arg)
+{
+	struct flipflop_test *test = arg;
+
+	/* If the parent (the test process) dies, kill ourselves too. */
+	E_prctl(PR_SET_PDEATHSIG, SIGKILL);
+
+	for (;;) {
+		dup2(test->target_fd, test->attacker_fd);
+		dup2(test->dummy_fd, test->attacker_fd);
+	}
+
+	return 1;
+}
+
+#define FLIPFLOP_ROUNDS 500000
+#define STACK_SIZE (1024 * 1024)
+static char flipflop_stack[STACK_SIZE];
+
+void test_reopen_flipflop(void)
+{
+	pid_t child;
+	int procfs_failures = 0, emptypath_failures = 0;
+	struct flipflop_test test = {};
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+	int tmpfd;
+	char tmpfile[] = "/tmp/ksft-openat2-reopen-testfile.XXXXXX";
+
+	tmpfd = mkstemp(tmpfile);
+	E_assert(tmpfd >= 0, "mkstemp failed: %m\n");
+	close(tmpfd);
+
+	test.target_fd = open(tmpfile, O_RDONLY);
+	test.dummy_fd = open("/dev/null", O_RDWR);
+	/* Get an fd to target for the attack. */
+	test.attacker_fd = dup(test.dummy_fd);
+
+	/* We need to share our fdtable with the flipper. */
+	child = clone(flipflopper, flipflop_stack + STACK_SIZE,
+		      CLONE_FILES, &test);
+	E_assert(child >= 0, "clone() failed: %m\n");
+
+	for (int i = 0; i < FLIPFLOP_ROUNDS; i++) {
+		int newfd;
+		struct open_how how = { .flags = O_WRONLY };
+
+		newfd = reopen_proc(test.attacker_fd, how);
+		if (newfd >= 0) {
+			/* Did we open the readonly-fd as O_WRONLY? */
+			if (fdequal(newfd, test.target_fd, NULL))
+				procfs_failures++;
+			close(newfd);
+		}
+
+		newfd = reopen_oemptypath(test.attacker_fd, how);
+		if (newfd >= 0) {
+			/* Did we open the readonly-fd as O_WRONLY? */
+			if (fdequal(newfd, test.target_fd, NULL))
+				emptypath_failures++;
+			close(newfd);
+		}
+	}
+
+	if (procfs_failures + emptypath_failures > 0) {
+		resultfn = ksft_test_result_fail;
+		ksft_print_msg("illegal re-opens: procfs=%d + O_EMPTYPATH=%d\n",
+			       procfs_failures, emptypath_failures);
+	}
+	resultfn("flip-flop reopen attack (%d runs, got %d illegal re-opens)\n",
+		 FLIPFLOP_ROUNDS, procfs_failures + emptypath_failures);
+
+	/* Should be killed anyway, but might as well make sure. */
+	E_kill(child, SIGKILL);
+}
+
+void test_xdev_flipflop(void)
+{
+	pid_t child;
+	int procfs_failures = 0;
+	struct flipflop_test test = {};
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+	int tmpfd;
+	char tmpfile[] = "/tmp/ksft-openat2-xdev-testfile.XXXXXX";
+
+	tmpfd = mkstemp(tmpfile);
+	E_assert(tmpfd >= 0, "mkstemp failed: %m\n");
+	close(tmpfd);
+
+	test.target_fd = open(tmpfile, O_RDONLY);
+	test.dummy_fd = open("/proc", O_RDONLY);
+	/* Get an fd to target for the attack. */
+	test.attacker_fd = dup(test.dummy_fd);
+
+	/* We need to share our fdtable with the flipper. */
+	child = clone(flipflopper, flipflop_stack + STACK_SIZE,
+		      CLONE_FILES, &test);
+	E_assert(child >= 0, "clone() failed: %m\n");
+
+	for (int i = 0; i < FLIPFLOP_ROUNDS; i++) {
+		int newfd;
+		struct open_how how = {
+			.flags = O_RDONLY,
+			.resolve = RESOLVE_NO_XDEV,
+		};
+
+		newfd = reopen_proc(test.attacker_fd, how);
+		if (newfd >= 0) {
+			/* Did we open the readonly-fd as O_WRONLY? */
+			if (fdequal(newfd, test.target_fd, NULL))
+				procfs_failures++;
+			close(newfd);
+		}
+	}
+
+	if (procfs_failures > 0) {
+		resultfn = ksft_test_result_fail;
+		ksft_print_msg("illegal opens: procfs=%d\n", procfs_failures);
+	}
+	resultfn("flip-flop no_xdev attack (%d runs, got %d illegal opens)\n",
+		 FLIPFLOP_ROUNDS, procfs_failures);
+
+	/* Should be killed anyway, but might as well make sure. */
+	E_kill(child, SIGKILL);
+}
+
+#define NUM_TESTS (2 * NUM_REOPEN_ORDINARY_TESTS) + NUM_FLIPFLOP_RACE_TESTS
+
+int main(int argc, char **argv)
+{
+	bool privileged;
+
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+	test_openat2_supported();
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
+	test_reopen_flipflop();
+	test_xdev_flipflop();
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
new file mode 100644
index 000000000000..55d5a14a64b6
--- /dev/null
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include "../kselftest.h"
+#include "helpers.h"
+
+#define NUM_OPENAT2_TESTS 7
+#define NUM_OPENAT2_VARIATIONS 13
+
+struct open_how_ext {
+	struct open_how inner;
+	uint32_t extra1;
+	char pad1[128];
+	uint32_t extra2;
+	char pad2[128];
+	uint32_t extra3;
+};
+
+struct struct_test {
+	const char *name;
+	struct open_how_ext arg;
+	size_t size;
+	int err;
+};
+
+void test_openat2_struct(void)
+{
+	int misalignments[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 17, 87 };
+
+	struct struct_test tests[] = {
+		/* Normal struct. */
+		{ .name = "normal struct",
+		  .arg.inner.flags = O_RDONLY,
+		  .size = sizeof(struct open_how) },
+		/* Bigger struct, with zeroed out end. */
+		{ .name = "bigger struct (zeroed out)",
+		  .arg.inner.flags = O_RDONLY,
+		  .size = sizeof(struct open_how_ext) },
+
+		/* TODO: Once expanded, check zero-padding. */
+
+		/* Smaller than version-0 struct. */
+		{ .name = "zero-sized 'struct'",
+		  .arg.inner.flags = O_RDONLY, .size = 0, .err = -EINVAL },
+		{ .name = "smaller-than-v0 struct",
+		  .arg.inner.flags = O_RDONLY,
+		  .size = OPEN_HOW_SIZE_VER0 - 1, .err = -EINVAL },
+
+		/* Bigger struct, with non-zero trailing bytes. */
+		{ .name = "bigger struct (non-zero data in first 'future field')",
+		  .arg.inner.flags = O_RDONLY, .arg.extra1 = 0xdeadbeef,
+		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
+		{ .name = "bigger struct (non-zero data in middle of 'future fields')",
+		  .arg.inner.flags = O_RDONLY, .arg.extra2 = 0xfeedcafe,
+		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
+		{ .name = "bigger struct (non-zero data at end of 'future fields')",
+		  .arg.inner.flags = O_RDONLY, .arg.extra3 = 0xabad1dea,
+		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
+	};
+
+	BUILD_BUG_ON(ARRAY_LEN(misalignments) != NUM_OPENAT2_VARIATIONS);
+	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_TESTS);
+
+	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+		struct struct_test *test = &tests[i];
+		struct open_how_ext how_ext = test->arg;
+
+		for (int j = 0; j < ARRAY_LEN(misalignments); j++) {
+			int fd, misalign = misalignments[j];
+			char *fdpath = NULL;
+			bool failed;
+			void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+			void *copy = NULL, *how_copy = &how_ext;
+
+			if (misalign) {
+				/*
+				 * Explicitly misalign the structure copying it with the given
+				 * (mis)alignment offset. The other data is set to be non-zero to
+				 * make sure that non-zero bytes outside the struct aren't checked
+				 *
+				 * This is effectively to check that is_zeroed_user() works.
+				 */
+				copy = malloc(misalign + sizeof(how_ext));
+				how_copy = copy + misalign;
+				memset(copy, 0xff, misalign);
+				memcpy(how_copy, &how_ext, sizeof(how_ext));
+			}
+
+			fd = raw_openat2(AT_FDCWD, ".", how_copy, test->size);
+			if (test->err >= 0)
+				failed = (fd < 0);
+			else
+				failed = (fd != test->err);
+			if (fd >= 0) {
+				fdpath = fdreadlink(fd);
+				close(fd);
+			}
+
+			if (failed) {
+				resultfn = ksft_test_result_fail;
+
+				ksft_print_msg("openat2 unexpectedly returned ");
+				if (fdpath)
+					ksft_print_msg("%d['%s']\n", fd, fdpath);
+				else
+					ksft_print_msg("%d (%s)\n", fd, strerror(-fd));
+			}
+
+			if (test->err >= 0)
+				resultfn("openat2 with %s argument [misalign=%d] succeeds\n",
+					 test->name, misalign);
+			else
+				resultfn("openat2 with %s argument [misalign=%d] fails with %d (%s)\n",
+					 test->name, misalign, test->err,
+					 strerror(-test->err));
+
+			free(copy);
+			free(fdpath);
+			fflush(stdout);
+		}
+	}
+}
+
+#define NUM_TESTS (NUM_OPENAT2_VARIATIONS * NUM_OPENAT2_TESTS)
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+
+	test_openat2_supported();
+	test_openat2_struct();
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/openat2/rename_attack_test.c b/tools/testing/selftests/openat2/rename_attack_test.c
new file mode 100644
index 000000000000..baf998f4e67e
--- /dev/null
+++ b/tools/testing/selftests/openat2/rename_attack_test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <signal.h>
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
+/* Construct a test directory with the following structure:
+ *
+ * root/
+ * |-- a/
+ * |   `-- c/
+ * `-- b/
+ */
+int setup_testdir(void)
+{
+	int dfd;
+	char dirname[] = "/tmp/ksft-openat2-rename-attack.XXXXXX";
+
+	/* Make the top-level directory. */
+	if (!mkdtemp(dirname))
+		ksft_exit_fail_msg("setup_testdir: failed to create tmpdir\n");
+	dfd = open(dirname, O_PATH | O_DIRECTORY);
+	if (dfd < 0)
+		ksft_exit_fail_msg("setup_testdir: failed to open tmpdir\n");
+
+	E_mkdirat(dfd, "a", 0755);
+	E_mkdirat(dfd, "b", 0755);
+	E_mkdirat(dfd, "a/c", 0755);
+
+	return dfd;
+}
+
+/* Swap @dirfd/@a and @dirfd/@b constantly. Parent must kill this process. */
+pid_t spawn_attack(int dirfd, char *a, char *b)
+{
+	pid_t child = fork();
+	if (child != 0)
+		return child;
+
+	/* If the parent (the test process) dies, kill ourselves too. */
+	E_prctl(PR_SET_PDEATHSIG, SIGKILL);
+
+	/* Swap @a and @b. */
+	for (;;)
+		renameat2(dirfd, a, dirfd, b, RENAME_EXCHANGE);
+	exit(1);
+}
+
+#define NUM_RENAME_TESTS 2
+#define ROUNDS 400000
+
+const char *flagname(int resolve)
+{
+	switch (resolve) {
+	case RESOLVE_IN_ROOT:
+		return "RESOLVE_IN_ROOT";
+	case RESOLVE_BENEATH:
+		return "RESOLVE_BENEATH";
+	}
+	return "(unknown)";
+}
+
+void test_rename_attack(int resolve)
+{
+	int dfd, afd;
+	pid_t child;
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+	int escapes = 0, other_errs = 0, exdevs = 0, eagains = 0, successes = 0;
+
+	dfd = setup_testdir();
+	afd = openat(dfd, "a", O_PATH);
+	if (afd < 0)
+		ksft_exit_fail_msg("test_rename_attack: failed to open 'a'\n");
+
+	child = spawn_attack(dfd, "a/c", "b");
+
+	for (int i = 0; i < ROUNDS; i++) {
+		int fd;
+		struct open_how how = {
+			.flags = O_PATH,
+			.resolve = resolve,
+		};
+		char *victim_path = "c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../..";
+
+		fd = sys_openat2(afd, victim_path, &how);
+		if (fd < 0) {
+			if (fd == -EAGAIN)
+				eagains++;
+			else if (fd == -EXDEV)
+				exdevs++;
+			else
+				other_errs++; /* unexpected error */
+		} else {
+			if (fdequal(fd, afd, NULL))
+				successes++;
+			else
+				escapes++; /* we got an unexpected fd */
+		}
+		close(fd);
+	}
+
+	if (escapes > 0)
+		resultfn = ksft_test_result_fail;
+	ksft_print_msg("non-escapes: EAGAIN=%d EXDEV=%d E<other>=%d success=%d\n",
+		       eagains, exdevs, other_errs, successes);
+	resultfn("rename attack with %s (%d runs, got %d escapes)\n",
+		 flagname(resolve), ROUNDS, escapes);
+
+	/* Should be killed anyway, but might as well make sure. */
+	E_kill(child, SIGKILL);
+}
+
+#define NUM_TESTS NUM_RENAME_TESTS
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+	test_openat2_supported();
+
+	test_rename_attack(RESOLVE_BENEATH);
+	test_rename_attack(RESOLVE_IN_ROOT);
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
new file mode 100644
index 000000000000..9ed84b2842ba
--- /dev/null
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018-2019 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
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
+ * |-- creatlink -> /newfile3
+ * |-- reletc -> etc/
+ * |-- relsym -> etc/passwd
+ * |-- absetc -> /etc/
+ * |-- abssym -> /etc/passwd
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
+	char dirname[] = "/tmp/ksft-openat2-testdir.XXXXXX";
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
+	E_symlinkat("/newfile3", dfd, "creatlink");
+	E_symlinkat("etc/", dfd, "reletc");
+	E_symlinkat("etc/passwd", dfd, "relsym");
+	E_symlinkat("/etc/", dfd, "absetc");
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
+	const char *name;
+	const char *dir;
+	const char *path;
+	struct open_how how;
+	bool pass;
+	union {
+		int err;
+		const char *path;
+	} out;
+};
+
+#define NUM_OPENAT2_OPATH_TESTS 88
+
+void test_openat2_opath_tests(void)
+{
+	int rootfd, hardcoded_fd;
+	char *procselfexe, *hardcoded_fdpath;
+
+	E_asprintf(&procselfexe, "/proc/%d/exe", getpid());
+	rootfd = setup_testdir();
+
+	hardcoded_fd = open("/dev/null", O_RDONLY);
+	E_assert(hardcoded_fd >= 0, "open fd to hardcode");
+	E_asprintf(&hardcoded_fdpath, "self/fd/%d", hardcoded_fd);
+
+	struct basic_test tests[] = {
+		/** RESOLVE_BENEATH **/
+		/* Attempts to cross dirfd should be blocked. */
+		{ .name = "[beneath] jump to /",
+		  .path = "/",			.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] absolute link to $root",
+		  .path = "cheeky/absself",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] chained absolute links to $root",
+		  .path = "abscheeky/absself",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] jump outside $root",
+		  .path = "..",			.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] temporary jump outside $root",
+		  .path = "../root/",		.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] symlink temporary jump outside $root",
+		  .path = "cheeky/self",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] chained symlink temporary jump outside $root",
+		  .path = "abscheeky/self",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] garbage links to $root",
+		  .path = "cheeky/garbageself",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] chained garbage links to $root",
+		  .path = "abscheeky/garbageself", .how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Only relative paths that stay inside dirfd should work. */
+		{ .name = "[beneath] ordinary path to 'root'",
+		  .path = "root",		.how.resolve = RESOLVE_BENEATH,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[beneath] ordinary path to 'etc'",
+		  .path = "etc",		.how.resolve = RESOLVE_BENEATH,
+		  .out.path = "etc",		.pass = true },
+		{ .name = "[beneath] ordinary path to 'etc/passwd'",
+		  .path = "etc/passwd",		.how.resolve = RESOLVE_BENEATH,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[beneath] relative symlink inside $root",
+		  .path = "relsym",		.how.resolve = RESOLVE_BENEATH,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[beneath] chained-'..' relative symlink inside $root",
+		  .path = "cheeky/passwd",	.how.resolve = RESOLVE_BENEATH,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[beneath] absolute symlink component outside $root",
+		  .path = "abscheeky/passwd",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] absolute symlink target outside $root",
+		  .path = "abssym",		.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] absolute path outside $root",
+		  .path = "/etc/passwd",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] cheeky absolute path outside $root",
+		  .path = "cheeky/abspasswd",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] chained cheeky absolute path outside $root",
+		  .path = "abscheeky/abspasswd", .how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Tricky paths should fail. */
+		{ .name = "[beneath] tricky '..'-chained symlink outside $root",
+		  .path = "cheeky/dotdotlink",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] tricky absolute + '..'-chained symlink outside $root",
+		  .path = "abscheeky/dotdotlink", .how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] tricky garbage link outside $root",
+		  .path = "cheeky/garbagelink",	.how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[beneath] tricky absolute + garbage link outside $root",
+		  .path = "abscheeky/garbagelink", .how.resolve = RESOLVE_BENEATH,
+		  .out.err = -EXDEV,		.pass = false },
+
+		/** RESOLVE_IN_ROOT **/
+		/* All attempts to cross the dirfd will be scoped-to-root. */
+		{ .name = "[in_root] jump to /",
+		  .path = "/",			.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .name = "[in_root] absolute symlink to /root",
+		  .path = "cheeky/absself",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .name = "[in_root] chained absolute symlinks to /root",
+		  .path = "abscheeky/absself",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .name = "[in_root] '..' at root",
+		  .path = "..",			.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = NULL,		.pass = true },
+		{ .name = "[in_root] '../root' at root",
+		  .path = "../root/",		.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[in_root] relative symlink containing '..' above root",
+		  .path = "cheeky/self",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[in_root] garbage link to /root",
+		  .path = "cheeky/garbageself",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[in_root] chainged garbage links to /root",
+		  .path = "abscheeky/garbageself", .how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[in_root] relative path to 'root'",
+		  .path = "root",		.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[in_root] relative path to 'etc'",
+		  .path = "etc",		.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc",		.pass = true },
+		{ .name = "[in_root] relative path to 'etc/passwd'",
+		  .path = "etc/passwd",		.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] relative symlink to 'etc/passwd'",
+		  .path = "relsym",		.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] chained-'..' relative symlink to 'etc/passwd'",
+		  .path = "cheeky/passwd",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] chained-'..' absolute + relative symlink to 'etc/passwd'",
+		  .path = "abscheeky/passwd",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] absolute symlink to 'etc/passwd'",
+		  .path = "abssym",		.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] absolute path 'etc/passwd'",
+		  .path = "/etc/passwd",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] cheeky absolute path 'etc/passwd'",
+		  .path = "cheeky/abspasswd",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] chained cheeky absolute path 'etc/passwd'",
+		  .path = "abscheeky/abspasswd", .how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] tricky '..'-chained symlink outside $root",
+		  .path = "cheeky/dotdotlink",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] tricky absolute + '..'-chained symlink outside $root",
+		  .path = "abscheeky/dotdotlink", .how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] tricky absolute path + absolute + '..'-chained symlink outside $root",
+		  .path = "/../../../../abscheeky/dotdotlink", .how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] tricky garbage link outside $root",
+		  .path = "cheeky/garbagelink",	.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] tricky absolute + garbage link outside $root",
+		  .path = "abscheeky/garbagelink", .how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		{ .name = "[in_root] tricky absolute path + absolute + garbage link outside $root",
+		  .path = "/../../../../abscheeky/garbagelink", .how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "etc/passwd",	.pass = true },
+		/* O_CREAT should handle trailing symlinks correctly. */
+		{ .name = "[in_root] O_CREAT of relative path inside $root",
+		  .path = "newfile1",		.how.flags = O_CREAT,
+						.how.mode = 0700,
+						.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "newfile1",	.pass = true },
+		{ .name = "[in_root] O_CREAT of absolute path",
+		  .path = "/newfile2",		.how.flags = O_CREAT,
+						.how.mode = 0700,
+						.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "newfile2",	.pass = true },
+		{ .name = "[in_root] O_CREAT of tricky symlink outside root",
+		  .path = "/creatlink",		.how.flags = O_CREAT,
+						.how.mode = 0700,
+						.how.resolve = RESOLVE_IN_ROOT,
+		  .out.path = "newfile3",	.pass = true },
+
+		/** RESOLVE_NO_XDEV **/
+		/* Crossing *down* into a mountpoint is disallowed. */
+		{ .name = "[no_xdev] cross into $mnt",
+		  .path = "mnt",		.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[no_xdev] cross into $mnt/",
+		  .path = "mnt/",		.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[no_xdev] cross into $mnt/.",
+		  .path = "mnt/.",		.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Crossing *up* out of a mountpoint is disallowed. */
+		{ .name = "[no_xdev] goto mountpoint root",
+		  .dir = "mnt", .path = ".",	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.path = "mnt",		.pass = true },
+		{ .name = "[no_xdev] cross up through '..'",
+		  .dir = "mnt", .path = "..",	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[no_xdev] temporary cross up through '..'",
+		  .dir = "mnt", .path = "../mnt", .how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[no_xdev] temporary relative symlink cross up",
+		  .dir = "mnt", .path = "self",	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[no_xdev] temporary absolute symlink cross up",
+		  .dir = "mnt", .path = "absself", .how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Jumping to "/" is ok, but later components cannot cross. */
+		{ .name = "[no_xdev] jump to / directly",
+		  .dir = "mnt", .path = "/",	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.path = "/",		.pass = true },
+		{ .name = "[no_xdev] jump to / (from /) directly",
+		  .dir = "/", .path = "/",	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.path = "/",		.pass = true },
+		{ .name = "[no_xdev] jump to / then proc",
+		  .path = "/proc/1",		.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		{ .name = "[no_xdev] jump to / then tmp",
+		  .path = "/tmp",		.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,		.pass = false },
+		/* Magic-links are blocked since they can switch vfsmounts. */
+		{ .name = "[no_xdev] cross through magic-link to self/root",
+		  .dir = "/proc", .path = "self/root", 	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,			.pass = false },
+		{ .name = "[no_xdev] cross through magic-link to self/cwd",
+		  .dir = "/proc", .path = "self/cwd",	.how.resolve = RESOLVE_NO_XDEV,
+		  .out.err = -EXDEV,			.pass = false },
+		/* Except magic-link jumps inside the same vfsmount. */
+		{ .name = "[no_xdev] jump through magic-link to same procfs",
+		  .dir = "/proc", .path = hardcoded_fdpath, .how.resolve = RESOLVE_NO_XDEV,
+		  .out.path = "/proc",			    .pass = true, },
+
+		/** RESOLVE_NO_MAGICLINKS **/
+		/* Regular symlinks should work. */
+		{ .name = "[no_magiclinks] ordinary relative symlink",
+		  .path = "relsym",		.how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.path = "etc/passwd",	.pass = true },
+		/* Magic-links should not work. */
+		{ .name = "[no_magiclinks] symlink to magic-link",
+		  .path = "procexe",		.how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_magiclinks] normal path to magic-link",
+		  .path = "/proc/self/exe",	.how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_magiclinks] normal path to magic-link with O_NOFOLLOW",
+		  .path = "/proc/self/exe",	.how.flags = O_NOFOLLOW,
+						.how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.path = procselfexe,	.pass = true },
+		{ .name = "[no_magiclinks] symlink to magic-link path component",
+		  .path = "procroot/etc",	.how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_magiclinks] magic-link path component",
+		  .path = "/proc/self/root/etc", .how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_magiclinks] magic-link path component with O_NOFOLLOW",
+		  .path = "/proc/self/root/etc", .how.flags = O_NOFOLLOW,
+						 .how.resolve = RESOLVE_NO_MAGICLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+
+		/** RESOLVE_NO_SYMLINKS **/
+		/* Normal paths should work. */
+		{ .name = "[no_symlinks] ordinary path to '.'",
+		  .path = ".",			.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = NULL,		.pass = true },
+		{ .name = "[no_symlinks] ordinary path to 'root'",
+		  .path = "root",		.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = "root",		.pass = true },
+		{ .name = "[no_symlinks] ordinary path to 'etc'",
+		  .path = "etc",		.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = "etc",		.pass = true },
+		{ .name = "[no_symlinks] ordinary path to 'etc/passwd'",
+		  .path = "etc/passwd",		.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = "etc/passwd",	.pass = true },
+		/* Regular symlinks are blocked. */
+		{ .name = "[no_symlinks] relative symlink target",
+		  .path = "relsym",		.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] relative symlink component",
+		  .path = "reletc/passwd",	.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] absolute symlink target",
+		  .path = "abssym",		.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] absolute symlink component",
+		  .path = "absetc/passwd",	.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] cheeky garbage link",
+		  .path = "cheeky/garbagelink",	.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] cheeky absolute + garbage link",
+		  .path = "abscheeky/garbagelink", .how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] cheeky absolute + absolute symlink",
+		  .path = "abscheeky/absself",	.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		/* Trailing symlinks with NO_FOLLOW. */
+		{ .name = "[no_symlinks] relative symlink with O_NOFOLLOW",
+		  .path = "relsym",		.how.flags = O_NOFOLLOW,
+						.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = "relsym",		.pass = true },
+		{ .name = "[no_symlinks] absolute symlink with O_NOFOLLOW",
+		  .path = "abssym",		.how.flags = O_NOFOLLOW,
+						.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = "abssym",		.pass = true },
+		{ .name = "[no_symlinks] trailing symlink with O_NOFOLLOW",
+		  .path = "cheeky/garbagelink",	.how.flags = O_NOFOLLOW,
+						.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.path = "cheeky/garbagelink", .pass = true },
+		{ .name = "[no_symlinks] multiple symlink components with O_NOFOLLOW",
+		  .path = "abscheeky/absself",	.how.flags = O_NOFOLLOW,
+						.how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+		{ .name = "[no_symlinks] multiple symlink (and garbage link) components with O_NOFOLLOW",
+		  .path = "abscheeky/garbagelink", .how.flags = O_NOFOLLOW,
+						   .how.resolve = RESOLVE_NO_SYMLINKS,
+		  .out.err = -ELOOP,		.pass = false },
+	};
+
+	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_OPATH_TESTS);
+
+	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+		int dfd, fd;
+		char *fdpath = NULL;
+		bool failed;
+		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+		struct basic_test *test = &tests[i];
+
+		/* Auto-set O_PATH. */
+		if (!(test->how.flags & O_CREAT))
+			test->how.flags |= O_PATH;
+
+		if (test->dir)
+			dfd = openat(rootfd, test->dir, O_PATH | O_DIRECTORY);
+		else
+			dfd = dup(rootfd);
+		if (dfd < 0) {
+			resultfn = ksft_test_result_error;
+			ksft_print_msg("failed to openat root: %m");
+			goto next;
+		}
+
+		E_dup2(dfd, hardcoded_fd);
+
+		fd = sys_openat2(dfd, test->path, &test->how);
+		if (test->pass)
+			failed = (fd < 0 || !fdequal(fd, rootfd, test->out.path));
+		else
+			failed = (fd != test->out.err);
+		if (fd >= 0) {
+			fdpath = fdreadlink(fd);
+			close(fd);
+		}
+		close(dfd);
+
+		if (failed) {
+			resultfn = ksft_test_result_fail;
+
+			ksft_print_msg("openat2 unexpectedly returned ");
+			if (fdpath)
+				ksft_print_msg("%d['%s']\n", fd, fdpath);
+			else
+				ksft_print_msg("%d (%s)\n", fd, strerror(-fd));
+		}
+
+next:
+		if (test->pass)
+			resultfn("%s gives path '%s'\n", test->name,
+				 test->out.path ?: ".");
+		else
+			resultfn("%s fails with %d (%s)\n", test->name,
+				 test->out.err, strerror(-test->out.err));
+
+		fflush(stdout);
+		free(fdpath);
+	}
+
+	free(procselfexe);
+	close(rootfd);
+
+	free(hardcoded_fdpath);
+	close(hardcoded_fd);
+}
+
+#define NUM_TESTS NUM_OPENAT2_OPATH_TESTS
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+	test_openat2_supported();
+
+	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
+	if (geteuid() != 0)
+		ksft_exit_skip("openat2(2) tests require euid == 0\n");
+
+	test_openat2_opath_tests();
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
-- 
2.23.0

