Return-Path: <linux-fsdevel+bounces-50872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5760AD0986
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9540C3AE064
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DF23FC52;
	Fri,  6 Jun 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNg4ExAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEB23F404;
	Fri,  6 Jun 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245447; cv=none; b=EmlwMMxTmBitZWpWjUhK0MDv+hHQA1bS5GlaBZOVyyC6FXPkgW7rXRky2O8ZLx+mXK3zjDcehpPBodi24B8fk7LehDUEYtoaWahEO6R7QB5GgW09BmRi+xTkyUI09YEtaMid4YnoyuwNyKulx0BdpldB3THDDY7SxUE504GtWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245447; c=relaxed/simple;
	bh=9F10qO9Msdgz89bnpZRuwO8YiDXQDw7GfTMJBW3OmZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD48nbOrRgK1t1uZprrIUJJ+CNzDJSShmIIj0ToR6+M7VY0wy3kKHbvOdf8htzoleEvhV5LRvPYohxYlpLiL1/F+EoGc6Uk3RkwIHJzQFdly4veL/CWmqf209JqvHjLPcdnmhAnnUbr6oknNUZw3bvrmpb0S9IbhtjhY+g4rHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNg4ExAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC53C4CEEB;
	Fri,  6 Jun 2025 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749245446;
	bh=9F10qO9Msdgz89bnpZRuwO8YiDXQDw7GfTMJBW3OmZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNg4ExAeCXGc+bn0OHnPisPTpjL2XzeFSHdHU4GlYFORVNucTzqCXTySyPvwnigzX
	 U/XIhyISmy5HUUzN2pNqKuiQFC1dT+RIv7MFDCS1SnKyPMBCPP+Lj1FhxRBHJCwjZY
	 QVRSDg9QGqdAf+lI4nt4BrNKzL7KTRn0XpiTS+ZZPH7gUilUTG0FfC6QkW6yg855hC
	 OyxK09LkWQCreJDHgmvLZRlJc6ihXv7CPls1XvYLNhyTOxFFH1gRdp/IjPSfUYn5QJ
	 VaZJI/qAuxQnQdp3pwF945oi8tLInH7EgKY1Jg5VGILiue5VxYUrNUNr7JO9s9knzV
	 X1WIrsdeemmPQ==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 4/5] selftests/bpf: Add tests for bpf path iterator
Date: Fri,  6 Jun 2025 14:30:14 -0700
Message-ID: <20250606213015.255134-5-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606213015.255134-1-song@kernel.org>
References: <20250606213015.255134-1-song@kernel.org>
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


