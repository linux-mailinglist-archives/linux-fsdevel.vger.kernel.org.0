Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48223CFEDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhGTP3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbhGTPUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:20:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F5C0613EF;
        Tue, 20 Jul 2021 09:00:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 345011F4312B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 05/16] fanotify: Split superblock marks out to a new cache
Date:   Tue, 20 Jul 2021 11:59:33 -0400
Message-Id: <20210720155944.1447086-6-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720155944.1447086-1-krisman@collabora.com>
References: <20210720155944.1447086-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_FS_ERROR will require an error structure to be stored per mark.
But, since FAN_FS_ERROR doesn't apply to inode/mount marks, it should
suffice to only expose this information for superblock marks. Therefore,
wrap this kind of marks into a container and plumb it for the future.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Move mark initialization to fanotify_alloc_mark (Amir)

Changes since v1:
  - Only extend superblock marks (Amir)
---
 fs/notify/fanotify/fanotify.c      | 10 ++++++--
 fs/notify/fanotify/fanotify.h      | 23 ++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 310246f8d3f1..c3eefe3f6494 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -869,9 +869,15 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
 		dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
 }
 
-static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
+static void fanotify_free_mark(struct fsnotify_mark *mark)
 {
-	kmem_cache_free(fanotify_mark_cache, fsn_mark);
+	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
+		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
+
+		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
+	} else {
+		kmem_cache_free(fanotify_mark_cache, mark);
+	}
 }
 
 const struct fsnotify_ops fanotify_fsnotify_ops = {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4a5e555dc3d2..c548b96472dd 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -6,6 +6,7 @@
 #include <linux/hashtable.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
+extern struct kmem_cache *fanotify_sb_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
@@ -129,6 +130,28 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 	       name->name);
 }
 
+#define FANOTIFY_MARK_FLAG(flag) \
+static const unsigned int FANOTIFY_MARK_FLAG_##flag = \
+	(1 << FANOTIFY_MARK_FLAG_BIT_##flag)
+
+enum fanotify_mark_bits {
+	FANOTIFY_MARK_FLAG_BIT_SB_MARK = FSN_MARK_PRIVATE_FLAGS,
+};
+
+FANOTIFY_MARK_FLAG(SB_MARK);
+
+struct fanotify_sb_mark {
+	struct fsnotify_mark fsn_mark;
+};
+
+static inline
+struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
+{
+	WARN_ON(!(mark->flags & FANOTIFY_MARK_FLAG_SB_MARK));
+
+	return container_of(mark, struct fanotify_sb_mark, fsn_mark);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 67b18dfe0025..0696f2121781 100644
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
+		mark->flags |= FANOTIFY_MARK_FLAG_SB_MARK;
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
-- 
2.32.0

