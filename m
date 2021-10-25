Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9F43A3FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhJYULu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhJYULm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:11:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F9C04A409;
        Mon, 25 Oct 2021 12:30:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7A7E41F433B0;
        Mon, 25 Oct 2021 20:28:59 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 09/31] fsnotify: Add wrapper around fsnotify_add_event
Date:   Mon, 25 Oct 2021 16:27:24 -0300
Message-Id: <20211025192746.66445-10-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
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
index 310246f8d3f1..f82e20228999 100644
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
index 749bc85e1d1c..b323d0c4b967 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -498,16 +498,25 @@ extern int fsnotify_fasync(int fd, struct file *file, int on);
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
2.33.0

