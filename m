Return-Path: <linux-fsdevel+bounces-50335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6FACB076
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22623A97FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88605228CB2;
	Mon,  2 Jun 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8n5BTMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF1227EB9;
	Mon,  2 Jun 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872953; cv=none; b=D2ecVe82rShgF033BAU48eRMcjq3Owwkz80Rw3OYBXOpB6BMmIdUJ/5R8ogE7NcfcPIcPdYxP9CKjKmDLr4jDUsnt4mt71qHiuNiz+L0UTp74Mu4cyBZewIMvTWhy/TUvuQxSdSXmUI1gEWZG4dOohjA06atEl5/uWa2MS6lhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872953; c=relaxed/simple;
	bh=hq54trMBQfOBExEaJCPkyc60i4ZI5QVe6/7T7Saw+Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uERW9Go+vzWGHytOYXvI2igNc935+9a3hnOIBY5pfxVRjJMnCkNbOhllze5dy2nOyNeaIu8lIHENvu7opE5iMQk3j95OT5bPgTOnT8aXkRLtOsmLMbcyfjYuKGCFbvEyrMxqMDODcRMZtt1pHXWu/tCa+F7/uDAvpR72K/Y4DeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8n5BTMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D52C4CEF5;
	Mon,  2 Jun 2025 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872952;
	bh=hq54trMBQfOBExEaJCPkyc60i4ZI5QVe6/7T7Saw+Bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e8n5BTMWqm9rH+yOhZheCg6a1BBv02LOeszJqMwoYB7fD9zcElbTKKUN+knAl6VGP
	 sJ1jzvjljWnVAAEg9/FjLY1voQy7MJzt9uX/yDajbUwD9xY1+llsiUg/e6SsbhSKrL
	 nz1OmAkuAdXi1042hft8BtTDPzok2Qb6acU6NGU0lmmApw9h/EKGXIxaOOpsCdBuTb
	 S+8YwGJwWJzt4o3ijWGx0p6Ngu8/x4vATNwh65BKU7Ak5l/sHvR2w+xOiSiP/CbtlJ
	 wyvovlNW5q23lrXZNi1Pea4ohv0Pi23n2qEKIQL/Ivs+PMw7PfZ6I9Rbte5q57Bl+E
	 GbbAF84wgIMhg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:48 -0400
Subject: [PATCH RFC v2 05/28] vfs: allow rmdir to wait for delegation break
 on parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-5-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hq54trMBQfOBExEaJCPkyc60i4ZI5QVe6/7T7Saw+Bw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7lWGnbULXucj0fCehfGYQ3sLRbedLR7Sm1Q
 GjuO3AFDqeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5QAKCRAADmhBGVaC
 FXNMD/9jRqeOyIiQhocqTsdyPQa1pLi521eSfX5vDTVGnF0pQGHmyz1UAra13z/vYzBEwZnL0U3
 K/XUDmz8tmqV5fUc8qXqLKNjXoFNhW+pGkFNNX08FkYcNSAfdDRk293Yd2V8SIr3dO1zTlJcmJM
 ukPiMpFIl/0GssxnwShZclq6z7vnS9Tb/oW1JIPlVHPvLdpG8eNFZr6KHoYI1BKrXSN0u4U59q6
 lVsUNeYNWnpVtYdMBSMzGZrh/PQWIUETTDw/pqj3FYqfgZWciZpgS384z5U9G5yaJmWcrMydO5i
 x03KHJN2ElrO0lyaM/STc5pCLgjuIqbU6ge4NctPWN7/ga/kfn0uHcstqqK4BkxhBwcGY706/Tg
 NesQZT+2rJ4Xclqvt4U07ozs24IZTUNgiE3DPE0WIegCJS/T4+oaQwQnGDkvgwYNIjSMa17AI9s
 c0ESYFIbV+XuI9RBiOKv4P9e2l6czOD9fiVfvwbFWtMeXoZmQXkO/dn1qZE7893jlAsHQRZwWUZ
 JXUYb767M5L1UnUG9R5zmGyWg3jRJKkPxtT4pAJq++v34qrjqGKWeRgqagLljGxXGDf2XQwGXyv
 WM2j5j6GJ/BDERDcunPpBOdL3DvQR+o1o/Zy40oClaGrfkfnUPnw9qJw5o6JibJGmCaBcgLvhCL
 rs5j4UJyiclmNbA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename vfs_rmdir as __vfs_rmdir, make it static and add a new
delegated_inode parameter. Add a vfs_rmdir wrapper that passes in a NULL
pointer for it. Add the necessary try_break_deleg calls to
__vfs_rmdir(). Convert do_rmdir to use __vfs_rmdir and wait for the
delegation break to complete before proceeding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7c9e237ed1b1a535934ffe5e523424bb035e7ae0..2211ed9f427cc97391d068b1a33ce388266a3e02 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4438,22 +4438,8 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 	return do_mkdirat(AT_FDCWD, getname(pathname), mode);
 }
 
-/**
- * vfs_rmdir - remove directory
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child directory
- *
- * Remove a directory.
- *
- * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then take
- * care to map the inode according to @idmap before checking permissions.
- * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply pass @nop_mnt_idmap.
- */
-int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry)
+static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, struct inode **delegated_inode)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
 
@@ -4475,6 +4461,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto out;
+
 	error = dir->i_op->rmdir(dir, dentry);
 	if (error)
 		goto out;
@@ -4491,6 +4481,26 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		d_delete_notify(dir, dentry);
 	return error;
 }
+
+/**
+ * vfs_rmdir - remove directory
+ * @idmap:	idmap of the mount the inode was found from
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
+ *
+ * Remove a directory.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply pass @nop_mnt_idmap.
+ */
+int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
+		     struct dentry *dentry)
+{
+	return __vfs_rmdir(idmap, dir, dentry, NULL);
+}
 EXPORT_SYMBOL(vfs_rmdir);
 
 int do_rmdir(int dfd, struct filename *name)
@@ -4501,6 +4511,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4530,7 +4541,8 @@ int do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
-	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
+	error = __vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+			    dentry, &delegated_inode);
 exit4:
 	dput(dentry);
 exit3:
@@ -4538,6 +4550,11 @@ int do_rmdir(int dfd, struct filename *name)
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

-- 
2.49.0


