Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABC3EAC91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhHLVlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45732 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbhHLVlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 11E831F44220
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v6 08/21] fsnotify: Add wrapper around fsnotify_add_event
Date:   Thu, 12 Aug 2021 17:39:57 -0400
Message-Id: <20210812214010.3197279-9-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify_add_event is growing in number of parameters, which in most
case are just passed a NULL pointer.  So, split out a new
fsnotify_insert_event function to clean things up for users who don't
need an insert hook.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c        |  4 ++--
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/notification.c             | 12 ++++++------
 include/linux/fsnotify_backend.h     | 23 ++++++++++++++++-------
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c3eefe3f6494..acf78c0ed219 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -781,8 +781,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	fsn_event = &event->fse;
-	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
-				 fanotify_insert_event);
+	ret = fsnotify_insert_event(group, fsn_event, fanotify_merge,
+				    fanotify_insert_event);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index d1a64daa0171..a96582cbfad1 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -116,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (len)
 		strcpy(event->name, name->name);
 
-	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
+	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
 		/* Our event wasn't used in the end. Free it. */
 		fsnotify_destroy_event(group, fsn_event);
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 32f45543b9c6..44bb10f50715 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -78,12 +78,12 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
  * 2 if the event was not queued - either the queue of events has overflown
  *   or the group is shutting down.
  */
-int fsnotify_add_event(struct fsnotify_group *group,
-		       struct fsnotify_event *event,
-		       int (*merge)(struct fsnotify_group *,
-				    struct fsnotify_event *),
-		       void (*insert)(struct fsnotify_group *,
-				      struct fsnotify_event *))
+int fsnotify_insert_event(struct fsnotify_group *group,
+			  struct fsnotify_event *event,
+			  int (*merge)(struct fsnotify_group *,
+				       struct fsnotify_event *),
+			  void (*insert)(struct fsnotify_group *,
+					 struct fsnotify_event *))
 {
 	int ret = 0;
 	struct list_head *list = &group->notification_list;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index cb75fb6d130a..e027af3cd8dd 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -494,16 +494,25 @@ extern int fsnotify_fasync(int fd, struct file *file, int on);
 extern void fsnotify_destroy_event(struct fsnotify_group *group,
 				   struct fsnotify_event *event);
 /* attach the event to the group notification queue */
-extern int fsnotify_add_event(struct fsnotify_group *group,
-			      struct fsnotify_event *event,
-			      int (*merge)(struct fsnotify_group *,
-					   struct fsnotify_event *),
-			      void (*insert)(struct fsnotify_group *,
-					     struct fsnotify_event *));
+extern int fsnotify_insert_event(struct fsnotify_group *group,
+				 struct fsnotify_event *event,
+				 int (*merge)(struct fsnotify_group *,
+					      struct fsnotify_event *),
+				 void (*insert)(struct fsnotify_group *,
+						struct fsnotify_event *));
+
+static inline int fsnotify_add_event(struct fsnotify_group *group,
+				     struct fsnotify_event *event,
+				     int (*merge)(struct fsnotify_group *,
+						  struct fsnotify_event *))
+{
+	return fsnotify_insert_event(group, event, merge, NULL);
+}
+
 /* Queue overflow event to a notification group */
 static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 {
-	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
+	fsnotify_add_event(group, group->overflow_event, NULL);
 }
 
 static inline bool fsnotify_is_overflow_event(u32 mask)
-- 
2.32.0

