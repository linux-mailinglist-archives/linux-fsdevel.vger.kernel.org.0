Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8851332D122
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhCDKtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhCDKtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD141C061763
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 02:48:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m7so855558wmq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvPLtIk/5SiiU+j2q2PGjFncYC4qy1AB2pH3m11fCww=;
        b=ae3jM5QLbnfnscL8uko6EeVnXU4DVO4iACXzvcVd03z2GXgHT7CniHjZBqB/EirQ/S
         1b118isd/nRhpEp7X0KfhIDaGgi6rioK5LagTvT+X8vyQg+96QiM3DL9yBLUuvMVSKBQ
         3PaN0iLLHjZSGxKjtFS1lbv6W/rS5Ur37EsEt3bsMKbmTAbWFlR6wIXJE1xj8H5zfag9
         Vyh3yPH8PsoFzGl53zy80ZUeqgk4ycm0E3ZMdLv4gJJkql7dpsSwPwFRBfhBODoUFxeI
         PVhp9N1FfCE11449c/qLipK95f+G+0O7m+yLD/3r6AjGi4BeU9B861/6T2ttSNJiTDec
         THUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvPLtIk/5SiiU+j2q2PGjFncYC4qy1AB2pH3m11fCww=;
        b=pKRyj42FOCXRC+9LRTcTVykv5K04Q4PGAGqHVLfhO3s0wGSycdXZrXBJDNZ0iHEMHd
         yCiOI+jpVS9o9g0eakFZRhB32XIIuBIvfaylGqXNLEcS+ZPM7TFtqKsMbcdanGnzJDSF
         pfbd1FeIZJAbMCDkLRJH1FlfApT4nN9P1BE9NdBaZ8g1IOi6pyPSBEgwvIVl4REeXdLt
         O9fn1Vkn8eAAAcugoFEAi1lg9sThvpJWX4U4BMbNA2mFDs7fh/QzM+jE5aUgbepRDZMb
         tBamPwQvx7qCswOxIe6kBIQUMzBlrjUeeGxF4CHtwf0z8ftFj8yiCw/8bERDSux2slkM
         gLDQ==
X-Gm-Message-State: AOAM5327IL9MEC9vqSURnf4LzmVGek9opYXhWDkSGB7bJ+wPXF0L6xr8
        g/6b2en0yrp3tbUUiut57XY=
X-Google-Smtp-Source: ABdhPJw2vrZ9Gp1Q9Vv0iYvzNu4nBynKFQsJo8+ycEjF0sGkLLh+nc/sl9EPjdbOBKbe+B8bcwDEBw==
X-Received: by 2002:a1c:7e45:: with SMTP id z66mr3284116wmc.126.1614854913601;
        Thu, 04 Mar 2021 02:48:33 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id d7sm6736635wrs.42.2021.03.04.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:48:33 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/5] fsnotify: use hash table for faster events merge
Date:   Thu,  4 Mar 2021 12:48:25 +0200
Message-Id: <20210304104826.3993892-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304104826.3993892-1-amir73il@gmail.com>
References: <20210304104826.3993892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to improve event merge performance, hash events in a 128 size
hash table by the event merge key.

The fanotify_event size grows by two pointers, but we just reduced its
size by removing the objectid member, so overall its size is increased
by one pointer.

Permission events and overflow event are not merged so they are also
not hashed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c        | 40 +++++++++++++++++++++++-----
 fs/notify/fanotify/fanotify.h        | 25 +++++++++++++++++
 fs/notify/fanotify/fanotify_user.c   | 39 +++++++++++++++++++++++++++
 fs/notify/inotify/inotify_fsnotify.c |  7 ++---
 fs/notify/notification.c             | 22 ++++++++++-----
 include/linux/fsnotify_backend.h     | 10 ++++---
 6 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index db30db61a815..1795facc5439 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -149,12 +149,15 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 }
 
 /* and the list better be locked by something too! */
-static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
+static int fanotify_merge(struct fsnotify_group *group,
+			  struct fsnotify_event *event)
 {
-	struct fsnotify_event *test_event;
 	struct fanotify_event *old, *new = FANOTIFY_E(event);
+	unsigned int bucket = fanotify_event_hash_bucket(group, new);
+	struct hlist_head *hlist = &group->fanotify_data.merge_hash[bucket];
 
-	pr_debug("%s: list=%p event=%p\n", __func__, list, event);
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
+		 group, event, bucket);
 
 	/*
 	 * Don't merge a permission event with any other event so that we know
@@ -164,8 +167,7 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 	if (fanotify_is_perm_event(new->mask))
 		return 0;
 
-	list_for_each_entry_reverse(test_event, list, list) {
-		old = FANOTIFY_E(test_event);
+	hlist_for_each_entry(old, hlist, merge_list) {
 		if (fanotify_should_merge(old, new)) {
 			old->mask |= new->mask;
 			return 1;
@@ -203,8 +205,11 @@ static int fanotify_get_response(struct fsnotify_group *group,
 			return ret;
 		}
 		/* Event not yet reported? Just remove it. */
-		if (event->state == FAN_EVENT_INIT)
+		if (event->state == FAN_EVENT_INIT) {
 			fsnotify_remove_queued_event(group, &event->fae.fse);
+			/* Permission events are not supposed to be hashed */
+			WARN_ON_ONCE(!hlist_unhashed(&event->fae.merge_list));
+		}
 		/*
 		 * Event may be also answered in case signal delivery raced
 		 * with wakeup. In that case we have nothing to do besides
@@ -679,6 +684,24 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	return fsid;
 }
 
+/*
+ * Add an event to hash table for faster merge.
+ */
+static void fanotify_insert_event(struct fsnotify_group *group,
+				  struct fsnotify_event *fsn_event)
+{
+	struct fanotify_event *event = FANOTIFY_E(fsn_event);
+	unsigned int bucket = fanotify_event_hash_bucket(group, event);
+	struct hlist_head *hlist = &group->fanotify_data.merge_hash[bucket];
+
+	assert_spin_locked(&group->notification_lock);
+
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
+		 group, event, bucket);
+
+	hlist_add_head(&event->merge_list, hlist);
+}
+
 static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 				 const void *data, int data_type,
 				 struct inode *dir,
@@ -749,7 +772,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	fsn_event = &event->fse;
-	ret = fsnotify_add_event(group, fsn_event, fanotify_merge);
+	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
+				 fanotify_is_hashed_event(mask) ?
+				 fanotify_insert_event : NULL);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
@@ -772,6 +797,7 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 {
 	struct user_struct *user;
 
+	kfree(group->fanotify_data.merge_hash);
 	user = group->fanotify_data.user;
 	atomic_dec(&user->fanotify_listeners);
 	free_uid(user);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 9871f76cd9c2..4a5e555dc3d2 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -3,6 +3,7 @@
 #include <linux/path.h>
 #include <linux/slab.h>
 #include <linux/exportfs.h>
+#include <linux/hashtable.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
@@ -150,6 +151,7 @@ enum fanotify_event_type {
 
 struct fanotify_event {
 	struct fsnotify_event fse;
+	struct hlist_node merge_list;	/* List for hashed merge */
 	u32 mask;
 	struct {
 		unsigned int type : FANOTIFY_EVENT_TYPE_BITS;
@@ -162,6 +164,7 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 				       unsigned int hash, u32 mask)
 {
 	fsnotify_init_event(&event->fse);
+	INIT_HLIST_NODE(&event->merge_list);
 	event->hash = hash;
 	event->mask = mask;
 	event->pid = NULL;
@@ -299,3 +302,25 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 	else
 		return NULL;
 }
+
+/*
+ * Use 128 size hash table to speed up events merge.
+ */
+#define FANOTIFY_HTABLE_BITS	(7)
+#define FANOTIFY_HTABLE_SIZE	(1 << FANOTIFY_HTABLE_BITS)
+#define FANOTIFY_HTABLE_MASK	(FANOTIFY_HTABLE_SIZE - 1)
+
+/*
+ * Permission events and overflow event do not get merged - don't hash them.
+ */
+static inline bool fanotify_is_hashed_event(u32 mask)
+{
+	return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
+}
+
+static inline unsigned int fanotify_event_hash_bucket(
+						struct fsnotify_group *group,
+						struct fanotify_event *event)
+{
+	return event->hash & FANOTIFY_HTABLE_MASK;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 16162207e886..b89f332248bd 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -89,6 +89,23 @@ static int fanotify_event_info_len(unsigned int fid_mode,
 	return info_len;
 }
 
+/*
+ * Remove an hashed event from merge hash table.
+ */
+static void fanotify_unhash_event(struct fsnotify_group *group,
+				  struct fanotify_event *event)
+{
+	assert_spin_locked(&group->notification_lock);
+
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
+		 group, event, fanotify_event_hash_bucket(group, event));
+
+	if (WARN_ON_ONCE(hlist_unhashed(&event->merge_list)))
+		return;
+
+	hlist_del_init(&event->merge_list);
+}
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -126,6 +143,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	fsnotify_remove_first_event(group);
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
+	if (fanotify_is_hashed_event(event->mask))
+		fanotify_unhash_event(group, event);
 out:
 	spin_unlock(&group->notification_lock);
 	return event;
@@ -925,6 +944,20 @@ static struct fsnotify_event *fanotify_alloc_overflow_event(void)
 	return &oevent->fse;
 }
 
+static struct hlist_head *fanotify_alloc_merge_hash(void)
+{
+	struct hlist_head *hash;
+
+	hash = kmalloc(sizeof(struct hlist_head) << FANOTIFY_HTABLE_BITS,
+		       GFP_KERNEL_ACCOUNT);
+	if (!hash)
+		return NULL;
+
+	__hash_init(hash, FANOTIFY_HTABLE_SIZE);
+
+	return hash;
+}
+
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
@@ -993,6 +1026,12 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
+	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
+	if (!group->fanotify_data.merge_hash) {
+		fd = -ENOMEM;
+		goto out_destroy_group;
+	}
+
 	group->overflow_event = fanotify_alloc_overflow_event();
 	if (unlikely(!group->overflow_event)) {
 		fd = -ENOMEM;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 0533bacbd584..d1a64daa0171 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -46,9 +46,10 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	return false;
 }
 
-static int inotify_merge(struct list_head *list,
-			  struct fsnotify_event *event)
+static int inotify_merge(struct fsnotify_group *group,
+			 struct fsnotify_event *event)
 {
+	struct list_head *list = &group->notification_list;
 	struct fsnotify_event *last_event;
 
 	last_event = list_entry(list->prev, struct fsnotify_event, list);
@@ -115,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (len)
 		strcpy(event->name, name->name);
 
-	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
+	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
 	if (ret) {
 		/* Our event wasn't used in the end. Free it. */
 		fsnotify_destroy_event(group, fsn_event);
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 001cfe7d2e4e..0582c7209bc0 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -68,16 +68,22 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
 }
 
 /*
- * Add an event to the group notification queue.  The group can later pull this
- * event off the queue to deal with.  The function returns 0 if the event was
- * added to the queue, 1 if the event was merged with some other queued event,
+ * Try to Add an event to the notification queue.
+ * The group can later pull this event off the queue to deal with.
+ * The group can use the @merge hook to merge the event with a queued event.
+ * The group can use the @insert hook to insert the event into hash table.
+ * The function returns:
+ * 0 if the event was added to a queue
+ * 1 if the event was merged with some other queued event
  * 2 if the event was not queued - either the queue of events has overflown
- * or the group is shutting down.
+ *   or the group is shutting down.
  */
 int fsnotify_add_event(struct fsnotify_group *group,
 		       struct fsnotify_event *event,
-		       int (*merge)(struct list_head *,
-				    struct fsnotify_event *))
+		       int (*merge)(struct fsnotify_group *,
+				    struct fsnotify_event *),
+		       void (*insert)(struct fsnotify_group *,
+				      struct fsnotify_event *))
 {
 	int ret = 0;
 	struct list_head *list = &group->notification_list;
@@ -104,7 +110,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 	}
 
 	if (!list_empty(list) && merge) {
-		ret = merge(list, event);
+		ret = merge(group, event);
 		if (ret) {
 			spin_unlock(&group->notification_lock);
 			return ret;
@@ -114,6 +120,8 @@ int fsnotify_add_event(struct fsnotify_group *group,
 queue:
 	group->q_len++;
 	list_add_tail(&event->list, list);
+	if (insert)
+		insert(group, event);
 	spin_unlock(&group->notification_lock);
 
 	wake_up(&group->notification_waitq);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index fc98f9f88d12..63fb766f0f3e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -233,6 +233,8 @@ struct fsnotify_group {
 #endif
 #ifdef CONFIG_FANOTIFY
 		struct fanotify_group_private_data {
+			/* Hash table of events for merge */
+			struct hlist_head *merge_hash;
 			/* allows a group to block waiting for a userspace response */
 			struct list_head access_list;
 			wait_queue_head_t access_waitq;
@@ -486,12 +488,14 @@ extern void fsnotify_destroy_event(struct fsnotify_group *group,
 /* attach the event to the group notification queue */
 extern int fsnotify_add_event(struct fsnotify_group *group,
 			      struct fsnotify_event *event,
-			      int (*merge)(struct list_head *,
-					   struct fsnotify_event *));
+			      int (*merge)(struct fsnotify_group *,
+					   struct fsnotify_event *),
+			      void (*insert)(struct fsnotify_group *,
+					     struct fsnotify_event *));
 /* Queue overflow event to a notification group */
 static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 {
-	fsnotify_add_event(group, group->overflow_event, NULL);
+	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
 }
 
 static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
-- 
2.30.0

