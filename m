Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8823E0573
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhHDQIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:08:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42120 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhHDQIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:08:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 77B791F43695
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 18/23] fanotify: Handle FAN_FS_ERROR events
Date:   Wed,  4 Aug 2021 12:06:07 -0400
Message-Id: <20210804160612.3575505-19-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up FAN_FS_ERROR in the fanotify_mark syscall.  The event can only
be requested for the entire filesystem, thus it requires the
FAN_MARK_FILESYSTEM.

FAN_FS_ERROR has to be handled slightly differently from other events
because it needs to be submitted in an atomic context, using
preallocated memory.  This patch implements the submission path by only
storing the first error event that happened in the slot (userspace
resets the slot by reading the event).

Extra error events happening when the slot is occupied are merged to the
original report, and the only information keep for these extra errors is
an accumulator counting the number of events, which is part of the
record reported back to userspace.

Reporting only the first event should be fine, since when a FS error
happens, a cascade of error usually follows, but the most meaningful
information is (usually) on the first erro.

The event dequeueing is also a bit special to avoid losing events. Since
event merging only happens while the event is queued, there is a window
between when an error event is dequeued (notification_lock is dropped)
until it is reset (.free_event()) where the slot is full, but no merges
can happen.

The proposed solution is to replace the event in the slot with a new
structure, prior to dropping the lock.  This way, if a new event arrives
in the time between the event was dequeued and the time it resets, the
new errors will still be logged and merged in the new slot.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v4:
  - Split parts to earlier patches (amir)
  - Simplify fanotify entry replacement
  - Update handle size prediction on overflow
Changes since v3:
  - Convert WARN_ON to pr_warn (amir)
  - Remove unecessary READ/WRITE_ONCE (amir)
  - Alloc with GFP_KERNEL_ACCOUNT(amir)
  - Simplify flags on mark allocation (amir)
  - Avoid atomic set of error_count (amir)
  - Simplify rules when merging error_event (amir)
  - Allocate new error_event on get_one_event (amir)
  - Report superblock error with invalid FH (amir,jan)

Changes since v2:
  - Support and equire FID mode (amir)
  - Goto error path instead of early return (amir)
  - Simplify get_one_event (me)
  - Base merging on error_count
  - drop fanotify_queue_error_event

Changes since v1:
  - Pass dentry to fanotify_check_fsid (Amir)
  - FANOTIFY_EVENT_TYPE_ERROR -> FANOTIFY_EVENT_TYPE_FS_ERROR
  - Merge previous patch into it
  - Use a single slot
  - Move fanotify_mark.error_event definition to this commit
  - Rename FAN_ERROR -> FAN_FS_ERROR
  - Restrict FAN_FS_ERROR to FAN_MARK_FILESYSTEM
---
 fs/notify/fanotify/fanotify.c      | 50 +++++++++++++++++++++++-
 fs/notify/fanotify/fanotify.h      |  9 +++++
 fs/notify/fanotify/fanotify_user.c | 63 +++++++++++++++++++++++++++++-
 include/linux/fanotify.h           |  6 ++-
 4 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 0678d35432a7..4e9e271a4394 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -681,6 +681,42 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	return fsid;
 }
 
+static int fanotify_merge_error_event(struct fsnotify_group *group,
+				      struct fsnotify_event *event)
+{
+	struct fanotify_event *fae = FANOTIFY_E(event);
+	struct fanotify_error_event *fee = FANOTIFY_EE(fae);
+
+	/*
+	 * When err_count > 0, the reporting slot is full.  Just account
+	 * the additional error and abort the insertion.
+	 */
+	if (fee->err_count) {
+		fee->err_count++;
+		return 1;
+	}
+
+	return 0;
+}
+
+static void fanotify_insert_error_event(struct fsnotify_group *group,
+					struct fsnotify_event *event,
+					const void *data)
+{
+	const struct fs_error_report *report = (struct fs_error_report *) data;
+	struct fanotify_event *fae = FANOTIFY_E(event);
+	struct fanotify_error_event *fee;
+
+	/* This might be an unexpected type of event (i.e. overflow). */
+	if (!fanotify_is_error_event(fae->mask))
+		return;
+
+	fee = FANOTIFY_EE(fae);
+	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	fee->error = report->error;
+	fee->err_count = 1;
+}
+
 /*
  * Add an event to hash table for faster merge.
  */
@@ -735,7 +771,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type, dir);
@@ -760,6 +796,18 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
+	if (fanotify_is_error_event(mask)) {
+		struct fanotify_sb_mark *sb_mark =
+			FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
+
+		ret = fsnotify_insert_event(group,
+					    &sb_mark->fee_slot->fae.fse,
+					    fanotify_merge_error_event,
+					    fanotify_insert_error_event,
+					    data);
+		goto finish;
+	}
+
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid);
 	ret = -ENOMEM;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 206dc6cfd671..8929ea50f96f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -223,6 +223,9 @@ FANOTIFY_NE(struct fanotify_event *event)
 
 struct fanotify_error_event {
 	struct fanotify_event fae;
+	s32 error; /* Error reported by the Filesystem. */
+	u32 err_count; /* Suppressed errors count */
+
 	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
 };
 
@@ -323,6 +326,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct fanotify_event, fse);
 }
 
+static inline bool fanotify_is_error_event(u32 mask)
+{
+	return mask & FAN_FS_ERROR;
+}
+
 static inline bool fanotify_event_has_path(struct fanotify_event *event)
 {
 	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
@@ -352,6 +360,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
 	return !(fanotify_is_perm_event(mask) ||
+		 fanotify_is_error_event(mask) ||
 		 fsnotify_is_overflow_event(mask));
 }
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 76c1c805af3d..e7fe6bc61b6f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -183,6 +183,45 @@ static struct fanotify_error_event *fanotify_alloc_error_event(
 	return fee;
 }
 
+/*
+ * Replace a mark's error event with a new structure in preparation for
+ * it to be dequeued.  This is a bit annoying since we need to drop the
+ * lock, so another thread might just steal the event from us.
+ */
+static int fanotify_replace_fs_error_event(struct fsnotify_group *group,
+					   struct fanotify_event *fae)
+{
+	struct fanotify_error_event *new, *fee = FANOTIFY_EE(fae);
+	struct fanotify_sb_mark *sb_mark = fee->sb_mark;
+	struct fsnotify_event *fse;
+
+	pr_debug("%s: event=%p\n", __func__, fae);
+
+	assert_spin_locked(&group->notification_lock);
+
+	spin_unlock(&group->notification_lock);
+	new = fanotify_alloc_error_event(sb_mark);
+	spin_lock(&group->notification_lock);
+
+	if (!new)
+		return -ENOMEM;
+
+	/*
+	 * Since we temporarily dropped the notification_lock, the event
+	 * might have been taken from under us and reported by another
+	 * reader.  If that is the case, don't play games, just retry.
+	 */
+	fse = fsnotify_peek_first_event(group);
+	if (fse != &fae->fse) {
+		kfree(new);
+		return -EAGAIN;
+	}
+
+	sb_mark->fee_slot = new;
+
+	return 0;
+}
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -196,6 +235,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	struct fanotify_event *event = NULL;
 	struct fsnotify_event *fsn_event;
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	int ret;
 
 	pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
 
@@ -212,9 +252,21 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		goto out;
 	}
 
+	if (fanotify_is_error_event(event->mask)) {
+		/*
+		 * Replace the error event ahead of dequeueing so we
+		 * don't need to handle a incorrectly dequeued event.
+		 */
+		ret = fanotify_replace_fs_error_event(group, event);
+		if (ret) {
+			event = ERR_PTR(ret);
+			goto out;
+		}
+	}
+
 	/*
-	 * Held the notification_lock the whole time, so this is the
-	 * same event we peeked above.
+	 * Even though we might have temporarily dropped the lock, this
+	 * is guaranteed to be the same event we peeked above.
 	 */
 	fsnotify_remove_first_event(group);
 	if (fanotify_is_perm_event(event->mask))
@@ -596,6 +648,8 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		event = get_one_event(group, count);
 		if (IS_ERR(event)) {
 			ret = PTR_ERR(event);
+			if (ret == -EAGAIN)
+				continue;
 			break;
 		}
 
@@ -1464,6 +1518,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		fsid = &__fsid;
 	}
 
+	if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
+		ret = -EINVAL;
+		goto path_put_and_out;
+	}
+
 	/* inode held in place by reference to path; group by fget on fd */
 	if (mark_type == FAN_MARK_INODE)
 		inode = path.dentry->d_inode;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index c05d45bde8b8..c4d49308b2d0 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -88,9 +88,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
 
+/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
+#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS)
+				 FANOTIFY_INODE_EVENTS | \
+				 FANOTIFY_ERROR_EVENTS)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-- 
2.32.0

