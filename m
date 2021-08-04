Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6803E0571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhHDQH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:07:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42100 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhHDQH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:07:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4B2351F4080F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 17/23] fanotify: Preallocate per superblock mark error event
Date:   Wed,  4 Aug 2021 12:06:06 -0400
Message-Id: <20210804160612.3575505-18-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
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
 fs/notify/fanotify/fanotify.c      | 22 +++++++++++++++++
 fs/notify/fanotify/fanotify.h      | 13 ++++++++++
 fs/notify/fanotify/fanotify_user.c | 39 +++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index ca74199f11e2..0678d35432a7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -828,6 +828,24 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 	kfree(FANOTIFY_NE(event));
 }
 
+static void fanotify_free_error_event(struct fanotify_event *event)
+{
+	struct fanotify_error_event *fee;
+
+	if (!event)
+		return;
+
+	fee = FANOTIFY_EE(event);
+	/*
+	 * If this is an active error event, disassociate it from the
+	 * mark prior to removal.
+	 */
+	if (fee->sb_mark->fee_slot == fee)
+		fee->sb_mark->fee_slot = NULL;
+
+	kfree(fee);
+}
+
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
@@ -850,6 +868,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	case FANOTIFY_EVENT_TYPE_OVERFLOW:
 		kfree(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		fanotify_free_error_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -867,6 +888,7 @@ static void fanotify_free_mark(struct fsnotify_mark *mark)
 	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
 		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
 
+		fanotify_free_error_event(&fa_mark->fee_slot->fae);
 		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
 	} else {
 		kmem_cache_free(fanotify_mark_cache, mark);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index aa555975c0f8..206dc6cfd671 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -142,6 +142,7 @@ FANOTIFY_MARK_FLAG(SB_MARK);
 
 struct fanotify_sb_mark {
 	struct fsnotify_mark fsn_mark;
+	struct fanotify_error_event *fee_slot;
 };
 
 static inline
@@ -164,6 +165,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -219,6 +221,17 @@ FANOTIFY_NE(struct fanotify_event *event)
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
index 6dad2a00e337..76c1c805af3d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -167,6 +167,22 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
 	hlist_del_init(&event->merge_list);
 }
 
+static struct fanotify_error_event *fanotify_alloc_error_event(
+					struct fanotify_sb_mark *sb_mark)
+
+{
+	struct fanotify_error_event *fee;
+
+	fee = kzalloc(sizeof(*fee), GFP_KERNEL_ACCOUNT);
+	if (!fee)
+		return NULL;
+
+	fanotify_init_event(&fee->fae, 0, FS_ERROR);
+	fee->sb_mark = sb_mark;
+
+	return fee;
+}
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -994,6 +1010,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	__u32 added;
+	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -1004,13 +1021,33 @@ static int fanotify_add_mark(struct fsnotify_group *group,
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
+			sb_mark->fee_slot = fanotify_alloc_error_event(sb_mark);
+			if (!sb_mark->fee_slot) {
+				ret = -ENOMEM;
+				goto out;
+			}
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

