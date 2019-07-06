Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B232C60E47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 02:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfGFAWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 20:22:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47720 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfGFAWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:22:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjYTN-0006oF-1q; Sat, 06 Jul 2019 00:22:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] switch the remnants of releasing the mountpoint away from fs_pin
Date:   Sat,  6 Jul 2019 01:22:36 +0100
Message-Id: <20190706002236.26113-6-viro@ZenIV.linux.org.uk>
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

We used to need rather convoluted ordering trickery to guarantee
that dput() of ex-mountpoints happens before the final mntput()
of the same.  Since we don't need that anymore, there's no point
playing with fs_pin for that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fs_pin.c            | 10 ++--------
 fs/mount.h             |  7 +++++--
 fs/namespace.c         | 37 +++++++++++++++++++------------------
 include/linux/fs_pin.h |  1 -
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index a6497cf8ae53..47ef3c71ce90 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -19,20 +19,14 @@ void pin_remove(struct fs_pin *pin)
 	spin_unlock_irq(&pin->wait.lock);
 }
 
-void pin_insert_group(struct fs_pin *pin, struct vfsmount *m, struct hlist_head *p)
+void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 {
 	spin_lock(&pin_lock);
-	if (p)
-		hlist_add_head(&pin->s_list, p);
+	hlist_add_head(&pin->s_list, &m->mnt_sb->s_pins);
 	hlist_add_head(&pin->m_list, &real_mount(m)->mnt_pins);
 	spin_unlock(&pin_lock);
 }
 
-void pin_insert(struct fs_pin *pin, struct vfsmount *m)
-{
-	pin_insert_group(pin, m, &m->mnt_sb->s_pins);
-}
-
 void pin_kill(struct fs_pin *p)
 {
 	wait_queue_entry_t wait;
diff --git a/fs/mount.h b/fs/mount.h
index 84aa8cdf4971..711a4093e475 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -58,7 +58,10 @@ struct mount {
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
 	struct mnt_namespace *mnt_ns;	/* containing namespace */
 	struct mountpoint *mnt_mp;	/* where is it mounted */
-	struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
+	union {
+		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
+		struct hlist_node mnt_umount;
+	};
 	struct list_head mnt_umounting; /* list entry for umount propagation */
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
@@ -68,7 +71,7 @@ struct mount {
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
-	struct fs_pin mnt_umount;
+	struct hlist_head mnt_stuck_children;
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
diff --git a/fs/namespace.c b/fs/namespace.c
index 326a9ab591bc..a5d0eac9749d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -171,13 +171,6 @@ unsigned int mnt_get_count(struct mount *mnt)
 #endif
 }
 
-static void drop_mountpoint(struct fs_pin *p)
-{
-	struct mount *m = container_of(p, struct mount, mnt_umount);
-	pin_remove(p);
-	mntput(&m->mnt);
-}
-
 static struct mount *alloc_vfsmnt(const char *name)
 {
 	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
@@ -215,7 +208,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_LIST_HEAD(&mnt->mnt_slave);
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_LIST_HEAD(&mnt->mnt_umounting);
-		init_fs_pin(&mnt->mnt_umount, drop_mountpoint);
+		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
 	}
 	return mnt;
 
@@ -1079,19 +1072,22 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 static void cleanup_mnt(struct mount *mnt)
 {
+	struct hlist_node *p;
+	struct mount *m;
 	/*
-	 * This probably indicates that somebody messed
-	 * up a mnt_want/drop_write() pair.  If this
-	 * happens, the filesystem was probably unable
-	 * to make r/w->r/o transitions.
-	 */
-	/*
+	 * The warning here probably indicates that somebody messed
+	 * up a mnt_want/drop_write() pair.  If this happens, the
+	 * filesystem was probably unable to make r/w->r/o transitions.
 	 * The locking used to deal with mnt_count decrement provides barriers,
 	 * so mnt_get_writers() below is safe.
 	 */
 	WARN_ON(mnt_get_writers(mnt));
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
+	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
 	fsnotify_vfsmount_delete(&mnt->mnt);
 	dput(mnt->mnt.mnt_root);
 	deactivate_super(mnt->mnt.mnt_sb);
@@ -1160,6 +1156,7 @@ static void mntput_no_expire(struct mount *mnt)
 		struct mount *p, *tmp;
 		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
 			umount_mnt(p, &list);
+			hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
 		}
 	}
 	unlock_mount_hash();
@@ -1352,6 +1349,8 @@ EXPORT_SYMBOL(may_umount);
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
+	struct hlist_node *p;
+	struct mount *m;
 	LIST_HEAD(list);
 
 	hlist_move_list(&unmounted, &head);
@@ -1366,7 +1365,10 @@ static void namespace_unlock(void)
 
 	synchronize_rcu_expedited();
 
-	group_pin_kill(&head);
+	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
 }
 
 static inline void namespace_lock(void)
@@ -1453,8 +1455,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 		disconnect = disconnect_mount(p, how);
 
-		pin_insert_group(&p->mnt_umount, &p->mnt_parent->mnt,
-				 disconnect ? &unmounted : NULL);
 		if (mnt_has_parent(p)) {
 			mnt_add_count(p->mnt_parent, -1);
 			if (!disconnect) {
@@ -1462,6 +1462,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
 			} else {
 				umount_mnt(p, NULL);
+				hlist_add_head(&p->mnt_umount, &unmounted);
 			}
 		}
 		change_mnt_propagation(p, MS_PRIVATE);
@@ -1614,8 +1615,8 @@ void __detach_mounts(struct dentry *dentry)
 	while (!hlist_empty(&mp->m_list)) {
 		mnt = hlist_entry(mp->m_list.first, struct mount, mnt_mp_list);
 		if (mnt->mnt.mnt_flags & MNT_UMOUNT) {
-			hlist_add_head(&mnt->mnt_umount.s_list, &unmounted);
 			umount_mnt(mnt, NULL);
+			hlist_add_head(&mnt->mnt_umount, &unmounted);
 		}
 		else umount_tree(mnt, UMOUNT_CONNECTED);
 	}
diff --git a/include/linux/fs_pin.h b/include/linux/fs_pin.h
index 7cab74d66f85..bdd09fd2520c 100644
--- a/include/linux/fs_pin.h
+++ b/include/linux/fs_pin.h
@@ -20,6 +20,5 @@ static inline void init_fs_pin(struct fs_pin *p, void (*kill)(struct fs_pin *))
 }
 
 void pin_remove(struct fs_pin *);
-void pin_insert_group(struct fs_pin *, struct vfsmount *, struct hlist_head *);
 void pin_insert(struct fs_pin *, struct vfsmount *);
 void pin_kill(struct fs_pin *);
-- 
2.11.0

