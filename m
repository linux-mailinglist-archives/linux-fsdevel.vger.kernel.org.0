Return-Path: <linux-fsdevel+bounces-37609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB119F43EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743A97A59C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA81DC19F;
	Tue, 17 Dec 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya2W0Dvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA717278D;
	Tue, 17 Dec 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417554; cv=none; b=oojryqi68FPNx6RiiE56PMHEQP/sh1kqOTCb7Gig9T96atZs6AFiRc/uE3xUgv2dLdIoIbA2k2d+d5s2wJxTdmy+sgoyYGVf6VFZ6XTjFi6VI3anfAFZYqUv4sceZpsOs5rSmUS9dSWK/PabkNt7dcUJqjT8dvqWkDqfhD67a8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417554; c=relaxed/simple;
	bh=IqPKfOrMgp0tZi2PstSwCopMQvxaFrQgiqW8jHk0THg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVgwq/8wLyuiZ4mF8TIy4xrmrqvL9hfBi3puyAbhwZuOZOdlRvVLTst72b/TXf+CgGxrT+w3BYCamNLRsrIcYKidLaMCvDdwPDFSuT9umnL4ZBHjD6KB8uQeP0WV3u4HCOhfdntRrLaHvNRd9HRHCAdheJLVeA6XTOju7YMosfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya2W0Dvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3393CC4CEDD;
	Tue, 17 Dec 2024 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734417554;
	bh=IqPKfOrMgp0tZi2PstSwCopMQvxaFrQgiqW8jHk0THg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ya2W0Dvj1g15Vvm9w1s8zm6thZq71VCT9x0qdlg21bRgN0YYPHJnZA5WKiECYnJyh
	 gKUzaJcWXbyFB0dRirNgRSkt68Cps8zdAX6rfPpQg2KBSRpFNByBZ1sxWKgzJsn2hi
	 MGm0fxnA7jfgWOPLEL1pNu0uRRbD2wetofmrYLXgIW815Wuh1FrjVUd+ryxIjmzp/Q
	 ayKK8ZottGXVv7caNAIU6FIWxOmyNAdFUKHTzv7aKAzo2fnnpj4Bmw/HGcXLveTgiN
	 3abSoFqWKaxyK7i/Roc0lgulZMIgF+ed+WoI4O+mdZOh4KP9fB3csE+FTXwkyXWgkl
	 HG1F7z/XTjYDA==
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
Subject: [PATCH v4 bpf-next 6/6] selftests/bpf: Add __failure tests for set/remove xattr kfuncs
Date: Mon, 16 Dec 2024 22:38:21 -0800
Message-ID: <20241217063821.482857-7-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217063821.482857-1-song@kernel.org>
References: <20241217063821.482857-1-song@kernel.org>
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
index 43a26ec69a8e..f24285ae8d43 100644
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


