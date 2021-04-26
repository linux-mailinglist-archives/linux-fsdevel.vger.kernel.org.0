Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB936B932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbhDZSnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47460 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbhDZSnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 99B461F41E27
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 05/15] fsnotify: Support event submission through ring buffer
Date:   Mon, 26 Apr 2021 14:41:51 -0400
Message-Id: <20210426184201.4177978-6-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to support file system health/error reporting over fanotify,
fsnotify needs to expose a submission path that doesn't allow sleeping.
The only problem I identified with the current submission path is the
need to dynamically allocate memory for the event queue.

This patch avoids the problem by introducing a new mode in fsnotify,
where a ring buffer is used to submit events for a group.  Each group
has its own ring buffer, and error notifications are submitted
exclusively through it.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/Makefile               |   2 +-
 fs/notify/group.c                |  12 +-
 fs/notify/notification.c         |  10 ++
 fs/notify/ring.c                 | 199 +++++++++++++++++++++++++++++++
 include/linux/fsnotify_backend.h |  37 +++++-
 5 files changed, 255 insertions(+), 5 deletions(-)
 create mode 100644 fs/notify/ring.c

diff --git a/fs/notify/Makefile b/fs/notify/Makefile
index 63a4b8828df4..61dae1e90f2d 100644
--- a/fs/notify/Makefile
+++ b/fs/notify/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FSNOTIFY)		+= fsnotify.o notification.o group.o mark.o \
-				   fdinfo.o
+				   fdinfo.o ring.o
 
 obj-y			+= dnotify/
 obj-y			+= inotify/
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 08acb1afc0c2..b99b3de36696 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -81,7 +81,10 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	 * notification against this group. So clearing the notification queue
 	 * of all events is reliable now.
 	 */
-	fsnotify_flush_notify(group);
+	if (group->flags & FSN_SUBMISSION_RING_BUFFER)
+		fsnotify_free_ring_buffer(group);
+	else
+		fsnotify_flush_notify(group);
 
 	/*
 	 * Destroy overflow event (we cannot use fsnotify_destroy_event() as
@@ -136,6 +139,13 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 	group->ops = ops;
 	group->flags = flags;
 
+	if (group->flags & FSN_SUBMISSION_RING_BUFFER) {
+		if (fsnotify_create_ring_buffer(group)) {
+			kfree(group);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
 	return group;
 }
 
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 75d79d6d3ef0..32f97e7b7a80 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -51,6 +51,10 @@ EXPORT_SYMBOL_GPL(fsnotify_get_cookie);
 bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
 {
 	assert_spin_locked(&group->notification_lock);
+
+	if (group->flags & FSN_SUBMISSION_RING_BUFFER)
+		return fsnotify_ring_notify_queue_is_empty(group);
+
 	return list_empty(&group->notification_list) ? true : false;
 }
 
@@ -132,6 +136,9 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
 				  struct fsnotify_event *event)
 {
 	assert_spin_locked(&group->notification_lock);
+
+	if (group->flags & FSN_SUBMISSION_RING_BUFFER)
+		return;
 	/*
 	 * We need to init list head for the case of overflow event so that
 	 * check in fsnotify_add_event() works
@@ -166,6 +173,9 @@ struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
 {
 	assert_spin_locked(&group->notification_lock);
 
+	if (group->flags & FSN_SUBMISSION_RING_BUFFER)
+		return fsnotify_ring_peek_first_event(group);
+
 	return list_first_entry(&group->notification_list,
 				struct fsnotify_event, list);
 }
diff --git a/fs/notify/ring.c b/fs/notify/ring.c
new file mode 100644
index 000000000000..75e8af1f8d80
--- /dev/null
+++ b/fs/notify/ring.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/fsnotify.h>
+#include <linux/memcontrol.h>
+
+#define INVALID_RING_SLOT -1
+
+#define FSNOTIFY_RING_PAGES 16
+
+#define NEXT_SLOT(cur, len, ring_size) ((cur + len) & (ring_size-1))
+#define NEXT_PAGE(cur, ring_size) (round_up(cur, PAGE_SIZE) & (ring_size-1))
+
+bool fsnotify_ring_notify_queue_is_empty(struct fsnotify_group *group)
+{
+	assert_spin_locked(&group->notification_lock);
+
+	if (group->ring_buffer.tail == group->ring_buffer.head)
+		return true;
+	return false;
+}
+
+struct fsnotify_event *fsnotify_ring_peek_first_event(struct fsnotify_group *group)
+{
+	u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
+	struct fsnotify_event *fsn;
+	char *kaddr;
+	u64 tail;
+
+	assert_spin_locked(&group->notification_lock);
+
+again:
+	tail = group->ring_buffer.tail;
+
+	if ((PAGE_SIZE - (tail & (PAGE_SIZE-1))) < sizeof(struct fsnotify_event)) {
+		group->ring_buffer.tail = NEXT_PAGE(tail, ring_size);
+		goto again;
+	}
+
+	kaddr = kmap_atomic(group->ring_buffer.pages[tail / PAGE_SIZE]);
+	if (!kaddr)
+		return NULL;
+	fsn = (struct fsnotify_event *) (kaddr + (tail & (PAGE_SIZE-1)));
+
+	if (fsn->slot_len == INVALID_RING_SLOT) {
+		group->ring_buffer.tail = NEXT_PAGE(tail, ring_size);
+		kunmap_atomic(kaddr);
+		goto again;
+	}
+
+	/* will be unmapped when entry is consumed. */
+	return fsn;
+}
+
+void fsnotify_ring_buffer_consume_event(struct fsnotify_group *group,
+					struct fsnotify_event *event)
+{
+	u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
+	u64 new_tail = NEXT_SLOT(group->ring_buffer.tail, event->slot_len, ring_size);
+
+	kunmap_atomic(event);
+
+	pr_debug("%s: group=%p tail=%llx->%llx ring_size=%llu\n", __func__,
+		 group, group->ring_buffer.tail, new_tail, ring_size);
+
+	WRITE_ONCE(group->ring_buffer.tail, new_tail);
+}
+
+struct fsnotify_event *fsnotify_ring_alloc_event_slot(struct fsnotify_group *group,
+						      size_t size)
+	__acquires(&group->notification_lock)
+{
+	struct fsnotify_event *fsn;
+	u64 head, tail;
+	u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
+	u64 new_head;
+	void *kaddr;
+
+	if (WARN_ON(!(group->flags & FSN_SUBMISSION_RING_BUFFER) || size > PAGE_SIZE))
+		return ERR_PTR(-EINVAL);
+
+	pr_debug("%s: start group=%p ring_size=%llu, requested=%lu\n", __func__, group,
+		 ring_size, size);
+
+	spin_lock(&group->notification_lock);
+again:
+	head = group->ring_buffer.head;
+	tail = group->ring_buffer.tail;
+	new_head = NEXT_SLOT(head, size, ring_size);
+
+	/* head would catch up to tail, corrupting an entry. */
+	if ((head < tail && new_head > tail) || (head > new_head && new_head > tail)) {
+		fsn = ERR_PTR(-ENOMEM);
+		goto err;
+	}
+
+	/*
+	 * Not event a skip message fits in the page. We can detect the
+	 * lack of space. Move on to the next page.
+	 */
+	if ((PAGE_SIZE - (head & (PAGE_SIZE-1))) < sizeof(struct fsnotify_event)) {
+		/* Start again on next page */
+		group->ring_buffer.head = NEXT_PAGE(head, ring_size);
+		goto again;
+	}
+
+	kaddr = kmap_atomic(group->ring_buffer.pages[head / PAGE_SIZE]);
+	if (!kaddr) {
+		fsn = ERR_PTR(-EFAULT);
+		goto err;
+	}
+
+	fsn = (struct fsnotify_event *) (kaddr + (head & (PAGE_SIZE-1)));
+
+	if ((head >> PAGE_SHIFT) != (new_head >> PAGE_SHIFT)) {
+		/*
+		 * No room in the current page.  Add a fake entry
+		 * consuming the end the page to avoid splitting event
+		 * structure.
+		 */
+		fsn->slot_len = INVALID_RING_SLOT;
+		kunmap_atomic(kaddr);
+		/* Start again on the next page */
+		group->ring_buffer.head = NEXT_PAGE(head, ring_size);
+
+		goto again;
+	}
+	fsn->slot_len = size;
+
+	return fsn;
+
+err:
+	spin_unlock(&group->notification_lock);
+	return fsn;
+}
+
+void fsnotify_ring_commit_slot(struct fsnotify_group *group, struct fsnotify_event *fsn)
+	__releases(&group->notification_lock)
+{
+	u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
+	u64 head = group->ring_buffer.head;
+	u64 new_head = NEXT_SLOT(head, fsn->slot_len, ring_size);
+
+	pr_debug("%s: group=%p head=%llx->%llx ring_size=%llu\n", __func__,
+		 group, head, new_head, ring_size);
+
+	kunmap_atomic(fsn);
+	group->ring_buffer.head = new_head;
+
+	spin_unlock(&group->notification_lock);
+
+	wake_up(&group->notification_waitq);
+	kill_fasync(&group->fsn_fa, SIGIO, POLL_IN);
+
+}
+
+void fsnotify_free_ring_buffer(struct fsnotify_group *group)
+{
+	int i;
+
+	for (i = 0; i < group->ring_buffer.nr_pages; i++)
+		__free_page(group->ring_buffer.pages[i]);
+	kfree(group->ring_buffer.pages);
+	group->ring_buffer.nr_pages = 0;
+}
+
+int fsnotify_create_ring_buffer(struct fsnotify_group *group)
+{
+	int nr_pages = FSNOTIFY_RING_PAGES;
+	int i;
+
+	pr_debug("%s: group=%p pages=%d\n", __func__, group, nr_pages);
+
+	group->ring_buffer.pages = kmalloc_array(nr_pages, sizeof(struct pages *),
+						 GFP_KERNEL);
+	if (!group->ring_buffer.pages)
+		return -ENOMEM;
+
+	group->ring_buffer.head = 0;
+	group->ring_buffer.tail = 0;
+
+	for (i = 0; i < nr_pages; i++) {
+		group->ring_buffer.pages[i] = alloc_pages(GFP_KERNEL, 1);
+		if (!group->ring_buffer.pages)
+			goto err_dealloc;
+	}
+
+	group->ring_buffer.nr_pages = nr_pages;
+
+	return 0;
+
+err_dealloc:
+	for (--i; i >= 0; i--)
+		__free_page(group->ring_buffer.pages[i]);
+	kfree(group->ring_buffer.pages);
+	group->ring_buffer.nr_pages = 0;
+	return -ENOMEM;
+}
+
+
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 190c6a402e98..a1a4dd69e5ed 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -74,6 +74,8 @@
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
 
+#define FSN_SUBMISSION_RING_BUFFER	0x00000080
+
 /*
  * This is a list of all events that may get sent to a parent that is watching
  * with flag FS_EVENT_ON_CHILD based on fs event on a child of that directory.
@@ -166,7 +168,11 @@ struct fsnotify_ops {
  * listener this structure is where you need to be adding fields.
  */
 struct fsnotify_event {
-	struct list_head list;
+	union {
+		struct list_head list;
+		int slot_len;
+	};
+
 	unsigned long objectid;	/* identifier for queue merges */
 };
 
@@ -191,7 +197,21 @@ struct fsnotify_group {
 
 	/* needed to send notification to userspace */
 	spinlock_t notification_lock;		/* protect the notification_list */
-	struct list_head notification_list;	/* list of event_holder this group needs to send to userspace */
+
+	union {
+		/*
+		 * list of event_holder this group needs to send to
+		 * userspace.  Either a linked list (default), or a ring
+		 * buffer(FSN_SUBMISSION_RING_BUFFER).
+		 */
+		struct list_head notification_list;
+		struct {
+			struct page **pages;
+			int nr_pages;
+			u64 head;
+			u64 tail;
+		} ring_buffer;
+	};
 	wait_queue_head_t notification_waitq;	/* read() on the notification file blocks on this waitq */
 	unsigned int q_len;			/* events on the queue */
 	unsigned int max_events;		/* maximum events allowed on the list */
@@ -492,6 +512,16 @@ extern int fsnotify_add_event(struct fsnotify_group *group,
 			      struct fsnotify_event *event,
 			      int (*merge)(struct list_head *,
 					   struct fsnotify_event *));
+
+extern int fsnotify_create_ring_buffer(struct fsnotify_group *group);
+extern void fsnotify_free_ring_buffer(struct fsnotify_group *group);
+extern struct fsnotify_event *fsnotify_ring_alloc_event_slot(struct fsnotify_group *group,
+							     size_t size);
+extern void fsnotify_ring_buffer_consume_event(struct fsnotify_group *group,
+					       struct fsnotify_event *event);
+extern bool fsnotify_ring_notify_queue_is_empty(struct fsnotify_group *group);
+struct fsnotify_event *fsnotify_ring_peek_first_event(struct fsnotify_group *group);
+extern void fsnotify_ring_commit_slot(struct fsnotify_group *group, struct fsnotify_event *fsn);
 /* Queue overflow event to a notification group */
 static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 {
@@ -583,7 +613,8 @@ static inline void fsnotify_init_event(struct fsnotify_group *group,
 				       struct fsnotify_event *event,
 				       unsigned long objectid)
 {
-	INIT_LIST_HEAD(&event->list);
+	if (!(group->flags & FSN_SUBMISSION_RING_BUFFER))
+		INIT_LIST_HEAD(&event->list);
 	event->objectid = objectid;
 }
 
-- 
2.31.0

