Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1460E43
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 02:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfGFAWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 20:22:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47712 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGFAWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:22:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjYTM-0006o2-LB; Sat, 06 Jul 2019 00:22:36 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] make struct mountpoint bear the dentry reference to mountpoint, not struct mount
Date:   Sat,  6 Jul 2019 01:22:34 +0100
Message-Id: <20190706002236.26113-4-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  1 -
 fs/namespace.c | 66 +++++++++++++++++++++++++---------------------------------
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 6250de544760..84aa8cdf4971 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -69,7 +69,6 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct fs_pin mnt_umount;
-	struct dentry *mnt_ex_mountpoint;
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
diff --git a/fs/namespace.c b/fs/namespace.c
index b7059a4f07e3..911675de2a70 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -69,6 +69,8 @@ static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
 static struct kmem_cache *mnt_cache __read_mostly;
 static DECLARE_RWSEM(namespace_sem);
+static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
+static LIST_HEAD(ex_mountpoints);
 
 /* /sys/fs */
 struct kobject *fs_kobj;
@@ -172,7 +174,6 @@ unsigned int mnt_get_count(struct mount *mnt)
 static void drop_mountpoint(struct fs_pin *p)
 {
 	struct mount *m = container_of(p, struct mount, mnt_umount);
-	dput(m->mnt_ex_mountpoint);
 	pin_remove(p);
 	mntput(&m->mnt);
 }
@@ -739,7 +740,7 @@ static struct mountpoint *get_mountpoint(struct dentry *dentry)
 
 	/* Add the new mountpoint to the hash table */
 	read_seqlock_excl(&mount_lock);
-	new->m_dentry = dentry;
+	new->m_dentry = dget(dentry);
 	new->m_count = 1;
 	hlist_add_head(&new->m_hash, mp_hash(dentry));
 	INIT_HLIST_HEAD(&new->m_list);
@@ -752,7 +753,7 @@ static struct mountpoint *get_mountpoint(struct dentry *dentry)
 	return mp;
 }
 
-static void put_mountpoint(struct mountpoint *mp)
+static void put_mountpoint(struct mountpoint *mp, struct list_head *list)
 {
 	if (!--mp->m_count) {
 		struct dentry *dentry = mp->m_dentry;
@@ -760,6 +761,9 @@ static void put_mountpoint(struct mountpoint *mp)
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags &= ~DCACHE_MOUNTED;
 		spin_unlock(&dentry->d_lock);
+		if (!list)
+			list = &ex_mountpoints;
+		dput_to_list(dentry, list);
 		hlist_del(&mp->m_hash);
 		kfree(mp);
 	}
@@ -813,19 +817,17 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
  */
 static void detach_mnt(struct mount *mnt, struct path *old_path)
 {
-	old_path->dentry = mnt->mnt_mountpoint;
+	old_path->dentry = dget(mnt->mnt_mountpoint);
 	old_path->mnt = &mnt->mnt_parent->mnt;
-	put_mountpoint(unhash_mnt(mnt));
+	put_mountpoint(unhash_mnt(mnt), NULL);
 }
 
 /*
  * vfsmount lock must be held for write
  */
-static void umount_mnt(struct mount *mnt)
+static void umount_mnt(struct mount *mnt, struct list_head *list)
 {
-	/* old mountpoint will be dropped when we can do that */
-	mnt->mnt_ex_mountpoint = mnt->mnt_mountpoint;
-	put_mountpoint(unhash_mnt(mnt));
+	put_mountpoint(unhash_mnt(mnt), list);
 }
 
 /*
@@ -837,7 +839,7 @@ void mnt_set_mountpoint(struct mount *mnt,
 {
 	mp->m_count++;
 	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
-	child_mnt->mnt_mountpoint = dget(mp->m_dentry);
+	child_mnt->mnt_mountpoint = mp->m_dentry;
 	child_mnt->mnt_parent = mnt;
 	child_mnt->mnt_mp = mp;
 	hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
@@ -864,7 +866,6 @@ static void attach_mnt(struct mount *mnt,
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
 {
 	struct mountpoint *old_mp = mnt->mnt_mp;
-	struct dentry *old_mountpoint = mnt->mnt_mountpoint;
 	struct mount *old_parent = mnt->mnt_parent;
 
 	list_del_init(&mnt->mnt_child);
@@ -873,23 +874,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 
 	attach_mnt(mnt, parent, mp);
 
-	put_mountpoint(old_mp);
-
-	/*
-	 * Safely avoid even the suggestion this code might sleep or
-	 * lock the mount hash by taking advantage of the knowledge that
-	 * mnt_change_mountpoint will not release the final reference
-	 * to a mountpoint.
-	 *
-	 * During mounting, the mount passed in as the parent mount will
-	 * continue to use the old mountpoint and during unmounting, the
-	 * old mountpoint will continue to exist until namespace_unlock,
-	 * which happens well after mnt_change_mountpoint.
-	 */
-	spin_lock(&old_mountpoint->d_lock);
-	old_mountpoint->d_lockref.count--;
-	spin_unlock(&old_mountpoint->d_lock);
-
+	put_mountpoint(old_mp, NULL);
 	mnt_add_count(old_parent, -1);
 }
 
@@ -1142,6 +1127,8 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
 static void mntput_no_expire(struct mount *mnt)
 {
+	LIST_HEAD(list);
+
 	rcu_read_lock();
 	if (likely(READ_ONCE(mnt->mnt_ns))) {
 		/*
@@ -1182,10 +1169,11 @@ static void mntput_no_expire(struct mount *mnt)
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
 		struct mount *p, *tmp;
 		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
-			umount_mnt(p);
+			umount_mnt(p, &list);
 		}
 	}
 	unlock_mount_hash();
+	shrink_dentry_list(&list);
 
 	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
 		struct task_struct *task = current;
@@ -1371,16 +1359,18 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
-
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
+	LIST_HEAD(list);
 
 	hlist_move_list(&unmounted, &head);
+	list_splice_init(&ex_mountpoints, &list);
 
 	up_write(&namespace_sem);
 
+	shrink_dentry_list(&list);
+
 	if (likely(hlist_empty(&head)))
 		return;
 
@@ -1481,7 +1471,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 				/* Don't forget about p */
 				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
 			} else {
-				umount_mnt(p);
+				umount_mnt(p, NULL);
 			}
 		}
 		change_mnt_propagation(p, MS_PRIVATE);
@@ -1635,11 +1625,11 @@ void __detach_mounts(struct dentry *dentry)
 		mnt = hlist_entry(mp->m_list.first, struct mount, mnt_mp_list);
 		if (mnt->mnt.mnt_flags & MNT_UMOUNT) {
 			hlist_add_head(&mnt->mnt_umount.s_list, &unmounted);
-			umount_mnt(mnt);
+			umount_mnt(mnt, NULL);
 		}
 		else umount_tree(mnt, UMOUNT_CONNECTED);
 	}
-	put_mountpoint(mp);
+	put_mountpoint(mp, NULL);
 out_unlock:
 	unlock_mount_hash();
 	namespace_unlock();
@@ -2110,7 +2100,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		commit_tree(child);
 	}
-	put_mountpoint(smp);
+	put_mountpoint(smp, NULL);
 	unlock_mount_hash();
 
 	return 0;
@@ -2127,7 +2117,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	ns->pending_mounts = 0;
 
 	read_seqlock_excl(&mount_lock);
-	put_mountpoint(smp);
+	put_mountpoint(smp, NULL);
 	read_sequnlock_excl(&mount_lock);
 
 	return err;
@@ -2167,7 +2157,7 @@ static void unlock_mount(struct mountpoint *where)
 	struct dentry *dentry = where->m_dentry;
 
 	read_seqlock_excl(&mount_lock);
-	put_mountpoint(where);
+	put_mountpoint(where, NULL);
 	read_sequnlock_excl(&mount_lock);
 
 	namespace_unlock();
@@ -3663,7 +3653,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
 	list_del_init(&new_mnt->mnt_expire);
-	put_mountpoint(root_mp);
+	put_mountpoint(root_mp, NULL);
 	unlock_mount_hash();
 	chroot_fs_refs(&root, &new);
 	error = 0;
-- 
2.11.0

