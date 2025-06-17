Return-Path: <linux-fsdevel+bounces-51852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196BDADC22B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F2E17697A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CC28C85A;
	Tue, 17 Jun 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enTK2ZDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4528BABB;
	Tue, 17 Jun 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140698; cv=none; b=SkZaFS3TJoXnqjZDp07TTcyMZVXCUvAJPQAXA4cqA5+zXaCwLbj9+7yzRp47NzYQuIN+BJadkxxmSYBZsZJV7STXQ36JsiUTdkYTgNiBwQNN/ipfAzDajL7wopx9EH16TXsodGorK2wE/x7vEewkMhM/B9ZlhtsEaC8k9VItTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140698; c=relaxed/simple;
	bh=xWQ8ZTj8fLqEhGkBO7EXf6izR+8Hq06Q6V8sGdcTNBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK59c6VJ4n6GtT2+Y6+nlAqN/yzRbZEulxRkLvNv60PzoPKwr6/tG+ve2aGRss/E1apXaVp21qHyJKzh2LLcixmVNykvvt+QDAcSpEChUzGMw74/bti564XOCHzKfJEk2IzQlOdA0LcDqNVuPj3Dn7ho475qARRJLVc3z3YTU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enTK2ZDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462CAC4CEE3;
	Tue, 17 Jun 2025 06:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140698;
	bh=xWQ8ZTj8fLqEhGkBO7EXf6izR+8Hq06Q6V8sGdcTNBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enTK2ZDrFrzgkISgpLM/4mmBgB4+eZhatgYpJzX8b33DrffY5GPHtXEOGLoX41L/k
	 SFs9NW9sQxVw3JO5B681zT4fiRwa8ICAFve36IIWJu6/YrH5A8HMNhKuInc3UAloyl
	 UHnxuLvKwOiAO7V6/ipyxSRyKeOTw5JcfYwlSxuvCV5aIpQSprrU3kbNuUxO3TG6iW
	 gKuFXqPcuWrr6P0uAm4CHvWflKqGb6C7yyI+yDYr3A71h8p1NI7REASG8OfK5FqTeQ
	 cAYWoX0UKsR872nbbayHE3fnVsDJ8bz0l98Vrc+QsG0F7mLSBGFFyyLbQsbRQl5Hby
	 Erfp8KEuWKcxA==
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
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 3/5] bpf: Introduce path iterator
Date: Mon, 16 Jun 2025 23:11:14 -0700
Message-ID: <20250617061116.3681325-4-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617061116.3681325-1-song@kernel.org>
References: <20250617061116.3681325-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a path iterator, which walks a struct path toward the root.
This path iterator is based on path_walk_parent. A fixed zero'ed root
is passed to path_walk_parent(). Therefore, unless the user terminates
it earlier, the iterator will terminate at the real root.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/bpf_fs_kfuncs.c    | 72 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  5 +++
 2 files changed, 77 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08412532db1b..888867678981 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/namei.h>
 #include <linux/xattr.h>
 
 __bpf_kfunc_start_defs();
@@ -324,6 +325,74 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 
 __bpf_kfunc_end_defs();
 
+/* open-coded path iterator */
+struct bpf_iter_path {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_path_kern {
+	struct path path;
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
+		/*
+		 * _destroy() is still called when _new() fails. Zero
+		 * kit->path so that it be passed to path_put() safely.
+		 * Note: path_put() is no-op for zero'ed path.
+		 */
+		memset(&kit->path, 0, sizeof(struct path));
+		return -EINVAL;
+	}
+
+	kit->path = *start;
+	path_get(&kit->path);
+
+	return 0;
+}
+
+__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+	struct path root = {};
+
+	/*
+	 * "root" is zero'ed. Therefore, unless the loop is explicitly
+	 * terminated, bpf_iter_path_next() will continue looping until
+	 * we've reached the global root of the VFS.
+	 *
+	 * If a root of walk is needed, the user can check "path" against
+	 * that root on each iteration.
+	 */
+	if (path_walk_parent(&kit->path, &root))
+		return NULL;
+
+	return &kit->path;
+}
+
+__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
+{
+	struct bpf_iter_path_kern *kit = (void *)it;
+
+	/*
+	 * kit->path might be zero'ed, but this is OK because path_put()
+	 * is no-op for zero'ed struct path
+	 */
+	path_put(&kit->path);
+}
+
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
@@ -333,6 +402,9 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..b495c3cc4095 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7101,6 +7101,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
+	struct dentry *dentry;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7141,6 +7145,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 				    const char *field_name, u32 btf_id)
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
-- 
2.47.1


