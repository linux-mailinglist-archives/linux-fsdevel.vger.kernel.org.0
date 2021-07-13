Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA42C3C6F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhGMLSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMLSP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 388B361178;
        Tue, 13 Jul 2021 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174925;
        bh=pM43hmxb1r8NzZe8Bu0JOwv38UcMe7SpmO84f9h22oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rN39fDcQbuZTlSZX5QmPeRdOgcpSgedEP02wNb9YQT/dNvpHEBnAXNY8HVgIkUqU2
         AVGqX6yQ7xVrEbj1mAIaBQE7ji/YfKhWD+4p/pK0zvtvhjL6wwlvbvz5FB+LRDoZRF
         QpkvX1uva5EQTS38RhbMzZJoGLVwPsQD3ZPI0aFbLLXeqSWYr611nw3gAx08hx47zV
         pG6EtIO7QVKK4XlK3qh8h/HsnmEHLNE+ltZqWkUviKGmfdyhGP3bw0lFURcPpNcB+z
         17qTZSltmrbcrNTaTFABdrs8/CkNwqNs9NToQril6J6epyvcMSK1fyNXAmym09qJbH
         XYR0bSvn/d1MQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 01/24] namei: handle mappings in lookup_one_len()
Date:   Tue, 13 Jul 2021 13:13:21 +0200
Message-Id: <20210713111344.1149376-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=34833; h=from:subject; bh=HvpZqWnoX/cAxQzihtJiuF7rgFvIGkvNUFwJGjvsgCE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LQ1vCZW0vT1T8EFtRJCv4Ic6g++HUlc+SLGyf9r6Kst8 esWGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsNGdkeK1fzbbUn/v/S+u10vfnXD pzRGFi5YJYk9Vn5BMtd3j1sjMyTI/ecCuqdmeH513FA0vkZAOPprZolHzcafvpuLW+O48AOwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Various filesystems use the lookup_one_len() helper to lookup a single path
component relative to a well-known starting point. Allow such filesystems to
support idmapped mounts by enabling lookup_one_len() to take the idmap into
account when calling inode_permission(). This change is a required to let btrfs
(and other filesystems) support idmapped mounts.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/s390/hypfs/inode.c            |  2 +-
 drivers/android/binderfs.c         |  4 ++--
 drivers/infiniband/hw/qib/qib_fs.c |  5 +++--
 fs/afs/dir.c                       |  2 +-
 fs/afs/dir_silly.c                 |  2 +-
 fs/afs/dynroot.c                   |  4 ++--
 fs/binfmt_misc.c                   |  2 +-
 fs/btrfs/ioctl.c                   |  4 ++--
 fs/cachefiles/namei.c              |  9 +++++----
 fs/debugfs/inode.c                 |  6 ++++--
 fs/exportfs/expfs.c                |  3 ++-
 fs/namei.c                         | 15 +++++++++------
 fs/nfs/unlink.c                    |  3 ++-
 fs/nfsd/nfs4recover.c              |  7 ++++---
 fs/nfsd/nfsproc.c                  |  3 ++-
 fs/nfsd/vfs.c                      | 19 ++++++++++---------
 fs/overlayfs/copy_up.c             | 10 ++++++----
 fs/overlayfs/dir.c                 | 23 ++++++++++++-----------
 fs/overlayfs/export.c              |  3 ++-
 fs/overlayfs/readdir.c             | 12 +++++++-----
 fs/overlayfs/super.c               |  8 +++++---
 fs/overlayfs/util.c                |  2 +-
 fs/reiserfs/xattr.c                | 14 +++++++-------
 fs/tracefs/inode.c                 |  3 ++-
 include/linux/namei.h              |  3 ++-
 ipc/mqueue.c                       |  5 +++--
 kernel/bpf/inode.c                 |  2 +-
 security/apparmor/apparmorfs.c     |  5 +++--
 security/inode.c                   |  2 +-
 29 files changed, 103 insertions(+), 79 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 5c97f48cea91..e17d8c53a7a3 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -341,7 +341,7 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 	struct inode *inode;
 
 	inode_lock(d_inode(parent));
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_one_len(&init_user_ns, name, parent, strlen(name));
 	if (IS_ERR(dentry)) {
 		dentry = ERR_PTR(-ENOMEM);
 		goto fail;
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e80ba93c62a9..3a55ffc6c4e5 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -178,7 +178,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	inode_lock(d_inode(root));
 
 	/* look it up */
-	dentry = lookup_one_len(name, root, name_len);
+	dentry = lookup_one_len(&init_user_ns, name, root, name_len);
 	if (IS_ERR(dentry)) {
 		inode_unlock(d_inode(root));
 		ret = PTR_ERR(dentry);
@@ -487,7 +487,7 @@ static struct dentry *binderfs_create_dentry(struct dentry *parent,
 {
 	struct dentry *dentry;
 
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_one_len(&init_user_ns, name, parent, strlen(name));
 	if (IS_ERR(dentry))
 		return dentry;
 
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index a0c5f3bdc324..f85cfee80de5 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -91,7 +91,7 @@ static int create_file(const char *name, umode_t mode,
 	int error;
 
 	inode_lock(d_inode(parent));
-	*dentry = lookup_one_len(name, parent, strlen(name));
+	*dentry = lookup_one_len(&init_user_ns, name, parent, strlen(name));
 	if (!IS_ERR(*dentry))
 		error = qibfs_mknod(d_inode(parent), *dentry,
 				    mode, fops, data);
@@ -434,7 +434,8 @@ static int remove_device_files(struct super_block *sb,
 	char unit[10];
 
 	snprintf(unit, sizeof(unit), "%u", dd->unit);
-	dir = lookup_one_len_unlocked(unit, sb->s_root, strlen(unit));
+	dir = lookup_one_len_unlocked(&init_user_ns, unit, sb->s_root,
+				      strlen(unit));
 
 	if (IS_ERR(dir)) {
 		pr_err("Lookup of %s failed\n", unit);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78719f2f567e..ca3e4980ad8b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -986,7 +986,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 		}
 
 		strcpy(p, name);
-		ret = lookup_one_len(buf, dentry->d_parent, len);
+		ret = lookup_one_len(&init_user_ns, buf, dentry->d_parent, len);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index dae9a57d7ec0..341bf214cbdf 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -122,7 +122,7 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 		 * understood by the salvager and must not be changed.
 		 */
 		slen = scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
-		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
+		sdentry = lookup_one_len(&init_user_ns, silly, dentry->d_parent, slen);
 
 		/* N.B. Better to return EBUSY here ... it could be dangerous
 		 * to delete the file while it's in use.
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index db832cc931c8..6b89d68c8e44 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -202,7 +202,7 @@ static struct dentry *afs_lookup_atcell(struct dentry *dentry)
 	if (!cell)
 		goto out_n;
 
-	ret = lookup_one_len(name, dentry->d_parent, len);
+	ret = lookup_one_len(&init_user_ns, name, dentry->d_parent, len);
 
 	/* We don't want to d_add() the @cell dentry here as we don't want to
 	 * the cached dentry to hide changes to the local cell name.
@@ -285,7 +285,7 @@ int afs_dynroot_mkdir(struct afs_net *net, struct afs_cell *cell)
 	/* Let the ->lookup op do the creation */
 	root = sb->s_root;
 	inode_lock(root->d_inode);
-	subdir = lookup_one_len(cell->name, root, cell->name_len);
+	subdir = lookup_one_len(&init_user_ns, cell->name, root, cell->name_len);
 	if (IS_ERR(subdir)) {
 		ret = PTR_ERR(subdir);
 		goto unlock;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e1eae7ea823a..3c8bf8f551ee 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -668,7 +668,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	}
 
 	inode_lock(d_inode(root));
-	dentry = lookup_one_len(e->name, root, strlen(e->name));
+	dentry = lookup_one_len(&init_user_ns, e->name, root, strlen(e->name));
 	err = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..8ec67e52fde3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -893,7 +893,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (error == -EINTR)
 		return error;
 
-	dentry = lookup_one_len(name, parent->dentry, namelen);
+	dentry = lookup_one_len(&init_user_ns, name, parent->dentry, namelen);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
@@ -3016,7 +3016,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto free_subvol_name;
-	dentry = lookup_one_len(subvol_name, parent, subvol_namelen);
+	dentry = lookup_one_len(&init_user_ns, subvol_name, parent, subvol_namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7bf0732ae25c..40497c6b6376 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -367,7 +367,8 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 		return -EIO;
 	}
 
-	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
+	grave = lookup_one_len(&init_user_ns, nbuffer,
+			       cache->graveyard, strlen(nbuffer));
 	if (IS_ERR(grave)) {
 		unlock_rename(cache->graveyard, dir);
 
@@ -536,7 +537,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
 	start = jiffies;
-	next = lookup_one_len(name, dir, nlen);
+	next = lookup_one_len(&init_user_ns, name, dir, nlen);
 	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(next)) {
 		trace_cachefiles_lookup(object, next, NULL);
@@ -776,7 +777,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 retry:
 	start = jiffies;
-	subdir = lookup_one_len(dirname, dir, strlen(dirname));
+	subdir = lookup_one_len(&init_user_ns, dirname, dir, strlen(dirname));
 	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(subdir)) {
 		if (PTR_ERR(subdir) == -ENOMEM)
@@ -886,7 +887,7 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
 	start = jiffies;
-	victim = lookup_one_len(filename, dir, strlen(filename));
+	victim = lookup_one_len(&init_user_ns, filename, dir, strlen(filename));
 	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(victim))
 		goto lookup_error;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 8129a430d789..92db343f35f4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -349,7 +349,8 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	if (unlikely(IS_DEADDIR(d_inode(parent))))
 		dentry = ERR_PTR(-ENOENT);
 	else
-		dentry = lookup_one_len(name, parent, strlen(name));
+		dentry = lookup_one_len(&init_user_ns, name,
+					parent, strlen(name));
 	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
 		if (d_is_dir(dentry))
 			pr_err("Directory '%s' with parent '%s' already present!\n",
@@ -775,7 +776,8 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 	if (d_really_is_negative(old_dentry) || old_dentry == trap ||
 	    d_mountpoint(old_dentry))
 		goto exit;
-	dentry = lookup_one_len(new_name, new_dir, strlen(new_name));
+	dentry = lookup_one_len(&init_user_ns, new_name,
+				new_dir, strlen(new_name));
 	/* Lookup failed, cyclic rename or target exists? */
 	if (IS_ERR(dentry) || dentry == trap || d_really_is_positive(dentry))
 		goto exit;
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0106eba46d5a..9ba408594094 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -525,7 +525,8 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		}
 
 		inode_lock(target_dir->d_inode);
-		nresult = lookup_one_len(nbuf, target_dir, strlen(nbuf));
+		nresult = lookup_one_len(&init_user_ns, nbuf,
+					 target_dir, strlen(nbuf));
 		if (!IS_ERR(nresult)) {
 			if (unlikely(nresult->d_inode != result->d_inode)) {
 				dput(nresult);
diff --git a/fs/namei.c b/fs/namei.c
index bf6d8a738c59..5a3e8188585e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2575,7 +2575,8 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_one_len_common(const char *name, struct dentry *base,
+static int lookup_one_len_common(struct user_namespace *mnt_userns,
+				 const char *name, struct dentry *base,
 				 int len, struct qstr *this)
 {
 	this->name = name;
@@ -2604,7 +2605,7 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 			return err;
 	}
 
-	return inode_permission(&init_user_ns, base->d_inode, MAY_EXEC);
+	return inode_permission(mnt_userns, base->d_inode, MAY_EXEC);
 }
 
 /**
@@ -2628,7 +2629,7 @@ struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2638,6 +2639,7 @@ EXPORT_SYMBOL(try_lookup_one_len);
 
 /**
  * lookup_one_len - filesystem helper to lookup single pathname component
+ * @mnt_userns:	user namespace of the mount the lookup is performed from
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
@@ -2647,7 +2649,8 @@ EXPORT_SYMBOL(try_lookup_one_len);
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
+struct dentry *lookup_one_len(struct user_namespace *mnt_userns,
+			      const char *name, struct dentry *base, int len)
 {
 	struct dentry *dentry;
 	struct qstr this;
@@ -2655,7 +2658,7 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(mnt_userns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2683,7 +2686,7 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 5fa11e1aca4c..b519f97a2b19 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -463,7 +463,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
 				dentry, silly);
 
-		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
+		sdentry = lookup_one_len(&init_user_ns, silly,
+					 dentry->d_parent, slen);
 		/*
 		 * N.B. Better to return EBUSY here ... it could be
 		 * dangerous to delete the file while it's in use.
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 6fedc49726bf..0ac319feea55 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -218,7 +218,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	/* lock the parent */
 	inode_lock(d_inode(dir));
 
-	dentry = lookup_one_len(dname, dir, HEXDIR_LEN-1);
+	dentry = lookup_one_len(&init_user_ns, dname, dir, HEXDIR_LEN-1);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
 		goto out_unlock;
@@ -313,7 +313,8 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
 		if (!status) {
 			struct dentry *dentry;
-			dentry = lookup_one_len(entry->name, dir, HEXDIR_LEN-1);
+			dentry = lookup_one_len(&init_user_ns, entry->name,
+						dir, HEXDIR_LEN-1);
 			if (IS_ERR(dentry)) {
 				status = PTR_ERR(dentry);
 				break;
@@ -345,7 +346,7 @@ nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
 
 	dir = nn->rec_file->f_path.dentry;
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-	dentry = lookup_one_len(name, dir, namlen);
+	dentry = lookup_one_len(&init_user_ns, name, dir, namlen);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
 		goto out_unlock;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 60d7c59e7935..4a2473ae81cb 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -292,7 +292,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
-	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
+	dchild = lookup_one_len(&init_user_ns, argp->name,
+				dirfhp->fh_dentry, argp->len);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
 		goto out_unlock;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a224a5e23cc1..962d718faf38 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -205,7 +205,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 * need to take the child's i_mutex:
 		 */
 		fh_lock_nested(fhp, I_MUTEX_PARENT);
-		dentry = lookup_one_len(name, dparent, len);
+		dentry = lookup_one_len(&init_user_ns, name, dparent, len);
 		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
@@ -1277,7 +1277,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		host_err = vfs_mkdir(&init_user_ns, dirp, dchild, iap->ia_mode);
 		if (!host_err && unlikely(d_unhashed(dchild))) {
 			struct dentry *d;
-			d = lookup_one_len(dchild->d_name.name,
+			d = lookup_one_len(&init_user_ns,
+					   dchild->d_name.name,
 					   dchild->d_parent,
 					   dchild->d_name.len);
 			if (IS_ERR(d)) {
@@ -1367,7 +1368,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return nfserrno(host_err);
 
 	fh_lock_nested(fhp, I_MUTEX_PARENT);
-	dchild = lookup_one_len(fname, dentry, flen);
+	dchild = lookup_one_len(&init_user_ns, fname, dentry, flen);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild))
 		return nfserrno(host_err);
@@ -1424,7 +1425,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	/*
 	 * Compose the response file handle.
 	 */
-	dchild = lookup_one_len(fname, dentry, flen);
+	dchild = lookup_one_len(&init_user_ns, fname, dentry, flen);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild))
 		goto out_nfserr;
@@ -1620,7 +1621,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	fh_lock(fhp);
 	dentry = fhp->fh_dentry;
-	dnew = lookup_one_len(fname, dentry, flen);
+	dnew = lookup_one_len(&init_user_ns, fname, dentry, flen);
 	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew))
 		goto out_nfserr;
@@ -1683,7 +1684,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
 
-	dnew = lookup_one_len(name, ddir, len);
+	dnew = lookup_one_len(&init_user_ns, name, ddir, len);
 	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew))
 		goto out_nfserr;
@@ -1783,7 +1784,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	fill_pre_wcc(ffhp);
 	fill_pre_wcc(tfhp);
 
-	odentry = lookup_one_len(fname, fdentry, flen);
+	odentry = lookup_one_len(&init_user_ns, fname, fdentry, flen);
 	host_err = PTR_ERR(odentry);
 	if (IS_ERR(odentry))
 		goto out_nfserr;
@@ -1795,7 +1796,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (odentry == trap)
 		goto out_dput_old;
 
-	ndentry = lookup_one_len(tname, tdentry, tlen);
+	ndentry = lookup_one_len(&init_user_ns, tname, tdentry, tlen);
 	host_err = PTR_ERR(ndentry);
 	if (IS_ERR(ndentry))
 		goto out_dput_old;
@@ -1893,7 +1894,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
 
-	rdentry = lookup_one_len(fname, dentry, flen);
+	rdentry = lookup_one_len(&init_user_ns, fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
 		goto out_drop_write;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 2846b943e80c..ece61c70d50f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -420,7 +420,7 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 	if (err)
 		goto out;
 
-	index = lookup_one_len(name.name, indexdir, name.len);
+	index = lookup_one_len(&init_user_ns, name.name, indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 	} else {
@@ -468,7 +468,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 		return err;
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
-	upper = lookup_one_len(c->dentry->d_name.name, upperdir,
+	upper = lookup_one_len(&init_user_ns, c->dentry->d_name.name, upperdir,
 			       c->dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
@@ -620,7 +620,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 			goto cleanup;
 	}
 
-	upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
+	upper = lookup_one_len(&init_user_ns, c->destname.name,
+			       c->destdir, c->destname.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto cleanup;
@@ -671,7 +672,8 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 
-	upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
+	upper = lookup_one_len(&init_user_ns, c->destname.name,
+			       c->destdir, c->destname.len);
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(temp, udir, upper);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 93efe7048a77..df8fc89416db 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -51,7 +51,7 @@ struct dentry *ovl_lookup_temp(struct dentry *workdir)
 	/* counter is allowed to wrap, since temp dentries are ephemeral */
 	snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
 
-	temp = lookup_one_len(name, workdir, strlen(name));
+	temp = lookup_one_len(&init_user_ns, name, workdir, strlen(name));
 	if (!IS_ERR(temp) && temp->d_inode) {
 		pr_err("workdir/%s already exists\n", name);
 		dput(temp);
@@ -155,8 +155,8 @@ static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
 	 * to it unhashed and negative. If that happens, try to
 	 * lookup a new hashed and positive dentry.
 	 */
-	d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
-			   dentry->d_name.len);
+	d = lookup_one_len(&init_user_ns, dentry->d_name.name,
+			   dentry->d_parent, dentry->d_name.len);
 	if (IS_ERR(d)) {
 		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
 			dentry, err);
@@ -330,7 +330,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 	newdentry = ovl_create_real(udir,
-				    lookup_one_len(dentry->d_name.name,
+				    lookup_one_len(&init_user_ns,
+						   dentry->d_name.name,
 						   upperdir,
 						   dentry->d_name.len),
 				    attr);
@@ -482,7 +483,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	upper = lookup_one_len(dentry->d_name.name, upperdir,
+	upper = lookup_one_len(&init_user_ns, dentry->d_name.name, upperdir,
 			       dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
@@ -763,7 +764,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 	if (err)
 		goto out_dput;
 
-	upper = lookup_one_len(dentry->d_name.name, upperdir,
+	upper = lookup_one_len(&init_user_ns, dentry->d_name.name, upperdir,
 			       dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
@@ -810,7 +811,7 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 	}
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	upper = lookup_one_len(dentry->d_name.name, upperdir,
+	upper = lookup_one_len(&init_user_ns, dentry->d_name.name, upperdir,
 			       dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
@@ -1184,8 +1185,8 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 
 	trap = lock_rename(new_upperdir, old_upperdir);
 
-	olddentry = lookup_one_len(old->d_name.name, old_upperdir,
-				   old->d_name.len);
+	olddentry = lookup_one_len(&init_user_ns, old->d_name.name,
+				   old_upperdir, old->d_name.len);
 	err = PTR_ERR(olddentry);
 	if (IS_ERR(olddentry))
 		goto out_unlock;
@@ -1194,8 +1195,8 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 	if (!ovl_matches_upper(old, olddentry))
 		goto out_dput_old;
 
-	newdentry = lookup_one_len(new->d_name.name, new_upperdir,
-				   new->d_name.len);
+	newdentry = lookup_one_len(&init_user_ns, new->d_name.name,
+				   new_upperdir, new->d_name.len);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
 		goto out_dput_old;
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 41ebf52f1bbc..5469b1f36039 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -391,7 +391,8 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 * pointer because we hold no lock on the real dentry.
 	 */
 	take_dentry_name_snapshot(&name, real);
-	this = lookup_one_len(name.name.name, connected, name.name.len);
+	this = lookup_one_len(&init_user_ns, name.name.name,
+			      connected, name.name.len);
 	err = PTR_ERR(this);
 	if (IS_ERR(this)) {
 		goto fail;
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e8ad2c2c77dd..3de32997ea28 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -278,7 +278,8 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 		while (rdd->first_maybe_whiteout) {
 			p = rdd->first_maybe_whiteout;
 			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
-			dentry = lookup_one_len(p->name, dir, p->len);
+			dentry = lookup_one_len(&init_user_ns, p->name,
+						dir, p->len);
 			if (!IS_ERR(dentry)) {
 				p->is_whiteout = ovl_is_whiteout(dentry);
 				dput(dentry);
@@ -479,7 +480,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 			goto get;
 		}
 	}
-	this = lookup_one_len(p->name, dir, p->len);
+	this = lookup_one_len(&init_user_ns, p->name, dir, p->len);
 	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
 		if (IS_ERR(this)) {
 			err = PTR_ERR(this);
@@ -1007,7 +1008,7 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
 		if (WARN_ON(!p->is_whiteout || !p->is_upper))
 			continue;
 
-		dentry = lookup_one_len(p->name, upper, p->len);
+		dentry = lookup_one_len(&init_user_ns, p->name, upper, p->len);
 		if (IS_ERR(dentry)) {
 			pr_err("lookup '%s/%.*s' failed (%i)\n",
 			       upper->d_name.name, p->len, p->name,
@@ -1106,7 +1107,8 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
 			err = -EINVAL;
 			break;
 		}
-		dentry = lookup_one_len(p->name, path->dentry, p->len);
+		dentry = lookup_one_len(&init_user_ns, p->name,
+					path->dentry, p->len);
 		if (IS_ERR(dentry))
 			continue;
 		if (dentry->d_inode)
@@ -1174,7 +1176,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			if (p->len == 2 && p->name[1] == '.')
 				continue;
 		}
-		index = lookup_one_len(p->name, indexdir, p->len);
+		index = lookup_one_len(&init_user_ns, p->name, indexdir, p->len);
 		if (IS_ERR(index)) {
 			err = PTR_ERR(index);
 			index = NULL;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b01d4147520d..58c592f52b5b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -761,7 +761,8 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 retry:
-	work = lookup_one_len(name, ofs->workbasedir, strlen(name));
+	work = lookup_one_len(&init_user_ns, name,
+			      ofs->workbasedir, strlen(name));
 
 	if (!IS_ERR(work)) {
 		struct iattr attr = {
@@ -1284,7 +1285,8 @@ static int ovl_check_rename_whiteout(struct dentry *workdir)
 		goto cleanup_temp;
 	}
 
-	whiteout = lookup_one_len(name.name.name, workdir, name.name.len);
+	whiteout = lookup_one_len(&init_user_ns, name.name.name,
+				  workdir, name.name.len);
 	err = PTR_ERR(whiteout);
 	if (IS_ERR(whiteout))
 		goto cleanup_temp;
@@ -1315,7 +1317,7 @@ static struct dentry *ovl_lookup_or_create(struct dentry *parent,
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-	child = lookup_one_len(name, parent, len);
+	child = lookup_one_len(&init_user_ns, name, parent, len);
 	if (!IS_ERR(child) && !child->d_inode)
 		child = ovl_create_real(parent->d_inode, child,
 					OVL_CATTR(mode));
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b9d03627f364..1138c10814c5 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -740,7 +740,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	}
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	index = lookup_one_len(name.name, indexdir, name.len);
+	index = lookup_one_len(&init_user_ns, name.name, indexdir, name.len);
 	err = PTR_ERR(index);
 	if (IS_ERR(index)) {
 		index = NULL;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index bd073836e141..d70f4ffe5d6b 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -159,7 +159,7 @@ static struct dentry *open_xa_dir(const struct inode *inode, int flags)
 
 	inode_lock_nested(d_inode(xaroot), I_MUTEX_XATTR);
 
-	xadir = lookup_one_len(namebuf, xaroot, strlen(namebuf));
+	xadir = lookup_one_len(&init_user_ns, namebuf, xaroot, strlen(namebuf));
 	if (!IS_ERR(xadir) && d_really_is_negative(xadir)) {
 		int err = -ENODATA;
 
@@ -206,7 +206,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 			       (namelen == 2 && name[1] == '.')))
 		return 0;
 
-	dentry = lookup_one_len(name, dbuf->xadir, namelen);
+	dentry = lookup_one_len(&init_user_ns, name, dbuf->xadir, namelen);
 	if (IS_ERR(dentry)) {
 		dbuf->err = PTR_ERR(dentry);
 		return PTR_ERR(dentry);
@@ -397,7 +397,7 @@ static struct dentry *xattr_lookup(struct inode *inode, const char *name,
 		return ERR_CAST(xadir);
 
 	inode_lock_nested(d_inode(xadir), I_MUTEX_XATTR);
-	xafile = lookup_one_len(name, xadir, strlen(name));
+	xafile = lookup_one_len(&init_user_ns, name, xadir, strlen(name));
 	if (IS_ERR(xafile)) {
 		err = PTR_ERR(xafile);
 		goto out;
@@ -491,7 +491,7 @@ static int lookup_and_delete_xattr(struct inode *inode, const char *name)
 		return PTR_ERR(xadir);
 
 	inode_lock_nested(d_inode(xadir), I_MUTEX_XATTR);
-	dentry = lookup_one_len(name, xadir, strlen(name));
+	dentry = lookup_one_len(&init_user_ns, name, xadir, strlen(name));
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_dput;
@@ -977,7 +977,7 @@ int reiserfs_lookup_privroot(struct super_block *s)
 
 	/* If we don't have the privroot located yet - go find it */
 	inode_lock(d_inode(s->s_root));
-	dentry = lookup_one_len(PRIVROOT_NAME, s->s_root,
+	dentry = lookup_one_len(&init_user_ns, PRIVROOT_NAME, s->s_root,
 				strlen(PRIVROOT_NAME));
 	if (!IS_ERR(dentry)) {
 		REISERFS_SB(s)->priv_root = dentry;
@@ -1018,8 +1018,8 @@ int reiserfs_xattr_init(struct super_block *s, int mount_flags)
 		if (!REISERFS_SB(s)->xattr_root) {
 			struct dentry *dentry;
 
-			dentry = lookup_one_len(XAROOT_NAME, privroot,
-						strlen(XAROOT_NAME));
+			dentry = lookup_one_len(&init_user_ns, XAROOT_NAME,
+						privroot, strlen(XAROOT_NAME));
 			if (!IS_ERR(dentry))
 				REISERFS_SB(s)->xattr_root = dentry;
 			else
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1261e8b41edb..a704d84c9d22 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -335,7 +335,8 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
 		dentry = ERR_PTR(-ENOENT);
 	else
-		dentry = lookup_one_len(name, parent, strlen(name));
+		dentry = lookup_one_len(&init_user_ns, name,
+					parent, strlen(name));
 	if (!IS_ERR(dentry) && dentry->d_inode) {
 		dput(dentry);
 		dentry = ERR_PTR(-EEXIST);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index be9a2b349ca7..7f8b58b43075 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -65,7 +65,8 @@ extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry *lookup_one_len(struct user_namespace *mnt_userns,
+				     const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..4c84805161e8 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -899,7 +899,8 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 
 	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
 	inode_lock(d_inode(root));
-	path.dentry = lookup_one_len(name->name, root, strlen(name->name));
+	path.dentry = lookup_one_len(&init_user_ns, name->name,
+				     root, strlen(name->name));
 	if (IS_ERR(path.dentry)) {
 		error = PTR_ERR(path.dentry);
 		goto out_putfd;
@@ -955,7 +956,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 	if (err)
 		goto out_name;
 	inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
-	dentry = lookup_one_len(name->name, mnt->mnt_root,
+	dentry = lookup_one_len(&init_user_ns, name->name, mnt->mnt_root,
 				strlen(name->name));
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 80da1db47c68..5e50f9fc7dd1 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -423,7 +423,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	int ret;
 
 	inode_lock(parent->d_inode);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_one_len(&init_user_ns, name, parent, strlen(name));
 	if (IS_ERR(dentry)) {
 		inode_unlock(parent->d_inode);
 		return PTR_ERR(dentry);
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2ee3b3d29f10..02c61284aab7 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -280,7 +280,7 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 	dir = d_inode(parent);
 
 	inode_lock(dir);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_one_len(&init_user_ns, name, parent, strlen(name));
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto fail_lock;
@@ -2504,7 +2504,8 @@ static int aa_mk_null_file(struct dentry *parent)
 		return error;
 
 	inode_lock(d_inode(parent));
-	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
+	dentry = lookup_one_len(&init_user_ns, NULL_FILE_NAME,
+				parent, strlen(NULL_FILE_NAME));
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out;
diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..6b89567be9a6 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -128,7 +128,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dir = d_inode(parent);
 
 	inode_lock(dir);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	dentry = lookup_one_len(&init_user_ns, name, parent, strlen(name));
 	if (IS_ERR(dentry))
 		goto out;
 
-- 
2.30.2

