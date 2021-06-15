Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69663A8D08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhFOX6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhFOX6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BAC061574;
        Tue, 15 Jun 2021 16:56:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6320C1F4332C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 08/14] fsnotify: Support passing argument to insert callback on add_event
Date:   Tue, 15 Jun 2021 19:55:50 -0400
Message-Id: <20210615235556.970928-9-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_FS_ERROR requires some initialization to happen from inside the
insert hook.  This allows a user of fanotify_add_event to pass an
argument to be sent to the insert callback.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c        | 5 +++--
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 fs/notify/notification.c             | 7 +++++--
 include/linux/fsnotify_backend.h     | 7 +++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3822e46fc18a..f64234489811 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -695,7 +695,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
  * Add an event to hash table for faster merge.
  */
 static void fanotify_insert_event(struct fsnotify_group *group,
-				  struct fsnotify_event *fsn_event)
+				  struct fsnotify_event *fsn_event,
+				  const void *data)
 {
 	struct fanotify_event *event = FANOTIFY_E(fsn_event);
 	unsigned int bucket = fanotify_event_hash_bucket(group, event);
@@ -777,7 +778,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	fsn_event = &event->fse;
 	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
 				 fanotify_is_hashed_event(mask) ?
-				 fanotify_insert_event : NULL);
+				 fanotify_insert_event : NULL, NULL);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index d1a64daa0171..a003a64ff8ee 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -116,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (len)
 		strcpy(event->name, name->name);
 
-	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
+	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL, NULL);
 	if (ret) {
 		/* Our event wasn't used in the end. Free it. */
 		fsnotify_destroy_event(group, fsn_event);
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 033294669e07..73db3e7f1735 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -83,7 +83,9 @@ int fsnotify_add_event(struct fsnotify_group *group,
 		       int (*merge)(struct fsnotify_group *,
 				    struct fsnotify_event *),
 		       void (*insert)(struct fsnotify_group *,
-				      struct fsnotify_event *))
+				      struct fsnotify_event *,
+				      const void *),
+		       const void *insert_data)
 {
 	int ret = 0;
 	struct list_head *list = &group->notification_list;
@@ -111,6 +113,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 		 * them in the merge hash.
 		 */
 		insert = NULL;
+		insert_data = NULL;
 		goto queue;
 	}
 
@@ -126,7 +129,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 	group->q_len++;
 	list_add_tail(&event->list, list);
 	if (insert)
-		insert(group, event);
+		insert(group, event, insert_data);
 	spin_unlock(&group->notification_lock);
 
 	wake_up(&group->notification_waitq);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index b1590f654ade..8222fe12a6c9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -526,11 +526,14 @@ extern int fsnotify_add_event(struct fsnotify_group *group,
 			      int (*merge)(struct fsnotify_group *,
 					   struct fsnotify_event *),
 			      void (*insert)(struct fsnotify_group *,
-					     struct fsnotify_event *));
+					     struct fsnotify_event *,
+					     const void *),
+			      const void *insert_data);
+
 /* Queue overflow event to a notification group */
 static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 {
-	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
+	fsnotify_add_event(group, group->overflow_event, NULL, NULL, NULL);
 }
 
 static inline bool fsnotify_is_overflow_event(u32 mask)
-- 
2.31.0

