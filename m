Return-Path: <linux-fsdevel+bounces-36999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16199EBD96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 23:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997E3287290
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC324353C;
	Tue, 10 Dec 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK/wDN4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853C1EE7D1;
	Tue, 10 Dec 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868452; cv=none; b=rWDDdTWpoHjtoX4AKrgvNc3QncW6Odnz5Rjx2Sypq9jwma2kJljnmfbh+dBqhyHfMn2sqyGPlcovWoI5aaQdVBPAXfO3j8P+PhnOUGu+1mzufpoTd3rXyRNgUf2Ggocq/oxxRuWld90eQCDlrRA4yusUd3VZlmA2IcqDHFdNVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868452; c=relaxed/simple;
	bh=0fQ3Q90Pn0i+PpOwOA0VS4st230oZ1EKiYKxA/3sSK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2d75L15qVp7rZM5J2rfa1+/BVicJ6QruLLAhvtAyCx3T4Uv6zqg7qn548yI927yUcQY/gdDqDiWTpdkYOEqEKM7FzW0X5ebEWdRDPGVWmfqGLulu16MgV11pAiebCo+W7mPx05lZRGMmuBADbpcsPdHROWBycIAOWlZpSdcyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK/wDN4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B896C4CED6;
	Tue, 10 Dec 2024 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733868451;
	bh=0fQ3Q90Pn0i+PpOwOA0VS4st230oZ1EKiYKxA/3sSK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TK/wDN4XAzYzcaam5iHqAQZjl/nEJ7DrrYhSk99c3QvDbimbj/ctpm9tzlgCU0ZXc
	 xBAHYeqf0QEmS0GgedFcaOvy59tqTW8JlFyXA3PcCezSqaa2JbaGOpB+Sj0AYsysXF
	 4yQpepnlvvYq79YShcF/+0DdGJGpEoZ7CLg5YdLy9DXFO9Oetzq2uz/3F+2pBKLX4G
	 X5l1wS7hhfuVhbrJoGxF9m/om1t0iKHMODdgl6TTj/KrfN6XmAfPKARih8/5c+M29T
	 qiSteYYaxFjypRHla/AzQtGDmfVzQpSd6+21ixsjEOgx8qwgWc4jkAsoZ5gFsX8aMF
	 nRF88BUYXbMhQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
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
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 6/6] selftests/bpf: Add __failure tests for set/remove xattr kfuncs
Date: Tue, 10 Dec 2024 14:06:27 -0800
Message-ID: <20241210220627.2800362-7-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210220627.2800362-1-song@kernel.org>
References: <20241210220627.2800362-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different LSM hooks should call different versions of set/remove xattr
kfuncs (with _locked or not). Add __failure tests to make sure the
verifier can detect when the user uses the wrong kfuncs.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  3 +
 .../bpf/progs/test_set_remove_xattr_failure.c | 56 +++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 41532df79fdd..614335a3ff53 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -9,6 +9,7 @@
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
+#include "test_set_remove_xattr_failure.skel.h"
 #include "test_fsverity.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
@@ -286,6 +287,8 @@ void test_fs_kfuncs(void)
 	if (test__start_subtest("set_remove_xattr"))
 		test_set_remove_xattr();
 
+	RUN_TESTS(test_set_remove_xattr_failure);
+
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_set_remove_xattr_failure.c b/tools/testing/selftests/bpf/progs/test_set_remove_xattr_failure.c
new file mode 100644
index 000000000000..ee9c7df27a93
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_set_remove_xattr_failure.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static const char xattr_bar[] = "security.bpf.bar";
+char v[32];
+
+SEC("lsm.s/inode_getxattr")
+__failure __msg("calling kernel function bpf_set_dentry_xattr_locked is not allowed")
+int BPF_PROG(test_getxattr_failure_a, struct dentry *dentry, char *name)
+{
+	struct bpf_dynptr value_ptr;
+
+	bpf_dynptr_from_mem(v, sizeof(v), 0, &value_ptr);
+
+	bpf_set_dentry_xattr_locked(dentry, xattr_bar, &value_ptr, 0);
+	return 0;
+}
+
+SEC("lsm.s/inode_getxattr")
+__failure __msg("calling kernel function bpf_remove_dentry_xattr_locked is not allowed")
+int BPF_PROG(test_getxattr_failure_b, struct dentry *dentry, char *name)
+{
+	bpf_remove_dentry_xattr_locked(dentry, xattr_bar);
+	return 0;
+}
+
+SEC("lsm.s/inode_setxattr")
+__failure __msg("calling kernel function bpf_set_dentry_xattr is not allowed")
+int BPF_PROG(test_inode_setxattr_failure_a, struct mnt_idmap *idmap,
+	     struct dentry *dentry, const char *name,
+	     const void *value, size_t size, int flags)
+{
+	struct bpf_dynptr value_ptr;
+
+	bpf_dynptr_from_mem(v, sizeof(v), 0, &value_ptr);
+
+	bpf_set_dentry_xattr(dentry, xattr_bar, &value_ptr, 0);
+	return 0;
+}
+
+SEC("lsm.s/inode_setxattr")
+__failure __msg("calling kernel function bpf_remove_dentry_xattr is not allowed")
+int BPF_PROG(test_inode_setxattr_failure_b, struct mnt_idmap *idmap,
+	     struct dentry *dentry, const char *name,
+	     const void *value, size_t size, int flags)
+{
+	bpf_remove_dentry_xattr(dentry, xattr_bar);
+	return 0;
+}
-- 
2.43.5


