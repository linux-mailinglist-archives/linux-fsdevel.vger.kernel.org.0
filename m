Return-Path: <linux-fsdevel+bounces-501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2257CB63D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF85B1C20C1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C938FAA;
	Mon, 16 Oct 2023 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AP798oGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A938F95
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 22:08:41 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F7A2;
	Mon, 16 Oct 2023 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=G1EUxetWjs0qOtiUH5tq0mLBZ10VZFvJHINvC7djz08=; b=AP798oGVcQFaoR+bfW9MbfgGz1
	zelAD9u35kqPo1eM3njrtfroxaF4lOY4JYIHcduw2vfFS+HwW1RO7V9wH0pEuJhSZGAzGXG2I12La
	P4i27v//FxpHatdl2vHmNRJZruJ829xkgC6ClzEWmOksLiSMr8sAtTva6cEgzxQNcNk8us9mncOOe
	E5wD+aY3lQ0hhszKritoyXhdpRQRAppXXLSEdjhP/9qu/3zpI+pOiGrjitbHW/OlxAl0gOI1oMUaS
	9jpjqdo0RWT3WdF+XotVMT2UmqFjxSs+E7+1T8DaR40CZIbQ4+yf7nX4cQePLvYrszHxV6+bOPaeL
	1rH83buQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsVlL-001rfB-2f;
	Mon, 16 Oct 2023 22:08:36 +0000
Date: Mon, 16 Oct 2023 23:08:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH][RFC] selinuxfs: saner handling of policy reloads
Message-ID: <20231016220835.GH800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[
That thing sits in viro/vfs.git#work.selinuxfs; I have
lock_rename()-related followups in another branch, so a pull would be more
convenient for me than cherry-pick.  NOTE: testing and comments would
be very welcome - as it is, the patch is pretty much untested beyond
"it builds".
]

On policy reload selinuxfs replaces two subdirectories (/booleans
and /class) with new variants.  Unfortunately, that's done with
serious abuses of directory locking.

1) lock_rename() should be done to parents, not to objects being
exchanged

2) there's a bunch of reasons why it should not be done for directories
that do not have a common ancestor; most of those do not apply to
selinuxfs, but even in the best case the proof is subtle and brittle.

3) failure halfway through the creation of /class will leak
names and values arrays.

4) use of d_genocide() is also rather brittle; it's probably not much of
a bug per se, but e.g. an overmount of /sys/fs/selinuxfs/classes/shm/index
with any regular file will end up with leaked mount on policy reload.
Sure, don't do it, but...

Let's stop messing with disconnected directories; just create
a temporary (/.swapover) with no permissions for anyone (on the
level of ->permission() returing -EPERM, no matter who's calling
it) and build the new /booleans and /class in there; then
lock_rename on root and that temporary directory and d_exchange()
old and new both for class and booleans.  Then unlock and use
simple_recursive_removal() to take the temporary out; it's much
more robust.

And instead of bothering with separate pathways for freeing
new (on failure halfway through) and old (on success) names/values,
do all freeing in one place.  With temporaries swapped with the
old ones when we are past all possible failures.

The only user-visible difference is that /.swapover shows up
(but isn't possible to open, look up into, etc.) for the
duration of policy reload.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6fa640263216..ab4beb1cdf20 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -336,12 +336,9 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 			unsigned long *ino);
 
 /* declaration for sel_make_policy_nodes */
-static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
+static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino);
 
-/* declaration for sel_make_policy_nodes */
-static void sel_remove_entries(struct dentry *de);
-
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -508,13 +505,13 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 				struct selinux_policy *newpolicy)
 {
 	int ret = 0;
-	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir, *old_dentry;
-	unsigned int tmp_bool_num, old_bool_num;
-	char **tmp_bool_names, **old_bool_names;
-	int *tmp_bool_values, *old_bool_values;
+	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir;
+	unsigned int bool_num = 0;
+	char **bool_names = NULL;
+	int *bool_values = NULL;
 	unsigned long tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
 
-	tmp_parent = sel_make_disconnected_dir(fsi->sb, &tmp_ino);
+	tmp_parent = sel_make_swapover_dir(fsi->sb, &tmp_ino);
 	if (IS_ERR(tmp_parent))
 		return PTR_ERR(tmp_parent);
 
@@ -532,8 +529,8 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 		goto out;
 	}
 
-	ret = sel_make_bools(newpolicy, tmp_bool_dir, &tmp_bool_num,
-			     &tmp_bool_names, &tmp_bool_values);
+	ret = sel_make_bools(newpolicy, tmp_bool_dir, &bool_num,
+			     &bool_names, &bool_values);
 	if (ret)
 		goto out;
 
@@ -542,38 +539,30 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	if (ret)
 		goto out;
 
+	lock_rename(tmp_parent, fsi->sb->s_root);
+
 	/* booleans */
-	old_dentry = fsi->bool_dir;
-	lock_rename(tmp_bool_dir, old_dentry);
 	d_exchange(tmp_bool_dir, fsi->bool_dir);
 
-	old_bool_num = fsi->bool_num;
-	old_bool_names = fsi->bool_pending_names;
-	old_bool_values = fsi->bool_pending_values;
-
-	fsi->bool_num = tmp_bool_num;
-	fsi->bool_pending_names = tmp_bool_names;
-	fsi->bool_pending_values = tmp_bool_values;
-
-	sel_remove_old_bool_data(old_bool_num, old_bool_names, old_bool_values);
+	swap(fsi->bool_num, bool_num);
+	swap(fsi->bool_pending_names, bool_names);
+	swap(fsi->bool_pending_values, bool_values);
 
 	fsi->bool_dir = tmp_bool_dir;
-	unlock_rename(tmp_bool_dir, old_dentry);
 
 	/* classes */
-	old_dentry = fsi->class_dir;
-	lock_rename(tmp_class_dir, old_dentry);
 	d_exchange(tmp_class_dir, fsi->class_dir);
 	fsi->class_dir = tmp_class_dir;
-	unlock_rename(tmp_class_dir, old_dentry);
+
+	unlock_rename(tmp_parent, fsi->sb->s_root);
 
 out:
+	sel_remove_old_bool_data(bool_num, bool_names, bool_values);
 	/* Since the other temporary dirs are children of tmp_parent
 	 * this will handle all the cleanup in the case of a failure before
 	 * the swapover
 	 */
-	sel_remove_entries(tmp_parent);
-	dput(tmp_parent); /* d_genocide() only handles the children */
+	simple_recursive_removal(tmp_parent, NULL);
 
 	return ret;
 }
@@ -1351,54 +1340,48 @@ static const struct file_operations sel_commit_bools_ops = {
 	.llseek		= generic_file_llseek,
 };
 
-static void sel_remove_entries(struct dentry *de)
-{
-	d_genocide(de);
-	shrink_dcache_parent(de);
-}
-
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
 			  int **bool_pending_values)
 {
 	int ret;
-	ssize_t len;
-	struct dentry *dentry = NULL;
-	struct inode *inode = NULL;
-	struct inode_security_struct *isec;
-	char **names = NULL, *page;
+	char **names, *page;
 	u32 i, num;
-	int *values = NULL;
-	u32 sid;
 
-	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		goto out;
+		return -ENOMEM;
 
-	ret = security_get_bools(newpolicy, &num, &names, &values);
+	ret = security_get_bools(newpolicy, &num, &names, bool_pending_values);
 	if (ret)
 		goto out;
 
+	*bool_num = num;
+	*bool_pending_names = names;
+
 	for (i = 0; i < num; i++) {
-		ret = -ENOMEM;
+		struct dentry *dentry;
+		struct inode *inode;
+		struct inode_security_struct *isec;
+		ssize_t len;
+		u32 sid;
+
+		len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
+		if (len >= PAGE_SIZE) {
+			ret = -ENAMETOOLONG;
+			break;
+		}
 		dentry = d_alloc_name(bool_dir, names[i]);
-		if (!dentry)
-			goto out;
+		if (!dentry) {
+			ret = -ENOMEM;
+			break;
+		}
 
-		ret = -ENOMEM;
 		inode = sel_make_inode(bool_dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
 		if (!inode) {
 			dput(dentry);
-			goto out;
-		}
-
-		ret = -ENAMETOOLONG;
-		len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
-		if (len >= PAGE_SIZE) {
-			dput(dentry);
-			iput(inode);
-			goto out;
+			ret = -ENOMEM;
+			break;
 		}
 
 		isec = selinux_inode(inode);
@@ -1416,23 +1399,8 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
 		d_add(dentry, inode);
 	}
-	*bool_num = num;
-	*bool_pending_names = names;
-	*bool_pending_values = values;
-
-	free_page((unsigned long)page);
-	return 0;
 out:
 	free_page((unsigned long)page);
-
-	if (names) {
-		for (i = 0; i < num; i++)
-			kfree(names[i]);
-		kfree(names);
-	}
-	kfree(values);
-	sel_remove_entries(bool_dir);
-
 	return ret;
 }
 
@@ -1961,20 +1929,39 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 	return dentry;
 }
 
-static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
+static int reject_all(struct mnt_idmap *idmap, struct inode *inode, int mask)
+{
+	return -EPERM;	// no access for anyone, root or no root.
+}
+
+static const struct inode_operations swapover_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.permission	= reject_all,
+};
+
+static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino)
 {
-	struct inode *inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+	struct dentry *dentry = d_alloc_name(sb->s_root, ".swapover");
+	struct inode *inode;
 
-	if (!inode)
+	if (!dentry)
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode = sel_make_inode(sb, S_IFDIR);
+	if (!inode) {
+		dput(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	inode->i_op = &swapover_dir_inode_operations;
 	inode->i_ino = ++(*ino);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	return d_obtain_alias(inode);
+	inode_lock(sb->s_root->d_inode);
+	d_add(dentry, inode);
+	inode_unlock(sb->s_root->d_inode);
+	return dentry;
 }
 
 #define NULL_FILE_NAME "null"

