Return-Path: <linux-fsdevel+bounces-58715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE75B30A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0EA7BAA4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27313BC0C;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2420EB;
	Fri, 22 Aug 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821484; cv=none; b=mYiq6J0S2MeCDKatC51HNAgZrthkx7bFq10gR8sL0kau5lC2Hy6PfoN5RVDmmaZRi0l9jqgehI1kk19gDqkwEoWBsV0uDkDpD9hDrFjDsz1xZa6pnr2pco37555gQ2Idq585lIG0/xavsyixSfUOnbMvvX0zUeZ4bHDN5tg77wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821484; c=relaxed/simple;
	bh=xqXtKlwajL92pljf4lb4kVN1sDC+aVFMEzKA1befkEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCwHMPOlMxEbbibQ8a8Ga1k90GSJCplhRlfPn0yod4IDXiBEpBVoTZE1I7qP9kWFNz7OwSYV8A+HqDp+o1hbEXbsT+lVEWWHeFdQZLj01DNc7TXPVJltnI3BRID6WGHFnvGuFpzZYxQzpZTthHv8e9gXq9fm1tDR6JdYAwxvmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNA-006nar-IW;
	Fri, 22 Aug 2025 00:11:14 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/16] VFS: introduce start_dirop()
Date: Fri, 22 Aug 2025 10:00:24 +1000
Message-ID: <20250822000818.1086550-7-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fact that directory operations (create,remove,rename) are protected
by a lock on the parent is known widely throughout the kernel.
In order to change this - to locking the target dentry instead - it is
best to centralise this knowledge so it can be changed in one place.

This patch introduces start_dirop() which is local to fs/namei.c.
It performs the required locking for create and remove.  Rename
will be handled separately.

It is intended that this will be exported to the rest of the kernel
using more focused helpers.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 60 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b785bf7a9344..4f1eddaff63f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2752,6 +2752,32 @@ static int filename_parentat(int dfd, struct filename *name,
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent - the dentry of the parent in which the operation will occur
+ * @name - a qstr holding the name within that parent
+ * @lookup_flags - intent and other lookup flags.
+ *
+ * The lookup is performed and necessarly locks are taken so that, on success,
+ * the returned dentry can be operated on safely.
+ * The qstr must already have the hash value calculated.
+ *
+ * Returns: a locked dentry, or an error.
+ *
+ */
+static struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+				  unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	struct inode *dir = d_inode(parent);
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+	dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(dir);
+	return dentry;
+}
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct path *path)
 {
@@ -2765,12 +2791,10 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = start_dirop(parent_path.dentry, &last, 0);
+	if (IS_ERR(d))
 		return d;
-	}
+
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -2789,12 +2813,10 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+	d = start_dirop(parent_path.dentry, &last, LOOKUP_CREATE);
+	if (IS_ERR(d))
 		return d;
-	}
+
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
@@ -4143,11 +4165,9 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 */
 	if (last.name[last.len] && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto out_drop_write;
 
 	if (unlikely(error))
 		goto fail;
@@ -4156,8 +4176,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 fail:
 	dput(dentry);
 	dentry = ERR_PTR(error);
-unlock:
 	inode_unlock(path->dentry->d_inode);
+out_drop_write:
 	if (!error)
 		mnt_drop_write(path->mnt);
 out:
@@ -4511,8 +4531,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4522,8 +4541,8 @@ int do_rmdir(int dfd, struct filename *name)
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
 	dput(dentry);
-exit3:
 	inode_unlock(path.dentry->d_inode);
+exit3:
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4640,8 +4659,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 
@@ -4657,8 +4675,8 @@ int do_unlinkat(int dfd, struct filename *name)
 				   dentry, &delegated_inode);
 exit3:
 		dput(dentry);
+		inode_unlock(path.dentry->d_inode);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
-- 
2.50.0.107.gf914562f5916.dirty


