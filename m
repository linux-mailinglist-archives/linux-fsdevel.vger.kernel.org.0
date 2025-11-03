Return-Path: <linux-fsdevel+bounces-66786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D69C2BF3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEAF54FB9CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018F315790;
	Mon,  3 Nov 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMpPjzOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8330E0E2;
	Mon,  3 Nov 2025 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174408; cv=none; b=XS/LjPVQ4e8CL9Za66hm564zZ16ypTlCjHCyaVMrwjtSf57fl/6DHCJEaV1hDJgVJDw2NMQq1JG7NXpMFmvjp/pb4vXJ1NBtoMvfMBPb+hvMm0XDcG+gapGtE7sngzsKVvlxk30dB/048R0/nHdkNyeUXv8XF+hVv/Cwe8Omjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174408; c=relaxed/simple;
	bh=Lq/JBMu0T1h4/13uRSNeKNc8cdFPxVXxt0JHjoT6GJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXYt8rA8ZfLZ17vfoYKs5WkN1J81vfBpOuClAaYPf4kvwDcGshZZ5xvxjlOL0YWOyq1KFLaU5PA9kWWRzxHmXWfE7hyIYnfug/KcRHTbqj/ce++JaLiXxbiVSVWZyNiT9qcU1j3L/vThpLeVi67nrbvjXEjRBwWBqhyG2eFWH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMpPjzOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A448C116C6;
	Mon,  3 Nov 2025 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174408;
	bh=Lq/JBMu0T1h4/13uRSNeKNc8cdFPxVXxt0JHjoT6GJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OMpPjzODO5QzZVqkBunGNze6QHf8UIckZ1IDDAJGnhk5EEBDcv9ElTdioKsgkIlTk
	 Peb9uzn3GHYTewPXn7/lN9WAzXwql6qecAHp8HKxV11dn2xk4SdNWVAohQT0xvoSSm
	 siqU75CpKrqpeHT+USVUW7SWWPFkHBSOyBkXbBPxOKQ/oVM5CEJUwHGyTGQ4m0YhmP
	 4QGW3n2iAqn2duuAy5WrJIWE6WY8BFv+LmNL2wHxeVxeKUl7tsvzZ0XrhBgOCSVZRw
	 1sXTPaNahBYH/B84OipJV3/fRVcmFZqz/GiL+QrTnpIc3Hemu2CgvzhvxukBa6W4uu
	 36nzFs7kVVCRw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:39 -0500
Subject: [PATCH v4 11/17] vfs: make vfs_mknod break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-11-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7497; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Lq/JBMu0T1h4/13uRSNeKNc8cdFPxVXxt0JHjoT6GJA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWeAOcIMuv+JwM52+Bk5/rKW2T2lMhBOKyws
 2HtWfRG1F2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilngAKCRAADmhBGVaC
 FRreEACixXTl66tvn+CnX+Wl3fi0kIAS4S8nYRdqTF36EZJ3r9F4b1TeVKvhRQH/Yd6mv2mgyMk
 c2b38dm86dfEQjLT6h74vlVwuz3AbAb42ZFxwp5BF1oawyTyb9GFOMSONpkk85C7n8o49eTt/OR
 F4rNW+K2ayY/i7RcjnKJYypqOwjpqoSrpH0O62Fg7a1PL4k9h+f38TPD9DMDDkkOIhmrX1g5Q33
 /yQDurOMZXlWcL697sz7ROzYplMmSGVNwmHwcu3j6+NliiSTvzcdytc6axmpzxvyRIBus9uDTqi
 FbW95MioJvNokgPVJQ5SEeejefMXHlxWCBS/kR5GIaHQpiBfnUkiYdMOW83W8n3tSeFrkR6ItIY
 8DDLn9nth0oU8tVk41ZkptXvKraeAS4xAt1ZaJFd/TFhN+P78soJ4xVaAwqH2lLJf/SwOaiFO7f
 +LrhpNHju2JDkb8rtizi+GJ3JeceQmEJ3QxLijcLFiLk+wOBUuFxYA9k5rg37QTadV9Ot5/xQ4k
 UhOZxDYdCOHzX0rZlC6INrNkw2H9PauK3EZrdOSHd+vPs71D5oU1ZP+MAXgqqIUKsC8xJaaM2ln
 stYmPzmUfvfVF4YX19605+J09jiH0kjanhKKzOB7+VnkjticCp4klQNywjNqV+2tq1l7sqJttzx
 ytRGc2qBCQDj9Rw==
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
index 51accd166dbf515eb5221b6a39b204622a6b0f7c..42d00f5080b8c52622a5e57bd70a5659504da46e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -570,7 +570,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
index e8973000a312fb05ebb63a0d9bd83b9a5f8f805d..8851f0870f63ba1d3789300dbacc8b9cce534900 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4294,13 +4294,15 @@ inline struct dentry *start_creating_user_path(
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
@@ -4311,7 +4313,8 @@ EXPORT_SYMBOL(start_creating_user_path);
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode, dev_t dev)
+	      struct dentry *dentry, umode_t mode, dev_t dev,
+	      struct delegated_inode *delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4335,6 +4338,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4400,11 +4407,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
index e4ed1952f02c0a66c64528e59453cc9b2352c18f..ce8c653f7a4edab81a7f1b231a4ae77dc82c073a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1579,7 +1579,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case S_IFIFO:
 	case S_IFSOCK:
 		host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
-				     iap->ia_mode, rdev);
+				     iap->ia_mode, rdev, NULL);
 		break;
 	default:
 		printk(KERN_WARNING "nfsd: bad file type %o in nfsd_create\n",
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 5fa939ac842ed04df8f0088233f4cba4ac703c05..958531448cb85aeb3bfa174e9dbf25469384b53f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -262,7 +262,7 @@ static inline int ovl_do_mknod(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev)
 {
-	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev);
+	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev, NULL);
 
 	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cfcb20a7c4ce4b6dcec98b3eccbdb5ec8bab6fa9..47031dbb0b026c0b59661719df551979717907a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2125,7 +2125,7 @@ int vfs_create(struct createdata *);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
-              umode_t, dev_t);
+	      umode_t, dev_t, struct delegated_inode *);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
@@ -2161,7 +2161,7 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
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


