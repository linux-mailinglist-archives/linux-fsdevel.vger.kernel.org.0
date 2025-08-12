Return-Path: <linux-fsdevel+bounces-57603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61953B23CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692DC1A23CCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825C2E8893;
	Tue, 12 Aug 2025 23:53:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F42D46C6;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042784; cv=none; b=G7UUeNf3nY1cPVy/GwPbrDJfRVR9hkj8CBS9DEVRUbN/VxExGC38pD6g0EJECSmbd8Wnc2VtZsQEK1SmlX16ZpfPeFPojeSDVE0WftupEPOsroi8WHcB6u6ADozuTFtiWHkVKFvqYse1ZdIy2P3YK2XKM5XwiCMXuyLJzthAXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042784; c=relaxed/simple;
	bh=I90cfJ5hxWQAKE5THF1GA3BmLbMCQgMmZktcIxEsAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qE78BvY6hRnXd/b+pBTZlTbH/NgiKZUaMMoNXONZHPNY2r1obIHEBue9M1b5cGeqj56mEvNmvssabdEHihL/p+jZpUXcDW3+Awg4NHyBpGLrygW0DP3nnKNFi54C/MJGlqci8ROno8hf8zbaWutGMmtUmum1mP/wHpFwMCB/ocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynJ-005Y1w-PX;
	Tue, 12 Aug 2025 23:52:43 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] VFS: introduce dentry_lookup() and friends
Date: Tue, 12 Aug 2025 12:25:05 +1000
Message-ID: <20250812235228.3072318-3-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is the first step in introducing a new API for locked
operation on names in directories.  It supports operations that create or
remove names.  Rename operations will also be part of this new API but
require different specific interfaces.

The plan is to lock just the dentry (or dentries), not the whole
directory.  dentry_lookup() combines locking the directory and
performing a lookup prior to a change to the directory.  On success it
returns a dentry which is consider to be locked, though at this stage
the whole parent directory is actually locked.

dentry_lookup_noperm() does the same without needing a mnt_idmap and
without checking permissions.  This is useful for internal filesystem
management (e.g.  creating virtual files in response to events) and in
other cases similar to lookup_noperm().

__dentry_lookup() is a VFS-internal interface which does no permissions
checking and assumes that the hash of the name has already been stored
in the qstr.  This is useful following filename_parentat().

done_dentry_lookup() is provided which performs the inverse of putting
the dentry and unlocking.

Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
-EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.

These functions replace all uses of lookup_one_qstr_excl() in namei.c
except for those used for rename.

They also allow simple_start_creating() to be simplified into a
static-inline.

A __free() class is provided to allow done_dentry_lookup() to be called
transparently on scope exit.  dget() is extended to ignore ERR_PTR()s
so that "return dget(dentry);" is always safe when dentry was provided
by dentry_lookup() and the variable was declared __free(dentry_lookup).

lookup_noperm_common() and lookup_one_common() are moved earlier in
namei.c.

Note that done_dentry_lookup() can NOT currently be used for vfs_mkdir() as
that function consumes the dentry on error, providing a PTR_ERR instead.
This can be passed to done_dentry_lookup(), but the directory won't be
unlocked.   A future patch will resolve this so done_dentry_lookup() can
be used in done_path_create().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/libfs.c             |  25 -----
 fs/namei.c             | 229 +++++++++++++++++++++++++++++------------
 include/linux/dcache.h |  16 +--
 include/linux/fs.h     |   1 -
 include/linux/namei.h  |  15 +++
 5 files changed, 184 insertions(+), 102 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..f31b80d8de18 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2288,28 +2288,3 @@ void stashed_dentry_prune(struct dentry *dentry)
 	 */
 	cmpxchg(stashed, dentry, NULL);
 }
-
-/* parent must be held exclusive */
-struct dentry *simple_start_creating(struct dentry *parent, const char *name)
-{
-	struct dentry *dentry;
-	struct inode *dir = d_inode(parent);
-
-	inode_lock(dir);
-	if (unlikely(IS_DEADDIR(dir))) {
-		inode_unlock(dir);
-		return ERR_PTR(-ENOENT);
-	}
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		inode_unlock(dir);
-		return dentry;
-	}
-	if (dentry->d_inode) {
-		dput(dentry);
-		inode_unlock(dir);
-		return ERR_PTR(-EEXIST);
-	}
-	return dentry;
-}
-EXPORT_SYMBOL(simple_start_creating);
diff --git a/fs/namei.c b/fs/namei.c
index 62c1e2268942..85b981248a90 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1714,6 +1714,152 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
+{
+	const char *name = qname->name;
+	u32 len = qname->len;
+
+	qname->hash = full_name_hash(base, name, len);
+	if (!len)
+		return -EACCES;
+
+	if (is_dot_dotdot(name, len))
+		return -EACCES;
+
+	while (len--) {
+		unsigned int c = *(const unsigned char *)name++;
+		if (c == '/' || c == '\0')
+			return -EACCES;
+	}
+	/*
+	 * See if the low-level filesystem might want
+	 * to use its own hash..
+	 */
+	if (base->d_flags & DCACHE_OP_HASH) {
+		int err = base->d_op->d_hash(base, qname);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static int lookup_one_common(struct mnt_idmap *idmap,
+			     struct qstr *qname, struct dentry *base)
+{
+	int err;
+	err = lookup_noperm_common(qname, base);
+	if (err < 0)
+		return err;
+	return inode_permission(idmap, base->d_inode, MAY_EXEC);
+}
+
+/**
+ * __dentry_lookup - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode lock on @base.
+ * The name @last is expected to already have the hash calculated.
+ * No permission checks are performed.
+ * This function is for VFS-internal use only.
+ *
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+static struct dentry *__dentry_lookup(struct qstr *last,
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
+
+/**
+ * dentry_lookup_noperm - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode lock on @base.
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
+	return __dentry_lookup(last, base, lookup_flags);
+}
+EXPORT_SYMBOL(dentry_lookup_noperm);
+
+/**
+ * dentry_lookup - lookup and lock a name prior to dir ops
+ * @idmap: idmap of the mount the lookup is performed from
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode lock on @base.
+ * The name @last is NOT expected to already have the hash calculated.
+ * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ *
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
+	return __dentry_lookup(last, base, lookup_flags);
+}
+EXPORT_SYMBOL(dentry_lookup);
+
+/**
+ * done_dentry_lookup - finish a lookup used for create/delete
+ * @dentry:  the target dentry
+ *
+ * Reverse the effects of dentry_lookup() or similar.  If the
+ * @dentry is not an error, the lock and the reference to the dentry
+ * are dropped.
+ *
+ * This interface allows a smooth transition from parent-dir based
+ * locking to dentry based locking.
+ *
+ * This interface is NOT suficient for vfs_mkdir() usage without
+ * extra care as vfs_mkdir() consumes a dentry withouty dropping the lock.
+ */
+void done_dentry_lookup(struct dentry *dentry)
+{
+	if (!IS_ERR(dentry)) {
+		inode_unlock(dentry->d_parent->d_inode);
+		dput(dentry);
+	}
+}
+EXPORT_SYMBOL(done_dentry_lookup);
+
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
  * @nd: current nameidata
@@ -2756,12 +2902,9 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = __dentry_lookup(&last, parent_path.dentry, 0);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -2780,12 +2923,9 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = __dentry_lookup(&last, parent_path.dentry, LOOKUP_CREATE);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -2863,45 +3003,6 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
-{
-	const char *name = qname->name;
-	u32 len = qname->len;
-
-	qname->hash = full_name_hash(base, name, len);
-	if (!len)
-		return -EACCES;
-
-	if (is_dot_dotdot(name, len))
-		return -EACCES;
-
-	while (len--) {
-		unsigned int c = *(const unsigned char *)name++;
-		if (c == '/' || c == '\0')
-			return -EACCES;
-	}
-	/*
-	 * See if the low-level filesystem might want
-	 * to use its own hash..
-	 */
-	if (base->d_flags & DCACHE_OP_HASH) {
-		int err = base->d_op->d_hash(base, qname);
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
-static int lookup_one_common(struct mnt_idmap *idmap,
-			     struct qstr *qname, struct dentry *base)
-{
-	int err;
-	err = lookup_noperm_common(qname, base);
-	if (err < 0)
-		return err;
-	return inode_permission(idmap, base->d_inode, MAY_EXEC);
-}
-
 /**
  * try_lookup_noperm - filesystem helper to lookup single pathname component
  * @name:	qstr storing pathname component to lookup
@@ -4125,7 +4226,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * (foo/., foo/.., /////)
 	 */
 	if (unlikely(type != LAST_NORM))
-		goto out;
+		goto put;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
 	error = mnt_want_write(path->mnt);
@@ -4135,24 +4236,20 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 */
 	if (last.name[last.len] && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+	dentry = __dentry_lookup(&last, path->dentry, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto drop;
 
 	if (unlikely(error))
 		goto fail;
-
 	return dentry;
 fail:
-	dput(dentry);
+	done_dentry_lookup(dentry);
 	dentry = ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
+drop:
 	if (!error)
 		mnt_drop_write(path->mnt);
-out:
+put:
 	path_put(path);
 	return dentry;
 }
@@ -4503,19 +4600,18 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = __dentry_lookup(&last, path.dentry, lookup_flags);
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
@@ -4632,11 +4728,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = __dentry_lookup(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
 			goto slashes;
@@ -4648,9 +4742,8 @@ int do_unlinkat(int dfd, struct filename *name)
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
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index cc3e1c1a3454..5d53489e5556 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -327,13 +327,13 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
  * dget - get a reference to a dentry
  * @dentry: dentry to get a reference to
  *
- * Given a dentry or %NULL pointer increment the reference count
- * if appropriate and return the dentry.  A dentry will not be
- * destroyed when it has references.  Conversely, a dentry with
- * no references can disappear for any number of reasons, starting
- * with memory pressure.  In other words, that primitive is
- * used to clone an existing reference; using it on something with
- * zero refcount is a bug.
+ * Given a dentry, PTR_ERR, or %NULL pointer increment the reference
+ * count if appropriate and return the dentry.  A dentry will not be
+ * destroyed when it has references.  Conversely, a dentry with no
+ * references can disappear for any number of reasons, starting with
+ * memory pressure.  In other words, that primitive is used to clone an
+ * existing reference; using it on something with zero refcount is a
+ * bug.
  *
  * NOTE: it will spin if @dentry->d_lock is held.  From the deadlock
  * avoidance point of view it is equivalent to spin_lock()/increment
@@ -343,7 +343,7 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
  */
 static inline struct dentry *dget(struct dentry *dentry)
 {
-	if (dentry)
+	if (!IS_ERR_OR_NULL(dentry))
 		lockref_get(&dentry->d_lockref);
 	return dentry;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..db644150b58f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3656,7 +3656,6 @@ extern int simple_fill_super(struct super_block *, unsigned long,
 			     const struct tree_descr *);
 extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
 extern void simple_release_fs(struct vfsmount **mount, int *count);
-struct dentry *simple_start_creating(struct dentry *, const char *);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..932cb94c3538 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -80,6 +80,21 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
+struct dentry *dentry_lookup(struct mnt_idmap *idmap,
+			       struct qstr *last, struct dentry *base,
+			       unsigned int lookup_flags);
+struct dentry *dentry_lookup_noperm(struct qstr *name, struct dentry *base,
+				      unsigned int lookup_flags);
+void done_dentry_lookup(struct dentry *dentry);
+/* no_free_ptr() must not be used here - use dget() */
+DEFINE_FREE(dentry_lookup, struct dentry *, if (_T) done_dentry_lookup(_T))
+
+static inline
+struct dentry *simple_start_creating(struct dentry *parent, const char *name)
+{
+	return dentry_lookup_noperm(&QSTR(name), parent,
+				    LOOKUP_CREATE | LOOKUP_EXCL);
+}
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
-- 
2.50.0.107.gf914562f5916.dirty


