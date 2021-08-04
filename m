Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836413E0559
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhHDQHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:07:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41966 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhHDQHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:07:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4CD091F4080F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v5 09/23] fsnotify: Support passing argument to insert callback on add_event
Date:   Wed,  4 Aug 2021 12:05:58 -0400
Message-Id: <20210804160612.3575505-10-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_FS_ERROR requires some initialization to happen from inside the
insert hook.  This allows a user of fanotify_add_event to pass an
argument to be sent to the insert callback.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c    | 5 +++--
 fs/notify/notification.c         | 6 ++++--
 include/linux/fsnotify_backend.h | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index acf78c0ed219..538d114f439f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -694,7 +694,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
  * Add an event to hash table for faster merge.
  */
 static void fanotify_insert_event(struct fsnotify_group *group,
-				  struct fsnotify_event *fsn_event)
+				  struct fsnotify_event *fsn_event,
+				  const void *data)
 {
 	struct fanotify_event *event = FANOTIFY_E(fsn_event);
 	unsigned int bucket = fanotify_event_hash_bucket(group, event);
@@ -782,7 +783,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 	fsn_event = &event->fse;
 	ret = fsnotify_insert_event(group, fsn_event, fanotify_merge,
-				    fanotify_insert_event);
+				    fanotify_insert_event, NULL);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 44bb10f50715..206a17346ca6 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -83,7 +83,9 @@ int fsnotify_insert_event(struct fsnotify_group *group,
 			  int (*merge)(struct fsnotify_group *,
 				       struct fsnotify_event *),
 			  void (*insert)(struct fsnotify_group *,
-					 struct fsnotify_event *))
+					 struct fsnotify_event *,
+					 const void *),
+			  const void *insert_data)
 {
 	int ret = 0;
 	struct list_head *list = &group->notification_list;
@@ -121,7 +123,7 @@ int fsnotify_insert_event(struct fsnotify_group *group,
 	group->q_len++;
 	list_add_tail(&event->list, list);
 	if (insert)
-		insert(group, event);
+		insert(group, event, insert_data);
 	spin_unlock(&group->notification_lock);
 
 	wake_up(&group->notification_waitq);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index cd4ca11f129e..693fe4cb48cf 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -500,14 +500,16 @@ extern int fsnotify_insert_event(struct fsnotify_group *group,
 				 int (*merge)(struct fsnotify_group *,
 					      struct fsnotify_event *),
 				 void (*insert)(struct fsnotify_group *,
-						struct fsnotify_event *));
+						struct fsnotify_event *,
+						const void *),
+				 const void *insert_data);
 
 static inline int fsnotify_add_event(struct fsnotify_group *group,
 				     struct fsnotify_event *event,
 				     int (*merge)(struct fsnotify_group *,
 						  struct fsnotify_event *))
 {
-	return fsnotify_insert_event(group, event, merge, NULL);
+	return fsnotify_insert_event(group, event, merge, NULL, NULL);
 }
 
 /* Queue overflow event to a notification group */
-- 
2.32.0

