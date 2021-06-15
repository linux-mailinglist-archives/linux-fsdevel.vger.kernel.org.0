Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00893A8CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhFOX62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:58:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhFOX6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3485A1F432EA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 04/14] fanotify: Split superblock marks out to a new cache
Date:   Tue, 15 Jun 2021 19:55:46 -0400
Message-Id: <20210615235556.970928-5-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
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
Changes since v1:
  - Only extend superblock marks
---
 fs/notify/fanotify/fanotify.c      | 10 ++++++++--
 fs/notify/fanotify/fanotify.h      | 11 +++++++++++
 fs/notify/fanotify/fanotify_user.c | 29 ++++++++++++++++++++++++++++-
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 057abd2cf887..f85efb24cfb4 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -867,9 +867,15 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
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
index 4a5e555dc3d2..aec05e21d5a9 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -6,6 +6,7 @@
 #include <linux/hashtable.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
+extern struct kmem_cache *fanotify_sb_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
@@ -129,6 +130,16 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 	       name->name);
 }
 
+struct fanotify_sb_mark {
+	struct fsnotify_mark fsn_mark;
+};
+
+static inline
+struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
+{
+	return container_of(mark, struct fanotify_sb_mark, fsn_mark);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index af518790a80f..db378480f1b1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -99,6 +99,7 @@ struct ctl_table fanotify_table[] = {
 extern const struct fsnotify_ops fanotify_fsnotify_ops;
 
 struct kmem_cache *fanotify_mark_cache __read_mostly;
+struct kmem_cache *fanotify_sb_mark_cache __read_mostly;
 struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
 struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
@@ -915,6 +916,27 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	return mask & ~oldmask;
 }
 
+static struct fsnotify_mark *fanotify_alloc_mark(unsigned int type)
+{
+	struct fanotify_sb_mark *sb_mark;
+
+	switch (type) {
+	case FSNOTIFY_OBJ_TYPE_SB:
+		sb_mark = kmem_cache_zalloc(fanotify_sb_mark_cache, GFP_KERNEL);
+		if (!sb_mark)
+			return NULL;
+		return &sb_mark->fsn_mark;
+
+	case FSNOTIFY_OBJ_TYPE_INODE:
+	case FSNOTIFY_OBJ_TYPE_PARENT:
+	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
+		return kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	default:
+		WARN_ON(1);
+		return NULL;
+	}
+}
+
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int type,
@@ -933,13 +955,16 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
 
-	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	mark = fanotify_alloc_mark(type);
 	if (!mark) {
 		ret = -ENOMEM;
 		goto out_dec_ucounts;
 	}
 
 	fsnotify_init_mark(mark, group);
+	if (type == FSNOTIFY_OBJ_TYPE_SB)
+		mark->flags |= FSNOTIFY_MARK_FLAG_SB;
+
 	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
@@ -1497,6 +1522,8 @@ static int __init fanotify_user_setup(void)
 
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
2.31.0

