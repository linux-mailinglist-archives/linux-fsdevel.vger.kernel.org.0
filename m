Return-Path: <linux-fsdevel+bounces-40446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5CBA236D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660421883E21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36E1F2C5B;
	Thu, 30 Jan 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgciyJ7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705081F131F;
	Thu, 30 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272995; cv=none; b=Lsg+cEfz7yiE+PYKJH86U45+OnT3YW1kmq/oRrwcGFNgfs5tIsqiLPakS4nA7ap3JH9iJ/ynOydcmrW3GvU1E6W4CSzTyGo5tMecjxaeuWNtWl2ZEz3cquweZl/1ke99PK1B87vwb1hP8lklsPBB59N2E5o+46q4quzi43n7vsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272995; c=relaxed/simple;
	bh=HE8mmCbdjixPJC7zTyEKUTMsznoh3OVprbayuWAPsxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQgsEn7LA4EiPs8QDFekTwaQYwuN35zs8nmaZpLgO6oQl5R+MdpTJff80tigdJqstG2XCEwUzdXugoPxVwK7xW7fFY100KUFdpQG74N/OBCmbHU/V/Z+vcoOwezL9VeMKAr/wzCI81IbljpLRuMkz0V++O4PpZINN/PCRxTzkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgciyJ7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1013AC4CED2;
	Thu, 30 Jan 2025 21:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738272994;
	bh=HE8mmCbdjixPJC7zTyEKUTMsznoh3OVprbayuWAPsxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgciyJ7E24Yy4h7sveqFP2yBIwyE6+e1O9+QVV1PQ+5Y9P6jYxOuyJ6auRZGAq0mu
	 lUNIzAfF4NCZEm/s/vHJZVUlbjZe4PE2aGNtpbuk2VPspFvP23zqKKIelganBhwusp
	 3WIZB4exXg7iyOuRc3sSk7GNT7j8Oo9C2f5lS2DIbJ/eUV8H8OJ2JEycyYQNXFrQ7q
	 uXEpwW7fHDfzt/9s7pPEvQc140JWsutAHvRB4wGM3JHvcwYK52WdCt4wO3tpIoZ9P1
	 meW4L+7MqcaRYcjVT746JWUEurDqT53rglXKsA0+eaqqwl5XzvLyrC5EPOlKtQGlF7
	 0UyOkoRZ2QX9g==
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
Subject: [PATCH v12 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
Date: Thu, 30 Jan 2025 13:35:48 -0800
Message-ID: <20250130213549.3353349-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250130213549.3353349-1-song@kernel.org>
References: <20250130213549.3353349-1-song@kernel.org>
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
Acked-by: Christian Brauner <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c      | 189 ++++++++++++++++++++++++++++++++++++++++
 include/linux/bpf_lsm.h |  18 ++++
 kernel/bpf/verifier.c   |  21 +++++
 3 files changed, 228 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index db5c8e855517..08412532db1b 100644
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
@@ -168,6 +170,160 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 
 __bpf_kfunc_end_defs();
 
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
+int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
+				const struct bpf_dynptr *value_p, int flags)
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
+int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
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
+__bpf_kfunc_start_defs();
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
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
@@ -175,6 +331,8 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
@@ -185,6 +343,37 @@ static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
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
+bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
+{
+	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
+}
+
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &bpf_fs_kfunc_set_ids,
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aefcd6564251..643809cc78c3 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -48,6 +48,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
 
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 			     struct bpf_retval_range *range);
+int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
+				const struct bpf_dynptr *value_p, int flags);
+int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
+bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -86,6 +91,19 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
+					      const struct bpf_dynptr *value_p, int flags)
+{
+	return -EOPNOTSUPP;
+}
+static inline int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
+{
+	return -EOPNOTSUPP;
+}
+static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
+{
+	return false;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..04d1d75d9ff9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11766,6 +11766,8 @@ enum special_kfunc_type {
 	KF_bpf_iter_num_new,
 	KF_bpf_iter_num_next,
 	KF_bpf_iter_num_destroy,
+	KF_bpf_set_dentry_xattr,
+	KF_bpf_remove_dentry_xattr,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11795,6 +11797,10 @@ BTF_ID(func, bpf_wq_set_callback_impl)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+#ifdef CONFIG_BPF_LSM
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+#endif
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11844,6 +11850,13 @@ BTF_ID(func, bpf_local_irq_restore)
 BTF_ID(func, bpf_iter_num_new)
 BTF_ID(func, bpf_iter_num_next)
 BTF_ID(func, bpf_iter_num_destroy)
+#ifdef CONFIG_BPF_LSM
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -20924,6 +20937,14 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 		 */
 		env->seen_direct_write = seen_direct_write;
 	}
+
+	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&
+	    bpf_lsm_has_d_inode_locked(prog))
+		*addr = (unsigned long)bpf_set_dentry_xattr_locked;
+
+	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
+	    bpf_lsm_has_d_inode_locked(prog))
+		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
-- 
2.43.5


