Return-Path: <linux-fsdevel+bounces-66784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB1C2BEC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750A73A7936
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8A314A73;
	Mon,  3 Nov 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrenRr+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2230DD23;
	Mon,  3 Nov 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174401; cv=none; b=N+zgiN7awBgf4Sw2dyQ8NfB2y/JW8dbTCcDWgbFKmtp2TuDDq5fNJjchun5ffc9DysGD9KhUEFOHqXPDbiaMp/xml+Ye/vIclru/6ANo75Rhl6b5+veXCszp8aeS8hsN/4bUiXDcz5JfgocozgvhDG7bHTQUYndgy4l+980/BeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174401; c=relaxed/simple;
	bh=9qqxYTmkti/XE0jnEtcrEK19pEka9QAsFL9WwL3RtFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRcvTj4bKNNetJqxhjdKKtV/CbbQBbO1zwtjUAteLxSuXckiUgbsxMVuNiA0KZ7jL5NOiaFRfuERESmuzEGiHkNzuYTtF5CQk48BOwz+1XS6zIsmaWgedlpsZAqciAHCbDwY7v2sdKKCuRyWTpwtE275zriYF5u4AYZJUE7aBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrenRr+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7788CC113D0;
	Mon,  3 Nov 2025 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174401;
	bh=9qqxYTmkti/XE0jnEtcrEK19pEka9QAsFL9WwL3RtFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RrenRr+XJKzgRoR5koPB8mOl8niSorSfWE2rhDQKP61xKieAMY7R3vk8HhbMufvuC
	 pqBfIcSWqBXTIh0K/h8ZGbJpIRRqqkqKuHznR4dZPsCnikF4N1Y8eJBbMCT/zXjYyo
	 nQHACA1REZ2EZ43WdYkWvfzCFUsIGNNC8yLpTKE+J/kQmSG6sy4Z6ZM+Mj4j2l3+wR
	 obueKTS/lOCxF/x8GwDkGPWrP6HgsWozXgbIXea5okGx2aBHFpH+h8RaV4kg/n9rpx
	 An8qlRKYxsAyUQLvEyIyswTSQTg6ChH6KM9tXitjJ3voO36tUJ1ZR2x9/8cXK0co5a
	 qUaVpHIF7frSQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:37 -0500
Subject: [PATCH v4 09/17] vfs: add struct createdata for passing arguments
 to vfs_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-9-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9801; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9qqxYTmkti/XE0jnEtcrEK19pEka9QAsFL9WwL3RtFA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWd0zceYSjAxUd98e/4woWPyTt40Dx58/xAi
 xId39+B9iSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnQAKCRAADmhBGVaC
 FdPREADDxDX/Z+gC0PeTBwW7obHMQ82gbnNRawmHnk7XR+rkgF3F3DhgIgMOSZJHofm5DgHLnOu
 uQeJyg3SprXBdGtRxGT3EUKXekftnh5w6aekLepb5IGmCmT0h9nefQhwQea3z76hIEgbN9w6XoI
 MUWiH5/yWLUIgTDBk9V3MwGEV9p3xFu6LGL++ytXne9WlS7/CYw5Sc+cqK/NDIuMWgzUDkSNlQW
 +goh0yGVkYDfCXYA4nNSxlRAr8svUFOuVpiUoS7uW0duLzJiHKruDIYAeov2MH3TPFMjry1+ujq
 r2n4agesaIMsiB2hvG3F3QyNfUX7YsT7yTqM2YKi2WpLygW1UDzrJ4MM21A6h6ucJu6uhEZEJvn
 E2Ao4kereQEcLzkmjrzOdlAFO4HvTGt3TmXY6IfNgaSqxuQdgR2pwsc7WLdtqo8kjZeRMTPrr3T
 sx+kfsjbL+EMTRnAUd1gPIL7ojFbFeyasxEtWF5uI+Ne/PIVG3j98Nt7Hgpxp4Vz2OLoVg0FUa6
 rzaCwhd2YppD6XSJ3Nu7XZA2NdloBF9P9Kk6Tjf2vJS8z+Sz+9Us3ZMIsq4vayunKxCz19FqoXj
 n5aPOo2iyRnKzLT4R2KLxov6XDrj6caZkA4i0UlMhwB1Z96kuPYlv5oWn5FKxRzfVWhsGiYz5m9
 4EEW2SYvMbLFKqw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

vfs_create() has grown an uncomfortably long argument list, and a
following patch will add another. Convert it to take a new struct
createdata pointer and fix up the callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c      | 11 ++++++++---
 fs/namei.c               | 33 ++++++++++++++++++++-------------
 fs/nfsd/nfs3proc.c       |  9 ++++++++-
 fs/nfsd/vfs.c            | 19 ++++++++++++-------
 fs/open.c                |  9 ++++++---
 fs/overlayfs/overlayfs.h |  7 ++++++-
 fs/smb/server/vfs.c      |  9 +++++++--
 include/linux/fs.h       | 13 +++++++++++--
 8 files changed, 78 insertions(+), 32 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..51accd166dbf515eb5221b6a39b204622a6b0f7c 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -187,9 +187,14 @@ ecryptfs_do_create(struct inode *directory_inode,
 	struct inode *inode;
 
 	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+	if (!rc) {
+		struct createdata args = { .idmap = &nop_mnt_idmap,
+					   .dir = lower_dir,
+					   .dentry = lower_dentry,
+					   .mode = mode,
+					   .excl = true };
+		rc = vfs_create(&args);
+	}
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
diff --git a/fs/namei.c b/fs/namei.c
index f439429bdfa271ccc64c937771ef4175597feb53..fdf4e78cd041de8c564b7d1d89a46ba2aaf79d53 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3460,23 +3460,22 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 
 /**
  * vfs_create - create new file
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child file
- * @mode:	mode of the child file
- * @want_excl:	whether the file must not yet exist
+ * @args:	struct createdata describing create to be done
  *
  * Create a new file.
  *
  * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then take
- * care to map the inode according to @idmap before checking permissions.
+ * the vfsmount must be passed through @args->idmap. This function will then take
+ * care to map the inode according to @args->idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
  */
-int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool want_excl)
+int vfs_create(struct createdata *args)
 {
+	struct mnt_idmap *idmap = args->idmap;
+	struct inode *dir = args->dir;
+	struct dentry *dentry = args->dentry;
+	umode_t mode = args->mode;
 	int error;
 
 	error = may_create(idmap, dir, dentry);
@@ -3490,7 +3489,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
+	error = dir->i_op->create(idmap, dir, dentry, mode, args->excl);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4382,12 +4381,20 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 
 	idmap = mnt_idmap(path.mnt);
 	switch (mode & S_IFMT) {
-		case 0: case S_IFREG:
-			error = vfs_create(idmap, path.dentry->d_inode,
-					   dentry, mode, true);
+		case 0:
+		case S_IFREG:
+		{
+			struct createdata args = { .idmap = idmap,
+						   .dir = path.dentry->d_inode,
+						   .dentry = dentry,
+						   .mode = mode,
+						   .excl = true };
+
+			error = vfs_create(&args);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
+		}
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
 					  dentry, mode, new_decode_dev(dev));
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..dcd7de465e7e33d1c66ee0272c4f220d55e85928 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -258,6 +258,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct nfsd_attrs attrs = {
 		.na_iattr	= iap,
 	};
+	struct createdata cargs = { };
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
@@ -344,7 +345,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
+
+	cargs.idmap = &nop_mnt_idmap;
+	cargs.dir = inode;
+	cargs.dentry = child;
+	cargs.mode = iap->ia_mode;
+	cargs.excl = true;
+	host_err = vfs_create(&cargs);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c400ea94ff2e837fd59719bf2c4b79ef1d064743..e4ed1952f02c0a66c64528e59453cc9b2352c18f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1527,11 +1527,12 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   struct nfsd_attrs *attrs,
 		   int type, dev_t rdev, struct svc_fh *resfhp)
 {
-	struct dentry	*dentry, *dchild;
-	struct inode	*dirp;
-	struct iattr	*iap = attrs->na_iattr;
-	__be32		err;
-	int		host_err = 0;
+	struct dentry		*dentry, *dchild;
+	struct inode		*dirp;
+	struct iattr		*iap = attrs->na_iattr;
+	__be32			err;
+	int			host_err = 0;
+	struct createdata	cargs = { };
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
@@ -1552,8 +1553,12 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = 0;
 	switch (type) {
 	case S_IFREG:
-		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild,
-				      iap->ia_mode, true);
+		cargs.idmap = &nop_mnt_idmap;
+		cargs.dir = dirp;
+		cargs.dentry = dchild;
+		cargs.mode = iap->ia_mode;
+		cargs.excl = true;
+		host_err = vfs_create(&cargs);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
diff --git a/fs/open.c b/fs/open.c
index fdaa6f08f6f4cac5c2fefd3eafa5e430e51f3979..006cc2aeb1fbbb3db48b32db798108da120f75c2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1164,6 +1164,11 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred)
 {
+	struct createdata cargs = { .idmap = mnt_idmap(path->mnt),
+				    .dir = d_inode(path->dentry->d_parent),
+				    .dentry = path->dentry,
+				    .mode = mode,
+				    .excl = true };
 	struct file *f;
 	int error;
 
@@ -1171,9 +1176,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 	if (IS_ERR(f))
 		return f;
 
-	error = vfs_create(mnt_idmap(path->mnt),
-			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
+	error = vfs_create(&cargs);
 	if (!error)
 		error = vfs_open(path, f);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d215d7349489686b66bb66e939b27046f7d836f6..5fa939ac842ed04df8f0088233f4cba4ac703c05 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -235,7 +235,12 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
+	struct createdata cargs = { .idmap = ovl_upper_mnt_idmap(ofs),
+				    .dir = dir,
+				    .dentry = dentry,
+				    .mode = mode,
+				    .excl = true };
+	int err = vfs_create(&cargs);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c5f0f3170d586cb2dc4d416b80948c642797fb82..fbc3c34e14b870f1750b945349335afb62d89d0d 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -173,6 +173,7 @@ void ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
  */
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 {
+	struct createdata cargs = { };
 	struct path path;
 	struct dentry *dentry;
 	int err;
@@ -188,8 +189,12 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	}
 
 	mode |= S_IFREG;
-	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
-			 dentry, mode, true);
+	cargs.idmap = mnt_idmap(path.mnt);
+	cargs.dir = d_inode(path.dentry);
+	cargs.dentry = dentry;
+	cargs.mode = mode;
+	cargs.excl = true;
+	err = vfs_create(&cargs);
 	if (!err) {
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
 					d_inode(dentry));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 12873214e1c7811735ea5d2dee3d57e2a5604d8f..b61873767b37591aecadd147623d7dfc866bef82 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2111,8 +2111,17 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 /*
  * VFS helper functions..
  */
-int vfs_create(struct mnt_idmap *, struct inode *,
-	       struct dentry *, umode_t, bool);
+
+struct createdata {
+	struct mnt_idmap *idmap;	// idmap of the mount the inode was found from
+	struct inode *dir;		// inode of parent directory
+	struct dentry *dentry;		// dentry of the child file
+	umode_t mode;			// mode of the child file
+	bool excl;			// whether the file must not yet exist
+};
+
+int vfs_create(struct createdata *);
+
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.1


