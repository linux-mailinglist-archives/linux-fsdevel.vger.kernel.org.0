Return-Path: <linux-fsdevel+bounces-67169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E407DC36E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C707188B08F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37B34A789;
	Wed,  5 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY9wqaZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C7347FE7;
	Wed,  5 Nov 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361687; cv=none; b=pbWnois6KZYXlXupCJX7O+A1dwtphsPAGhZAX+B4DOnjJltVSTQZhUng9ue+01jXvC4BPixOB5A5BscceiBXsETqaCjnCD0ofiLcjk7m61urZ8yswUEJ0eZx6gjt4eikJ009LRzM4udl0WqHJC3nPOFy+m0Ja7NWB+DrcDdab3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361687; c=relaxed/simple;
	bh=enwRSJtPuTCJax9ReM6vLhCWhCDrTpDxateSqGDz3Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRB7L7ZV5uGus2rTmF8rQn1yT8WCd1stHHDTRf0EqV9WvicLfpgXH0U61nRmwN2BAWGLhy0IMyHhtj0JHOZ3F5WueBjbrXpHic6wumovuHv1zGH0VADa7wteo9UzXZc2u5A3C6yyN/Rdn/y3qyi62jl4+R9KWbN8ICEEmbweNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY9wqaZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC8C4CEF5;
	Wed,  5 Nov 2025 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361687;
	bh=enwRSJtPuTCJax9ReM6vLhCWhCDrTpDxateSqGDz3Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eY9wqaZTGXiMaYlGu6x40FbDllAugWb9R3dizymjdrIogos1md+U9eF5bSF4HRwYx
	 D9uO8wXvGW6DkQ3ra7lseTnfHYBof73gcdauTvSs18i9fSQy0HNd0/woHRCQ+zyttv
	 bkLWwktaRr+ZodyIkpvoMf0GapxrK3TGimNKCoTlaJLWDt7IlrKbF3OSpJCDXCo7HJ
	 8Pjduc3f5nQSOt91L9UR8re0WT3JuasxMM+3bhWpeui+g1AL/SWYpfQDvMR+07K/V+
	 I7FPw9wLd3cYoP/gZC2GEpV43sLffaAjWnnEtdZO20SXCS2Mdsa8FpllDQbmVPtrbw
	 k/NgJGRZwGZJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:57 -0500
Subject: [PATCH v5 11/17] vfs: make vfs_mknod break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-11-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7475; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=enwRSJtPuTCJax9ReM6vLhCWhCDrTpDxateSqGDz3Cs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EsKClzzmFe3+aVQaOdkV21j38hqbV9HdNa5
 8gtElydNtyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBLAAKCRAADmhBGVaC
 FVKgEAC3o3liCkhkHJrxsl59eWlDlPOWm2a1UAd/3qGurTt7bUYnYyLLTDfOCcD8ustraVHy7it
 RMrER4nZ89a8fDi8fdJ0jsmn0m3KDdDIEqqQAkkIR/+sen05pNx095o3NvyE2N+Ob9d6uZuzfH6
 7Akk/3e7Ru+CrAkmLoozJR5W+8ErgxhaqJEt5n2gs0WEV3T9k+uqxUc9VoAY0yjng4ApoOzEXsI
 DEG6LaK7CY266/XX0MAoY2zbTwZAP0yRQhNOxCj33ePAqH8kRBB3joeVq+9Ahz7hcf9geiaVfbX
 aajAv/2igKPh0Cf27z2hjzHL92Z+eahsHKILyrJ1id1F40Qfu36Ii7gVKEJInifjBdHgmySsvyp
 K/UgqSeLWE5HBVBR3Svad3hG1tXKDxosWxIrfW67k9WPwf2+sVCUgkarWZS7+lT86X/slamJ22/
 N+TD2gtcUt/zTmGDiOMf5QYugivWCVFnouj9HsGnQcv2Pq1MNsvMLS27T7JyUAEILi4aOfgaRs5
 vr4rEDO6tle3EOkFbcaETafiDvVByRMhAbjXQnjdwYFBPwW9780QxfVzMN3hmsEBAVWn0isOxiv
 hflVLKU8b35tB+GTlPz0wsMFO8f5qV4y9Cde5yYyH+gxi7UOfb2f6yB7Jhm2Ud8vXGvi6UrQJX5
 ZWBODeDqJV47jAw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode pointer to vfs_mknod() and have the
appropriate callers wait when there is an outstanding delegation. All
other callers just set the pointer to NULL.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 23 +++++++++++++++--------
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 include/linux/fs.h       |  4 ++--
 net/unix/af_unix.c       |  2 +-
 8 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 104025104ef75381984fd94dfbd50feeaa8cdd22..2f576ecf18324f767cd5ac6cbd28adbf9f46b958 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -231,7 +231,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 		return PTR_ERR(dentry);
 
 	err = vfs_mknod(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode,
-			dev->devt);
+			dev->devt, NULL);
 	if (!err) {
 		struct iattr newattrs;
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 3341f00dd08753c8feab184dd82b8bfa63d3724a..83f06452476dec4025cc8f50e082ae6ccbbc7914 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -564,7 +564,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	if (!rc)
 		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode, dev);
+			       lower_dentry, mode, dev, NULL);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
diff --git a/fs/init.c b/fs/init.c
index 895f8a09a71acfd03e11164e3b441a7d4e2de146..4f02260dd65b0dfcbfbf5812d2ec6a33444a3b1f 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -157,7 +157,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
 		error = vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode, new_decode_dev(dev));
+				  dentry, mode, new_decode_dev(dev), NULL);
 	end_creating_path(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index b20f053374a578d36fb764e0df80fb7db9230dbe..e9616134390fb7f0d09a759be69bf677f8800bc5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4295,13 +4295,15 @@ inline struct dentry *start_creating_user_path(
 }
 EXPORT_SYMBOL(start_creating_user_path);
 
+
 /**
  * vfs_mknod - create device node or file
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child device node
- * @mode:	mode of the child device node
- * @dev:	device number of device to create
+ * @idmap:		idmap of the mount the inode was found from
+ * @dir:		inode of the parent directory
+ * @dentry:		dentry of the child device node
+ * @mode:		mode of the child device node
+ * @dev:		device number of device to create
+ * @delegated_inode:	returns parent inode, if the inode is delegated.
  *
  * Create a device node or file.
  *
@@ -4312,7 +4314,8 @@ EXPORT_SYMBOL(start_creating_user_path);
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode, dev_t dev)
+	      struct dentry *dentry, umode_t mode, dev_t dev,
+	      struct delegated_inode *delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4336,6 +4339,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4393,11 +4400,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, new_decode_dev(dev));
+					  dentry, mode, new_decode_dev(dev), &di);
 			break;
 		case S_IFIFO: case S_IFSOCK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, 0);
+					  dentry, mode, 0, &di);
 			break;
 	}
 out2:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index de5f46f8c6d3ab24fabddeed9bd59adbe7a486df..6684935007b17ed40723ff0a744045fd187ace5e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1573,7 +1573,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case S_IFIFO:
 	case S_IFSOCK:
 		host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
-				     iap->ia_mode, rdev);
+				     iap->ia_mode, rdev, NULL);
 		break;
 	default:
 		printk(KERN_WARNING "nfsd: bad file type %o in nfsd_create\n",
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index e30441cc9c63ff8b6c055db80be7974501d0023b..afd95721f76ea761cfe7133c3902028550f3e359 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -257,7 +257,7 @@ static inline int ovl_do_mknod(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev)
 {
-	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev);
+	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev, NULL);
 
 	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 83b05aec4e10c846d3168018fb62284e45ceb1a8..1a5d86cfafaa97fc89d15cd1a156968b8c3dd377 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2116,7 +2116,7 @@ int vfs_create(struct mnt_idmap *, struct dentry *, umode_t,
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
-              umode_t, dev_t);
+	      umode_t, dev_t, struct delegated_inode *);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
@@ -2152,7 +2152,7 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
 			       struct inode *dir, struct dentry *dentry)
 {
 	return vfs_mknod(idmap, dir, dentry, S_IFCHR | WHITEOUT_MODE,
-			 WHITEOUT_DEV);
+			 WHITEOUT_DEV, NULL);
 }
 
 struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec2310008632558ae928703b37c3cc8ef..db1fd8d6a84c2c7c0d45b43d9c5a936b3d491b7b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1399,7 +1399,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	idmap = mnt_idmap(parent.mnt);
 	err = security_path_mknod(&parent, dentry, mode, 0);
 	if (!err)
-		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0);
+		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0, NULL);
 	if (err)
 		goto out_path;
 	err = mutex_lock_interruptible(&u->bindlock);

-- 
2.51.1


