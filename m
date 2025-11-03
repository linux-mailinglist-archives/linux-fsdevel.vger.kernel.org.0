Return-Path: <linux-fsdevel+bounces-66787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63181C2BF02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE73B8F35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007CE316184;
	Mon,  3 Nov 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piHP4CCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AE315D38;
	Mon,  3 Nov 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174413; cv=none; b=VyhVQ7y96TZ6yxGF2hW2Z2ZW1EG30ikdw6h7jH7LTaOZ8pcIYaqO8txMqlCDQXpA69hItqPKUKtUlfID3/DFGVKE1ivuEegt1FOoOuBU03GCC9Jf/i3vMRFt6iGr53s8O40MiZtroI5yFqz4Vm+7ryLkWd6/m78BQnu85048+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174413; c=relaxed/simple;
	bh=D5V0UFm+9OUK4y+/EaRKtu56Yc3CDLhLRHYFSz9Ys84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FksU7U7rdGl1+aRlIthUdkVI3hSAtoUp5ah1qtHSIryHNGFwIcSZ7dKVQgakaqMcPg97SKTL0d0oFPafE1ZXwEivYsELOxJ82UBiz0KMmwr3KpORhvK8/s0z8JfR+U5V9eMFi+k5ss6MgaMqVNGVSoeEB/9J3QI5LmL1a/DVNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piHP4CCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD205C16AAE;
	Mon,  3 Nov 2025 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174411;
	bh=D5V0UFm+9OUK4y+/EaRKtu56Yc3CDLhLRHYFSz9Ys84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=piHP4CCM5hB9QLZP0faziwV56bKDvC1DxsiEoOuVCRsdhjVE8Q9/zQBTCYn3xZmMW
	 WFE0hBn+6ciWLEc4Ya9HpTnI/jOB58HtuarleVd5y/GEPa4xygwrDOEjX08h5er5hT
	 UaKvV3mYqMtxtaIvqyQQV8MngdH41aLlYZQZtP7HEtpFPsCoa0g0TG8GHMNWsYzoYM
	 3DTqtBK2f/Mw5qb7YO8Gv7Yms5AHN46jNvefawhcipWSzL6ChHSFjhRfOD/eBAq/Fg
	 bcY6DAxmrpiDn1QbpZdNCEBvfOCOtli5UM3irMh5fVCq3so24Apdpy1An8gJ6EKz5I
	 t3D9k4lQ2rDkQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:40 -0500
Subject: [PATCH v4 12/17] vfs: make vfs_symlink break delegations on parent
 dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-12-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5708; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D5V0UFm+9OUK4y+/EaRKtu56Yc3CDLhLRHYFSz9Ys84=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWe25kDvzIUFEMcI8PZW6lHavHlY3cQCfQDV
 S7u3UR6x2KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilngAKCRAADmhBGVaC
 FQr5D/9/bWoDn1lQiat35yZ2f6ohat3fC7JS/FnJI63iLRx8/cHR2mF0vj82fi6a1FBb/PeFMpM
 R82Ng7od8if9kPRhieD+muVBIu3fYQQxCCrFNY4Ohv78lVE2s+hj8AklaC5WtBuk1cN8IfP3WMU
 Wqtlo+XQK8Vi9qgXw36VVS5+p5OkhHcs/lZMd6mpnb/psZHy3wRpnN+JT0mmrzXx3LSSVVYzspF
 9xzeR6J1BnwNpJ7yIdnD+9txMstScfPfwJk+WhffFcIF2K82Er1GlZnSlEel0Q0uXC0P6KkDiUH
 7schL4zRpwE9Hyn2xLGNiFSNDkwjDiAvwZeYZS+up+2UCiHANncOSLGCbf2gsSJ/kZQ7LRPEBzT
 G/wHv6kF1xeOmz+dY6F+ji7C5lRLzQH3188IbHqrTHBOmw5jeC5xRepk8mteeTRPlWxSMLAqg/Q
 qv/xLej717aYVmn7vztG7UrICLSK+A5IqiE302B/qYEblCgpYcnxXTIad30aUPB6wXgObamTs48
 qIQ1a9t/knkUsdfL3TUfeYwOkB137fuU3FijP+9ebY5/qj0/Oy+Dwpch7kHwJ7GwnRE6aEazVGD
 vAHIu+QxEQg17M3Dj/oqMJZsGmZD0PWcqfOXAgxBxDq3nukjNDuJceZZ+mc7uTnUAWP99ZuSoq1
 ZjpxIKB9TSnusRg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we must break delegations
on the parent on any change to the directory.

Add a delegated_inode parameter to vfs_symlink() and have it break the
delegation. do_symlinkat() can then wait on the delegation break before
proceeding.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 16 ++++++++++++++--
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 include/linux/fs.h       |  2 +-
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 42d00f5080b8c52622a5e57bd70a5659504da46e..c52bd187f21437fa1a0deb8f3dcd60c8930154ef 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -485,7 +485,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	if (rc)
 		goto out_lock;
 	rc = vfs_symlink(&nop_mnt_idmap, lower_dir, lower_dentry,
-			 encoded_symname);
+			 encoded_symname, NULL);
 	kfree(encoded_symname);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out_lock;
diff --git a/fs/init.c b/fs/init.c
index 4f02260dd65b0dfcbfbf5812d2ec6a33444a3b1f..e0f5429c0a49d046bd3f231a260954ed0f90ef44 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -209,7 +209,7 @@ int __init init_symlink(const char *oldname, const char *newname)
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
-				    dentry, oldname);
+				    dentry, oldname, NULL);
 	end_creating_path(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 8851f0870f63ba1d3789300dbacc8b9cce534900..7071cdbfc587c108ebd777746f736d854feb68e7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4854,6 +4854,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * @dir:	inode of the parent directory
  * @dentry:	dentry of the child symlink file
  * @oldname:	name of the file to link to
+ * @delegated_inode: returns victim inode, if the inode is delegated.
  *
  * Create a symlink.
  *
@@ -4864,7 +4865,8 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, const char *oldname)
+		struct dentry *dentry, const char *oldname,
+		struct delegated_inode *delegated_inode)
 {
 	int error;
 
@@ -4879,6 +4881,10 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4892,6 +4898,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags = 0;
+	struct delegated_inode delegated_inode = { };
 
 	if (IS_ERR(from)) {
 		error = PTR_ERR(from);
@@ -4906,8 +4913,13 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	error = security_path_symlink(&path, dentry, from->name);
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
-				    dentry, from->name);
+				    dentry, from->name, &delegated_inode);
 	end_creating_path(&path, dentry);
+	if (is_delegated(&delegated_inode)) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ce8c653f7a4edab81a7f1b231a4ae77dc82c073a..edcc8c05e435a4abba27dd2eb07facf4b5ed3243 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1748,7 +1748,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
-	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path);
+	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path, NULL);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 958531448cb85aeb3bfa174e9dbf25469384b53f..3e4774a979976c65f2984bbc212bd403e440644e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -272,7 +272,7 @@ static inline int ovl_do_symlink(struct ovl_fs *ofs,
 				 struct inode *dir, struct dentry *dentry,
 				 const char *oldname)
 {
-	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname);
+	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname, NULL);
 
 	pr_debug("symlink(\"%s\", %pd2) = %i\n", oldname, dentry, err);
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 47031dbb0b026c0b59661719df551979717907a5..8cd1804a2c3dcfa0153b1bc1c0250f5a989c857c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2127,7 +2127,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 	      umode_t, dev_t, struct delegated_inode *);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
-		struct dentry *, const char *);
+		struct dentry *, const char *, struct delegated_inode *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct delegated_inode *);
 int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.1


