Return-Path: <linux-fsdevel+bounces-66781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65377C2BE68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B56F3BEE18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BD9313264;
	Mon,  3 Nov 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGocjzKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34A312811;
	Mon,  3 Nov 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174391; cv=none; b=WG5qUQH9tX8krBl+exKskskHOGlLbdPRH8oYaj7T+wYk6xuYi5cMICV4p1rkAoRduPiNXSRTcCm4iat43H28JS7Tt+WKT8k/Ish3fAvndfNReb2E+00PfBcxA7npIfY2+xNY7J8cXqZd1PNS1PNdK4ElF3rISuxopvPIvBwDRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174391; c=relaxed/simple;
	bh=Abg5p2Lt31TlE/xurhC/XlffrDJLd5VW/QAzqsSk4cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMvFH5Tnx3bbyq3TTs5yrmwxC7ZDjHqSuUp6EBLJVrtunQxqVG2WcqFo2CXrStneUQehmV/hC8Y6FTNRwLraJXpB7UkxrVZzYdYypdJPs6Vpl2AR3zKfpIxYmE5GCuX3oRZ2HO/ZhQOisK2Q4DMyU57gx9nXJc84flyihiMCUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGocjzKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43502C4CEFD;
	Mon,  3 Nov 2025 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174391;
	bh=Abg5p2Lt31TlE/xurhC/XlffrDJLd5VW/QAzqsSk4cE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cGocjzKTKwgkB0U5jYi+t8Nqft5Qr4+UVgUpOf+IdFuoW2sWzZICll24l8ERwOfMX
	 1laAbKKVAEbp3uVEEpO2gCR1ptiWwN5rqiKhoryxqANFdLx16r5XMxV2ar4NohsVKy
	 ygscKqHIqbKuex1yVpQyhT154uaiZ2Entti1O9e2XR7tZZoHJERFNcyBWS/+37d0t/
	 1wo5EoHgxDbwFVtPvZQOS1Roa0CEFEc0VkYEhlCHS+gEMG5Qd/8QLCSQxfnMod3XTB
	 XYvb52suzu8s7l5Ot44h6jVkQ4ce3MlFVf81pm5PUFwSRRMKq963WBFOu25mCZkf0q
	 2YaUCiwqafxdg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:34 -0500
Subject: [PATCH v4 06/17] vfs: allow mkdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-6-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9247; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Abg5p2Lt31TlE/xurhC/XlffrDJLd5VW/QAzqsSk4cE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWcR1Qht8ekwA0ZBgB01/KBRuqP23ouw+Byi
 6wDZa2GfbiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnAAKCRAADmhBGVaC
 FajwD/oDNkM0xhUt8g+DQT4tQubhRSTHkKkCMKx1VhTGXNj4lWars4M58TcIjKmYBwbGl9KXYli
 u20zbC64lvl+/JC4D7lgEJNtqYzLzkbZDZ6YZ4dZOdpwIp7IHR6KxnmQaQjlq10pocmBoTGOHlv
 ETuxnjU+1RDH/hS70G7pTTYYgv3rSkBQdgaYDosc5LT9OrryhQISoG+b0i2WrlbywaFD5Gnd9Qh
 4ecn5QDNwsLMAW6100srZZ07DM0Mw5Oe4Ub7q9GOdAjeVrqAOgomnvbbiPx+5UNIuTX0kss9oml
 RnZ6MTFBHIH1CNw+T0qC7qbvEdSHrRnSeoBaE/lTa/ANMRqFkWH62eJJ03QXrcS9LdLmR2axaEm
 eiOmnlghZk7ai4CXMO7gZNuDIkWdDujkENarQmLpxbXXrlHnbqQhZx2wj63hPDefEdN2gN37+Uj
 WbD3ZrApgp7J7FKFKcpEsMQtXtnzgsAmbb0BMuy4NMyNveEhfJZPtoveSZp0B0uYaCCjto2BhlJ
 FIIdDL47oPafJH42xze6vTD6xNrPfMMYeTSqHG+Rxb/Ip6S7Q1dPNREub6MGVds+sxRBnGKy8lW
 Zm0VF2uwlGRDIpO9UOyH+YDwofjsycuHpOV5KN/fbUdzEgXd9Ui22ke6sw/vhyOplidmsDU7d69
 A4zwz+le6TmNPcQ==
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
index 5bcf3e93d350ffd290f72725c378d3dffeeae364..76c0587d991ff7307e3dde69497719d716c8d7b8 100644
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
+			 struct delegated_inode *delegated_inode)
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
+	struct delegated_inode delegated_inode = { };
 
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
+	if (is_delegated(&delegated_inode)) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index e2b9472e5c78c9f03731090ffdfb26eb5de38fe0..1f56834b2072fcee1d0d400bbb554b0c949ecab4 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -213,7 +213,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL);
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
 out_put:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9cb20d4aeab159ef3ba3584d1a3a33ef16ba4dea..97aef140cbf5fca4c41738fdcaccba3b57886463 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1558,7 +1558,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
index 909a88e3979d4f1ba3104f3d05145e1096ed44d5..20bb4c8a4e8e1be7e11047d228c05920ea6c388d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2114,7 +2114,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
-			 struct dentry *, umode_t);
+			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
 int vfs_symlink(struct mnt_idmap *, struct inode *,

-- 
2.51.1


