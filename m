Return-Path: <linux-fsdevel+bounces-58721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB7B30A21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D274E3A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6761DE8AD;
	Fri, 22 Aug 2025 00:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854B54723;
	Fri, 22 Aug 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821487; cv=none; b=FLHfhk7H4XXreBWrdsr+brxteuLnI9kUEaeD0DRXbTNTSsgrR0c/hZV5Bcd+HZRRbpbNLwCTSNtylXIdoxk2CB7Nh2gkPgDXYVVr5ksym1ZzuqI8jLm3o1gqf/ULU4AHMRxleZAeO9ZdqLuAP1WPDwdc9PjpgK55svrx+ZDM4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821487; c=relaxed/simple;
	bh=X8yh33lItgx3dVAiLdahd/NXyVASV1tHoEAt3L1iMVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNW+W+tcccBZFyQYLMUUO/j1VV8IEMT14M8TJuVK3DL2ZyIeKEynNGj3PwciZDfxDCiYigAe8A3RjrHYbssrycs7K7XFaDyBWLIfnGlRODo0EvG26+v+dbxYhtRx4rLQqdYTZ48kFGbj4zoIrx7dCWuSc80favRHfQ5r6wzNSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFND-006nbD-0t;
	Fri, 22 Aug 2025 00:11:16 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/16] VFS/nfsd/cachefiles: add start_creating() and end_creating()
Date: Fri, 22 Aug 2025 10:00:29 +1000
Message-ID: <20250822000818.1086550-12-neil@brown.name>
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

start_creating() is similar to simple_start_creating() but is not so
simple.
It takes a qstr for the name, includes permission checking, and does NOT
report an error if the name already exists, returning a positive dentry
instead.

This is currently used by nfsd and cachefiles.  Overlayfs might have a
use for it too.

end_creating() is called after the dentry has been used.  Unlike
simple_end_creating(), end_creating() drop the reference to the dentry
as it is generally no longer needed.  This is exactly end_dirop_mkdir(),
but using that everywhere looks a bit odd...

These calls help encapsulate locking rules so that directory locking can
be changed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c | 33 +++++++++++++++------------------
 fs/namei.c            | 25 +++++++++++++++++++++++++
 fs/nfsd/nfs3proc.c    | 14 +++++---------
 fs/nfsd/nfs4proc.c    | 14 +++++---------
 fs/nfsd/nfs4recover.c | 16 ++++++----------
 fs/nfsd/nfsproc.c     | 11 +++++------
 fs/nfsd/vfs.c         | 42 +++++++++++++++---------------------------
 include/linux/namei.h | 18 ++++++++++++++++++
 8 files changed, 94 insertions(+), 79 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d1edb2ac3837..9af324473967 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -93,12 +93,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	_enter(",,%s", dirname);
 
 	/* search the current directory for the element name */
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
 retry:
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		subdir = lookup_one(&nop_mnt_idmap, &QSTR(dirname), dir);
+		subdir = start_creating(&nop_mnt_idmap, dir, &QSTR(dirname));
 	else
 		subdir = ERR_PTR(ret);
 	trace_cachefiles_lookup(NULL, dir, subdir);
@@ -141,7 +140,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		trace_cachefiles_mkdir(dir, subdir);
 
 		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
-			dput(subdir);
+			end_creating(subdir, dir);
 			goto retry;
 		}
 		ASSERT(d_backing_inode(subdir));
@@ -154,7 +153,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* Tell rmdir() it's not allowed to delete the subdir */
 	inode_lock(d_inode(subdir));
-	inode_unlock(d_inode(dir));
+	dget(subdir);
+	end_creating(subdir, dir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
@@ -196,14 +196,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(-EBUSY);
 
 mkdir_error:
-	inode_unlock(d_inode(dir));
-	if (!IS_ERR(subdir))
-		dput(subdir);
+	end_creating(subdir, dir);
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
 lookup_error:
-	inode_unlock(d_inode(dir));
 	ret = PTR_ERR(subdir);
 	pr_err("Lookup %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
@@ -679,36 +676,37 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 
 	_enter(",%pD", object->file);
 
-	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		dentry = lookup_one(&nop_mnt_idmap, &QSTR(object->d_name), fan);
+		dentry = start_creating(&nop_mnt_idmap, fan, &QSTR(object->d_name));
 	else
 		dentry = ERR_PTR(ret);
 	if (IS_ERR(dentry)) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 					   cachefiles_trace_lookup_error);
 		_debug("lookup fail %ld", PTR_ERR(dentry));
-		goto out_unlock;
+		goto out;
 	}
 
-	if (!d_is_negative(dentry)) {
+	while (!d_is_negative(dentry)) {
 		ret = cachefiles_unlink(volume->cache, object, fan, dentry,
 					FSCACHE_OBJECT_IS_STALE);
 		if (ret < 0)
 			goto out_dput;
 
-		dput(dentry);
+		end_creating(dentry, fan);
+
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
-			dentry = lookup_one(&nop_mnt_idmap, &QSTR(object->d_name), fan);
+			dentry = start_creating(&nop_mnt_idmap, fan,
+						&QSTR(object->d_name));
 		else
 			dentry = ERR_PTR(ret);
 		if (IS_ERR(dentry)) {
 			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 						   cachefiles_trace_lookup_error);
 			_debug("lookup fail %ld", PTR_ERR(dentry));
-			goto out_unlock;
+			goto out;
 		}
 	}
 
@@ -730,9 +728,8 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 out_dput:
-	dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(fan));
+	end_creating(dentry, fan);
+out:
 	_leave(" = %u", success);
 	return success;
 }
diff --git a/fs/namei.c b/fs/namei.c
index c1e39c985f1f..407f3516b335 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3161,6 +3161,31 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
+/**
+ * start_creating - prepare to create a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
+ * an object in a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name already exists, a positive dentry is returned.
+ *
+ * Returns: a negative or positive dentry, or an error.
+ */
+struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, LOOKUP_CREATE);
+}
+EXPORT_SYMBOL(start_creating);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7..e2aac0def2cb 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -281,14 +281,11 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	inode_lock_nested(inode, I_MUTEX_PARENT);
-
-	child = lookup_one(&nop_mnt_idmap,
-			   &QSTR_LEN(argp->name, argp->len),
-			   parent);
+	child = start_creating(&nop_mnt_idmap, parent,
+			       &QSTR_LEN(argp->name, argp->len));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out;
+		goto out_write;
 	}
 
 	if (d_really_is_negative(child)) {
@@ -367,9 +364,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	inode_unlock(inode);
-	if (child && !IS_ERR(child))
-		dput(child);
+	end_creating(child, parent);
+out_write:
 	fh_drop_write(fhp);
 	return status;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb5..35d48221072f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -264,14 +264,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (is_create_with_attrs(open))
 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
 
-	inode_lock_nested(inode, I_MUTEX_PARENT);
-
-	child = lookup_one(&nop_mnt_idmap,
-			   &QSTR_LEN(open->op_fname, open->op_fnamelen),
-			   parent);
+	child = start_creating(&nop_mnt_idmap, parent,
+			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out;
+		goto out_write;
 	}
 
 	if (d_really_is_negative(child)) {
@@ -379,10 +376,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	inode_unlock(inode);
+	end_creating(child, parent);
 	nfsd_attrs_free(&attrs);
-	if (child && !IS_ERR(child))
-		dput(child);
+out_write:
 	fh_drop_write(fhp);
 	return status;
 }
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2231192ec33f..93b2a3e764db 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -216,13 +216,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		goto out_creds;
 
 	dir = nn->rec_file->f_path.dentry;
-	/* lock the parent */
-	inode_lock(d_inode(dir));
 
-	dentry = lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
+	dentry = start_creating(&nop_mnt_idmap, dir, &QSTR(dname));
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
-		goto out_unlock;
+		goto out;
 	}
 	if (d_really_is_positive(dentry))
 		/*
@@ -233,15 +231,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * In the 4.0 case, we should never get here; but we may
 		 * as well be forgiving and just succeed silently.
 		 */
-		goto out_put;
+		goto out_end;
 	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
-out_put:
-	if (!status)
-		dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(dir));
+out_end:
+	end_creating(dentry, dir);
+out:
 	if (status == 0) {
 		if (nn->in_grace)
 			__nfsd4_create_reclaim_record_grace(clp, dname,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8f71f5748c75..ee1b16e921fd 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -306,18 +306,16 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto done;
 	}
 
-	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one(&nop_mnt_idmap, &QSTR_LEN(argp->name, argp->len),
-			    dirfhp->fh_dentry);
+	dchild = start_creating(&nop_mnt_idmap, dirfhp->fh_dentry,
+				&QSTR_LEN(argp->name, argp->len));
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
-		goto out_unlock;
+		goto out_write;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
-	dput(dchild);
 	if (resp->status) {
 		if (resp->status != nfserr_noent)
 			goto out_unlock;
@@ -423,7 +421,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	inode_unlock(dirfhp->fh_dentry->d_inode);
+	end_creating(dchild, dirfhp->fh_dentry);
+out_write:
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5f3e99f956ca..5c809cbc05fe 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1597,19 +1597,16 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	dchild = start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
 	host_err = PTR_ERR(dchild);
-	if (IS_ERR(dchild)) {
-		err = nfserrno(host_err);
-		goto out_unlock;
-	}
+	if (IS_ERR(dchild))
+		return nfserrno(host_err);
+
 	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
 	/*
 	 * We unconditionally drop our ref to dchild as fh_compose will have
 	 * already grabbed its own ref for it.
 	 */
-	dput(dchild);
 	if (err)
 		goto out_unlock;
 	err = fh_fill_pre_attrs(fhp);
@@ -1618,7 +1615,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	end_creating(dchild, dentry);
 	return err;
 }
 
@@ -1704,11 +1701,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	dentry = fhp->fh_dentry;
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dnew = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	dnew = start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
-		inode_unlock(dentry->d_inode);
 		goto out_drop_write;
 	}
 	err = fh_fill_pre_attrs(fhp);
@@ -1721,11 +1716,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	end_creating(dnew, dentry);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-	dput(dnew);
-	if (err==0) err = cerr;
+	if (err==0)
+		err = cerr;
 out_drop_write:
 	fh_drop_write(fhp);
 out:
@@ -1780,32 +1775,31 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
+	dnew = start_creating(&nop_mnt_idmap, ddir, &QSTR_LEN(name, len));
 
-	dnew = lookup_one(&nop_mnt_idmap, &QSTR_LEN(name, len), ddir);
 	if (IS_ERR(dnew)) {
 		host_err = PTR_ERR(dnew);
-		goto out_unlock;
+		goto out_drop_write;
 	}
 
 	dold = tfhp->fh_dentry;
 
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
-		goto out_dput;
+		goto out_unlock;
 	err = fh_fill_pre_attrs(ffhp);
 	if (err != nfs_ok)
-		goto out_dput;
+		goto out_unlock;
 	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
-	inode_unlock(dirp);
+out_unlock:
+	end_creating(dnew, ddir);
 	if (!host_err) {
 		host_err = commit_metadata(ffhp);
 		if (!host_err)
 			host_err = commit_metadata(tfhp);
 	}
 
-	dput(dnew);
 out_drop_write:
 	fh_drop_write(tfhp);
 	if (host_err == -EBUSY) {
@@ -1820,12 +1814,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-
-out_dput:
-	dput(dnew);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 static void
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b1171aa7fb96..7371f586e318 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,9 +81,27 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
 
+struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
+
 void end_dirop(struct dentry *de);
 void end_dirop_mkdir(struct dentry *de, struct dentry *parent);
 
+/* end_creating - finish action started with start_creating
+ * @child - dentry returned by start_creating()
+ * @parent - dentry given to start_creating()
+ *
+ * Unlock and release the child.
+ *
+ * Unlike end_dirop() this can only be called if start_creating() succeeded.
+ * It handles @child being and error as vfs_mkdir() might have converted the
+ * dentry to an error - in that case the parent still needs to be unlocked.
+ */
+static inline void end_creating(struct dentry *child, struct dentry *parent)
+{
+	end_dirop_mkdir(child, parent);
+}
+
 /* filesystems which use the dcache as backing store don't
  * keep a reference after creating an object.
  */
-- 
2.50.0.107.gf914562f5916.dirty


