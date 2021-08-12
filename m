Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5C3EAC86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbhHLVlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45680 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbhHLVlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1952D1F44207
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 05/21] fanotify: Split superblock marks out to a new cache
Date:   Thu, 12 Aug 2021 17:39:54 -0400
Message-Id: <20210812214010.3197279-6-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
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
Changes since v5:
  - turn the flag bits into defines (jan)
  - don't use zalloc for consistency (jan)
Changes since v2:
  - Move mark initialization to fanotify_alloc_mark (Amir)

Changes since v1:
  - Only extend superblock marks (Amir)
---
 fs/notify/fanotify/fanotify.c      | 10 ++++++--
 fs/notify/fanotify/fanotify.h      | 20 ++++++++++++++++
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 4 deletions(-)

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
index 4a5e555dc3d2..3b11dd03df59 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -6,6 +6,7 @@
 #include <linux/hashtable.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
+extern struct kmem_cache *fanotify_sb_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
@@ -129,6 +130,25 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 	       name->name);
 }
 
+enum fanotify_mark_bits {
+	FANOTIFY_MARK_FLAG_BIT_SB_MARK = FSN_MARK_PRIVATE_FLAGS,
+};
+
+#define FANOTIFY_MARK_FLAG_SB_MARK \
+	(1 << FANOTIFY_MARK_FLAG_BIT_SB_MARK)
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
index 67b18dfe0025..c47a5a45c0d3 100644
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
+		sb_mark = kmem_cache_alloc(fanotify_sb_mark_cache, GFP_KERNEL);
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

