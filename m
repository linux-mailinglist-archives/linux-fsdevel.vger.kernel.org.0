Return-Path: <linux-fsdevel+bounces-58718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F774B30A1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2CF2A3A27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295AD1A5B9E;
	Fri, 22 Aug 2025 00:11:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911F22EE5;
	Fri, 22 Aug 2025 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821486; cv=none; b=PQBwp9koJMVd5rbrHr9qLm4pyKzh3/aPvxuUPMb2C2yhjUo1dlKbPMBDPJsBObGwYRos+S1rAwNUlXbkTfJIKoy6RyyKeSn+JMu5io8W3OuK4rkOzqnQiebvrJLRZ+74sVVLsOGAmSfkHo4pughIsOe4GiciJ0nq8uarJQ0aYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821486; c=relaxed/simple;
	bh=UHhqmYK4kA6URFwMqIaA9tYTTvYOGMHKirwwvzE7Fgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbjZCgl9Fo8Ho7epayGxxvAjgY7giTtREnbsWpKdab/BQAg3tT8x81NL53J9f5WE2YYIYLt6SpxtPD4hh5hoV6TAp/0wvnfdf2fTbV7BNU7sRyDrFowtzVAcioOo2XmYYrOJ7G5xpcF++uiodODM4g8Bl25qtJDGmZCe81nGh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNB-006nb5-Vl;
	Fri, 22 Aug 2025 00:11:15 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/16] VFS: introduce simple_end_creating() and simple_failed_creating()
Date: Fri, 22 Aug 2025 10:00:27 +1000
Message-ID: <20250822000818.1086550-10-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are partners of simple_start_creating().
On failure we don't keep a reference.  On success we do.

Use these where simple_start_creating() is used, in debugfs, tracefs,
and rpcpipefs.

Also rename start_creating, end_creating, failed_creating in debugfs to
free up these generic names for more generic use.

I put the declarations in namei.h to have access to end_dirop() but they
really below with the other simple_ function declaration.  Possibly
these should be moved out of fs.h into a separate libfs.h which could
include namei.h

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c    | 43 +++++++++++++++++++++----------------------
 fs/tracefs/inode.c    |  6 ++----
 include/linux/namei.h | 16 ++++++++++++++++
 net/sunrpc/rpc_pipe.c | 11 ++++-------
 4 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a0357b0cf362..9525618ccad1 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -353,7 +353,8 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+static struct dentry *debugfs_start_creating(const char *name,
+					     struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -393,18 +394,16 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+static struct dentry *debugfs_failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_failed_creating(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 	return ERR_PTR(-ENOMEM);
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+static struct dentry *debugfs_end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
@@ -419,13 +418,13 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
+	dentry = debugfs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -433,7 +432,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = mode;
@@ -448,7 +447,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
@@ -568,14 +567,14 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  */
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = debugfs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -583,7 +582,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -595,7 +594,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
@@ -615,14 +614,14 @@ struct dentry *debugfs_create_automount(const char *name,
 					debugfs_automount_t f,
 					void *data)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = debugfs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -630,7 +629,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
@@ -642,7 +641,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
 
@@ -678,7 +677,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	if (!link)
 		return ERR_PTR(-ENOMEM);
 
-	dentry = start_creating(name, parent);
+	dentry = debugfs_start_creating(name, parent);
 	if (IS_ERR(dentry)) {
 		kfree(link);
 		return dentry;
@@ -689,13 +688,13 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		pr_err("out of free dentries, can not create symlink '%s'\n",
 		       name);
 		kfree(link);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 0c023941a316..320d7f25024b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -571,16 +571,14 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 
 struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_failed_creating(dentry);
 	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 	return NULL;
 }
 
 struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 /* Find the inode that this will use for default */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index bd0cba118540..b1171aa7fb96 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -84,6 +84,22 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 void end_dirop(struct dentry *de);
 void end_dirop_mkdir(struct dentry *de, struct dentry *parent);
 
+/* filesystems which use the dcache as backing store don't
+ * keep a reference after creating an object.
+ */
+static inline struct dentry *simple_end_creating(struct dentry *dentry)
+{
+	dget(dentry);
+	end_dirop(dentry);
+	return dentry;
+}
+
+/* On failure, the don't keep a reference */
+static inline void simple_failed_creating(struct dentry *dentry)
+{
+	end_dirop(dentry);
+}
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0bd1df2ebb47..38c26909235d 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -536,8 +536,7 @@ static int rpc_new_file(struct dentry *parent,
 
 	inode = rpc_get_inode(dir->i_sb, S_IFREG | mode);
 	if (unlikely(!inode)) {
-		dput(dentry);
-		inode_unlock(dir);
+		simple_failed_creating(dentry);
 		return -ENOMEM;
 	}
 	inode->i_ino = iunique(dir->i_sb, 100);
@@ -546,7 +545,7 @@ static int rpc_new_file(struct dentry *parent,
 	rpc_inode_setowner(inode, private);
 	d_instantiate(dentry, inode);
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	simple_end_creating(dentry);
 	return 0;
 }
 
@@ -572,9 +571,8 @@ static struct dentry *rpc_new_dir(struct dentry *parent,
 	inc_nlink(dir);
 	d_instantiate(dentry, inode);
 	fsnotify_mkdir(dir, dentry);
-	inode_unlock(dir);
 
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 static int rpc_populate(struct dentry *parent,
@@ -669,9 +667,8 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 	rpci->pipe = pipe;
 	rpc_inode_setowner(inode, private);
 	d_instantiate(dentry, inode);
-	pipe->dentry = dentry;
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	pipe->dentry = simple_end_creating(dentry);
 	return 0;
 
 failed:
-- 
2.50.0.107.gf914562f5916.dirty


