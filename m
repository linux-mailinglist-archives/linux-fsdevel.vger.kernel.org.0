Return-Path: <linux-fsdevel+bounces-4129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47547FCBAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FD41C20F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84644185E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvlKtwju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA474185B;
	Wed, 29 Nov 2023 00:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0181AC433C7;
	Wed, 29 Nov 2023 00:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218257;
	bh=YsPV5/V0usatEtmx3OOF87u1CEwJ7V2A5bFAv2iUvrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvlKtwju6H0WXiuezzJxV8F7E0KLFaj5jP+xUGgDkd7huYalMXpBa+pFC0ii5lYi6
	 4z856MdduXKraQoa+fhEXlbj8uCV1jFynH5MlysNMD4asp1E+wtzvhrzC0Ua+uBJTX
	 Eqg8jxDB4YRwbBPLgGtXJvMB/oTBt99VrCTQEZra8Rnsr3S7T9y0RidyVDqWUQPLA8
	 mSkhLxC8lJv9SrxcnYDLD6jrGR7egFfn8tgywrRnAViTwPMooCut3FthwKLv9pTobn
	 Ok+PV1nG3hFEmWud16d5Jh3gIZ8qdAKwTU1cIQcxP6AgS0rno69Thp0hai1DPYymc2
	 rrIyJr8eP8L3w==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v14 bpf-next 5/6] selftests/bpf: Add tests for filesystem kfuncs
Date: Tue, 28 Nov 2023 16:36:55 -0800
Message-Id: <20231129003656.1165061-6-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129003656.1165061-1-song@kernel.org>
References: <20231129003656.1165061-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for two new filesystem kfuncs:
  1. bpf_get_file_xattr
  2. bpf_get_fsverity_digest

These tests simply make sure the two kfuncs work. Another selftest will be
added to demonstrate how to use these kfuncs to verify file signature.

CONFIG_FS_VERITY is added to selftests config. However, this is not
sufficient to guarantee bpf_get_fsverity_digest works. This is because
fsverity need to be enabled at file system level (for example, with tune2fs
on ext4). If local file system doesn't have this feature enabled, just skip
the test.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 +
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 132 ++++++++++++++++++
 .../selftests/bpf/progs/test_fsverity.c       |  46 ++++++
 .../selftests/bpf/progs/test_get_xattr.c      |  37 +++++
 5 files changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 5ca68ff0b59f..c2c084a44eae 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -55,4 +55,7 @@ void *bpf_cast_to_kern_ctx(void *) __ksym;
 
 void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
 
+extern int bpf_get_file_xattr(struct file *file, const char *name,
+			      struct bpf_dynptr *value_ptr) __ksym;
+extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_ptr) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 782876452acf..c125c441abc7 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -23,6 +23,7 @@ CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_FUNCTION_TRACER=y
+CONFIG_FS_VERITY=y
 CONFIG_GENEVE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
new file mode 100644
index 000000000000..3084872ad1f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <linux/fsverity.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "test_get_xattr.skel.h"
+#include "test_fsverity.skel.h"
+
+static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
+
+static void test_xattr(void)
+{
+	struct test_get_xattr *skel = NULL;
+	int fd = -1, err;
+
+	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+
+	close(fd);
+	fd = -1;
+
+	err = setxattr(testfile, "user.kfuncs", "hello", sizeof("hello"), 0);
+	if (!ASSERT_OK(err, "setxattr"))
+		goto out;
+
+	skel = test_get_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_get_xattr__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_get_xattr__attach(skel);
+
+	if (!ASSERT_OK(err, "test_get_xattr__attach"))
+		goto out;
+
+	fd = open(testfile, O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "open_file"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
+
+out:
+	close(fd);
+	test_get_xattr__destroy(skel);
+	remove(testfile);
+}
+
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE      32
+#endif
+
+static void test_fsverity(void)
+{
+	struct fsverity_enable_arg arg = {0};
+	struct test_fsverity *skel = NULL;
+	struct fsverity_digest *d;
+	int fd, err;
+	char buffer[4096];
+
+	fd = open(testfile, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+
+	/* Write random buffer, so the file is not empty */
+	err = write(fd, buffer, 4096);
+	if (!ASSERT_EQ(err, 4096, "write_file"))
+		goto out;
+	close(fd);
+
+	/* Reopen read-only, otherwise FS_IOC_ENABLE_VERITY will fail */
+	fd = open(testfile, O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "open_file1"))
+		return;
+
+	/* Enable fsverity for the file.
+	 * If the file system doesn't support verity, this will fail. Skip
+	 * the test in such case.
+	 */
+	arg.version = 1;
+	arg.hash_algorithm = FS_VERITY_HASH_ALG_SHA256;
+	arg.block_size = 4096;
+	err = ioctl(fd, FS_IOC_ENABLE_VERITY, &arg);
+	if (err) {
+		printf("%s:SKIP:local fs doesn't support fsverity (%d)\n", __func__, errno);
+		test__skip();
+		goto out;
+	}
+
+	skel = test_fsverity__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_fsverity__open_and_load"))
+		goto out;
+
+	/* Get fsverity_digest from ioctl */
+	d = (struct fsverity_digest *)skel->bss->expected_digest;
+	d->digest_algorithm = FS_VERITY_HASH_ALG_SHA256;
+	d->digest_size = SHA256_DIGEST_SIZE;
+	err = ioctl(fd, FS_IOC_MEASURE_VERITY, skel->bss->expected_digest);
+	if (!ASSERT_OK(err, "ioctl_FS_IOC_MEASURE_VERITY"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_fsverity__attach(skel);
+	if (!ASSERT_OK(err, "test_fsverity__attach"))
+		goto out;
+
+	/* Reopen the file to trigger the program */
+	close(fd);
+	fd = open(testfile, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open_file2"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->got_fsverity, 1, "got_fsverity");
+	ASSERT_EQ(skel->bss->digest_matches, 1, "digest_matches");
+out:
+	close(fd);
+	test_fsverity__destroy(skel);
+	remove(testfile);
+}
+
+void test_fs_kfuncs(void)
+{
+	if (test__start_subtest("xattr"))
+		test_xattr();
+
+	if (test__start_subtest("fsverity"))
+		test_fsverity();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_fsverity.c b/tools/testing/selftests/bpf/progs/test_fsverity.c
new file mode 100644
index 000000000000..ddba2edc8e7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_fsverity.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE      32
+#endif
+
+__u32 monitored_pid;
+char expected_digest[sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
+char digest[sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
+__u32 got_fsverity;
+__u32 digest_matches;
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	struct bpf_dynptr digest_ptr;
+	__u32 pid;
+	int ret;
+	int i;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(digest, sizeof(digest), 0, &digest_ptr);
+	ret = bpf_get_fsverity_digest(f, &digest_ptr);
+	if (ret < 0)
+		return 0;
+	got_fsverity = 1;
+
+	for (i = 0; i < sizeof(digest); i++) {
+		if (digest[i] != expected_digest[i])
+			return 0;
+	}
+
+	digest_matches = 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
new file mode 100644
index 000000000000..7eb2a4e5a3e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+__u32 found_xattr;
+
+static const char expected_value[] = "hello";
+char value[32];
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+	int ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+
+	ret = bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
+	if (ret != sizeof(expected_value))
+		return 0;
+	if (bpf_strncmp(value, ret, expected_value))
+		return 0;
+	found_xattr = 1;
+	return 0;
+}
-- 
2.34.1


