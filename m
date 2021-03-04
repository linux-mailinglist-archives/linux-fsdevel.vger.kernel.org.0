Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA532D11E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbhCDKtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbhCDKtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86090C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 02:48:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u16so9081733wrt.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 02:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdKMKmCulEu9yUl0BzkGlzPECPrQ7du2NIbp3/YfnRY=;
        b=WHW6zfNa8t1xIGQ3TjCPssZ72/XfYBsToGDPlfG7Bfm9C4gXNwGHEnQeonENnU87wl
         fibFVUSydTYW7I9AeAQsOUXY7eX21bjmHs0OQ4Sr/ACGGryALOQ+2WsMi8zZAbenchox
         jeDtErMN+uIsHMt0s96kHvOs7rx9skBL4xrC1bXO46NOst2JN80dpZqVhg1OGmXr/zUt
         LUzkqBnsIycZOd9yl7zWGwnuJapdx31JoRb7F+CWs+LiUgxefoKhiVmgHyIuUKouo2ZJ
         5bskIauZGiNlYTX9XEmDGg4b2NQoOtvNDfwtR5sKCIOrqFX3D+54nnFfzAn+uIOLnsF3
         o1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdKMKmCulEu9yUl0BzkGlzPECPrQ7du2NIbp3/YfnRY=;
        b=Q+pFrqVqGhw8npiJPQbd2oHlOI6JnOMjR8Twmc99XO1M+dgyAzgxC7uX+EomSIuVjJ
         kxyX3g4dJ9mPdTgWPPnxTGfXj4B10Sh0wAvIre/U5K1lfk8Lh9yLgxSPpO9IKOANSB5y
         JCmEUFVCzSaWUlQIZ12XrmIHMg2hU6EvJ35Z++4HG2bosk47OmmARDI6+5RyYCbHCRYk
         +MiES5L3VlmQo58DcZ0rryee6eCD9hDl9OO0wDzV4an6AP6BJjRkUA6Sdjf3qHQE/ic4
         il5QWjemcTAahqbEaqEoFOHR8B2eiLBJfee5MqwRYt6LvwtNyRPcDcYiQlcktSFLoEVi
         Bj4w==
X-Gm-Message-State: AOAM531TTcMWR9a4gzSBhsCs8pgfbsomAyk//sG7/H6HL6MnDEiVlCIA
        P6+DbcqCWnwefwpBzQHgPXY=
X-Google-Smtp-Source: ABdhPJzD6oDjsou8SJ77IfHHHN6Z8kMOWaH0fIsYzb5Ene1auGSt3sxEwpPTjMwpp5csrZVpNqOJDg==
X-Received: by 2002:a5d:6a87:: with SMTP id s7mr3403913wru.312.1614854910252;
        Thu, 04 Mar 2021 02:48:30 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id d7sm6736635wrs.42.2021.03.04.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:48:29 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/5] fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
Date:   Thu,  4 Mar 2021 12:48:22 +0200
Message-Id: <20210304104826.3993892-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304104826.3993892-1-amir73il@gmail.com>
References: <20210304104826.3993892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current code has an assumtion that fsnotify_notify_queue_is_empty() is
called to verify that queue is not empty before trying to peek or remove
an event from queue.

Remove this assumption by moving the fsnotify_notify_queue_is_empty()
into the functions, allow them to return NULL value and check return
value by all callers.

This is a prep patch for multi event queues.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 26 +++++++++++-------
 fs/notify/inotify/inotify_user.c   |  5 ++--
 fs/notify/notification.c           | 42 ++++++++++++++----------------
 include/linux/fsnotify_backend.h   |  8 +++++-
 4 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9e0c1afac8bd..16162207e886 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -100,24 +100,30 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 {
 	size_t event_size = FAN_EVENT_METADATA_LEN;
 	struct fanotify_event *event = NULL;
+	struct fsnotify_event *fsn_event;
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 
 	pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
 
 	spin_lock(&group->notification_lock);
-	if (fsnotify_notify_queue_is_empty(group))
+	fsn_event = fsnotify_peek_first_event(group);
+	if (!fsn_event)
 		goto out;
 
-	if (fid_mode) {
-		event_size += fanotify_event_info_len(fid_mode,
-			FANOTIFY_E(fsnotify_peek_first_event(group)));
-	}
+	event = FANOTIFY_E(fsn_event);
+	if (fid_mode)
+		event_size += fanotify_event_info_len(fid_mode, event);
 
 	if (event_size > count) {
 		event = ERR_PTR(-EINVAL);
 		goto out;
 	}
-	event = FANOTIFY_E(fsnotify_remove_first_event(group));
+
+	/*
+	 * Held the notification_lock the whole time, so this is the
+	 * same event we peeked above.
+	 */
+	fsnotify_remove_first_event(group);
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
 out:
@@ -573,6 +579,7 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group = file->private_data;
+	struct fsnotify_event *fsn_event;
 
 	/*
 	 * Stop new events from arriving in the notification queue. since
@@ -601,13 +608,12 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	 * dequeue them and set the response. They will be freed once the
 	 * response is consumed and fanotify_get_response() returns.
 	 */
-	while (!fsnotify_notify_queue_is_empty(group)) {
-		struct fanotify_event *event;
+	while ((fsn_event = fsnotify_remove_first_event(group))) {
+		struct fanotify_event *event = FANOTIFY_E(fsn_event);
 
-		event = FANOTIFY_E(fsnotify_remove_first_event(group));
 		if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
 			spin_unlock(&group->notification_lock);
-			fsnotify_destroy_event(group, &event->fse);
+			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
 						FAN_ALLOW);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c71be4fb7dc5..a6c95bd64618 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -146,10 +146,9 @@ static struct fsnotify_event *get_one_event(struct fsnotify_group *group,
 	size_t event_size = sizeof(struct inotify_event);
 	struct fsnotify_event *event;
 
-	if (fsnotify_notify_queue_is_empty(group))
-		return NULL;
-
 	event = fsnotify_peek_first_event(group);
+	if (!event)
+		return NULL;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 75d79d6d3ef0..001cfe7d2e4e 100644
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
@@ -141,33 +134,36 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
 }
 
 /*
- * Remove and return the first event from the notification list.  It is the
- * responsibility of the caller to destroy the obtained event
+ * Return the first event on the notification list without removing it.
+ * Returns NULL if the list is empty.
  */
-struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
+struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
 {
-	struct fsnotify_event *event;
-
 	assert_spin_locked(&group->notification_lock);
 
-	pr_debug("%s: group=%p\n", __func__, group);
+	if (fsnotify_notify_queue_is_empty(group))
+		return NULL;
 
-	event = list_first_entry(&group->notification_list,
-				 struct fsnotify_event, list);
-	fsnotify_remove_queued_event(group, event);
-	return event;
+	return list_first_entry(&group->notification_list,
+				struct fsnotify_event, list);
 }
 
 /*
- * This will not remove the event, that must be done with
- * fsnotify_remove_first_event()
+ * Remove and return the first event from the notification list.  It is the
+ * responsibility of the caller to destroy the obtained event
  */
-struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
+struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
 {
-	assert_spin_locked(&group->notification_lock);
+	struct fsnotify_event *event = fsnotify_peek_first_event(group);
 
-	return list_first_entry(&group->notification_list,
-				struct fsnotify_event, list);
+	if (!event)
+		return NULL;
+
+	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
+
+	fsnotify_remove_queued_event(group, event);
+
+	return event;
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index e5409b83e731..7eb979bfc141 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -495,7 +495,13 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 	fsnotify_add_event(group, group->overflow_event, NULL);
 }
 
-/* true if the group notification queue is empty */
+static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
+{
+	assert_spin_locked(&group->notification_lock);
+
+	return list_empty(&group->notification_list);
+}
+
 extern bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group);
 /* return, but do not dequeue the first event on the notification queue */
 extern struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group);
-- 
2.30.0

