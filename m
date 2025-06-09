Return-Path: <linux-fsdevel+bounces-50971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF043AD1845
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55463A7E14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D2280005;
	Mon,  9 Jun 2025 05:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98972137932
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446446; cv=none; b=EpjP04vLF2ck2sIKcRH72lYFGs4bmSzKQ0x2LJn1u0QsXTxL7XRRb14j1ljPwwkVz9T6wuG9YK3u/+njPqPII8vvsAY7AYF8/N6RfV87kl44aJSVfB5AIF8Dhzx+WsPu5sR6y4WimKEI8zwuytYvKOCc7HNzR7OAQFAB5NJma7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446446; c=relaxed/simple;
	bh=cZlCxD1HoQg0Kgr0hiZA4YkR2udavtirpQhAYVHBtI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m790ArYHlVeM6YTrLhDKRv8z3ubSEfMqFIS7/+xEmP/8tGpZFsC1HG9miyBtu2N0hcpw/fCfTTW2vHV+wEFcrG/YwQf7QS7Qof12SiYvUWuINqiF511TTc57Mf3+2O5MlFZGUFQC9O/VRNvTa6zJ8sCz6hhoO6BFM3AYE2J+uIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUw5-006ApK-53;
	Mon, 09 Jun 2025 05:20:41 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] VFS: introduce lookup_and_lock() and friends
Date: Mon,  9 Jun 2025 15:01:13 +1000
Message-ID: <20250609051419.106580-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609051419.106580-1-neil@brown.name>
References: <20250609051419.106580-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_and_lock() combines locking the directory and performing a lookup
prior to a change to the directory.
Abstracting this prepares for changing the locking requirements.

lookup_and_lock_noperm() does the same without needing a mnt_idmap and
without checking permissions.  This is useful for internal filesystem
management (e.g.  creating virtual files in response to events) and in
other cases similar to lookup_noperm().

lookup_and_lock_hashed() also does no permissions checking and assumes
that the hash of the name has already been stored in the qstr.  This is
useful following filename_parentat().

For "silly_rename" we will need to lookup_and_lock() in a directory that
is already locked.  For this purpose we add lookup_and_lock_noperm_locked()
and dentry_unlock_dir_locked().  It is planned for these function to
be removed once locking is performed on the dentry only.

dentry_unlock() provides the inverse of putting the dentry and
unlocking.

Like lookup_one_qstr_excl(), lookup_and_lock() returns -ENOENT if
LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
-EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.

These functions replace all uses of lookup_one_qstr_excl() in namei.c
except for those used for rename.

The name might seem backwards as the lock happens before the lookup.
A future patch will change this so that only a shared lock is taken
before the lookup, and an exclusive lock on the dentry is taken after a
successful lookup.  So the order "lookup" then "lock" will make sense.

Some of the variants should possibly be inlines in a header.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 186 ++++++++++++++++++++++++++++++++----------
 include/linux/namei.h |  11 +++
 2 files changed, 156 insertions(+), 41 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cefbb681d2f5..5e8fe2d78486 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1714,6 +1714,130 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+/**
+ * lookup_and_lock_hashed - lookup and lock a name prior to dir ops
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
+struct dentry *lookup_and_lock_hashed(struct qstr *last,
+				      struct dentry *base,
+				      unsigned int lookup_flags)
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
+EXPORT_SYMBOL(lookup_and_lock_hashed);
+
+static int lookup_noperm_common(struct qstr *qname, struct dentry *base);
+static int lookup_one_common(struct mnt_idmap *idmap,
+			     struct qstr *qname, struct dentry *base);
+struct dentry *lookup_and_lock_noperm_locked(struct qstr *last,
+					     struct dentry *base,
+					     unsigned int lookup_flags)
+{
+	int err;
+
+	err = lookup_noperm_common(last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return lookup_one_qstr_excl(last, base, lookup_flags);
+}
+EXPORT_SYMBOL(lookup_and_lock_noperm_locked);
+
+/**
+ * lookup_and_lock_noperm - lookup and lock a name prior to dir ops
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
+struct dentry *lookup_and_lock_noperm(struct qstr *last,
+				      struct dentry *base,
+				      unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+
+	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+
+	dentry = lookup_and_lock_noperm_locked(last, base, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(base->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(lookup_and_lock_noperm);
+
+/**
+ * lookup_and_lock - lookup and lock a name prior to dir ops
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
+struct dentry *lookup_and_lock(struct mnt_idmap *idmap,
+			       struct qstr *last,
+			       struct dentry *base,
+			       unsigned int lookup_flags)
+{
+	int err;
+
+	err = lookup_one_common(idmap, last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+	return lookup_and_lock_hashed(last, base, lookup_flags);
+}
+EXPORT_SYMBOL(lookup_and_lock);
+
+void dentry_unlock_dir_locked(struct dentry *dentry)
+{
+	d_lookup_done(dentry);
+	dput(dentry);
+}
+EXPORT_SYMBOL(dentry_unlock_dir_locked);
+
+/**
+ * dentry_unlock - unlock a dentry retured by lookup_and_lock()
+ * @dentry - the target dentry
+ *
+ * Reverse the effects of lookup_and_lock() or similar.  If the
+ * @dentry is not an error, the lock and the reference to the dentry
+ * are dropped.
+ */
+void dentry_unlock(struct dentry *dentry)
+{
+	if (!IS_ERR(dentry)) {
+		inode_unlock(dentry->d_parent->d_inode);
+		dentry_unlock_dir_locked(dentry);
+	}
+}
+EXPORT_SYMBOL(dentry_unlock);
+
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
  * @nd: current nameidata
@@ -2756,12 +2880,9 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = lookup_and_lock_hashed(&last, parent_path.dentry, 0);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -2780,12 +2901,9 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = lookup_and_lock_hashed(&last, parent_path.dentry, LOOKUP_CREATE);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -4105,7 +4223,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4117,35 +4234,30 @@ static struct dentry *filename_create(int dfd, struct filename *name,
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
+	dentry = lookup_and_lock_hashed(&last, path->dentry, reval_flag | create_flags);
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
+	dentry_unlock(dentry);
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
@@ -4163,16 +4275,13 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry)) {
-		dput(dentry);
-		inode_unlock(path->dentry->d_inode);
-	}
+	dentry_unlock(dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
 EXPORT_SYMBOL(done_path_create);
 
-inline struct dentry *user_path_create(int dfd, const char __user *pathname,
+struct dentry *user_path_create(int dfd, const char __user *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname(pathname);
@@ -4369,8 +4478,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 err:
 	/* Caller only needs to unlock if dentry is not an error */
-	inode_unlock(dir);
-	dput(dentry);
+	dentry_unlock(dentry);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(vfs_mkdir);
@@ -4500,19 +4608,18 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = lookup_and_lock_hashed(&last, path.dentry, lookup_flags);
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
+	dentry_unlock(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4629,11 +4736,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = lookup_and_lock_hashed(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
 			goto slashes;
@@ -4645,9 +4750,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		dentry_unlock(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..378ee72b57f4 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -80,6 +80,17 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
+struct dentry *lookup_and_lock(struct mnt_idmap *idmap,
+			       struct qstr *last, struct dentry *base,
+			       unsigned int lookup_flags);
+struct dentry *lookup_and_lock_noperm(struct qstr *name, struct dentry *base,
+				      unsigned int lookup_flags);
+struct dentry *lookup_and_lock_noperm_locked(struct qstr *name, struct dentry *base,
+					     unsigned int lookup_flags);
+struct dentry *lookup_and_lock_hashed(struct qstr *last, struct dentry *base,
+				      unsigned int lookup_flags);
+void dentry_unlock(struct dentry *dentry);
+void dentry_unlock_dir_locked(struct dentry *dentry);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
-- 
2.49.0


