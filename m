Return-Path: <linux-fsdevel+bounces-58720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23ABB30A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6131B1D063E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E81ACEDC;
	Fri, 22 Aug 2025 00:11:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A5225D6;
	Fri, 22 Aug 2025 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821486; cv=none; b=Dw7n4fKJKVSX3HXITY4L5fJ5LAl8Cls6WzmvspIdlX5jluJoOYXhmHD/jC2HorqiBP0DhxefPpWiTbiPLr8HNkEYXrsPCsp49qpSL/ox+A35D+S5TQyKxjKDCImeRnFfliEt+RTt7qxdClpBD/pfz3ig8cLDv+x6Z0EC8d2K/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821486; c=relaxed/simple;
	bh=WxoFrYEdzCo87Szu1Wss2RIWhUxh1bJ27GAEEzx+OYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmVOETOfjqGem9y2azsJyzbsqGOtQ3BajfHggZr5LjnqHsfiwCNFM80KhPFienXPgiGuzHp6BIuvgjq8sqmTp+1xdHAqT71Xetw82DE7ntmBudYA4dwSycug13IKo5ssNwfTzow9ek4descSiTRVe+IVJooIIN8cV1cOnTphqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNC-006nb9-HE;
	Fri, 22 Aug 2025 00:11:16 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/16] Use simple_start_creating() in various places.
Date: Fri, 22 Aug 2025 10:00:28 +1000
Message-ID: <20250822000818.1086550-11-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s390/hypfs, android/binder, binfmt_misc,
devpts, nfsd, bpf, apparmour, selinux, security

all create FS objects following the pattern of simple_start_creating().
This patch changes them all to use simple_start_creating() and to clean
up with simple_failed_creating() or simple_end_creating().

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/s390/hypfs/inode.c        | 20 +++++-------
 drivers/android/binderfs.c     | 53 +++++++-------------------------
 fs/binfmt_misc.c               | 30 +++++++-----------
 fs/devpts/inode.c              | 29 +++++++-----------
 fs/nfsd/nfsctl.c               | 56 ++++++++++++++--------------------
 kernel/bpf/inode.c             | 14 ++++-----
 security/apparmor/apparmorfs.c | 37 ++++++----------------
 security/inode.c               | 19 +++---------
 security/selinux/selinuxfs.c   |  8 ++---
 9 files changed, 88 insertions(+), 178 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 96409573c75d..00639f458068 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -341,17 +341,14 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 	struct dentry *dentry;
 	struct inode *inode;
 
-	inode_lock(d_inode(parent));
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		dentry = ERR_PTR(-ENOMEM);
-		goto fail;
-	}
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
+		return ERR_PTR(-ENOMEM);
+
 	inode = hypfs_make_inode(parent->d_sb, mode);
 	if (!inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto fail;
+		simple_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 	}
 	if (S_ISREG(mode)) {
 		inode->i_fop = &hypfs_file_ops;
@@ -367,10 +364,7 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 		BUG();
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
-	dget(dentry);
-fail:
-	inode_unlock(d_inode(parent));
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 struct dentry *hypfs_mkdir(struct dentry *parent, const char *name)
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 0d9d95a7fb60..466e8c0007c3 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -181,28 +181,17 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	}
 
 	root = sb->s_root;
-	inode_lock(d_inode(root));
 
-	/* look it up */
-	dentry = lookup_noperm(&QSTR(name), root);
+	dentry = simple_start_creating(root, name);
 	if (IS_ERR(dentry)) {
-		inode_unlock(d_inode(root));
 		ret = PTR_ERR(dentry);
 		goto err;
 	}
 
-	if (d_really_is_positive(dentry)) {
-		/* already exists */
-		dput(dentry);
-		inode_unlock(d_inode(root));
-		ret = -EEXIST;
-		goto err;
-	}
-
 	inode->i_private = device;
 	d_instantiate(dentry, inode);
 	fsnotify_create(root->d_inode, dentry);
-	inode_unlock(d_inode(root));
+	simple_end_creating(dentry);
 
 	binder_add_device(device);
 
@@ -482,19 +471,7 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
 static struct dentry *binderfs_create_dentry(struct dentry *parent,
 					     const char *name)
 {
-	struct dentry *dentry;
-
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry))
-		return dentry;
-
-	/* Return error if the file/dir already exists. */
-	if (d_really_is_positive(dentry)) {
-		dput(dentry);
-		return ERR_PTR(-EEXIST);
-	}
-
-	return dentry;
+	return simple_start_creating(parent, name);
 }
 
 struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
@@ -506,18 +483,16 @@ struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 	struct super_block *sb;
 
 	parent_inode = d_inode(parent);
-	inode_lock(parent_inode);
 
 	dentry = binderfs_create_dentry(parent, name);
 	if (IS_ERR(dentry))
-		goto out;
+		return dentry;
 
 	sb = parent_inode->i_sb;
 	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
 	if (!new_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto out;
+		simple_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	new_inode->i_fop = fops;
@@ -525,9 +500,7 @@ struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 	d_instantiate(dentry, new_inode);
 	fsnotify_create(parent_inode, dentry);
 
-out:
-	inode_unlock(parent_inode);
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 static struct dentry *binderfs_create_dir(struct dentry *parent,
@@ -538,18 +511,16 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	struct super_block *sb;
 
 	parent_inode = d_inode(parent);
-	inode_lock(parent_inode);
 
 	dentry = binderfs_create_dentry(parent, name);
 	if (IS_ERR(dentry))
-		goto out;
+		return dentry;
 
 	sb = parent_inode->i_sb;
 	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
 	if (!new_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto out;
+		simple_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	new_inode->i_fop = &simple_dir_operations;
@@ -560,9 +531,7 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	inc_nlink(parent_inode);
 	fsnotify_mkdir(parent_inode, dentry);
 
-out:
-	inode_unlock(parent_inode);
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 static int binder_features_show(struct seq_file *m, void *unused)
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a839f960cd4a..dbe56f243174 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -796,28 +796,23 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		revert_creds(old_cred);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
-				 e->interpreter);
+				  e->interpreter);
 			kfree(e);
 			return PTR_ERR(f);
 		}
 		e->interp_file = f;
 	}
 
-	inode_lock(d_inode(root));
-	dentry = lookup_noperm(&QSTR(e->name), root);
+	dentry = simple_start_creating(root, e->name);
 	err = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out;
 
-	err = -EEXIST;
-	if (d_really_is_positive(dentry))
-		goto out2;
-
 	inode = bm_get_inode(sb, S_IFREG | 0644);
 
 	err = -ENOMEM;
 	if (!inode)
-		goto out2;
+		goto out;
 
 	refcount_set(&e->users, 1);
 	e->dentry = dget(dentry);
@@ -830,19 +825,16 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	list_add(&e->list, &misc->entries);
 	write_unlock(&misc->entries_lock);
 
-	err = 0;
-out2:
-	dput(dentry);
+	simple_end_creating(dentry);
+	return count;
+
 out:
-	inode_unlock(d_inode(root));
+	simple_failed_creating(dentry);
 
-	if (err) {
-		if (f)
-			filp_close(f, NULL);
-		kfree(e);
-		return err;
-	}
-	return count;
+	if (f)
+		filp_close(f, NULL);
+	kfree(e);
+	return err;
 }
 
 static const struct file_operations bm_register_operations = {
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index fdf22264a8e9..85c78e133dad 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -259,7 +259,6 @@ static int devpts_parse_param(struct fs_context *fc, struct fs_parameter *param)
 static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 {
 	int mode;
-	int rc = -ENOMEM;
 	struct dentry *dentry;
 	struct inode *inode;
 	struct dentry *root = sb->s_root;
@@ -268,18 +267,15 @@ static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 	kuid_t ptmx_uid = current_fsuid();
 	kgid_t ptmx_gid = current_fsgid();
 
-	inode_lock(d_inode(root));
-
-	/* If we have already created ptmx node, return */
-	if (fsi->ptmx_dentry) {
-		rc = 0;
-		goto out;
-	}
+	dentry = simple_start_creating(root, "ptmx");
+	if (IS_ERR(dentry)) {
+		if (dentry == ERR_PTR(-EEXIST)) {
+			/* If we have already created ptmx node, return */
+			return 0;
+		}
 
-	dentry = d_alloc_name(root, "ptmx");
-	if (!dentry) {
 		pr_err("Unable to alloc dentry for ptmx node\n");
-		goto out;
+		return -ENOMEM;
 	}
 
 	/*
@@ -288,8 +284,8 @@ static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 	inode = new_inode(sb);
 	if (!inode) {
 		pr_err("Unable to alloc inode for ptmx node\n");
-		dput(dentry);
-		goto out;
+		simple_failed_creating(dentry);
+		return -ENOMEM;
 	}
 
 	inode->i_ino = 2;
@@ -302,11 +298,8 @@ static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 
 	d_add(dentry, inode);
 
-	fsi->ptmx_dentry = dentry;
-	rc = 0;
-out:
-	inode_unlock(d_inode(root));
-	return rc;
+	fsi->ptmx_dentry = simple_end_creating(dentry);
+	return 0;
 }
 
 static void update_ptmx_mode(struct pts_fs_info *fsi)
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index bc6b776fc657..e0aac224172c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1147,24 +1147,21 @@ static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *ncl, char *name)
 {
-	struct inode *dir = parent->d_inode;
 	struct dentry *dentry;
-	int ret = -ENOMEM;
+	int ret;
+
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
+		return dentry;
 
-	inode_lock(dir);
-	dentry = d_alloc_name(parent, name);
-	if (!dentry)
-		goto out_err;
 	ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600, ncl);
 	if (ret)
 		goto out_err;
-out:
-	inode_unlock(dir);
-	return dentry;
+	return simple_end_creating(dentry);
+
 out_err:
-	dput(dentry);
-	dentry = ERR_PTR(ret);
-	goto out;
+	simple_failed_creating(dentry);
+	return ERR_PTR(ret);
 }
 
 #if IS_ENABLED(CONFIG_SUNRPC_GSS)
@@ -1193,19 +1190,18 @@ static int __nfsd_symlink(struct inode *dir, struct dentry *dentry,
 static void _nfsd_symlink(struct dentry *parent, const char *name,
 			  const char *content)
 {
-	struct inode *dir = parent->d_inode;
 	struct dentry *dentry;
 	int ret;
 
-	inode_lock(dir);
-	dentry = d_alloc_name(parent, name);
-	if (!dentry)
-		goto out;
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
+		return;
 	ret = __nfsd_symlink(d_inode(parent), dentry, S_IFLNK | 0777, content);
-	if (ret)
-		dput(dentry);
-out:
-	inode_unlock(dir);
+	if (ret) {
+		simple_failed_creating(dentry);
+		return;
+	}
+	simple_end_creating(dentry);
 }
 #else
 static inline void _nfsd_symlink(struct dentry *parent, const char *name,
@@ -1250,30 +1246,24 @@ static  int nfsdfs_create_files(struct dentry *root,
 	struct dentry *dentry;
 	int i;
 
-	inode_lock(dir);
 	for (i = 0; files->name && files->name[0]; i++, files++) {
-		dentry = d_alloc_name(root, files->name);
-		if (!dentry)
-			goto out;
+		dentry = simple_start_creating(root, files->name);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);;
 		inode = nfsd_get_inode(d_inode(root)->i_sb,
 					S_IFREG | files->mode);
 		if (!inode) {
-			dput(dentry);
-			goto out;
+			simple_failed_creating(dentry);
+			return -ENOMEM;
 		}
 		kref_get(&ncl->cl_ref);
 		inode->i_fop = files->ops;
 		inode->i_private = ncl;
 		d_add(dentry, inode);
 		fsnotify_create(dir, dentry);
-		if (fdentries)
-			fdentries[i] = dentry;
+		fdentries[i] = simple_end_creating(dentry);
 	}
-	inode_unlock(dir);
 	return 0;
-out:
-	inode_unlock(dir);
-	return -ENOMEM;
 }
 
 /* on success, returns positive number unique to that client. */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5c2e96b19392..ee50d1a38023 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -420,16 +420,14 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	struct dentry *dentry;
 	int ret;
 
-	inode_lock(parent->d_inode);
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		inode_unlock(parent->d_inode);
-		return PTR_ERR(dentry);
-	}
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
+	return PTR_ERR(dentry);
+
 	ret = bpf_mkobj_ops(dentry, mode, link, &bpf_link_iops,
 			    &bpf_iter_fops);
-	dput(dentry);
-	inode_unlock(parent->d_inode);
+	/* bpf_mkobj_ops took the ref if needed, so we dput() here */
+	dput(simple_end_creating(dentry));
 	return ret;
 }
 
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 391a586d0557..13260352198f 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -280,32 +280,20 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
-	dir = d_inode(parent);
-
-	inode_lock(dir);
-	dentry = lookup_noperm(&QSTR(name), parent);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
-		goto fail_lock;
-	}
-
-	if (d_really_is_positive(dentry)) {
-		error = -EEXIST;
-		goto fail_dentry;
+		goto fail;
 	}
 
 	error = __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iops);
 	if (error)
-		goto fail_dentry;
-	inode_unlock(dir);
-
-	return dentry;
+		goto fail;
 
-fail_dentry:
-	dput(dentry);
+	return simple_end_creating(dentry);
 
-fail_lock:
-	inode_unlock(dir);
+fail:
+	simple_failed_creating(dentry);
 	simple_release_fs(&aafs_mnt, &aafs_count);
 
 	return ERR_PTR(error);
@@ -2567,8 +2555,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	if (error)
 		return error;
 
-	inode_lock(d_inode(parent));
-	dentry = lookup_noperm(&QSTR(NULL_FILE_NAME), parent);
+	dentry = simple_start_creating(parent, NULL_FILE_NAME);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out;
@@ -2576,7 +2563,8 @@ static int aa_mk_null_file(struct dentry *parent)
 	inode = new_inode(parent->d_inode->i_sb);
 	if (!inode) {
 		error = -ENOMEM;
-		goto out1;
+		simple_failed_creating(dentry);
+		goto out;
 	}
 
 	inode->i_ino = get_next_ino();
@@ -2588,18 +2576,13 @@ static int aa_mk_null_file(struct dentry *parent)
 	aa_null.dentry = dget(dentry);
 	aa_null.mnt = mntget(mount);
 
-	error = 0;
+	simple_end_creating(dentry);
 
-out1:
-	dput(dentry);
 out:
-	inode_unlock(d_inode(parent));
 	simple_release_fs(&mount, &count);
 	return error;
 }
 
-
-
 static const char *policy_get_link(struct dentry *dentry,
 				   struct inode *inode,
 				   struct delayed_call *done)
diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..0d2fab99e71e 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -129,20 +129,14 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	dir = d_inode(parent);
 
-	inode_lock(dir);
-	dentry = lookup_noperm(&QSTR(name), parent);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry))
 		goto out;
 
-	if (d_really_is_positive(dentry)) {
-		error = -EEXIST;
-		goto out1;
-	}
-
 	inode = new_inode(dir->i_sb);
 	if (!inode) {
 		error = -ENOMEM;
-		goto out1;
+		goto out;
 	}
 
 	inode->i_ino = get_next_ino();
@@ -161,14 +155,11 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	inode_unlock(dir);
-	return dentry;
+	return simple_end_creating(dentry);
 
-out1:
-	dput(dentry);
-	dentry = ERR_PTR(error);
 out:
-	inode_unlock(dir);
+	simple_failed_creating(dentry);
+	dentry = ERR_PTR(error);
 	if (pinned)
 		simple_release_fs(&mount, &mount_count);
 	return dentry;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9aa1d03ab612..5aa1ad5be587 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1949,15 +1949,16 @@ static const struct inode_operations swapover_dir_inode_operations = {
 static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino)
 {
-	struct dentry *dentry = d_alloc_name(sb->s_root, ".swapover");
+	struct dentry *dentry;
 	struct inode *inode;
 
+	dentry = simple_start_creating(sb->s_root, ".swapover");
 	if (!dentry)
 		return ERR_PTR(-ENOMEM);
 
 	inode = sel_make_inode(sb, S_IFDIR);
 	if (!inode) {
-		dput(dentry);
+		simple_failed_creating(dentry);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1968,8 +1969,7 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 	inode_lock(sb->s_root->d_inode);
 	d_add(dentry, inode);
 	inc_nlink(sb->s_root->d_inode);
-	inode_unlock(sb->s_root->d_inode);
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 #define NULL_FILE_NAME "null"
-- 
2.50.0.107.gf914562f5916.dirty


