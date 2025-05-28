Return-Path: <linux-fsdevel+bounces-50012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EEAC740D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C521C04FB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0ED22D7AD;
	Wed, 28 May 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXtlXNir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063914E2F2;
	Wed, 28 May 2025 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471203; cv=none; b=HZoLZFXF2FKN4AIVYEmnqi6UTR0ciYvoWFNX/oQNNA33/UvQLfwBE3nQ2hib9Jdp00BXnGTkaMA5APFePL/+dUTfnKrbOAlq21ZbPHUw9vcZmCWrhnUX1iGv+EqAdCEJJxx9jTtacOZj/EuXP6jXwZotgvH9V/qPsZGIS5m+89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471203; c=relaxed/simple;
	bh=OdqrPuaA4OShJbWqBysA33tbjRNwkLq+Lcj5uC8chRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhG5XEbm4tK9T/jG0Tf+/OGnh+5Bjm4tdp42i+9sCoEwu2wyQX7P+rZKPMR8jsUCJeftf0rWc9AYk7FHe+7NpTyLLMsz82OpuwfnUNiW9qgBo8cUSVip0hVFv7Ip/BCeuDaOHgQ90pDh4qjS8hjZ4udSx5tkOAr7sKJEmcZ5Frk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXtlXNir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6DEC4CEE3;
	Wed, 28 May 2025 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471203;
	bh=OdqrPuaA4OShJbWqBysA33tbjRNwkLq+Lcj5uC8chRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXtlXNirxVoekee6vJsofDDUwl5f2fvXh5DbQGXKtPTBhYLvgsVoM+nvPMHTeR2HI
	 Ykt1/QR7t8gSXGXxfa7HraVerReuWLL6a5pWbmx1QudYrq8O82/Lb2ANQEu/AxfWhz
	 A+LaZ/bdNXNQnf53CisguYeb8ucXkBN2TiF/mXy8IkL4r1VD1BpPRRWmZM8L9ZcXRy
	 IBokj6iVtmBpbcutaiPPS5ZtraJwLi32AML4laYCW0VDKHKp1UBYfKc2aG50Aj7TfL
	 Cn7uFwbAb0eEkxbsKNSBMPXl07sAQVr9bNlBbAGV/eg+41MSp133gwbx10KyHLrN5e
	 EPpEgJ3sG8eng==
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
Subject: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Date: Wed, 28 May 2025 15:26:22 -0700
Message-ID: <20250528222623.1373000-4-song@kernel.org>
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

Introduce a path iterator, which reliably walk a struct path.

Current version only support walking towards the root, which helper
path_parent. But the path iterator API can be extended to cover other
use cases, for example, walking the mount tree.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/Makefile    |  1 +
 kernel/bpf/helpers.c   |  3 ++
 kernel/bpf/path_iter.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  |  5 +++
 4 files changed, 83 insertions(+)
 create mode 100644 kernel/bpf/path_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 70502f038b92..8075a83d5e08 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += path_iter.o
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1113b74e1e2..d77b055092e7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3386,6 +3386,9 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
new file mode 100644
index 000000000000..838ebbeac6c2
--- /dev/null
+++ b/kernel/bpf/path_iter.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/namei.h>
+#include <linux/path.h>
+
+enum bpf_path_iter_mode {
+	BPF_PATH_ITER_MODE_PARENT = 1,
+};
+
+/* open-coded iterator */
+struct bpf_iter_path {
+	__u64 __opaque[3];
+} __aligned(8);
+
+struct bpf_iter_path_kern {
+	struct path path;
+	enum bpf_path_iter_mode mode;
+} __aligned(8);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
+				  struct path *start,
+				  enum bpf_path_iter_mode mode)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	kit->mode = mode;
+
+	switch (mode) {
+	case BPF_PATH_ITER_MODE_PARENT:
+		break;
+	default:
+		memset(&kit->path, 0, sizeof(struct path));
+		return -EINVAL;
+	}
+
+	kit->path = *start;
+	path_get(&kit->path);
+	return 0;
+}
+
+__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+
+	switch (kit->mode) {
+	case BPF_PATH_ITER_MODE_PARENT:
+		enum path_parent_status status = path_parent(&kit->path);
+
+		/* If already at a root, return NULL */
+		if (status == PATH_PARENT_REAL_ROOT ||
+		    status == PATH_PARENT_DISCONNECTED_ROOT)
+			return NULL;
+		break;
+	default:
+		return NULL;
+	}
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
index d5807d2efc92..734c06809563 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7034,6 +7034,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
+	struct dentry *dentry;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7074,6 +7078,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 				    const char *field_name, u32 btf_id)
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
-- 
2.47.1


