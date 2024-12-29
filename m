Return-Path: <linux-fsdevel+bounces-38234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815269FDDFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F34188278A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B282E55887;
	Sun, 29 Dec 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ObqTYjHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A2481A3
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459950; cv=none; b=oMgxwXrO1yy2xYKVKxD3KcXnmcUnZ+ridAEthH3bDuK8Hjw4ixOgTYfXsArKYmk7guk4aOSnCZ2rKkJtpjDAB6gu6CkgPXWCu/QLGixDzW/072YAISuVXQDOeTiiH1gPJjkEFUxojU5q0K+DBtsVYBWsGTGkQZS15ry48D2rIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459950; c=relaxed/simple;
	bh=wuALVG1q3BtK0QjYJwEh1xS7b0d9ru5lvyXzwQboGX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIUcjqn6TkhPodru2bYn/NbjT9f3mrvGgyqDLCWqvMYjLGD33VX/dLnXYB89LQIGcqDDJdyN8YJ26aySI5gZpiZi7FWLRvr5BnUSHuKWuqu1K3g7qgBen/7LKOWV+99qJqN22g8JYBSpXCriKmWB9Z+xgR3jePJEsoKuRLGuriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ObqTYjHl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g3PelZ5aE+gGm9bEGlmPsZG/LJUmFxczLrwZHhnc4xY=; b=ObqTYjHlY7yjZi3ryYTzWR/5+f
	Ei6HkTJVzv2jikNAbXC0HZtXk2VlrqT1kgdzYVr2nDydgIFKePhdSoshDkrkJFS9EIiaQcXiHpyzR
	s5F7VxeQFLz4SjEXvB9o9TkurX81fZzsDrHnPX7bBaH8keK/20w91erNeLydBb7DW6wt9KHntzhlE
	TSZmWI19Tctf/DMMRHRQiz6RN2fLUuI3SgY1OcJnRd2YPweHuA6bkTazYfz5JPfesp7d3EE+WnzSP
	aYPi4MyDlyf6YYzP3ikwdsiI1jRw30y+AagwG09/bP6PxhB+AEnTXAoEZlLUsEND8dzOFv84ciLgA
	Llp3eunA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPS-0000000DOjP-05Gs;
	Sun, 29 Dec 2024 08:12:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 20/20] saner replacement for debugfs_rename()
Date: Sun, 29 Dec 2024 08:12:23 +0000
Message-ID: <20241229081223.3193228-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Existing primitive has several problems:
	1) calling conventions are clumsy - it returns a dentry reference
that is either identical to its second argument or is an ERR_PTR(-E...);
in both cases no refcount changes happen.  Inconvenient for users and
bug-prone; it would be better to have it return 0 on success and -E... on
failure.
	2) it allows cross-directory moves; however, no such caller have
ever materialized and considering the way debugfs is used, it's unlikely
to happen in the future.  What's more, any such caller would have fun
issues to deal with wrt interplay with recursive removal.  It also makes
the calling conventions clumsier...
	3) tautological rename fails; the callers have no race-free way
to deal with that.
	4) new name must have been formed by the caller; quite a few
callers have it done by sprintf/kasprintf/etc., ending up with considerable
boilerplate.

Proposed replacement: int debugfs_change_name(dentry, fmt, ...).  All callers
convert to that easily, and it's simpler internally.

IMO debugfs_rename() should go; if we ever get a real-world use case for
cross-directory moves in debugfs, we can always look into the right way
to handle that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/debugfs.rst         |  12 +-
 drivers/net/bonding/bond_debugfs.c            |   9 +-
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c  |  19 +---
 drivers/net/ethernet/marvell/skge.c           |   5 +-
 drivers/net/ethernet/marvell/sky2.c           |   5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   6 +-
 drivers/opp/debugfs.c                         |  10 +-
 fs/debugfs/inode.c                            | 106 +++++++++---------
 include/linux/debugfs.h                       |   9 +-
 mm/shrinker_debug.c                           |  16 +--
 net/hsr/hsr_debugfs.c                         |   9 +-
 net/mac80211/debugfs_netdev.c                 |  11 +-
 net/wireless/core.c                           |   5 +-
 13 files changed, 77 insertions(+), 145 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index dc35da8b8792..f7f977ffbf8d 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -211,18 +211,16 @@ seq_file content.
 
 There are a couple of other directory-oriented helper functions::
 
-    struct dentry *debugfs_rename(struct dentry *old_dir,
-    				  struct dentry *old_dentry,
-		                  struct dentry *new_dir,
-				  const char *new_name);
+    struct dentry *debugfs_change_name(struct dentry *dentry,
+					  const char *fmt, ...);
 
     struct dentry *debugfs_create_symlink(const char *name,
                                           struct dentry *parent,
 				      	  const char *target);
 
-A call to debugfs_rename() will give a new name to an existing debugfs
-file, possibly in a different directory.  The new_name must not exist prior
-to the call; the return value is old_dentry with updated information.
+A call to debugfs_change_name() will give a new name to an existing debugfs
+file, always in the same directory.  The new_name must not exist prior
+to the call; the return value is 0 on success and -E... on failuer.
 Symbolic links can be created with debugfs_create_symlink().
 
 There is one important thing that all debugfs users must take into account:
diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index b19492a7f6ad..2b78be129770 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -63,13 +63,8 @@ void bond_debug_unregister(struct bonding *bond)
 
 void bond_debug_reregister(struct bonding *bond)
 {
-	struct dentry *d;
-
-	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
-			   bonding_debug_root, bond->dev->name);
-	if (!IS_ERR(d)) {
-		bond->debug_dir = d;
-	} else {
+	err = debugfs_change_name(bond->debug_dir, "%s", bond->dev->name);
+	if (err) {
 		netdev_warn(bond->dev, "failed to reregister, so just unregister old one\n");
 		bond_debug_unregister(bond);
 	}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c b/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
index b0a6c96b6ef4..b35808d3d07f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
@@ -505,21 +505,6 @@ void xgbe_debugfs_exit(struct xgbe_prv_data *pdata)
 
 void xgbe_debugfs_rename(struct xgbe_prv_data *pdata)
 {
-	char *buf;
-
-	if (!pdata->xgbe_debugfs)
-		return;
-
-	buf = kasprintf(GFP_KERNEL, "amd-xgbe-%s", pdata->netdev->name);
-	if (!buf)
-		return;
-
-	if (!strcmp(pdata->xgbe_debugfs->d_name.name, buf))
-		goto out;
-
-	debugfs_rename(pdata->xgbe_debugfs->d_parent, pdata->xgbe_debugfs,
-		       pdata->xgbe_debugfs->d_parent, buf);
-
-out:
-	kfree(buf);
+	debugfs_change_name(pdata->xgbe_debugfs,
+			    "amd-xgbe-%s", pdata->netdev->name);
 }
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 25bf6ec44289..a1bada9eaaf6 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3742,10 +3742,7 @@ static int skge_device_event(struct notifier_block *unused,
 	skge = netdev_priv(dev);
 	switch (event) {
 	case NETDEV_CHANGENAME:
-		if (skge->debugfs)
-			skge->debugfs = debugfs_rename(skge_debug,
-						       skge->debugfs,
-						       skge_debug, dev->name);
+		debugfs_change_name(skge->debugfs, "%s", dev->name);
 		break;
 
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 3914cd9210d4..719ae94a5f97 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4493,10 +4493,7 @@ static int sky2_device_event(struct notifier_block *unused,
 
 	switch (event) {
 	case NETDEV_CHANGENAME:
-		if (sky2->debugfs) {
-			sky2->debugfs = debugfs_rename(sky2_debug, sky2->debugfs,
-						       sky2_debug, dev->name);
-		}
+		debugfs_change_name(sky2->debugfs, "%s", dev->name);
 		break;
 
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c81ea8cdfe6e..82e2908016bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6489,11 +6489,7 @@ static int stmmac_device_event(struct notifier_block *unused,
 
 	switch (event) {
 	case NETDEV_CHANGENAME:
-		if (priv->dbgfs_dir)
-			priv->dbgfs_dir = debugfs_rename(stmmac_fs_dir,
-							 priv->dbgfs_dir,
-							 stmmac_fs_dir,
-							 dev->name);
+		debugfs_change_name(priv->dbgfs_dir, "%s", dev->name);
 		break;
 	}
 done:
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 105de7c3274a..8fc6238b1728 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -217,7 +217,7 @@ static void opp_migrate_dentry(struct opp_device *opp_dev,
 {
 	struct opp_device *new_dev = NULL, *iter;
 	const struct device *dev;
-	struct dentry *dentry;
+	int err;
 
 	/* Look for next opp-dev */
 	list_for_each_entry(iter, &opp_table->dev_list, node)
@@ -234,16 +234,14 @@ static void opp_migrate_dentry(struct opp_device *opp_dev,
 
 	opp_set_dev_name(dev, opp_table->dentry_name);
 
-	dentry = debugfs_rename(rootdir, opp_dev->dentry, rootdir,
-				opp_table->dentry_name);
-	if (IS_ERR(dentry)) {
+	err = debugfs_change_name(opp_dev->dentry, "%s", opp_table->dentry_name);
+	if (err) {
 		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
 			__func__, dev_name(opp_dev->dev), dev_name(dev));
 		return;
 	}
 
-	new_dev->dentry = dentry;
-	opp_table->dentry = dentry;
+	new_dev->dentry = opp_table->dentry = opp_dev->dentry;
 }
 
 /**
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index c62e6b26412a..948345d1226e 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -830,76 +830,70 @@ void debugfs_lookup_and_remove(const char *name, struct dentry *parent)
 EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
 
 /**
- * debugfs_rename - rename a file/directory in the debugfs filesystem
- * @old_dir: a pointer to the parent dentry for the renamed object. This
- *          should be a directory dentry.
- * @old_dentry: dentry of an object to be renamed.
- * @new_dir: a pointer to the parent dentry where the object should be
- *          moved. This should be a directory dentry.
- * @new_name: a pointer to a string containing the target name.
+ * debugfs_change_name - rename a file/directory in the debugfs filesystem
+ * @dentry: dentry of an object to be renamed.
+ * @fmt: format for new name
  *
  * This function renames a file/directory in debugfs.  The target must not
  * exist for rename to succeed.
  *
- * This function will return a pointer to old_dentry (which is updated to
- * reflect renaming) if it succeeds. If an error occurs, ERR_PTR(-ERROR)
- * will be returned.
+ * This function will return 0 on success and -E... on failure.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
-		struct dentry *new_dir, const char *new_name)
+int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, ...)
 {
-	int error;
-	struct dentry *dentry = NULL, *trap;
+	int error = 0;
+	const char *new_name;
 	struct name_snapshot old_name;
+	struct dentry *parent, *target;
+	struct inode *dir;
+	va_list ap;
 
-	if (IS_ERR(old_dir))
-		return old_dir;
-	if (IS_ERR(new_dir))
-		return new_dir;
-	if (IS_ERR_OR_NULL(old_dentry))
-		return old_dentry;
-
-	trap = lock_rename(new_dir, old_dir);
-	/* Source or destination directories don't exist? */
-	if (d_really_is_negative(old_dir) || d_really_is_negative(new_dir))
-		goto exit;
-	/* Source does not exist, cyclic rename, or mountpoint? */
-	if (d_really_is_negative(old_dentry) || old_dentry == trap ||
-	    d_mountpoint(old_dentry))
-		goto exit;
-	dentry = lookup_one_len(new_name, new_dir, strlen(new_name));
-	/* Lookup failed, cyclic rename or target exists? */
-	if (IS_ERR(dentry) || dentry == trap || d_really_is_positive(dentry))
-		goto exit;
-
-	take_dentry_name_snapshot(&old_name, old_dentry);
-
-	error = simple_rename(&nop_mnt_idmap, d_inode(old_dir), old_dentry,
-			      d_inode(new_dir), dentry, 0);
-	if (error) {
-		release_dentry_name_snapshot(&old_name);
-		goto exit;
+	if (IS_ERR_OR_NULL(dentry))
+		return 0;
+
+	va_start(ap, fmt);
+	new_name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+	if (!new_name)
+		return -ENOMEM;
+
+	parent = dget_parent(dentry);
+	dir = d_inode(parent);
+	inode_lock(dir);
+
+	take_dentry_name_snapshot(&old_name, dentry);
+
+	if (WARN_ON_ONCE(dentry->d_parent != parent)) {
+		error = -EINVAL;
+		goto out;
+	}
+	if (strcmp(old_name.name.name, new_name) == 0)
+		goto out;
+	target = lookup_one_len(new_name, parent, strlen(new_name));
+	if (IS_ERR(target)) {
+		error = PTR_ERR(target);
+		goto out;
 	}
-	d_move(old_dentry, dentry);
-	fsnotify_move(d_inode(old_dir), d_inode(new_dir), &old_name.name,
-		d_is_dir(old_dentry),
-		NULL, old_dentry);
+	if (d_really_is_positive(target)) {
+		dput(target);
+		error = -EINVAL;
+		goto out;
+	}
+	simple_rename_timestamp(dir, dentry, dir, target);
+	d_move(dentry, target);
+	dput(target);
+	fsnotify_move(dir, dir, &old_name.name, d_is_dir(dentry), NULL, dentry);
+out:
 	release_dentry_name_snapshot(&old_name);
-	unlock_rename(new_dir, old_dir);
-	dput(dentry);
-	return old_dentry;
-exit:
-	if (dentry && !IS_ERR(dentry))
-		dput(dentry);
-	unlock_rename(new_dir, old_dir);
-	if (IS_ERR(dentry))
-		return dentry;
-	return ERR_PTR(-EINVAL);
+	inode_unlock(dir);
+	dput(parent);
+	kfree_const(new_name);
+	return error;
 }
-EXPORT_SYMBOL_GPL(debugfs_rename);
+EXPORT_SYMBOL_GPL(debugfs_change_name);
 
 /**
  * debugfs_initialized - Tells whether debugfs has been registered
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7c97417d73b5..9ad00d8b6f89 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -175,8 +175,7 @@ ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
 			size_t len, loff_t *ppos);
 
-struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
-                struct dentry *new_dir, const char *new_name);
+int debugfs_change_name(struct dentry *dentry, const char *fmt, ...) __printf(2, 3);
 
 void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
@@ -361,10 +360,10 @@ static inline ssize_t debugfs_attr_write_signed(struct file *file,
 	return -ENODEV;
 }
 
-static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
-                struct dentry *new_dir, char *new_name)
+static inline int __printf(2, 3) debugfs_change_name(struct dentry *dentry,
+					const char *fmt, ...)
 {
-	return ERR_PTR(-ENODEV);
+	return -ENODEV;
 }
 
 static inline void debugfs_create_u8(const char *name, umode_t mode,
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 4a85b94d12ce..794bd433cce0 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -195,8 +195,6 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
-	struct dentry *entry;
-	char buf[128];
 	const char *new, *old;
 	va_list ap;
 	int ret = 0;
@@ -213,18 +211,8 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 	old = shrinker->name;
 	shrinker->name = new;
 
-	if (shrinker->debugfs_entry) {
-		snprintf(buf, sizeof(buf), "%s-%d", shrinker->name,
-			 shrinker->debugfs_id);
-
-		entry = debugfs_rename(shrinker_debugfs_root,
-				       shrinker->debugfs_entry,
-				       shrinker_debugfs_root, buf);
-		if (IS_ERR(entry))
-			ret = PTR_ERR(entry);
-		else
-			shrinker->debugfs_entry = entry;
-	}
+	ret = debugfs_change_name(shrinker->debugfs_entry, "%s-%d",
+			shrinker->name, shrinker->debugfs_id);
 
 	mutex_unlock(&shrinker_mutex);
 
diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index 1a195efc79cd..5b2cfac3b2ba 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -57,14 +57,11 @@ DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
 void hsr_debugfs_rename(struct net_device *dev)
 {
 	struct hsr_priv *priv = netdev_priv(dev);
-	struct dentry *d;
+	int err;
 
-	d = debugfs_rename(hsr_debugfs_root_dir, priv->node_tbl_root,
-			   hsr_debugfs_root_dir, dev->name);
-	if (IS_ERR(d))
+	err = debugfs_change_name(priv->node_tbl_root, "%s", dev->name);
+	if (err)
 		netdev_warn(dev, "failed to rename\n");
-	else
-		priv->node_tbl_root = d;
 }
 
 /* hsr_debugfs_init - create hsr node_table file for dumping
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index a9bc2fd59f55..9fa38c489edc 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -1025,16 +1025,7 @@ void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata)
 {
-	struct dentry *dir;
-	char buf[10 + IFNAMSIZ];
-
-	dir = sdata->vif.debugfs_dir;
-
-	if (IS_ERR_OR_NULL(dir))
-		return;
-
-	sprintf(buf, "netdev:%s", sdata->name);
-	debugfs_rename(dir->d_parent, dir, dir->d_parent, buf);
+	debugfs_change_name(sdata->vif.debugfs_dir, "netdev:%s", sdata->name);
 }
 
 void ieee80211_debugfs_recreate_netdev(struct ieee80211_sub_if_data *sdata,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index afbdc549fb4a..9130cb872ed3 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -143,10 +143,7 @@ int cfg80211_dev_rename(struct cfg80211_registered_device *rdev,
 	if (result)
 		return result;
 
-	if (!IS_ERR_OR_NULL(rdev->wiphy.debugfsdir))
-		debugfs_rename(rdev->wiphy.debugfsdir->d_parent,
-			       rdev->wiphy.debugfsdir,
-			       rdev->wiphy.debugfsdir->d_parent, newname);
+	debugfs_change_name(rdev->wiphy.debugfsdir, "%s", newname);
 
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
 
-- 
2.39.5


