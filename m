Return-Path: <linux-fsdevel+bounces-50985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFAAD1977
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49E9169480
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE872820B5;
	Mon,  9 Jun 2025 08:00:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF228136C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456008; cv=none; b=P8DphraIZv6gBY4gfzCV/9cPsPbJu4keaIe1NjGdYppDSOOA85sYH8VSf9irj0fwD7fh18HlWFDwQuUlQ0UFaNAw7L/29Us1NaqwjCGxT3+iXzRSJUnzgagN7KdX79eTIBdsnR1otiLHou3U/GoN6MOYmIkPw3m/d1XBlmhP+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456008; c=relaxed/simple;
	bh=jltm3s2sdTvLs8URIpODlEzqZTQvQxyZK6bk2ixrNag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewG+VNq+LIT1m2o3FNk5qnXagckel9IL4geUCufs+MyAL0q9Emj2gWhxGCzLthKu4yO7vfnNLWPvI0QZxR6qZcdF0ZQE++x1N3GDbi6IlH+Sbi+ECc19juuYSo1lBB0gA8fx5q7H44t38K+8M5yaj4KjGII9/6dwdNxxXvwjwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQJ-006HTZ-Ea;
	Mon, 09 Jun 2025 08:00:03 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/8] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
Date: Mon,  9 Jun 2025 17:34:07 +1000
Message-ID: <20250609075950.159417-3-neil@brown.name>
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

lookup_one_qstr_excl() is used for lookups prior to directory
modifications, whether create, unlink, rename, or whatever.

To prepare for allowing modification to happen in parallel, change
lookup_one_qstr_excl() to use d_alloc_parallel() and change its name to
remove the _excl requirement.

If LOOKUP_EXCL or LOOKUP_RENAME_TARGET is passed, the caller must ensure
d_lookup_done() is called at an appropriate time, and must not assume
that it can test for positive or negative dentries without confirming
that the dentry is no longer d_in_lookup() - unless it is filesystem
code acting one itself and *knows* that ->lookup() always completes the
lookup (currently true for all filesystems other than NFS).

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 11 +++++
 fs/namei.c                            | 58 ++++++++++++++++++---------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 385ca21e230e..1feeac9e1483 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1271,3 +1271,14 @@ completed - typically when it completes with failure.
 
 d_alloc_parallel() no longer requires a waitqueue_head.  It used one
 from an internal table when needed.
+
+---
+
+** mandatory**
+
+All lookup_and_lock* functions may return a d_in_lookup() dentry if
+passed "O_CREATE|O_EXCL" or "O_RENAME_TARGET".  dentry_unlock() calls
+the necessary d_lookup_done().  If the caller *knows* which filesystem
+is being used, it may know that this is not possible.  Otherwise it must
+be careful testing if the dentry is positive or negative as the lookup
+may not have been performed yet.
diff --git a/fs/namei.c b/fs/namei.c
index 0703568339d3..e1749fb03cb5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1666,17 +1666,18 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
+ * Parent directory has inode locked.
+ * d_lookup_done() must be called before the dentry is dput()
+ * if LOOKUP_EXCL or LOOKUP_RENAME_TARGET is set.
+ * If the dentry is not d_in_lookup():
  * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
  * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * If it is d_in_lookup() then these conditions will be checked when
+ * the attempt make to create the act on the name.
  */
-static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-					   struct dentry *base,
-					   unsigned int flags)
+static struct dentry *lookup_one_qstr(const struct qstr *name,
+				      struct dentry *base,
+				      unsigned int flags)
 {
 	struct dentry *dentry;
 	struct dentry *old;
@@ -1691,18 +1692,27 @@ static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
-		return ERR_PTR(-ENOMEM);
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR(dentry)))
+		return dentry;
+	if (unlikely(!d_in_lookup(dentry)))
+		/* Raced with another thread which did the lookup */
+		goto found;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
 found:
 	if (IS_ERR(dentry))
 		return dentry;
+	if (d_in_lookup(dentry))
+		/* We cannot check for errors - the caller will have to
+		 * wait for any create-etc attempt to get relevant errors.
+		 */
+		return dentry;
 	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
 		dput(dentry);
 		return ERR_PTR(-ENOENT);
@@ -1725,7 +1735,10 @@ static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
  * The "necessary locks" are currently the inode node lock on @base.
  * The name @last is expected to already have the hash calculated.
  * No permission checks are performed.
+ *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *lookup_and_lock_hashed(struct qstr *last,
 				      struct dentry *base,
@@ -1735,7 +1748,7 @@ struct dentry *lookup_and_lock_hashed(struct qstr *last,
 
 	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
 
-	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	dentry = lookup_one_qstr(last, base, lookup_flags);
 	if (IS_ERR(dentry))
 		inode_unlock(base->d_inode);
 	return dentry;
@@ -1755,7 +1768,7 @@ struct dentry *lookup_and_lock_noperm_locked(struct qstr *last,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	return lookup_one_qstr_excl(last, base, lookup_flags);
+	return lookup_one_qstr(last, base, lookup_flags);
 }
 EXPORT_SYMBOL(lookup_and_lock_noperm_locked);
 
@@ -1770,7 +1783,10 @@ EXPORT_SYMBOL(lookup_and_lock_noperm_locked);
  * The "necessary locks" are currently the inode node lock on @base.
  * The name @last is NOT expected to have the hash calculated.
  * No permission checks are performed.
+ *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *lookup_and_lock_noperm(struct qstr *last,
 				      struct dentry *base,
@@ -1798,7 +1814,10 @@ EXPORT_SYMBOL(lookup_and_lock_noperm);
  * The "necessary locks" are currently the inode node lock on @base.
  * The name @last is NOT expected to already have the hash calculated.
  * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *lookup_and_lock(struct mnt_idmap *idmap,
 			       struct qstr *last,
@@ -1826,7 +1845,10 @@ EXPORT_SYMBOL(lookup_and_lock);
  * If a fatal signal arrives or is already pending the operation is aborted.
  * The name @last is NOT expected to already have the hash calculated.
  * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 					struct qstr *last,
@@ -1843,7 +1865,7 @@ struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	dentry = lookup_one_qstr(last, base, lookup_flags);
 	if (IS_ERR(dentry))
 		inode_unlock(base->d_inode);
 	return dentry;
@@ -1894,6 +1916,7 @@ EXPORT_SYMBOL(dentry_unlock_dir_locked);
 void dentry_unlock(struct dentry *dentry)
 {
 	if (!IS_ERR(dentry)) {
+		d_lookup_done(dentry);
 		inode_unlock(dentry->d_parent->d_inode);
 		dentry_unlock_dir_locked(dentry);
 	}
@@ -3500,8 +3523,7 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 		p = lock_rename(rd->old_dir, rd->new_dir);
 		dget(rd->old_dir);
 
-		d1 = lookup_one_qstr_excl(&rd->old_last, rd->old_dir,
-					  lookup_flags);
+		d1 = lookup_one_qstr(&rd->old_last, rd->old_dir, lookup_flags);
 		if (IS_ERR(d1))
 			goto out_unlock_1;
 	}
@@ -3513,8 +3535,8 @@ lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags)
 		}
 		d2 = dget(rd->new_dentry);
 	} else {
-		d2 = lookup_one_qstr_excl(&rd->new_last, rd->new_dir,
-				  lookup_flags | target_flags);
+		d2 = lookup_one_qstr(&rd->new_last, rd->new_dir,
+				     lookup_flags | target_flags);
 		if (IS_ERR(d2))
 			goto out_unlock_2;
 	}
-- 
2.49.0


