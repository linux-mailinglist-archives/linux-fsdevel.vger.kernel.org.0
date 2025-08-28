Return-Path: <linux-fsdevel+bounces-59585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1248CB3AE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C7B5E3C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDBE2FF657;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Nb+ZBU3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314E2F3C03
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422499; cv=none; b=pCyow9Y0G/qk53KGvbQ2oYmIiTA/xvVysBG0TMlIbdAQbhNY2KTzwdQ/+gYiSQTXQZ7mf9nrUYq9/vtbE5MoF9C2wZSsLxYdQhgCeO+xlmeY+I7dczIwUMkvBck5sN2hpWHe0BAIsdwDrIQfn/SAMyz7733296UC1oBXrbQISzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422499; c=relaxed/simple;
	bh=KINVBemYKlz5GNBGKoBs4WMl/aM01bCLodjteAudEGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv0BFLBi4SqIpIp7Maz5TiB8IKM+Lm+G5kFOSi2Sh6Fg3Y34VKx5tuecwACkVgZAH0XTwlaSIme67myzRMIKaOXgLi26+VWgowY8Ku6tUTa/BAEf77U+WiqpB7XH48BI2sRuCKF0J9cKzOjB5nPyiHVoshqDzABvUx4Zt2UVA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Nb+ZBU3e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n2zCqkVhN6Bq+qc1BARoNlH9AIfwtqAURBoz/ZOgIxY=; b=Nb+ZBU3eaHsy4aCB/W88zVC+Fz
	40rSwj9oxDnBG+ahS+DjNvzLOpZj84x4498tQ5mnh4wk598GCz3TyUsU6CYolnum6oGyW13QL4qtO
	el6rcbMPR8DSMTUjF5hznWnrd8rLIWRNVFjdeTjjaSUWrR3zaaCZnIpNFBFi7kt3JhoEvNcTafwEq
	yzVL2dX0FHUZTurcjNqGXhLnw/WSiTCZJ9auVvKdQ8rEMDeDY2ififVOb29Db2fOC38Ij52gWFaes
	WhoH2NoqT2qsjJhlB9PR+XY3sCJeCuiH67PPHkLgwtgiWuwPKAqDX2NkWPfWzMDUNWBAXYM0H2+tf
	lsvH4Ufw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F29b-0gRd;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 52/63] ecryptfs: get rid of pointless mount references in ecryptfs dentries
Date: Fri, 29 Aug 2025 00:07:55 +0100
Message-ID: <20250828230806.3582485-52-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->lower_path.mnt has the same value for all dentries on given ecryptfs
instance and if somebody goes for mountpoint-crossing variant where that
would not be true, we can deal with that when it happens (and _not_
with duplicating these reference into each dentry).

As it is, we are better off just sticking a reference into ecryptfs-private
part of superblock and keeping it pinned until ->kill_sb().

That way we can stick a reference to underlying dentry right into ->d_fsdata
of ecryptfs one, getting rid of indirection through struct ecryptfs_dentry_info,
along with the entire struct ecryptfs_dentry_info machinery.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/dentry.c          | 14 +-------------
 fs/ecryptfs/ecryptfs_kernel.h | 27 +++++++++++----------------
 fs/ecryptfs/file.c            | 15 +++++++--------
 fs/ecryptfs/inode.c           | 19 +++++--------------
 fs/ecryptfs/main.c            | 24 ++++++------------------
 5 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 1dfd5b81d831..6648a924e31a 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -59,14 +59,6 @@ static int ecryptfs_d_revalidate(struct inode *dir, const struct qstr *name,
 	return rc;
 }
 
-struct kmem_cache *ecryptfs_dentry_info_cache;
-
-static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
-{
-	kmem_cache_free(ecryptfs_dentry_info_cache,
-		container_of(head, struct ecryptfs_dentry_info, rcu));
-}
-
 /**
  * ecryptfs_d_release
  * @dentry: The ecryptfs dentry
@@ -75,11 +67,7 @@ static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
  */
 static void ecryptfs_d_release(struct dentry *dentry)
 {
-	struct ecryptfs_dentry_info *p = dentry->d_fsdata;
-	if (p) {
-		path_put(&p->lower_path);
-		call_rcu(&p->rcu, ecryptfs_dentry_free_rcu);
-	}
+	dput(dentry->d_fsdata);
 }
 
 const struct dentry_operations ecryptfs_dops = {
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 1f562e75d0e4..9e6ab0b41337 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -258,13 +258,6 @@ struct ecryptfs_inode_info {
 	struct ecryptfs_crypt_stat crypt_stat;
 };
 
-/* dentry private data. Each dentry must keep track of a lower
- * vfsmount too. */
-struct ecryptfs_dentry_info {
-	struct path lower_path;
-	struct rcu_head rcu;
-};
-
 /**
  * ecryptfs_global_auth_tok - A key used to encrypt all new files under the mountpoint
  * @flags: Status flags
@@ -348,6 +341,7 @@ struct ecryptfs_mount_crypt_stat {
 /* superblock private data. */
 struct ecryptfs_sb_info {
 	struct super_block *wsi_sb;
+	struct vfsmount *lower_mnt;
 	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
 };
 
@@ -494,22 +488,25 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
 }
 
 static inline void
-ecryptfs_set_dentry_private(struct dentry *dentry,
-			    struct ecryptfs_dentry_info *dentry_info)
+ecryptfs_set_dentry_lower(struct dentry *dentry,
+			  struct dentry *lower_dentry)
 {
-	dentry->d_fsdata = dentry_info;
+	dentry->d_fsdata = lower_dentry;
 }
 
 static inline struct dentry *
 ecryptfs_dentry_to_lower(struct dentry *dentry)
 {
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
+	return dentry->d_fsdata;
 }
 
-static inline const struct path *
-ecryptfs_dentry_to_lower_path(struct dentry *dentry)
+static inline struct path
+ecryptfs_lower_path(struct dentry *dentry)
 {
-	return &((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path;
+	return (struct path){
+		.mnt = ecryptfs_superblock_to_private(dentry->d_sb)->lower_mnt,
+		.dentry = ecryptfs_dentry_to_lower(dentry)
+	};
 }
 
 #define ecryptfs_printk(type, fmt, arg...) \
@@ -532,7 +529,6 @@ extern unsigned int ecryptfs_number_of_users;
 
 extern struct kmem_cache *ecryptfs_auth_tok_list_item_cache;
 extern struct kmem_cache *ecryptfs_file_info_cache;
-extern struct kmem_cache *ecryptfs_dentry_info_cache;
 extern struct kmem_cache *ecryptfs_inode_info_cache;
 extern struct kmem_cache *ecryptfs_sb_info_cache;
 extern struct kmem_cache *ecryptfs_header_cache;
@@ -557,7 +553,6 @@ int ecryptfs_encrypt_and_encode_filename(
 	size_t *encoded_name_size,
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	const char *name, size_t name_size);
-struct dentry *ecryptfs_lower_dentry(struct dentry *this_dentry);
 void ecryptfs_dump_hex(char *data, int bytes);
 int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
 			int sg_size);
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 5f8f96da09fe..7929411837cf 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -33,13 +33,12 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 				struct iov_iter *to)
 {
 	ssize_t rc;
-	const struct path *path;
 	struct file *file = iocb->ki_filp;
 
 	rc = generic_file_read_iter(iocb, to);
 	if (rc >= 0) {
-		path = ecryptfs_dentry_to_lower_path(file->f_path.dentry);
-		touch_atime(path);
+		struct path path = ecryptfs_lower_path(file->f_path.dentry);
+		touch_atime(&path);
 	}
 	return rc;
 }
@@ -59,12 +58,11 @@ static ssize_t ecryptfs_splice_read_update_atime(struct file *in, loff_t *ppos,
 						 size_t len, unsigned int flags)
 {
 	ssize_t rc;
-	const struct path *path;
 
 	rc = filemap_splice_read(in, ppos, pipe, len, flags);
 	if (rc >= 0) {
-		path = ecryptfs_dentry_to_lower_path(in->f_path.dentry);
-		touch_atime(path);
+		struct path path = ecryptfs_lower_path(in->f_path.dentry);
+		touch_atime(&path);
 	}
 	return rc;
 }
@@ -283,6 +281,7 @@ static int ecryptfs_dir_open(struct inode *inode, struct file *file)
 	 * ecryptfs_lookup() */
 	struct ecryptfs_file_info *file_info;
 	struct file *lower_file;
+	struct path path;
 
 	/* Released in ecryptfs_release or end of function if failure */
 	file_info = kmem_cache_zalloc(ecryptfs_file_info_cache, GFP_KERNEL);
@@ -292,8 +291,8 @@ static int ecryptfs_dir_open(struct inode *inode, struct file *file)
 				"Error attempting to allocate memory\n");
 		return -ENOMEM;
 	}
-	lower_file = dentry_open(ecryptfs_dentry_to_lower_path(ecryptfs_dentry),
-				 file->f_flags, current_cred());
+	path = ecryptfs_lower_path(ecryptfs_dentry);
+	lower_file = dentry_open(&path, file->f_flags, current_cred());
 	if (IS_ERR(lower_file)) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 72fbe1316ab8..d2b262dc485d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -327,24 +327,15 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 				     struct dentry *lower_dentry)
 {
-	const struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
+	struct dentry *lower_parent = ecryptfs_dentry_to_lower(dentry->d_parent);
 	struct inode *inode, *lower_inode;
-	struct ecryptfs_dentry_info *dentry_info;
 	int rc = 0;
 
-	dentry_info = kmem_cache_alloc(ecryptfs_dentry_info_cache, GFP_KERNEL);
-	if (!dentry_info) {
-		dput(lower_dentry);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	fsstack_copy_attr_atime(d_inode(dentry->d_parent),
-				d_inode(path->dentry));
+				d_inode(lower_parent));
 	BUG_ON(!d_count(lower_dentry));
 
-	ecryptfs_set_dentry_private(dentry, dentry_info);
-	dentry_info->lower_path.mnt = mntget(path->mnt);
-	dentry_info->lower_path.dentry = lower_dentry;
+	ecryptfs_set_dentry_lower(dentry, lower_dentry);
 
 	/*
 	 * negative dentry can go positive under us here - its parent is not
@@ -1022,10 +1013,10 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
 {
 	struct dentry *dentry = path->dentry;
 	struct kstat lower_stat;
+	struct path lower_path = ecryptfs_lower_path(dentry);
 	int rc;
 
-	rc = vfs_getattr_nosec(ecryptfs_dentry_to_lower_path(dentry),
-			       &lower_stat, request_mask, flags);
+	rc = vfs_getattr_nosec(&lower_path, &lower_stat, request_mask, flags);
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
 				      ecryptfs_inode_to_lower(d_inode(dentry)));
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index eab1beb846d3..2afbcbbd9546 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -106,15 +106,14 @@ static int ecryptfs_init_lower_file(struct dentry *dentry,
 				    struct file **lower_file)
 {
 	const struct cred *cred = current_cred();
-	const struct path *path = ecryptfs_dentry_to_lower_path(dentry);
+	struct path path = ecryptfs_lower_path(dentry);
 	int rc;
 
-	rc = ecryptfs_privileged_open(lower_file, path->dentry, path->mnt,
-				      cred);
+	rc = ecryptfs_privileged_open(lower_file, path.dentry, path.mnt, cred);
 	if (rc) {
 		printk(KERN_ERR "Error opening lower file "
 		       "for lower_dentry [0x%p] and lower_mnt [0x%p]; "
-		       "rc = [%d]\n", path->dentry, path->mnt, rc);
+		       "rc = [%d]\n", path.dentry, path.mnt, rc);
 		(*lower_file) = NULL;
 	}
 	return rc;
@@ -437,7 +436,6 @@ static int ecryptfs_get_tree(struct fs_context *fc)
 	struct ecryptfs_fs_context *ctx = fc->fs_private;
 	struct ecryptfs_sb_info *sbi = fc->s_fs_info;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
-	struct ecryptfs_dentry_info *root_info;
 	const char *err = "Getting sb failed";
 	struct inode *inode;
 	struct path path;
@@ -543,14 +541,8 @@ static int ecryptfs_get_tree(struct fs_context *fc)
 		goto out_free;
 	}
 
-	rc = -ENOMEM;
-	root_info = kmem_cache_zalloc(ecryptfs_dentry_info_cache, GFP_KERNEL);
-	if (!root_info)
-		goto out_free;
-
-	/* ->kill_sb() will take care of root_info */
-	ecryptfs_set_dentry_private(s->s_root, root_info);
-	root_info->lower_path = path;
+	ecryptfs_set_dentry_lower(s->s_root, path.dentry);
+	sbi->lower_mnt = path.mnt;
 
 	s->s_flags |= SB_ACTIVE;
 	fc->root = dget(s->s_root);
@@ -580,6 +572,7 @@ static void ecryptfs_kill_block_super(struct super_block *sb)
 	kill_anon_super(sb);
 	if (!sb_info)
 		return;
+	mntput(sb_info->lower_mnt);
 	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
 	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
 }
@@ -667,11 +660,6 @@ static struct ecryptfs_cache_info {
 		.name = "ecryptfs_file_cache",
 		.size = sizeof(struct ecryptfs_file_info),
 	},
-	{
-		.cache = &ecryptfs_dentry_info_cache,
-		.name = "ecryptfs_dentry_info_cache",
-		.size = sizeof(struct ecryptfs_dentry_info),
-	},
 	{
 		.cache = &ecryptfs_inode_info_cache,
 		.name = "ecryptfs_inode_cache",
-- 
2.47.2


