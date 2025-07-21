Return-Path: <linux-fsdevel+bounces-55571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E89B0BF5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31773AB0DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7996628A73D;
	Mon, 21 Jul 2025 08:45:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14622877CE;
	Mon, 21 Jul 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087541; cv=none; b=rvqT9OcVcN2JGprLgt0JCRkq0gCcy3a+sxzHVdEPERrZnxOsZQAYzuJGuIneRjFNP2k76e+Q09sw8sWaQNp9Ji9dMWwbL/sN7/NUO9MxaJPkzVwtIUJxBRkKQvp4J5KZfr6fQZpmm92GEnPvSL8p+OkhXdcrMCfKL3+4G8Kr2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087541; c=relaxed/simple;
	bh=kBTj7AdWspoKHj3j/tvxPQIpm3IgCWJH09T6ATNv6O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2Ol/S33yEelfmelqzfyRgN3NSKQjzusNmYZOIb9fpaK9qtOqVO3RuSlQnFhAm5ul1PWqFUqj0iB7uUaRMt5T6ORPCA8yqQpFZiDTVYvjBVWdlVa8xnz3/1tiuDLHOt+de0KWi435rAIiwAOBw61bhmNas8sgahcgANR5RJ0350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9H-002pfv-E4;
	Mon, 21 Jul 2025 08:45:29 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] VFS: introduce dentry_lookup() and friends
Date: Mon, 21 Jul 2025 18:00:00 +1000
Message-ID: <20250721084412.370258-5-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721084412.370258-1-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dentry_lookup() combines locking the directory and performing a lookup
prior to a change to the directory.
Abstracting this prepares for changing the locking requirements.

dentry_lookup_noperm() does the same without needing a mnt_idmap and
without checking permissions.  This is useful for internal filesystem
management (e.g.  creating virtual files in response to events) and in
other cases similar to lookup_noperm().

dentry_lookup_hashed() also does no permissions checking and assumes
that the hash of the name has already been stored in the qstr.  This is
useful following filename_parentat().

These are intended to be paired with done_dentry_lookup() which provides
the inverse of putting the dentry and unlocking.

Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
-EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.

These functions replace all uses of lookup_one_qstr_excl() in namei.c
except for those used for rename.

Some of the variants should possibly be inlines in a header.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 158 ++++++++++++++++++++++++++++++------------
 include/linux/namei.h |   8 ++-
 2 files changed, 119 insertions(+), 47 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 950a0d0d54da..f292df61565a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1714,17 +1714,98 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+/**
+ * dentry_lookup_hashed - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode node lock on @base.
+ * The name @last is expected to already have the hash calculated.
+ * No permission checks are performed.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *dentry_lookup_hashed(struct qstr *last,
+				    struct dentry *base,
+				    unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+
+	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+
+	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(base->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(dentry_lookup_hashed);
+
+static int lookup_noperm_common(struct qstr *qname, struct dentry *base);
+static int lookup_one_common(struct mnt_idmap *idmap,
+			     struct qstr *qname, struct dentry *base);
+
+/**
+ * dentry_lookup_noperm - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode node lock on @base.
+ * The name @last is NOT expected to have the hash calculated.
+ * No permission checks are performed.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *dentry_lookup_noperm(struct qstr *last,
+				    struct dentry *base,
+				    unsigned int lookup_flags)
+{
+	int err;
+
+	err = lookup_noperm_common(last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+	return dentry_lookup_hashed(last, base, lookup_flags);
+}
+EXPORT_SYMBOL(dentry_lookup_noperm);
+
+/**
+ * dentry_lookup - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode node lock on @base.
+ * The name @last is NOT expected to already have the hash calculated.
+ * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *dentry_lookup(struct mnt_idmap *idmap,
+			     struct qstr *last,
+			     struct dentry *base,
+			     unsigned int lookup_flags)
+{
+	int err;
+
+	err = lookup_one_common(idmap, last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+	return dentry_lookup_hashed(last, base, lookup_flags);
+}
+EXPORT_SYMBOL(dentry_lookup);
+
 /**
  * done_dentry_lookup - finish a lookup used for create/delete
  * @dentry:  the target dentry
  *
- * After locking the directory and lookup or validating a dentry
- * an attempt can be made to create (including link) or remove (including
- * rmdir) a dentry.  After this, done_dentry_lookup() can be used to both
- * unlock the parent directory and dput() the dentry.
- *
- * If the dentry is an error - as can happen after vfs_mkdir() -
- * the unlock is skipped as unneeded.
+ * Reverse the effects of dentry_lookup() or similar.  If the
+ * @dentry is not an error, the lock and the reference to the dentry
+ * are dropped.
  *
  * This interface allows a smooth transition from parent-dir based
  * locking to dentry based locking.
@@ -1733,6 +1814,7 @@ void done_dentry_lookup(struct dentry *dentry)
 {
 	if (!IS_ERR(dentry)) {
 		inode_unlock(dentry->d_parent->d_inode);
+		d_lookup_done(dentry);
 		dput(dentry);
 	}
 }
@@ -1742,16 +1824,16 @@ EXPORT_SYMBOL(done_dentry_lookup);
  * done_dentry_lookup_return - finish a lookup sequence, returning the dentry
  * @dentry:  the target dentry
  *
- * After locking the directory and lookup or validating a dentry
- * an attempt can be made to create (including link) or remove (including
- * rmdir) a dentry.  After this, done_dentry_lookup_return() can be used to
- * unlock the parent directory.  The dentry is returned for further use.
+ * Reverse the effects of dentry_lookup() or similar, but keep the dentry.
+ * If @dentry is not an error, the lock is dropped.
  *
  * If the dentry is an error - as can happen after vfs_mkdir() -
  * the unlock is skipped as unneeded.
  *
  * This interface allows a smooth transition from parent-dir based
  * locking to dentry based locking.
+ *
+ * Returns: the dentry.
  */
 struct dentry *done_dentry_lookup_return(struct dentry *dentry)
 {
@@ -2803,12 +2885,9 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = dentry_lookup_hashed(&last, parent_path.dentry, 0);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -2827,12 +2906,9 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = dentry_lookup_hashed(&last, parent_path.dentry, LOOKUP_CREATE);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -4161,7 +4237,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4173,35 +4248,30 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * (foo/., foo/.., /////)
 	 */
 	if (unlikely(type != LAST_NORM))
-		goto out;
+		goto put;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
-	err2 = mnt_want_write(path->mnt);
+	error = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
 	if (last.name[last.len] && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+	dentry = dentry_lookup_hashed(&last, path->dentry, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto drop;
 
-	if (unlikely(err2)) {
-		error = err2;
+	if (unlikely(error))
 		goto fail;
-	}
 	return dentry;
 fail:
-	dput(dentry);
+	done_dentry_lookup(dentry);
 	dentry = ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
-	if (!err2)
+drop:
+	if (!error)
 		mnt_drop_write(path->mnt);
-out:
+put:
 	path_put(path);
 	return dentry;
 }
@@ -4225,7 +4295,7 @@ void done_path_create(struct path *path, struct dentry *dentry)
 }
 EXPORT_SYMBOL(done_path_create);
 
-inline struct dentry *user_path_create(int dfd, const char __user *pathname,
+struct dentry *user_path_create(int dfd, const char __user *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname(pathname);
@@ -4551,19 +4621,18 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = dentry_lookup_hashed(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
+
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
-	dput(dentry);
+	done_dentry_lookup(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4680,11 +4749,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = dentry_lookup_hashed(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
 			goto slashes;
@@ -4696,9 +4763,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		done_dentry_lookup(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e097f11587c9..6d2cf4af5f16 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -80,7 +80,13 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
-
+struct dentry *dentry_lookup(struct mnt_idmap *idmap,
+			       struct qstr *last, struct dentry *base,
+			       unsigned int lookup_flags);
+struct dentry *dentry_lookup_noperm(struct qstr *name, struct dentry *base,
+				      unsigned int lookup_flags);
+struct dentry *dentry_lookup_hashed(struct qstr *last, struct dentry *base,
+				      unsigned int lookup_flags);
 void done_dentry_lookup(struct dentry *dentry);
 struct dentry *done_dentry_lookup_return(struct dentry *dentry);
 
-- 
2.49.0


