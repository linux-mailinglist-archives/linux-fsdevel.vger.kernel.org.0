Return-Path: <linux-fsdevel+bounces-43994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF639A60828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8DB19C3604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B615666B;
	Fri, 14 Mar 2025 04:57:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E848632B;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928233; cv=none; b=od5hkFW26jOQgtyWMrws1fDYVMpwf/Oy60DbbcVlhPN+t43Br9b0o/CAhPXTV+4LFZyHbwjX7SKWyiO06g2M29DGxTAieghB1PKsUKnu7rTsqoRdPPQVQwh5tP6mSemABCyVwB/t15Z3K2r2ZXhCFF9muXjohVvE+ZT4T4SwsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928233; c=relaxed/simple;
	bh=XBSTY8FMAGV1BO2RGaSAPnh7agffMsWQ7gSERDdUrBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1kpdtO4ctDWMbv6rhCvSJU1ZT8nJzyDt0BJZmQwWkiaM1egEIFuJ3/VKCFqGn9K62wKogyAyHDWXmCQ2FN/3eNEZQg38xyV5fKh8CUs+fSyGa/gn24X0Ok5yk+LTZeq8ZLjxUaqZ35jKcgi4TX85EAWFsSxh6STR+7ZYoh7Y98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6Z-00E3vt-SY;
	Fri, 14 Mar 2025 04:57:07 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] VFS: rename lookup_one_len() family to lookup_noperm() and remove permission check
Date: Fri, 14 Mar 2025 11:34:12 +1100
Message-ID: <20250314045655.603377-7-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314045655.603377-1-neil@brown.name>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lookup_one_len family of functions is (now) only used internally by
a filesystem on itself either
- in a context where permission checking is irrelevant such as by a
  virtual filesystem populating itself, or xfs accessing its ORPHANAGE
  or dquota accessing the quota file; or
- in a context where a permission check (MAY_EXEC on the parent) has just
  been performed such as a network filesystem finding a "silly-rename"
  file in the same directory.  This is also the context after the
  _parentat() functions where currently lookup_one_qstr_excl() is used.

So the permission check is pointless and given that nop_mnt_idmap is
currently used, it is possibly erroneous on a idmapped mount.

The name "one_len" is unhelpful in understanding the purpose of these
functions and should be changed.  Most of the callers pass the len as
"strlen()" so using a qstr and QSTR() can simplify the code.

This patch renames these functions (include lookup_positive_unlocked()
which is part of the family despite the name) to have a name based on
"lookup_noperm".  They are changed to receive a 'struct qstr' instead
of separate name and len.  In a few cases the use of QSTR() results in a
new call to strlen().

try_lookup_noperm() takes a pointer to a qstr instead of the whole
qstr.  This is consistent with d_hash_and_lookup() (which is nearly
identical) and useful for lookup_noperm_unlocked().

The new lookup_noperm_common() doesn't take a qstr yet.  That will be
tidied up in a subsequent patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 20 +++++++
 arch/s390/hypfs/inode.c               |  2 +-
 drivers/android/binderfs.c            |  4 +-
 drivers/infiniband/hw/qib/qib_fs.c    |  4 +-
 fs/afs/dir.c                          |  2 +-
 fs/afs/dir_silly.c                    |  6 +-
 fs/autofs/dev-ioctl.c                 |  3 +-
 fs/binfmt_misc.c                      |  2 +-
 fs/debugfs/inode.c                    |  6 +-
 fs/ecryptfs/inode.c                   | 16 +++---
 fs/kernfs/mount.c                     |  4 +-
 fs/namei.c                            | 82 ++++++++++++++-------------
 fs/nfs/unlink.c                       | 11 ++--
 fs/overlayfs/export.c                 |  6 +-
 fs/overlayfs/namei.c                  |  2 +-
 fs/quota/dquot.c                      |  2 +-
 fs/smb/client/cached_dir.c            |  5 +-
 fs/smb/client/cifsfs.c                |  3 +-
 fs/tracefs/inode.c                    |  2 +-
 fs/xfs/scrub/orphanage.c              |  3 +-
 include/linux/namei.h                 |  8 +--
 ipc/mqueue.c                          |  5 +-
 kernel/bpf/inode.c                    |  2 +-
 security/apparmor/apparmorfs.c        |  4 +-
 security/inode.c                      |  2 +-
 25 files changed, 113 insertions(+), 93 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 481b2656d7a0..49a7be912e5f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1206,3 +1206,23 @@ take a vfsmount instead of a mnt_idmap, and a qstr instead of a name and len.
 These, not the "one_len" versions, should be used whenever accessing a
 filesystem from outside that filesysmtem, through a mount point - unless
 a permission check has already been performed.
+
+---
+
+** mandatory**
+
+Functions try_lookup_one_len(), lookup_one_len(),
+lookup_one_len_unlocked() and lookup_positive_unlocked() have been
+renamed to try_lookup_noperm(), lookup_noperm(),
+lookup_noperm_unlocked(), lookup_noperm_positive_unlocked().  They now
+take a qstr instead of separate name and length.  QSTR() can be used
+when strlen() is needed for the length.
+
+For try_lookup_noperm() a reference to the qstr is passed in case the
+hash might subsequently be needed.
+
+These function no longer do any permission checking - they previously
+checked that the caller has 'X' permission on the parent.  They must
+ONLY be used internally by a filesystem on itself when it knows that
+permissions are irrelevant or in a context where permission checks have
+already been performed such as after vfs_path_parent_lookup()
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index d428635abf08..2eed957393f4 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -341,7 +341,7 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 	struct inode *inode;
 
 	inode_lock(d_inode(parent));
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_noperm(QSTR(name), parent);
 	if (IS_ERR(dentry)) {
 		dentry = ERR_PTR(-ENOMEM);
 		goto fail;
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index bc6bae76ccaf..172e825168c8 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -187,7 +187,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	inode_lock(d_inode(root));
 
 	/* look it up */
-	dentry = lookup_one_len(name, root, name_len);
+	dentry = lookup_noperm(QSTR(name), root);
 	if (IS_ERR(dentry)) {
 		inode_unlock(d_inode(root));
 		ret = PTR_ERR(dentry);
@@ -486,7 +486,7 @@ static struct dentry *binderfs_create_dentry(struct dentry *parent,
 {
 	struct dentry *dentry;
 
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_noperm(QSTR(name), parent);
 	if (IS_ERR(dentry))
 		return dentry;
 
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index b27791029fa9..c3aa40c3fb8f 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -89,7 +89,7 @@ static int create_file(const char *name, umode_t mode,
 	int error;
 
 	inode_lock(d_inode(parent));
-	*dentry = lookup_one_len(name, parent, strlen(name));
+	*dentry = lookup_noperm(QSTR(name), parent);
 	if (!IS_ERR(*dentry))
 		error = qibfs_mknod(d_inode(parent), *dentry,
 				    mode, fops, data);
@@ -432,7 +432,7 @@ static int remove_device_files(struct super_block *sb,
 	char unit[10];
 
 	snprintf(unit, sizeof(unit), "%u", dd->unit);
-	dir = lookup_one_len_unlocked(unit, sb->s_root, strlen(unit));
+	dir = lookup_noperm_unlocked(QSTR(unit), sb->s_root);
 
 	if (IS_ERR(dir)) {
 		pr_err("Lookup of %s failed\n", unit);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5bddcc20786e..0e633535d2c7 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -943,7 +943,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_one_len(buf, dentry->d_parent, len);
+		ret = lookup_noperm(QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index a1e581946b93..292a5c8c752a 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -113,16 +113,14 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 
 	sdentry = NULL;
 	do {
-		int slen;
-
 		dput(sdentry);
 		sillycounter++;
 
 		/* Create a silly name.  Note that the ".__afs" prefix is
 		 * understood by the salvager and must not be changed.
 		 */
-		slen = scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
-		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
+		scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
+		sdentry = lookup_noperm(QSTR(silly), dentry->d_parent);
 
 		/* N.B. Better to return EBUSY here ... it could be dangerous
 		 * to delete the file while it's in use.
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 6d57efbb8110..a577b175c38a 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -461,7 +461,8 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
 				"prevent shutdown\n");
 
 		inode_lock_shared(inode);
-		dentry = try_lookup_one_len(param->path, base, path_len);
+		dentry = try_lookup_noperm(&QSTR_LEN(param->path, path_len),
+					   base);
 		inode_unlock_shared(inode);
 		if (IS_ERR_OR_NULL(dentry))
 			return dentry ? PTR_ERR(dentry) : -ENOENT;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5a7ebd160724..f0996a76ee7c 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -842,7 +842,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	}
 
 	inode_lock(d_inode(root));
-	dentry = lookup_one_len(e->name, root, strlen(e->name));
+	dentry = lookup_noperm(QSTR(e->name), root);
 	err = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 75715d8877ee..feb5ccb5bba8 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -346,7 +346,7 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
-	dentry = lookup_positive_unlocked(name, parent, strlen(name));
+	dentry = lookup_noperm_positive_unlocked(QSTR(name), parent);
 	if (IS_ERR(dentry))
 		return NULL;
 	return dentry;
@@ -388,7 +388,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	if (unlikely(IS_DEADDIR(d_inode(parent))))
 		dentry = ERR_PTR(-ENOENT);
 	else
-		dentry = lookup_one_len(name, parent, strlen(name));
+		dentry = lookup_noperm(QSTR(name), parent);
 	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
 		if (d_is_dir(dentry))
 			pr_err("Directory '%s' with parent '%s' already present!\n",
@@ -872,7 +872,7 @@ int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, .
 	}
 	if (strcmp(old_name.name.name, new_name) == 0)
 		goto out;
-	target = lookup_one_len(new_name, parent, strlen(new_name));
+	target = lookup_noperm(QSTR(new_name), parent);
 	if (IS_ERR(target)) {
 		error = PTR_ERR(target);
 		goto out;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 51a5c54eb740..9a0d40bb43d6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -394,8 +394,8 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 	char *encrypted_and_encoded_name = NULL;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
 	struct dentry *lower_dir_dentry, *lower_dentry;
-	const char *name = ecryptfs_dentry->d_name.name;
-	size_t len = ecryptfs_dentry->d_name.len;
+	struct qstr qname = QSTR_INIT(ecryptfs_dentry->d_name.name,
+				      ecryptfs_dentry->d_name.len);
 	struct dentry *res;
 	int rc = 0;
 
@@ -404,23 +404,25 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 				ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
+		size_t len = qname.len;
 		rc = ecryptfs_encrypt_and_encode_filename(
 			&encrypted_and_encoded_name, &len,
-			mount_crypt_stat, name, len);
+			mount_crypt_stat, qname.name, len);
 		if (rc) {
 			printk(KERN_ERR "%s: Error attempting to encrypt and encode "
 			       "filename; rc = [%d]\n", __func__, rc);
 			return ERR_PTR(rc);
 		}
-		name = encrypted_and_encoded_name;
+		qname.name = encrypted_and_encoded_name;
+		qname.len = len;
 	}
 
-	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
+	lower_dentry = lookup_noperm_unlocked(qname, lower_dir_dentry);
 	if (IS_ERR(lower_dentry)) {
-		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
+		ecryptfs_printk(KERN_DEBUG, "%s: lookup_noperm() returned "
 				"[%ld] on lower_dentry = [%s]\n", __func__,
 				PTR_ERR(lower_dentry),
-				name);
+				qname.name);
 		res = ERR_CAST(lower_dentry);
 	} else {
 		res = ecryptfs_lookup_interpose(ecryptfs_dentry, lower_dentry);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1..46943a7fb4df 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -233,8 +233,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+		dtmp = lookup_noperm_positive_unlocked(QSTR(kntmp->name),
+							 dentry);
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/namei.c b/fs/namei.c
index fb8dbabc5cbf..f89ed09c0b0b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2833,9 +2833,9 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_one_common(struct mnt_idmap *idmap,
-			     const char *name, struct dentry *base, int len,
-			     struct qstr *this)
+static int lookup_noperm_common(const char *name, struct dentry *base,
+				  int len,
+				  struct qstr *this)
 {
 	this->name = name;
 	this->len = len;
@@ -2860,51 +2860,59 @@ static int lookup_one_common(struct mnt_idmap *idmap,
 		if (err < 0)
 			return err;
 	}
+	return 0;
+}
 
+static int lookup_one_common(struct mnt_idmap *idmap,
+			     const char *name, struct dentry *base, int len,
+			     struct qstr *this) {
+	int err;
+	err = lookup_noperm_common(name, base, len, this);
+	if (err < 0)
+		return err;
 	return inode_permission(idmap, base->d_inode, MAY_EXEC);
 }
 
 /**
- * try_lookup_one_len - filesystem helper to lookup single pathname component
- * @name:	pathname component to lookup
+ * try_lookup_noperm - filesystem helper to lookup single pathname component
+ * @name:	qstr storing pathname component to lookup
  * @base:	base directory to lookup from
- * @len:	maximum length @len should be interpreted to
  *
  * Look up a dentry by name in the dcache, returning NULL if it does not
  * currently exist.  The function does not try to create a dentry.
  *
  * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.
+ * not be called by generic code.  It does no permission checking.
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len)
+struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
 {
 	struct qstr this;
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
+	err = lookup_noperm_common(name->name, base, name->len, &this);
 	if (err)
 		return ERR_PTR(err);
 
-	return lookup_dcache(&this, base, 0);
+	name->hash = this.hash;
+	return lookup_dcache(name, base, 0);
 }
-EXPORT_SYMBOL(try_lookup_one_len);
+EXPORT_SYMBOL(try_lookup_noperm);
 
 /**
- * lookup_one_len - filesystem helper to lookup single pathname component
- * @name:	pathname component to lookup
+ * lookup_noperm - filesystem helper to lookup single pathname component
+ * @name:	qstr storing pathname component to lookup
  * @base:	base directory to lookup from
- * @len:	maximum length @len should be interpreted to
  *
  * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.
+ * not be called by generic code.  It does no permission checking.
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
+struct dentry *lookup_noperm(struct qstr name, struct dentry *base)
 {
 	struct dentry *dentry;
 	struct qstr this;
@@ -2912,14 +2920,14 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
+	err = lookup_noperm_common(name.name, base, name.len, &this);
 	if (err)
 		return ERR_PTR(err);
 
 	dentry = lookup_dcache(&this, base, 0);
 	return dentry ? dentry : __lookup_slow(&this, base, 0);
 }
-EXPORT_SYMBOL(lookup_one_len);
+EXPORT_SYMBOL(lookup_noperm);
 
 /**
  * lookup_one - lookup single pathname component
@@ -2957,7 +2965,7 @@ EXPORT_SYMBOL(lookup_one);
  *
  * This can be used for in-kernel filesystem clients such as file servers.
  *
- * Unlike lookup_one_len, it should be called without the parent
+ * Unlike lookup_one, it should be called without the parent
  * i_rwsem held, and will take the i_rwsem itself if necessary.
  */
 struct dentry *lookup_one_unlocked(struct vfsmount *mnt,
@@ -3010,47 +3018,41 @@ struct dentry *lookup_one_positive_unlocked(struct vfsmount *mnt,
 EXPORT_SYMBOL(lookup_one_positive_unlocked);
 
 /**
- * lookup_one_len_unlocked - filesystem helper to lookup single pathname component
+ * lookup_noperm_unlocked - filesystem helper to lookup single pathname component
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
  *
  * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.
+ * not be called by generic code. It does no permission checking.
  *
- * Unlike lookup_one_len, it should be called without the parent
- * i_mutex held, and will take the i_mutex itself if necessary.
+ * Unlike lookup_noperm, it should be called without the parent
+ * i_rwsem held, and will take the i_rwsem itself if necessary.
  */
-struct dentry *lookup_one_len_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_noperm_unlocked(struct qstr name,
+					struct dentry *base)
 {
-	struct qstr this;
-	int err;
 	struct dentry *ret;
 
-	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
-	if (err)
-		return ERR_PTR(err);
-
-	ret = lookup_dcache(&this, base, 0);
+	ret = try_lookup_noperm(&name, base);
 	if (!ret)
-		ret = lookup_slow(&this, base, 0);
+		ret = lookup_slow(&name, base, 0);
 	return ret;
 }
-EXPORT_SYMBOL(lookup_one_len_unlocked);
+EXPORT_SYMBOL(lookup_noperm_unlocked);
 
 /*
- * Like lookup_one_len_unlocked(), except that it yields ERR_PTR(-ENOENT)
+ * Like lookup_noperm_unlocked(), except that it yields ERR_PTR(-ENOENT)
  * on negatives.  Returns known positive or ERR_PTR(); that's what
  * most of the users want.  Note that pinned negative with unlocked parent
- * _can_ become positive at any time, so callers of lookup_one_len_unlocked()
+ * _can_ become positive at any time, so callers of lookup_noperm_unlocked()
  * need to be very careful; pinned positives have ->d_inode stable, so
  * this one avoids such problems.
  */
-struct dentry *lookup_positive_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_noperm_positive_unlocked(struct qstr name,
+						 struct dentry *base)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	struct dentry *ret = lookup_noperm_unlocked(name, base);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
@@ -3058,7 +3060,7 @@ struct dentry *lookup_positive_unlocked(const char *name,
 	}
 	return ret;
 }
-EXPORT_SYMBOL(lookup_positive_unlocked);
+EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index bf77399696a7..f52e57c31ae4 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -464,18 +464,17 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 
 	sdentry = NULL;
 	do {
-		int slen;
 		dput(sdentry);
 		sillycounter++;
-		slen = scnprintf(silly, sizeof(silly),
-				SILLYNAME_PREFIX "%0*llx%0*x",
-				SILLYNAME_FILEID_LEN, fileid,
-				SILLYNAME_COUNTER_LEN, sillycounter);
+		scnprintf(silly, sizeof(silly),
+			  SILLYNAME_PREFIX "%0*llx%0*x",
+			  SILLYNAME_FILEID_LEN, fileid,
+			  SILLYNAME_COUNTER_LEN, sillycounter);
 
 		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
 				dentry, silly);
 
-		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
+		sdentry = lookup_noperm(QSTR(silly), dentry->d_parent);
 		/*
 		 * N.B. Better to return EBUSY here ... it could be
 		 * dangerous to delete the file while it's in use.
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 444aeeccb6da..a51025e8b2d0 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -385,11 +385,9 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 */
 	take_dentry_name_snapshot(&name, real);
 	/*
-	 * No idmap handling here: it's an internal lookup.  Could skip
-	 * permission checking altogether, but for now just use non-idmap
-	 * transformed ids.
+	 * No idmap handling here: it's an internal lookup.
 	 */
-	this = lookup_one_len(name.name.name, connected, name.name.len);
+	this = lookup_noperm(name.name, connected);
 	release_dentry_name_snapshot(&name);
 	err = PTR_ERR(this);
 	if (IS_ERR(this)) {
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 7ee0c43e6630..46fa8a41f6cc 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -758,7 +758,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->workdir, name.len);
+	index = lookup_noperm_positive_unlocked(name, ofs->workdir);
 	kfree(name.name);
 	if (IS_ERR(index)) {
 		if (PTR_ERR(index) == -ENOENT)
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 825c5c2e0962..ea426467f26b 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2560,7 +2560,7 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 	struct dentry *dentry;
 	int error;
 
-	dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name));
+	dentry = lookup_noperm_positive_unlocked(QSTR(qf_name), sb->s_root);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index fe738623cf1b..64308cccd1be 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -109,7 +109,8 @@ path_to_dentry(struct cifs_sb_info *cifs_sb, const char *path)
 		while (*s && *s != sep)
 			s++;
 
-		child = lookup_positive_unlocked(p, dentry, s - p);
+		child = lookup_noperm_positive_unlocked(QSTR_LEN(p, s - p),
+							dentry);
 		dput(dentry);
 		dentry = child;
 	} while (!IS_ERR(dentry));
@@ -207,7 +208,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	spin_unlock(&cfids->cfid_list_lock);
 
 	/*
-	 * Skip any prefix paths in @path as lookup_positive_unlocked() ends up
+	 * Skip any prefix paths in @path as lookup_noperm_positive_unlocked() ends up
 	 * calling ->lookup() which already adds those through
 	 * build_path_from_dentry().  Also, do it earlier as we might reconnect
 	 * below when trying to send compounded request and then potentially
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 6a3bd652d251..71eadc0305b5 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -925,7 +925,8 @@ cifs_get_root(struct smb3_fs_context *ctx, struct super_block *sb)
 		while (*s && *s != sep)
 			s++;
 
-		child = lookup_positive_unlocked(p, dentry, s - p);
+		child = lookup_noperm_positive_unlocked(QSTR_LEN(p, s - p),
+							dentry);
 		dput(dentry);
 		dentry = child;
 	} while (!IS_ERR(dentry));
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index cb1af30b49f5..aa7982e9b579 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -555,7 +555,7 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 	if (unlikely(IS_DEADDIR(d_inode(parent))))
 		dentry = ERR_PTR(-ENOENT);
 	else
-		dentry = lookup_one_len(name, parent, strlen(name));
+		dentry = lookup_noperm(QSTR(name), parent);
 	if (!IS_ERR(dentry) && d_inode(dentry)) {
 		dput(dentry);
 		dentry = ERR_PTR(-EEXIST);
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 3537f3cca6d5..987af5b2bb82 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -153,8 +153,7 @@ xrep_orphanage_create(
 
 	/* Try to find the orphanage directory. */
 	inode_lock_nested(root_inode, I_MUTEX_PARENT);
-	orphanage_dentry = lookup_one_len(ORPHANAGE, root_dentry,
-			strlen(ORPHANAGE));
+	orphanage_dentry = lookup_noperm(QSTR(ORPHANAGE), root_dentry);
 	if (IS_ERR(orphanage_dentry)) {
 		error = PTR_ERR(orphanage_dentry);
 		goto out_unlock_root;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5df2c1a4af25..6492c0c85049 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -69,10 +69,10 @@ int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
-extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
-extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
+extern struct dentry *try_lookup_noperm(struct qstr *, struct dentry *);
+extern struct dentry *lookup_noperm(struct qstr, struct dentry *);
+extern struct dentry *lookup_noperm_unlocked(struct qstr, struct dentry *);
+extern struct dentry *lookup_noperm_positive_unlocked(struct qstr, struct dentry *);
 struct dentry *lookup_one(struct vfsmount *, struct qstr, struct dentry *);
 struct dentry *lookup_one_unlocked(struct vfsmount *mnt,
 				   struct qstr name, struct dentry *base);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 35b4f8659904..f3d76c4b6013 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -913,7 +913,7 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 
 	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
 	inode_lock(d_inode(root));
-	path.dentry = lookup_one_len(name->name, root, strlen(name->name));
+	path.dentry = lookup_noperm(QSTR(name->name), root);
 	if (IS_ERR(path.dentry)) {
 		error = PTR_ERR(path.dentry);
 		goto out_putfd;
@@ -969,8 +969,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 	if (err)
 		goto out_name;
 	inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
-	dentry = lookup_one_len(name->name, mnt->mnt_root,
-				strlen(name->name));
+	dentry = lookup_noperm(QSTR(name->name), mnt->mnt_root);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index dc3aa91a6ba0..77fda4101b06 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -421,7 +421,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	int ret;
 
 	inode_lock(parent->d_inode);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_noperm(QSTR(name), parent);
 	if (IS_ERR(dentry)) {
 		inode_unlock(parent->d_inode);
 		return PTR_ERR(dentry);
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 6039afae4bfc..dfc56cec5ab5 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -283,7 +283,7 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 	dir = d_inode(parent);
 
 	inode_lock(dir);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_noperm(QSTR(name), parent);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto fail_lock;
@@ -2551,7 +2551,7 @@ static int aa_mk_null_file(struct dentry *parent)
 		return error;
 
 	inode_lock(d_inode(parent));
-	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
+	dentry = lookup_noperm(QSTR(NULL_FILE_NAME), parent);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out;
diff --git a/security/inode.c b/security/inode.c
index da3ab44c8e57..d04a52a52bdd 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -128,7 +128,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dir = d_inode(parent);
 
 	inode_lock(dir);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_noperm(QSTR(name), parent);
 	if (IS_ERR(dentry))
 		goto out;
 
-- 
2.48.1


