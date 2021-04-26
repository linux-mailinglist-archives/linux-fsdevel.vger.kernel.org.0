Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACD36B934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhDZSnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbhDZSn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A046C061760;
        Mon, 26 Apr 2021 11:42:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 290F61F41E82
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 06/15] fanotify: Support submission through ring buffer
Date:   Mon, 26 Apr 2021 14:41:52 -0400
Message-Id: <20210426184201.4177978-7-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for the ring buffer mode in fanotify.  It is enabled
by a new flag FAN_PREALLOC_QUEUE passed to fanotify_init.  If this flag
is enabled, the group only allows marks that support the ring buffer
submission.  In a following patch, FAN_ERROR will make use of this
mechanism.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c      | 77 +++++++++++++++++++---------
 fs/notify/fanotify/fanotify_user.c | 81 ++++++++++++++++++------------
 include/linux/fanotify.h           |  5 +-
 include/uapi/linux/fanotify.h      |  1 +
 4 files changed, 105 insertions(+), 59 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e3669d8a4a64..98591a8155a7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -612,6 +612,26 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	return event;
 }
 
+static struct fanotify_event *fanotify_ring_get_slot(struct fsnotify_group *group,
+						     u32 mask, const void *data,
+						     int data_type)
+{
+	size_t size = 0;
+
+	pr_debug("%s: group=%p mask=%x size=%lu\n", __func__, group, mask, size);
+
+	return FANOTIFY_E(fsnotify_ring_alloc_event_slot(group, size));
+}
+
+static void fanotify_ring_write_event(struct fsnotify_group *group,
+				      struct fanotify_event *event, u32 mask,
+				      const void *data, __kernel_fsid_t *fsid)
+{
+	fanotify_init_event(group, event, 0, mask);
+
+	event->pid = get_pid(task_tgid(current));
+}
+
 /*
  * Get cached fsid of the filesystem containing the object from any connector.
  * All connectors are supposed to have the same fsid, but we do not verify that
@@ -701,31 +721,38 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	event = fanotify_alloc_event(group, mask, data, data_type, dir,
-				     file_name, &fsid);
-	ret = -ENOMEM;
-	if (unlikely(!event)) {
-		/*
-		 * We don't queue overflow events for permission events as
-		 * there the access is denied and so no event is in fact lost.
-		 */
-		if (!fanotify_is_perm_event(mask))
-			fsnotify_queue_overflow(group);
-		goto finish;
-	}
-
-	fsn_event = &event->fse;
-	ret = fsnotify_add_event(group, fsn_event, fanotify_merge);
-	if (ret) {
-		/* Permission events shouldn't be merged */
-		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
-		/* Our event wasn't used in the end. Free it. */
-		fsnotify_destroy_event(group, fsn_event);
-
-		ret = 0;
-	} else if (fanotify_is_perm_event(mask)) {
-		ret = fanotify_get_response(group, FANOTIFY_PERM(event),
-					    iter_info);
+	if (group->flags & FSN_SUBMISSION_RING_BUFFER) {
+		event = fanotify_ring_get_slot(group, mask, data, data_type);
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+		fanotify_ring_write_event(group, event, mask, data, &fsid);
+		fsnotify_ring_commit_slot(group, &event->fse);
+	} else {
+		event = fanotify_alloc_event(group, mask, data, data_type, dir,
+					     file_name, &fsid);
+		ret = -ENOMEM;
+		if (unlikely(!event)) {
+			/*
+			 * We don't queue overflow events for permission events as
+			 * there the access is denied and so no event is in fact lost.
+			 */
+			if (!fanotify_is_perm_event(mask))
+				fsnotify_queue_overflow(group);
+			goto finish;
+		}
+		fsn_event = &event->fse;
+		ret = fsnotify_add_event(group, fsn_event, fanotify_merge);
+		if (ret) {
+			/* Permission events shouldn't be merged */
+			BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
+			/* Our event wasn't used in the end. Free it. */
+			fsnotify_destroy_event(group, fsn_event);
+
+			ret = 0;
+		} else if (fanotify_is_perm_event(mask)) {
+			ret = fanotify_get_response(group, FANOTIFY_PERM(event),
+						    iter_info);
+		}
 	}
 finish:
 	if (fanotify_is_perm_event(mask))
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fe605359af88..5031198bf7db 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -521,7 +521,9 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		 * Permission events get queued to wait for response.  Other
 		 * events can be destroyed now.
 		 */
-		if (!fanotify_is_perm_event(event->mask)) {
+		if (group->fanotify_data.flags & FAN_PREALLOC_QUEUE) {
+			fsnotify_ring_buffer_consume_event(group, &event->fse);
+		} else if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
 			if (ret <= 0) {
@@ -587,40 +589,39 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	 */
 	fsnotify_group_stop_queueing(group);
 
-	/*
-	 * Process all permission events on access_list and notification queue
-	 * and simulate reply from userspace.
-	 */
-	spin_lock(&group->notification_lock);
-	while (!list_empty(&group->fanotify_data.access_list)) {
-		struct fanotify_perm_event *event;
-
-		event = list_first_entry(&group->fanotify_data.access_list,
-				struct fanotify_perm_event, fae.fse.list);
-		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW);
+	if (!(group->flags & FSN_SUBMISSION_RING_BUFFER)) {
+		/*
+		 * Process all permission events on access_list and notification queue
+		 * and simulate reply from userspace.
+		 */
 		spin_lock(&group->notification_lock);
-	}
-
-	/*
-	 * Destroy all non-permission events. For permission events just
-	 * dequeue them and set the response. They will be freed once the
-	 * response is consumed and fanotify_get_response() returns.
-	 */
-	while (!fsnotify_notify_queue_is_empty(group)) {
-		struct fanotify_event *event;
-
-		event = FANOTIFY_E(fsnotify_remove_first_event(group));
-		if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
-			spin_unlock(&group->notification_lock);
-			fsnotify_destroy_event(group, &event->fse);
-		} else {
-			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW);
+		while (!list_empty(&group->fanotify_data.access_list)) {
+			struct fanotify_perm_event *event;
+			event = list_first_entry(&group->fanotify_data.access_list,
+						 struct fanotify_perm_event, fae.fse.list);
+			list_del_init(&event->fae.fse.list);
+			finish_permission_event(group, event, FAN_ALLOW);
+			spin_lock(&group->notification_lock);
 		}
-		spin_lock(&group->notification_lock);
+		/*
+		 * Destroy all non-permission events. For permission events just
+		 * dequeue them and set the response. They will be freed once the
+		 * response is consumed and fanotify_get_response() returns.
+		 */
+		while (!fsnotify_notify_queue_is_empty(group)) {
+			struct fanotify_event *event;
+			event = FANOTIFY_E(fsnotify_remove_first_event(group));
+			if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
+				spin_unlock(&group->notification_lock);
+				fsnotify_destroy_event(group, &event->fse);
+			} else {
+				finish_permission_event(group, FANOTIFY_PERM(event),
+							FAN_ALLOW);
+			}
+			spin_lock(&group->notification_lock);
+		}
+		spin_unlock(&group->notification_lock);
 	}
-	spin_unlock(&group->notification_lock);
 
 	/* Response for all permission events it set, wakeup waiters */
 	wake_up(&group->fanotify_data.access_waitq);
@@ -981,6 +982,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (flags & FAN_NONBLOCK)
 		f_flags |= O_NONBLOCK;
 
+	if (flags & FAN_PREALLOC_QUEUE) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		if (flags & FAN_UNLIMITED_QUEUE)
+			return -EINVAL;
+
+		fsn_flags = FSN_SUBMISSION_RING_BUFFER;
+	}
+
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops, fsn_flags);
 	if (IS_ERR(group)) {
@@ -1223,6 +1234,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 	}
 
+	if ((group->flags & FSN_SUBMISSION_RING_BUFFER) &&
+	    (mask & ~FANOTIFY_SUBMISSION_BUFFER_EVENTS))
+		goto fput_and_out;
+
 	ret = fanotify_find_path(dfd, pathname, &path, flags,
 			(mask & ALL_FSNOTIFY_EVENTS), obj_type);
 	if (ret)
@@ -1327,7 +1342,7 @@ SYSCALL32_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3e9c56ee651f..5a4cefb4b1c3 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -23,7 +23,8 @@
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
 				 FAN_REPORT_TID | \
 				 FAN_CLOEXEC | FAN_NONBLOCK | \
-				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
+				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS | \
+				 FAN_PREALLOC_QUEUE)
 
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
@@ -71,6 +72,8 @@
 					 FANOTIFY_PERM_EVENTS | \
 					 FAN_Q_OVERFLOW | FAN_ONDIR)
 
+#define FANOTIFY_SUBMISSION_BUFFER_EVENTS 0
+
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index fbf9c5c7dd59..b283531549f1 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -49,6 +49,7 @@
 #define FAN_UNLIMITED_QUEUE	0x00000010
 #define FAN_UNLIMITED_MARKS	0x00000020
 #define FAN_ENABLE_AUDIT	0x00000040
+#define FAN_PREALLOC_QUEUE	0x00000080
 
 /* Flags to determine fanotify event format */
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
-- 
2.31.0

