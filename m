Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF130C58D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhBBQZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbhBBQXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BFC06178B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s5so10684428edw.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XP53vLWMva4rKAbzpJV2CPB2Bn5JCtvElGL0L7+DZr0=;
        b=BRImuw/Bs2iwDp1zK0o0kN75YVQwHed5rO4eU03LB0ulJXRSMUVrGuJ20aDqPH8m/W
         W4Z0dcBeJoTj7X+GQwjBloUHxTN4B2oFNpnH1c5LjzljNUs3lXESE0k/QH1EVQZ2iwx8
         vovurkeJ+zh6KKwimy7pSo0V0aJHqUtmWlQNKOTtXGrq0eoZ6QJJp3I4pWeny3EeFuzM
         hSUQ7qZFGU78aI0jpV67z3+deZ/0vHrvykg9TyBuM7MJWNd33jgQEYlsgPUXaZnSlExu
         g20izN7ljLTOZ34VMvu0rUHz7Wo51lFMSm5UDCuzWB9f+WBAPOW94ewYwurJQ2QnFIfe
         ybFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XP53vLWMva4rKAbzpJV2CPB2Bn5JCtvElGL0L7+DZr0=;
        b=nfaWgUABLXTzZybJ0wIh2lJlPYhPjW12ML7jruamudSWL3xYLjIsGzV9go+OLF+5G8
         tPONQeL9jrshbimWuwkDV4rFBv8SmHNMpeYpkydngr69+ctgMk94e0+03LIeqr5H6Q+6
         jIGaKJ8ywsqtSIx3nN+L115EEkXp/bHtj/iGdYxZ6yP8qksPA6QQqB8tzHUgLxrBmI0q
         nrBO0xn5TtLhGOUg8MbnNGrJc2sv78L6NcjmtO+DkKed7ZwQac0oZDUyU3pklx/1cpP8
         9FEoUK0z2PAU4NXojrIdIcDS0wDrVtI+0ZpwfduyceRrB0lxa0Gj/crf9FfxyAXVYigj
         Pw9Q==
X-Gm-Message-State: AOAM530Exl+OnW9b0x2/ac2pCq/7rThm+Zl7yyP4cVBlKLh/v7unZno9
        EotxyMwlMb2YTRcOwdNNRfTIXsZ1RYk=
X-Google-Smtp-Source: ABdhPJz+9FIjEh2/ddkbMlTTJ0BmxuswykGB2u9hhHpTNHn0ereO/0peeAKtiYKDtGdnRog5g7sHpg==
X-Received: by 2002:a50:f19a:: with SMTP id x26mr15231106edl.354.1612282816090;
        Tue, 02 Feb 2021 08:20:16 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:15 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] fsnotify: support hashed notification queue
Date:   Tue,  2 Feb 2021 18:20:05 +0200
Message-Id: <20210202162010.305971-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to improve event merge performance, support sharding the
notification queue to several notification lists, hashed by an event
merge key.

The fanotify event merge key is the object id reduced to 32bit hash.

At the moment, both inotify and fanotify still use a single notification
list.

At the moment, reading events from the hashed queue is not by event
insertion order.  A non-empty list is read until it is empty.

The max events limit is accounted for total events in all lists.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |   5 +-
 fs/notify/fanotify/fanotify.h      |   4 +-
 fs/notify/fanotify/fanotify_user.c |  14 ++-
 fs/notify/group.c                  |  37 ++++++--
 fs/notify/inotify/inotify_user.c   |  17 ++--
 fs/notify/notification.c           | 131 ++++++++++++++++++++++++-----
 include/linux/fsnotify_backend.h   |  63 +++++++++++---
 7 files changed, 217 insertions(+), 54 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1192c9953620..12df6957e4d8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -97,7 +97,7 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 	old = FANOTIFY_E(old_fsn);
 	new = FANOTIFY_E(new_fsn);
 
-	if (old_fsn->objectid != new_fsn->objectid ||
+	if (old_fsn->key != new_fsn->key ||
 	    old->type != new->type || old->pid != new->pid)
 		return false;
 
@@ -600,8 +600,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * Use the victim inode instead of the watching inode as the id for
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
+	 * Reduce object id to 32bit hash for hashed queue merge.
 	 */
-	fanotify_init_event(event, (unsigned long)id, mask);
+	fanotify_init_event(event, hash_ptr(id, 32), mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 896c819a1786..2e856372ffc8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -145,9 +145,9 @@ struct fanotify_event {
 };
 
 static inline void fanotify_init_event(struct fanotify_event *event,
-				       unsigned long id, u32 mask)
+				       unsigned int key, u32 mask)
 {
-	fsnotify_init_event(&event->fse, id);
+	fsnotify_init_event(&event->fse, key);
 	event->mask = mask;
 	event->pid = NULL;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8ff27d92d32c..dee12d927f8d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -635,6 +635,7 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 {
 	struct fsnotify_group *group;
 	struct fsnotify_event *fsn_event;
+	struct list_head *list;
 	void __user *p;
 	int ret = -ENOTTY;
 	size_t send_len = 0;
@@ -646,8 +647,15 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	switch (cmd) {
 	case FIONREAD:
 		spin_lock(&group->notification_lock);
-		list_for_each_entry(fsn_event, &group->notification_list, list)
-			send_len += FAN_EVENT_METADATA_LEN;
+		list = fsnotify_first_notification_list(group);
+		/*
+		 * With multi queue, send_len will be a lower bound
+		 * on total events size.
+		 */
+		if (list) {
+			list_for_each_entry(fsn_event, list, list)
+				send_len += FAN_EVENT_METADATA_LEN;
+		}
 		spin_unlock(&group->notification_lock);
 		ret = put_user(send_len, (int __user *) p);
 		break;
@@ -982,7 +990,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		f_flags |= O_NONBLOCK;
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
-	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(0, &fanotify_fsnotify_ops);
 	if (IS_ERR(group)) {
 		free_uid(user);
 		return PTR_ERR(group);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index ffd723ffe46d..b41ed68f9ff9 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -21,6 +21,11 @@
  */
 static void fsnotify_final_destroy_group(struct fsnotify_group *group)
 {
+	int i;
+
+	for (i = 0; i <= group->max_bucket; i++)
+		WARN_ON_ONCE(!list_empty(&group->notification_list[i]));
+
 	if (group->ops->free_group_priv)
 		group->ops->free_group_priv(group);
 
@@ -111,12 +116,20 @@ void fsnotify_put_group(struct fsnotify_group *group)
 }
 EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
-static struct fsnotify_group *__fsnotify_alloc_group(
+static struct fsnotify_group *__fsnotify_alloc_group(unsigned int q_hash_bits,
 				const struct fsnotify_ops *ops, gfp_t gfp)
 {
 	struct fsnotify_group *group;
+	int i;
+
+#ifdef FSNOTIFY_HASHED_QUEUE
+	if (WARN_ON_ONCE(q_hash_bits > FSNOTIFY_HASHED_QUEUE_MAX_BITS))
+		q_hash_bits = FSNOTIFY_HASHED_QUEUE_MAX_BITS;
+#else
+	q_hash_bits = 0;
+#endif
 
-	group = kzalloc(sizeof(struct fsnotify_group), gfp);
+	group = kzalloc(fsnotify_group_size(q_hash_bits), gfp);
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
@@ -126,8 +139,12 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 	atomic_set(&group->user_waits, 0);
 
 	spin_lock_init(&group->notification_lock);
-	INIT_LIST_HEAD(&group->notification_list);
 	init_waitqueue_head(&group->notification_waitq);
+	/* Initialize one or more notification lists */
+	group->q_hash_bits = q_hash_bits;
+	group->max_bucket = (1 << q_hash_bits) - 1;
+	for (i = 0; i <= group->max_bucket; i++)
+		INIT_LIST_HEAD(&group->notification_list[i]);
 	group->max_events = UINT_MAX;
 
 	mutex_init(&group->mark_mutex);
@@ -139,20 +156,24 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 }
 
 /*
- * Create a new fsnotify_group and hold a reference for the group returned.
+ * Create a new fsnotify_group with no events queue.
+ * Hold a reference for the group returned.
  */
 struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
 {
-	return __fsnotify_alloc_group(ops, GFP_KERNEL);
+	return __fsnotify_alloc_group(0, ops, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
 /*
- * Create a new fsnotify_group and hold a reference for the group returned.
+ * Create a new fsnotify_group with an events queue.
+ * If @q_hash_bits > 0, the queue is shareded into several notification lists.
+ * Hold a reference for the group returned.
  */
-struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
+struct fsnotify_group *fsnotify_alloc_user_group(unsigned int q_hash_bits,
+						 const struct fsnotify_ops *ops)
 {
-	return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
+	return __fsnotify_alloc_group(q_hash_bits, ops, GFP_KERNEL_ACCOUNT);
 }
 EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index d8830be60a9b..1c476b9485dc 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -288,6 +288,7 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
 {
 	struct fsnotify_group *group;
 	struct fsnotify_event *fsn_event;
+	struct list_head *list;
 	void __user *p;
 	int ret = -ENOTTY;
 	size_t send_len = 0;
@@ -300,10 +301,16 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case FIONREAD:
 		spin_lock(&group->notification_lock);
-		list_for_each_entry(fsn_event, &group->notification_list,
-				    list) {
-			send_len += sizeof(struct inotify_event);
-			send_len += round_event_name_len(fsn_event);
+		list = fsnotify_first_notification_list(group);
+		/*
+		 * With multi queue, send_len will be a lower bound
+		 * on total events size.
+		 */
+		if (list) {
+			list_for_each_entry(fsn_event, list, list) {
+				send_len += sizeof(struct inotify_event);
+				send_len += round_event_name_len(fsn_event);
+			}
 		}
 		spin_unlock(&group->notification_lock);
 		ret = put_user(send_len, (int __user *) p);
@@ -631,7 +638,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct fsnotify_group *group;
 	struct inotify_event_info *oevent;
 
-	group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(0, &inotify_fsnotify_ops);
 	if (IS_ERR(group))
 		return group;
 
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index fcac2d72cbf5..58c8f6c1be1b 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -47,13 +47,6 @@ u32 fsnotify_get_cookie(void)
 }
 EXPORT_SYMBOL_GPL(fsnotify_get_cookie);
 
-/* return true if the notify queue is empty, false otherwise */
-bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
-{
-	assert_spin_locked(&group->notification_lock);
-	return list_empty(&group->notification_list) ? true : false;
-}
-
 void fsnotify_destroy_event(struct fsnotify_group *group,
 			    struct fsnotify_event *event)
 {
@@ -74,10 +67,75 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
 	group->ops->free_event(event);
 }
 
+/* Check and fix inconsistencies in hashed queue */
+static void fsnotify_queue_check(struct fsnotify_group *group)
+{
+#ifdef FSNOTIFY_HASHED_QUEUE
+	struct list_head *list;
+	int i, nbuckets = 0;
+	bool first_empty, last_empty;
+
+	assert_spin_locked(&group->notification_lock);
+
+	pr_debug("%s: group=%p events: num=%u max=%u buckets: first=%u last=%u max=%u\n",
+		 __func__, group, group->num_events, group->max_events,
+		 group->first_bucket, group->last_bucket, group->max_bucket);
+
+	if (fsnotify_notify_queue_is_empty(group))
+		return;
+
+	first_empty = list_empty(&group->notification_list[group->first_bucket]);
+	last_empty = list_empty(&group->notification_list[group->last_bucket]);
+
+	list = &group->notification_list[0];
+	for (i = 0; i <= group->max_bucket; i++, list++) {
+		if (list_empty(list))
+			continue;
+		if (nbuckets++)
+			continue;
+		if (first_empty)
+			group->first_bucket = i;
+		if (last_empty)
+			group->last_bucket = i;
+	}
+
+	pr_debug("%s: %u non-empty buckets\n", __func__, nbuckets);
+
+	/* All buckets are empty, but non-zero num_events? */
+	if (WARN_ON_ONCE(!nbuckets && group->num_events))
+		group->num_events = 0;
+#endif
+}
+
 /*
- * Add an event to the group notification queue.  The group can later pull this
- * event off the queue to deal with.  The function returns 0 if the event was
- * added to the queue, 1 if the event was merged with some other queued event,
+ * Add an event to the group notification queue (no merge and no failure).
+ */
+static void fsnotify_queue_event(struct fsnotify_group *group,
+				struct fsnotify_event *event)
+{
+	/* Choose list to add event to */
+	unsigned int b = fsnotify_event_bucket(group, event);
+	struct list_head *list = &group->notification_list[b];
+
+	assert_spin_locked(&group->notification_lock);
+
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__, group, event, b);
+
+	/*
+	 * TODO: set next_bucket of last event.
+	 */
+	group->last_bucket = b;
+	if (!group->num_events)
+		group->first_bucket = b;
+	group->num_events++;
+	list_add_tail(&event->list, list);
+}
+
+/*
+ * Try to Add an event to the group notification queue.
+ * The group can later pull this event off the queue to deal with.
+ * The function returns 0 if the event was added to a queue,
+ * 1 if the event was merged with some other queued event,
  * 2 if the event was not queued - either the queue of events has overflown
  * or the group is shutting down.
  */
@@ -87,7 +145,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 				    struct fsnotify_event *))
 {
 	int ret = 0;
-	struct list_head *list = &group->notification_list;
+	struct list_head *list;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -99,7 +157,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 	}
 
 	if (event == group->overflow_event ||
-	    group->q_len >= group->max_events) {
+	    group->num_events >= group->max_events) {
 		ret = 2;
 		/* Queue overflow event only if it isn't already queued */
 		if (!list_empty(&group->overflow_event->list)) {
@@ -110,6 +168,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 		goto queue;
 	}
 
+	list = fsnotify_event_notification_list(group, event);
 	if (!list_empty(list) && merge) {
 		ret = merge(list, event);
 		if (ret) {
@@ -119,8 +178,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 	}
 
 queue:
-	group->q_len++;
-	list_add_tail(&event->list, list);
+	fsnotify_queue_event(group, event);
 	spin_unlock(&group->notification_lock);
 
 	wake_up(&group->notification_waitq);
@@ -137,7 +195,30 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
 	 * check in fsnotify_add_event() works
 	 */
 	list_del_init(&event->list);
-	group->q_len--;
+	group->num_events--;
+}
+
+/* Return the notification list of the first event */
+struct list_head *fsnotify_first_notification_list(struct fsnotify_group *group)
+{
+	struct list_head *list;
+
+	assert_spin_locked(&group->notification_lock);
+
+	if (fsnotify_notify_queue_is_empty(group))
+		return NULL;
+
+	list = &group->notification_list[group->first_bucket];
+	if (likely(!list_empty(list)))
+		return list;
+
+	/*
+	 * Look for any non-empty bucket.
+	 */
+	fsnotify_queue_check(group);
+	list = &group->notification_list[group->first_bucket];
+
+	return list_empty(list) ? NULL : list;
 }
 
 /*
@@ -147,17 +228,21 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
 struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
 {
 	struct fsnotify_event *event;
+	struct list_head *list;
 
 	assert_spin_locked(&group->notification_lock);
 
-	if (fsnotify_notify_queue_is_empty(group))
+	list = fsnotify_first_notification_list(group);
+	if (!list)
 		return NULL;
 
-	pr_debug("%s: group=%p\n", __func__, group);
+	pr_debug("%s: group=%p bucket=%u\n", __func__, group, group->first_bucket);
 
-	event = list_first_entry(&group->notification_list,
-				 struct fsnotify_event, list);
+	event = list_first_entry(list, struct fsnotify_event, list);
 	fsnotify_remove_queued_event(group, event);
+	/*
+	 * TODO: update group->first_bucket to next_bucket in first event.
+	 */
 	return event;
 }
 
@@ -167,13 +252,15 @@ struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
  */
 struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
 {
+	struct list_head *list;
+
 	assert_spin_locked(&group->notification_lock);
 
-	if (fsnotify_notify_queue_is_empty(group))
+	list = fsnotify_first_notification_list(group);
+	if (!list)
 		return NULL;
 
-	return list_first_entry(&group->notification_list,
-				struct fsnotify_event, list);
+	return list_first_entry(list, struct fsnotify_event, list);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index e5409b83e731..b2a80bc00108 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -160,6 +160,11 @@ struct fsnotify_ops {
 	void (*free_mark)(struct fsnotify_mark *mark);
 };
 
+#ifdef CONFIG_FANOTIFY
+#define FSNOTIFY_HASHED_QUEUE
+#define FSNOTIFY_HASHED_QUEUE_MAX_BITS 8
+#endif
+
 /*
  * all of the information about the original object we want to now send to
  * a group.  If you want to carry more info from the accessing task to the
@@ -167,7 +172,7 @@ struct fsnotify_ops {
  */
 struct fsnotify_event {
 	struct list_head list;
-	unsigned long objectid;	/* identifier for queue merges */
+	unsigned int key;		/* Key for hashed queue add/merge */
 };
 
 /*
@@ -189,12 +194,10 @@ struct fsnotify_group {
 	 */
 	refcount_t refcnt;		/* things with interest in this group */
 
-	/* needed to send notification to userspace */
-	spinlock_t notification_lock;		/* protect the notification_list */
-	struct list_head notification_list;	/* list of event_holder this group needs to send to userspace */
-	wait_queue_head_t notification_waitq;	/* read() on the notification file blocks on this waitq */
-	unsigned int q_len;			/* events on the queue */
-	unsigned int max_events;		/* maximum events allowed on the list */
+	/* needed to send notification to userspace and wait on group shutdown */
+	spinlock_t notification_lock;		/* protect the event queues */
+	wait_queue_head_t notification_waitq;	/* read() the events blocks on this waitq */
+
 	/*
 	 * Valid fsnotify group priorities.  Events are send in order from highest
 	 * priority to lowest priority.  We default to the lowest priority.
@@ -244,8 +247,36 @@ struct fsnotify_group {
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
+
+	/* Only relevant for groups that use events queue: */
+	unsigned int q_hash_bits;	/* >0 means hashed notification queue */
+	unsigned int max_bucket;	/* notification_list[] range is [0..max_bucket] */
+	unsigned int first_bucket;	/* List to read first event from */
+	unsigned int last_bucket;	/* List of last added event */
+	unsigned int num_events;	/* Number of events in all lists */
+	unsigned int max_events;	/* Maximum events allowed in all lists */
+	struct list_head notification_list[];	/* Queue of events sharded into several lists */
 };
 
+static inline size_t fsnotify_group_size(unsigned int q_hash_bits)
+{
+	return sizeof(struct fsnotify_group) + (sizeof(struct list_head) << q_hash_bits);
+}
+
+static inline unsigned int fsnotify_event_bucket(struct fsnotify_group *group,
+						 struct fsnotify_event *event)
+{
+	/* High bits are better for hash */
+	return (event->key >> (32 - group->q_hash_bits)) & group->max_bucket;
+}
+
+static inline struct list_head *fsnotify_event_notification_list(
+						struct fsnotify_group *group,
+						struct fsnotify_event *event)
+{
+	return &group->notification_list[fsnotify_event_bucket(group, event)];
+}
+
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
@@ -470,7 +501,8 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 
 /* create a new group */
 extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
-extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops);
+extern struct fsnotify_group *fsnotify_alloc_user_group(unsigned int q_hash_bits,
+							const struct fsnotify_ops *ops);
 /* get reference to a group */
 extern void fsnotify_get_group(struct fsnotify_group *group);
 /* drop reference on a group from fsnotify_alloc_group */
@@ -495,8 +527,15 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 	fsnotify_add_event(group, group->overflow_event, NULL);
 }
 
-/* true if the group notification queue is empty */
-extern bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group);
+/* True if all the group event queues are empty */
+static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
+{
+	assert_spin_locked(&group->notification_lock);
+	return group->num_events == 0;
+}
+
+/* Return the notification list of the first event */
+extern struct list_head *fsnotify_first_notification_list(struct fsnotify_group *group);
 /* return, but do not dequeue the first event on the notification queue */
 extern struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group);
 /* return AND dequeue the first event on the notification queue */
@@ -577,10 +616,10 @@ extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
 static inline void fsnotify_init_event(struct fsnotify_event *event,
-				       unsigned long objectid)
+				       unsigned int key)
 {
 	INIT_LIST_HEAD(&event->list);
-	event->objectid = objectid;
+	event->key = key;
 }
 
 #else
-- 
2.25.1

