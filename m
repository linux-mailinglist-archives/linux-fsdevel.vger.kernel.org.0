Return-Path: <linux-fsdevel+bounces-57607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266DB23CBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BF07AA453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394AD2EACEE;
	Tue, 12 Aug 2025 23:53:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651D2D97B0;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042786; cv=none; b=d+cW59WnT9Z74PysFhXypjzuP+O6khVNzgj3LilWArd5VVtbpsm86b5A5phZ2K0eOJ9Fk5TAz8d9mo6+Cf2NQO4EtlxsEgCMGxJKWPcKTjotIgDDOgnvxJymo/EmcMZZQWP5F891xkfP+DLLJHOY7TUoFBnDAxLIE0r/IT/+tEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042786; c=relaxed/simple;
	bh=Fxzyw9jaYjDcrQDDTrdlviF3rA886DmUXWc9I/mH1Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgZc7KnYsd303yW2WSubI5lUywODwzN+/y/3yjE6AfqILT8bphRxSU2IRDhIQ5913Oov0KV3KVnN4l9uSsoGk4Cd+bueCsf7HjU2hNyMFihJVF76AnHl6LBfVxSVFo+L5o8I3wv1ekd9sYt5qlY1BPz6/gKeKrP9ZEBmYX5E54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynM-005Y23-70;
	Tue, 12 Aug 2025 23:52:45 +0000
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
Subject: [PATCH 05/11] VFS: add rename_lookup()
Date: Tue, 12 Aug 2025 12:25:08 +1000
Message-ID: <20250812235228.3072318-6-neil@brown.name>
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

rename_lookup() combines lookup and locking for a rename.

Two names - new_last and old_last - are added to struct renamedata so it
can be passed to rename_lookup() to have the old and new dentries filled
in.

__rename_lookup() in vfs-internal and assumes that the names are already
hashed and skips permission checking.  This is appropriate for use after
filename_parentat().

rename_lookup_noperm() does hash the name but avoids permission
checking.  This will be used by debugfs.

If either old_dentry or new_dentry are not NULL, the corresponding
"last" is ignored and the dentry is used as-is.  This provides similar
functionality to dentry_lookup_continue().  After locks are obtained we
check that the parent is still correct.  If old_parent was not given,
then it is set to the parent of old_dentry which was locked.  new_parent
must never be NULL.

On success new references are geld on old_dentry, new_dentry and old_parent.

done_rename_lookup() unlocks and drops those three references.

No __free() support is provided as done_rename_lookup() cannot be safely
called after rename_lookup() returns an error.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 318 ++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h    |   4 +
 include/linux/namei.h |   3 +
 3 files changed, 263 insertions(+), 62 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index df21b6fa5a0e..cead810d53c6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3507,6 +3507,233 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * __rename_lookup - lookup and lock names for rename
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
+ * If either are not NULL, then the corresponding lookup is avoided but
+ * the required locks are still taken.  In this case @rd.old_parent may
+ * be %NULL, otherwise @rd.old_dentry must still have @rd.old_parent as
+ * its d_parent after the locks are obtained.  @rd.new_parent must
+ * always be non-NULL, and must always be the correct parent after
+ * locking.
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
+static int
+__rename_lookup(struct renamedata *rd, int lookup_flags)
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
+	dput(d2);
+	d2 = ERR_PTR(err);
+out_unlock_2:
+	dput(d1);
+	d1 = d2;
+out_unlock_1:
+	unlock_rename(rd->old_parent, rd->new_parent);
+	dput(rd->old_parent);
+	return PTR_ERR(d1);
+}
+
+/**
+ * rename_lookup_noperm - lookup and lock names for rename
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
+ * If either are not NULL, then the corresponding lookup is avoided but
+ * the required locks are still taken.  In this case @rd.old_parent may
+ * be %NULL, otherwise @rd.old_dentry must still have @rd.old_parent as
+ * its d_parent after the locks are obtained.  @rd.new_parent must
+ * always be non-NULL, and must always be the correct parent after
+ * locking.
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
+	return __rename_lookup(rd, lookup_flags);
+}
+EXPORT_SYMBOL(rename_lookup_noperm);
+
+/**
+ * rename_lookup - lookup and lock names for rename
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
+ * If either are not NULL, then the corresponding lookup is avoided but
+ * the required locks are still taken.  In this case @rd.old_parent may
+ * be %NULL, otherwise @rd.old_dentry must still have @rd.old_parent as
+ * its d_parent after the locks are obtained.  @rd.new_parent must
+ * always be non-NULL, and must always be the correct parent after
+ * locking.
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
+		err = lookup_one_common(rd->old_mnt_idmap, &rd->old_last,
+					rd->old_parent);
+		if (err)
+			return err;
+	}
+	if (!rd->new_dentry) {
+		err = lookup_one_common(rd->new_mnt_idmap, &rd->new_last,
+					rd->new_parent);
+		if (err)
+			return err;
+	}
+	return __rename_lookup(rd, lookup_flags);
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
@@ -5336,14 +5563,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
 
@@ -5354,19 +5577,14 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
 
@@ -5388,67 +5606,43 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit2;
 
 retry_deleg:
-	trap = lock_rename(new_path.dentry, old_path.dentry);
-	if (IS_ERR(trap)) {
-		error = PTR_ERR(trap);
+	rd.old_parent	   = old_path.dentry;
+	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
+	rd.old_dentry	   = NULL;
+	rd.new_parent	   = new_path.dentry;
+	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
+	rd.new_dentry	   = NULL;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+
+	error = __rename_lookup(&rd, lookup_flags);
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
-	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
-	rd.new_parent	   = new_path.dentry;
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
+	done_rename_lookup(&rd);
 exit_lock_rename:
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index db644150b58f..b12203afa0da 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2011,9 +2011,11 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
  * @old_mnt_idmap:     idmap of the old mount the inode was found from
  * @old_parent:        parent of source
  * @old_dentry:                source
+ * @old_last:          name for old_dentry in old_dir, if old_dentry not given
  * @new_mnt_idmap:     idmap of the new mount the inode was found from
  * @new_parent:        parent of destination
  * @new_dentry:                destination
+ * @new_last:          name for new_dentry in new_dir, if new_dentry not given
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
@@ -2021,9 +2023,11 @@ struct renamedata {
 	struct mnt_idmap *old_mnt_idmap;
 	struct dentry *old_parent;
 	struct dentry *old_dentry;
+	struct qstr old_last;
 	struct mnt_idmap *new_mnt_idmap;
 	struct dentry *new_parent;
 	struct dentry *new_dentry;
+	struct qstr new_last;
 	struct inode **delegated_inode;
 	unsigned int flags;
 } __randomize_layout;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 67eef91603cc..26e5778c665f 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -108,6 +108,9 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+int rename_lookup(struct renamedata *rd, int lookup_flags);
+int rename_lookup_noperm(struct renamedata *rd, int lookup_flags);
+void done_rename_lookup(struct renamedata *rd);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.50.0.107.gf914562f5916.dirty


