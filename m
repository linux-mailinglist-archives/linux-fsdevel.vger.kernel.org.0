Return-Path: <linux-fsdevel+bounces-51369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C02AD621E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EB2189B66B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8325291C;
	Wed, 11 Jun 2025 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp3Z07xA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE85218591;
	Wed, 11 Jun 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679367; cv=none; b=pGwg2nQrko4uZwd4JJMjqOGNB7k1l810Br8ikr05J693N0kQ77d3OPEkljAqWYY8HNtmFrm+mMTCoSSjA7erzQcs0AL2iovliJ0ZMKQ7GA2+03X1Cs7fWa0NytvNogGWb0FpC9BDpBrl4hgI/xpgSofAxdCem4Dl6h6BPU+SW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679367; c=relaxed/simple;
	bh=9F10qO9Msdgz89bnpZRuwO8YiDXQDw7GfTMJBW3OmZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmZDMubZ6BPQnI3D+GQkZ2PMnTSttfD97PDwSQdxB5wB+CNAz4VD/DJLfUaafFAkfUFpK4hgJSBVLre8Qxf8VbngNf6LlGkzr8yLgjvt6mxZx7QFwuPaPDXSg3y5AfWDJk7DNYXQ8HvEw1Qk1KRequWuo2BbGoubJjxLJjKpdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp3Z07xA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF4C4CEE3;
	Wed, 11 Jun 2025 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749679366;
	bh=9F10qO9Msdgz89bnpZRuwO8YiDXQDw7GfTMJBW3OmZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kp3Z07xA35Fds9w9PvlnVexQmfBcdgep4DEj8lzIak5loHb0URjbscmByxloe6g28
	 dwr6IvYerDwnKBjUkJIG8YYqRLPs3Hza4c3dtzZQTf4gLAybzQALmwN8dpsPnUuFV8
	 kgFWyudO3odCO2DCnK2hvNJTQ6cMnuGtazaD/Wg8u3MfrECQwJJvXFDx0JVaeGKN7f
	 2dX4TOrJkz1G0d/hkQNrUlxam8zYP7tU3dEEX8FTfyh+GsziP5nykvUDdBIvoC+Eap
	 cF5Lh9Ilx2a49l+aMg0fQ7gRIswigcvOFBn3fHK0u2yVlpKXNpPdEXe4Mk3unYLJ00
	 QOd7bQBxsk5UQ==
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
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 4/5] selftests/bpf: Add tests for bpf path iterator
Date: Wed, 11 Jun 2025 15:02:19 -0700
Message-ID: <20250611220220.3681382-5-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611220220.3681382-1-song@kernel.org>
References: <20250611220220.3681382-1-song@kernel.org>
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
 tools/testing/selftests/bpf/progs/path_iter.c | 145 ++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 5e512a1d09d1..cbb759b473df 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -596,4 +596,10 @@ extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 
+struct bpf_iter_path;
+extern int bpf_iter_path_new(struct bpf_iter_path *it, struct path *start,
+			     __u64 flags) __weak __ksym;
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
index 000000000000..74d0f4e19ffa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_iter.c
@@ -0,0 +1,145 @@
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
+	ret = bpf_iter_path_new(&path_it, &f->f_path, 0);
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
+	bpf_for_each(path, p, &f->f_path, 0)
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
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
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
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
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
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
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
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
+	bpf_iter_path_destroy(&path_it);
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
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
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
+	path_it_2 = path_it;
+	bpf_iter_path_destroy(&path_it_2);
+	return 0;
+}
+
+SEC("lsm.s/sb_alloc_security")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(untrusted_path, struct super_block *sb)
+{
+	struct bpf_iter_path path_it;
+
+	bpf_iter_path_new(&path_it, &sb->s_bdev_file->f_path, 0);
+	bpf_iter_path_destroy(&path_it);
+	return 0;
+}
-- 
2.47.1


