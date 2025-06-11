Return-Path: <linux-fsdevel+bounces-51375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD624AD63A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 01:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DC03AC999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96925B31F;
	Wed, 11 Jun 2025 22:59:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30252580F9;
	Wed, 11 Jun 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682744; cv=none; b=rxuZiVkuAXc2lQBx5rozQoFurqJzsUa6V2WYSr8vnMnUv7FQyq97inZx0Zp3nOdWFSeBqXOZ9283qy2HQi6ubs/riEE7F2ZC+rMUwx3wxFFPXjXL53oNbwo4MvFSU8sca7MxcaESjaBJByNzL8idX59yz6DIKKeJKYxQhKy73TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682744; c=relaxed/simple;
	bh=+i8C7N+posJFBcewdpBu2DKJvjSsCO80DrOe6h7VGLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNGTDGdcoHtK4+7PGfVWDsUJZYt9TD/92LQZORK4iRP2oXm/D/fcBbON5s9NBMmXJ1TEgifp+jk9aTPiLWPx9Asx3hFzafo/NlbxI32DBnuWa1j3sY9oyhxhavfV9CI8XK52gd/3QQyeXURQ00rSM41q5gEag/ZygKKMkTDS/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPUPK-008OC4-N0;
	Wed, 11 Jun 2025 22:58:58 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata to dentrys
Date: Thu, 12 Jun 2025 08:57:02 +1000
Message-ID: <20250611225848.1374929-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611225848.1374929-1-neil@brown.name>
References: <20250611225848.1374929-1-neil@brown.name>
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
index aecfc5c37b49..053fc28b5423 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -388,10 +388,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
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
index 493d7f194956..c9fec8b7e000 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -635,10 +635,10 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
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
index 019073162b8a..5b0be8bca50d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5007,7 +5007,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 int vfs_rename(struct renamedata *rd)
 {
 	int error;
-	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
+	struct inode *old_dir = d_inode(rd->old_dir), *new_dir = d_inode(rd->new_dir);
 	struct dentry *old_dentry = rd->old_dentry;
 	struct dentry *new_dentry = rd->new_dentry;
 	struct inode **delegated_inode = rd->delegated_inode;
@@ -5266,10 +5266,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
index cd689df2ca5d..3c87fbd22c57 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1864,7 +1864,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			    struct svc_fh *tfhp, char *tname, int tlen)
 {
 	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
-	struct inode	*fdir, *tdir;
 	int		type = S_IFDIR;
 	__be32		err;
 	int		host_err;
@@ -1880,10 +1879,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 
 	fdentry = ffhp->fh_dentry;
-	fdir = d_inode(fdentry);
 
 	tdentry = tfhp->fh_dentry;
-	tdir = d_inode(tdentry);
 
 	err = nfserr_perm;
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
@@ -1944,10 +1941,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
index d7310fcf3888..8a3c0d18ec2e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -563,7 +563,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 	} else {
-		err = ovl_do_rename(ofs, dir, temp, dir, index, 0);
+		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
 		dput(index);
 	}
 out:
@@ -762,7 +762,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
-	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
+	struct inode *wdir = d_inode(c->workdir);
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
@@ -829,7 +829,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(upper))
 		goto cleanup;
 
-	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
+	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fe493f3ed6b6..4fc221ea6480 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -107,7 +107,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 }
 
 /* Caller must hold i_mutex on both workdir and dir */
-int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
+int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
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
@@ -384,7 +384,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (err)
 		goto out_cleanup;
 
-	err = ovl_do_rename(ofs, wdir, opaquedir, udir, upper, RENAME_EXCHANGE);
+	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
 	if (err)
 		goto out_cleanup;
 
@@ -491,14 +491,14 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
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
@@ -774,7 +774,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
 
-	err = ovl_cleanup_and_whiteout(ofs, d_inode(upperdir), upper);
+	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
 	if (err)
 		goto out_d_drop;
 
@@ -1246,8 +1246,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (err)
 		goto out_dput;
 
-	err = ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
-			    new_upperdir->d_inode, newdentry, flags);
+	err = ovl_do_rename(ofs, old_upperdir, olddentry,
+			    new_upperdir, newdentry, flags);
 	if (err)
 		goto out_dput;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8baaba0a3fe5..65f9d51bed7c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -353,8 +353,8 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
 	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
 }
 
-static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
-				struct dentry *olddentry, struct inode *newdir,
+static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
+				struct dentry *olddentry, struct dentry *newdir,
 				struct dentry *newdentry, unsigned int flags)
 {
 	int err;
@@ -826,7 +826,7 @@ static inline void ovl_copyflags(struct inode *from, struct inode *to)
 
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
index e19940d649ca..cf99b276fdfb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -580,7 +580,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
index ba45e809555a..b8d913c61623 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -764,10 +764,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
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
index 16f40a6f8264..9a83904c9d4a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2016,10 +2016,10 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
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


