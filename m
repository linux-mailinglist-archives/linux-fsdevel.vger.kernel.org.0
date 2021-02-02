Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33A830C592
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhBBQ0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhBBQXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F03C061A27
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id w1so30806969ejf.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duY8gSS9Tptw0wHFrAtpi15QbDtf5eCNzekhn9p9FUA=;
        b=bZ0QZh6HvcXux0ay7xEOozN1IxF9vduxOIIlaxxOPh7lPCtXpgSoNmNMr4CJWrotiD
         N9AFEFf+st3ShFNdAd315frsB6KqJg4owbfA2GyfEJNFm2ZP6X6FRy8u0O280ixL3jCr
         IVUvh+1fTBPpbjXDkxFi03GU2drtmScAgEsU3qZ9ub/bxCA6yCS0jywn10AcOzQLej4y
         1R+Nbc8ua2JHfWGzji2bQEgI6CeGwKbAsl7jhNfYftO9NFrHnm7v/QNVDyNIR7iLsrAA
         nESVbBXxtVaC+s+oGqVZVr3yjiIrsOdFj1pkkl2x3qXceARLjo+rLEMuZ5LFSXAItvt6
         +Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duY8gSS9Tptw0wHFrAtpi15QbDtf5eCNzekhn9p9FUA=;
        b=Q+y4JnJ4JAW6VCNwXJ/4zh2XuGImZ3NvO+7uAV9fSDaTd3wBX5SfepdWkzJRXZCWL+
         db9JrGF7LDa3/hvArEV8ik7DuG88dG2XmpBPpD8BaKnmWX+b/1o0NhDcwMaaXZLrF7yD
         SCxk3imy9vVp0ennmLXh0rb22ucSrdfqxcF21wvUGdvX0frXsxCi0iJPB6iZr+ElgVmI
         Tyaain1ddMVuQIfKVp7/zaeNnB0eG8brD7JXOG7ppiOYA4Ur0ZQWB5i7Yc1DSzHK8i25
         u4+zisvJm1v9qVy6T51JNyW3vaNgGXIAEwBQzQR9sl77Kfeo/4Uzq/emuehbqVolRJnO
         9dWg==
X-Gm-Message-State: AOAM533FaHBfjoK65islMFNruxVE6lmoXeGsYJJCkijj8wZFi2Ywh9sd
        8QtTbAfJZysoaOfqniz+2D4=
X-Google-Smtp-Source: ABdhPJw6KO/zQiFfs6vbUa4lkNueYE1AOYJdemqFIM8BLN77m/ZcUXKWUe6isKQfE3il0mqA2Rmdxw==
X-Received: by 2002:a17:906:2b18:: with SMTP id a24mr8534051ejg.50.1612282817349;
        Tue, 02 Feb 2021 08:20:17 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:16 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] fsnotify: read events from hashed notification queue by order of insertion
Date:   Tue,  2 Feb 2021 18:20:06 +0200
Message-Id: <20210202162010.305971-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 64bit arch, use the available 32bit in event for next_bucket field,
that is used to chain all events by order of insertion.

The group has a cursor for the bucket containing the first event and
every event stores the bucket of the next event to read.

On 32bit arch, hashed notification queue is disabled.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/notification.c         | 49 ++++++++++++++++++++++++--------
 include/linux/fsnotify_backend.h | 42 +++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 58c8f6c1be1b..d98f4c8bfb0e 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -84,8 +84,8 @@ static void fsnotify_queue_check(struct fsnotify_group *group)
 	if (fsnotify_notify_queue_is_empty(group))
 		return;
 
-	first_empty = list_empty(&group->notification_list[group->first_bucket]);
-	last_empty = list_empty(&group->notification_list[group->last_bucket]);
+	first_empty = WARN_ON_ONCE(list_empty(&group->notification_list[group->first_bucket]));
+	last_empty = WARN_ON_ONCE(list_empty(&group->notification_list[group->last_bucket]));
 
 	list = &group->notification_list[0];
 	for (i = 0; i <= group->max_bucket; i++, list++) {
@@ -121,12 +121,23 @@ static void fsnotify_queue_event(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__, group, event, b);
 
-	/*
-	 * TODO: set next_bucket of last event.
-	 */
-	group->last_bucket = b;
-	if (!group->num_events)
-		group->first_bucket = b;
+	if (fsnotify_notify_queue_is_hashed(group)) {
+		/*
+		 * On first insert, set this event's list as the list to read first event.
+		 * Otherwise, point from last event to this event's list.
+		 */
+		struct list_head *last_l = &group->notification_list[group->last_bucket];
+
+		if (!group->num_events) {
+			group->first_bucket = b;
+		} else if (!WARN_ON_ONCE(list_empty(last_l))) {
+			struct fsnotify_event *last_e;
+
+			last_e = list_last_entry(last_l, struct fsnotify_event, list);
+			fsnotify_event_set_next_bucket(last_e, b);
+		}
+		group->last_bucket = b;
+	}
 	group->num_events++;
 	list_add_tail(&event->list, list);
 }
@@ -186,8 +197,8 @@ int fsnotify_add_event(struct fsnotify_group *group,
 	return ret;
 }
 
-void fsnotify_remove_queued_event(struct fsnotify_group *group,
-				  struct fsnotify_event *event)
+static void __fsnotify_remove_queued_event(struct fsnotify_group *group,
+					   struct fsnotify_event *event)
 {
 	assert_spin_locked(&group->notification_lock);
 	/*
@@ -198,6 +209,17 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
 	group->num_events--;
 }
 
+void fsnotify_remove_queued_event(struct fsnotify_group *group,
+				  struct fsnotify_event *event)
+{
+	/*
+	 * if called for removal of event in the middle of a hashed queue,
+	 * events may be read not in insertion order.
+	 */
+	WARN_ON_ONCE(fsnotify_notify_queue_is_hashed(group));
+	__fsnotify_remove_queued_event(group, event);
+}
+
 /* Return the notification list of the first event */
 struct list_head *fsnotify_first_notification_list(struct fsnotify_group *group)
 {
@@ -213,6 +235,7 @@ struct list_head *fsnotify_first_notification_list(struct fsnotify_group *group)
 		return list;
 
 	/*
+	 * Oops... first bucket is not supposed to be empty.
 	 * Look for any non-empty bucket.
 	 */
 	fsnotify_queue_check(group);
@@ -239,10 +262,12 @@ struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
 	pr_debug("%s: group=%p bucket=%u\n", __func__, group, group->first_bucket);
 
 	event = list_first_entry(list, struct fsnotify_event, list);
-	fsnotify_remove_queued_event(group, event);
+	__fsnotify_remove_queued_event(group, event);
 	/*
-	 * TODO: update group->first_bucket to next_bucket in first event.
+	 * Removed event points to the next list to read from.
 	 */
+	group->first_bucket = fsnotify_event_next_bucket(event);
+
 	return event;
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index b2a80bc00108..3fc3c9e4d21c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -161,9 +161,12 @@ struct fsnotify_ops {
 };
 
 #ifdef CONFIG_FANOTIFY
+#if BITS_PER_LONG == 64
+/* Use available 32bit of event for hashed queue support */
 #define FSNOTIFY_HASHED_QUEUE
 #define FSNOTIFY_HASHED_QUEUE_MAX_BITS 8
 #endif
+#endif
 
 /*
  * all of the information about the original object we want to now send to
@@ -173,6 +176,9 @@ struct fsnotify_ops {
 struct fsnotify_event {
 	struct list_head list;
 	unsigned int key;		/* Key for hashed queue add/merge */
+#ifdef FSNOTIFY_HASHED_QUEUE
+	unsigned int next_bucket;	/* Bucket to read next event from */
+#endif
 };
 
 /*
@@ -277,6 +283,41 @@ static inline struct list_head *fsnotify_event_notification_list(
 	return &group->notification_list[fsnotify_event_bucket(group, event)];
 }
 
+#ifdef FSNOTIFY_HASHED_QUEUE
+static inline bool fsnotify_notify_queue_is_hashed(struct fsnotify_group *group)
+{
+	return group->max_bucket > 0;
+}
+
+static inline unsigned int fsnotify_event_next_bucket(struct fsnotify_event *event)
+{
+	return event->next_bucket;
+}
+
+static inline void fsnotify_event_set_next_bucket(struct fsnotify_event *event,
+						  unsigned int b)
+{
+	event->next_bucket = b;
+}
+
+#else
+static inline bool fsnotify_notify_queue_is_hashed(struct fsnotify_group *group)
+{
+	return false;
+}
+
+static inline unsigned int fsnotify_event_next_bucket(struct fsnotify_event *event)
+{
+	return 0;
+}
+
+static inline void fsnotify_event_set_next_bucket(struct fsnotify_event *event,
+						  unsigned int b)
+{
+}
+
+#endif
+
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
@@ -620,6 +661,7 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
 {
 	INIT_LIST_HEAD(&event->list);
 	event->key = key;
+	fsnotify_event_set_next_bucket(event, 0);
 }
 
 #else
-- 
2.25.1

