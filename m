Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9130C57E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhBBQZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhBBQX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F29C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i8so14392371ejc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os4h8e0Oynzttj6eg8Va36k+oFVocWL1p818Ji0VtKE=;
        b=Lmm+QA3McHuM7OsoeP0EJjJYNdI6JuxYCQ2FDiJE5HJiiPKbphPPsJcKpA/GHs3yut
         XPhpvXQW05u4eA6XdVdtlnZVpSiZTKctUecC61pJJ6KuT3DeEsK7YwPfClJkHEZslB16
         WQSVme9t/m6Rjnhh6PQSyWlYwE0wxSAIdtof4G6gYW8sqXBtXgSuzyzfa4fhg7hhQ6fz
         76A227U6yLUErebkm4r2Fjna+1eIkjA6akGZtVk42ZVW5Vg9wcwG4eFNxRAElQwXroYq
         zZ7QKEpaTjBhwMjuLaR5NBo/9ubyj9/6i+25OgIVG3mtYuXhr6fazGo/rI4q5aS+y9LS
         2EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os4h8e0Oynzttj6eg8Va36k+oFVocWL1p818Ji0VtKE=;
        b=gporSWGn2JnWm4jx8r8MQcZQqVUlwZPsZBtr27TcYH1ify8yeDrIfJ65X1iEbG0ahd
         cX4QT2Ex7xKtY8KMQ7BQp8gQJEMzlnFo+59DyKHA6mFtagq4S43M6dEcfT+8hdJUYnjO
         Di8ihZXHOBQYLrpryYioCk0Sd0iYe4ULDw95u+qxV8URM1GcjZzaGoL/VJy6x1zrAEXx
         xgzOE8bvQSzoEJwkhWA04F8D3iqUhbBqc2sopkSk+9XDTeMCxTpuH8otEGpORZbMY2Sl
         56FAVxiFl3VAd1EkjhZvUTOw2nF3VpEWoWKqvgDYl9A4lyKpYEHFfs0zwULEFZm69S/S
         o6jg==
X-Gm-Message-State: AOAM533Xw81HEo+896J9n32AfsjfuRMnZcyeJwzZnP+UOtzJX/6tmCnW
        rmAghCGbK9CUXZZ1YdDh8CS9l++tS+4=
X-Google-Smtp-Source: ABdhPJyvMG5xjTc4+sXMvgQgC+cxArxQF1DVgbIFGuNzqOFCaV6P5HZ18VnWr90Lu7lyD+5Ka1qb3A==
X-Received: by 2002:a17:906:8555:: with SMTP id h21mr14206996ejy.403.1612282814809;
        Tue, 02 Feb 2021 08:20:14 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:14 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
Date:   Tue,  2 Feb 2021 18:20:04 +0200
Message-Id: <20210202162010.305971-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify_user.c | 26 ++++++++++++++++----------
 fs/notify/inotify/inotify_user.c   |  5 ++---
 fs/notify/notification.c           |  6 ++++++
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b78dd1f88f7c..8ff27d92d32c 100644
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
index 266d17e8ecb9..d8830be60a9b 100644
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
index 75d79d6d3ef0..fcac2d72cbf5 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -150,6 +150,9 @@ struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
 
 	assert_spin_locked(&group->notification_lock);
 
+	if (fsnotify_notify_queue_is_empty(group))
+		return NULL;
+
 	pr_debug("%s: group=%p\n", __func__, group);
 
 	event = list_first_entry(&group->notification_list,
@@ -166,6 +169,9 @@ struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
 {
 	assert_spin_locked(&group->notification_lock);
 
+	if (fsnotify_notify_queue_is_empty(group))
+		return NULL;
+
 	return list_first_entry(&group->notification_list,
 				struct fsnotify_event, list);
 }
-- 
2.25.1

