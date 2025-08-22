Return-Path: <linux-fsdevel+bounces-58724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55734B30A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D31D06898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6E1F4E57;
	Fri, 22 Aug 2025 00:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B615539A;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821488; cv=none; b=bk6eX8GyiGSyYwLWgsheTW1OU22QmAByhPzGiniZbnEsiOEp/IE9jAemdqOuC1ohE51YlXFLU/CQTbzqdCo/6PCDiWYfCV8yoHpUZqOeQHV1IHA7bs1CVuWw9SVp50vnfqqFIJPRyHVfWkCHhtb7beyDtT4Yn7oECjfXKH+0haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821488; c=relaxed/simple;
	bh=cLxOonLPhU4Ns4lppuaRfso35+0UkceNyrDxB0iS+uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neSzbm0GV8pc1Z8r2RxOuehrWJpMAq6g2Qe6b5dnW3gZl1lF+srzjj1Vpm4AC4ELamhFp/jGgyuzmN6I6IlH96luo6Mp6VKHKTH3COxiUhCy1/GihrYl/RIPiqFtGcswSTZVq/PkHcSdA9aq6XkrrbU1ufGxcgA6hOOZX1OqB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFND-006nbL-WB;
	Fri, 22 Aug 2025 00:11:17 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/16] VFS/nfsd/cachefiles: introduce start_removing()
Date: Fri, 22 Aug 2025 10:00:31 +1000
Message-ID: <20250822000818.1086550-14-neil@brown.name>
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

start_removing() is similar to start_creating() to will only return a
positive dentry and the expectation is that it will be removed.
This is used by nfsd and cachefiles.  They are changed to also
use end_dirop() to terminate the action begun by start_removing().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c | 25 ++++++++++---------------
 fs/namei.c            | 27 +++++++++++++++++++++++++++
 fs/nfsd/nfs4recover.c | 24 +++++++-----------------
 fs/nfsd/vfs.c         | 26 ++++++++++----------------
 include/linux/namei.h |  2 ++
 5 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 9af324473967..ddced50afb66 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -260,6 +260,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
  * - File backed objects are unlinked
  * - Directory backed objects are stuffed into the graveyard for userspace to
  *   delete
+ * On entry dir must be locked.  It will be unlocked on exit.
  */
 int cachefiles_bury_object(struct cachefiles_cache *cache,
 			   struct cachefiles_object *object,
@@ -275,7 +276,8 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	_enter(",'%pd','%pd'", dir, rep);
 
 	if (rep->d_parent != dir) {
-		inode_unlock(d_inode(dir));
+		dget(rep);
+		end_dirop(rep);
 		_leave(" = -ESTALE");
 		return -ESTALE;
 	}
@@ -286,16 +288,16 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 			    * by a file struct.
 			    */
 		ret = cachefiles_unlink(cache, object, dir, rep, why);
-		dput(rep);
+		end_dirop(rep);
 
-		inode_unlock(d_inode(dir));
 		_leave(" = %d", ret);
 		return ret;
 	}
 
 	/* directories have to be moved to the graveyard */
 	_debug("move stale object to graveyard");
-	inode_unlock(d_inode(dir));
+	dget(rep);
+	end_dirop(rep);
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
@@ -745,26 +747,20 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 	struct dentry *victim;
 	int ret = -ENOENT;
 
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	victim = start_removing(&nop_mnt_idmap, dir, &QSTR(filename));
 
-	victim = lookup_one(&nop_mnt_idmap, &QSTR(filename), dir);
 	if (IS_ERR(victim))
 		goto lookup_error;
-	if (d_is_negative(victim))
-		goto lookup_put;
 	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
 		goto lookup_busy;
 	return victim;
 
 lookup_busy:
 	ret = -EBUSY;
-lookup_put:
-	inode_unlock(d_inode(dir));
-	dput(victim);
+	end_dirop(victim);
 	return ERR_PTR(ret);
 
 lookup_error:
-	inode_unlock(d_inode(dir));
 	ret = PTR_ERR(victim);
 	if (ret == -ENOENT)
 		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
@@ -812,18 +808,17 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
+	dput(victim);
 	if (ret < 0)
 		goto error;
 
 	fscache_count_culled();
-	dput(victim);
 	_leave(" = 0");
 	return 0;
 
 error_unlock:
-	inode_unlock(d_inode(dir));
+	end_dirop(victim);
 error:
-	dput(victim);
 	if (ret == -ENOENT)
 		return -ESTALE; /* Probably got retired by the netfs */
 
diff --git a/fs/namei.c b/fs/namei.c
index 407f3516b335..27a99c276137 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3186,6 +3186,33 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_creating);
 
+/**
+ * start_removing - prepare to remove a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to find the name
+ * @name - the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_dirop() should be called when removal is complete, or aborted.
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, 0);
+}
+EXPORT_SYMBOL(start_removing);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index f65cf7ecea6d..8d4bb22db3b7 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -335,20 +335,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
 
 	dir = nn->rec_file->f_path.dentry;
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-	dentry = lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
-	if (IS_ERR(dentry)) {
-		status = PTR_ERR(dentry);
-		goto out_unlock;
-	}
-	status = -ENOENT;
-	if (d_really_is_negative(dentry))
-		goto out;
+	dentry = start_removing(&nop_mnt_idmap, dir, &QSTR(name));
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
-out:
-	dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(dir));
+	end_dirop(dentry);
 	return status;
 }
 
@@ -435,16 +427,14 @@ purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
+	child = start_removing(&nop_mnt_idmap, parent, &QSTR(cname));
 	if (!IS_ERR(child)) {
 		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
 		if (status)
 			printk("failed to remove client recovery directory %pd\n",
 			       child);
-		dput(child);
+		end_dirop(child);
 	}
-	inode_unlock(d_inode(parent));
 
 out_free:
 	kfree(name.data);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5c809cbc05fe..5bdd068dbdd7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2013,7 +2013,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 {
 	struct dentry	*dentry, *rdentry;
 	struct inode	*dirp;
-	struct inode	*rinode;
+	struct inode	*rinode = NULL;
 	__be32		err;
 	int		host_err;
 
@@ -2032,24 +2032,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	rdentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	rdentry = start_removing(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
+
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_unlock;
+		goto out_drop_write;
 
-	if (d_really_is_negative(rdentry)) {
-		dput(rdentry);
-		host_err = -ENOENT;
-		goto out_unlock;
-	}
-	rinode = d_inode(rdentry);
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
 
+	rinode = d_inode(rdentry);
+	/* Prevent truncation until after locks dropped */
 	ihold(rinode);
+
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
@@ -2071,10 +2068,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 	fh_fill_post_attrs(fhp);
 
-	inode_unlock(dirp);
-	if (!host_err)
+out_unlock:
+	end_dirop(rdentry);
+	if (!err && !host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
@@ -2092,9 +2089,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 7371f586e318..5feb92b84d84 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,8 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 
 struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
 
 void end_dirop(struct dentry *de);
 void end_dirop_mkdir(struct dentry *de, struct dentry *parent);
-- 
2.50.0.107.gf914562f5916.dirty


