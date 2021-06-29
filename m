Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC033B7853
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhF2TOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:14:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhF2TOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:14:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8E5791F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 04/15] fanotify: Split superblock marks out to a new cache
Date:   Tue, 29 Jun 2021 15:10:24 -0400
Message-Id: <20210629191035.681913-5-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_ERROR will require an error structure to be stored per mark.  But,
since FAN_ERROR doesn't apply to inode/mount marks, it should suffice to
only expose this information for superblock marks. Therefore, wrap this
kind of marks into a container and plumb it for the future.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Move mark initialization to fanotify_alloc_mark (Amir)

Changes since v1:
  - Only extend superblock marks (Amir)
---
 fs/notify/fanotify/fanotify.c      | 10 ++++++--
 fs/notify/fanotify/fanotify.h      | 13 ++++++++++
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++--
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 310246f8d3f1..0f760770d4c9 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -869,9 +869,15 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
 		dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
 }
 
-static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
+static void fanotify_free_mark(struct fsnotify_mark *mark)
 {
-	kmem_cache_free(fanotify_mark_cache, fsn_mark);
+	if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
+		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
+
+		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
+	} else {
+		kmem_cache_free(fanotify_mark_cache, mark);
+	}
 }
 
 const struct fsnotify_ops fanotify_fsnotify_ops = {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4a5e555dc3d2..fd125a949187 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -6,6 +6,7 @@
 #include <linux/hashtable.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
+extern struct kmem_cache *fanotify_sb_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
@@ -129,6 +130,18 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 	       name->name);
 }
 
+struct fanotify_sb_mark {
+	struct fsnotify_mark fsn_mark;
+};
+
+static inline
+struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
+{
+	WARN_ON(!(mark->flags & FSNOTIFY_MARK_FLAG_SB));
+
+	return container_of(mark, struct fanotify_sb_mark, fsn_mark);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 67b18dfe0025..a42521e140e6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -99,6 +99,7 @@ struct ctl_table fanotify_table[] = {
 extern const struct fsnotify_ops fanotify_fsnotify_ops;
 
 struct kmem_cache *fanotify_mark_cache __read_mostly;
+struct kmem_cache *fanotify_sb_mark_cache __read_mostly;
 struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
 struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
@@ -915,6 +916,38 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	return mask & ~oldmask;
 }
 
+static struct fsnotify_mark *fanotify_alloc_mark(struct fsnotify_group *group,
+						 unsigned int type)
+{
+	struct fanotify_sb_mark *sb_mark;
+	struct fsnotify_mark *mark;
+
+	switch (type) {
+	case FSNOTIFY_OBJ_TYPE_SB:
+		sb_mark = kmem_cache_zalloc(fanotify_sb_mark_cache, GFP_KERNEL);
+		if (!sb_mark)
+			return NULL;
+		mark = &sb_mark->fsn_mark;
+		break;
+
+	case FSNOTIFY_OBJ_TYPE_INODE:
+	case FSNOTIFY_OBJ_TYPE_PARENT:
+	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
+		mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+		break;
+	default:
+		WARN_ON(1);
+		return NULL;
+	}
+
+	fsnotify_init_mark(mark, group);
+
+	if (type == FSNOTIFY_OBJ_TYPE_SB)
+		mark->flags |= FSNOTIFY_MARK_FLAG_SB;
+
+	return mark;
+}
+
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int type,
@@ -933,13 +966,12 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
 
-	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	mark = fanotify_alloc_mark(group, type);
 	if (!mark) {
 		ret = -ENOMEM;
 		goto out_dec_ucounts;
 	}
 
-	fsnotify_init_mark(mark, group);
 	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
@@ -1497,6 +1529,8 @@ static int __init fanotify_user_setup(void)
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
+	fanotify_sb_mark_cache = KMEM_CACHE(fanotify_sb_mark,
+					    SLAB_PANIC|SLAB_ACCOUNT);
 	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
 					       SLAB_PANIC);
 	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..c4473b467c28 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -401,6 +401,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x01
 #define FSNOTIFY_MARK_FLAG_ALIVE		0x02
 #define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
+#define FSNOTIFY_MARK_FLAG_SB			0x08
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.32.0

