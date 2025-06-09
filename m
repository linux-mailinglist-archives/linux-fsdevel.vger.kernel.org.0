Return-Path: <linux-fsdevel+bounces-50972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F0AD1846
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C71E1889D42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F6F280012;
	Mon,  9 Jun 2025 05:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5E19258E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446447; cv=none; b=EQYPV5xHqVWrECpZ0fWAcHeT/UmbAuFqD6M9/QwNK/a6xw23NSxomFsqVKWqJZz9on9Gv1sdHs856HSRy1bkV3qjFLMGcjZVXI2OPzoT9uhEGkjaaeJa9wD5PoSvY5qo+Brj0TPnFe14mzLEGIdqOkIjx0+t2wBLb3OuI6YVzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446447; c=relaxed/simple;
	bh=ViEPJih92x1kGIbwrPv6Y61eEAslE4FHOrp5BxHu8ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKQ2nUjI1QWzuYFw6WUT6nciT7jLs38NJEVocNncG46clR71VGTzFOQzZPuuz/aa6vQTzl0VDVjC2m4ycNhWh+V8CmVN/NMucK4uR98zJ5O4JOO4uPmxoqhix9lCyjhLi0kGp6Hsxb6djgG5uFw2fsEN9mmeb3ep2Seu0axJTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUw6-006Apj-Ta;
	Mon, 09 Jun 2025 05:20:42 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] VFS: add lookup_and_lock_rename()
Date: Mon,  9 Jun 2025 15:01:16 +1000
Message-ID: <20250609051419.106580-5-neil@brown.name>
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

lookup_and_lock_rename() combines locking and lookup for two names.

Two names - new_last and old_last - are added to struct renamedata so it
can be passed to lookup_and_lock_rename() to have the old and new
dentries filled in.

lookup_and_lock_rename_hashed() assumes that the names are already hashed
and skips permission checking.  This is appropriate for use after
filename_parentat().

lookup_and_lock_rename_noperm() does hash the name but avoids permission
checking.  This will be used by debugfs.

dentry_unlock_rename() unlocks.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 311 +++++++++++++++++++++++++++++++++---------
 include/linux/fs.h    |   4 +
 include/linux/namei.h |   4 +
 3 files changed, 257 insertions(+), 62 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 32895140abde..39868ee40f03 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3475,6 +3475,226 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * lookup_and_lock_rename_hashed - lookup and lock names for rename
+ * @rd:           rename data containing relevant details
+ * @lookup_flags: optional LOOKUP_REVAL to pass to ->lookup
+ *
+ * Optionally look up two names and ensure locks are in place for
+ * rename.
+ * Normally @rd.old_dentry and @rd.new_dentry are %NULL and the
+ * old and new directories and last names are given in @rd.  In this
+ * case the names are looked up with appropriate locking and the
+ * results stored in @rd.old_dentry and @rd.new_dentry.
+ *
+ * If either are not NULL, then the corresponding lookup is avoided
+ * but the required locks are still taken.  In this case @rd.old_dir
+ * may be %NULL, otherwise @rd.old_dentry must have that as its d_parent
+ * pointer after the locks are obtained.  @rd.new_dir must always
+ * be non-NULL, and must always be the correct parent after locking.
+ *
+ * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
+ * and @rd.old_dir whether they were originally %NULL or not.  These
+ * references are dropped by dentry_unlock_rename().  @rd.new_dir
+ * must always be non-NULL and no extra reference is taken.
+ *
+ * The passed in qstrs must have the hash calculated, and no permission
+ * checking is performed.
+ *
+ * Returns: zero or an error.
+ */
+int
+lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
+{
+	struct dentry *p;
+	struct dentry *d1, *d2;
+	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	int err;
+
+	if (rd->flags & RENAME_EXCHANGE)
+		target_flags = 0;
+	if (rd->flags & RENAME_NOREPLACE)
+		target_flags |= LOOKUP_EXCL;
+
+	if (rd->old_dentry) {
+		/* Already have the dentry - need to be sure to lock the correct parent */
+		p = lock_rename_child(rd->old_dentry, rd->new_dir);
+		if (d_unhashed(rd->old_dentry) ||
+		    (rd->old_dir && rd->old_dir != rd->old_dentry->d_parent)) {
+			/* dentry was removed, or moved and  explicit parent requested */
+			unlock_rename(rd->old_dentry->d_parent, rd->new_dir);
+			return -EINVAL;
+		}
+		rd->old_dir = dget(rd->old_dentry->d_parent);
+		d1 = dget(rd->old_dentry);
+	} else {
+		p = lock_rename(rd->old_dir, rd->new_dir);
+		dget(rd->old_dir);
+
+		d1 = lookup_one_qstr_excl(&rd->old_last, rd->old_dir,
+					  lookup_flags);
+		if (IS_ERR(d1))
+			goto out_unlock_1;
+	}
+	if (rd->new_dentry) {
+		if (d_unhashed(rd->new_dentry) ||
+		    rd->new_dentry->d_parent != rd->new_dir) {
+			/* new_dentry was moved or removed! */
+			goto out_unlock_2;
+		}
+		d2 = dget(rd->new_dentry);
+	} else {
+		d2 = lookup_one_qstr_excl(&rd->new_last, rd->new_dir,
+				  lookup_flags | target_flags);
+		if (IS_ERR(d2))
+			goto out_unlock_2;
+	}
+
+	if (d1 == p) {
+		/* source is an ancestor of target */
+		err = -EINVAL;
+		goto out_unlock_3;
+	}
+
+	if (d2 == p) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_unlock_3;
+	}
+
+	rd->old_dentry = d1;
+	rd->new_dentry = d2;
+	return 0;
+
+out_unlock_3:
+	d_lookup_done(d2);
+	dput(d2);
+	d2 = ERR_PTR(err);
+out_unlock_2:
+	d_lookup_done(d1);
+	dput(d1);
+	d1 = d2;
+out_unlock_1:
+	unlock_rename(rd->old_dir, rd->new_dir);
+	dput(rd->old_dir);
+	return PTR_ERR(d1);
+}
+EXPORT_SYMBOL(lookup_and_lock_rename_hashed);
+
+/**
+ * lookup_and_lock_rename_noperm - lookup and lock names for rename
+ * @rd:           rename data containing relevant details
+ * @lookup_flags: optional LOOKUP_REVAL to pass to ->lookup
+ *
+ * Optionally look up two names and ensure locks are in place for
+ * rename.
+ * Normally @rd.old_dentry and @rd.new_dentry are %NULL and the
+ * old and new directories and last names are given in @rd.  In this
+ * case the names are looked up with appropriate locking and the
+ * results stored in @rd.old_dentry and @rd.new_dentry.
+ *
+ * If either are not NULL, then the corresponding lookup is avoided
+ * but the required locks are still taken.  In this case @rd.old_dir
+ * may be %NULL, otherwise @rd.old_dentry must have that as its d_parent
+ * pointer after the locks are obtained.  @rd.new_dir must always
+ * be non-NULL, and must always be the correct parent after locking.
+ *
+ * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
+ * and @rd.old_dir whether they were originally %NULL or not.  These
+ * references are dropped by dentry_unlock_rename().  @rd.new_dir
+ * must always be non-NULL and no extra reference is taken.
+ *
+ * The passed in qstrs need not have the hash calculated, and no
+ * permission checking is performed.
+ *
+ * Returns: zero or an error.
+ */
+int lookup_and_lock_rename_noperm(struct renamedata *rd, int lookup_flags)
+{
+	int err;
+
+	if (!rd->old_dentry) {
+		err = lookup_noperm_common(&rd->old_last, rd->old_dir);
+		if (err)
+			return err;
+	}
+	if (!rd->new_dentry) {
+		err = lookup_noperm_common(&rd->new_last, rd->new_dir);
+		if (err)
+			return err;
+	}
+	return lookup_and_lock_rename_hashed(rd, lookup_flags);
+}
+EXPORT_SYMBOL(lookup_and_lock_rename_noperm);
+
+/**
+ * lookup_and_lock_rename - lookup and lock names for rename
+ * @rd:           rename data containing relevant details
+ * @lookup_flags: optional LOOKUP_REVAL to pass to ->lookup
+ *
+ * Optionally look up two names and ensure locks are in place for
+ * rename.
+ * Normally @rd.old_dentry and @rd.new_dentry are %NULL and the
+ * old and new directories and last names are given in @rd.  In this
+ * case the names are looked up with appropriate locking and the
+ * results stored in @rd.old_dentry and @rd.new_dentry.
+ *
+ * If either are not NULL, then the corresponding lookup is avoided
+ * but the required locks are still taken.  In this case @rd.old_dir
+ * may be %NULL, otherwise @rd.old_dentry must have that as its d_parent
+ * pointer after the locks are obtained.  @rd.new_dir must always
+ * be non-NULL, and must always be the correct parent after locking.
+ *
+ * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
+ * and @rd.old_dir whether they were originally %NULL or not.  These
+ * references are dropped by dentry_unlock_rename().  @rd.new_dir
+ * must always be non-NULL and no extra reference is taken.
+ *
+ * The passed in qstrs need not have the hash calculated, and normal
+ * permission checking for MAY_EXEC is performed.
+ *
+ * Returns: zero or an error.
+ */
+int lookup_and_lock_rename(struct renamedata *rd, int lookup_flags)
+{
+	int err;
+
+	if (!rd->old_dentry) {
+		err = lookup_one_common(rd->old_mnt_idmap, &rd->old_last, rd->old_dir);
+		if (err)
+			return err;
+	}
+	if (!rd->new_dentry) {
+		err = lookup_one_common(rd->new_mnt_idmap, &rd->new_last, rd->new_dir);
+		if (err)
+			return err;
+	}
+	return lookup_and_lock_rename_hashed(rd, lookup_flags);
+}
+EXPORT_SYMBOL(lookup_and_lock_rename);
+
+/**
+ * dentry_unlock_rename - unlock dentries after rename
+ * @rd: the struct renamedata that was passed to lookup_and_lock_rename()
+ *
+ * After a successful lookup_and_lock_rename() (or similar) call, and after
+ * any required renaming is performed, dentry_unlock_rename() must be called
+ * to drop any locks and references that were obtained by the earlier function.
+ */
+void dentry_unlock_rename(struct renamedata *rd)
+{
+	d_lookup_done(rd->old_dentry);
+	d_lookup_done(rd->new_dentry);
+	unlock_rename(rd->old_dir, rd->new_dir);
+	dput(rd->old_dir);
+	dput(rd->old_dentry);
+	dput(rd->new_dentry);
+}
+EXPORT_SYMBOL(dentry_unlock_rename);
+
 /**
  * vfs_prepare_mode - prepare the mode to be used for a new inode
  * @idmap:	idmap of the mount the inode was found from
@@ -5303,14 +5523,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		 struct filename *to, unsigned int flags)
 {
 	struct renamedata rd;
-	struct dentry *old_dentry, *new_dentry;
-	struct dentry *trap;
 	struct path old_path, new_path;
-	struct qstr old_last, new_last;
 	int old_type, new_type;
 	struct inode *delegated_inode = NULL;
-	unsigned int lookup_flags = 0, target_flags =
-		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	unsigned int lookup_flags = 0;
 	bool should_retry = false;
 	int error = -EINVAL;
 
@@ -5321,19 +5537,14 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	    (flags & RENAME_EXCHANGE))
 		goto put_names;
 
-	if (flags & RENAME_EXCHANGE)
-		target_flags = 0;
-	if (flags & RENAME_NOREPLACE)
-		target_flags |= LOOKUP_EXCL;
-
 retry:
 	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
-				  &old_last, &old_type);
+				  &rd.old_last, &old_type);
 	if (error)
 		goto put_names;
 
-	error = filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
-				  &new_type);
+	error = filename_parentat(newdfd, to, lookup_flags, &new_path,
+				  &rd.new_last, &new_type);
 	if (error)
 		goto exit1;
 
@@ -5355,67 +5566,43 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit2;
 
 retry_deleg:
-	trap = lock_rename(new_path.dentry, old_path.dentry);
-	if (IS_ERR(trap)) {
-		error = PTR_ERR(trap);
+	rd.old_dir	   = old_path.dentry;
+	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
+	rd.old_dentry	   = NULL;
+	rd.new_dir	   = new_path.dentry;
+	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
+	rd.new_dentry	   = NULL;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+
+	error = lookup_and_lock_rename_hashed(&rd, lookup_flags);
+	if (error)
 		goto exit_lock_rename;
-	}
 
-	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
-					  lookup_flags);
-	error = PTR_ERR(old_dentry);
-	if (IS_ERR(old_dentry))
-		goto exit3;
-	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | target_flags);
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto exit4;
 	if (flags & RENAME_EXCHANGE) {
-		if (!d_is_dir(new_dentry)) {
+		if (!d_is_dir(rd.new_dentry)) {
 			error = -ENOTDIR;
-			if (new_last.name[new_last.len])
-				goto exit5;
+			if (rd.new_last.name[rd.new_last.len])
+				goto exit_unlock;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
-	if (!d_is_dir(old_dentry)) {
+	if (!d_is_dir(rd.old_dentry)) {
 		error = -ENOTDIR;
-		if (old_last.name[old_last.len])
-			goto exit5;
-		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
-			goto exit5;
-	}
-	/* source should not be ancestor of target */
-	error = -EINVAL;
-	if (old_dentry == trap)
-		goto exit5;
-	/* target should not be an ancestor of source */
-	if (!(flags & RENAME_EXCHANGE))
-		error = -ENOTEMPTY;
-	if (new_dentry == trap)
-		goto exit5;
+		if (rd.old_last.name[rd.old_last.len])
+			goto exit_unlock;
+		if (!(flags & RENAME_EXCHANGE) && rd.new_last.name[rd.new_last.len])
+			goto exit_unlock;
+	}
 
-	error = security_path_rename(&old_path, old_dentry,
-				     &new_path, new_dentry, flags);
+	error = security_path_rename(&old_path, rd.old_dentry,
+				     &new_path, rd.new_dentry, flags);
 	if (error)
-		goto exit5;
+		goto exit_unlock;
 
-	rd.old_dir	   = old_path.dentry;
-	rd.old_dentry	   = old_dentry;
-	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
-	rd.new_dir	   = new_path.dentry;
-	rd.new_dentry	   = new_dentry;
-	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
-	rd.delegated_inode = &delegated_inode;
-	rd.flags	   = flags;
 	error = vfs_rename(&rd);
-exit5:
-	dput(new_dentry);
-exit4:
-	dput(old_dentry);
-exit3:
-	unlock_rename(new_path.dentry, old_path.dentry);
+exit_unlock:
+	dentry_unlock_rename(&rd);
 exit_lock_rename:
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9b54b4e7dbb7..24bc29efecd5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2006,9 +2006,11 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
  * @old_mnt_idmap:     idmap of the old mount the inode was found from
  * @old_dir:           parent of source
  * @old_dentry:                source
+ * @old_last:          name for old_dentry in old_dir, if old_dentry not given
  * @new_mnt_idmap:     idmap of the new mount the inode was found from
  * @new_dir:           parent of destination
  * @new_dentry:                destination
+ * @new_last:          name for new_dentry in new_dir, if new_dentry not given
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
@@ -2016,9 +2018,11 @@ struct renamedata {
 	struct mnt_idmap *old_mnt_idmap;
 	struct dentry *old_dir;
 	struct dentry *old_dentry;
+	struct qstr old_last;
 	struct mnt_idmap *new_mnt_idmap;
 	struct dentry *new_dir;
 	struct dentry *new_dentry;
+	struct qstr new_last;
 	struct inode **delegated_inode;
 	unsigned int flags;
 } __randomize_layout;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5177499a2f6b..a51f3caad106 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -102,6 +102,10 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+int lookup_and_lock_rename(struct renamedata *rd, int lookup_flags);
+int lookup_and_lock_rename_noperm(struct renamedata *rd, int lookup_flags);
+int lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags);
+void dentry_unlock_rename(struct renamedata *rd);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.49.0


