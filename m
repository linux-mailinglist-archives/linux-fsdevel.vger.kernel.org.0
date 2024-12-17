Return-Path: <linux-fsdevel+bounces-37607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1355C9F43E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB50168926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68234189B8F;
	Tue, 17 Dec 2024 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4l8d8Sb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F616EB7C;
	Tue, 17 Dec 2024 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417539; cv=none; b=D7GPOmVNxl8bKdYlP1nBqulljK73afl6r4NQ6tD23PTYSQHBpnjI+NPA11kUAl/wubhHD/WIb9/tv2Ow7WBuLKi4fQk+iqwIpVRQea031NnPwVNkhKmyAJ5PW4dz1klUMi0avRpPbebomykz5V7pvBCSuUaj3fMy7P4iBo0lXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417539; c=relaxed/simple;
	bh=f5+i1QTWEI38UXaXFdF3fywxj5TrxmIUcKHLqy0rKok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiUnsve5NogAyNxB7CddrU8gkjD/q1PnCT/XSObIMyEyHrMf/+szTG3jxPsbOnSTEf3EMk9j7Hz+HHM2FPxjH0Hruf1zSinHjWqTx3Iptmty3Pcrzb2VLnljoSTEq1cK+SjF9LguFi6caDWFgI8+dNXemh85QiFEFw1Z911x5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4l8d8Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ACAC4CED3;
	Tue, 17 Dec 2024 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734417539;
	bh=f5+i1QTWEI38UXaXFdF3fywxj5TrxmIUcKHLqy0rKok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4l8d8SbqpR+Lssh3LDYhnVjgyzZJkMZrQJz4SFHPGzVtG7x9QSpVy1IkCTeGuS6B
	 kNOIzckFSZyuvQQGNP55+C9XTTEZWctrKnLLkGZlRd0jHR6asE2YfHdLW2YUeNqgPk
	 NJ4YzQVFt5Lrd58541s4hxuvaVkSVs8exBn1LF0lSCVNoS4rkZN5OcBleGYdFUCalb
	 es3gCkFe+JTx9Ku2hFyJgChO811obkzTLuz38BLMEUDhAZ+siaoiLSj/ZOydhuAr9O
	 Mb+ydtGJgCM6rmImZzAKdWYWhu1AgVwY5LOHZFuyBloCu8VoRIzuzRJxdC7M4179bh
	 L/v4V2XrRW8Hw==
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
Subject: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
Date: Mon, 16 Dec 2024 22:38:19 -0800
Message-ID: <20241217063821.482857-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217063821.482857-1-song@kernel.org>
References: <20241217063821.482857-1-song@kernel.org>
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
dentry->d_inode is already locked.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 243 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 8a65184c8c2c..3261324e956c 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -6,6 +6,7 @@
 #include <linux/btf_ids.h>
 #include <linux/dcache.h>
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
@@ -161,6 +162,164 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
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
+static int __bpf_set_dentry_xattr(struct dentry *dentry, const char *name,
+				  const struct bpf_dynptr *value_p, int flags, bool lock_inode)
+{
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
+	if (lock_inode)
+		inode_lock(inode);
+
+	ret = bpf_xattr_write_permission(name, inode);
+	if (ret)
+		goto out;
+
+	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name,
+			     value, value_len, flags);
+	if (!ret) {
+		fsnotify_xattr(dentry);
+
+		/* This xattr is set by BPF LSM, so we do not call
+		 * security_inode_post_setxattr. This is the same as
+		 * security_inode_setsecurity().
+		 */
+	}
+out:
+	if (lock_inode)
+		inode_unlock(inode);
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
+	return __bpf_set_dentry_xattr(dentry, name__str, value_p, flags, true);
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
+	return __bpf_set_dentry_xattr(dentry, name__str, value_p, flags, false);
+}
+
+static int __bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     bool lock_inode)
+{
+	struct inode *inode = d_inode(dentry);
+	int ret;
+
+	if (lock_inode)
+		inode_lock(inode);
+
+	ret = bpf_xattr_write_permission(name__str, inode);
+	if (ret)
+		goto out;
+
+	ret = __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
+	if (!ret) {
+		fsnotify_xattr(dentry);
+
+		/* This xattr is removed by BPF LSM, so we do not call
+		 * security_inode_post_removexattr.
+		 */
+	}
+out:
+	if (lock_inode)
+		inode_unlock(inode);
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
+	return __bpf_remove_dentry_xattr(dentry, name__str, true);
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
+	return __bpf_remove_dentry_xattr(dentry, name__str, false);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -186,9 +345,91 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.filter = bpf_fs_kfuncs_filter,
 };
 
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
+BTF_KFUNCS_START(bpf_write_xattr_set_ids)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_write_xattr_set_ids)
+
+static int bpf_write_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_write_xattr_set_ids, kfunc_id))
+		return 0;
+	if (prog->type != BPF_PROG_TYPE_LSM)
+		return -EACCES;
+
+	if (bpf_lsm_has_d_inode_locked(prog))
+		return -EINVAL;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_write_xattr_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_write_xattr_set_ids,
+	.filter = bpf_write_xattr_filter,
+};
+
+BTF_KFUNCS_START(bpf_write_xattr_locked_set_ids)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_write_xattr_locked_set_ids)
+
+static int bpf_write_xattr_locked_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_write_xattr_locked_set_ids, kfunc_id))
+		return 0;
+	if (prog->type != BPF_PROG_TYPE_LSM)
+		return -EACCES;
+
+	if (!bpf_lsm_has_d_inode_locked(prog))
+		return -EINVAL;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_write_xattr_locked_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_write_xattr_locked_set_ids,
+	.filter = bpf_write_xattr_locked_filter,
+};
+
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_write_xattr_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_write_xattr_locked_set);
+	return ret;
 }
 
 late_initcall(bpf_fs_kfuncs_init);
-- 
2.43.5


