Return-Path: <linux-fsdevel+bounces-63980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA84CBD3D5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323CC4F7A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184E30DEA1;
	Mon, 13 Oct 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ52bAen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2530DD16;
	Mon, 13 Oct 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366924; cv=none; b=VuDodnsoz1WN2YZCftfy4ck1KYinbIkXCvSuJXMUHq69jYtcsWlHOm1T4RVaHeIEk8NPhmA3OnawG9nynACLn24AvOASEQPFPncTlr5RfedZEXTvYYovy/s8GmhIsyZmVGgbGIIrTbQyok9MyqWwbSfcizP6kZuw/Bk6XGICSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366924; c=relaxed/simple;
	bh=yxbWy/3ErCMtZ3JMbvRBdh6rwPwLL6/FsViY5uHr484=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8oiAh61CDsOzZ6RZ3TDYirKDisCbCPzP5EVvoX1OEd03MmwpoZb8V8K4c/DYpV7yjWbIwSbp47/dYSxlT051AbOCQ8oK9ay7QIqcDb/pDALDm41xI4O/xhdw3D4eW5AQmOiJsa2wR+ujw4i+A1CT8jpkSM3gyFaBWZggckQPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ52bAen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2A1C116C6;
	Mon, 13 Oct 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366923;
	bh=yxbWy/3ErCMtZ3JMbvRBdh6rwPwLL6/FsViY5uHr484=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dJ52bAenhzuKH3haVrGPE7kz7ub5SttBtBRah8NgL2Nx9vsXpoK7o15bhF6HNQFR9
	 ou+u41VHK3qZzYgSUecHeMJoYBKendD0k9H+RlIqD3AeOwG0K1KqRbOKguDTp61dX1
	 KRacBAsuMxJ6QsVXCUjfMBCjXkmxUUFs4MslemW4lVfQaS2FYJS0wVIxp1U4b7e6mL
	 TuYH51ce/DmKAztAH5UnOYx/qfbz82rGb8dt6fLXSEEWaEIFTNosJv9EJxy9dS2jQE
	 4cUvbf4CgNpFga/biOkFQ2o1hhPhNgxbFisRUjFZvVp5crzojbVgv1U8eiIBpMjeyV
	 5LLmRYrEWwtTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:06 -0400
Subject: [PATCH 08/13] vfs: make vfs_mknod break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-8-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7411; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yxbWy/3ErCMtZ3JMbvRBdh6rwPwLL6/FsViY5uHr484=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REr0vWGNO8rgb9mNU3Rko+uwg3QqAPSeO1am
 lA95loyT8mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKwAKCRAADmhBGVaC
 FbLMEACzIS7AcPJOAqSvsp9n+MAN/iYjivUwr1veW7IIUve2dlFLYmsOYgtvuTxEiNSmCRm05Wn
 yxAypWfEsQfmFjZ2PBZWQ7U4ALGRwCee2OS/dCtVY12tK9x5qWdbTbAtwioWXpXjzXphp4XfE+p
 Qotys6gbnQG7hSDrbtezIV0epkJJPqWkwqWtlVpPWn2iupADZPvtjJPDgDXNG/sTy46VzSgvWII
 pT2QHS6tBSmuO9tl9S1TmjLnAWBowkeJ1I7vu+16cpeY3hZtV/BOfNVqB4L2rJPZZuW5GL6sjQM
 HMCo20TsdTgaxqQYW9oxcxiZ09cHdV2STnycDfchIDi7BZRHukj39izoDruV8a7sZ9WSMd01qrg
 rq+Y49uNcOvKP5RFGjT1JiO221CQITcdrRhgcUmz6qXggKgL+oben/hYYv9sDUpHYFkIWNVVHHW
 /wpLI3eyXc6oT3On6+aiSRRvaa5Z4NPAx2Yd8zweT1e7lLCRVyOGo45svmsJKHKreDv3B/tJkMa
 2Q6BR/veV7E5S9Mkh9XVzXJoXeUl7KmLn975Eh/5qNBuBvsu2vFPABZu1bcrh+R3DW6elcfk/nE
 Csfn37WrE0MbgYRUGJOBw9kXWRP04kOrhhxQluA5JET3wj/g0AeHwuxAI4zmyPPSh2xTHk81881
 254PI8qqTj4azLA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode return pointer to vfs_mknod() and have the
appropriate callers wait when there is an outstanding delegation. All
other callers just set the pointer to NULL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 25 +++++++++++++++++--------
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 include/linux/fs.h       |  4 ++--
 net/unix/af_unix.c       |  2 +-
 8 files changed, 25 insertions(+), 16 deletions(-)

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
index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..acef6d921167268d4590c688894d4522016db0dd 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -565,7 +565,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
index 1427c53e13978e70adefdc572b71247536985430..2e1e3f0068a28271e07aa0fa0c7e0b04582400fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4302,13 +4302,15 @@ inline struct dentry *start_creating_user_path(
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
@@ -4319,7 +4321,8 @@ EXPORT_SYMBOL(start_creating_user_path);
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode, dev_t dev)
+	      struct dentry *dentry, umode_t mode, dev_t dev,
+	      struct inode **delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4343,6 +4346,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4402,11 +4409,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, new_decode_dev(dev));
+					  dentry, mode, new_decode_dev(dev),
+					  &delegated_inode);
 			break;
 		case S_IFIFO: case S_IFSOCK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, 0);
+					  dentry, mode, 0,
+					  &delegated_inode);
 			break;
 	}
 out2:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7d8cd2595f197be9741ee6320d43ed6651896647..858485c76b6524e965b7cbc92f67c1a4eb19e34e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1660,7 +1660,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case S_IFIFO:
 	case S_IFSOCK:
 		host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
-				     iap->ia_mode, rdev);
+				     iap->ia_mode, rdev, NULL);
 		break;
 	default:
 		printk(KERN_WARNING "nfsd: bad file type %o in nfsd_create\n",
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d215d7349489686b66bb66e939b27046f7d836f6..8b8c99e9e1a518c365cfff952d391887ec18d453 100644
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
index d8bdaf7c87502ff17775602f5391d375738b4ed8..4ad49b39441b2c9088fd01a7e0e46a6511c26d2e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2115,7 +2115,7 @@ int vfs_create(struct mnt_idmap *, struct inode *,
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct inode **);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
-              umode_t, dev_t);
+	      umode_t, dev_t, struct inode **);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
@@ -2151,7 +2151,7 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
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
2.51.0


