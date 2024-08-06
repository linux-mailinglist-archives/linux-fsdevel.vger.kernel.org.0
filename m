Return-Path: <linux-fsdevel+bounces-25183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C70949931
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94E4B2529B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78572170A1C;
	Tue,  6 Aug 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqCBUmSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AB14901A;
	Tue,  6 Aug 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976455; cv=none; b=tbDMQaSF4P9vQ5WYNfWMPi+mV8vWT8u47B8go5K17Wk2kGLL5m0SDq+OHuHGwuU95iyqsFAOkADiAGxW6lw+tt9JxrxpdtTb+uFsuDHghou550OyV744jWAQro7xoqkqNc7umWTBJVq/iKKyXOxH7WWixavKTeLgzjj+qkBH81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976455; c=relaxed/simple;
	bh=mRi8+Zeuva9RNnLIIseP+EjFUXk9thoSLijEUjM0ssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MazksGb92JH2MAuNknbWrcaffUyquBEVe0jjwq9uR6yb72ZemiV2LAyZUfcZr/duYv9xGuQo+pCDm1RM344SZhCWVpNWBmJCx0n4tBKMM5XizGgVPXujgi4yVJHA5XZBWJMt8pST/0au0JO9aHeF8FnxMJR4ZeyGsDIxGp8ig+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqCBUmSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEB3C32786;
	Tue,  6 Aug 2024 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976455;
	bh=mRi8+Zeuva9RNnLIIseP+EjFUXk9thoSLijEUjM0ssg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqCBUmSySNPLKALRYbwy4stRPxEkUsaOPiD+LzyCALdLFcAgJ3fnTn1xKURQvgGaj
	 uZ0zzoF9oAGl+A/1ysS/whxHtSBrUVjH3x3uG4c2r/UUlGo5MbzIJNO0TEW3IpJEBl
	 A3xjdWErPrAPC29ZZzzWqH4Hs/kfS0pX8VcdKNaXdhEqVIsxLOxuZavoYd2xFOEgj3
	 es2M1psOBP5OqyEUaKfKRiKbrI3jYe75ayQCqQc8Eq/ftlxhH6xskrr6mTemn0i13m
	 6KX092MnvLwTZDJ4DLOJoLSskWReTw1Qa03EN14121fNynOKMkniFCdaItj5oY8Hgr
	 /L/E9jVYadhqA==
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
	liamwisehart@meta.com,
	lltang@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: Add tests for bpf_get_dentry_xattr
Date: Tue,  6 Aug 2024 13:33:40 -0700
Message-ID: <20240806203340.3503805-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240806203340.3503805-1-song@kernel.org>
References: <20240806203340.3503805-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test for bpf_get_dentry_xattr on hook security_inode_getxattr.
Verify that the kfunc can read the xattr. Also test failing getxattr
from user space by returning non-zero from the LSM bpf program.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 ++++-
 .../selftests/bpf/progs/test_get_xattr.c      | 37 ++++++++++++++++---
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 3b6675ab4086..cf25421c36c9 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -78,4 +78,12 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 
 extern bool bpf_session_is_return(void) __ksym __weak;
 extern __u64 *bpf_session_cookie(void) __ksym __weak;
+
+/* Description
+ *  Returns xattr of a dentry
+ * Returns__bpf_kfunc
+ *  Error code
+ */
+extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
+			      struct bpf_dynptr *value_ptr) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 37056ba73847..5a0b51157451 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -16,6 +16,7 @@ static void test_xattr(void)
 {
 	struct test_get_xattr *skel = NULL;
 	int fd = -1, err;
+	int v[32];
 
 	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
 	if (!ASSERT_GE(fd, 0, "create_file"))
@@ -50,7 +51,13 @@ static void test_xattr(void)
 	if (!ASSERT_GE(fd, 0, "open_file"))
 		goto out;
 
-	ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
+	ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
+
+	/* Trigger security_inode_getxattr */
+	err = getxattr(testfile, "user.kfuncs", v, sizeof(v));
+	ASSERT_EQ(err, -1, "getxattr_return");
+	ASSERT_EQ(errno, EINVAL, "getxattr_errno");
+	ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
 
 out:
 	close(fd);
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
index 7eb2a4e5a3e5..66e737720f7c 100644
--- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_kfuncs.h"
@@ -9,10 +10,12 @@
 char _license[] SEC("license") = "GPL";
 
 __u32 monitored_pid;
-__u32 found_xattr;
+__u32 found_xattr_from_file;
+__u32 found_xattr_from_dentry;
 
 static const char expected_value[] = "hello";
-char value[32];
+char value1[32];
+char value2[32];
 
 SEC("lsm.s/file_open")
 int BPF_PROG(test_file_open, struct file *f)
@@ -25,13 +28,37 @@ int BPF_PROG(test_file_open, struct file *f)
 	if (pid != monitored_pid)
 		return 0;
 
-	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+	bpf_dynptr_from_mem(value1, sizeof(value1), 0, &value_ptr);
 
 	ret = bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
 	if (ret != sizeof(expected_value))
 		return 0;
-	if (bpf_strncmp(value, ret, expected_value))
+	if (bpf_strncmp(value1, ret, expected_value))
 		return 0;
-	found_xattr = 1;
+	found_xattr_from_file = 1;
 	return 0;
 }
+
+SEC("lsm.s/inode_getxattr")
+int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+	int ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
+
+	ret = bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);
+	if (ret != sizeof(expected_value))
+		return 0;
+	if (bpf_strncmp(value2, ret, expected_value))
+		return 0;
+	found_xattr_from_dentry = 1;
+
+	/* return non-zero to fail getxattr from user space */
+	return -EINVAL;
+}
-- 
2.43.5


