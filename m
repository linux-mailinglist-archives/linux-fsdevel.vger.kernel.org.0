Return-Path: <linux-fsdevel+bounces-58725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C54B30A25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99DD7BC778
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5120EB;
	Fri, 22 Aug 2025 00:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C130156230;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821488; cv=none; b=Zmke0E1F3SdYdNrfioxtikplH3xBiCAM+Rtw9FfYRFxJc5cKR9toqLrFk9goKOZd1loapACMjQPam1i/9BAB5dx9MnpjtB8ZSk87+brJmEnQiuzE54hyakzpCOHlR+c3uyfeFXMrwE0Hv7/37JB90nwBS1MdPJJPiQbzid17cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821488; c=relaxed/simple;
	bh=l6xkNp1lPiYCT5DKAQ0xm8yzAbNf3BW5XyqA/xo4kDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5bJHjNNm+4rsmQY5wIi9JfrQCSCVl4sG2clHGL6dx5dp1iy369V7c9m/4kxZpq7JdgpCK+WZYf/An86cXshpi7Tj7E3w2TogvGYND2er0u0bFmbErtvUaoTEm5kEkMbbArE2nF03aCE3/mzZJVV/JEMGrECsOX2f4POXG7V62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNE-006nbW-Eq;
	Fri, 22 Aug 2025 00:11:18 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/16] VFS: introduce start_creating_noperm() and start_removing_noperm()
Date: Fri, 22 Aug 2025 10:00:32 +1000
Message-ID: <20250822000818.1086550-15-neil@brown.name>
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

xfs, fuse, ipc/mqueue need variants of start_creating or start_removing
which do not check permissions.
This patch adds _noperm versions of these functions.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/dir.c            | 19 +++++++---------
 fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/orphanage.c | 11 ++++-----
 include/linux/namei.h    |  2 ++
 ipc/mqueue.c             |  7 ++----
 5 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..043896278380 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1403,27 +1403,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	if (!parent)
 		return -ENOENT;
 
-	inode_lock_nested(parent, I_MUTEX_PARENT);
 	if (!S_ISDIR(parent->i_mode))
-		goto unlock;
+		goto put_parent;
 
 	err = -ENOENT;
 	dir = d_find_alias(parent);
 	if (!dir)
-		goto unlock;
+		goto put_parent;
 
-	name->hash = full_name_hash(dir, name->name, name->len);
-	entry = d_lookup(dir, name);
+	entry = start_removing_noperm(dir, name);
 	dput(dir);
-	if (!entry)
-		goto unlock;
+	if (IS_ERR(entry))
+		goto put_parent;
 
 	fuse_dir_changed(parent);
 	if (!(flags & FUSE_EXPIRE_ONLY))
 		d_invalidate(entry);
 	fuse_invalidate_entry_cache(entry);
 
-	if (child_nodeid != 0 && d_really_is_positive(entry)) {
+	if (child_nodeid != 0) {
 		inode_lock(d_inode(entry));
 		if (get_node_id(d_inode(entry)) != child_nodeid) {
 			err = -ENOENT;
@@ -1451,10 +1449,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	} else {
 		err = 0;
 	}
-	dput(entry);
 
- unlock:
-	inode_unlock(parent);
+	end_dirop(entry);
+ put_parent:
 	iput(parent);
 	return err;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 27a99c276137..34895487045e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3213,6 +3213,54 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing);
 
+/**
+ * start_creating_noperm - prepare to create a given name without permission checking
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
+ * an object in a directory.
+ *
+ * If the name already exists, a positive dentry is returned.
+ *
+ * Returns: a negative or positive dentry, or an error.
+ */
+struct dentry *start_creating_noperm(struct dentry *parent,
+				     struct qstr *name)
+{
+	int err = lookup_noperm_common(name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, LOOKUP_CREATE);
+}
+EXPORT_SYMBOL(start_creating_noperm);
+
+/**
+ * start_removing_noperm - prepare to remove a given name without permission checking
+ * @parent - directory in which to find the name
+ * @name - the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_dirop() should be called when removal is complete, or aborted.
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing_noperm(struct dentry *parent,
+				     struct qstr *name)
+{
+	int err = lookup_noperm_common(name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, 0);
+}
+EXPORT_SYMBOL(start_removing_noperm);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 9c12cb844231..aa2f747039e8 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -152,11 +152,10 @@ xrep_orphanage_create(
 	}
 
 	/* Try to find the orphanage directory. */
-	inode_lock_nested(root_inode, I_MUTEX_PARENT);
-	orphanage_dentry = lookup_noperm(&QSTR(ORPHANAGE), root_dentry);
+	orphanage_dentry = start_creating_noperm(root_dentry, &QSTR(ORPHANAGE));
 	if (IS_ERR(orphanage_dentry)) {
 		error = PTR_ERR(orphanage_dentry);
-		goto out_unlock_root;
+		goto out_dput_root;
 	}
 
 	/*
@@ -170,7 +169,7 @@ xrep_orphanage_create(
 					     orphanage_dentry, 0750);
 		error = PTR_ERR(orphanage_dentry);
 		if (IS_ERR(orphanage_dentry))
-			goto out_unlock_root;
+			goto out_dput_orphanage;
 	}
 
 	/* Not a directory? Bail out. */
@@ -200,9 +199,7 @@ xrep_orphanage_create(
 	sc->orphanage_ilock_flags = 0;
 
 out_dput_orphanage:
-	dput(orphanage_dentry);
-out_unlock_root:
-	inode_unlock(VFS_I(sc->mp->m_rootip));
+	end_dirop_mkdir(orphanage_dentry, root_dentry);
 out_dput_root:
 	dput(root_dentry);
 out:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5feb92b84d84..d765a23c87e4 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -85,6 +85,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
 struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
 
 void end_dirop(struct dentry *de);
 void end_dirop_mkdir(struct dentry *de, struct dentry *parent);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..407ef49f2dbc 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -913,13 +913,11 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		goto out_putname;
 
 	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
-	inode_lock(d_inode(root));
-	path.dentry = lookup_noperm(&QSTR(name->name), root);
+	path.dentry = start_creating_noperm(root, &QSTR(name->name));
 	if (IS_ERR(path.dentry)) {
 		error = PTR_ERR(path.dentry);
 		goto out_putfd;
 	}
-	path.mnt = mntget(mnt);
 	error = prepare_open(path.dentry, oflag, ro, mode, name, attr);
 	if (!error) {
 		struct file *file = dentry_open(&path, oflag, current_cred());
@@ -928,13 +926,12 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		else
 			error = PTR_ERR(file);
 	}
-	path_put(&path);
 out_putfd:
 	if (error) {
 		put_unused_fd(fd);
 		fd = error;
 	}
-	inode_unlock(d_inode(root));
+	end_dirop(path.dentry);
 	if (!ro)
 		mnt_drop_write(mnt);
 out_putname:
-- 
2.50.0.107.gf914562f5916.dirty


