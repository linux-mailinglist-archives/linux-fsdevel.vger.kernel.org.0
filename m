Return-Path: <linux-fsdevel+bounces-62633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE8B9B444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E653B5239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C2311587;
	Wed, 24 Sep 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW6iSNIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65D324B20;
	Wed, 24 Sep 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737227; cv=none; b=o/9vLcn3MqdUhosa/qXQUt2mjtDhZWt1ltKVrjxlK6e7SitdaExt0M4ocRfgfpxJaXy0Ms/VdlLa/Pcjr0uRDFPuyiFFWs5ScR0MzZWe39Hz4RURxIlGErL+WCjNKDi0RGdq16bbMh0zJEo6XwYrPYI7+/0yZlA8sXaCOnwfOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737227; c=relaxed/simple;
	bh=d9JNsKUONfXALWZPklzOejQGs/N7Zk4qYoPs7sVB+0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMjGu2eSWTzQDt80jMVxsVHmPu/+mtGfOQyjPk/8zpgsQ29XP/tnSgRr9nAfCa0RiMQ6g3RqbFwJME2QbJjx5wNXi160nvI1uTn4hUx0n67syUU8nKAYagNfNOSFQSUXEJaWgIF4i8gDHkbS+rD6jMaszeWb57IbUSNjumGZ9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW6iSNIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71337C4CEE7;
	Wed, 24 Sep 2025 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737226;
	bh=d9JNsKUONfXALWZPklzOejQGs/N7Zk4qYoPs7sVB+0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cW6iSNIwxy423D0VVG6kVffhKe3H07dzDzxZNRfAi6vASHPepnD0Ssx94rZRoxQ0x
	 Ja2tKgcAvvTK/e+6AAc+9crZpdd7yReEhSzI2Ri1gCeoxV78ouHctDPDvhFD5p4eGH
	 syXK5ghzuny0x6q4L9fd+7MVEf960gukIB8XKnD3FgKK5S2yZTSKPYFsMnJMWCl2sf
	 s0KNVpsrI0mSPVb9AbukPL349/y1iGXxDXOI5Lhm9HNJH5ti6jXawPCKTpM2i3Mbdr
	 ovR6qSXsO2/ctcgCo17lQoaok0ceLUD/noFLUFYXvFMyrl8fF1hgaP5ls1lSsQ11TT
	 C9Jwqg45X4PGw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:01 -0400
Subject: [PATCH v3 15/38] filelock: add struct delegated_inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-15-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27415; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=d9JNsKUONfXALWZPklzOejQGs/N7Zk4qYoPs7sVB+0A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMNJSnswp2udnq9Hp7WaXPwC3G4LVMnW3P1m
 LDwupv358SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDQAKCRAADmhBGVaC
 FVOBEACYWnJWg8Zo+wJoh4zZeJ/uwCsDNe6CD7JijL0hQizkdnJD0IuK+oFKBM5sAY4RQM1jnth
 oMakt2bxKsoLkHSbSdWIgDBN34YEKADod9D/NzPDDpwKB862gxBOFznegvnaeYGGXTeINdE6dMp
 KThpUm0JeF5WuzjVETBW3nX8MjX29kdL0P7fLXITAtQVB/JAyTCWgT1E4e9xxVlM5FR/Xa4WyNo
 jeZ9LSFcp9Nry2gYQljGM26WJjU1bS4hU/x2lzezaW4kmUyV5JYy+6w+90RDtJ1rEyj4eQP23kp
 8+9zyNCJYEnZ1RWt6mrQBNfGTEf06/nwz4kNOg5BOWQHPSuTyJPSRepPvs9pOPUIVZbEB2f+EYK
 I0dMKOlravOum9R8yZSYY5dk0rTw25KmZ39PXKBIeBD5JcxKpZwvlMOi3OIF5eAbnymiE537tVV
 g7OANNe6HSrttlI2UC2wzxcjlScc+6xbdeObtz4tNxMtzSO95Nu5j7sVVWlnizwwoJwRQj5Psx2
 Cu2G0LW9gAxglFqBh5JyX9PjHFVl8TWQIUIiw9xgK/S4q7xvY5rfmo5vOTieTRNRtUibW2qwEMJ
 E0CF6ax/nwgTSWcEO46oSzzw5EYEbIBcmflivfw9ubkhjjsXUAJp50K8eDFiO1UVmWAxUmnOZpq
 xGBHk/WbkbL/1fQ==
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
 include/linux/fs.h       | 11 +++----
 include/linux/xattr.h    |  4 +--
 9 files changed, 116 insertions(+), 81 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 795f231d00e8eaaadf5b62f241655cb4b69cb507..01374453805acba7ea8e1e3e4818b76fffb45334 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL(may_setattr);
  * performed on the raw inode simply pass @nop_mnt_idmap.
  */
 int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
-		  struct iattr *attr, struct inode **delegated_inode)
+		  struct iattr *attr, struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
@@ -537,7 +537,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * breaking the delegation in this case.
 	 */
 	if (!(ia_valid & ATTR_DELEG)) {
-		error = try_break_deleg(inode, delegated_inode);
+		error = try_break_deleg(inode, 0, delegated_inode);
 		if (error)
 			return error;
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 7bcd898c84138061030f1f8b91273261cdf2a9b4..e50af814b25079038a48d53bd73c00a26db4f829 100644
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
@@ -4386,7 +4386,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode,
-			 struct inode **delegated_inode)
+			 struct delegated_inode *delegated_inode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4409,7 +4409,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		goto err;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		goto err;
 
@@ -4436,7 +4436,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -4453,7 +4453,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 			error = PTR_ERR(dentry);
 	}
 	done_path_create(&path, dentry);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry;
@@ -4478,7 +4478,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 }
 
 static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, struct inode **delegated_inode)
+		       struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
 
@@ -4500,7 +4500,7 @@ static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_DELETE, delegated_inode);
 	if (error)
 		goto out;
 
@@ -4550,7 +4550,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4589,7 +4589,7 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry;
@@ -4634,7 +4634,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, struct inode **delegated_inode)
+	       struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
 	int error = may_delete(idmap, dir, dentry, 0);
@@ -4653,10 +4653,10 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -4695,7 +4695,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	struct inode *inode = NULL;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
@@ -4732,7 +4732,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -4881,7 +4881,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  */
 int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	     struct inode *dir, struct dentry *new_dentry,
-	     struct inode **delegated_inode)
+	     struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4925,9 +4925,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
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
@@ -4959,7 +4959,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct mnt_idmap *idmap;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int how = 0;
 	int error;
 
@@ -5003,7 +5003,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 			 new_dentry, &delegated_inode);
 out_dput:
 	done_path_create(&new_path, new_dentry);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error) {
 			path_put(&old_path);
@@ -5089,7 +5089,7 @@ int vfs_rename(struct renamedata *rd)
 	struct inode *new_dir = d_inode(rd->new_parent);
 	struct dentry *old_dentry = rd->old_dentry;
 	struct dentry *new_dentry = rd->new_dentry;
-	struct inode **delegated_inode = rd->delegated_inode;
+	struct delegated_inode *delegated_inode = rd->delegated_inode;
 	unsigned int flags = rd->flags;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
@@ -5194,21 +5194,24 @@ int vfs_rename(struct renamedata *rd)
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
@@ -5260,7 +5263,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
 	int old_type, new_type;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0, target_flags =
 		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 	bool should_retry = false;
@@ -5369,7 +5372,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 exit3:
 	unlock_rename(new_path.dentry, old_path.dentry);
 exit_lock_rename:
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/open.c b/fs/open.c
index 9655158c38853e3435adb77f22ce0c81c3f0aed4..f9fe763a7c8802f5b6fad1c7ff8256dddcd8f48c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -631,7 +631,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 int chmod_common(const struct path *path, umode_t mode)
 {
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	struct iattr newattrs;
 	int error;
 
@@ -651,7 +651,7 @@ int chmod_common(const struct path *path, umode_t mode)
 			      &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (deleg_inode(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -756,7 +756,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	struct mnt_idmap *idmap;
 	struct user_namespace *fs_userns;
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int error;
 	struct iattr newattrs;
 	kuid_t uid;
@@ -791,7 +791,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
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
index 8851a5ef34f5ab34383975dd4cef537de3f6391e..276b445bfa013e8c0e10231c00dd8e36368c7bdf 100644
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
index 29078156d863b4e66dc59085f7c2cebd2c078ec3..68901da7671694f68d939085d08e0da21712540d 100644
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
@@ -227,12 +240,6 @@ void locks_init_lease(struct file_lease *);
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
@@ -500,25 +507,41 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
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
 
@@ -537,6 +560,13 @@ static inline int break_layout(struct inode *inode, bool wait)
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
@@ -547,12 +577,13 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
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
index 24a091509f12ce65a2c8343d438fccf423d3062b..de178875462a1cb8eded868d8f8539dcc747e03f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -82,6 +82,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct file_kattr;
 struct iomap_ops;
+struct delegated_inode;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1997,16 +1998,16 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
-			 struct dentry *, umode_t, struct inode **);
+			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
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
@@ -2026,7 +2027,7 @@ struct renamedata {
 	struct mnt_idmap *new_mnt_idmap;
 	struct dentry *new_parent;
 	struct dentry *new_dentry;
-	struct inode **delegated_inode;
+	struct delegated_inode *delegated_inode;
 	unsigned int flags;
 } __randomize_layout;
 
@@ -3069,7 +3070,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
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
2.51.0


