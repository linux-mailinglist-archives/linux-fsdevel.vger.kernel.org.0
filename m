Return-Path: <linux-fsdevel+bounces-55569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C4B0BF56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950293B754C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60220F069;
	Mon, 21 Jul 2025 08:45:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CF287500;
	Mon, 21 Jul 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087539; cv=none; b=tKQDDWTA7s/fZkBWG+gjrIpmA9wkPBrX6qdPbFv3afQfDNhIr/L0W1QwQW9r0SsrVIQsjy1oOJessNDrWDt2L6AN68j4byRDxhyTkI+LhuodIhgx5UVQQwDSIJg1roh+Z/fRt2sM1OwMrZ2XKMAjnvkNtinIvzzXl7MnDOupchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087539; c=relaxed/simple;
	bh=WsiREpDyD5e2M1t4P4tsfE0wG9bWYJ1PAILyyKiMj/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVp0AKGuncpk5U6B1LvGtrUjaBD7sRtADhjHurKWlrqaW5x0Zsms8/0A1PaD6oi5x32+N3XVV2+buenQvcazMKXyAVbHlWUJREbBnoQtoI66UJixwixsrcFshQ45Gsxn921IiS/kFWrbU1gY9FoXcJwnkrK9wISBxhH0z1iX6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9G-002pft-Tr;
	Mon, 21 Jul 2025 08:45:28 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] VFS: Change vfs_mkdir() to unlock on failure.
Date: Mon, 21 Jul 2025 17:59:59 +1000
Message-ID: <20250721084412.370258-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721084412.370258-1-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
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

So this patch changes vfs_mkdir() to unlock on error as well as
releasing the dentry.  This requires various other functions in various
callers to also unlock on error.

At present this results in some clumsy code.  Once the transition to
dentry locking is complete the clumsiness will be gone.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    |  9 +++++----
 fs/ecryptfs/inode.c      |  3 ++-
 fs/namei.c               | 24 ++++++++++++++++--------
 fs/nfsd/nfs4recover.c    | 12 +++++-------
 fs/nfsd/vfs.c            | 12 ++++++++++--
 fs/overlayfs/dir.c       | 13 +++++++------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     |  5 +++--
 fs/xfs/scrub/orphanage.c |  2 +-
 9 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d1edb2ac3837..732d78911bed 100644
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
@@ -196,9 +199,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(-EBUSY);
 
 mkdir_error:
-	inode_unlock(d_inode(dir));
-	if (!IS_ERR(subdir))
-		dput(subdir);
+	done_dentry_lookup(subdir);
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index abd954c6a14e..5d8cb042aa57 100644
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
index da160a01e23d..950a0d0d54da 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1723,13 +1723,18 @@ EXPORT_SYMBOL(lookup_one_qstr_excl);
  * rmdir) a dentry.  After this, done_dentry_lookup() can be used to both
  * unlock the parent directory and dput() the dentry.
  *
+ * If the dentry is an error - as can happen after vfs_mkdir() -
+ * the unlock is skipped as unneeded.
+ *
  * This interface allows a smooth transition from parent-dir based
  * locking to dentry based locking.
  */
 void done_dentry_lookup(struct dentry *dentry)
 {
-	inode_unlock(dentry->d_parent->d_inode);
-	dput(dentry);
+	if (!IS_ERR(dentry)) {
+		inode_unlock(dentry->d_parent->d_inode);
+		dput(dentry);
+	}
 }
 EXPORT_SYMBOL(done_dentry_lookup);
 
@@ -1742,12 +1747,16 @@ EXPORT_SYMBOL(done_dentry_lookup);
  * rmdir) a dentry.  After this, done_dentry_lookup_return() can be used to
  * unlock the parent directory.  The dentry is returned for further use.
  *
+ * If the dentry is an error - as can happen after vfs_mkdir() -
+ * the unlock is skipped as unneeded.
+ *
  * This interface allows a smooth transition from parent-dir based
  * locking to dentry based locking.
  */
 struct dentry *done_dentry_lookup_return(struct dentry *dentry)
 {
-	inode_unlock(dentry->d_parent->d_inode);
+	if (!IS_ERR(dentry))
+		inode_unlock(dentry->d_parent->d_inode);
 	return dentry;
 }
 EXPORT_SYMBOL(done_dentry_lookup_return);
@@ -4210,9 +4219,7 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
-		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	done_dentry_lookup(dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4375,7 +4382,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * negative or unhashes it and possibly splices a different one returning it,
  * the original dentry is dput() and the alternate is returned.
  *
- * In case of an error the dentry is dput() and an ERR_PTR() is returned.
+ * In case of an error the dentry is dput(), the parent is unlocked, and
+ * an ERR_PTR() is returned.
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
@@ -4413,7 +4421,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return dentry;
 
 err:
-	dput(dentry);
+	done_dentry_lookup(dentry);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(vfs_mkdir);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 82785db730d9..693fa95fa678 100644
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
@@ -233,15 +234,12 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * In the 4.0 case, we should never get here; but we may
 		 * as well be forgiving and just succeed silently.
 		 */
-		goto out_put;
+		goto out;
 	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
-out_put:
-	if (!status)
-		dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(dir));
+out:
+	done_dentry_lookup(dentry);
 	if (status == 0) {
 		if (nn->in_grace)
 			__nfsd4_create_reclaim_record_grace(clp, dname,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a21940cadede..e85195e858a2 100644
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
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 30619777f0f6..74b52595ea0e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -161,14 +161,17 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	goto out;
 }
 
+/* dir will be unlocked on return */
 struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
 	struct inode *dir = parent->d_inode;
 	int err;
 
-	if (IS_ERR(newdentry))
+	if (IS_ERR(newdentry)) {
+		inode_unlock(dir);
 		return newdentry;
+	}
 
 	err = -ESTALE;
 	if (newdentry->d_inode)
@@ -213,11 +216,11 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 	}
 out:
 	if (err) {
-		if (!IS_ERR(newdentry))
-			dput(newdentry);
+		done_dentry_lookup(newdentry);
 		return ERR_PTR(err);
+	} else {
+		return done_dentry_lookup_return(newdentry);
 	}
-	return newdentry;
 }
 
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
@@ -227,7 +230,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	inode_lock(workdir->d_inode);
 	ret = ovl_create_real(ofs, workdir,
 			      ovl_lookup_temp(ofs, workdir), attr);
-	inode_unlock(workdir->d_inode);
 	return ret;
 }
 
@@ -335,7 +337,6 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
-	inode_unlock(udir);
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4f84abaa0d68..238c26142318 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -250,6 +250,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
 
 	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(ret));
+	/* Note: dir will have been unlocked on failure */
 	return ret;
 }
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 4afa91882075..df99a6fa17ef 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -328,11 +328,11 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
-		inode_unlock(dir);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
 
+		done_dentry_lookup_return(work);
 		/* Weird filesystem returning with hashed negative (kernfs)? */
 		err = -EINVAL;
 		if (d_really_is_negative(work))
@@ -623,7 +623,8 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 	child = ovl_lookup_upper(ofs, name, parent, len);
 	if (!IS_ERR(child) && !child->d_inode)
 		child = ovl_create_real(ofs, parent, child, OVL_CATTR(mode));
-	inode_unlock(parent->d_inode);
+	else
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


