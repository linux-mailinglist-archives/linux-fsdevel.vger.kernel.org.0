Return-Path: <linux-fsdevel+bounces-50990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A68AD197C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D103AA3F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6C2820A8;
	Mon,  9 Jun 2025 08:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC22820A5
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456010; cv=none; b=bqGpOZkK7qDZqeK5P3jPSp1A2gSvGtaxYzD4iigodZkAsWENG+CS3g9dAdpdkL+unojB8EKwfNP6aJfG96sBRB+PUT3HXXHz1GKYnEQsEZFL4/1XfGADmdwkt/joucrPqnlIjXqHao0r0UTOeyw44uuzFUrwwWunvf6s5UPpPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456010; c=relaxed/simple;
	bh=8mzvmF3/dXUhgeORYVFi+lJppKcpzmmfZX9SmDy53jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnUZKsNPSYapA8ArtcqDE2HzHaVjzZLo+Wt4OaDw4VfhiIrVMCIChf7uU8bnhWe4lfdJS79uOQUPg70ns3+PPgvS6Jbfd75fZe2DxDJExPyNKdIt+tDLXMrKK+wHl0hTl44qZfqeOdxbZPTRPCHKoPo9g+SKKSSQNahJw95XsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQM-006HUD-Bk;
	Mon, 09 Jun 2025 08:00:06 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] VFS: use new dentry locking for create/remove/rename
Date: Mon,  9 Jun 2025 17:34:12 +1000
Message-ID: <20250609075950.159417-8-neil@brown.name>
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

After taking the directory lock (or locks) we now lock the target
dentries.  This is pointless at present but will allow us to remove the
taking of the directory lock in a future patch.

MORE WORDS

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c           |   3 +-
 fs/afs/dir_silly.c     |   2 +-
 fs/namei.c             | 140 ++++++++++++++++++++++++++++++++++++-----
 fs/nfs/unlink.c        |   2 +-
 include/linux/dcache.h |   3 +
 include/linux/namei.h  |   4 +-
 6 files changed, 133 insertions(+), 21 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 421bd044f8c9..da30700c0106 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -943,7 +943,8 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_and_lock_noperm_locked(&QSTR(buf), dentry->d_parent);
+		ret = lookup_and_lock_noperm_locked(&QSTR(buf), dentry->d_parent, 0,
+						    DLOCK_SUB_LOOKUP);
 		if (!IS_ERR(ret) && d_is_positive(ret))
 			dget(ret);
 		dentry_unlock(ret);
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 68e38429cf49..d25353fab18c 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -120,7 +120,7 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 		scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
 		sdentry = lookup_and_lock_noperm_locked(
 			&QSTR(silly), dentry->d_parent,
-			LOOKUP_CREATE | LOOKUP_EXCL);
+			LOOKUP_CREATE | LOOKUP_EXCL, DLOCK_SUB_LOOKUP);
 
 		/* N.B. Better to return EBUSY here ... it could be dangerous
 		 * to delete the file while it's in use.
diff --git a/fs/namei.c b/fs/namei.c
index da9ba37f8a93..5c9279657b32 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1723,6 +1723,7 @@ static struct dentry *lookup_one_qstr(const struct qstr *name,
 	}
 	return dentry;
 }
+
 /*
  * dentry locking for updates.
  * When modifying a directory the target dentry will be locked by
@@ -1856,7 +1857,6 @@ static bool dentry_lock(struct dentry *dentry,
 	return __dentry_lock(dentry, base, last, DLOCK_NORMAL, state);
 }
 
-__maybe_unused /* will be used for rename */
 static bool dentry_lock_nested(struct dentry *dentry,
 			       struct dentry *base, const struct qstr *last,
 			       int state)
@@ -2003,7 +2003,14 @@ struct dentry *lookup_and_lock_hashed(struct qstr *last,
 
 	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
 
+retry:
 	dentry = lookup_one_qstr(last, base, lookup_flags);
+	if (!IS_ERR(dentry) &&
+	    !dentry_lock(dentry, base, last, TASK_UNINTERRUPTIBLE)) {
+		dput(dentry);
+		goto retry;
+	}
+
 	if (IS_ERR(dentry))
 		inode_unlock(base->d_inode);
 	return dentry;
@@ -2015,15 +2022,25 @@ static int lookup_one_common(struct mnt_idmap *idmap,
 			     struct qstr *qname, struct dentry *base);
 struct dentry *lookup_and_lock_noperm_locked(struct qstr *last,
 					     struct dentry *base,
-					     unsigned int lookup_flags)
+					     unsigned int lookup_flags,
+					     unsigned int class)
 {
+	struct dentry *dentry;
 	int err;
 
 	err = lookup_noperm_common(last, base);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	return lookup_one_qstr(last, base, lookup_flags);
+retry:
+	dentry = lookup_one_qstr(last, base, lookup_flags);
+	if (!IS_ERR(dentry) &&
+	    !__dentry_lock(dentry, base, last, class,
+			   TASK_UNINTERRUPTIBLE)) {
+		dput(dentry);
+		goto retry;
+	}
+	return dentry;
 }
 EXPORT_SYMBOL(lookup_and_lock_noperm_locked);
 
@@ -2051,13 +2068,43 @@ struct dentry *lookup_and_lock_noperm(struct qstr *last,
 
 	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
 
-	dentry = lookup_and_lock_noperm_locked(last, base, lookup_flags);
+	dentry = lookup_and_lock_noperm_locked(last, base, lookup_flags,
+					       DLOCK_NORMAL);
 	if (IS_ERR(dentry))
 		inode_unlock(base->d_inode);
 	return dentry;
 }
 EXPORT_SYMBOL(lookup_and_lock_noperm);
 
+/**
+ * lookup_and_lock_nested_noperm - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ * @class: locking subclass for lock on dentry
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode node lock on @base.
+ * The name @last is NOT expected to have the hash calculated.
+ * No permission checks are performed.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *lookup_and_lock_noperm_nested(struct qstr *last,
+					     struct dentry *base,
+					     unsigned int lookup_flags,
+					     unsigned int class)
+{
+	struct dentry *dentry;
+
+	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+	dentry = lookup_and_lock_noperm_locked(last, base, lookup_flags, class);
+	if (IS_ERR(dentry))
+		inode_unlock(base->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(lookup_and_lock_noperm_nested);
+
 /**
  * lookup_and_lock - lookup and lock a name prior to dir ops
  * @last: the name in the given directory
@@ -2120,7 +2167,15 @@ struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 	if (err < 0)
 		return ERR_PTR(err);
 
+retry:
 	dentry = lookup_one_qstr(last, base, lookup_flags);
+	if (!IS_ERR(dentry) &&
+	    !dentry_lock(dentry, base, last, TASK_KILLABLE)) {
+		dput(dentry);
+		if (fatal_signal_pending(current))
+			return ERR_PTR(-ERESTARTSYS);
+		goto retry;
+	}
 	if (IS_ERR(dentry))
 		inode_unlock(base->d_inode);
 	return dentry;
@@ -2142,20 +2197,23 @@ EXPORT_SYMBOL(lookup_and_lock_killable);
  */
 bool lock_and_check_dentry(struct dentry *child, struct dentry *parent)
 {
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	if (child->d_parent == parent) {
-		/* get the child to balance with dentry_unlock which puts it. */
-		dget(child);
-		return true;
+	if (!dentry_lock(child, NULL, NULL, TASK_UNINTERRUPTIBLE))
+		return false;
+	if (child->d_parent != parent) {
+		__dentry_unlock(child);
+		return false;
 	}
-	inode_unlock(d_inode(parent));
-	return false;
+	/* get the child to balance with dentry_unlock() which puts it. */
+	dget(child);
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	return true;
 }
 EXPORT_SYMBOL(lock_and_check_dentry);
 
 void dentry_unlock_dir_locked(struct dentry *dentry)
 {
 	d_lookup_done(dentry);
+	__dentry_unlock(dentry);
 	dput(dentry);
 }
 EXPORT_SYMBOL(dentry_unlock_dir_locked);
@@ -3900,7 +3958,10 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 {
 	struct dentry *p, *ancestor;
 	struct dentry *d1, *d2;
+	struct dentry *old_dir;
+	struct qstr *old_last = NULL, *new_last = NULL;
 	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	bool ok1, ok2;
 	int err;
 
 	if (rd->flags & RENAME_EXCHANGE)
@@ -3908,6 +3969,7 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 	if (rd->flags & RENAME_NOREPLACE)
 		target_flags |= LOOKUP_EXCL;
 
+retry:
 	if (rd->old_dentry) {
 		/* Already have the dentry - need to be sure to lock the correct parent */
 		p = lock_rename_child(rd->old_dentry, rd->new_dir);
@@ -3926,19 +3988,17 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 		d1 = lookup_one_qstr(&rd->old_last, rd->old_dir, lookup_flags);
 		if (IS_ERR(d1))
 			goto out_unlock_1;
+		old_last = &rd->old_last;
 	}
+
 	if (rd->new_dentry) {
-		if (d_unhashed(rd->new_dentry) ||
-		    rd->new_dentry->d_parent != rd->new_dir) {
-			/* new_dentry was moved or removed! */
-			goto out_unlock_2;
-		}
 		d2 = dget(rd->new_dentry);
 	} else {
 		d2 = lookup_one_qstr(&rd->new_last, rd->new_dir,
 				     lookup_flags | target_flags);
 		if (IS_ERR(d2))
 			goto out_unlock_2;
+		new_last = &rd->new_last;
 	}
 
 	if (d1 == p) {
@@ -3964,6 +4024,44 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 		goto out_unlock_3;
 	}
 
+	if (!old_dir)
+		old_dir = dget(d1->d_parent);
+
+	/*
+	 * Time to lock the dentrys.  Only validate the name if a lookup
+	 * was performed.  i.e.  if old_last or new_last is not NULL.
+	 */
+	if (d1 < d2) {
+		ok1 = dentry_lock(d1, rd->old_dir, old_last,
+				  TASK_UNINTERRUPTIBLE);
+		ok2 = dentry_lock_nested(d2, rd->new_dir, new_last,
+					 TASK_UNINTERRUPTIBLE);
+	} else if (d1 > d2) {
+		ok2 = dentry_lock(d2, rd->new_dir, new_last,
+				  TASK_UNINTERRUPTIBLE);
+		ok1 = dentry_lock_nested(d1, rd->old_dir, old_last,
+					 TASK_UNINTERRUPTIBLE);
+	} else {
+		ok1 = ok2 = dentry_lock(d1, NULL, NULL, TASK_UNINTERRUPTIBLE);
+	}
+
+	if (!ok1 || !ok2) {
+		if (ok1)
+			__dentry_unlock(d1);
+		if (ok2)
+			__dentry_unlock(d2);
+		d_lookup_done(d1);
+		d_lookup_done(d2);
+		renaming_unlock(old_dir, rd->new_dir, ancestor,
+				d1, d2);
+		unlock_rename(rd->old_dir, rd->new_dir);
+		dput(d1);
+		dput(d2);
+		dput(old_dir);
+		goto retry;
+	}
+
+	rd->old_dir = old_dir;
 	rd->old_dentry = d1;
 	rd->new_dentry = d2;
 	rd->ancestor = ancestor;
@@ -3971,15 +4069,19 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 
 out_unlock_3:
 	d_lookup_done(d2);
+	if (d2 != d1)
+		__dentry_unlock(d2);
 	dput(d2);
 	d2 = ERR_PTR(err);
+	d_lookup_done(d1);
+	__dentry_unlock(d1);
 out_unlock_2:
 	d_lookup_done(d1);
 	dput(d1);
 	d1 = d2;
 out_unlock_1:
 	unlock_rename(rd->old_dir, rd->new_dir);
-	dput(rd->old_dir);
+	dput(old_dir);
 	return PTR_ERR(d1);
 }
 EXPORT_SYMBOL(lookup_and_lock_rename_hashed);
@@ -4093,8 +4195,12 @@ void dentry_unlock_rename(struct renamedata *rd)
 			rd->old_dentry, rd->new_dentry);
 
 	unlock_rename(rd->old_dir, rd->new_dir);
+
 	dput(rd->old_dir);
+	__dentry_unlock(rd->old_dentry);
 	dput(rd->old_dentry);
+	if (rd->old_dentry != rd->new_dentry)
+		__dentry_unlock(rd->new_dentry);
 	dput(rd->new_dentry);
 }
 EXPORT_SYMBOL(dentry_unlock_rename);
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index a67df3ae74ab..4ac3e3195a45 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -476,7 +476,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 		 */
 		sdentry = lookup_and_lock_noperm_locked(
 			&QSTR(silly), dentry->d_parent,
-			LOOKUP_CREATE);
+			LOOKUP_CREATE, DLOCK_SUB_LOOKUP);
 		if (!IS_ERR(sdentry) && d_is_positive(dentry)) {
 			dput(sdentry);
 			sdentry = ERR_PTR(-EEXIST);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 27e645d290b1..ea1c37df7f00 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -242,6 +242,9 @@ enum {
 	DLOCK_NORMAL,
 	DLOCK_RENAME,		/* dentry with higher address in rename */
 	DLOCK_DYING_WAIT,	/* child of a locked parent that is dying */
+	DLOCK_SUB_LOOKUP,	/* lock on target for silly-rename or other
+				 * subordinate lookup
+				 */
 };
 
 extern seqlock_t rename_lock;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 6c9b545c60ce..1cbaa392fa21 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,8 +83,10 @@ struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 					unsigned int lookup_flags);
 struct dentry *lookup_and_lock_noperm(struct qstr *name, struct dentry *base,
 				      unsigned int lookup_flags);
+struct dentry *lookup_and_lock_noperm_nested(struct qstr *name, struct dentry *base,
+					     unsigned int lookup_flags, unsigned int class);
 struct dentry *lookup_and_lock_noperm_locked(struct qstr *name, struct dentry *base,
-					     unsigned int lookup_flags);
+					     unsigned int lookup_flags, unsigned int class);
 struct dentry *lookup_and_lock_hashed(struct qstr *last, struct dentry *base,
 				      unsigned int lookup_flags);
 void dentry_unlock(struct dentry *dentry);
-- 
2.49.0


