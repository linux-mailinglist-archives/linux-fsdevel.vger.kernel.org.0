Return-Path: <linux-fsdevel+bounces-50345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FEACB0F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B241BC10C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228AE233144;
	Mon,  2 Jun 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASI7Ygri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA81232376;
	Mon,  2 Jun 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872974; cv=none; b=e/wKq498/GcUg2qQiQkTeUm4hK+bSsn3qNz1cKNEHt6CjimrKtic4JtQCMoWqutQs1g7qjTBcUAQlXXGJ8m+P2sV1ob7R6mhDIeHNj1/kCmgCt1zAL7syEuXpYO/mN9d0neafFsW3aiVpvcvk631+92fC1oW6xFp9hhkVhwdsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872974; c=relaxed/simple;
	bh=3k+VvTdjcwKXyNQVPi29EJW5NaPGU8wqkBuvNBLOJmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcwTfSlzE5Yqssf1nX/VDDvu1j10OyXr1qrQz48S/WYDRycn+whdcV5s5BGU10AjPzipDrQyEVurjpwjuzHPR/NTLXGHvR03YdaajXmxUz1m18L6rANSj64qs9nogpdzerA/nagTX4dKqfPnlOzLsBIv1k3N21B2oPmrD+k8dqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASI7Ygri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F061DC4CEF0;
	Mon,  2 Jun 2025 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872973;
	bh=3k+VvTdjcwKXyNQVPi29EJW5NaPGU8wqkBuvNBLOJmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ASI7Ygrin0QZBCC9OLr1qAjHAafsCEB+4DQNF5jYwuZWDzu8cpdFhO7cWaX5eHXAo
	 ZvVf5yzn/HW2Ob+sPseRyj28fNI4GBYrukFrrPpKqmmBjMsBBSREeKOyIMnQNg7LTJ
	 eXwUEx7ybOb71Cmk6WWGYwPTJKnBxjvRYCxOvj1wmh1T/DxgQRceNi65j4jE+Y7lyR
	 /ash4jGPgr5hsP0ocWhuAHUtVTjTmtqE4tYlP9asglfZqsKZvvYej+zk+pDIH622V1
	 y27SywSpznUnDDXUJE9P88opE2+uBVGLFSaf5gurfZiWsIONwDWdIpFnPEeiGAz+LU
	 Sq2kG7PGoW0rw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:58 -0400
Subject: [PATCH RFC v2 15/28] filelock: add struct delegated_inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-15-a7919700de86@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=27085; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3k+VvTdjcwKXyNQVPi29EJW5NaPGU8wqkBuvNBLOJmg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7njTwbrGXHQ9ZwnJSIOTuo+UAlFRFzt4Bdv
 h3q2ghr+2KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5wAKCRAADmhBGVaC
 FaWED/4z3+En3mW4KxYz5ZubB00WFVVY+fh+S1XPavUdzfpR1imob4bwvdbt8cFB7j5h1PIBxIv
 ZvMhLYyItXyWt9xNecdgqtFQ845vwpLC9DwbcV1DUZTdiV0Ji28FU9bqot/6lW1HStub+ZFQkyO
 qQM0Xy9H6XDoZGE4BgzOmi+M13Z+3GH9K/ZtmKVAV3RfzcgkT/TA5lc2TSAi21B8BUUdJElBpD3
 4pssq9NMwFlaR2kSk2B9/d6G6+t9G8oYkQehpkge8PRuojJOlr0Axazqb1sT6pJBPi0MptmOLnC
 L047jCJSnXdr/yBIF+wmfOV4beRNU+CJHdQLHyzQJxUDusBG49AVmyVcgTGYhmoJSBikSZ327Xw
 mRHIfiMCDBplIgegwjyG1XX7G2yQdIfCjLqsj3fJxOSxMto/YIOtD0Cv2wmKc/XAPRAnJW7jQ6c
 gUsRcsLGgu73R5gh+qx0mc/+UUx3d9ZyOF5Jta+/SiTVi74FXMQla4RF4q+PhHGHvk3i6FuEYer
 xmsb8RYXRkEaqSKizZbSvBFPEmIZBJCTYiS3Z/KcnEwOjImyAqeq7CawXj2cDZrxJMgBYdlRu2L
 E9r4xDfwkVAreC5YivFXswsjjzT8amAcDzUcfDpjM/blV6l2uKQXXswvVUkTB9U6OVR5fGI8k1X
 rEIa9Pwqr3CuaDg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Later patches will add support for ignoring certain events rather than
breaking the delegation. To do this, the VFS must inform __break_lease()
about why the delegation is being broken. Convert the delegated_inode
double pointer in various VFS functions into a struct that has a inode
and a reason for the delegation break. Also set the reason value in the
appropriate places.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c                |  4 +--
 fs/namei.c               | 75 +++++++++++++++++++++++++-----------------------
 fs/open.c                |  8 +++---
 fs/posix_acl.c           | 12 ++++----
 fs/utimes.c              |  4 +--
 fs/xattr.c               | 16 +++++------
 include/linux/filelock.h | 63 +++++++++++++++++++++++++++++-----------
 include/linux/fs.h       |  9 +++---
 include/linux/xattr.h    |  4 +--
 9 files changed, 115 insertions(+), 80 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..02f685a56729c2f8b3f6b6d636a9297a1e52062a 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -424,7 +424,7 @@ EXPORT_SYMBOL(may_setattr);
  * performed on the raw inode simply pass @nop_mnt_idmap.
  */
 int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
-		  struct iattr *attr, struct inode **delegated_inode)
+		  struct iattr *attr, struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
@@ -543,7 +543,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * breaking the delegation in this case.
 	 */
 	if (!(ia_valid & ATTR_DELEG)) {
-		error = try_break_deleg(inode, delegated_inode);
+		error = try_break_deleg(inode, 0, delegated_inode);
 		if (error)
 			return error;
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 8f0517ade308134ed6566566d9b575c4e9fb0d4e..ba9cbdfb591d54cfe3315d8821ce276a6f12700f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3372,7 +3372,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 
 static int __vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool want_excl,
-			struct inode **delegated_inode)
+			struct delegated_inode *delegated_inode)
 {
 	int error;
 
@@ -3387,7 +3387,7 @@ static int __vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		return error;
 	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
@@ -3618,8 +3618,8 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  * An error code is returned on failure.
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
-				  const struct open_flags *op,
-				  bool got_write, struct inode **delegated_inode)
+				  const struct open_flags *op, bool got_write,
+				  struct delegated_inode *delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -3709,7 +3709,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
+		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (error)
 			goto out_dput;
 
@@ -3776,7 +3776,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	struct dentry *dentry;
@@ -3836,7 +3836,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		mnt_drop_write(nd->path.mnt);
 
 	if (IS_ERR(dentry)) {
-		if (delegated_inode) {
+		if (deleg_inode(&delegated_inode)) {
 			int error = break_deleg_wait(&delegated_inode);
 
 			if (!error)
@@ -4217,7 +4217,7 @@ EXPORT_SYMBOL(user_path_create);
 
 static int __vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t dev,
-		       struct inode **delegated_inode)
+		       struct delegated_inode *delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4241,7 +4241,7 @@ static int __vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		return error;
 
@@ -4299,7 +4299,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	error = may_mknod(mode);
 	if (error)
@@ -4337,7 +4337,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	done_path_create(&path, dentry);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry;
@@ -4364,7 +4364,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 
 static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				  struct dentry *dentry, umode_t mode,
-				  struct inode **delegated_inode)
+				  struct delegated_inode *delegated_inode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4387,7 +4387,7 @@ static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		goto err;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		goto err;
 
@@ -4441,7 +4441,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -4458,7 +4458,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 			error = PTR_ERR(dentry);
 	}
 	done_path_create(&path, dentry);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry;
@@ -4483,7 +4483,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 }
 
 static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, struct inode **delegated_inode)
+		       struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
 
@@ -4505,7 +4505,7 @@ static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_DELETE, delegated_inode);
 	if (error)
 		goto out;
 
@@ -4555,7 +4555,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4594,7 +4594,7 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry;
@@ -4639,7 +4639,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, struct inode **delegated_inode)
+	       struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
 	int error = may_delete(idmap, dir, dentry, 0);
@@ -4658,10 +4658,10 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	else {
 		error = security_inode_unlink(dir, dentry);
 		if (!error) {
-			error = try_break_deleg(dir, delegated_inode);
+			error = try_break_deleg(dir, LEASE_BREAK_DIR_DELETE, delegated_inode);
 			if (error)
 				goto out;
-			error = try_break_deleg(target, delegated_inode);
+			error = try_break_deleg(target, 0, delegated_inode);
 			if (error)
 				goto out;
 			error = dir->i_op->unlink(dir, dentry);
@@ -4700,7 +4700,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	struct inode *inode = NULL;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
@@ -4737,7 +4737,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -4886,7 +4886,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  */
 int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	     struct inode *dir, struct dentry *new_dentry,
-	     struct inode **delegated_inode)
+	     struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4930,9 +4930,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
 	else {
-		error = try_break_deleg(dir, delegated_inode);
+		error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (!error)
-			error = try_break_deleg(inode, delegated_inode);
+			error = try_break_deleg(inode, 0, delegated_inode);
 		if (!error)
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
@@ -4964,7 +4964,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct mnt_idmap *idmap;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int how = 0;
 	int error;
 
@@ -5008,7 +5008,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 			 new_dentry, &delegated_inode);
 out_dput:
 	done_path_create(&new_path, new_dentry);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error) {
 			path_put(&old_path);
@@ -5093,7 +5093,7 @@ int vfs_rename(struct renamedata *rd)
 	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
 	struct dentry *old_dentry = rd->old_dentry;
 	struct dentry *new_dentry = rd->new_dentry;
-	struct inode **delegated_inode = rd->delegated_inode;
+	struct delegated_inode *delegated_inode = rd->delegated_inode;
 	unsigned int flags = rd->flags;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
@@ -5198,21 +5198,24 @@ int vfs_rename(struct renamedata *rd)
 		    old_dir->i_nlink >= max_links)
 			goto out;
 	}
-	error = try_break_deleg(old_dir, delegated_inode);
+	error = try_break_deleg(old_dir,
+				old_dir == new_dir ? LEASE_BREAK_DIR_RENAME :
+						     LEASE_BREAK_DIR_DELETE,
+				delegated_inode);
 	if (error)
 		goto out;
 	if (new_dir != old_dir) {
-		error = try_break_deleg(new_dir, delegated_inode);
+		error = try_break_deleg(new_dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (error)
 			goto out;
 	}
 	if (!is_dir) {
-		error = try_break_deleg(source, delegated_inode);
+		error = try_break_deleg(source, 0, delegated_inode);
 		if (error)
 			goto out;
 	}
 	if (target && !new_is_dir) {
-		error = try_break_deleg(target, delegated_inode);
+		error = try_break_deleg(target, 0, delegated_inode);
 		if (error)
 			goto out;
 	}
@@ -5264,7 +5267,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
 	int old_type, new_type;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0, target_flags =
 		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 	bool should_retry = false;
@@ -5373,7 +5376,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 exit3:
 	unlock_rename(new_path.dentry, old_path.dentry);
 exit_lock_rename:
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa40c83e69683bd1ecfe69a90e2b49..529f9d4ee73453a9e3da818ebd4ba0eb17245521 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -630,7 +630,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 int chmod_common(const struct path *path, umode_t mode)
 {
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	struct iattr newattrs;
 	int error;
 
@@ -650,7 +650,7 @@ int chmod_common(const struct path *path, umode_t mode)
 			      &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -755,7 +755,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	struct mnt_idmap *idmap;
 	struct user_namespace *fs_userns;
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int error;
 	struct iattr newattrs;
 	kuid_t uid;
@@ -790,7 +790,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4050942ab52f95741da2df13d191ade5c5ca12a2..19a45fc8e413d0fb2e2d906488c3ce648bb318a4 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1091,7 +1091,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	int acl_type;
 	int error;
 	struct inode *inode = d_inode(dentry);
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	acl_type = posix_acl_type(acl_name);
 	if (acl_type < 0)
@@ -1125,7 +1125,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	error = try_break_deleg(inode, &delegated_inode);
+	error = try_break_deleg(inode, 0, &delegated_inode);
 	if (error)
 		goto out_inode_unlock;
 
@@ -1141,7 +1141,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 out_inode_unlock:
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -1212,7 +1212,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	int acl_type;
 	int error;
 	struct inode *inode = d_inode(dentry);
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	acl_type = posix_acl_type(acl_name);
 	if (acl_type < 0)
@@ -1233,7 +1233,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	error = try_break_deleg(inode, &delegated_inode);
+	error = try_break_deleg(inode, 0, &delegated_inode);
 	if (error)
 		goto out_inode_unlock;
 
@@ -1249,7 +1249,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 out_inode_unlock:
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/utimes.c b/fs/utimes.c
index c7c7958e57b22f91646ca9f76d18781b64d371a3..4145cbbc190ffb5990fef248300c853ec32d643f 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -22,7 +22,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	int error;
 	struct iattr newattrs;
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	if (times) {
 		if (!nsec_valid(times[0].tv_nsec) ||
@@ -66,7 +66,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
 			      &delegated_inode);
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/xattr.c b/fs/xattr.c
index 8ec5b0204bfdc587e7875893e3b1a1e1479d7d1b..1de49ba91b8e6ff9c45c461fe9963f587420cc5f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -274,7 +274,7 @@ int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
 int
 __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *name, const void *value, size_t size,
-		      int flags, struct inode **delegated_inode)
+		      int flags, struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -288,7 +288,7 @@ __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(inode, delegated_inode);
+	error = try_break_deleg(inode, 0, delegated_inode);
 	if (error)
 		goto out;
 
@@ -305,7 +305,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	     const char *name, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	const void  *orig_value = value;
 	int error;
 
@@ -322,7 +322,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				      flags, &delegated_inode);
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -533,7 +533,7 @@ EXPORT_SYMBOL(__vfs_removexattr);
 int
 __vfs_removexattr_locked(struct mnt_idmap *idmap,
 			 struct dentry *dentry, const char *name,
-			 struct inode **delegated_inode)
+			 struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -546,7 +546,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(inode, delegated_inode);
+	error = try_break_deleg(inode, 0, delegated_inode);
 	if (error)
 		goto out;
 
@@ -567,7 +567,7 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		const char *name)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int error;
 
 retry_deleg:
@@ -576,7 +576,7 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 					 name, &delegated_inode);
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 0fe368060781d0b22f735c2cfb8d8c1a6a238290..f2b2d1e1d1ab08671895c3bfe398e5bba02353d8 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -160,6 +160,19 @@ struct file_lock_context {
 	struct list_head	flc_lease;
 };
 
+#define LEASE_BREAK_LEASE		BIT(0)	// break leases and delegations
+#define LEASE_BREAK_DELEG		BIT(1)	// break delegations only
+#define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
+#define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
+#define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
+#define LEASE_BREAK_DIR_CREATE		BIT(6)	// dir deleg create event
+#define LEASE_BREAK_DIR_DELETE		BIT(7)	// dir deleg delete event
+#define LEASE_BREAK_DIR_RENAME		BIT(8)	// dir deleg rename event
+
+#define LEASE_BREAK_DIR_REASON_MASK	(LEASE_BREAK_DIR_CREATE | \
+					 LEASE_BREAK_DIR_DELETE | \
+					 LEASE_BREAK_DIR_RENAME)
+
 #ifdef CONFIG_FILE_LOCKING
 int fcntl_getlk(struct file *, unsigned int, struct flock *);
 int fcntl_setlk(unsigned int, struct file *, unsigned int,
@@ -222,12 +235,6 @@ void locks_init_lease(struct file_lease *);
 void locks_free_lease(struct file_lease *fl);
 struct file_lease *locks_alloc_lease(void);
 
-#define LEASE_BREAK_LEASE		BIT(0)	// break leases and delegations
-#define LEASE_BREAK_DELEG		BIT(1)	// break delegations only
-#define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
-#define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
-#define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
-
 int __break_lease(struct inode *inode, unsigned int flags);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
 int generic_setlease(struct file *, int, struct file_lease **, void **priv);
@@ -495,25 +502,41 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 	return 0;
 }
 
-static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
+struct delegated_inode {
+	struct inode *di_inode;
+	unsigned int di_reason; // LEASE_BREAK_* flags
+};
+
+static inline struct inode *deleg_inode(struct delegated_inode *di)
+{
+	return di->di_inode;
+}
+
+static inline int try_break_deleg(struct inode *inode, unsigned int reason,
+				  struct delegated_inode *di)
 {
 	int ret;
 
-	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
-	if (ret == -EWOULDBLOCK && delegated_inode) {
-		*delegated_inode = inode;
+	/* Clear any extraneous reason bits, after warning if any are set */
+	WARN_ON_ONCE(reason & ~LEASE_BREAK_DIR_REASON_MASK);
+	reason &= LEASE_BREAK_DIR_REASON_MASK;
+
+	ret = break_deleg(inode, reason | LEASE_BREAK_NONBLOCK);
+	if (ret == -EWOULDBLOCK && di) {
+		di->di_inode = inode;
+		di->di_reason = reason;
 		ihold(inode);
 	}
 	return ret;
 }
 
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static inline int break_deleg_wait(struct delegated_inode *di)
 {
 	int ret;
 
-	ret = break_deleg(*delegated_inode, 0);
-	iput(*delegated_inode);
-	*delegated_inode = NULL;
+	ret = break_deleg(di->di_inode, di->di_reason);
+	iput(di->di_inode);
+	di->di_inode = NULL;
 	return ret;
 }
 
@@ -532,6 +555,13 @@ static inline int break_layout(struct inode *inode, bool wait)
 }
 
 #else /* !CONFIG_FILE_LOCKING */
+struct delegated_inode { };
+
+static inline struct inode *deleg_inode(struct delegated_inode *di)
+{
+	return NULL;
+}
+
 static inline int break_lease(struct inode *inode, bool wait)
 {
 	return 0;
@@ -542,12 +572,13 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 	return 0;
 }
 
-static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
+static inline int try_break_deleg(struct inode *inode, unsigned int reason,
+				  struct delegated_inode *delegated_inode)
 {
 	return 0;
 }
 
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static inline int break_deleg_wait(struct delegated_inode *delegated_inode)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0db87f8e676cc8d022b28042bf6fd1af5f8928e3..172094c88165f909ee3cd53c8b02ff6d69f04e5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -82,6 +82,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
 struct iomap_ops;
+struct delegated_inode;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1997,10 +1998,10 @@ int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
-	     struct dentry *, struct inode **);
+	     struct dentry *, struct delegated_inode *);
 int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
 int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
-	       struct inode **);
+	       struct delegated_inode *);
 
 /**
  * struct renamedata - contains all information required for renaming
@@ -2020,7 +2021,7 @@ struct renamedata {
 	struct mnt_idmap *new_mnt_idmap;
 	struct inode *new_dir;
 	struct dentry *new_dentry;
-	struct inode **delegated_inode;
+	struct delegated_inode *delegated_inode;
 	unsigned int flags;
 } __randomize_layout;
 
@@ -3028,7 +3029,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 #endif
 
 int notify_change(struct mnt_idmap *, struct dentry *,
-		  struct iattr *, struct inode **);
+		  struct iattr *, struct delegated_inode *);
 int inode_permission(struct mnt_idmap *, struct inode *, int);
 int generic_permission(struct mnt_idmap *, struct inode *, int);
 static inline int file_permission(struct file *file, int mask)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 86b0d47984a16d935dd1c45ca80a3b8bb5b7295b..64e9afe7d647dc38f686a4b5c6f765e061cde54c 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -85,12 +85,12 @@ int __vfs_setxattr_noperm(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int);
 int __vfs_setxattr_locked(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int,
-			  struct inode **);
+			  struct delegated_inode *);
 int vfs_setxattr(struct mnt_idmap *, struct dentry *, const char *,
 		 const void *, size_t, int);
 int __vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
 int __vfs_removexattr_locked(struct mnt_idmap *, struct dentry *,
-			     const char *, struct inode **);
+			     const char *, struct delegated_inode *);
 int vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);

-- 
2.49.0


