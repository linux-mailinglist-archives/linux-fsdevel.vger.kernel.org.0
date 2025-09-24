Return-Path: <linux-fsdevel+bounces-62622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B551B9B317
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6134E5457
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DDB31D368;
	Wed, 24 Sep 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgrGSYK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90E31C56F;
	Wed, 24 Sep 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737188; cv=none; b=PdMooYPUlHVafFE52M14/I86lmExcb/kDpiCO3XkLGRpaqYl5ifIgMjgEfNyO874JlGdxu1GvrPOTvR/omBQizN4YHvLzLmTJAbXKjr5jF3xS7irfbKhbuajVDnkw3O1nqUOTLc8Fd8AOTC8DsORx914V6tm5j8TIG55RI9pYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737188; c=relaxed/simple;
	bh=91t/VZ4w1HRKzWfj/m46dtMABknMoxedbQESpnEOTOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPuEYxfBXORjQj8oL/dSDMVgPf7ywk8jU2Na5HQPxh9KHnlqyneFrb1/vdYeU9vesfMjhYkmx4QZuggbFKkRZXsl66jOmp4UrbldtIU33oGojYdh2iS07aTVTfCZJk3YUd8eDXgSsPiRhcAoBrsRmJcUuRzDMaMDQYeMStfhniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgrGSYK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02754C116D0;
	Wed, 24 Sep 2025 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737188;
	bh=91t/VZ4w1HRKzWfj/m46dtMABknMoxedbQESpnEOTOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cgrGSYK4xn4RGSfZKdqivtkbewVHAaxxjnHec90dWxjMNcyyoBmoNZTe1FLZsU0oM
	 kErXRx49ISMDwtrG85cl6+jjoBfBElmU1tVe9+z8Da/lFayWBgR11QdVHO8DN0boIh
	 ipadYzVoWf2BociIvYy6G4huK9DTTc/8dy1IiL0aepKf/ydd0In03+HM4DiQ/2Bx0w
	 0pKEGww3dOCKJCaq2q/tciVo/9tIR+xE7A62opzZFxKaM+jOef9ksr8UT3d6tnesdO
	 QTer3aE1bXiiRfbOjE1QzW9YO4SdnnzANrtVG+CrJJqyv1sbzoGefY0I+mEm6NQfDG
	 he7v6eMDnKcZw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:50 -0400
Subject: [PATCH v3 04/38] vfs: allow mkdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-4-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9145; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=91t/VZ4w1HRKzWfj/m46dtMABknMoxedbQESpnEOTOw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMLPVuEI1usTTcMLz4VwycVIzeTF1e6qhaTT
 cF3rZdTRNeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCwAKCRAADmhBGVaC
 FXH7D/0fb+i1quegRfl6MAyECHKje5N5iV1o6hwrdXJNoNCqXxDIUe4sC35B1LP3U/oB8dwVDX5
 sfAjyuqR8xqbKdA26MHb9iDFtgjj6kkSC7u3pT9n5lNi/s/qBfTL+xJpx9LTmmSkVtcAItSjxw7
 jjd7p7Q6jP0vUS6xKGbRUohk6k8Z/Enfdb0vAwjBgfx//BIeYMuFtPsWgOM4Ibr+Xhsw5LQssiu
 B8G5fg0NUSoPShiQguBMc0o0d88wDdsDBvCvcsou85iFVsB4x55FG04EuBWbkocCXr3kLZnB6UC
 nn7E1IDc3b6UFuRXKqNjUZPVB4/9BZ8R43Qzmd8twh5jBTbTNLxTVmgO/KZTMUNX9vLgT7mXY9S
 sBQSoICZaD9JIHVgwZbIYY3qUroiWllB6wV3nTZ59pXwXrS5tGIkZjmVhw7833FsrO5WECrc4AV
 Lb3I2ER/WYiM8bs5GRNIDmezm9dkJt/uN8sabt0j0fiSsiXWX2gBtca2wjTtUyP45iCaBvUOBRi
 N/Y1ZD9Xw552QCnJn57ZUbbglSCvmQHQGqoiwXvDJQF2e7ep1ROfywXfRTCjWKFE8CqkoRkxtqh
 hUPpDN0/4h8rn1ToyDvTex4eDtpFUrrqDykceZK8KNWRRqFZvDqBFREfK9b1QgBleIsOO4f8p+P
 UUwoy0PKFNfH2ig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename the existing vfs_mkdir to __vfs_mkdir, make it static and add a
new delegated_inode parameter. Add a new exported vfs_mkdir wrapper
around it that passes a NULL pointer for delegated_inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/cachefiles/namei.c    |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 24 ++++++++++++++++++------
 fs/nfsd/nfs4recover.c    |  2 +-
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  2 +-
 fs/xfs/scrub/orphanage.c |  2 +-
 include/linux/fs.h       |  2 +-
 11 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 31bfb3194b4c29a1d6a002449045bf4e4141911d..a57da600ce7523e9e2755b78f75342bf4fa56ef6 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -180,7 +180,7 @@ static int dev_mkdir(const char *name, umode_t mode)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode, NULL);
 	if (!IS_ERR(dentry))
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 91dfd02318772fa63050ecf40fa5625ab48ad589..b3dac91efec622261186fbba8e704ae9e782bea0 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -130,7 +130,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			goto mkdir_error;
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
-			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NULL);
 		else
 			subdir = ERR_PTR(ret);
 		if (IS_ERR(subdir)) {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 72fbe1316ab8831bb4228d573278f32fe52b6b25..00f54c125b102856c33ffff24627475f40dcbc7b 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -517,7 +517,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 
 	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
-				 lower_dentry, mode);
+				 lower_dentry, mode, NULL);
 	rc = PTR_ERR(lower_dentry);
 	if (IS_ERR(lower_dentry))
 		goto out;
diff --git a/fs/init.c b/fs/init.c
index eef5124885e372ac020d2923692116c5e884b3cf..dd5240ce8ad41f02367a54ddf1b6ac0aa28e9721 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -232,7 +232,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error) {
 		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
+				  dentry, mode, NULL);
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index cd517eb232317d326e6d2fc5a60cb4c7569a137d..c939a58f16f9c4edded424475aff52f2c423d301 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4320,10 +4320,11 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 
 /**
  * vfs_mkdir - create directory returning correct dentry if possible
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child directory
- * @mode:	mode of the child directory
+ * @idmap:		idmap of the mount the inode was found from
+ * @dir:		inode of the parent directory
+ * @dentry:		dentry of the child directory
+ * @mode:		mode of the child directory
+ * @delegated_inode:	returns victim inode, if the inode is delegated.
  *
  * Create a directory.
  *
@@ -4340,7 +4341,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * In case of an error the dentry is dput() and an ERR_PTR() is returned.
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+			 struct dentry *dentry, umode_t mode,
+			 struct inode **delegated_inode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4363,6 +4365,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		goto err;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto err;
+
 	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	error = PTR_ERR(de);
 	if (IS_ERR(de))
@@ -4386,6 +4392,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	struct inode *delegated_inode = NULL;
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -4397,11 +4404,16 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
 		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
+				   dentry, mode, &delegated_inode);
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
 	done_path_create(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b1005abcb9035b2cf743200808a251b00af7e3f4..423dd102b51198ea7c447be2b9a0a5020c950dba 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -202,7 +202,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL);
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
 out_put:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2026431500ecbc0cf5fb5d4af1a7632c611ce4f4..6f1275fdc8ac831aa0ea8da588f751eddff88df1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1560,7 +1560,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
+		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, NULL);
 		if (IS_ERR(dchild)) {
 			host_err = PTR_ERR(dchild);
 		} else if (d_is_negative(dchild)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bb0d7ded8e763a4a7a6fc506d966ed2f3bdb4f06..4a3a22f422c37d45e49a762cd3c9957aa2c6a485 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -248,7 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
 {
 	struct dentry *ret;
 
-	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
+	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, NULL);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(ret));
 	return ret;
 }
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 04539037108c93e285f4e9d6aa61f93a507ae5da..b0fb73b277876a56797f5cc8a5aa53f156bb7a26 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -229,7 +229,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
 	d = dentry;
-	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
+	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode, NULL);
 	if (IS_ERR(dentry))
 		err = PTR_ERR(dentry);
 	else if (d_is_negative(dentry))
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 9c12cb8442311ca26b169e4d1567939ae44a5be0..91c9d07b97f306f57aebb9b69ba564b0c2cb8c17 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -167,7 +167,7 @@ xrep_orphanage_create(
 	 */
 	if (d_really_is_negative(orphanage_dentry)) {
 		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
-					     orphanage_dentry, 0750);
+					     orphanage_dentry, 0750, NULL);
 		error = PTR_ERR(orphanage_dentry);
 		if (IS_ERR(orphanage_dentry))
 			goto out_unlock_root;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 74f2bfc519263c6411a8e3427e1bd6680a1121db..24a091509f12ce65a2c8343d438fccf423d3062b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1997,7 +1997,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
-			 struct dentry *, umode_t);
+			 struct dentry *, umode_t, struct inode **);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
 int vfs_symlink(struct mnt_idmap *, struct inode *,

-- 
2.51.0


