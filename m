Return-Path: <linux-fsdevel+bounces-55574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B9B0BF5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0E2189D833
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9528B504;
	Mon, 21 Jul 2025 08:45:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE721C17D;
	Mon, 21 Jul 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087541; cv=none; b=CV0YZBmR7rp/BcO4q0gKjlexWoEnOXuEpkDvNAe4H2uNM2sADmxdiVq/GVs2PaEypxtcgdCFJqq13sdo8AvKH95GSPJBLXmXRrgJEh3L8LJqqv7hzg9O6jhp2xk/WbuS2VaSEOJNVoGwQwT9bwbFSq0SzZ5IaiPOkzVybsSCfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087541; c=relaxed/simple;
	bh=twIEAk2VcEqC3Z8nz59FTWIJoql8mNp4EZgcLKmUpXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpPbAMspN0V/ker7pwZqUQ252j5d9WnfEe4/aI3XNJxc3F8O0M3lq9jrFGTEzrdaVolXcIME37oJs+O/aer4ckXGCjzSR3cXwumJTt2HqRqDFCeBk8zdlTzL8/hH/p5ueu7YfmLTnOPtRbpCoJaj4GyHX5bGSz7YSHzxKOXk1Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9I-002pgB-Dj;
	Mon, 21 Jul 2025 08:45:30 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] VFS: add rename_lookup()
Date: Mon, 21 Jul 2025 18:00:02 +1000
Message-ID: <20250721084412.370258-7-neil@brown.name>
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

rename_lookup() combines lookup and locking for a rename.

Two names - new_last and old_last - are added to struct renamedata so it
can be passed to rename_lookup() to have the old and new dentries filled
in.

rename_lookup_hashed() assumes that the names are already hashed
and skips permission checking.  This is appropriate for use after
filename_parentat().

rename_lookup_noperm() does hash the name but avoids permission
checking.  This will be used by debugfs.

If either old_dentry or new_dentry are not NULL, the corresponding
"last" is ignored and the dentry is used as-is.  After locks are
obtained we check that the parent is still correct.  If old_parent
was not given, then it is set to the parent of old_dentry which
was locked.  new_parent must never be NULL.

done_rename_lookup() unlocks and drops any dentry references taken.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 316 ++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h    |   4 +
 include/linux/namei.h |   4 +
 3 files changed, 263 insertions(+), 61 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 46657736c7a0..ae8079916ac6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3490,6 +3490,233 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * rename_lookup_hashed - lookup and lock names for rename
+ * @rd:           rename data containing relevant details
+ * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
+ *                LOOKUP_NO_SYMLINKS etc).
+ *
+ * Optionally look up two names and ensure locks are in place for
+ * rename.
+ * Normally @rd.old_dentry and @rd.new_dentry are %NULL and the
+ * old and new directories and last names are given in @rd.  In this
+ * case the names are looked up with appropriate locking and the
+ * results stored in @rd.old_dentry and @rd.new_dentry.
+ *
+ * If either are not NULL, then the corresponding lookup is avoided
+ * but the required locks are still taken.  In this case @rd.old_parent
+ * may be %NULL, otherwise @rd.old_dentry must have that as its d_parent
+ * pointer after the locks are obtained.  @rd.new_parent must always
+ * be non-NULL, and must always be the correct parent after locking.
+ *
+ * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
+ * and @rd.old_parent whether they were originally %NULL or not.  These
+ * references are dropped by done_rename_lookup().  @rd.new_parent
+ * must always be non-NULL and no extra reference is taken.
+ *
+ * The passed in qstrs must have the hash calculated, and no permission
+ * checking is performed.
+ *
+ * Returns: zero or an error.
+ */
+int
+rename_lookup_hashed(struct renamedata *rd, int lookup_flags)
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
+		p = lock_rename_child(rd->old_dentry, rd->new_parent);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+		if (d_unhashed(rd->old_dentry) ||
+		    (rd->old_parent && rd->old_parent != rd->old_dentry->d_parent)) {
+			/* dentry was removed, or moved and explicit parent requested */
+			unlock_rename(rd->old_dentry->d_parent, rd->new_parent);
+			return -EINVAL;
+		}
+		rd->old_parent = dget(rd->old_dentry->d_parent);
+		d1 = dget(rd->old_dentry);
+	} else {
+		p = lock_rename(rd->old_parent, rd->new_parent);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+		dget(rd->old_parent);
+
+		d1 = lookup_one_qstr_excl(&rd->old_last, rd->old_parent,
+					  lookup_flags);
+		if (IS_ERR(d1))
+			goto out_unlock_1;
+	}
+	if (rd->new_dentry) {
+		if (d_unhashed(rd->new_dentry) ||
+		    rd->new_dentry->d_parent != rd->new_parent) {
+			/* new_dentry was moved or removed! */
+			goto out_unlock_2;
+		}
+		d2 = dget(rd->new_dentry);
+	} else {
+		d2 = lookup_one_qstr_excl(&rd->new_last, rd->new_parent,
+					  lookup_flags | target_flags);
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
+	unlock_rename(rd->old_parent, rd->new_parent);
+	dput(rd->old_parent);
+	return PTR_ERR(d1);
+}
+EXPORT_SYMBOL(rename_lookup_hashed);
+
+/**
+ * rename_lookup_noperm - lookup and lock names for rename
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
+ * but the required locks are still taken.  In this case @rd.old_parent
+ * may be %NULL, otherwise @rd.old_dentry must have that as its d_parent
+ * pointer after the locks are obtained.  @rd.new_parent must always
+ * be non-NULL, and must always be the correct parent after locking.
+ *
+ * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
+ * and @rd.old_parent whether they were originally %NULL or not.  These
+ * references are dropped by done_rename_lookup().  @rd.new_parent
+ * must always be non-NULL and no extra reference is taken.
+ *
+ * The passed in qstrs need not have the hash calculated, and no
+ * permission checking is performed.
+ *
+ * Returns: zero or an error.
+ */
+int rename_lookup_noperm(struct renamedata *rd, int lookup_flags)
+{
+	int err;
+
+	if (!rd->old_dentry) {
+		err = lookup_noperm_common(&rd->old_last, rd->old_parent);
+		if (err)
+			return err;
+	}
+	if (!rd->new_dentry) {
+		err = lookup_noperm_common(&rd->new_last, rd->new_parent);
+		if (err)
+			return err;
+	}
+	return rename_lookup_hashed(rd, lookup_flags);
+}
+EXPORT_SYMBOL(rename_lookup_noperm);
+
+/**
+ * rename_lookup - lookup and lock names for rename
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
+ * but the required locks are still taken.  In this case @rd.old_parent
+ * may be %NULL, otherwise @rd.old_dentry must have that as its d_parent
+ * pointer after the locks are obtained.  @rd.new_parent must always
+ * be non-NULL, and must always be the correct parent after locking.
+ *
+ * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
+ * and @rd.old_parent whether they were originally %NULL or not.  These
+ * references are dropped by done_rename_lookup().  @rd.new_parent
+ * must always be non-NULL and no extra reference is taken.
+ *
+ * The passed in qstrs need not have the hash calculated, and normal
+ * permission checking for MAY_EXEC is performed.
+ *
+ * Returns: zero or an error.
+ */
+int rename_lookup(struct renamedata *rd, int lookup_flags)
+{
+	int err;
+
+	if (!rd->old_dentry) {
+		err = lookup_one_common(rd->mnt_idmap, &rd->old_last,
+					rd->old_parent);
+		if (err)
+			return err;
+	}
+	if (!rd->new_dentry) {
+		err = lookup_one_common(rd->mnt_idmap, &rd->new_last,
+					rd->new_parent);
+		if (err)
+			return err;
+	}
+	return rename_lookup_hashed(rd, lookup_flags);
+}
+EXPORT_SYMBOL(rename_lookup);
+
+/**
+ * done_rename_lookup - unlock dentries after rename
+ * @rd: the struct renamedata that was passed to rename_lookup()
+ *
+ * After a successful rename_lookup() (or similar) call, and after
+ * any required renaming is performed, done_rename_rename() must be called
+ * to drop any locks and references that were obtained by the earlier function.
+ */
+void done_rename_lookup(struct renamedata *rd)
+{
+	d_lookup_done(rd->old_dentry);
+	d_lookup_done(rd->new_dentry);
+	unlock_rename(rd->old_parent, rd->new_parent);
+	dput(rd->old_parent);
+	dput(rd->old_dentry);
+	dput(rd->new_dentry);
+}
+EXPORT_SYMBOL(done_rename_lookup);
+
 /**
  * vfs_prepare_mode - prepare the mode to be used for a new inode
  * @idmap:	idmap of the mount the inode was found from
@@ -5318,14 +5545,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
 
@@ -5336,19 +5559,14 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
 
@@ -5370,66 +5588,42 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit2;
 
 retry_deleg:
-	trap = lock_rename(new_path.dentry, old_path.dentry);
-	if (IS_ERR(trap)) {
-		error = PTR_ERR(trap);
+	rd.old_parent	   = old_path.dentry;
+	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
+	rd.old_dentry	   = NULL;
+	rd.new_parent	   = new_path.dentry;
+	rd.new_dentry	   = NULL;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+
+	error = rename_lookup_hashed(&rd, lookup_flags);
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
 
-	rd.old_parent	   = old_path.dentry;
-	rd.old_dentry	   = old_dentry;
-	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
-	rd.new_parent	   = new_path.dentry;
-	rd.new_dentry	   = new_dentry;
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
+	done_rename_lookup(&rd);
 exit_lock_rename:
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d3e27da8a6aa..1ae7328749a0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2008,8 +2008,10 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
  * @mnt_idmap:     idmap of the mount in which the rename is happening.
  * @old_parent:        parent of source
  * @old_dentry:                source
+ * @old_last:          name for old_dentry in old_dir, if old_dentry not given
  * @new_parent:        parent of destination
  * @new_dentry:                destination
+ * @new_last:          name for new_dentry in new_dir, if new_dentry not given
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
@@ -2017,8 +2019,10 @@ struct renamedata {
 	struct mnt_idmap *mnt_idmap;
 	struct dentry *old_parent;
 	struct dentry *old_dentry;
+	struct qstr old_last;
 	struct dentry *new_parent;
 	struct dentry *new_dentry;
+	struct qstr new_last;
 	struct inode **delegated_inode;
 	unsigned int flags;
 } __randomize_layout;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8eade32623d8..c86d9683563c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -100,6 +100,10 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+int rename_lookup(struct renamedata *rd, int lookup_flags);
+int rename_lookup_noperm(struct renamedata *rd, int lookup_flags);
+int rename_lookup_hashed(struct renamedata *rd, int lookup_flags);
+void done_rename_lookup(struct renamedata *rd);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.49.0


