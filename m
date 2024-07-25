Return-Path: <linux-fsdevel+bounces-24283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5216393CB5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 01:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B931C21042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 23:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565014A0A2;
	Thu, 25 Jul 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqXj1E3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6E1448EF;
	Thu, 25 Jul 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951253; cv=none; b=PFvTwNU+v22C4ZQd6GaYxZ+zdZSa/tJwfCSiusU5YlHllUmr7x6JyW/HyOISKcKb+GZkKgoiR4OZSeWqNwNM2PZKwK22DIKdrBEaflyZmVDSvwTxerydvRo1x0KhUWCnC0LUDEwIcnLWuFrvut8G5IS8FuIpmiGC3aCHeqWcPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951253; c=relaxed/simple;
	bh=PUgjQxlKWaIMqyGx3fXaZXi8AHfHJ5blsyfSLofmLmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBIAVrlXkNHXifm/HF2FHNqOHDghDdUX5wkPyDFzBPaErxWbAKtE6wSJ4RsQbTDO2GRIWHFyjFqWxz5Z1jD2iNCkBqkNZl//AsLEtJrqOAQtsa0GoI1waMNrJNYI7q0CV1T5prImWTWCjdnGqK1PGGSqRQYBKdSTmzqoLbz/yxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqXj1E3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D644CC116B1;
	Thu, 25 Jul 2024 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721951253;
	bh=PUgjQxlKWaIMqyGx3fXaZXi8AHfHJ5blsyfSLofmLmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqXj1E3D1YE5rgAvYstkrGs85MXZah8kIjgzJRDRuQS5jDD/i4oV4b7Swsotj9jxR
	 CX/3I7rIpjUWIubBmAw4Oe+kGZjA3eHyr19dd6IYtkVF61LBDsmldFtqWzuEqmD+fT
	 nMjvgeOh1UiHpX3hvQfint350c+53R4L8TbD+V5zSnudbQwicwKommxhPYkPu2iyMc
	 7Vr9aGlx03SRjS2EXP/M4zcCKrJtIviJZVgfX/+Htwe9d6KbSKRJ8bYLg+MxAwrona
	 dbbx/t/STEShG3UkYy3ZNBc/pW0vGcDdP1WNt+hW9NzD+INDPhiCvxIUyAoS1vMkHv
	 C2HHtPxQq+EyA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_get_dentry_xattr
Date: Thu, 25 Jul 2024 16:47:06 -0700
Message-ID: <20240725234706.655613-3-song@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725234706.655613-1-song@kernel.org>
References: <20240725234706.655613-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Rename fs_kfuncs/xattr to fs_kfuncs/file_xattr and add a call of
   bpf_get_dentry_xattr() to the test.
2. Add a new sub test fs_kfuncs/dentry_xattr, which checks 3 levels of
   parent directories for xattr. This demonstrate the use case that
   a xattr on a directory is used to tag all files in the directory and
   sub directories.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 61 +++++++++++++++++--
 .../selftests/bpf/progs/test_dentry_xattr.c   | 46 ++++++++++++++
 .../selftests/bpf/progs/test_get_xattr.c      | 16 ++++-
 3 files changed, 117 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_dentry_xattr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 37056ba73847..a960cfbe8907 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -2,17 +2,19 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include <stdlib.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/xattr.h>
 #include <linux/fsverity.h>
 #include <unistd.h>
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
+#include "test_dentry_xattr.skel.h"
 #include "test_fsverity.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
-static void test_xattr(void)
+static void test_file_xattr(void)
 {
 	struct test_get_xattr *skel = NULL;
 	int fd = -1, err;
@@ -50,7 +52,8 @@ static void test_xattr(void)
 	if (!ASSERT_GE(fd, 0, "open_file"))
 		goto out;
 
-	ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
+	ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
+	ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
 
 out:
 	close(fd);
@@ -58,6 +61,53 @@ static void test_xattr(void)
 	remove(testfile);
 }
 
+static void test_directory_xattr(void)
+{
+	struct test_dentry_xattr *skel = NULL;
+	static const char * const paths[] = {
+		"/tmp/a",
+		"/tmp/a/b",
+		"/tmp/a/b/c",
+	};
+	const char *file = "/tmp/a/b/c/d";
+	int i, j, err, fd;
+
+	for (i = 0; i < sizeof(paths) / sizeof(char *); i++) {
+		err = mkdir(paths[i], 0755);
+		if (!ASSERT_OK(err, "mkdir"))
+			goto out;
+		err = setxattr(paths[i], "user.kfunc", "hello", sizeof("hello"), 0);
+		if (!ASSERT_OK(err, "setxattr")) {
+			i++;
+			goto out;
+		}
+	}
+
+	skel = test_dentry_xattr__open_and_load();
+
+	if (!ASSERT_OK_PTR(skel, "test_dentry_xattr__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_dentry_xattr__attach(skel);
+
+	if (!ASSERT_OK(err, "test_dentry__xattr__attach"))
+		goto out;
+
+	fd = open(file, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "open_file"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->number_of_xattr_found, 3, "number_of_xattr_found");
+	close(fd);
+out:
+	test_dentry_xattr__destroy(skel);
+	remove(file);
+	for (j = i - 1; j >= 0; j--)
+		rmdir(paths[j]);
+}
+
+
 #ifndef SHA256_DIGEST_SIZE
 #define SHA256_DIGEST_SIZE      32
 #endif
@@ -134,8 +184,11 @@ static void test_fsverity(void)
 
 void test_fs_kfuncs(void)
 {
-	if (test__start_subtest("xattr"))
-		test_xattr();
+	if (test__start_subtest("file_xattr"))
+		test_file_xattr();
+
+	if (test__start_subtest("dentry_xattr"))
+		test_directory_xattr();
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
diff --git a/tools/testing/selftests/bpf/progs/test_dentry_xattr.c b/tools/testing/selftests/bpf/progs/test_dentry_xattr.c
new file mode 100644
index 000000000000..d2e378b2e2d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_dentry_xattr.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+__u32 number_of_xattr_found;
+
+static const char expected_value[] = "hello";
+char value[32];
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	struct bpf_dynptr value_ptr;
+	struct dentry *dentry, *prev_dentry;
+	__u32 pid, matches = 0;
+	int i, ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+
+	dentry = bpf_file_dentry(f);
+
+	for (i = 0; i < 10; i++) {
+		ret = bpf_get_dentry_xattr(dentry, "user.kfunc", &value_ptr);
+		if (ret == sizeof(expected_value) &&
+		    !bpf_strncmp(value, ret, expected_value))
+			matches++;
+
+		prev_dentry = dentry;
+		dentry = bpf_dget_parent(prev_dentry);
+		bpf_dput(prev_dentry);
+	}
+
+	bpf_dput(dentry);
+	number_of_xattr_found = matches;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
index 7eb2a4e5a3e5..3b0dc6106ca5 100644
--- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -9,7 +9,8 @@
 char _license[] SEC("license") = "GPL";
 
 __u32 monitored_pid;
-__u32 found_xattr;
+__u32 found_xattr_from_file;
+__u32 found_xattr_from_dentry;
 
 static const char expected_value[] = "hello";
 char value[32];
@@ -18,6 +19,7 @@ SEC("lsm.s/file_open")
 int BPF_PROG(test_file_open, struct file *f)
 {
 	struct bpf_dynptr value_ptr;
+	struct dentry *dentry;
 	__u32 pid;
 	int ret;
 
@@ -32,6 +34,16 @@ int BPF_PROG(test_file_open, struct file *f)
 		return 0;
 	if (bpf_strncmp(value, ret, expected_value))
 		return 0;
-	found_xattr = 1;
+	found_xattr_from_file = 1;
+
+	dentry = bpf_file_dentry(f);
+	ret = bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);
+	bpf_dput(dentry);
+	if (ret != sizeof(expected_value))
+		return 0;
+	if (bpf_strncmp(value, ret, expected_value))
+		return 0;
+	found_xattr_from_dentry = 1;
+
 	return 0;
 }
-- 
2.43.0


