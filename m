Return-Path: <linux-fsdevel+bounces-50013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94320AC7412
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEFA9E883C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22795221FCD;
	Wed, 28 May 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWN6bbv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC3221FC0;
	Wed, 28 May 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471208; cv=none; b=U9GVhCanlBoSuqOd4JoEJM3SwpKKwVR5WP+nvSWe+uNjjSEWk+GDSKMYpDZ8djVJSRJx+1p8BKYbk7xGmVj8hXNYPpg29ZYdhNivrMzmcRdcRDDKM68R8EMq56g90Vjb3ijrxePcHvj+5W83/JqLFI/+O3O6MC+Ago1jZqqhzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471208; c=relaxed/simple;
	bh=rhY89p3QLjKKxBhAfsOf/vrOTPNyUThFp058gpN3hhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAK4Vhr3tMVxAX/bK7GAkOXSXT9Idcq8kLYxnFXhNYG7Xhr+YuHUqpoAtQI3yE7HBshVxOk0sTwRPHgAWPE3uzT5vI6QiuPkifmKx2Qin+GCcjUqfXl0lhXClJ4Xb1+vtuAWQoucShjLvwYBFEoHiJ9dhMGEk/+rwHJbdjsHkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWN6bbv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D380DC4CEEE;
	Wed, 28 May 2025 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471208;
	bh=rhY89p3QLjKKxBhAfsOf/vrOTPNyUThFp058gpN3hhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWN6bbv3xpc11cQKUuM4O2zDoxiWWjAp6EaCj0hMnr8NAL2RtZ0mfwV2y4E/Gl4bx
	 DWIHJ21sxrVmxKC7SFKpJua9S3GRNcdcCIiMkTYzWGNuVvoGB0Rw+1SqNvII2FVngX
	 wC9HlM7teDCn7Iu6d3eFJqhToqeDHzwueaE4IVUJiIDyrkEpRD7Q4MyC/T4Wk/9ijT
	 YohqPGKHyerB5aWiQncwTXcu+BJ1qkzRsKUeJceWIzK1/V72IhSs9t1JoM8mkc7sB9
	 ZTdIhRIa0K1tkeh2oP17N6mUoT2Ox6F3+6eb6cJuuBTgD22eWpAiAf84qPNWhCPyNj
	 ddgSpkel4oIwQ==
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
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for bpf path iterator
Date: Wed, 28 May 2025 15:26:23 -0700
Message-ID: <20250528222623.1373000-5-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250528222623.1373000-1-song@kernel.org>
References: <20250528222623.1373000-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for bpf path iterator, including test cases similar to real
workload (call bpf_path_d_path and bpf_get_dentry_xattr), and test cases
where the verifier rejects invalid use of the iterator.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/path_iter.c      |  12 ++
 tools/testing/selftests/bpf/progs/path_iter.c | 134 ++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 6535c8ae3c46..e9eb2b105eb2 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -591,4 +591,10 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
 extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
 
+struct bpf_iter_path;
+extern int bpf_iter_path_new(struct bpf_iter_path *it, struct path *start,
+			     enum bpf_path_iter_mode mode) __weak __ksym;
+extern struct path *bpf_iter_path_next(struct bpf_iter_path *it) __weak __ksym;
+extern void bpf_iter_path_destroy(struct bpf_iter_path *it) __weak __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/path_iter.c b/tools/testing/selftests/bpf/prog_tests/path_iter.c
new file mode 100644
index 000000000000..3c99c24fbd96
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/path_iter.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "path_iter.skel.h"
+
+void test_path_iter(void)
+{
+	RUN_TESTS(path_iter);
+}
diff --git a/tools/testing/selftests/bpf/progs/path_iter.c b/tools/testing/selftests/bpf/progs/path_iter.c
new file mode 100644
index 000000000000..d5733c797a3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_iter.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+char path_name[256];
+char xattr_val[64];
+
+static __always_inline void access_path_dentry(struct path *p)
+{
+	struct bpf_dynptr ptr;
+	struct dentry *dentry;
+
+	if (!p)
+		return;
+
+	bpf_dynptr_from_mem(xattr_val, sizeof(xattr_val), 0, &ptr);
+	bpf_path_d_path(p, path_name, sizeof(path_name));
+
+	dentry = p->dentry;
+	if (dentry)
+		bpf_get_dentry_xattr(dentry, "user.xattr", &ptr);
+}
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(open_code, struct file *f)
+{
+	struct bpf_iter_path path_it;
+	struct path *p;
+	int ret;
+
+	ret = bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	if (ret) {
+		bpf_iter_path_destroy(&path_it);
+		return 0;
+	}
+
+	p = bpf_iter_path_next(&path_it);
+	access_path_dentry(p);
+	bpf_iter_path_destroy(&path_it);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(for_each, struct file *f)
+{
+	struct path *p;
+
+	bpf_for_each(path, p, &f->f_path, BPF_PATH_ITER_MODE_PARENT)
+		access_path_dentry(p);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(missing_destroy, struct file *f)
+{
+	struct bpf_iter_path path_it;
+
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("expected an initialized iter_path")
+int BPF_PROG(missing_new, struct file *f)
+{
+	struct bpf_iter_path path_it;
+
+	bpf_iter_path_destroy(&path_it);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("expected uninitialized iter_path")
+int BPF_PROG(new_twice, struct file *f)
+{
+	struct bpf_iter_path path_it;
+
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	bpf_iter_path_destroy(&path_it);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("expected an initialized iter_path")
+int BPF_PROG(destroy_twice, struct file *f)
+{
+	struct bpf_iter_path path_it;
+
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	bpf_iter_path_destroy(&path_it);
+	bpf_iter_path_destroy(&path_it);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(reuse_path_iter, struct file *f)
+{
+	struct bpf_iter_path path_it;
+
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	bpf_iter_path_destroy(&path_it);
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	bpf_iter_path_destroy(&path_it);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("invalid read from stack off")
+int BPF_PROG(invalid_read_path_iter, struct file *f)
+{
+	struct bpf_iter_path path_it;
+	struct bpf_iter_path path_it_2;
+
+
+	bpf_iter_path_new(&path_it, &f->f_path, BPF_PATH_ITER_MODE_PARENT);
+	path_it_2 = path_it;
+	bpf_iter_path_destroy(&path_it_2);
+	return 0;
+}
-- 
2.47.1


