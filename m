Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3468C570A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 21:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiGKTRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiGKTRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:17:00 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F56EEBC;
        Mon, 11 Jul 2022 12:16:59 -0700 (PDT)
Received: from unless.localdomain (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 776903E950;
        Mon, 11 Jul 2022 19:16:58 +0000 (UTC)
From:   James Yonan <james@openvpn.net>
To:     linux-fsdevel@vger.kernel.org
Cc:     david@fromorbit.com, neilb@suse.de, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        James Yonan <james@openvpn.net>
Subject: [PATCH v4 2/2] selftests: added a new target renameat2
Date:   Mon, 11 Jul 2022 13:13:31 -0600
Message-Id: <20220711191331.2739584-2-james@openvpn.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711191331.2739584-1-james@openvpn.net>
References: <20220702080710.GB3108597@dread.disaster.area>
 <20220711191331.2739584-1-james@openvpn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new renameat2 target tests the new renameat2()
flag RENAME_NEWER_MTIME along with RENAME_NOREPLACE
and RENAME_EXCHANGE.

This test is designed to be portable between
the Linux kernel self-tests and the Linux Test Project.

Signed-off-by: James Yonan <james@openvpn.net>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/renameat2/.gitignore  |   1 +
 tools/testing/selftests/renameat2/Makefile    |  11 +
 .../selftests/renameat2/renameat2_tests.c     | 451 ++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 tools/testing/selftests/renameat2/.gitignore
 create mode 100644 tools/testing/selftests/renameat2/Makefile
 create mode 100644 tools/testing/selftests/renameat2/renameat2_tests.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index de11992dc577..34226dfbca7a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -54,6 +54,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += renameat2
 TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
diff --git a/tools/testing/selftests/renameat2/.gitignore b/tools/testing/selftests/renameat2/.gitignore
new file mode 100644
index 000000000000..79bbdf497559
--- /dev/null
+++ b/tools/testing/selftests/renameat2/.gitignore
@@ -0,0 +1 @@
+renameat2_tests
diff --git a/tools/testing/selftests/renameat2/Makefile b/tools/testing/selftests/renameat2/Makefile
new file mode 100644
index 000000000000..6d5c44906b03
--- /dev/null
+++ b/tools/testing/selftests/renameat2/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = -g -Wall -O2 -pthread
+CFLAGS += $(KHDR_INCLUDES)
+LDLIBS += -lpthread
+
+TEST_GEN_PROGS := renameat2_tests
+
+include ../lib.mk
+
+$(OUTPUT)/renameat2_tests: renameat2_tests.c
diff --git a/tools/testing/selftests/renameat2/renameat2_tests.c b/tools/testing/selftests/renameat2/renameat2_tests.c
new file mode 100644
index 000000000000..bc41975a565f
--- /dev/null
+++ b/tools/testing/selftests/renameat2/renameat2_tests.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Written by James Yonan <james@openvpn.net>
+ * Copyright (c) 2022 OpenVPN, Inc.
+ */
+
+/*
+ * Test renameat2() with RENAME_NOREPLACE, RENAME_EXCHANGE,
+ * and RENAME_NEWER_MTIME.
+ *
+ * This test is designed to be portable between
+ * the Linux kernel self-tests and the Linux Test Project.
+ * The cool thing about running the test in the Linux Test Project
+ * is that it will automatically iterate the test over all the
+ * filesystems available in your kernel.  In a default kernel,
+ * that includes ext2, ext3, ext4, xfs, btrfs, and tmpfs.
+ *
+ * By default we assume a Linux kernel self-test build, where
+ * you can build and run with:
+ *   make -C tools/testing/selftests TARGETS=renameat2 run_tests
+ *
+ * For a Linux Test Project build, place this source file
+ * under the ltp tree in:
+ *   testcases/kernel/syscalls/renameat2/renameat203.c
+ * Then cd to testcases/kernel/syscalls/renameat2 and add:
+ *   CPPFLAGS += -DLINUX_TEST_PROJECT
+ * to the end of the Makefile.  Then run with:
+ *   make && ./rename_newer_mtime
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <time.h>
+
+#ifdef LINUX_TEST_PROJECT
+#include "tst_test.h"
+#include "renameat2.h"
+#else
+#include "../kselftest_harness.h"
+#endif
+
+/* requires a kernel that implements renameat2() RENAME_NEWER_MTIME flag */
+#ifndef RENAME_NEWER_MTIME
+#define RENAME_NEWER_MTIME (1 << 3)
+#endif
+
+/* convert milliseconds to nanoseconds */
+#define MS_TO_NANO(x) ((x) * 1000000)
+
+#ifdef LINUX_TEST_PROJECT
+
+#define MNTPOINT "mntpoint"
+#define WORKDIR MNTPOINT "/testdir.XXXXXX"
+
+#define MY_ERROR(...) tst_brk(TFAIL, __VA_ARGS__)
+#define MY_PASS(...) tst_res(TPASS, __VA_ARGS__)
+
+#else /* Linux kernel self-test */
+
+#define WORKDIR "/tmp/ksft-renameat2-rename-newer-mtime.XXXXXX"
+
+#define MY_ERROR(fmt, ...) ksft_exit_fail_msg("%s/%d: " fmt "\n", __FILE__, __LINE__, __VA_ARGS__)
+#define MY_PASS(...)
+
+#endif
+
+static int create_file_with_timestamp(const char *filename,
+				      const time_t tv_sec,
+				      const long tv_nsec,
+				      struct stat *s,
+				      int *retain_fd)
+{
+	int fd;
+	struct timespec times[2];
+
+	fd = open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0777);
+	if (fd < 0)
+		return errno;
+	times[0].tv_sec = tv_sec;
+	times[0].tv_nsec = tv_nsec;
+	times[1] = times[0];
+	if (futimens(fd, times)) {
+		close(fd);
+		return errno;
+	}
+	if (fstat(fd, s)) {
+		close(fd);
+		return errno;
+	}
+	if (retain_fd)
+		*retain_fd = fd;
+	else if (close(fd))
+		return errno;
+	return 0;
+}
+
+static int create_directory_with_timestamp(const char *dirname,
+					   const time_t tv_sec,
+					   const long tv_nsec,
+					   struct stat *s)
+{
+	struct timespec times[2];
+
+	if (mkdir(dirname, 0777))
+		return errno;
+	times[0].tv_sec = tv_sec;
+	times[0].tv_nsec = tv_nsec;
+	times[1] = times[0];
+	if (utimensat(AT_FDCWD, dirname, times, 0) != 0)
+		return errno;
+	if (lstat(dirname, s))
+		return errno;
+	return 0;
+}
+
+static int do_rename(const char *source_path, const char *target_path,
+		     const unsigned int flags)
+{
+	if (renameat2(AT_FDCWD, source_path, AT_FDCWD, target_path, flags))
+		return errno;
+	return 0;
+}
+
+static int verify_inode(const char *path, const struct stat *orig_stat)
+{
+	struct stat s;
+
+	if (stat(path, &s))
+		return errno;
+	if (orig_stat->st_ino != s.st_ino)
+		return ENOENT;
+	return 0;
+}
+
+static int verify_exist(const char *path)
+{
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return errno;
+	if (close(fd) != 0)
+		return errno;
+	return 0;
+}
+
+static int fd_d = -1; /* retained fd from file "d" */
+
+/*
+ * Test renameat2() with RENAME_NEWER_MTIME, RENAME_NOREPLACE, and RENAME_EXCHANGE.
+ */
+static void do_rename_newer_mtime(void)
+{
+	char dirname[] = WORKDIR;
+	const time_t now = time(NULL);
+	struct stat stat_a, stat_b, stat_c, stat_d, stat_f; /* files */
+	struct stat stat_x, stat_y; /* directories */
+	int eno; /* copied errno */
+
+	/* fd_d initial state */
+	fd_d = -1;
+
+	/* make the top-level directory */
+	if (!mkdtemp(dirname)) {
+		eno = errno;
+		MY_ERROR("failed to create tmpdir, errno=%d", eno);
+	}
+
+	/* cd to top-level directory */
+	if (chdir(dirname)) {
+		eno = errno;
+		MY_ERROR("failed to cd to tmpdir, errno=%d", eno);
+	}
+
+	/* create files with different mtimes */
+	eno = create_file_with_timestamp("a", now, MS_TO_NANO(700), &stat_a, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'a', errno=%d", eno);
+	eno = create_file_with_timestamp("b", now+1, MS_TO_NANO(500), &stat_b, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'b', errno=%d", eno);
+	eno = create_file_with_timestamp("c", now+1, MS_TO_NANO(500), &stat_c, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'c', errno=%d", eno);
+	eno = create_file_with_timestamp("d", now+1, MS_TO_NANO(300), &stat_d, &fd_d); /* leave open for write */
+	if (eno)
+		MY_ERROR("failed to create file 'd', errno=%d", eno);
+	eno = create_file_with_timestamp("f", now, MS_TO_NANO(0), &stat_f, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'f', errno=%d", eno);
+
+	/* create directories with different mtimes */
+	eno = create_directory_with_timestamp("x", now+2, MS_TO_NANO(0), &stat_x);
+	if (eno)
+		MY_ERROR("failed to create directory 'x', errno=%d", eno);
+	eno = create_directory_with_timestamp("y", now+3, MS_TO_NANO(0), &stat_y);
+	if (eno)
+		MY_ERROR("failed to create directory 'y', errno=%d", eno);
+
+	/* rename b -> e with RENAME_NEWER_MTIME -- should succeed because e doesn't exist */
+	eno = do_rename("b", "e", RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("failed to rename 'b' -> 'e', errno=%d (kernel may be missing RENAME_NEWER_MTIME feature)", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		MY_ERROR("could not verify inode of 'e' after rename 'b' -> 'e', errno=%d", eno);
+	eno = verify_exist("b");
+	if (eno != ENOENT)
+		MY_ERROR("strangely, 'b' still exists after rename 'b' -> 'e', errno=%d", eno);
+
+	/* rename c -> e with RENAME_NEWER_MTIME|RENAME_NOREPLACE -- should fail
+	 * because RENAME_NEWER_MTIME and RENAME_NOREPLACE cannot be used together
+	 */
+	eno = do_rename("c", "e", RENAME_NEWER_MTIME|RENAME_NOREPLACE);
+	if (eno != EINVAL)
+		MY_ERROR("rename 'c' -> 'e' should have failed with EINVAL because RENAME_NEWER_MTIME and RENAME_NOREPLACE cannot be used together, errno=%d", eno);
+
+	/* rename c -> e with RENAME_NEWER_MTIME|RENAME_WHITEOUT -- should fail
+	 * because RENAME_NEWER_MTIME and RENAME_WHITEOUT cannot be used together
+	 */
+	eno = do_rename("c", "e", RENAME_NEWER_MTIME|RENAME_WHITEOUT);
+	if (eno != EINVAL)
+		MY_ERROR("rename 'c' -> 'e' should have failed with EINVAL because RENAME_NEWER_MTIME and RENAME_WHITEOUT cannot be used together, errno=%d", eno);
+
+	/* rename c -> e with RENAME_NEWER_MTIME -- should fail because c and e have
+	 * the same timestamp
+	 */
+	eno = do_rename("c", "e", RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("rename 'c' -> 'e' should have failed with EEXIST because 'c' and 'e' have the same timestamp, errno=%d", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'c' after attempted rename 'c' -> 'e', errno=%d", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		MY_ERROR("could not verify inode of 'e' after attempted rename 'c' -> 'e', errno=%d", eno);
+
+	/* rename a -> c with RENAME_NOREPLACE -- should fail because c exists */
+	eno = do_rename("a", "c", RENAME_NOREPLACE);
+	if (eno != EEXIST)
+		MY_ERROR("rename 'a' -> 'c' should have failed because 'c' exists, errno=%d", eno);
+	eno = verify_inode("a", &stat_a);
+	if (eno)
+		MY_ERROR("could not verify inode of 'a' after attempted rename 'a' -> 'c', errno=%d", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'c' after attempted rename 'a' -> 'c', errno=%d", eno);
+
+	/* rename a -> c with RENAME_NEWER_MTIME -- should fail because c is newer than a */
+	eno = do_rename("a", "c", RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("rename 'a' -> 'c' should have failed with EEXIST because 'c' is newer, errno=%d", eno);
+	eno = verify_inode("a", &stat_a);
+	if (eno)
+		MY_ERROR("could not verify inode of 'a' after attempted rename 'a' -> 'c', errno=%d", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'c' after attempted rename 'a' -> 'c', errno=%d", eno);
+
+	/* rename c -> a with RENAME_NEWER_MTIME -- should succeed because c is newer than a */
+	eno = do_rename("c", "a", RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("rename 'c' -> 'a' should have succeeded because 'c' is newer than 'a', errno=%d", eno);
+	eno = verify_inode("a", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'a' after rename 'c' -> 'a', errno=%d", eno);
+	eno = verify_exist("c");
+	if (eno != ENOENT)
+		MY_ERROR("strangely, 'c' still exists after rename 'c' -> 'a', errno=%d", eno);
+
+	/* exchange f <-> nonexistent with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * only f exists
+	 */
+	eno = do_rename("f", "nonexistent", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ENOENT)
+		MY_ERROR("exchange 'f' <-> 'nonexistent' should have failed with ENOENT, errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'f' <-> 'nonexistent', errno=%d", eno);
+
+	/* exchange d <-> f with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * d is open for write
+	 */
+	eno = do_rename("d", "f", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ETXTBSY)
+		MY_ERROR("exchange 'd' <-> 'f' should have failed with ETXTBSY because d is open for write, errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'd' <-> 'f', errno=%d", eno);
+
+	/* exchange e <-> d with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * d is open for write
+	 */
+	eno = do_rename("e", "d", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ETXTBSY)
+		MY_ERROR("exchange 'e' <-> 'd' should have failed with ETXTBSY because d is open for write, errno=%d", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		MY_ERROR("could not verify inode of 'e' after attempted exchange 'e' <-> 'd', errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'e' <-> 'd', errno=%d", eno);
+
+	/* exchange f <-> d with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * d is open for write but also because f is older than d
+	 */
+	eno = do_rename("f", "d", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ETXTBSY) /* note in this case we get ETXTBSY first (EEXIST would have
+			     * been returned if d wasn't open for write)
+			     */
+		MY_ERROR("exchange 'f' <-> 'd' should have failed with ETXTBSY because d is open for write, errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+
+	/* close fd_d */
+	if (close(fd_d) != 0) {
+		eno = errno;
+		MY_ERROR("error closing fd_d (write), errno=%d", eno);
+	}
+
+	/* reopen "d" for read access, which should not prevent RENAME_NEWER_MTIME */
+	fd_d = open("d", O_RDONLY);
+	if (fd_d < 0)
+		MY_ERROR("error reopening 'd' for read, errno=%d", eno);
+
+	/* exchange f <-> d with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail
+	 * because f is older than d
+	 */
+	eno = do_rename("f", "d", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("exchange 'f' <-> 'd' should have failed with EEXIST because f is older than d, errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+
+	/* double exchange f <-> d with RENAME_EXCHANGE -- should succeed */
+	eno = do_rename("f", "d", RENAME_EXCHANGE);
+	if (eno)
+		MY_ERROR("exchange 'f' <-> 'd' should have succeeded, errno=%d", eno);
+	eno = verify_inode("d", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = do_rename("f", "d", RENAME_EXCHANGE);
+	if (eno)
+		MY_ERROR("exchange 'f' <-> 'd' should have succeeded, errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after exchange 'd' <-> 'f', errno=%d", eno);
+
+	/* exchange d <-> f with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should succeed
+	 * because d is newer than f and fd_d is now read-only
+	 */
+	eno = do_rename("d", "f", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("exchange 'd' <-> 'f' failed, errno=%d", eno);
+	eno = verify_inode("d", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after exchange 'd' <-> 'f', errno=%d", eno);
+
+	/* exchange directories x <-> y with RENAME_EXCHANGE|RENAME_NEWER_MTIME
+	 * -- should fail because RENAME_NEWER_MTIME is not implemented
+	 * for directories.
+	 */
+	eno = do_rename("x", "y", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != EISDIR)
+		MY_ERROR("exchange 'x' <-> 'y' should have failed with EISDIR because x and y are directories, errno=%d", eno);
+	eno = verify_inode("x", &stat_x);
+	if (eno)
+		MY_ERROR("could not verify inode of 'x' after attempted exchange 'x' <-> 'y', errno=%d", eno);
+	eno = verify_inode("y", &stat_y);
+	if (eno)
+		MY_ERROR("could not verify inode of 'y' after attempted exchange 'x' <-> 'y', errno=%d", eno);
+
+	/* close fd_d */
+	if (close(fd_d) != 0) {
+		eno = errno;
+		MY_ERROR("error closing fd_d (read), errno=%d", eno);
+	}
+	fd_d = -1;
+
+	MY_PASS("rename_newer_mtime test passed, workdir=%s", dirname);
+}
+
+#ifdef LINUX_TEST_PROJECT
+
+static void setup(void)
+{
+}
+
+static void cleanup(void)
+{
+	/* close fd_d */
+	if (fd_d >= 0)
+		close(fd_d);
+}
+
+static struct tst_test test = {
+	.test_all = do_rename_newer_mtime,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char*[]) {
+		"exfat",
+		"ntfs",
+		"vfat",
+		NULL
+	},
+	.needs_cmds = NULL,
+};
+
+#else /* Linux kernel self-test */
+
+TEST(rename_newer_mtime)
+{
+	do_rename_newer_mtime();
+}
+
+TEST_HARNESS_MAIN
+
+#endif
-- 
2.25.1

