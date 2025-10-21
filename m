Return-Path: <linux-fsdevel+bounces-64946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BFFBF7576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBAA421C63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E7345750;
	Tue, 21 Oct 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNUrwMoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE603343218;
	Tue, 21 Oct 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060373; cv=none; b=BmQo476v+4xBLzaq+V8rh8sgK8GcQHdRvLQnOdGnH7Mm11tY7H3fVb/d/1k/Ovzi3Oqz9w3ss4bCmmR3gFoR89ilNBe5wjbzYbygD1Y+0RqGta8aQqtasNfMDAWeOTiAwW7XFdnaGMgb2BNiEEz/hhDpB6UyPw6l8qMnVtbXqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060373; c=relaxed/simple;
	bh=fquIbNNyhedSINPdZZrOQAlr1sZhilSlFO2OBS1kyRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXrVMeLixcg7FVkBFIFgr/OlurFaHTfaJhh7M1htfNR5xk7pXVhbBLc462nSHX5vij5eGayZ+FZeUMdlXmEjS0STqg3acZBaWDqERxGGSNi6KuJRFxn+7y9N1yPUAoIKR8ITjWyr1kVLHNHVLnAoR8NocyHQem5iwomkAYtdiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNUrwMoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA94C4CEFF;
	Tue, 21 Oct 2025 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060372;
	bh=fquIbNNyhedSINPdZZrOQAlr1sZhilSlFO2OBS1kyRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QNUrwMoFfsN8arTX9+A9dfCjce3GPfmD+AsKqx7ZgwL2/L7kgr7w8a+0KFNK2BG32
	 uz9BuyeJlCVjQxWPsfZJY2cNeitCAuXwZXSR20v0kexFSj7Ugy2Z1Eg60ekXOlwEzx
	 sb4Zvtvc4z1M4X5G1rXwjK41QQT2gGm7RIbyJKuaxKhSV+1QJurZXN8WJ/dPzWCz5p
	 Uehbo/rfQ9Wp4+gWhvw0wQm0cDncjR43Ncm748VrIzHnQYpBXzlB9dzqjvQ+QKrSP7
	 ykLkgxI47uqDvQ+UoWvhx6w5jKQXCQcvo/kmXFl9N5Ip+sY7LjQZuvL63S9m5tQ3JM
	 mwOWt/HB/gbHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:38 -0400
Subject: [PATCH v3 03/13] vfs: allow mkdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-3-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9206; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fquIbNNyhedSINPdZZrOQAlr1sZhilSlFO2OBS1kyRE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YEQvzAe/BY5zs5Xj08cgX+PpuzZVP7N42Kz
 DMthrI7EzqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBAAKCRAADmhBGVaC
 FbGFD/9p1bzJRPPUavhf7yyhGVO/rQ/tQUSKEbYiThgW85u8P08BgCNbqm3Utd4VWqR9Ljd/o6u
 iplhVvFGa+cjrvu8Fg93oKwZGENyXeHwOlLJnXR3J91OzDCnOFDrvJ1NpoE4MHWAVH7imUlYxaf
 bpCNiPoEPznhGu1V7oFFoHRXF3p34WHd2JedfwOXL/xt+hY2LA3H8cx6Wop0FYPt3rjNngS4HNn
 qXgXya459zjx9k3XKGQ2aaJAqyrLaL51H/xLeMDnDr5wCSWTK+QbOfahxuRk4gH2LmZpw9q+kIh
 GpuEKwoZFxnVUG29eHlnGVyINE2Ke5nnwxfYhQR3VF5MGY8w9NRRlIWP4dJzqUHt+dm9w0z0gXw
 LZcsKXBM4WuDjMzCz/nEddhZW9sJH45KqCCdELTnxPdBtx0qGcYgOz7OciBgCtxSibdqaBU2qE0
 FWFlFScIZzhoep2bkHtbJSJMcox0OG/+hN5h8EbxAbeS4ahARaM9bxeNmg6516vVCoRomRqYwsx
 75LWjWquhOPPTiYPpyhRlv2gAQBsjG0ZjFrQ3FbdRjWb4UF0QzAJIZO/U8WIr1RPgyLEt9iRVGe
 h7PppVVvmuIKnBkF7SGYXr6L0mTDM2mF7MkEl7N3Y9jWvIp9zjIjA9fHXtQ6ekqtgtJl2eLLkzk
 2n0/P6kabXZlOIA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode parameter to vfs_mkdir. All of the existing
callers set that to NULL for now, except for do_mkdirat which will
properly block until the lease is gone.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
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
index 9d4e46ad8352257a6a65d85526ebdbf9bf2d4b19..0e79621cb0f79870003b867ca384199171ded4e0 100644
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
index d1edb2ac38376c4f9d2a18026450bb3c774f7824..50c0f9c76d1fd4c05db90d7d0d1bad574523ead0 100644
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
index ed1394da8d6bd7065f2a074378331f13fcda17f9..35830b3144f8f71374a78b3e7463b864f4fc216e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -508,7 +508,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 
 	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
-				 lower_dentry, mode);
+				 lower_dentry, mode, NULL);
 	rc = PTR_ERR(lower_dentry);
 	if (IS_ERR(lower_dentry))
 		goto out;
diff --git a/fs/init.c b/fs/init.c
index 07f592ccdba868509d0f3aaf9936d8d890fdbec5..895f8a09a71acfd03e11164e3b441a7d4e2de146 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -233,7 +233,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error) {
 		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
+				  dentry, mode, NULL);
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 6e61e0215b34134b1690f864e2719e3f82cf71a8..86cf6eca1f485361c6732974e4103cf5ea721539 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4407,10 +4407,11 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 
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
+ * @delegated_inode:	returns parent inode, if the inode is delegated.
  *
  * Create a directory.
  *
@@ -4427,7 +4428,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * In case of an error the dentry is dput() and an ERR_PTR() is returned.
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+			 struct dentry *dentry, umode_t mode,
+			 struct inode **delegated_inode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4450,6 +4452,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		goto err;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto err;
+
 	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	error = PTR_ERR(de);
 	if (IS_ERR(de))
@@ -4473,6 +4479,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	struct inode *delegated_inode = NULL;
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -4484,11 +4491,16 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
 		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
+				   dentry, mode, &delegated_inode);
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
 	end_creating_path(&path, dentry);
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
index 8b2dc7a88aab015d1e39da0dd4e6daf7e276aabe..5f24af289d509bea54a324b8851fa06de6050353 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1645,7 +1645,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
+		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, NULL);
 		if (IS_ERR(dchild)) {
 			host_err = PTR_ERR(dchild);
 		} else if (d_is_negative(dchild)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c8fd5951fc5ece1ae6b3e2a0801ca15f9faf7d72..0f65f9a5d54d4786b39e4f4f30f416d5b9016e70 100644
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
index 891ed2dc2b7351a5cb14a2241d71095ffdd03f08..3d2190f26623b23ea79c63410905a3c3ad684048 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -230,7 +230,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
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
index c895146c1444be36e0a779df55622cc38c9419ff..1040df3792794cd353b86558b41618294e25b8a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2113,7 +2113,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
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


