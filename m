Return-Path: <linux-fsdevel+bounces-58710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC6CB30A0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C294E1D05811
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A7BA42;
	Fri, 22 Aug 2025 00:11:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCFA48;
	Fri, 22 Aug 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821483; cv=none; b=fjS+7p1W4Lna0U4wG1ewXP7gxSgxWi8ZcQrtDSuHTo1edEH6/5uPy5rvfmPw01KUbvoz+qsrb9DLBPIGjAh2nIYx7Oist7nfNsigHyHJZqsBuazXBaEY0uy93nldohhrO10sjD2Xq8o/rHmb9CsZCjYAErW/XVK8+lvkjiMfEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821483; c=relaxed/simple;
	bh=w9NqnSfAAzN7pyPgJqvIpY2bJ5Qzw/yvyMsNLpzqYdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JandktBdpVkdnzazD+JqF4C9I807QEo/YQ/xpRvuLXbGEjYPzkbVr7XCqFRmeMssoLBXKZxdMPLHh7DAUISmQQMAsLiraFeokpHBw4M+wi088GsoyFJe4uW6r2rfwsoT5xbGC1f/C+agcQJ34lrNQQqT+ItquTtcUuxwIXcL4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFN8-006nab-HQ;
	Fri, 22 Aug 2025 00:11:12 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/16] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
Date: Fri, 22 Aug 2025 10:00:20 +1000
Message-ID: <20250822000818.1086550-3-neil@brown.name>
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

A rename can only rename with a single mount.  Callers of vfs_rename()
must and do ensure this is the case.

So there is no point in having two mnt_idmaps in renamedata as they are
always the same.  Only of of them is passed to ->rename in any case.

This patch replaces both with a single "mnt_idmap" and changes all
callers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    |  3 +--
 fs/ecryptfs/inode.c      |  3 +--
 fs/namei.c               | 17 ++++++++---------
 fs/nfsd/vfs.c            |  3 +--
 fs/overlayfs/overlayfs.h |  3 +--
 fs/smb/server/vfs.c      |  3 +--
 include/linux/fs.h       |  6 ++----
 7 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 91dfd0231877..d1edb2ac3837 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -387,10 +387,9 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
 		struct renamedata rd = {
-			.old_mnt_idmap	= &nop_mnt_idmap,
+			.mnt_idmap	= &nop_mnt_idmap,
 			.old_parent	= dir,
 			.old_dentry	= rep,
-			.new_mnt_idmap	= &nop_mnt_idmap,
 			.new_parent	= cache->graveyard,
 			.new_dentry	= grave,
 		};
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 72fbe1316ab8..abd954c6a14e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -634,10 +634,9 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_lock;
 	}
 
-	rd.old_mnt_idmap	= &nop_mnt_idmap;
+	rd.mnt_idmap		= &nop_mnt_idmap;
 	rd.old_parent		= lower_old_dir_dentry;
 	rd.old_dentry		= lower_old_dentry;
-	rd.new_mnt_idmap	= &nop_mnt_idmap;
 	rd.new_parent		= lower_new_dir_dentry;
 	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
diff --git a/fs/namei.c b/fs/namei.c
index 62c1e2268942..1d5fdcbe1828 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5022,20 +5022,20 @@ int vfs_rename(struct renamedata *rd)
 	if (source == target)
 		return 0;
 
-	error = may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
+	error = may_delete(rd->mnt_idmap, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(rd->new_mnt_idmap, new_dir, new_dentry);
+		error = may_create(rd->mnt_idmap, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(rd->new_mnt_idmap, new_dir,
+			error = may_delete(rd->mnt_idmap, new_dir,
 					   new_dentry, is_dir);
 		else
-			error = may_delete(rd->new_mnt_idmap, new_dir,
+			error = may_delete(rd->mnt_idmap, new_dir,
 					   new_dentry, new_is_dir);
 	}
 	if (error)
@@ -5050,13 +5050,13 @@ int vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(rd->old_mnt_idmap, source,
+			error = inode_permission(rd->mnt_idmap, source,
 						 MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(rd->new_mnt_idmap, target,
+			error = inode_permission(rd->mnt_idmap, target,
 						 MAY_WRITE);
 			if (error)
 				return error;
@@ -5124,7 +5124,7 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
+	error = old_dir->i_op->rename(rd->mnt_idmap, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
@@ -5267,10 +5267,9 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
 	rd.old_parent	   = old_path.dentry;
 	rd.old_dentry	   = old_dentry;
-	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
+	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
 	rd.new_parent	   = new_path.dentry;
 	rd.new_dentry	   = new_dentry;
-	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 98ab55ba3ced..5f3e99f956ca 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1943,10 +1943,9 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out_dput_old;
 	} else {
 		struct renamedata rd = {
-			.old_mnt_idmap	= &nop_mnt_idmap,
+			.mnt_idmap	= &nop_mnt_idmap,
 			.old_parent	= fdentry,
 			.old_dentry	= odentry,
-			.new_mnt_idmap	= &nop_mnt_idmap,
 			.new_parent	= tdentry,
 			.new_dentry	= ndentry,
 		};
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bb0d7ded8e76..4f84abaa0d68 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -361,10 +361,9 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 {
 	int err;
 	struct renamedata rd = {
-		.old_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
+		.mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.old_parent	= olddir,
 		.old_dentry	= olddentry,
-		.new_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.new_parent	= newdir,
 		.new_dentry	= newdentry,
 		.flags		= flags,
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 04539037108c..07739055ac9f 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -770,10 +770,9 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out4;
 	}
 
-	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt),
+	rd.mnt_idmap		= mnt_idmap(old_path->mnt),
 	rd.old_parent		= old_parent,
 	rd.old_dentry		= old_child,
-	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt),
 	rd.new_parent		= new_path.dentry,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..73b39e5bb9e4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2008,20 +2008,18 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 
 /**
  * struct renamedata - contains all information required for renaming
- * @old_mnt_idmap:     idmap of the old mount the inode was found from
+ * @mnt_idmap:     idmap of the mount in which the rename is happening.
  * @old_parent:        parent of source
  * @old_dentry:                source
- * @new_mnt_idmap:     idmap of the new mount the inode was found from
  * @new_parent:        parent of destination
  * @new_dentry:                destination
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
 struct renamedata {
-	struct mnt_idmap *old_mnt_idmap;
+	struct mnt_idmap *mnt_idmap;
 	struct dentry *old_parent;
 	struct dentry *old_dentry;
-	struct mnt_idmap *new_mnt_idmap;
 	struct dentry *new_parent;
 	struct dentry *new_dentry;
 	struct inode **delegated_inode;
-- 
2.50.0.107.gf914562f5916.dirty


