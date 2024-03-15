Return-Path: <linux-fsdevel+bounces-14496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D910F87D1CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D941F21605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598459B4E;
	Fri, 15 Mar 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpMNJ5yK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544158ADE;
	Fri, 15 Mar 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521613; cv=none; b=IDIlACKw6WAtC6Hsvg0SzoopB3/ibHScn4ZlgLA4Tz4F3oeVZP/M2NjSxJpZCA9D6R5IrsJQc+f7CJweLNTi8Id7k0jV9566JVuCOQsgEac7iFp7BgK8qK6jJ/KVti77ECRgbomJdMhG8SlpeCM9R8DHnzhTJrxcNvnOTU3OeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521613; c=relaxed/simple;
	bh=A/Nofv6jvEBl49XHLBGXua/1eUYdkgzdVhY0jmU9xq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ospHGYvza96F3RgXGQ7nIjwS4O1+8a/r/uqMWttEuAtG7y/z5/HjVeV0sbEEPz2wpxaMvyj+LjxPuZCOqycOQdI7iiT+xc+F/ES4XUovv8qfZU8pLCQpsYXOhr4wL/nfTQ8KYIjHJAltr10MTM7DZNFtHZQ+osLv+kG3qgsFjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpMNJ5yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FCC43394;
	Fri, 15 Mar 2024 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521612;
	bh=A/Nofv6jvEBl49XHLBGXua/1eUYdkgzdVhY0jmU9xq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WpMNJ5yKdtUExT0NtExNsSwOKpWxCFORz1Imkn5kgGGbjKKD3XGQYJ0Ix6ASoSFvy
	 WXMMUBQ8HTJQYQ1NWdwvhOVFCRLcvJ4ZDBJCyuSD7TMtHiR192VydhyO2lwBQxUGSa
	 V0epqfbYNwwKTzy260g3iGFNO72njDi1iGn61+9MYUHrKsQaa8XwvsTUCsLQlJSXNl
	 ML9XyHxoBLSqS9LmLI/3n6+OoSgEHd6Cl0tZK0010ayaKiX0/qV7wfs8EDXjqi5PNd
	 D6yPJG3LXFVm08JM7uW1P2WkuG/SdkkdPHqMdEKOawaIW4X5wZbB/A1wji0rsG5SCu
	 oUSTZKzTmdMVg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:59 -0400
Subject: [PATCH RFC 08/24] vfs: make vfs_mknod break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-8-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6152; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=A/Nofv6jvEBl49XHLBGXua/1eUYdkgzdVhY0jmU9xq8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzt6FbvM1BM7CP4UXM+6W1njDcNK0c5kl7c6
 XmwmbqwbiiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FQ4AEACThSeI6+TIG1kW9UqOnWQeo3HAg9T3swR2ryWmmPBYfMC8YOjGUQ4zalxhyC7ulplluuu
 WY58OEjlFnlRH9+584tktokXhQU9ZQ9yx5hUlpKbeBWOO6N6LPAMyIUGD5VT79riv7OCVvgr7Re
 rYdSgfmDFGZl3dcWf0D+9K2MZmOCHDnvaCLb+1vC3GscGfc+IcgXvEqY2AyWHruVn/TpalthhjF
 Jt8PjRCjf18/hHEm7Jr3eXwA7FcaC2bvWWt6zp3H/guan5GwtvT447i6UlxTWsTeNF3/Slx3qq4
 jNwLWpZGjM21C8LHY6+3t7Yo3dYTUpg6l5w8fg9DAQreFJUXhVEpG0SRWfYEdU/7ZJ09qqWX0eP
 bk25vEDF+cEyz1TCgSD+10anAXfwzhoMnRslPoJw6s0VLOOIrAbhvsQygDGrguVx7TrLdnUIOqK
 3xLy9Eda5ZkMhGDX7FWngE69fsNfgLROAgoZ0I3pIjvpjkmMID0+0xry/wmcESz3714Oa2zGSN0
 3K1SO6fWsSfRBXcOrtS8wQ0BqKsYvCzFw5sMT0NyIQBYMGWMuNsUq4CyAmkJWCMHGyMv6V430z5
 4fHiE92XenLjSwKTzv8qpXwgnvNwzQgZ+j0iOpijB4S06LhjY91QG5/+ipENUaumU7VEarDukQk
 OJsNC2Ncebk4E6Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode parameter to vfs_mknod. Most callers will
set that to NULL, but do_mknodat can use that to synchronously wait
for the delegation break to complete.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 11 ++++++++---
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 include/linux/fs.h       |  4 ++--
 net/unix/af_unix.c       |  2 +-
 8 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c00126796f79..8c0a872e3165 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -217,7 +217,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 		return PTR_ERR(dentry);
 
 	err = vfs_mknod(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode,
-			dev->devt);
+			dev->devt, NULL);
 	if (!err) {
 		struct iattr newattrs;
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index a99b1e264c46..c6442b8caa2f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -566,7 +566,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	if (!rc)
 		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode, dev);
+			       lower_dentry, mode, dev, NULL);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
diff --git a/fs/init.c b/fs/init.c
index 325c9e4d9b20..99c6b413adad 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -157,7 +157,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
 		error = vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode, new_decode_dev(dev));
+				  dentry, mode, new_decode_dev(dev), NULL);
 	done_path_create(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 01e04cf155eb..a185974c1a55 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3996,7 +3996,8 @@ EXPORT_SYMBOL(user_path_create);
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode, dev_t dev)
+	      struct dentry *dentry, umode_t mode, dev_t dev,
+	      struct inode **delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4020,6 +4021,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4078,11 +4083,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, new_decode_dev(dev));
+					  dentry, mode, new_decode_dev(dev), &delegated_inode);
 			break;
 		case S_IFIFO: case S_IFSOCK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, 0);
+					  dentry, mode, 0, &delegated_inode);
 			break;
 	}
 out2:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 47b8ab1d4b17..fe088e7c49c8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1525,7 +1525,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case S_IFIFO:
 	case S_IFSOCK:
 		host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
-				     iap->ia_mode, rdev);
+				     iap->ia_mode, rdev, NULL);
 		break;
 	default:
 		printk(KERN_WARNING "nfsd: bad file type %o in nfsd_create\n",
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index be2518e6da95..26cdef6c3579 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -251,7 +251,7 @@ static inline int ovl_do_mknod(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev)
 {
-	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev);
+	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev, NULL);
 
 	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8fb4101fea49..4b396c9a7a84 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1841,7 +1841,7 @@ int vfs_create(struct mnt_idmap *, struct inode *,
 int vfs_mkdir(struct mnt_idmap *, struct inode *,
 	      struct dentry *, umode_t, struct inode **);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
-              umode_t, dev_t);
+              umode_t, dev_t, struct inode **);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
@@ -1879,7 +1879,7 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
 			       struct inode *dir, struct dentry *dentry)
 {
 	return vfs_mknod(idmap, dir, dentry, S_IFCHR | WHITEOUT_MODE,
-			 WHITEOUT_DEV);
+			 WHITEOUT_DEV, NULL);
 }
 
 struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0748e7ea5210..34fbcc90c984 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1227,7 +1227,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	idmap = mnt_idmap(parent.mnt);
 	err = security_path_mknod(&parent, dentry, mode, 0);
 	if (!err)
-		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0);
+		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0, NULL);
 	if (err)
 		goto out_path;
 	err = mutex_lock_interruptible(&u->bindlock);

-- 
2.44.0


