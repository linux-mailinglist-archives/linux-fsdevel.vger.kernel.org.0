Return-Path: <linux-fsdevel+bounces-64950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03ABF7606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECE3547E42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB123491D5;
	Tue, 21 Oct 2025 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYh2M77J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9243491C5;
	Tue, 21 Oct 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060386; cv=none; b=umBYxKInIwMuMkLnWMphDrMjvrPNCCKST78/zVJxcN6lcyxa6JjZ0rHk7dyeY03nzZlF72nP+8bkTjqee7SQe+xc7FgK1pW3sdAwnV8VOC7W4cK/SDxSEpxNfJVbsEIP+4mV959ZrhrnWpnY4QETG5Q1ovHe3Ri27YxVr0gfbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060386; c=relaxed/simple;
	bh=yTgOStwUbcuSXR0JicjTG44hgRhCgvUguUODuPzyJCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daflsns4ki+RXqTGt66QyoILjBK6JBSSvquuH2fDyMAS8qJNua0JyBZYNH/kZ4VT1i+mrfrvNMxsJXkD6H1YhbcJ27AixotUh8Cv2+YeEN4H5oIXRWmxKaHYrbFkJcjVlC332j+nFtS4KhZRNf1EF96vy8Tpz+iQuArXBhuvy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYh2M77J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D427EC116C6;
	Tue, 21 Oct 2025 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060386;
	bh=yTgOStwUbcuSXR0JicjTG44hgRhCgvUguUODuPzyJCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pYh2M77Jjbnc2s1mAU2dIv8Nudl10TuxUjc2JAti1QOwQ05bynxKrqzZQ60f29eIv
	 UnA7n1TNv3u8AC6xbEL7pRZxfdJo0tr108Ew3kaoa9n28KQK5+oxyy3EQFOQy0l4oz
	 8PcBvvztrsZka4guq9xcgco7DX4+5L8DvXuRBuxBUeKSI0ZlOMHDh/6bDwQAmWkN7v
	 jaR58hz3c2X1Ck074XBD67gDYyUpC03MB2y++1Sbx4s/pceAAQlWh1Z1ozx3uZ+BWk
	 MgNbNA8Ma9T3NKAVB5lGKPH+5rRmz2A3SIEjfhFpSE8DH85YOWBrPjGA8GvCj/gupi
	 JPbb8emYZlX6A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:42 -0400
Subject: [PATCH v3 07/13] vfs: make vfs_mknod break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-7-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7491; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yTgOStwUbcuSXR0JicjTG44hgRhCgvUguUODuPzyJCs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YFAnlIJo/MYWe+AjYeieNWpSrK5vYSrf8gc
 L/7l9jJA9eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBQAKCRAADmhBGVaC
 FZ1sD/sE+YFbP/tRPvSHthcvwkoRmY3I1Z/bgs1aPEYJS3iP7coQDSlUsvE1zDwSzRD0+nEXnC3
 pcrRClpBKv74Z4sNPkfcuzl/x9v70N6TbDCPF2aBAmQYjeMbY4v4qFRX9tZno6oUHwhYpEkZNsG
 9ZsI4O5QOtt+l9HGXXyQ0OGZqh0gtXgnME2KdilXFEJ38M6i0vFO4wwjpQKzcWxKIs+r1NRuHwW
 TPp4BU5I2a5iApTZa6aVMNV+wiDeDkBq3wdTCVrp1kyGmI89Z6DN9qvC4qIoe+qvZYa4SLJBiJg
 4iuIdFfQgTSlMZAk3nQEpoRa5wXgjoLF+4VwFEbIVEvCbbX7qyiL/hVvmL2WNVo9IZmWYCCfn98
 pT446X7BCtPkjsX/B6RrTuilCH5n8dkfBS8yKk5v7pN8H5D/yE+VBy+GiazuhIh5zqklPSXKg/H
 B4DPbHRHO1wViqXHRr9IcyQ5ojnNutbgzULjo6mbKGP0Fg3UCzB+jXQ77VY2cOKSlwLaHMnLWeJ
 8cUMOIzBPsqBNgPhhAKxb290ek80aqjZy7CEsroza17U0nwk7UdGYHSJD0yQ37idtwcV6Whh/C8
 kA7sXf7AeMcy28lgjRDpoIKuxQv57nX9NuckwqDVU1+UJWuu1JA0afjFdNoFmPBrMnDbD6z0GWj
 f/jpSyHBXFNgQiA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode return pointer to vfs_mknod() and have the
appropriate callers wait when there is an outstanding delegation. All
other callers just set the pointer to NULL.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
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
index 661709b157ce854c3bfdfdb13f7c10435fad9756..639ae42bcd56890d04592f7269e4ffc099b44f09 100644
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
index 7510942e0249de19df4363b92f813b3acdfc2254..7e400cbdbc6af1c72eb684f051d0571e944a27d7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4297,13 +4297,15 @@ inline struct dentry *start_creating_user_path(
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
@@ -4314,7 +4316,8 @@ EXPORT_SYMBOL(start_creating_user_path);
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode, dev_t dev)
+	      struct dentry *dentry, umode_t mode, dev_t dev,
+	      struct inode **delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4338,6 +4341,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4397,11 +4404,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
index 7eaae44467188fab0909fabec986e103bcd52457..44debf3d0be450ddc245e2fa4f57fe076e1454a2 100644
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
index d3123f5d97e86b58e4c9608cf6ef2abd1fcddbcd..87b82dada7ec1b8429299c68078cda24176c5607 100644
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
index 5fcf64d9cf42ce135c0fbcbf6dfbf8816ae0bcb1..a1e1afe39e01a46bf0a81e241b92690947402851 100644
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


