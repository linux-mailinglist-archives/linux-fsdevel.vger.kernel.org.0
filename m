Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C3960E42
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 02:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfGFAWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 20:22:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47716 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGFAWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:22:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjYTM-0006o8-R3; Sat, 06 Jul 2019 00:22:36 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] get rid of detach_mnt()
Date:   Sat,  6 Jul 2019 01:22:35 +0100
Message-Id: <20190706002236.26113-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
References: <20190706001612.GM17978@ZenIV.linux.org.uk>
 <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Lift getting the original mount (dentry is actually not needed at all)
of the mountpoint into the callers - to do_move_mount() and pivot_root()
level.  That simplifies the cleanup in those and allows to get saner
arguments for attach_mnt_recursive().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 62 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 911675de2a70..326a9ab591bc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -815,16 +815,6 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
 /*
  * vfsmount lock must be held for write
  */
-static void detach_mnt(struct mount *mnt, struct path *old_path)
-{
-	old_path->dentry = dget(mnt->mnt_mountpoint);
-	old_path->mnt = &mnt->mnt_parent->mnt;
-	put_mountpoint(unhash_mnt(mnt), NULL);
-}
-
-/*
- * vfsmount lock must be held for write
- */
 static void umount_mnt(struct mount *mnt, struct list_head *list)
 {
 	put_mountpoint(unhash_mnt(mnt), list);
@@ -2037,7 +2027,7 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 static int attach_recursive_mnt(struct mount *source_mnt,
 			struct mount *dest_mnt,
 			struct mountpoint *dest_mp,
-			struct path *parent_path)
+			bool moving)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
@@ -2055,7 +2045,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		return PTR_ERR(smp);
 
 	/* Is there space to add these mounts to the mount namespace? */
-	if (!parent_path) {
+	if (!moving) {
 		err = count_mounts(ns, source_mnt);
 		if (err)
 			goto out;
@@ -2074,8 +2064,8 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	} else {
 		lock_mount_hash();
 	}
-	if (parent_path) {
-		detach_mnt(source_mnt, parent_path);
+	if (moving) {
+		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
@@ -2173,7 +2163,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp, NULL);
+	return attach_recursive_mnt(mnt, p, mp, false);
 }
 
 /*
@@ -2566,11 +2556,11 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
 
 static int do_move_mount(struct path *old_path, struct path *new_path)
 {
-	struct path parent_path = {.mnt = NULL, .dentry = NULL};
 	struct mnt_namespace *ns;
 	struct mount *p;
 	struct mount *old;
-	struct mountpoint *mp;
+	struct mount *parent;
+	struct mountpoint *mp, *old_mp;
 	int err;
 	bool attached;
 
@@ -2580,7 +2570,9 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
+	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
+	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -2608,7 +2600,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	/*
 	 * Don't move a mount residing in a shared parent.
 	 */
-	if (attached && IS_MNT_SHARED(old->mnt_parent))
+	if (attached && IS_MNT_SHARED(parent))
 		goto out;
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
@@ -2624,18 +2616,21 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 			goto out;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   attached ? &parent_path : NULL);
+				   attached);
 	if (err)
 		goto out;
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
+	if (attached)
+		put_mountpoint(old_mp, NULL);
 out:
 	unlock_mount(mp);
 	if (!err) {
-		path_put(&parent_path);
-		if (!attached)
+		if (attached)
+			mntput_no_expire(parent);
+		else
 			free_mnt_ns(ns);
 	}
 	return err;
@@ -3578,8 +3573,8 @@ EXPORT_SYMBOL(path_is_under);
 SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		const char __user *, put_old)
 {
-	struct path new, old, parent_path, root_parent, root;
-	struct mount *new_mnt, *root_mnt, *old_mnt;
+	struct path new, old, root;
+	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
 	struct mountpoint *old_mp, *root_mp;
 	int error;
 
@@ -3608,9 +3603,11 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	new_mnt = real_mount(new.mnt);
 	root_mnt = real_mount(root.mnt);
 	old_mnt = real_mount(old.mnt);
+	ex_parent = new_mnt->mnt_parent;
+	root_parent = root_mnt->mnt_parent;
 	if (IS_MNT_SHARED(old_mnt) ||
-		IS_MNT_SHARED(new_mnt->mnt_parent) ||
-		IS_MNT_SHARED(root_mnt->mnt_parent))
+		IS_MNT_SHARED(ex_parent) ||
+		IS_MNT_SHARED(root_parent))
 		goto out4;
 	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
 		goto out4;
@@ -3627,7 +3624,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		goto out4; /* not a mountpoint */
 	if (!mnt_has_parent(root_mnt))
 		goto out4; /* not attached */
-	root_mp = root_mnt->mnt_mp;
 	if (new.mnt->mnt_root != new.dentry)
 		goto out4; /* not a mountpoint */
 	if (!mnt_has_parent(new_mnt))
@@ -3638,10 +3634,9 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	/* make certain new is below the root */
 	if (!is_path_reachable(new_mnt, new.dentry, &root))
 		goto out4;
-	root_mp->m_count++; /* pin it so it won't go away */
 	lock_mount_hash();
-	detach_mnt(new_mnt, &parent_path);
-	detach_mnt(root_mnt, &root_parent);
+	put_mountpoint(unhash_mnt(new_mnt), NULL);
+	root_mp = unhash_mnt(root_mnt);
 	if (root_mnt->mnt.mnt_flags & MNT_LOCKED) {
 		new_mnt->mnt.mnt_flags |= MNT_LOCKED;
 		root_mnt->mnt.mnt_flags &= ~MNT_LOCKED;
@@ -3649,7 +3644,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	/* mount old root on put_old */
 	attach_mnt(root_mnt, old_mnt, old_mp);
 	/* mount new_root on / */
-	attach_mnt(new_mnt, real_mount(root_parent.mnt), root_mp);
+	attach_mnt(new_mnt, root_parent, root_mp);
+	mnt_add_count(root_parent, -1);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
 	list_del_init(&new_mnt->mnt_expire);
@@ -3659,10 +3655,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = 0;
 out4:
 	unlock_mount(old_mp);
-	if (!error) {
-		path_put(&root_parent);
-		path_put(&parent_path);
-	}
+	if (!error)
+		mntput_no_expire(ex_parent);
 out3:
 	path_put(&root);
 out2:
-- 
2.11.0

