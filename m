Return-Path: <linux-fsdevel+bounces-50871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EFAD097E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1269E189E181
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449323E32E;
	Fri,  6 Jun 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7OPb0wZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C471238C1E;
	Fri,  6 Jun 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245441; cv=none; b=kCA+uPkcWtEGBTi3U4E+DLdb5uNw0cZ++6lzPEUzCP+JLCOF57mnIHRghFp07jBZFM8WegURf4+fi8AfQbHPYuDI9Z68sUwHuZyFBPfSv1U26/15bbAF7X2k0P2GIJwazQV5+QVtEP9jijVy599tmLx2y30DR3rMi9Ho1nRSi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245441; c=relaxed/simple;
	bh=OnL2EfwsdgVdb5c1ai8U7ZmDoCqhqPrRkXhX1QYpDSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyDOXn3VZubKDosoV/NXCP0P9aKhzKbdK2xXBrKPm634/R8kykEhnkqqBjyL6HQkBYUbXfmgqLPO1AgsydF3ZcZGcYYvBrOFAefLxLePiwx4XQyhtednVAbDAiuqUd4fiqkJwjiLo/F2wmdwP+mrk8eCrRB3ZXJdUcbZbC3SYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7OPb0wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F62AC4CEEB;
	Fri,  6 Jun 2025 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749245441;
	bh=OnL2EfwsdgVdb5c1ai8U7ZmDoCqhqPrRkXhX1QYpDSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7OPb0wZ/rRJW16/XiQile83oAX++PfmsP6B625RkpSWMjqdq5vp77jQo9B1FABcB
	 ESooZg02+7m1jTgj6eL0e8g2fDF7cSncBsMpLhnjatKmLFhJzfk88+8sJySrpkVmEX
	 x6GIzpGhZy8bV3qb10SIcszVVEubUjynKhBU2rHHPUW3qiO5LfVjL73sr9jjVbHhuw
	 d+kS6o5nL/LTa1XCDSkqfX6nhzbfZdleiHic+5eOL7iMR61AYj8pD4euqw/nYCMFnG
	 m4dLkoHANLij5TR+2KwukoIwTQdv+q+DvjwyaaqjnV0uy7WrgxY2gVoiQwJPXZoDFW
	 SlAuEJpcSIvLw==
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
Subject: [PATCH v3 bpf-next 3/5] bpf: Introduce path iterator
Date: Fri,  6 Jun 2025 14:30:13 -0700
Message-ID: <20250606213015.255134-4-song@kernel.org>
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

Introduce a path iterator, which walks a struct path toward the root.
This path iterator is based on path_walk_parent. A fixed zero'ed root
is passed to path_walk_parent(). Therefore, unless the user terminates
it earlier, the iterator will terminate at the real root.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  5 +++
 2 files changed, 78 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08412532db1b..8c618154df0a 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/namei.h>
 #include <linux/xattr.h>
 
 __bpf_kfunc_start_defs();
@@ -324,6 +325,75 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 
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
+	if (!path_walk_parent(&kit->path, &root)) {
+		/*
+		 * Return NULL, but keep valid kit->path. _destroy() will
+		 * always path_put(&kit->path).
+		 */
+		return NULL;
+	}
+
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
+
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
@@ -333,6 +403,9 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e31f6b0ccb30..2c187c05c06f 100644
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


