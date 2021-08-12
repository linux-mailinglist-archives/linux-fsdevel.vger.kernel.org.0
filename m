Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4247F3EACAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhHLVl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhHLVl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0ED891F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 16/21] fanotify: Handle FAN_FS_ERROR events
Date:   Thu, 12 Aug 2021 17:40:05 -0400
Message-Id: <20210812214010.3197279-17-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
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

The proposed solution is to copy the event to the stack prior to
dropping the lock.  This way, if a new event arrives in the time between
the event was dequeued and the time it resets, the new errors will still
be logged and merged in the recently freed slot.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Copy to stack instead of replacing the fee slot(jan)
  - prepare error slot outside of the notification lock(jan)
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
 fs/notify/fanotify/fanotify.c      | 57 +++++++++++++++++++++++++++++-
 fs/notify/fanotify/fanotify.h      | 21 +++++++++++
 fs/notify/fanotify/fanotify_user.c | 39 ++++++++++++++++++--
 include/linux/fanotify.h           |  6 +++-
 4 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3bf6fd85c634..0c7667d3f5d1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -709,6 +709,55 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	return fsid;
 }
 
+static void fanotify_insert_error_event(struct fsnotify_group *group,
+					struct fsnotify_event *fsn_event)
+
+{
+	struct fanotify_event *event = FANOTIFY_E(fsn_event);
+
+	if (!fanotify_is_error_event(event->mask))
+		return;
+
+	/*
+	 * Prevent the mark from going away while an outstanding error
+	 * event is queued.  The reference is released by
+	 * fanotify_dequeue_first_event.
+	 */
+	fsnotify_get_mark(&FANOTIFY_EE(event)->sb_mark->fsn_mark);
+
+}
+
+static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
+				       struct fsnotify_group *group,
+				       const struct fs_error_report *report)
+{
+	struct fanotify_sb_mark *sb_mark =
+		FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
+	struct fanotify_error_event *fee = sb_mark->fee_slot;
+
+	spin_lock(&group->notification_lock);
+	if (fee->err_count++) {
+		spin_unlock(&group->notification_lock);
+		return 0;
+	}
+	spin_unlock(&group->notification_lock);
+
+	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+
+	if (fsnotify_insert_event(group, &fee->fae.fse,
+				  NULL, fanotify_insert_error_event)) {
+		/*
+		 *  Even if an error occurred, an overflow event is
+		 *  queued. Just reset the error count and succeed.
+		 */
+		spin_lock(&group->notification_lock);
+		fanotify_reset_error_slot(fee);
+		spin_unlock(&group->notification_lock);
+	}
+
+	return 0;
+}
+
 /*
  * Add an event to hash table for faster merge.
  */
@@ -762,7 +811,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type, dir);
@@ -787,6 +836,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
+	if (fanotify_is_error_event(mask))
+		return fanotify_handle_error_event(iter_info, group, data);
+
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid);
 	ret = -ENOMEM;
@@ -857,10 +909,13 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 
 static void fanotify_free_error_event(struct fanotify_event *event)
 {
+	struct fanotify_error_event *fee = FANOTIFY_EE(event);
+
 	/*
 	 * The actual event is tied to a mark, and is released on mark
 	 * removal
 	 */
+	fsnotify_put_mark(&fee->sb_mark->fsn_mark);
 }
 
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 3f03333df32f..eeb4a85af74e 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -220,6 +220,8 @@ FANOTIFY_NE(struct fanotify_event *event)
 
 struct fanotify_error_event {
 	struct fanotify_event fae;
+	u32 err_count; /* Suppressed errors count */
+
 	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
 };
 
@@ -320,6 +322,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
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
@@ -349,6 +356,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
 	return !(fanotify_is_perm_event(mask) ||
+		 fanotify_is_error_event(mask) ||
 		 fsnotify_is_overflow_event(mask));
 }
 
@@ -358,3 +366,16 @@ static inline unsigned int fanotify_event_hash_bucket(
 {
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
+
+/*
+ * Reset the FAN_FS_ERROR event slot
+ *
+ * This is used to restore the error event slot to a a zeroed state,
+ * where it can be used for a new incoming error.  It does not
+ * initialize the event, but clear only the required data to free the
+ * slot.
+ */
+static inline void fanotify_reset_error_slot(struct fanotify_error_event *fee)
+{
+	fee->err_count = 0;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b77030386d7f..3fff0c994dc8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -167,6 +167,19 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
 	hlist_del_init(&event->merge_list);
 }
 
+static struct fanotify_event *fanotify_dup_error_to_stack(
+				struct fanotify_error_event *fee,
+				struct fanotify_error_event *error_on_stack)
+{
+	fanotify_init_event(&error_on_stack->fae, 0, FS_ERROR);
+
+	error_on_stack->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	error_on_stack->err_count = fee->err_count;
+	error_on_stack->sb_mark = fee->sb_mark;
+
+	return &error_on_stack->fae;
+}
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -174,7 +187,9 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
  * updated accordingly.
  */
 static struct fanotify_event *get_one_event(struct fsnotify_group *group,
-					    size_t count)
+				    size_t count,
+				    struct fanotify_error_event *error_on_stack)
+
 {
 	size_t event_size;
 	struct fanotify_event *event = NULL;
@@ -205,6 +220,16 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
 	if (fanotify_is_hashed_event(event->mask))
 		fanotify_unhash_event(group, event);
+
+	if (fanotify_is_error_event(event->mask)) {
+		/*
+		 * Error events are returned as a copy of the error
+		 * slot.  The actual error slot is reused.
+		 */
+		fanotify_dup_error_to_stack(FANOTIFY_EE(event), error_on_stack);
+		fanotify_reset_error_slot(FANOTIFY_EE(event));
+		event = &error_on_stack->fae;
+	}
 out:
 	spin_unlock(&group->notification_lock);
 	return event;
@@ -564,6 +589,7 @@ static __poll_t fanotify_poll(struct file *file, poll_table *wait)
 static ssize_t fanotify_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *pos)
 {
+	struct fanotify_error_event error_on_stack;
 	struct fsnotify_group *group;
 	struct fanotify_event *event;
 	char __user *start;
@@ -582,7 +608,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		 * in case there are lots of available events.
 		 */
 		cond_resched();
-		event = get_one_event(group, count);
+		event = get_one_event(group, count, &error_on_stack);
 		if (IS_ERR(event)) {
 			ret = PTR_ERR(event);
 			break;
@@ -1031,6 +1057,10 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			fanotify_init_event(&fee->fae, 0, FS_ERROR);
 			fee->sb_mark = sb_mark;
 			sb_mark->fee_slot = fee;
+
+			/* Mark the error slot ready to receive events. */
+			fanotify_reset_error_slot(fee);
+
 		}
 	}
 
@@ -1459,6 +1489,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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

