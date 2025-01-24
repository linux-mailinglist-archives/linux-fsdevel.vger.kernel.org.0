Return-Path: <linux-fsdevel+bounces-40082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0293A1BD87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D83AF500
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB481DB377;
	Fri, 24 Jan 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7cSTF2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF881DB55D;
	Fri, 24 Jan 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750610; cv=none; b=TA1s3Qsrtx/35JhqtrTWQEi1slA7FyIHPLSXpWaiaCvMFpn7OTNptJA1WZd8TvPZLgUqflFjTpx4UM+Wv5gMGFi6hNKdJ0ZyC5PKZIqgAgjx/Mwji9SHOIBxQRbMsMbGgUwLjITbiJAFSLDL+7VkwvJJXp2YH2PCPRDj1W6p/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750610; c=relaxed/simple;
	bh=ZLMrbPuuHCwP50lgXGWm23z4SsM3rUFrfmuCFt02zzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac8nXbFkoMKOs4EInWVznYkx8Yztwwl0K6R7St0jBOPF6uGIOlXu6W5eootEgLLwz+C83n2qqi3CtxaM58SQrwvyHFJRmdMQ12wKrOq1o+e5ytOR7AYTIRZB1tl+3QlB2UoLc2bMEFrSqDIZ9nKmTILmbt2MFMgrm7fYG94LRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7cSTF2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744A0C4CED2;
	Fri, 24 Jan 2025 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737750610;
	bh=ZLMrbPuuHCwP50lgXGWm23z4SsM3rUFrfmuCFt02zzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7cSTF2tV9xcOYUEH54GdMsarBKKKKcMK/q8aSQVipB8+fd7kb8obW05R1o4+OTTB
	 9VkL6yPxPTWqiImBT6ZPXjlXx7UX5yjfwj2J8Yq/Nfns1XfEwHnMucREX0trzxc8jG
	 M4ImGNjCzoA7229UXJRv0yUMclAivsaO6MkVKyHjfnXtJkSiNgIonhocCkDuXrQDqh
	 dmCGpzN+E+cuDTJcz7m+0XUip4JLSCA3C0dugvFD/l5SxVdkcPH0VsMmUoru3rr+dM
	 JKcPP1Wp9Xcmsjc4d5vGMDNH2OxagUl+Hs14rukgu898dojgG0rPFkJaZA9Nc9XV/Z
	 CbttehKw2KPqg==
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
Subject: [PATCH v10 bpf-next 6/7] bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
Date: Fri, 24 Jan 2025 12:29:10 -0800
Message-ID: <20250124202911.3264715-7-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124202911.3264715-1-song@kernel.org>
References: <20250124202911.3264715-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following kfuncs to set and remove xattrs from BPF programs:

  bpf_set_dentry_xattr
  bpf_remove_dentry_xattr
  bpf_set_dentry_xattr_locked
  bpf_remove_dentry_xattr_locked

The _locked version of these kfuncs are called from hooks where
dentry->d_inode is already locked. Instead of requiring the user
to know which version of the kfuncs to use, the verifier will pick
the proper kfunc based on the calling hook.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c      | 219 +++++++++++++++++++++++++++++++++++++++-
 include/linux/bpf_lsm.h |   2 +
 2 files changed, 219 insertions(+), 2 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 8a65184c8c2c..28a0ec5516af 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -2,10 +2,12 @@
 /* Copyright (c) 2024 Google LLC. */
 
 #include <linux/bpf.h>
+#include <linux/bpf_lsm.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/dcache.h>
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
@@ -161,6 +163,156 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+static int bpf_xattr_write_permission(const char *name, struct inode *inode)
+{
+	if (WARN_ON(!inode))
+		return -EINVAL;
+
+	/* Only allow setting and removing security.bpf. xattrs */
+	if (!match_security_bpf_prefix(name))
+		return -EPERM;
+
+	return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
+}
+
+/**
+ * bpf_set_dentry_xattr_locked - set a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: xattr value
+ * @flags: flags to pass into filesystem operations
+ *
+ * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller already locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
+					    const struct bpf_dynptr *value_p, int flags)
+{
+
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	struct inode *inode = d_inode(dentry);
+	const void *value;
+	u32 value_len;
+	int ret;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	ret = bpf_xattr_write_permission(name__str, inode);
+	if (ret)
+		return ret;
+
+	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name__str,
+			     value, value_len, flags);
+	if (!ret) {
+		fsnotify_xattr(dentry);
+
+		/* This xattr is set by BPF LSM, so we do not call
+		 * security_inode_post_setxattr. Otherwise, we would
+		 * risk deadlocks by calling back to the same kfunc.
+		 *
+		 * This is the same as security_inode_setsecurity().
+		 */
+	}
+	return ret;
+}
+
+/**
+ * bpf_set_dentry_xattr - set a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: xattr value
+ * @flags: flags to pass into filesystem operations
+ *
+ * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller has not locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     const struct bpf_dynptr *value_p, int flags)
+{
+	struct inode *inode = d_inode(dentry);
+	int ret;
+
+	inode_lock(inode);
+	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
+	inode_unlock(inode);
+	return ret;
+}
+
+/**
+ * bpf_remove_dentry_xattr_locked - remove a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ *
+ * Rmove xattr *name__str* of *dentry*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller already locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
+{
+	struct inode *inode = d_inode(dentry);
+	int ret;
+
+	ret = bpf_xattr_write_permission(name__str, inode);
+	if (ret)
+		return ret;
+
+	ret = __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
+	if (!ret) {
+		fsnotify_xattr(dentry);
+
+		/* This xattr is removed by BPF LSM, so we do not call
+		 * security_inode_post_removexattr. Otherwise, we would
+		 * risk deadlocks by calling back to the same kfunc.
+		 */
+	}
+	return ret;
+}
+
+/**
+ * bpf_remove_dentry_xattr - remove a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ *
+ * Rmove xattr *name__str* of *dentry*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller has not locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str)
+{
+	struct inode *inode = d_inode(dentry);
+	int ret;
+
+	inode_lock(inode);
+	ret = bpf_remove_dentry_xattr_locked(dentry, name__str);
+	inode_unlock(inode);
+	return ret;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -170,20 +322,83 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
+BTF_HIDDEN_KFUNCS_START(bpf_fs_kfunc_hidden_set_ids)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_fs_kfunc_hidden_set_ids)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) &&
+	    !btf_id_set8_contains(&bpf_fs_kfunc_hidden_set_ids, kfunc_id))
+		return 0;
+	if (prog->type == BPF_PROG_TYPE_LSM)
 		return 0;
 	return -EACCES;
 }
 
+/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
+ * KF_SLEEPABLE, so they are only available to sleepable hooks with
+ * dentry arguments.
+ *
+ * Setting and removing xattr requires exclusive lock on dentry->d_inode.
+ * Some hooks already locked d_inode, while some hooks have not locked
+ * d_inode. Therefore, we need different kfuncs for different hooks.
+ * Specifically, hooks in the following list (d_inode_locked_hooks)
+ * should call bpf_[set|remove]_dentry_xattr_locked; while other hooks
+ * should call bpf_[set|remove]_dentry_xattr.
+ */
+BTF_SET_START(d_inode_locked_hooks)
+BTF_ID(func, bpf_lsm_inode_post_removexattr)
+BTF_ID(func, bpf_lsm_inode_post_setattr)
+BTF_ID(func, bpf_lsm_inode_post_setxattr)
+BTF_ID(func, bpf_lsm_inode_removexattr)
+BTF_ID(func, bpf_lsm_inode_rmdir)
+BTF_ID(func, bpf_lsm_inode_setattr)
+BTF_ID(func, bpf_lsm_inode_setxattr)
+BTF_ID(func, bpf_lsm_inode_unlink)
+#ifdef CONFIG_SECURITY_PATH
+BTF_ID(func, bpf_lsm_path_unlink)
+BTF_ID(func, bpf_lsm_path_rmdir)
+#endif /* CONFIG_SECURITY_PATH */
+BTF_SET_END(d_inode_locked_hooks)
+
+static bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
+{
+	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
+}
+
+BTF_ID_LIST(not_locked_fs_kfuncs)
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+
+BTF_ID_LIST(locked_fs_kfuncs)
+BTF_ID(func, bpf_set_dentry_xattr_locked)
+BTF_ID(func, bpf_remove_dentry_xattr_locked)
+
+static u32 bpf_fs_kfunc_remap(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!bpf_lsm_has_d_inode_locked(prog))
+		return 0;
+
+	if (kfunc_id == not_locked_fs_kfuncs[0])
+		return locked_fs_kfuncs[0];
+	if (kfunc_id == not_locked_fs_kfuncs[1])
+		return locked_fs_kfuncs[1];
+
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &bpf_fs_kfunc_set_ids,
+	.hidden_set = &bpf_fs_kfunc_hidden_set_ids,
 	.filter = bpf_fs_kfuncs_filter,
+	.remap = bpf_fs_kfunc_remap,
 };
 
 static int __init bpf_fs_kfuncs_init(void)
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aefcd6564251..f4ab0dc1df69 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -48,6 +48,7 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
 
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 			     struct bpf_retval_range *range);
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -86,6 +87,7 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 {
 	return -EOPNOTSUPP;
 }
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
-- 
2.43.5


