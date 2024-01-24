Return-Path: <linux-fsdevel+bounces-8650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321B839ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFAA1F25B88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC216429;
	Wed, 24 Jan 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4A+VNia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203E156E4;
	Wed, 24 Jan 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062936; cv=none; b=TMQkaJrMhB5UajJ2ZVaQzp2b2jBKOAe44/Ck6KpvSCY3/O8D03GUz5dQthLnaVKTuoYCJt63oi20u6MtfACNOio1rTahiZX2iJXQTZYU0DAxw2GpaphdVt8vIaoBw+Da1M7iCOSs6laQKbJYE4BhCxV6CgT3HHq/6qtuOvnuSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062936; c=relaxed/simple;
	bh=D1xlUAH/ufmhCmt1IsHSRVD50NmqzxltSKIioXYGB+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=es4izDC3zows6NUJ5wpR/VaVqgDxDlnnUs7ew35hDJnlis9Lz8AiOOxTXf3ziZNP2x3cmg8oXJ4KPBMnxNBJCXLJ8N0Gsbtirvqy4frkvqa6kFaLjbOc6pDHWuIibvan3Tf9BcoRhelghUJgM5gK1pTfMJRbJO0I12CKE86nbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4A+VNia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA11C433C7;
	Wed, 24 Jan 2024 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062935;
	bh=D1xlUAH/ufmhCmt1IsHSRVD50NmqzxltSKIioXYGB+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4A+VNiaLaUndPqZhs3tD2OCJ/+YnItCcS5qXRmvpaAtn26LzEgBZcAb+0riQ5LZ6
	 TmSaCkiKtYZIYheTgs63KdvXOOuN7upmtb5DhPN2XBlskL31o7Fs1D5u6ut3IdJwWs
	 PY/MykjIY0pbWrPWzJNSEQ7HF9pmlXG5ILIrlb2Ul7tds13IrbfMtbpQIlAp9OUsmo
	 SPCjb4feAl5O9bP1ekp+YVU2Y47H/wTyLH0kotRnTqxukBgT6nnbxbDcHzahYwEHJz
	 LJXBnt/9neaLFuJCXICxnhVe70cDDRqOiOoNCNMzLyyG/Zs9ToqzPbnQdA2JQJbJwa
	 pHu106VmAl5Aw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 12/30] libbpf: add bpf_token_create() API
Date: Tue, 23 Jan 2024 18:21:09 -0800
Message-Id: <20240124022127.2379740-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 17 +++++++++++++++++
 tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 42 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9dc9625651dc..d4019928a864 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1287,3 +1287,20 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int fd;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.bpffs_fd = bpffs_fd;
+	attr.token_create.flags = OPTS_GET(opts, flags, 0);
+
+	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(fd);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d0f53772bdc0..e49254c9f68f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -640,6 +640,30 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field flags
+
+/**
+ * @brief **bpf_token_create()** creates a new instance of BPF token derived
+ * from specified BPF FS mount point.
+ *
+ * BPF token created with this API can be passed to bpf() syscall for
+ * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
+ *
+ * @param bpffs_fd FD for BPF FS instance from which to derive a BPF token
+ * instance.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return BPF token FD > 0, on success; negative error code, otherwise (errno
+ * is also set to the error code)
+ */
+LIBBPF_API int bpf_token_create(int bpffs_fd,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 91c5aef7dae7..d9e1f57534fa 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,4 +411,5 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+		bpf_token_create;
 } LIBBPF_1.3.0;
-- 
2.34.1


