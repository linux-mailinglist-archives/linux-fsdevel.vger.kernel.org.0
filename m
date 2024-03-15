Return-Path: <linux-fsdevel+bounces-14493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62B87D1B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309A71C20973
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EFA55798;
	Fri, 15 Mar 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ode0hfFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6054910;
	Fri, 15 Mar 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521603; cv=none; b=dRK7DH+NSso+NTORJZqEFSXRoXm/wBiiNrZn9a+VpIno0YtvITrqnpT9oEZ7iKBYyCo6hXUw7k5N/Nubq+dwGOQS38ih+fnDYZdEfhOtbv7XoOeUyOJpFClm4KSmkpha+PloQYMEHVzDxrKMtSBYXJJ8dJv84OA+qH5yd7O7gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521603; c=relaxed/simple;
	bh=4Hh6J09N40Wh6o7Y7XvcqF+EG8cxj/8qFYbo024OMkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtFK1KUu+wsCOpUBimT7F48cu1xhiHOVDXV5HNdetKVJWALxr96IaNlFcxCq2uG3DmTJOdbxK1+VLl08vHqs1jRJK4xP2fP1AHPHAGHO23gc265pTgc95638DrSl4Q/Oa4VfHhu282jnGOgs67sEoJwO6xj8bl1kM8uQ2fJsgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ode0hfFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1351DC43609;
	Fri, 15 Mar 2024 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521603;
	bh=4Hh6J09N40Wh6o7Y7XvcqF+EG8cxj/8qFYbo024OMkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ode0hfFu6Gg9RHfhivzCeASVGZsOe/RdUmf1C493jkcyVJGUDp0hzALLCup4zs3tx
	 hWWSZOheFCmuPgxgTJ1sb9DU5YfYfL6GOi7Ywr0tH3M+03imNCNwBPkbzO5mujObcP
	 21HALFvYvdm1eusUYjhfR+V8Tp9r6DgU3Z14qYk9XNiLxZJhV6T5/a2f6+/4oMrD62
	 rljvNgtBN4p9w4n/bXLKF/eD66NIGAya0zP3I5WKhVoEZ6+MtjEJ1UpvOb23avBTM2
	 /Xqri7PfTXUZZIl6teaGZpK1sB0tfrtGk7ItxbkkmdUvCMkt0l15ivwfxrYUQ9+AuA
	 3jTo44hNLi4xw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:56 -0400
Subject: [PATCH RFC 05/24] vfs: allow rmdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-5-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7032; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4Hh6J09N40Wh6o7Y7XvcqF+EG8cxj/8qFYbo024OMkU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzt9k6/585HV65ukYqnWWqAbMCrWWWQNmCTg
 kTMzxFXcRiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FUIKD/9z8JZIU07s513G0XxxneuCrd9u7hEEB1Mib4EnmqFq5ThTbEwUs5mCIte9khpQ/5NArX/
 3wzTpaF7+Om8T074fwYQaVKp0YsOP5BtipNh71epmC0lE7WjJHhcDoRt1sJtd7inaWWKXr0TmoD
 8x28NBfcvENlifSpkvC6PVPRCMRZZbmCAh5XhVSE7CcfEFJunhNywWO/QKoDxibi2guxymBnLHk
 Ra4Mv6zj1IhqAORmYpc36R5/hp2qxCzsgp3b3XzzPXKFO8YMjZecAbB/+PvbbNR0SuaOx+kcEYz
 ylqsJq4lhL9wULmtcXGSREKC7P1mJzyZGyYBU6LeBSFjVgXWOG6K3ert+g0teM7CABspgJVy9le
 VfDF+seu6N2LLDd+sAUwH+7VpOxsx/DQOPuHY5WYZ/vrZpXlDAkObTVCVITW6hmd/cOzNs+Ksi8
 VhYfjl8Vk+NHHQ5ijsnmloBGNy8KPUq73ZZTcjXqbz+fKAG/7fto81A7xt1uYrahVywY/Bp17m6
 jmCNMf0N1KRcOvU6I/q/pvQ4PKGxMIvMj1rODVeyWauRMJbonrWX9Or6f13QDO6F35zIF/4NEIW
 wlFzRF5hF9Z6/a6/cvvX9Nkx1pzVqzicrkynMwudYWJ7Lxgjmq+xwIhaFoQ/F2URj2vdcIn/9g9
 dvaoqH0SMWfYEZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode parameter to vfs_rmdir. Most callers will set
that to NULL, but do_rmdir can use that to wait for the delegation
break to complete and then retry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/namei.c               | 16 ++++++++++++++--
 fs/nfsd/nfs4recover.c    |  4 ++--
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  4 ++--
 include/linux/fs.h       |  3 ++-
 8 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 8d1dbcad69f7..c00126796f79 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -248,7 +248,7 @@ static int dev_rmdir(const char *name)
 	if (d_really_is_positive(dentry)) {
 		if (d_inode(dentry)->i_private == &thread)
 			err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
-					dentry);
+					dentry, NULL);
 		else
 			err = -EPERM;
 	} else {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d26b4484fa60..3d0cddbf037c 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -541,7 +541,7 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 		if (d_unhashed(lower_dentry))
 			rc = -EINVAL;
 		else
-			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
+			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
 	}
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
diff --git a/fs/namei.c b/fs/namei.c
index 6a22517f9938..f00d8d708001 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4183,6 +4183,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
  * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of @dentry
  * @dentry:	pointer to dentry of the base directory
+ * @delegated_inode: return pointer for delegated inode
  *
  * Remove a directory.
  *
@@ -4193,7 +4194,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry)
+		     struct dentry *dentry, struct inode **delegated_inode)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
 
@@ -4215,6 +4216,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto out;
+
 	error = dir->i_op->rmdir(dir, dentry);
 	if (error)
 		goto out;
@@ -4241,6 +4246,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4274,7 +4280,8 @@ int do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
-	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
+	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+			  dentry, &delegated_inode);
 exit4:
 	dput(dentry);
 exit3:
@@ -4282,6 +4289,11 @@ int do_rmdir(int dfd, struct filename *name)
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
index 5bfced783a70..0e82f79471cf 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -354,7 +354,7 @@ nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
 out:
 	dput(dentry);
 out_unlock:
@@ -444,7 +444,7 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child, NULL);
 	if (status)
 		printk("failed to remove client recovery directory %pd\n",
 				child);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e42e58825590..34cc2d1a4944 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2003,7 +2003,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 				break;
 		}
 	} else {
-		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry);
+		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry, NULL);
 	}
 	fh_fill_post_attrs(fhp);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index baa371947f86..5b1f56294c4d 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -203,7 +203,7 @@ static inline int ovl_do_notify_change(struct ovl_fs *ofs,
 static inline int ovl_do_rmdir(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry);
+	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry, NULL);
 
 	pr_debug("rmdir(%pd2) = %i\n", dentry, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 3760e0dda349..5b4e5876c2ac 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -611,7 +611,7 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 
 	idmap = mnt_idmap(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
-		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
+		err = vfs_rmdir(idmap, d_inode(parent), path->dentry, NULL);
 		if (err && err != -ENOTEMPTY)
 			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
 	} else {
@@ -1084,7 +1084,7 @@ int ksmbd_vfs_unlink(struct file *filp)
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
-		err = vfs_rmdir(idmap, d_inode(dir), dentry);
+		err = vfs_rmdir(idmap, d_inode(dir), dentry, NULL);
 	else
 		err = vfs_unlink(idmap, d_inode(dir), dentry, NULL);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 18eb7d628290..e72c825476de 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1846,7 +1846,8 @@ int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct inode **);
-int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
+int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,
+	       struct inode **);
 int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 	       struct inode **);
 

-- 
2.44.0


