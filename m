Return-Path: <linux-fsdevel+bounces-50426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58629ACC0A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB5D3A4F78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A726A096;
	Tue,  3 Jun 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekutbj59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADD268C6F;
	Tue,  3 Jun 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933990; cv=none; b=cPCWzFToaTJFa9bsH9g6L1ZW6GFIF7l6O9ouffUzdwm6uBzvusbqAVLGCQq4cNU9uefsK97sCx30ZjsL0/azgP28Bx1IFATbW4Ashs+p+3lUQhl/NeipyvA/VI2UEdbqEqg34qgPtom34e2hf2/u8QH2OaDuRMzMRSQpjLDK7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933990; c=relaxed/simple;
	bh=D1DJb4SnUrqB3p+41jAzsi+WoB7vPnyoNcQiK6Opy5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvBzhW0LiPYG/JsJiOtr1ha+OgdIx+ybyvmvCnpeKeY/Ca9dwDnbyH4ZWtDAhH6Lu5QKq5PjRQZqa/qCPOcHiJd/6yxnV83xIohICrIrr8b7+k3lJW3iloLejKuTU4knrHtHwC4XpBrHZJSH0+PJ3Zzbf+hgg/Wi2jVbsLFLGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekutbj59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D88EC4CEED;
	Tue,  3 Jun 2025 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748933989;
	bh=D1DJb4SnUrqB3p+41jAzsi+WoB7vPnyoNcQiK6Opy5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekutbj59Zl137NBCNx+l2QdKyupFi173NhNpFGfdiAWf+rt5Dii7sOiDV9D0QQAa3
	 +UsSoWijbSV0zEYneE9uYhfr0P38JgBfaG0FIgng255cuS15MG8d7AFIAsjjJl4lc3
	 OFNu4aixNU7TqrG4FBjNoEAoNcpMk0PlabDPqVPertK6/zc5rDgYPWcuKvBR2xq+QL
	 bNfnHzleFJhn1fkmXixlInk6puxJIHlNVUT+UuWjEyaDbQDJnez+gGWCnP5dQC4yH2
	 Y9ky/bUKH/Ga7H3QjtmWlwniW7A/440X7WZzqdAeVXeWwADk4qiPUWfk5Hm14FbCqL
	 EnVrXiWUesC1w==
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
Subject: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
Date: Mon,  2 Jun 2025 23:59:19 -0700
Message-ID: <20250603065920.3404510-4-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250603065920.3404510-1-song@kernel.org>
References: <20250603065920.3404510-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a path iterator, which reliably walk a struct path toward
the root. This path iterator is based on path_walk_parent. A fixed
zero'ed root is passed to path_walk_parent(). Therefore, unless the
user terminates it earlier, the iterator will terminate at the real
root.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/Makefile    |  1 +
 kernel/bpf/helpers.c   |  3 +++
 kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  |  5 ++++
 4 files changed, 67 insertions(+)
 create mode 100644 kernel/bpf/path_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3a335c50e6e3..454a650d934e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+obj-$(CONFIG_BPF_SYSCALL) += path_iter.o
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..b190c78e40f6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
+BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
new file mode 100644
index 000000000000..0d972ec84beb
--- /dev/null
+++ b/kernel/bpf/path_iter.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/namei.h>
+#include <linux/path.h>
+
+/* open-coded iterator */
+struct bpf_iter_path {
+	__u64 __opaque[3];
+} __aligned(8);
+
+struct bpf_iter_path_kern {
+	struct path path;
+	__u64 flags;
+} __aligned(8);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
+				  struct path *start,
+				  __u64 flags)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	if (flags) {
+		memset(&kit->path, 0, sizeof(struct path));
+		return -EINVAL;
+	}
+
+	kit->path = *start;
+	path_get(&kit->path);
+	kit->flags = flags;
+
+	return 0;
+}
+
+__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+	struct path root = {};
+
+	if (!path_walk_parent(&kit->path, &root))
+		return NULL;
+	return &kit->path;
+}
+
+__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+
+	path_put(&kit->path);
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7d6e0c5928b..45b45cdfb223 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7036,6 +7036,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
+	struct dentry *dentry;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7076,6 +7080,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 				    const char *field_name, u32 btf_id)
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
-- 
2.47.1


