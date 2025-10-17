Return-Path: <linux-fsdevel+bounces-64481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D6BE85C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE51AA0D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34C350D74;
	Fri, 17 Oct 2025 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Vqey2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABE28A3FA;
	Fri, 17 Oct 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700756; cv=none; b=DFHE67gVigmwsi39jkFYGt4FiQzrd61oR0CoOdWn74Xa61s1/DAJYvU2OGAolHNyYVKRCD7SAeLczAej6jEo28jW7Tav+tzv9TjuVi3O8ts2UUWdyoWWClrTQfg5Dl2/EN4vrGnQtJYW7Kb0XQOO3by+2ABKgVRq+DyLi3LP1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700756; c=relaxed/simple;
	bh=DITGPrxEBGAinDQ3TL6Rppcs0FME3zPsDBnrTn3EUy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JC7h+0B8P2O2BcOAo8MV2qcqs9E5aTqCYsPo6ABs3G+8NwcZazdMP8lA2cDkFUXZSiNYy/CkWm1nyCKRuGcNxx9EiGO2nw53W4bMz7tYp9CNg646sMxWU3uSK1tlXx1ll9gYSF3RaKPTUE7r+5IPyfz9D7uZNEnsRbctWJb2gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Vqey2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA91DC4CEFB;
	Fri, 17 Oct 2025 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700756;
	bh=DITGPrxEBGAinDQ3TL6Rppcs0FME3zPsDBnrTn3EUy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m/Vqey2FGjNvNYRNKfFA+VJKtBLFsFlvvungKu30w2u1Xm5scpMxGW/ZQ20p7XUpS
	 RzfQtp4LfGZ8ayT9llgK9q305aMk610aJ2vusAxnnynR0rdVeQkdV3oT26ScJOucA4
	 wbuu/WYWFb8WrmyQGV4Gdhl2KF5MjBPfy0N3PUpyf8K1WXEz/aKmFA7AwmpHKHKnac
	 j+iNVsakddb3R4y6KF9ftNyA7LpLE0/LoGeAGOM+FJUpVuezTuztpH0pbMozcrGudF
	 Wb85Bz6cE9c212NZklA1in3q5Bh8Xq15YIzkIk8qxxfwee/8bTTr0yiDSVuDCA0isk
	 YzBFR4gy+UXeg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:31:56 -0400
Subject: [PATCH v2 04/11] vfs: allow rmdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-4-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7725; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DITGPrxEBGAinDQ3TL6Rppcs0FME3zPsDBnrTn3EUy4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilBFHWbp7nQtOljMHFcQyFXCEC/22bbn5krC
 hRCoBTn5cGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQQAKCRAADmhBGVaC
 FZqvEACQuKYB5J24NCIBBxCMcO4nEXeWGPvptt18r6fjOtZ/Mg3KREIlbFvLSXcPDOe+egOVDTB
 gBjZhvjq800orb+y4Z/e2w09rOhtJ0SP5++m1Evbs9BnwVi7zdHNBNIlpqauOS0X9qEhOyi9R7G
 EgM9ahunDsQtjFjRJcnKLZpG4RwlrU/X4dERjFEo0Rew2pZQnRQzOlzMr3GJijzzz73As0zS+gL
 b1oYv31OokfgTo6tpP7uXwHcuwqaVHW7vdwz8bMXvNNUs0a0HP3JkzqB2gNQIQIYwN1CzOC1dVp
 maAoQpr4FB8XhuxqoomKM62WLHYimRFTfmcnbvj2vpQDBCUKNE0CIgCaBgw5MNzoFG/+K0HEHXU
 AbWSB3Zbe+mvWVb0db4oMwUyN8SP+q+zSZKOJL8KZre7/P1H1Sji6T7cYoN0f7TzKtBZfetlr6w
 Vo+Yhs+eLBTxqNZqnpMPC40BohhCTJCfQV9y8BlyAuEHQ4b0w3RwXAzdTxMtiRtcTpbltVf4b3g
 L6UG1b7dC3bW+sKmzQU8HCaAiGTSs+zXaYPsO5aKaWs5aWGjxK0M0A+FxiJA+ydncfvNqVKGINl
 4keXmXjCPGsfd/avLd1gUwGLfjTsCdZKqMfw+4yjzA9t/HQ2urcQsivx1pbAvtPz2wJCc1qUER8
 lbjMVhVTbcLglxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a "delegated_inode" return pointer to vfs_rmdir() and populate that
pointer with the parent inode if it's non-NULL. Most existing in-kernel
callers pass in a NULL pointer.

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
index 3dfbb85c9a1166b56e56eb9f1d6bfd140584730b..ad3acbb956d90cac88f74e5f598719af6f1f8328 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -275,7 +275,7 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
 out:
 	dput(dentry);
 out_unlock:
@@ -367,7 +367,7 @@ purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
 	if (!IS_ERR(child)) {
-		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child, NULL);
 		if (status)
 			printk("failed to remove client recovery directory %pd\n",
 			       child);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 447f5ab8e0b92288c9f220060ab15f32f2a84de9..7d8cd2595f197be9741ee6320d43ed6651896647 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2194,7 +2194,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
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


