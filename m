Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EAD42E37A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhJNVk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:40:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhJNVkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:40:23 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A62CF1F44F83;
        Thu, 14 Oct 2021 22:38:16 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 11/28] fsnotify: Pass group argument to free_event
Date:   Thu, 14 Oct 2021 18:36:29 -0300
Message-Id: <20211014213646.1139469-12-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For group-wide mempool backed events, like FS_ERROR, the free_event
callback will need to reference the group's mempool to free the memory.
Wire that argument into the current callers.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c        | 3 ++-
 fs/notify/group.c                    | 2 +-
 fs/notify/inotify/inotify_fsnotify.c | 3 ++-
 fs/notify/notification.c             | 2 +-
 include/linux/fsnotify_backend.h     | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index f82e20228999..c620b4f6fe12 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -835,7 +835,8 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 	kfree(FANOTIFY_NE(event));
 }
 
-static void fanotify_free_event(struct fsnotify_event *fsn_event)
+static void fanotify_free_event(struct fsnotify_group *group,
+				struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
 
diff --git a/fs/notify/group.c b/fs/notify/group.c
index fb89c351295d..6a297efc4788 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -88,7 +88,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	 * that deliberately ignores overflow events.
 	 */
 	if (group->overflow_event)
-		group->ops->free_event(group->overflow_event);
+		group->ops->free_event(group, group->overflow_event);
 
 	fsnotify_put_group(group);
 }
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index a96582cbfad1..d92d7b0adc9a 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -177,7 +177,8 @@ static void inotify_free_group_priv(struct fsnotify_group *group)
 		dec_inotify_instances(group->inotify_data.ucounts);
 }
 
-static void inotify_free_event(struct fsnotify_event *fsn_event)
+static void inotify_free_event(struct fsnotify_group *group,
+			       struct fsnotify_event *fsn_event)
 {
 	kfree(INOTIFY_E(fsn_event));
 }
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 44bb10f50715..9022ae650cf8 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -64,7 +64,7 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
 		WARN_ON(!list_empty(&event->list));
 		spin_unlock(&group->notification_lock);
 	}
-	group->ops->free_event(event);
+	group->ops->free_event(group, event);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 035438fe4a43..1e69e9fe45c9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -155,7 +155,7 @@ struct fsnotify_ops {
 			    const struct qstr *file_name, u32 cookie);
 	void (*free_group_priv)(struct fsnotify_group *group);
 	void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
-	void (*free_event)(struct fsnotify_event *event);
+	void (*free_event)(struct fsnotify_group *group, struct fsnotify_event *event);
 	/* called on final put+free to free memory */
 	void (*free_mark)(struct fsnotify_mark *mark);
 };
-- 
2.33.0

