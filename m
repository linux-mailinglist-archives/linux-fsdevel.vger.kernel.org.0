Return-Path: <linux-fsdevel+bounces-50991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FDAD197D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E547A4806
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B228313A;
	Mon,  9 Jun 2025 08:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85222820C6
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456010; cv=none; b=cuXMkIPE4O3zdiZhIH5WIvSe1s56HW8wnqD6rQaWPMEk8ocDelkKjFHsGbG4H2sx0UHoer30UqjmKaZE0PTaSS1RnSWlfhZhINhZUW3Vbkk8zcA3n62o7G5VsxXtiExVrP9jthaYhdG6LhZ8VxMyHDpopCCiHOifcS6n7uR8oMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456010; c=relaxed/simple;
	bh=JV7unuyDjiWrdNMrRhC5Mv/zXIzHNxtgSoH+D67dfrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7HAkz3rwAJyZl7V0bfZwAO1cq3mGPpgjf//97d35IoPrS/QzcJJFa3lf56vNFRGSZiZWAh/E/s63PxgjhKDpVckCACANUsF2Gj5yQhPORX5uESyuww7RB4bY2sUlEgi/bPJjEoWsZ9o7KDsU61Bm3szj5jeyn08b0JiU54O4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQM-006HUJ-Rs;
	Mon, 09 Jun 2025 08:00:06 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] VFS: allow a filesystem to opt out of directory locking.
Date: Mon,  9 Jun 2025 17:34:13 +1000
Message-ID: <20250609075950.159417-9-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609075950.159417-1-neil@brown.name>
References: <20250609075950.159417-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VFS no longer needs the directory to be locked when performing
updates in the directory (create/remove/rename).  We only lock
directories during these ops because the filesystem might expect that.
Some filesystems may not need it.  Allow the filesystem to opt out by
setting no_dir_lock in inode_operations.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c         | 75 ++++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |  1 +
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5c9279657b32..55ea67b4f891 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2001,7 +2001,8 @@ struct dentry *lookup_and_lock_hashed(struct qstr *last,
 {
 	struct dentry *dentry;
 
-	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+	if (!d_inode(base)->i_op->no_dir_lock)
+		inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
 
 retry:
 	dentry = lookup_one_qstr(last, base, lookup_flags);
@@ -2011,7 +2012,8 @@ struct dentry *lookup_and_lock_hashed(struct qstr *last,
 		goto retry;
 	}
 
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry) &&
+	    !d_inode(base)->i_op->no_dir_lock)
 		inode_unlock(base->d_inode);
 	return dentry;
 }
@@ -2066,11 +2068,13 @@ struct dentry *lookup_and_lock_noperm(struct qstr *last,
 {
 	struct dentry *dentry;
 
-	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+	if (!d_inode(base)->i_op->no_dir_lock)
+		inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
 
 	dentry = lookup_and_lock_noperm_locked(last, base, lookup_flags,
 					       DLOCK_NORMAL);
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry) &&
+	    !d_inode(base)->i_op->no_dir_lock)
 		inode_unlock(base->d_inode);
 	return dentry;
 }
@@ -2097,9 +2101,11 @@ struct dentry *lookup_and_lock_noperm_nested(struct qstr *last,
 {
 	struct dentry *dentry;
 
-	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+	if (!d_inode(base)->i_op->no_dir_lock)
+		inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
 	dentry = lookup_and_lock_noperm_locked(last, base, lookup_flags, class);
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry) &&
+	    !d_inode(base)->i_op->no_dir_lock)
 		inode_unlock(base->d_inode);
 	return dentry;
 }
@@ -2160,9 +2166,12 @@ struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 	struct dentry *dentry;
 	int err;
 
-	err = down_write_killable_nested(&base->d_inode->i_rwsem, I_MUTEX_PARENT);
-	if (err)
-		return ERR_PTR(err);
+	if (!d_inode(base)->i_op->no_dir_lock) {
+		err = down_write_killable_nested(&base->d_inode->i_rwsem,
+						 I_MUTEX_PARENT);
+		if (err)
+			return ERR_PTR(err);
+	}
 	err = lookup_one_common(idmap, last, base);
 	if (err < 0)
 		return ERR_PTR(err);
@@ -2176,7 +2185,8 @@ struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 			return ERR_PTR(-ERESTARTSYS);
 		goto retry;
 	}
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry) &&
+	    !d_inode(base)->i_op->no_dir_lock)
 		inode_unlock(base->d_inode);
 	return dentry;
 }
@@ -2205,7 +2215,8 @@ bool lock_and_check_dentry(struct dentry *child, struct dentry *parent)
 	}
 	/* get the child to balance with dentry_unlock() which puts it. */
 	dget(child);
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	if (!d_inode(parent)->i_op->no_dir_lock)
+		inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	return true;
 }
 EXPORT_SYMBOL(lock_and_check_dentry);
@@ -2230,7 +2241,8 @@ void dentry_unlock(struct dentry *dentry)
 {
 	if (!IS_ERR(dentry)) {
 		d_lookup_done(dentry);
-		inode_unlock(dentry->d_parent->d_inode);
+		if (!dentry->d_parent->d_inode->i_op->no_dir_lock)
+			inode_unlock(dentry->d_parent->d_inode);
 		dentry_unlock_dir_locked(dentry);
 	}
 }
@@ -2342,9 +2354,11 @@ static struct dentry *lookup_slow(const struct qstr *name,
 {
 	struct inode *inode = dir->d_inode;
 	struct dentry *res;
-	inode_lock_shared(inode);
+	if (!inode->i_op->no_dir_lock)
+		inode_lock_shared(inode);
 	res = __lookup_slow(name, dir, flags);
-	inode_unlock_shared(inode);
+	if (!inode->i_op->no_dir_lock)
+		inode_unlock_shared(inode);
 	return res;
 }
 
@@ -3721,6 +3735,9 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
  */
 static struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 {
+	if (d_inode(p1)->i_op->no_dir_lock)
+		return NULL;
+
 	if (p1 == p2) {
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
 		return NULL;
@@ -3735,6 +3752,9 @@ static struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
  */
 static struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 {
+	if (d_inode(c1)->i_op->no_dir_lock)
+		return NULL;
+
 	if (READ_ONCE(c1->d_parent) == p2) {
 		/*
 		 * hopefully won't need to touch ->s_vfs_rename_mutex at all.
@@ -3773,6 +3793,8 @@ static struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 
 static void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
+	if (d_inode(p1)->i_op->no_dir_lock)
+		return;
 	inode_unlock(p1->d_inode);
 	if (p1 != p2) {
 		inode_unlock(p2->d_inode);
@@ -3880,6 +3902,10 @@ static struct dentry *lock_ancestors(struct dentry *d1, struct dentry *d2)
 {
 	struct dentry *locked, *ancestor;
 
+	if (!d_inode(d1)->i_op->no_dir_lock)
+		/* s_vfs_rename_mutex is being used, so skip this locking */
+		return NULL;
+
 	if (d1->d_parent == d2->d_parent)
 		/* Nothing to lock */
 		return NULL;
@@ -4194,6 +4220,7 @@ void dentry_unlock_rename(struct renamedata *rd)
 	renaming_unlock(rd->old_dir, rd->new_dir, rd->ancestor,
 			rd->old_dentry, rd->new_dentry);
 
+	if (!d_inode(rd->old_dir)->i_op->no_dir_lock)
 	unlock_rename(rd->old_dir, rd->new_dir);
 
 	dput(rd->old_dir);
@@ -4697,19 +4724,23 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
+	if (!d_inode(dir)->i_op->no_dir_lock) {
+		if (open_flag & O_CREAT)
+			inode_lock(dir->d_inode);
+		else
+			inode_lock_shared(dir->d_inode);
+	}
 	dentry = lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
-	if (open_flag & O_CREAT)
-		inode_unlock(dir->d_inode);
-	else
-		inode_unlock_shared(dir->d_inode);
+	if (!d_inode(dir)->i_op->no_dir_lock) {
+		if (open_flag & O_CREAT)
+			inode_unlock(dir->d_inode);
+		else
+			inode_unlock_shared(dir->d_inode);
+	}
 
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6b4a1a1f4786..b213993c486a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,6 +2225,7 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
 	{ return wrap_directory_iterator(file, ctx, x); }
 
 struct inode_operations {
+	bool no_dir_lock:1;
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct mnt_idmap *, struct inode *, int);
-- 
2.49.0


