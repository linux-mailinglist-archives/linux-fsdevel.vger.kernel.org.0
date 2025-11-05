Return-Path: <linux-fsdevel+bounces-67165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB86C36E85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B39A500B67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6140633B6D6;
	Wed,  5 Nov 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1yuvNPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD734404B;
	Wed,  5 Nov 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361673; cv=none; b=jVtLlR4KpMtD08ZKtkuimCuH9jgcnu9eOIsuKXESKjJbYL0uB9HaQoXTEqPvViwaerqDJtq/fWmKHe8tv5XSGLqYmjI4u71iIbCFErc+haMa2uihdXJgdk8YCVuwHHHoMm1bj0qG1tK5XrcAI7ZoRpIG5QeXH2gGIhnUxDTMYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361673; c=relaxed/simple;
	bh=nVt7zfcxkLtFpIV/AjQcJVwofL/t6x0LVRGY+VtgUx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4lI6sczMp4fbeK2gT30oh6HvQusX0v4eWWGd6h6dCYfmdq7aMWl4EwyRo9PDFPiE4bRwblrSZKaKKaeZPn4Ps8J2j2OLDyJAxTKIKwgPiefz+1n0QBAa+uFCbxgph6EMm6Xzo5V2kghoynE+3YwasMXUI7+ix6eT8qfYUjLuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1yuvNPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1FAC116C6;
	Wed,  5 Nov 2025 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361673;
	bh=nVt7zfcxkLtFpIV/AjQcJVwofL/t6x0LVRGY+VtgUx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T1yuvNPhetJCADnWOKxP2SxMDylyBlzZFXbDiRWDJsWQ6HZaVPD3h47hWMJ3z9Br6
	 0wnjjCzesrB2Apehde8xCZ6FT3tRF52UrAjV0iBhv98BLq5eOhxLX0yBPKQ3Nysyr4
	 yXxhGmf74zVAcSnb7/aN2g95ZFIcwWS/ouP7uPfaPNSDgwYCfxSc8cBD+K44Wvu02q
	 zc1fLFB5whPDXAd8HAbNAzmjzMXv2ReKzfpt4PJcOuHRBOIUShyyuqyPtum8W6CLRj
	 XtcC88YeBytxsXR9IEqQ5C3ZYavf74mkHi4UrLDInxv0kO8rXHJrWr05a0rH+Flkxe
	 GjK38XC8gmPNQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:53 -0500
Subject: [PATCH v5 07/17] vfs: allow rmdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-7-7ebc168a88ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7777; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nVt7zfcxkLtFpIV/AjQcJVwofL/t6x0LVRGY+VtgUx0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4Er/oilxewvUaJv+DVl82MHZmHENJoYL2app
 G2kbBu4Y5yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBKwAKCRAADmhBGVaC
 FX41D/42+M+KQCSzsaid1QETi47k3GYB6A4R+TZRNjsT2zyfVUMs8ycwyC+Ag/AWoTrN1egwZrc
 osw8ipGpljH3Gn1Y4gWXeFRrLnHf+Vk+gCPc+Cl3ml9s7/JQ5tZMbSnQWAw8k2fiBo28Wp7Wy61
 Eq5gtJyDr/yrrYtDM+TJJyN+6ZX3Jtp8+wCsf2kf1XAyC4sjJ+rVWJVAU597Fb/gSCNxj7yIMVQ
 hXYmVWMqyUN2sB7e069DfCLDA1gg5otSk0tsGGz9zZ9p3ORZLfReeb5ZgZWQnEqdIcofKux8BEs
 oc5V/9OsRkEQ8PvIoaBtc8sKO5ZSXP++d8OazGl/CforQ7TXX+aZma9L7jf2GDxXlxqrXYj1S1f
 2AxOfoy2rWufgxCj4Dp3JJ4TYSKnR3sQkkT/LkMkMUnH5vw2fWlRjeAkQRjjt2YTmMCCmzDj6/C
 1W+bma6dHgWZmvttlbWi59g2RtPplYVQnHKD7/Y0f6FknnLu+mYlQnSGlLZhukbkoSrBPNwbr1d
 Vu9XoRePWjyTV71LFquiSdW3zUbvAZUu69RQvUPMdUVBsyF9UhWX8+Eai3LCbJ53WYC7lTT9tbw
 gk36bvS0ygNs9BBA2NWdEobtyo65qsXN6zp5U4gKVhxrBZXbw+hw/x04mDafqGJQgLXdQQu1tl/
 S7jdAOhls+IvOXw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode struct to vfs_rmdir() and populate that
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
index 76c0587d991ff7307e3dde69497719d716c8d7b8..9e0393a92091ac522b5324fcdad8c5592a948e8d 100644
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
+	      struct dentry *dentry, struct delegated_inode *delegated_inode)
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
+	struct delegated_inode delegated_inode = { };
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
+	if (is_delegated(&delegated_inode)) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 1f56834b2072fcee1d0d400bbb554b0c949ecab4..30bae93931d9c9f8900dfcf96f79403db4f3f458 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -337,7 +337,7 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
 out:
 	dput(dentry);
 out_unlock:
@@ -427,7 +427,7 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child, NULL);
 	if (status)
 		printk("failed to remove client recovery directory %pd\n",
 				child);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 97aef140cbf5fca4c41738fdcaccba3b57886463..c400ea94ff2e837fd59719bf2c4b79ef1d064743 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2108,7 +2108,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
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
index 20bb4c8a4e8e1be7e11047d228c05920ea6c388d..12873214e1c7811735ea5d2dee3d57e2a5604d8f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2121,7 +2121,8 @@ int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct delegated_inode *);
-int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
+int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,
+	      struct delegated_inode *);
 int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 	       struct delegated_inode *);
 

-- 
2.51.1


