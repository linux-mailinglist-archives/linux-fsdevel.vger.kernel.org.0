Return-Path: <linux-fsdevel+bounces-64947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C35BF759A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296C7542F7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A9346772;
	Tue, 21 Oct 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8slyY9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE6345CD7;
	Tue, 21 Oct 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060376; cv=none; b=RRKwjdnKsWaLWxdhExNcoX1fKrwCehPmZHXos2+E7Ki13bAwY57W4XhDvUZjaqZe/Tsh3NDN4uSNYEXUMz9thT3dc4n+eh1fNbreZFdmezRbsy55fePgMwGlwJoWsrV5didcp23+FFWTGLvcRU1ViBVz60rW2sI+0UsuYFxUqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060376; c=relaxed/simple;
	bh=BNQJaBr9mlUE++piDiBq8FCyr25mMT9XYhs2EJPR/Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8Q2JD/pQuPwA14AGO8fduSOo8QVylsNeToGQJAbiYNDqSYuvOhGPATnG2/WZFT27EfiQTRncnpPtkzhhNxmLTTcj+i3HV3Vc0WR3oFz0PPme0cWwz+XpQZ0eg70n6H+QyJVUfGauQpjv9aT5UCqwnGU9utfu85WKXtF/Lz+TcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8slyY9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18C7C4CEF5;
	Tue, 21 Oct 2025 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060375;
	bh=BNQJaBr9mlUE++piDiBq8FCyr25mMT9XYhs2EJPR/Xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j8slyY9/EzfWqT9d1gOhJXKTREgF/3ZqzuKT9hzAUesJgbxDH2NPwE0N04vDJtmis
	 WMKLq2VOwCbvVRotHdq+i4au61qzx1IqqnmftqHbEZxH8eu1qvQ7e8HAFxnKOTQy+b
	 SDFACXk2nLA4cc2OG3TSvyCEwCL8BMTunHog3NnwOBFohN1rvwusKA/WEp22i9o9Ze
	 9ykO6vuelpX2c/uPpi+G75Qscj7+Wwrhpbpo/vbOcxcIqRGCv2hXBh6t6g0rG3dqDW
	 JCSTmYpKFBw9J0p700sDpwm1UtIpvHj9rPKXAspaEd38EePDL5aBMbJQItMQltLsgv
	 GZL8f53EmU4Sg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:39 -0400
Subject: [PATCH v3 04/13] vfs: allow rmdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-4-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7805; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BNQJaBr9mlUE++piDiBq8FCyr25mMT9XYhs2EJPR/Xs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YEc0WpYvNNJg2vjpK158r69HFb+eiOu0/nV
 zrWk03ddqGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBAAKCRAADmhBGVaC
 FXzID/97EQQYYEK2GhVBQftEuPS9kZL/rJY7+/9hYTzhhbQBLXBFiB1NvDUffXBlE2s4m+eXTVP
 CptsZs8gEfKf/he0IveDANnHo8yIS0Ti4f+6JijQvMZtThvglqppnf6msbeXnIsRzneltlJoAFm
 wDeRFX9JORLGCpa+fzUfiiG6FBVK8JWo00teMMQL0pLUjCvtvN8JfWKUgHQQi1+TISX2pH9h+SY
 FttEiY4IFGdqOrwxwHp7o38Fbq1QMPHYWdkQcQn3HH4qpUdPjUP7BshV6/dpDhV2plCfDaQ0Wpg
 Sk5ijtheKtO0JWVAYjJcPu9riF9iBqvjZ603KN0Mn3k1jIu1g5dg0FrGjVVgNaojAd9ldINEkOC
 UnVpHy+zppEVeGHOZMz2CGCyRbbNFBYt2oukQZZf00Mt06745kb/3RhN26u2Qyh4ex9TjRjaMTe
 2KHkzeQdYs007w4xufoWUtC1P2z2jdFhNEjen9tKe+UCqJlCPA61lwCgxOEN7CUzufyJCsCM1K3
 GuSLU9AYJgzR92yLJFcvqf6FlvIB68M4s3J5toFGj1kBBnf5uHP/MZSiteG/cP0zuOm5iOytbPZ
 v9GRpY5LevETXKxZeV33LMuF+lgmsjLq55Vi2eLJHFARBvwG+Gh1L9aL5Nx2nyWLYX/KkpGNdQQ
 WPde2lgy4peh9XA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a "delegated_inode" return pointer to vfs_rmdir() and populate that
pointer with the parent inode if it's non-NULL. Most existing in-kernel
callers pass in a NULL pointer.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/namei.c               | 22 +++++++++++++++++-----
 fs/nfsd/nfs4recover.c    |  4 ++--
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  4 ++--
 include/linux/fs.h       |  3 ++-
 8 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 0e79621cb0f79870003b867ca384199171ded4e0..104025104ef75381984fd94dfbd50feeaa8cdd22 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -261,7 +261,7 @@ static int dev_rmdir(const char *name)
 		return PTR_ERR(dentry);
 	if (d_inode(dentry)->i_private == &thread)
 		err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
-				dentry);
+				dentry, NULL);
 	else
 		err = -EPERM;
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 35830b3144f8f71374a78b3e7463b864f4fc216e..88631291b32535f623a3fbe4ea9b6ed48a306ca0 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -540,7 +540,7 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 		if (d_unhashed(lower_dentry))
 			rc = -EINVAL;
 		else
-			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
+			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
 	}
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
diff --git a/fs/namei.c b/fs/namei.c
index 86cf6eca1f485361c6732974e4103cf5ea721539..4b5a99653c558397e592715d9d4663cd4a63ef86 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4522,9 +4522,10 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 
 /**
  * vfs_rmdir - remove directory
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child directory
+ * @idmap:		idmap of the mount the inode was found from
+ * @dir:		inode of the parent directory
+ * @dentry:		dentry of the child directory
+ * @delegated_inode:	returns parent inode, if it's delegated.
  *
  * Remove a directory.
  *
@@ -4535,7 +4536,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry)
+	      struct dentry *dentry, struct inode **delegated_inode)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
 
@@ -4557,6 +4558,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto out;
+
 	error = dir->i_op->rmdir(dir, dentry);
 	if (error)
 		goto out;
@@ -4583,6 +4588,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4612,7 +4618,8 @@ int do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
-	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
+	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+			  dentry, &delegated_inode);
 exit4:
 	dput(dentry);
 exit3:
@@ -4620,6 +4627,11 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 423dd102b51198ea7c447be2b9a0a5020c950dba..71f8bf25d209937e13c9ae563101b7d8bf55f4ce 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -315,7 +315,7 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
 out:
 	dput(dentry);
 out_unlock:
@@ -409,7 +409,7 @@ purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
 	if (!IS_ERR(child)) {
-		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child, NULL);
 		if (status)
 			printk("failed to remove client recovery directory %pd\n",
 			       child);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5f24af289d509bea54a324b8851fa06de6050353..85afd2fad7e08b66b1a9ce372afdea1df52086be 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2195,7 +2195,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 				break;
 		}
 	} else {
-		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry);
+		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry, NULL);
 	}
 	fh_fill_post_attrs(fhp);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0f65f9a5d54d4786b39e4f4f30f416d5b9016e70..d215d7349489686b66bb66e939b27046f7d836f6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -206,7 +206,7 @@ static inline int ovl_do_notify_change(struct ovl_fs *ofs,
 static inline int ovl_do_rmdir(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry);
+	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry, NULL);
 
 	pr_debug("rmdir(%pd2) = %i\n", dentry, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 3d2190f26623b23ea79c63410905a3c3ad684048..c5f0f3170d586cb2dc4d416b80948c642797fb82 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -609,7 +609,7 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 
 	idmap = mnt_idmap(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
-		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
+		err = vfs_rmdir(idmap, d_inode(parent), path->dentry, NULL);
 		if (err && err != -ENOTEMPTY)
 			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
 	} else {
@@ -1090,7 +1090,7 @@ int ksmbd_vfs_unlink(struct file *filp)
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
-		err = vfs_rmdir(idmap, d_inode(dir), dentry);
+		err = vfs_rmdir(idmap, d_inode(dir), dentry, NULL);
 	else
 		err = vfs_unlink(idmap, d_inode(dir), dentry, NULL);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1040df3792794cd353b86558b41618294e25b8a6..d8bdaf7c87502ff17775602f5391d375738b4ed8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2120,7 +2120,8 @@ int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct inode **);
-int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
+int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,
+	      struct inode **);
 int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 	       struct inode **);
 

-- 
2.51.0


