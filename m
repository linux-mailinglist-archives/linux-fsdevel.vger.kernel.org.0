Return-Path: <linux-fsdevel+bounces-50944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10525AD158C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8B0188B00B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB125D55D;
	Sun,  8 Jun 2025 23:10:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223571D7E57;
	Sun,  8 Jun 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749424213; cv=none; b=RClqfKTUxkqEDLGNQ60MWC3CayqhlQlZVvfDs6RIkmBmMANJzW4RoAwyu8F5nXFPOIQHc7yeYjH6utczMNwjK0GhUTN4pEkNXJCh0eDcfNIdE8mCgpIsW7DBq3ScTcL2ComuH59RW+aWwd99oj0k0FET9eazcbDtVSgX7Q57YUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749424213; c=relaxed/simple;
	bh=Z4YrSCC2sei4qXjAkZAwc3o6uXMpLXTfaizX+zttYdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7Eh6TWJCcXdOCfERIUXnoc0DVIVE3zH5BWhliZjKlAh06AuYPKOC2d9Gh8d5chzLCCdZxLe+Te5NsGzovRMDBo2Dz+YsKrYRhciZh1qGNkN5nADZC9yvCB5eATVsLlJc5yneEPBi97rY5nzXOPRrTeXZPd+G6rWdsseK6Sn4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOP9R-005vf3-GW;
	Sun, 08 Jun 2025 23:10:05 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
Date: Mon,  9 Jun 2025 09:09:37 +1000
Message-ID: <20250608230952.20539-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230952.20539-1-neil@brown.name>
References: <20250608230952.20539-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proposed changes to directory-op locking will lock the dentry rather
than the whole directory.  So the dentry will need to be unlocked.

vfs_mkdir() consumes the dentry on error, so there will be no dentry to
be unlocked.

So change vfs_mkdir() to unlock on error as well as releasing the
dentry.  This requires various other functions in various callers to
also unlock on error.

At present this results in some clumsy code.  Once the transition to
dentry locking is complete the clumsiness will be gone.

overlayfs looks particularly clumsy as in some cases a double-directory
rename lock is taken, and a mkdir is then performed in one of the
directories.  If that fails the other directory must be unlocked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    | 10 +++++++---
 fs/ecryptfs/inode.c      |  3 ++-
 fs/namei.c               | 10 +++++++---
 fs/nfsd/nfs4recover.c    | 12 +++++++-----
 fs/nfsd/vfs.c            | 12 ++++++++++--
 fs/overlayfs/copy_up.c   | 21 +++++++++++++++------
 fs/overlayfs/dir.c       | 31 +++++++++++++++++++++++--------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 14 ++++++++++----
 fs/xfs/scrub/orphanage.c |  2 +-
 10 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index aecfc5c37b49..6644f0694169 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -131,8 +131,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
 			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		else
+		else {
+			/* vfs_mkdir() unlocks on failure so we must too */
+			inode_unlock(d_inode(dir));
 			subdir = ERR_PTR(ret);
+		}
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -196,9 +199,10 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(-EBUSY);
 
 mkdir_error:
-	inode_unlock(d_inode(dir));
-	if (!IS_ERR(subdir))
+	if (!IS_ERR(subdir)) {
+		inode_unlock(d_inode(dir));
 		dput(subdir);
+	}
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 493d7f194956..c513e912ae3c 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -520,7 +520,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 lower_dentry, mode);
 	rc = PTR_ERR(lower_dentry);
 	if (IS_ERR(lower_dentry))
-		goto out;
+		goto out_unlocked;
 	rc = 0;
 	if (d_unhashed(lower_dentry))
 		goto out;
@@ -532,6 +532,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	set_nlink(dir, lower_dir->i_nlink);
 out:
 	inode_unlock(lower_dir);
+out_unlocked:
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
diff --git a/fs/namei.c b/fs/namei.c
index dc42bfac5c57..cefbb681d2f5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4163,9 +4163,10 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
+	if (!IS_ERR(dentry)) {
 		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+		inode_unlock(path->dentry->d_inode);
+	}
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4328,7 +4329,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * negative or unhashes it and possibly splices a different one returning it,
  * the original dentry is dput() and the alternate is returned.
  *
- * In case of an error the dentry is dput() and an ERR_PTR() is returned.
+ * In case of an error the dentry is dput(), the parent is unlocked, and
+ * an ERR_PTR() is returned.
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
@@ -4366,6 +4368,8 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return dentry;
 
 err:
+	/* Caller only needs to unlock if dentry is not an error */
+	inode_unlock(dir);
 	dput(dentry);
 	return ERR_PTR(error);
 }
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 82785db730d9..5aedadebebe4 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -222,7 +222,8 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	dentry = lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
-		goto out_unlock;
+		inode_unlock(d_inode(dir));
+		goto out;
 	}
 	if (d_really_is_positive(dentry))
 		/*
@@ -235,13 +236,14 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 */
 		goto out_put;
 	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
+		goto out;
+	}
 out_put:
-	if (!status)
-		dput(dentry);
-out_unlock:
+	dput(dentry);
 	inode_unlock(d_inode(dir));
+out:
 	if (status == 0) {
 		if (nn->in_grace)
 			__nfsd4_create_reclaim_record_grace(clp, dname,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd689df2ca5d..be29a18a23b2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1489,7 +1489,9 @@ nfsd_check_ignore_resizing(struct iattr *iap)
 		iap->ia_valid &= ~ATTR_SIZE;
 }
 
-/* The parent directory should already be locked: */
+/* The parent directory should already be locked.  The lock
+ * will be dropped on error.
+ */
 __be32
 nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   struct nfsd_attrs *attrs,
@@ -1555,8 +1557,11 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 
 out:
-	if (!IS_ERR(dchild))
+	if (!IS_ERR(dchild)) {
+		if (err)
+			inode_unlock(dirp);
 		dput(dchild);
+	}
 	return err;
 
 out_nfserr:
@@ -1613,6 +1618,9 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err != nfs_ok)
 		goto out_unlock;
 	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
+	if (err)
+		/* lock will have been dropped */
+		return err;
 	fh_fill_post_attrs(fhp);
 out_unlock:
 	inode_unlock(dentry->d_inode);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index d7310fcf3888..324429d02569 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -518,7 +518,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 /*
  * Create and install index entry.
  *
- * Caller must hold i_mutex on indexdir.
+ * Caller must hold i_mutex on indexdir.  It will be unlocked on error.
  */
 static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 			    struct dentry *upper)
@@ -539,16 +539,22 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	 * TODO: implement create index for non-dir, so we can call it when
 	 * encoding file handle for non-dir in case index does not exist.
 	 */
-	if (WARN_ON(!d_is_dir(dentry)))
+	if (WARN_ON(!d_is_dir(dentry))) {
+		inode_unlock(dir);
 		return -EIO;
+	}
 
 	/* Directory not expected to be indexed before copy up */
-	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry))))
+	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry)))) {
+		inode_unlock(dir);
 		return -EIO;
+	}
 
 	err = ovl_get_index_name_fh(fh, &name);
-	if (err)
+	if (err) {
+		inode_unlock(dir);
 		return err;
+	}
 
 	temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
 	err = PTR_ERR(temp);
@@ -567,8 +573,10 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 		dput(index);
 	}
 out:
-	if (err)
+	if (err) {
 		ovl_cleanup(ofs, dir, temp);
+		inode_unlock(dir);
+	}
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -781,7 +789,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_start_write(c->dentry);
 	inode_lock(wdir);
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
-	inode_unlock(wdir);
+	if (!IS_ERR(wdir))
+		inode_unlock(wdir);
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fe493f3ed6b6..b4d92b51b63f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -138,13 +138,16 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	goto out;
 }
 
+/* dir will be unlocked on failure */
 struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
 	int err;
 
-	if (IS_ERR(newdentry))
+	if (IS_ERR(newdentry)) {
+		inode_unlock(dir);
 		return newdentry;
+	}
 
 	err = -ESTALE;
 	if (newdentry->d_inode)
@@ -189,13 +192,16 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 	}
 out:
 	if (err) {
-		if (!IS_ERR(newdentry))
+		if (!IS_ERR(newdentry)) {
+			inode_unlock(dir);
 			dput(newdentry);
+		}
 		return ERR_PTR(err);
 	}
 	return newdentry;
 }
 
+/* Note workdir will be unlocked on failure */
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
@@ -309,7 +315,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    attr);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
-		goto out_unlock;
+		goto out;
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
@@ -323,6 +329,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		goto out_cleanup;
 out_unlock:
 	inode_unlock(udir);
+out:
 	return err;
 
 out_cleanup:
@@ -367,9 +374,12 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 
 	opaquedir = ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
 	err = PTR_ERR(opaquedir);
-	if (IS_ERR(opaquedir))
-		goto out_unlock;
-
+	if (IS_ERR(opaquedir)) {
+		/* workdir was unlocked, no upperdir */
+		inode_unlock(upperdir->d_inode);
+		mutex_unlock(&upperdir->d_sb->s_vfs_rename_mutex);
+		return ERR_PTR(err);
+	}
 	err = ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
 	if (err)
 		goto out_cleanup;
@@ -455,8 +465,13 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
 	newdentry = ovl_create_temp(ofs, workdir, cattr);
 	err = PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
-		goto out_dput;
+	if (IS_ERR(newdentry)) {
+		/* workdir was unlocked, not upperdir */
+		inode_unlock(upperdir->d_inode);
+		mutex_unlock(&upperdir->d_sb->s_vfs_rename_mutex);
+		dput(upper);
+		goto out;
+	}
 
 	/*
 	 * mode could have been mutilated due to umask (e.g. sgid directory)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8baaba0a3fe5..44df3a2449e7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -248,6 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
 {
 	dentry = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry));
+	/* Note: dir will have been unlocked on failure */
 	return dentry;
 }
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e19940d649ca..5f3267e919dd 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -366,14 +366,17 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto out_dput;
 	} else {
 		err = PTR_ERR(work);
+		inode_unlock(dir);
 		goto out_err;
 	}
 out_unlock:
-	inode_unlock(dir);
+	if (work && !IS_ERR(work))
+		inode_unlock(dir);
 	return work;
 
 out_dput:
 	dput(work);
+	inode_unlock(dir);
 out_err:
 	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n",
 		ofs->config.workdir, name, -err);
@@ -569,7 +572,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
-		goto out_unlock;
+		return err;
 
 	dest = ovl_lookup_temp(ofs, workdir);
 	err = PTR_ERR(dest);
@@ -620,10 +623,13 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = ovl_lookup_upper(ofs, name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
+	if (!IS_ERR(child) && !child->d_inode) {
 		child = ovl_create_real(ofs, parent->d_inode, child,
 					OVL_CATTR(mode));
-	inode_unlock(parent->d_inode);
+		if (!IS_ERR(child))
+			inode_unlock(parent->d_inode);
+	} else
+		inode_unlock(parent->d_inode);
 	dput(parent);
 
 	return child;
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 9c12cb844231..c95bded4e8a7 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -170,7 +170,7 @@ xrep_orphanage_create(
 					     orphanage_dentry, 0750);
 		error = PTR_ERR(orphanage_dentry);
 		if (IS_ERR(orphanage_dentry))
-			goto out_unlock_root;
+			goto out_dput_root;
 	}
 
 	/* Not a directory? Bail out. */
-- 
2.49.0


