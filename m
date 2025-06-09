Return-Path: <linux-fsdevel+bounces-50973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FAEAD1847
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927C1166EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1B28001F;
	Mon,  9 Jun 2025 05:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAE191F89
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446447; cv=none; b=r7Dydqd/ID5M0orj1brPkLlPNoklMn/hJiXyX1vkzlB2y1HJaTY8SXTHcH4gRPl3JQtBdUwLzjauVXKqhza6srRFKxjcT/gX6cVHvaZGA5x7OhaFMXGsbLvgUgPXclt2iNgP3Qw4Hfq94Mc/gWuaLo5nwEwktG2xGO7FGkJgXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446447; c=relaxed/simple;
	bh=ykDRjqgd4MErHcMB0wQTKLP443woNaNLWx8RVM0t4l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLfcXUkqu5AUk+AfyxhNlY0hrbIakBu51O6R8El+cDhU6HCiCvR4bPJSlkVBEVb34QixZEmuf0ldWeI+nRhW1+YSAF+Eg3gGj0kzN3aTnzxq9ZVRjfZ5pp8a7MhyTbxVHwzveH/flH3iTA7jObx0CCcA3HrF8fy/EbkQ2oK9avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUw6-006ApZ-C8;
	Mon, 09 Jun 2025 05:20:42 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] VFS: change old_dir and new_dir in struct renamedata to dentrys
Date: Mon,  9 Jun 2025 15:01:15 +1000
Message-ID: <20250609051419.106580-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609051419.106580-1-neil@brown.name>
References: <20250609051419.106580-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

all users of 'struct renamedata' have the dentry for the old and new
directories, and often have no use for the inode except to store it in
the renamedata.

This patch changes struct renamedata to hold the dentry, rather than
the inode, for the old and new directories, and changes callers to
match.

This results in the removal of several local variables and several
dereferences of ->d_inode at the cost of adding ->d_inode dereferences
to vfs_rename().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    |  4 ++--
 fs/ecryptfs/inode.c      |  4 ++--
 fs/namei.c               |  6 +++---
 fs/nfsd/vfs.c            |  7 ++-----
 fs/overlayfs/copy_up.c   |  6 +++---
 fs/overlayfs/dir.c       | 16 ++++++++--------
 fs/overlayfs/overlayfs.h |  6 +++---
 fs/overlayfs/readdir.c   |  2 +-
 fs/overlayfs/super.c     |  2 +-
 fs/overlayfs/util.c      |  2 +-
 fs/smb/server/vfs.c      |  4 ++--
 include/linux/fs.h       |  4 ++--
 12 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 6644f0694169..abc689d3df54 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -392,10 +392,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	} else {
 		struct renamedata rd = {
 			.old_mnt_idmap	= &nop_mnt_idmap,
-			.old_dir	= d_inode(dir),
+			.old_dir	= dir,
 			.old_dentry	= rep,
 			.new_mnt_idmap	= &nop_mnt_idmap,
-			.new_dir	= d_inode(cache->graveyard),
+			.new_dir	= cache->graveyard,
 			.new_dentry	= grave,
 		};
 		trace_cachefiles_rename(object, d_inode(rep)->i_ino, why);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c513e912ae3c..3e627bcbaff1 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -636,10 +636,10 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	rd.old_mnt_idmap	= &nop_mnt_idmap;
-	rd.old_dir		= d_inode(lower_old_dir_dentry);
+	rd.old_dir		= lower_old_dir_dentry;
 	rd.old_dentry		= lower_old_dentry;
 	rd.new_mnt_idmap	= &nop_mnt_idmap;
-	rd.new_dir		= d_inode(lower_new_dir_dentry);
+	rd.new_dir		= lower_new_dir_dentry;
 	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
 	if (rc)
diff --git a/fs/namei.c b/fs/namei.c
index 55ce5700ba0e..32895140abde 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5142,7 +5142,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 int vfs_rename(struct renamedata *rd)
 {
 	int error;
-	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
+	struct inode *old_dir = d_inode(rd->old_dir), *new_dir = d_inode(rd->new_dir);
 	struct dentry *old_dentry = rd->old_dentry;
 	struct dentry *new_dentry = rd->new_dentry;
 	struct inode **delegated_inode = rd->delegated_inode;
@@ -5401,10 +5401,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	if (error)
 		goto exit5;
 
-	rd.old_dir	   = old_path.dentry->d_inode;
+	rd.old_dir	   = old_path.dentry;
 	rd.old_dentry	   = old_dentry;
 	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
-	rd.new_dir	   = new_path.dentry->d_inode;
+	rd.new_dir	   = new_path.dentry;
 	rd.new_dentry	   = new_dentry;
 	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
 	rd.delegated_inode = &delegated_inode;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index be29a18a23b2..a957e2631f49 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1872,7 +1872,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			    struct svc_fh *tfhp, char *tname, int tlen)
 {
 	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
-	struct inode	*fdir, *tdir;
 	int		type = S_IFDIR;
 	__be32		err;
 	int		host_err;
@@ -1888,10 +1887,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 
 	fdentry = ffhp->fh_dentry;
-	fdir = d_inode(fdentry);
 
 	tdentry = tfhp->fh_dentry;
-	tdir = d_inode(tdentry);
 
 	err = nfserr_perm;
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
@@ -1952,10 +1949,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	} else {
 		struct renamedata rd = {
 			.old_mnt_idmap	= &nop_mnt_idmap,
-			.old_dir	= fdir,
+			.old_dir	= fdentry,
 			.old_dentry	= odentry,
 			.new_mnt_idmap	= &nop_mnt_idmap,
-			.new_dir	= tdir,
+			.new_dir	= tdentry,
 			.new_dentry	= ndentry,
 		};
 		int retries;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 324429d02569..b14f9ca99d26 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -569,7 +569,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 	} else {
-		err = ovl_do_rename(ofs, dir, temp, dir, index, 0);
+		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
 		dput(index);
 	}
 out:
@@ -770,7 +770,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
-	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
+	struct inode *wdir = d_inode(c->workdir);
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
@@ -838,7 +838,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(upper))
 		goto cleanup;
 
-	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
+	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b4d92b51b63f..c95e3f5684f7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -107,7 +107,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 }
 
 /* Caller must hold i_mutex on both workdir and dir */
-int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
+int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir, // FIXME
 			     struct dentry *dentry)
 {
 	struct inode *wdir = ofs->workdir->d_inode;
@@ -123,7 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	err = ovl_do_rename(ofs, wdir, whiteout, dir, dentry, flags);
+	err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
 	if (err)
 		goto kill_whiteout;
 	if (flags)
@@ -394,7 +394,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (err)
 		goto out_cleanup;
 
-	err = ovl_do_rename(ofs, wdir, opaquedir, udir, upper, RENAME_EXCHANGE);
+	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
 	if (err)
 		goto out_cleanup;
 
@@ -506,14 +506,14 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 
-		err = ovl_do_rename(ofs, wdir, newdentry, udir, upper,
+		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
 				    RENAME_EXCHANGE);
 		if (err)
 			goto out_cleanup;
 
 		ovl_cleanup(ofs, wdir, upper);
 	} else {
-		err = ovl_do_rename(ofs, wdir, newdentry, udir, upper, 0);
+		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
 		if (err)
 			goto out_cleanup;
 	}
@@ -789,7 +789,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
 
-	err = ovl_cleanup_and_whiteout(ofs, d_inode(upperdir), upper);
+	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
 	if (err)
 		goto out_d_drop;
 
@@ -1261,8 +1261,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (err)
 		goto out_dput;
 
-	err = ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
-			    new_upperdir->d_inode, newdentry, flags);
+	err = ovl_do_rename(ofs, old_upperdir, olddentry,
+			    new_upperdir, newdentry, flags);
 	if (err)
 		goto out_dput;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 44df3a2449e7..0e4e5ed4cdc0 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -354,8 +354,8 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
 	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
 }
 
-static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
-				struct dentry *olddentry, struct inode *newdir,
+static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
+				struct dentry *olddentry, struct dentry *newdir,
 				struct dentry *newdentry, unsigned int flags)
 {
 	int err;
@@ -827,7 +827,7 @@ static inline void ovl_copyflags(struct inode *from, struct inode *to)
 
 /* dir.c */
 extern const struct inode_operations ovl_dir_inode_operations;
-int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
+int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 			     struct dentry *dentry);
 struct ovl_cattr {
 	dev_t rdev;
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 474c80d210d1..68cca52ae2ac 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1235,7 +1235,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			 * Whiteout orphan index to block future open by
 			 * handle after overlay nlink dropped to zero.
 			 */
-			err = ovl_cleanup_and_whiteout(ofs, dir, index);
+			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
 		} else {
 			/* Cleanup orphan index entries */
 			err = ovl_cleanup(ofs, dir, index);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5f3267e919dd..ce4d6874fcc6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -583,7 +583,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
-	err = ovl_do_rename(ofs, dir, temp, dir, dest, RENAME_WHITEOUT);
+	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
 	if (err) {
 		if (err == -EINVAL)
 			err = 0;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index dcccb4b4a66c..2b4754c645ee 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1115,7 +1115,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
 		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
-					       dir, index);
+					       indexdir, index);
 	} else {
 		/* Cleanup orphan index entries */
 		err = ovl_cleanup(ofs, dir, index);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a5599d2e9ab0..7e382763b496 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -770,10 +770,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	}
 
 	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt),
-	rd.old_dir		= d_inode(old_parent),
+	rd.old_dir		= old_parent,
 	rd.old_dentry		= old_child,
 	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt),
-	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dir		= new_path.dentry,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
 	rd.delegated_inode	= NULL,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..9b54b4e7dbb7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2014,10 +2014,10 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
  */
 struct renamedata {
 	struct mnt_idmap *old_mnt_idmap;
-	struct inode *old_dir;
+	struct dentry *old_dir;
 	struct dentry *old_dentry;
 	struct mnt_idmap *new_mnt_idmap;
-	struct inode *new_dir;
+	struct dentry *new_dir;
 	struct dentry *new_dentry;
 	struct inode **delegated_inode;
 	unsigned int flags;
-- 
2.49.0


