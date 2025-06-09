Return-Path: <linux-fsdevel+bounces-50989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B0AD197B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7133B7A489B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A589283125;
	Mon,  9 Jun 2025 08:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C612E7E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456010; cv=none; b=lD3/Z5AyBjGpVYQT4iKsmL1xUVP516FecnNPiidjuLhtUR7r1b2yA40f0HNWj4l51T4uXnq0kZzbJMIiHZIB0wfoQHqpiPVd0e+06jh58AnKKT7I8OxhdshIm5G1HS1s7HxAwAP9hpCZoUYup4FAsGYVfE02iKAeonXO9X/idPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456010; c=relaxed/simple;
	bh=23EZATkXXX8QZ8KT685e73ZsKmsfbISblAVAfzMf1Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwm83msEMqwYmsNIN3Up0DnBc65K4LdARoNNIfIxVV62fdcLZUmZOpSchHkSp9u9m1B/gyDNZSC3q2wjHpHYQEmc4ml60y+/EvqjtEabz5wYVp4gMmUt/7ZKKHTIEGIaPTL2ZdyuLh/c+BzZurofjk+JWMKOvnCzm9sIsqaObG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQL-006HU2-R0;
	Mon, 09 Jun 2025 08:00:05 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] VFS: provide alternative to s_vfs_rename_mutex
Date: Mon,  9 Jun 2025 17:34:11 +1000
Message-ID: <20250609075950.159417-7-neil@brown.name>
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

s_vfs_rename_mutex plays a few different roles in managing renames.

1/ It stablises all ->d_parent pointers in the filesystem so that
   ancestral relationships between the source and target directories
   can be determined.
2/ It prevents any other cross-directory rename so that if the
   source and target directories do not have an ancestral relationship
   then they can be locked in any order without risk if AB-BA deadlock
   with another rename
3/ It prevents any other cross-directory rename so that the validation
   of ancestral relationship between the source and target which ensures
   no loop is created remains in effect until the rename has completed
   in the filesystem.

A future patch will introduce a new locking mechanism that will allow
filesystems to support concurrent directory operations where they do not
directly conflict.  The use of s_vfs_rename_mutex reduces the
opportunity for concurrency so this patch introduces a new mechanism.
The exist mechanism will remain but only be used for filesystems that
haven't advertised support for concurrent operations.

The new mechanism depends on rename_lock and locks against rename only
the ancestors of the two targets that are different.

A/ rename_lock is used to stablise all ->d_parent pointers.  While it is
   held the nearest common ancestor to both targets is found.  If this
   either the source or destination dentry an error is reported.
B/ While still holding rename_lock, DCACHE_RENAME_LOCK is set on all
   dentries from the two targets up to, but not including, the common
   ancestor.  If any already have DCACHE_RENAME_LOCK set, we abort
   before setting the flag anywhere, wait for that dentry to lose
   DCACHE_RENAME_LOCK, then try again.

   DCACHE_RENAME_LOCK ensures that the name and parent of the dentry is
   not changed.  DCACHE_RENAME_LOCK of the whole path up to the common
   ancestor ensures that these paths don't change so the ancestral
   relationship between the two targets don't change.  This ensures that
   no other rename can cause this one to create a path loop.

Waiting for DCACHE_RENAME_LOCK to be cleared uses a single
per-filesystem wait_queue_head.  This is signalled once all
DCACHE_RENAME_LOCK flags have been cleared.  This ensures waiters aren't
woken prematurely if they were only waiting on one other rename.

An important consideration when clearing the DCACHE_RENAME_LOCK flag is that
we do this from child to parent.  As we walk up we need to be sure we
have a valid reference to each dentry.  We will because we have a
counted reference to old_dir and new_dentry.  As none of these
directories are empty they cannot be removed and they cannot be moved
away as long as we continue to hold rename_lock.  So as long as we hold
rename_lock while clearing all the DCACHE_RENAME_LOCK flags we will have a
usable reference through the chain of ->d_parent links.  As soon as
rename_lock is dropped the ancestor and everything below that we do not
have an explicit counted reference on will become inaccessible.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c             | 160 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/dcache.h |   3 +
 include/linux/fs.h     |   8 ++-
 3 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c590f25d0d49..da9ba37f8a93 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3722,6 +3722,151 @@ static void unlock_rename(struct dentry *p1, struct dentry *p2)
 	}
 }
 
+static void wait_not_renaming(struct dentry *d)
+{
+	spin_lock(&d->d_lock);
+	wait_event_cmd(d->d_sb->s_vfs_rename_wq, !(d->d_flags & DCACHE_RENAME_LOCK),
+		       spin_unlock(&d->d_lock), spin_lock(&d->d_lock));
+	spin_unlock(&d->d_lock);
+}
+
+static void renaming_unlock_one(struct dentry *d)
+{
+	spin_lock(&d->d_lock);
+	WARN_ON_ONCE(!(d->d_flags & DCACHE_RENAME_LOCK));
+	d->d_flags &= ~DCACHE_RENAME_LOCK;
+	spin_unlock(&d->d_lock);
+}
+
+static void renaming_unlock(struct dentry *dir1, struct dentry *dir2,
+			    struct dentry *ancestor,
+			    struct dentry *d1, struct dentry *d2)
+{
+	struct dentry *d;
+
+	if (!ancestor)
+		return;
+
+	read_seqlock_excl(&rename_lock);
+	for (d = dir1; d != ancestor; d = d->d_parent)
+		renaming_unlock_one(d);
+	for (d = dir2; d != ancestor; d = d->d_parent)
+		renaming_unlock_one(d);
+	renaming_unlock_one(d1);
+	renaming_unlock_one(d2);
+	read_sequnlock_excl(&rename_lock);
+	/* We don't send any wakeup until all dentries have been unlocked */
+	wake_up(&dir1->d_sb->s_vfs_rename_wq);
+}
+
+/*
+ * Find the nearest common ancestor of d1 and d2, and report
+ * if any of the children of the ancestor which are in the line
+ * to d1 and d2 are locked for rename - have DCACHE_RENAME_LOCK set.
+ */
+static struct dentry *common_ancestor(struct dentry *d1, struct dentry *d2,
+				      struct dentry **locked)
+{
+	struct dentry *p, *q;
+	int depth1 = 0, depth2 = 0;
+
+	*locked = NULL;
+	/* Find depth of each and compare ancestors of equal depth */
+	for (p = d1; !IS_ROOT(p); p = p->d_parent)
+		depth1 += 1;
+	for (q = d2; !IS_ROOT(q); q = q->d_parent)
+		depth2 += 1;
+	if (p != q)
+		/* Different root! */
+		return NULL;
+	while (depth1 > depth2) {
+		if (d1->d_flags & DCACHE_RENAME_LOCK)
+			*locked = d1;
+		d1 = d1->d_parent;
+		depth1 -= 1;
+	}
+	while (depth2 > depth1) {
+		if (d2->d_flags & DCACHE_RENAME_LOCK)
+			*locked = d2;
+		d2 = d2->d_parent;
+		depth2 -= 1;
+	}
+	while (d1 != d2) {
+		if (d1->d_flags & DCACHE_RENAME_LOCK)
+			*locked = d1;
+		if (d2->d_flags & DCACHE_RENAME_LOCK)
+			*locked = d2;
+		d1 = d1->d_parent;
+		d2 = d2->d_parent;
+	}
+	return d1;
+}
+
+/*
+ * Lock all ancestors below nearest common ancestor for rename
+ * Returns:
+ *    -EXDEV if there is no common ancestor
+ *    -EINVAL if the first dentry is the common ancestor -
+ *		you cannot move a directory into a descendent
+ *    -ENOTEMPTY if the second dentry is the common ancestor -
+ *		the target directory must usually be empty.
+ * Note that these errors might be adjusted for RENAME_EXCHANGE
+ *
+ * The ancestors will be locked against rename, and no directory between
+ * either target and the ancestor will be the ancestor of an active
+ * rename.  This ensures that the common ancestor will continue to be
+ * the common ancestor, and that there will be no concurrent rename with
+ * the same ancestor.
+ */
+static struct dentry *lock_ancestors(struct dentry *d1, struct dentry *d2)
+{
+	struct dentry *locked, *ancestor;
+
+	if (d1->d_parent == d2->d_parent)
+		/* Nothing to lock */
+		return NULL;
+again:
+	read_seqlock_excl(&rename_lock);
+	ancestor = common_ancestor(d1, d2, &locked);
+	if (!ancestor) {
+		read_sequnlock_excl(&rename_lock);
+		return ERR_PTR(-EXDEV);
+	}
+	if (ancestor == d1) {
+		read_sequnlock_excl(&rename_lock);
+		return ERR_PTR(-EINVAL);
+	}
+	if (ancestor == d2) {
+		read_sequnlock_excl(&rename_lock);
+		return ERR_PTR(-ENOTEMPTY);
+	}
+	if (locked) {
+		dget(locked);
+		read_sequnlock_excl(&rename_lock);
+		wait_not_renaming(locked);
+		dput(locked);
+		goto again;
+	}
+	/*
+	 * Nothing from d1,d2 up to ancestor can have DCACHE_RENAME_LOCK
+	 * as we hold rename_lock and nothing was reported in "locked".
+	 */
+	while (d1 != ancestor) {
+		spin_lock(&d1->d_lock);
+		d1->d_flags |= DCACHE_RENAME_LOCK;
+		spin_unlock(&d1->d_lock);
+		d1 = d1->d_parent;
+	}
+	while (d2 != ancestor) {
+		spin_lock(&d2->d_lock);
+		d2->d_flags |= DCACHE_RENAME_LOCK;
+		spin_unlock(&d2->d_lock);
+		d2 = d2->d_parent;
+	}
+	read_sequnlock_excl(&rename_lock);
+	return ancestor;
+}
+
 /**
  * lookup_and_lock_rename_hashed - lookup and lock names for rename
  * @rd:           rename data containing relevant details
@@ -3753,7 +3898,7 @@ static void unlock_rename(struct dentry *p1, struct dentry *p2)
 int
 lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 {
-	struct dentry *p;
+	struct dentry *p, *ancestor;
 	struct dentry *d1, *d2;
 	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 	int err;
@@ -3811,8 +3956,17 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 		goto out_unlock_3;
 	}
 
+	ancestor = lock_ancestors(d1, d2);
+	if (IS_ERR(ancestor)) {
+		err = PTR_ERR(ancestor);
+		if (err == -ENOTEMPTY && (rd->flags & RENAME_EXCHANGE))
+			err = -EINVAL;
+		goto out_unlock_3;
+	}
+
 	rd->old_dentry = d1;
 	rd->new_dentry = d2;
+	rd->ancestor = ancestor;
 	return 0;
 
 out_unlock_3:
@@ -3934,6 +4088,10 @@ void dentry_unlock_rename(struct renamedata *rd)
 {
 	d_lookup_done(rd->old_dentry);
 	d_lookup_done(rd->new_dentry);
+
+	renaming_unlock(rd->old_dir, rd->new_dir, rd->ancestor,
+			rd->old_dentry, rd->new_dentry);
+
 	unlock_rename(rd->old_dir, rd->new_dir);
 	dput(rd->old_dir);
 	dput(rd->old_dentry);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2c7a2326367b..27e645d290b1 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -226,6 +226,9 @@ enum dentry_flags {
 	DCACHE_PAR_LOOKUP		= BIT(24),	/* being looked up (with parent locked shared) */
 	DCACHE_DENTRY_CURSOR		= BIT(25),
 	DCACHE_NORCU			= BIT(26),	/* No RCU delay for freeing */
+	DCACHE_RENAME_LOCK		= BIT(27),	/* A directory is being renamed
+							 * into or out-of this tree
+							 */
 };
 
 #define DCACHE_MANAGED_DENTRY \
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7fa38668987..6b4a1a1f4786 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1402,10 +1402,11 @@ struct super_block {
 	unsigned int		s_max_links;
 
 	/*
-	 * The next field is for VFS *only*. No filesystems have any business
-	 * even looking at it. You had been warned.
+	 * The next two fields are for VFS *only*. No filesystems have any business
+	 * even looking at them. You had been warned.
 	 */
 	struct mutex s_vfs_rename_mutex;	/* Kludge */
+	struct wait_queue_head s_vfs_rename_wq;	/* waiting for DCACHE_RENAME_LOCK to clear */
 
 	/*
 	 * Filesystem subtype.  If non-empty the filesystem type field
@@ -2012,6 +2013,8 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
  * @new_dentry:                destination
  * @new_last:          name for new_dentry in new_dir, if new_dentry not given
  * @delegated_inode:   returns an inode needing a delegation break
+ * @ancestor:          Closest common ancestor of @old_dir and @new_dir if those
+ *                     two are differernt.
  * @flags:             rename flags
  */
 struct renamedata {
@@ -2024,6 +2027,7 @@ struct renamedata {
 	struct dentry *new_dentry;
 	struct qstr new_last;
 	struct inode **delegated_inode;
+	struct dentry *ancestor;
 	unsigned int flags;
 } __randomize_layout;
 
-- 
2.49.0


