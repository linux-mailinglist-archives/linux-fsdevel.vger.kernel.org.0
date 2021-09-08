Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C986403995
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351690AbhIHMQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 08:16:49 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34018 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351687AbhIHMQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:16:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UnhKrU5_1631103338;
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0UnhKrU5_1631103338)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 20:15:38 +0800
From:   Yi Tao <escape@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: [RFC PATCH 1/2] add pinned flags for kernfs node
Date:   Wed,  8 Sep 2021 20:15:12 +0800
Message-Id: <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1631102579.git.escape@linux.alibaba.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
In-Reply-To: <cover.1631102579.git.escape@linux.alibaba.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch is preparing for the implementation of cgroup pool. If a
kernfs node is set to pinned. the data of this node will no longer be
protected by kernfs internally. When it performs the following actions,
the area protected by kernfs_rwsem will be protected by the specific
spinlock:
	1.rename this node
	2.remove this node
	3.create child node

Suggested-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 fs/kernfs/dir.c        | 74 ++++++++++++++++++++++++++++++++++++--------------
 include/linux/kernfs.h | 14 ++++++++++
 2 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ba581429bf7b..68b05b5bc1a2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -26,7 +26,6 @@
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_rwsem);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -461,10 +460,9 @@ static void kernfs_drain(struct kernfs_node *kn)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&kernfs_rwsem);
+	kernfs_unlock(kn);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -483,7 +481,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&kernfs_rwsem);
+	kernfs_lock(kn);
 }
 
 /**
@@ -722,7 +720,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
-	down_write(&kernfs_rwsem);
+	kernfs_lock(parent);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -753,7 +751,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&kernfs_rwsem);
+	kernfs_unlock(parent);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -767,7 +765,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&kernfs_rwsem);
+	kernfs_unlock(parent);
 	return ret;
 }
 
@@ -788,8 +786,6 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_rwsem);
-
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
 		     has_ns ? "required" : "invalid", parent->name, name);
@@ -1242,8 +1238,6 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_rwsem);
-
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
 		return kernfs_leftmost_descendant(root);
@@ -1299,8 +1293,6 @@ static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held_write(&kernfs_rwsem);
-
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
 	 * This is for kernfs_remove_self() which plays with active ref
@@ -1369,9 +1361,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	down_write(&kernfs_rwsem);
+	kernfs_lock(kn);
 	__kernfs_remove(kn);
-	up_write(&kernfs_rwsem);
+	kernfs_unlock(kn);
 }
 
 /**
@@ -1525,13 +1517,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	down_write(&kernfs_rwsem);
+	kernfs_lock(parent);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&kernfs_rwsem);
+	kernfs_unlock(parent);
 
 	if (kn)
 		return 0;
@@ -1557,7 +1549,9 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	down_write(&kernfs_rwsem);
+	/* if parent is pinned, parent->lock protects rename */
+	if (!kn->parent->pinned)
+		down_write(&kernfs_rwsem);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1576,7 +1570,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	/* rename kernfs_node */
 	if (strcmp(kn->name, new_name) != 0) {
 		error = -ENOMEM;
-		new_name = kstrdup_const(new_name, GFP_KERNEL);
+		/* use GFP_ATOMIC to avoid sleep */
+		new_name = kstrdup_const(new_name, GFP_ATOMIC);
 		if (!new_name)
 			goto out;
 	} else {
@@ -1611,10 +1606,49 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&kernfs_rwsem);
+	if (!kn->parent->pinned)
+		up_write(&kernfs_rwsem);
 	return error;
 }
 
+/* Traverse all descendants and set pinned */
+void kernfs_set_pinned(struct kernfs_node *kn, spinlock_t *lock)
+{
+	struct kernfs_node *pos = NULL;
+
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		pos->pinned = true;
+		pos->lock = lock;
+	}
+}
+
+/* Traverse all descendants and clear pinned */
+void kernfs_clear_pinned(struct kernfs_node *kn)
+{
+	struct kernfs_node *pos = NULL;
+
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		pos->pinned = false;
+		pos->lock = NULL;
+	}
+}
+
+void kernfs_lock(struct kernfs_node *kn)
+{
+	if (!kn->pinned)
+		down_write(&kernfs_rwsem);
+	else
+		spin_lock(kn->lock);
+}
+
+void kernfs_unlock(struct kernfs_node *kn)
+{
+	if (!kn->pinned)
+		up_write(&kernfs_rwsem);
+	else
+		spin_unlock(kn->lock);
+}
+
 /* Relationship between mode and the DT_xxx types */
 static inline unsigned char dt_type(struct kernfs_node *kn)
 {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 1093abf7c28c..a70d96308c51 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -161,6 +161,13 @@ struct kernfs_node {
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
+
+	/*
+	 * If pinned is true, use lock to protect remove, rename this kernfs
+	 * node or create child kernfs node.
+	 */
+	bool			pinned;
+	spinlock_t		*lock;
 };
 
 /*
@@ -415,6 +422,11 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id);
+
+void kernfs_set_pinned(struct kernfs_node *kn, spinlock_t *lock);
+void kernfs_clear_pinned(struct kernfs_node *kn);
+void kernfs_lock(struct kernfs_node *kn);
+void kernfs_unlock(struct kernfs_node *kn);
 #else	/* CONFIG_KERNFS */
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
@@ -528,6 +540,8 @@ static inline void kernfs_kill_sb(struct super_block *sb) { }
 
 static inline void kernfs_init(void) { }
 
+inline void kernfs_set_pinned(struct kernfs_node *kn, spinlock_t *lock) {}
+inline void kernfs_clear_pinned(struct kernfs_node *kn) {}
 #endif	/* CONFIG_KERNFS */
 
 /**
-- 
1.8.3.1

