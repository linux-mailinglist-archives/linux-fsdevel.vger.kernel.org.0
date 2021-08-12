Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA38E3EACA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhHLVly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45878 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhHLVlx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B64B41F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 15/21] fanotify: Preallocate per superblock mark error event
Date:   Thu, 12 Aug 2021 17:40:04 -0400
Message-Id: <20210812214010.3197279-16-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Error reporting needs to be done in an atomic context.  This patch
introduces a single error slot for superblock marks that report the
FAN_FS_ERROR event, to be used during event submission.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes v5:
  - Restore mark references. (jan)
  - Tie fee slot to the mark lifetime.(jan)
  - Don't reallocate event(jan)
---
 fs/notify/fanotify/fanotify.c      | 12 ++++++++++++
 fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
 fs/notify/fanotify/fanotify_user.c | 31 ++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index ebb6c557cea1..3bf6fd85c634 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -855,6 +855,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 	kfree(FANOTIFY_NE(event));
 }
 
+static void fanotify_free_error_event(struct fanotify_event *event)
+{
+	/*
+	 * The actual event is tied to a mark, and is released on mark
+	 * removal
+	 */
+}
+
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
@@ -877,6 +885,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	case FANOTIFY_EVENT_TYPE_OVERFLOW:
 		kfree(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		fanotify_free_error_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -894,6 +905,7 @@ static void fanotify_free_mark(struct fsnotify_mark *mark)
 	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
 		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
 
+		kfree(fa_mark->fee_slot);
 		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
 	} else {
 		kmem_cache_free(fanotify_mark_cache, mark);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b3ab620822c2..3f03333df32f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -139,6 +139,7 @@ enum fanotify_mark_bits {
 
 struct fanotify_sb_mark {
 	struct fsnotify_mark fsn_mark;
+	struct fanotify_error_event *fee_slot;
 };
 
 static inline
@@ -161,6 +162,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -216,6 +218,17 @@ FANOTIFY_NE(struct fanotify_event *event)
 	return container_of(event, struct fanotify_name_event, fae);
 }
 
+struct fanotify_error_event {
+	struct fanotify_event fae;
+	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
+};
+
+static inline struct fanotify_error_event *
+FANOTIFY_EE(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_error_event, fae);
+}
+
 static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 54107f1533d5..b77030386d7f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -947,8 +947,10 @@ static struct fsnotify_mark *fanotify_alloc_mark(struct fsnotify_group *group,
 
 	fsnotify_init_mark(mark, group);
 
-	if (type == FSNOTIFY_OBJ_TYPE_SB)
+	if (type == FSNOTIFY_OBJ_TYPE_SB) {
 		mark->flags |= FANOTIFY_MARK_FLAG_SB_MARK;
+		sb_mark->fee_slot = NULL;
+	}
 
 	return mark;
 }
@@ -999,6 +1001,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	__u32 added;
+	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -1009,13 +1012,37 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			return PTR_ERR(fsn_mark);
 		}
 	}
+
+	/*
+	 * Error events are allocated per super-block mark only if
+	 * strictly needed (i.e. FAN_FS_ERROR was requested).
+	 */
+	if (type == FSNOTIFY_OBJ_TYPE_SB && !(flags & FAN_MARK_IGNORED_MASK) &&
+	    (mask & FAN_FS_ERROR)) {
+		struct fanotify_sb_mark *sb_mark = FANOTIFY_SB_MARK(fsn_mark);
+
+		if (!sb_mark->fee_slot) {
+			struct fanotify_error_event *fee =
+				kzalloc(sizeof(*fee), GFP_KERNEL_ACCOUNT);
+			if (!fee) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			fanotify_init_event(&fee->fae, 0, FS_ERROR);
+			fee->sb_mark = sb_mark;
+			sb_mark->fee_slot = fee;
+		}
+	}
+
 	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
+
+out:
 	mutex_unlock(&group->mark_mutex);
 
 	fsnotify_put_mark(fsn_mark);
-	return 0;
+	return ret;
 }
 
 static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
-- 
2.32.0

