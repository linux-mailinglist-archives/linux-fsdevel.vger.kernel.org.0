Return-Path: <linux-fsdevel+bounces-51532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 853ADAD7EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 01:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D89B7A400C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 23:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228112DECBE;
	Thu, 12 Jun 2025 23:28:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BE1F0E39;
	Thu, 12 Jun 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770916; cv=none; b=K/XWjl98hw0d4u83oWO1XPLe8r2icpDwaaKnBcVNn/NMwXHGE24OLVjATWCVZzmaacJbraLUOMeB2YHs3Evx++HFv4I2fZpaGSel8EGEVErLzgJ3p+ZloUvYjDnMaVzdGbsiPlXWykp739oH92GQwzFoI6/3I6LNbl4eXqfZsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770916; c=relaxed/simple;
	bh=sGuQpP9eBHz1he+7ZUmvO1rzvdAKupsjz6vOUwHgT3Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=WwknvgSBUfmEeJGY2yK3tNxV+8ZYGEukS8OWcnZBX9Xakn0rTgTU/Mzb30mAWNEFSpsxwffu4skHjAdKxbftt3aCRH8Ziz5NQwBVqtzVpgosM/+waGZMZkZPT1wSCKw2skhvtIIBfsJkj5Be52soK/AsIYtfetmoY84wQem8eyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPrLB-009VyA-1P;
	Thu, 12 Jun 2025 23:28:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>, netfs@lists.linux.dev,
 linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject:
 [PATCH v2] VFS: change old_dir and new_dir in struct renamedata to dentrys
Date: Fri, 13 Jun 2025 09:28:10 +1000
Message-id: <174977089072.608730.4244531834577097454@noble.neil.brown.name>


all users of 'struct renamedata' have the dentry for the old and new
directories, and often have no use for the inode except to store it in
the renamedata.

This patch changes struct renamedata to hold the dentry, rather than
the inode, for the old and new directories, and changes callers to
match.  The names are also changed from a _dir suffix to _parent.  This
is consistent with other usage in namei.c and elsewhere.

This results in the removal of several local variables and several
dereferences of ->d_inode at the cost of adding ->d_inode dereferences
to vfs_rename().

Acked-by: Miklos Szeredi <miklos@szeredi.hu> (overlayfs parts)
Reviewed-by: Chuck Lever <chuck.lever@oracle.com> (For the NFSD hunks)
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org> (For ksmbd part)
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    |  4 ++--
 fs/ecryptfs/inode.c      |  4 ++--
 fs/namei.c               |  7 ++++---
 fs/nfsd/vfs.c            |  7 ++-----
 fs/overlayfs/copy_up.c   |  6 +++---
 fs/overlayfs/dir.c       | 16 ++++++++--------
 fs/overlayfs/overlayfs.h | 16 ++++++++--------
 fs/overlayfs/readdir.c   |  2 +-
 fs/overlayfs/super.c     |  2 +-
 fs/overlayfs/util.c      |  2 +-
 fs/smb/server/vfs.c      |  4 ++--
 include/linux/fs.h       |  8 ++++----
 12 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index aecfc5c37b49..91dfd0231877 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -388,10 +388,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cac=
he,
 	} else {
 		struct renamedata rd =3D {
 			.old_mnt_idmap	=3D &nop_mnt_idmap,
-			.old_dir	=3D d_inode(dir),
+			.old_parent	=3D dir,
 			.old_dentry	=3D rep,
 			.new_mnt_idmap	=3D &nop_mnt_idmap,
-			.new_dir	=3D d_inode(cache->graveyard),
+			.new_parent	=3D cache->graveyard,
 			.new_dentry	=3D grave,
 		};
 		trace_cachefiles_rename(object, d_inode(rep)->i_ino, why);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 493d7f194956..bd317d943d62 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -635,10 +635,10 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *=
old_dir,
 	}
=20
 	rd.old_mnt_idmap	=3D &nop_mnt_idmap;
-	rd.old_dir		=3D d_inode(lower_old_dir_dentry);
+	rd.old_parent		=3D lower_old_dir_dentry;
 	rd.old_dentry		=3D lower_old_dentry;
 	rd.new_mnt_idmap	=3D &nop_mnt_idmap;
-	rd.new_dir		=3D d_inode(lower_new_dir_dentry);
+	rd.new_parent		=3D lower_new_dir_dentry;
 	rd.new_dentry		=3D lower_new_dentry;
 	rc =3D vfs_rename(&rd);
 	if (rc)
diff --git a/fs/namei.c b/fs/namei.c
index 019073162b8a..a056fe0b5bde 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5007,7 +5007,8 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, con=
st char __user *, newname
 int vfs_rename(struct renamedata *rd)
 {
 	int error;
-	struct inode *old_dir =3D rd->old_dir, *new_dir =3D rd->new_dir;
+	struct inode *old_dir =3D d_inode(rd->old_parent);
+	struct inode *new_dir =3D d_inode(rd->new_parent);
 	struct dentry *old_dentry =3D rd->old_dentry;
 	struct dentry *new_dentry =3D rd->new_dentry;
 	struct inode **delegated_inode =3D rd->delegated_inode;
@@ -5266,10 +5267,10 @@ int do_renameat2(int olddfd, struct filename *from, i=
nt newdfd,
 	if (error)
 		goto exit5;
=20
-	rd.old_dir	   =3D old_path.dentry->d_inode;
+	rd.old_parent	   =3D old_path.dentry;
 	rd.old_dentry	   =3D old_dentry;
 	rd.old_mnt_idmap   =3D mnt_idmap(old_path.mnt);
-	rd.new_dir	   =3D new_path.dentry->d_inode;
+	rd.new_parent	   =3D new_path.dentry;
 	rd.new_dentry	   =3D new_dentry;
 	rd.new_mnt_idmap   =3D mnt_idmap(new_path.mnt);
 	rd.delegated_inode =3D &delegated_inode;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd689df2ca5d..7d522e426b2d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1864,7 +1864,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp=
, char *fname, int flen,
 			    struct svc_fh *tfhp, char *tname, int tlen)
 {
 	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
-	struct inode	*fdir, *tdir;
 	int		type =3D S_IFDIR;
 	__be32		err;
 	int		host_err;
@@ -1880,10 +1879,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffh=
p, char *fname, int flen,
 		goto out;
=20
 	fdentry =3D ffhp->fh_dentry;
-	fdir =3D d_inode(fdentry);
=20
 	tdentry =3D tfhp->fh_dentry;
-	tdir =3D d_inode(tdentry);
=20
 	err =3D nfserr_perm;
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
@@ -1944,10 +1941,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ff=
hp, char *fname, int flen,
 	} else {
 		struct renamedata rd =3D {
 			.old_mnt_idmap	=3D &nop_mnt_idmap,
-			.old_dir	=3D fdir,
+			.old_parent	=3D fdentry,
 			.old_dentry	=3D odentry,
 			.new_mnt_idmap	=3D &nop_mnt_idmap,
-			.new_dir	=3D tdir,
+			.new_parent	=3D tdentry,
 			.new_dentry	=3D ndentry,
 		};
 		int retries;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index d7310fcf3888..8a3c0d18ec2e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -563,7 +563,7 @@ static int ovl_create_index(struct dentry *dentry, const =
struct ovl_fh *fh,
 	if (IS_ERR(index)) {
 		err =3D PTR_ERR(index);
 	} else {
-		err =3D ovl_do_rename(ofs, dir, temp, dir, index, 0);
+		err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
 		dput(index);
 	}
 out:
@@ -762,7 +762,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
-	struct inode *udir =3D d_inode(c->destdir), *wdir =3D d_inode(c->workdir);
+	struct inode *wdir =3D d_inode(c->workdir);
 	struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
@@ -829,7 +829,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(upper))
 		goto cleanup;
=20
-	err =3D ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
+	err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fe493f3ed6b6..4fc221ea6480 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -107,7 +107,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 }
=20
 /* Caller must hold i_mutex on both workdir and dir */
-int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
+int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 			     struct dentry *dentry)
 {
 	struct inode *wdir =3D ofs->workdir->d_inode;
@@ -123,7 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct i=
node *dir,
 	if (d_is_dir(dentry))
 		flags =3D RENAME_EXCHANGE;
=20
-	err =3D ovl_do_rename(ofs, wdir, whiteout, dir, dentry, flags);
+	err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
 	if (err)
 		goto kill_whiteout;
 	if (flags)
@@ -384,7 +384,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dent=
ry,
 	if (err)
 		goto out_cleanup;
=20
-	err =3D ovl_do_rename(ofs, wdir, opaquedir, udir, upper, RENAME_EXCHANGE);
+	err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCH=
ANGE);
 	if (err)
 		goto out_cleanup;
=20
@@ -491,14 +491,14 @@ static int ovl_create_over_whiteout(struct dentry *dent=
ry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
=20
-		err =3D ovl_do_rename(ofs, wdir, newdentry, udir, upper,
+		err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
 				    RENAME_EXCHANGE);
 		if (err)
 			goto out_cleanup;
=20
 		ovl_cleanup(ofs, wdir, upper);
 	} else {
-		err =3D ovl_do_rename(ofs, wdir, newdentry, udir, upper, 0);
+		err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
 		if (err)
 			goto out_cleanup;
 	}
@@ -774,7 +774,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
=20
-	err =3D ovl_cleanup_and_whiteout(ofs, d_inode(upperdir), upper);
+	err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
 	if (err)
 		goto out_d_drop;
=20
@@ -1246,8 +1246,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct i=
node *olddir,
 	if (err)
 		goto out_dput;
=20
-	err =3D ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
-			    new_upperdir->d_inode, newdentry, flags);
+	err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
+			    new_upperdir, newdentry, flags);
 	if (err)
 		goto out_dput;
=20
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8baaba0a3fe5..78deb89e16b5 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -353,19 +353,19 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs,=
 struct dentry *dentry,
 	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
 }
=20
-static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
-				struct dentry *olddentry, struct inode *newdir,
+static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
+				struct dentry *olddentry, struct dentry *newdir,
 				struct dentry *newdentry, unsigned int flags)
 {
 	int err;
 	struct renamedata rd =3D {
 		.old_mnt_idmap	=3D ovl_upper_mnt_idmap(ofs),
-		.old_dir 	=3D olddir,
-		.old_dentry 	=3D olddentry,
+		.old_parent	=3D olddir,
+		.old_dentry	=3D olddentry,
 		.new_mnt_idmap	=3D ovl_upper_mnt_idmap(ofs),
-		.new_dir 	=3D newdir,
-		.new_dentry 	=3D newdentry,
-		.flags 		=3D flags,
+		.new_parent	=3D newdir,
+		.new_dentry	=3D newdentry,
+		.flags		=3D flags,
 	};
=20
 	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
@@ -826,7 +826,7 @@ static inline void ovl_copyflags(struct inode *from, stru=
ct inode *to)
=20
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
-			err =3D ovl_cleanup_and_whiteout(ofs, dir, index);
+			err =3D ovl_cleanup_and_whiteout(ofs, indexdir, index);
 		} else {
 			/* Cleanup orphan index entries */
 			err =3D ovl_cleanup(ofs, dir, index);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e19940d649ca..cf99b276fdfb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -580,7 +580,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
=20
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
-	err =3D ovl_do_rename(ofs, dir, temp, dir, dest, RENAME_WHITEOUT);
+	err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
 	if (err) {
 		if (err =3D=3D -EINVAL)
 			err =3D 0;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index dcccb4b4a66c..2b4754c645ee 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1115,7 +1115,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
 		err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
-					       dir, index);
+					       indexdir, index);
 	} else {
 		/* Cleanup orphan index entries */
 		err =3D ovl_cleanup(ofs, dir, index);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index ba45e809555a..2f0171896e5d 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -764,10 +764,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const str=
uct path *old_path,
 	}
=20
 	rd.old_mnt_idmap	=3D mnt_idmap(old_path->mnt),
-	rd.old_dir		=3D d_inode(old_parent),
+	rd.old_parent		=3D old_parent,
 	rd.old_dentry		=3D old_child,
 	rd.new_mnt_idmap	=3D mnt_idmap(new_path.mnt),
-	rd.new_dir		=3D new_path.dentry->d_inode,
+	rd.new_parent		=3D new_path.dentry,
 	rd.new_dentry		=3D new_dentry,
 	rd.flags		=3D flags,
 	rd.delegated_inode	=3D NULL,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 16f40a6f8264..9043f5d8a2cf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2006,20 +2006,20 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, st=
ruct dentry *,
 /**
  * struct renamedata - contains all information required for renaming
  * @old_mnt_idmap:     idmap of the old mount the inode was found from
- * @old_dir:           parent of source
+ * @old_parent:        parent of source
  * @old_dentry:                source
  * @new_mnt_idmap:     idmap of the new mount the inode was found from
- * @new_dir:           parent of destination
+ * @new_parent:        parent of destination
  * @new_dentry:                destination
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
 struct renamedata {
 	struct mnt_idmap *old_mnt_idmap;
-	struct inode *old_dir;
+	struct dentry *old_parent;
 	struct dentry *old_dentry;
 	struct mnt_idmap *new_mnt_idmap;
-	struct inode *new_dir;
+	struct dentry *new_parent;
 	struct dentry *new_dentry;
 	struct inode **delegated_inode;
 	unsigned int flags;
--=20
2.49.0


