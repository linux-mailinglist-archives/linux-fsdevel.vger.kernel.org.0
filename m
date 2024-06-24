Return-Path: <linux-fsdevel+bounces-22254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992519152E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201C61F22D00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF919D09D;
	Mon, 24 Jun 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="I38biAzu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4019DF47
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244252; cv=none; b=u/kyq9hO63zUtyYpK95P/FsthawdsuPDU7T2/GXCuTVIvgrKSuFRcPdxGxKwGBKhqPK4/KEJ194XrvqZcFHen3gOBNK7cWgwSZUJtEei9IgT3msadrLqYPWeIfBThZVKAtoq1rBfUaMz4JooDDDOcE1Y62J3qGBkVSnxXSAGCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244252; c=relaxed/simple;
	bh=ROqeQc9ShPHVDAu6oiFpoYSzcQGVC5xaqHMOVM0ZNws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfOdXu+ohm0b+zCNZ9ZSFyzdPU/AiW5gVVb+0JrHufZiXHZmybnFiJ/dJMDFEFOfeKRPV9oYffOUKaEBLoLdJObNdpdr9mevC40j2z4zCc/ii2clF9D6jsdJTHYk/sja+iFUx4m1w9srpC6hQ9WoO9eSXILd6nzdHQRti5BiJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=I38biAzu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-63036fa87dbso35772697b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244249; x=1719849049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06G3CQSYHYfgnl56rs4TSRzD4DsDReFJeEA6YjJT7uc=;
        b=I38biAzug67pCXw10OycHVpvhyZq330pDiWja7hcARwPKnlwk4QYi+2SYJVHoTxRIP
         q6SPOUbWF1F+Y0D4eKSrNDemHqasp6UesBYRIhrjPF6CBw+4EU7GOYauMIySnHdGGyhT
         6f80WFdnX5fF/NSnJoPu+Cf2TMq8yrqB5srYzFdBj0K/RcRLUcVn5lo5twnRaSv/ZmyC
         7CMcuOsh1utPewgTyuM5gRRJczbhMf5saIVpp7+LDZnoBR5tZzuWJJFk8HKPz1J9nCFC
         YYeZ23Fqz9ycNRdIskFz3oCuTigf1E8HJZr2ZstnvotnzEalOhDYZSq9Le+j0pJVH3Xy
         8OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244249; x=1719849049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06G3CQSYHYfgnl56rs4TSRzD4DsDReFJeEA6YjJT7uc=;
        b=I7kHR55wpbSGUhlX011Q1ajnpATXCtY7th2zWnhjyCApbcAtvXb8lm/iyUtQSgEriS
         wAuUoyCARboSbM0o1AGcJqa/6aBr6PXT8PXpDt0Do3arB5uhZuJ8DzHFjkYIg77UYVUb
         IMPgEGTMGQGV/xQsYSrENqmk5i+u2r1ML73CPnXFKUvYc6t7KEgHxbHY6L4PEv2wWwZQ
         +ANwKoh2GaHKlp8x1PzhuF4eoYxz+4L5vKb0bgx6GET3ZHvBbyNDuJhYYfiukYFc6EUu
         v8z1cyYpr7Jbc3MrUYkr39of+elEkb+8uFOu+T/jHpoZFCJL2hiWN9Q7DBL/P2FJo8sI
         sS0Q==
X-Gm-Message-State: AOJu0Yyx3DBKjvChgu05fp9sOGkVQeHrx/Qv5yVPvG3InIxA/QUdb4gC
	/1Rwnqxk7NKhkqDFIxxJj99fJ7hsgxKI/q8oaV4YeLVDKgMvie5kmXvAy5vscnLBrm69xLx1xO0
	B
X-Google-Smtp-Source: AGHT+IEU4eMODYn+sarM5XuvZfrUV6l7c/+yqzJNafKiGru23qlClHOvsInEVq+9O19brwPis+7i9g==
X-Received: by 2002:a81:4322:0:b0:622:c70b:ab2b with SMTP id 00721157ae682-6424821b6e8mr34106557b3.2.1719244248086;
        Mon, 24 Jun 2024 08:50:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f11268c35sm29133947b3.24.2024.06.24.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 8/8] selftests: add a test for the foreign mnt ns extensions
Date: Mon, 24 Jun 2024 11:49:51 -0400
Message-ID: <2d1a35bc9ab94b4656c056c420f25e429e7eb0b1.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests both statmount and listmount to make sure they work with the
extensions that allow us to specify a mount ns to enter in order to find
the mount entries.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../selftests/filesystems/statmount/Makefile  |   2 +-
 .../filesystems/statmount/statmount.h         |  46 +++
 .../filesystems/statmount/statmount_test.c    |  53 +--
 .../filesystems/statmount/statmount_test_ns.c | 360 ++++++++++++++++++
 4 files changed, 420 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount.h
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount_test_ns.c

diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
index 07a0d5b545ca..3af3136e35a4 100644
--- a/tools/testing/selftests/filesystems/statmount/Makefile
+++ b/tools/testing/selftests/filesystems/statmount/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
-TEST_GEN_PROGS := statmount_test
+TEST_GEN_PROGS := statmount_test statmount_test_ns
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
new file mode 100644
index 000000000000..f4294bab9d73
--- /dev/null
+++ b/tools/testing/selftests/filesystems/statmount/statmount.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __STATMOUNT_H
+#define __STATMOUNT_H
+
+#include <stdint.h>
+#include <linux/mount.h>
+#include <asm/unistd.h>
+
+static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
+			    struct statmount *buf, size_t bufsize,
+			    unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = mask,
+	};
+
+	if (mnt_ns_id) {
+		req.size = MNT_ID_REQ_SIZE_VER1;
+		req.mnt_ns_id = mnt_ns_id;
+	}
+
+	return syscall(__NR_statmount, &req, buf, bufsize, flags);
+}
+
+static ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
+			 uint64_t last_mnt_id, uint64_t list[], size_t num,
+			 unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = last_mnt_id,
+	};
+
+	if (mnt_ns_id) {
+		req.size = MNT_ID_REQ_SIZE_VER1;
+		req.mnt_ns_id = mnt_ns_id;
+	}
+
+	return syscall(__NR_listmount, &req, list, num, flags);
+}
+
+#endif /* __STATMOUNT_H */
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index e6d7c4f1c85b..4f7023c2de77 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -4,17 +4,15 @@
 
 #include <assert.h>
 #include <stddef.h>
-#include <stdint.h>
 #include <sched.h>
 #include <fcntl.h>
 #include <sys/param.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/statfs.h>
-#include <linux/mount.h>
 #include <linux/stat.h>
-#include <asm/unistd.h>
 
+#include "statmount.h"
 #include "../../kselftest.h"
 
 static const char *const known_fs[] = {
@@ -36,18 +34,6 @@ static const char *const known_fs[] = {
 	"ufs", "v7", "vboxsf", "vfat", "virtiofs", "vxfs", "xenfs", "xfs",
 	"zonefs", NULL };
 
-static int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
-		     size_t bufsize, unsigned int flags)
-{
-	struct mnt_id_req req = {
-		.size = MNT_ID_REQ_SIZE_VER0,
-		.mnt_id = mnt_id,
-		.param = mask,
-	};
-
-	return syscall(__NR_statmount, &req, buf, bufsize, flags);
-}
-
 static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mask, unsigned int flags)
 {
 	size_t bufsize = 1 << 15;
@@ -56,7 +42,7 @@ static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mask, unsigne
 	int ret;
 
 	for (;;) {
-		ret = statmount(mnt_id, mask, tmp, bufsize, flags);
+		ret = statmount(mnt_id, 0, mask, tmp, bufsize, flags);
 		if (ret != -1)
 			break;
 		if (tofree)
@@ -122,7 +108,6 @@ static int orig_root;
 static uint64_t root_id, parent_id;
 static uint32_t old_root_id, old_parent_id;
 
-
 static void cleanup_namespace(void)
 {
 	fchdir(orig_root);
@@ -138,7 +123,7 @@ static void setup_namespace(void)
 	uid_t uid = getuid();
 	gid_t gid = getgid();
 
-	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER);
+	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
 	if (ret == -1)
 		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
 				   strerror(errno));
@@ -208,25 +193,13 @@ static int setup_mount_tree(int log2_num)
 	return 0;
 }
 
-static ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
-			 uint64_t list[], size_t num, unsigned int flags)
-{
-	struct mnt_id_req req = {
-		.size = MNT_ID_REQ_SIZE_VER0,
-		.mnt_id = mnt_id,
-		.param = last_mnt_id,
-	};
-
-	return syscall(__NR_listmount, &req, list, num, flags);
-}
-
 static void test_listmount_empty_root(void)
 {
 	ssize_t res;
 	const unsigned int size = 32;
 	uint64_t list[size];
 
-	res = listmount(LSMT_ROOT, 0, list, size, 0);
+	res = listmount(LSMT_ROOT, 0, 0, list, size, 0);
 	if (res == -1) {
 		ksft_test_result_fail("listmount: %s\n", strerror(errno));
 		return;
@@ -251,7 +224,7 @@ static void test_statmount_zero_mask(void)
 	struct statmount sm;
 	int ret;
 
-	ret = statmount(root_id, 0, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, 0, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount zero mask: %s\n",
 				      strerror(errno));
@@ -277,7 +250,7 @@ static void test_statmount_mnt_basic(void)
 	int ret;
 	uint64_t mask = STATMOUNT_MNT_BASIC;
 
-	ret = statmount(root_id, mask, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, mask, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount mnt basic: %s\n",
 				      strerror(errno));
@@ -337,7 +310,7 @@ static void test_statmount_sb_basic(void)
 	struct statx sx;
 	struct statfs sf;
 
-	ret = statmount(root_id, mask, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, mask, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount sb basic: %s\n",
 				      strerror(errno));
@@ -498,14 +471,14 @@ static void test_statmount_string(uint64_t mask, size_t off, const char *name)
 	exactsize = sm->size;
 	shortsize = sizeof(*sm) + i;
 
-	ret = statmount(root_id, mask, sm, exactsize, 0);
+	ret = statmount(root_id, 0, mask, sm, exactsize, 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount exact size: %s\n",
 				      strerror(errno));
 		goto out;
 	}
 	errno = 0;
-	ret = statmount(root_id, mask, sm, shortsize, 0);
+	ret = statmount(root_id, 0, mask, sm, shortsize, 0);
 	if (ret != -1 || errno != EOVERFLOW) {
 		ksft_test_result_fail("should have failed with EOVERFLOW: %s\n",
 				      strerror(errno));
@@ -533,7 +506,7 @@ static void test_listmount_tree(void)
 	if (res == -1)
 		return;
 
-	num = res = listmount(LSMT_ROOT, 0, list, size, 0);
+	num = res = listmount(LSMT_ROOT, 0, 0, list, size, 0);
 	if (res == -1) {
 		ksft_test_result_fail("listmount: %s\n", strerror(errno));
 		return;
@@ -545,7 +518,7 @@ static void test_listmount_tree(void)
 	}
 
 	for (i = 0; i < size - step;) {
-		res = listmount(LSMT_ROOT, i ? list2[i - 1] : 0, list2 + i, step, 0);
+		res = listmount(LSMT_ROOT, 0, i ? list2[i - 1] : 0, list2 + i, step, 0);
 		if (res == -1)
 			ksft_test_result_fail("short listmount: %s\n",
 					      strerror(errno));
@@ -577,11 +550,11 @@ int main(void)
 	int ret;
 	uint64_t all_mask = STATMOUNT_SB_BASIC | STATMOUNT_MNT_BASIC |
 		STATMOUNT_PROPAGATE_FROM | STATMOUNT_MNT_ROOT |
-		STATMOUNT_MNT_POINT | STATMOUNT_FS_TYPE;
+		STATMOUNT_MNT_POINT | STATMOUNT_FS_TYPE | STATMOUNT_MNT_NS_ID;
 
 	ksft_print_header();
 
-	ret = statmount(0, 0, NULL, 0, 0);
+	ret = statmount(0, 0, 0, NULL, 0, 0);
 	assert(ret == -1);
 	if (errno == ENOSYS)
 		ksft_exit_skip("statmount() syscall not supported\n");
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
new file mode 100644
index 000000000000..145ecb5f3fb2
--- /dev/null
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+
+#include <assert.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <linux/nsfs.h>
+#include <linux/stat.h>
+
+#include "statmount.h"
+#include "../../kselftest.h"
+
+#define NSID_PASS 0
+#define NSID_FAIL 1
+#define NSID_SKIP 2
+#define NSID_ERROR 3
+
+static void handle_result(int ret, const char *testname)
+{
+	if (ret == NSID_PASS)
+		ksft_test_result_pass(testname);
+	else if (ret == NSID_FAIL)
+		ksft_test_result_fail(testname);
+	else if (ret == NSID_ERROR)
+		ksft_exit_fail_msg(testname);
+	else
+		ksft_test_result_skip(testname);
+}
+
+static inline int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
+		return -1;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg(
+		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
+		       WIFSIGNALED(status), WTERMSIG(status));
+		return -1;
+	}
+
+	ret = WEXITSTATUS(status);
+	return ret;
+}
+
+static int get_mnt_ns_id(const char *mnt_ns, uint64_t *mnt_ns_id)
+{
+	int fd = open(mnt_ns, O_RDONLY);
+
+	if (fd < 0) {
+		ksft_print_msg("failed to open for ns %s: %s\n",
+			       mnt_ns, strerror(errno));
+		sleep(60);
+		return NSID_ERROR;
+	}
+
+	if (ioctl(fd, NS_GET_MNTNS_ID, mnt_ns_id) < 0) {
+		ksft_print_msg("failed to get the nsid for ns %s: %s\n",
+			       mnt_ns, strerror(errno));
+		return NSID_ERROR;
+	}
+	close(fd);
+	return NSID_PASS;
+}
+
+static int get_mnt_id(const char *path, uint64_t *mnt_id)
+{
+	struct statx sx;
+	int ret;
+
+	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
+	if (ret == -1) {
+		ksft_print_msg("retrieving unique mount ID for %s: %s\n", path,
+			       strerror(errno));
+		return NSID_ERROR;
+	}
+
+	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE)) {
+		ksft_print_msg("no unique mount ID available for %s\n", path);
+		return NSID_ERROR;
+	}
+
+	*mnt_id = sx.stx_mnt_id;
+	return NSID_PASS;
+}
+
+static int write_file(const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY);
+	size_t len = strlen(val);
+	int ret;
+
+	if (fd == -1) {
+		ksft_print_msg("opening %s for write: %s\n", path, strerror(errno));
+		return NSID_ERROR;
+	}
+
+	ret = write(fd, val, len);
+	if (ret == -1) {
+		ksft_print_msg("writing to %s: %s\n", path, strerror(errno));
+		return NSID_ERROR;
+	}
+	if (ret != len) {
+		ksft_print_msg("short write to %s\n", path);
+		return NSID_ERROR;
+	}
+
+	ret = close(fd);
+	if (ret == -1) {
+		ksft_print_msg("closing %s\n", path);
+		return NSID_ERROR;
+	}
+
+	return NSID_PASS;
+}
+
+static int setup_namespace(void)
+{
+	int ret;
+	char buf[32];
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+
+	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
+	if (ret == -1)
+		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
+				   strerror(errno));
+
+	sprintf(buf, "0 %d 1", uid);
+	ret = write_file("/proc/self/uid_map", buf);
+	if (ret != NSID_PASS)
+		return ret;
+	ret = write_file("/proc/self/setgroups", "deny");
+	if (ret != NSID_PASS)
+		return ret;
+	sprintf(buf, "0 %d 1", gid);
+	ret = write_file("/proc/self/gid_map", buf);
+	if (ret != NSID_PASS)
+		return ret;
+
+	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+	if (ret == -1) {
+		ksft_print_msg("making mount tree private: %s\n",
+			       strerror(errno));
+		return NSID_ERROR;
+	}
+
+	return NSID_PASS;
+}
+
+static int _test_statmount_mnt_ns_id(void)
+{
+	struct statmount sm;
+	uint64_t mnt_ns_id;
+	uint64_t root_id;
+	int ret;
+
+	ret = get_mnt_ns_id("/proc/self/ns/mnt", &mnt_ns_id);
+	if (ret != NSID_PASS)
+		return ret;
+
+	ret = get_mnt_id("/", &root_id);
+	if (ret != NSID_PASS)
+		return ret;
+
+	ret = statmount(root_id, 0, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), 0);
+	if (ret == -1) {
+		ksft_print_msg("statmount mnt ns id: %s\n", strerror(errno));
+		return NSID_ERROR;
+	}
+
+	if (sm.size != sizeof(sm)) {
+		ksft_print_msg("unexpected size: %u != %u\n", sm.size,
+			       (uint32_t)sizeof(sm));
+		return NSID_FAIL;
+	}
+	if (sm.mask != STATMOUNT_MNT_NS_ID) {
+		ksft_print_msg("statmount mnt ns id unavailable\n");
+		return NSID_SKIP;
+	}
+
+	if (sm.mnt_ns_id != mnt_ns_id) {
+		ksft_print_msg("unexpected mnt ns ID: 0x%llx != 0x%llx\n",
+			       (unsigned long long)sm.mnt_ns_id,
+			       (unsigned long long)mnt_ns_id);
+		return NSID_FAIL;
+	}
+
+	return NSID_PASS;
+}
+
+static void test_statmount_mnt_ns_id(void)
+{
+	pid_t pid;
+	int ret;
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_msg("failed to fork: %s\n", strerror(errno));
+
+	/* We're the original pid, wait for the result. */
+	if (pid != 0) {
+		ret = wait_for_pid(pid);
+		handle_result(ret, "test statmount ns id\n");
+		return;
+	}
+
+	ret = setup_namespace();
+	if (ret != NSID_PASS)
+		exit(ret);
+	ret = _test_statmount_mnt_ns_id();
+	exit(ret);
+}
+
+static int validate_external_listmount(pid_t pid, uint64_t child_nr_mounts)
+{
+	uint64_t list[256];
+	uint64_t mnt_ns_id;
+	uint64_t nr_mounts;
+	char buf[256];
+	int ret;
+
+	/* Get the mount ns id for our child. */
+	snprintf(buf, sizeof(buf), "/proc/%lu/ns/mnt", (unsigned long)pid);
+	ret = get_mnt_ns_id(buf, &mnt_ns_id);
+
+	nr_mounts = listmount(LSMT_ROOT, mnt_ns_id, 0, list, 256, 0);
+	if (nr_mounts == (uint64_t)-1) {
+		ksft_print_msg("listmount: %s\n", strerror(errno));
+		return NSID_ERROR;
+	}
+
+	if (nr_mounts != child_nr_mounts) {
+		ksft_print_msg("listmount results is %zi != %zi\n", nr_mounts,
+			       child_nr_mounts);
+		return NSID_FAIL;
+	}
+
+	/* Validate that all of our entries match our mnt_ns_id. */
+	for (int i = 0; i < nr_mounts; i++) {
+		struct statmount sm;
+
+		ret = statmount(list[i], mnt_ns_id, STATMOUNT_MNT_NS_ID, &sm,
+				sizeof(sm), 0);
+		if (ret < 0) {
+			ksft_print_msg("statmount mnt ns id: %s\n", strerror(errno));
+			return NSID_ERROR;
+		}
+
+		if (sm.mask != STATMOUNT_MNT_NS_ID) {
+			ksft_print_msg("statmount mnt ns id unavailable\n");
+			return NSID_SKIP;
+		}
+
+		if (sm.mnt_ns_id != mnt_ns_id) {
+			ksft_print_msg("listmount gave us the wrong ns id: 0x%llx != 0x%llx\n",
+				       (unsigned long long)sm.mnt_ns_id,
+				       (unsigned long long)mnt_ns_id);
+			return NSID_FAIL;
+		}
+	}
+
+	return NSID_PASS;
+}
+
+static void test_listmount_ns(void)
+{
+	uint64_t nr_mounts;
+	char pval;
+	int child_ready_pipe[2];
+	int parent_ready_pipe[2];
+	pid_t pid;
+	int ret, child_ret;
+
+	if (pipe(child_ready_pipe) < 0)
+		ksft_exit_fail_msg("failed to create the child pipe: %s\n",
+				   strerror(errno));
+	if (pipe(parent_ready_pipe) < 0)
+		ksft_exit_fail_msg("failed to create the parent pipe: %s\n",
+				   strerror(errno));
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_msg("failed to fork: %s\n", strerror(errno));
+
+	if (pid == 0) {
+		char cval;
+		uint64_t list[256];
+
+		close(child_ready_pipe[0]);
+		close(parent_ready_pipe[1]);
+
+		ret = setup_namespace();
+		if (ret != NSID_PASS)
+			exit(ret);
+
+		nr_mounts = listmount(LSMT_ROOT, 0, 0, list, 256, 0);
+		if (nr_mounts == (uint64_t)-1) {
+			ksft_print_msg("listmount: %s\n", strerror(errno));
+			exit(NSID_FAIL);
+		}
+
+		/*
+		 * Tell our parent how many mounts we have, and then wait for it
+		 * to tell us we're done.
+		 */
+		write(child_ready_pipe[1], &nr_mounts, sizeof(nr_mounts));
+		read(parent_ready_pipe[0], &cval, sizeof(cval));
+		exit(NSID_PASS);
+	}
+
+	close(child_ready_pipe[1]);
+	close(parent_ready_pipe[0]);
+
+	/* Wait until the child has created everything. */
+	read(child_ready_pipe[0], &nr_mounts, sizeof(nr_mounts));
+
+	ret = validate_external_listmount(pid, nr_mounts);
+
+	write(parent_ready_pipe[1], &pval, sizeof(pval));
+	child_ret = wait_for_pid(pid);
+	if (child_ret != NSID_PASS)
+		ret = child_ret;
+	handle_result(ret, "test listmount ns id\n");
+}
+
+int main(void)
+{
+	int ret;
+
+	ksft_print_header();
+	ret = statmount(0, 0, 0, NULL, 0, 0);
+	assert(ret == -1);
+	if (errno == ENOSYS)
+		ksft_exit_skip("statmount() syscall not supported\n");
+
+	ksft_set_plan(2);
+	test_statmount_mnt_ns_id();
+	test_listmount_ns();
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
-- 
2.43.0


