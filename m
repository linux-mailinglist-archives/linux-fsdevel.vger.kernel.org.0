Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CF40DC60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhIPOI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhIPOI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:08:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0FC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 07:07:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id dw14so4638218pjb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAFyANTO0m4NxnhxkW+K/6J35H5Ad6CuaOG2nFlDWFE=;
        b=qbPL/xEjXaJocQUrWhVjWi7D38ZJdAgX5vRaN3eb56F1rkghE8SHLTR3zbV37Jg0C/
         XTcYcn56KfjplIWDp9g11q/iX7vKBw8I+HVWsOX1t2GaPl7AmtOOPbl4YTVBSGDHm2UZ
         kcXTKSl2/9YaupW68ypK733+bXv/ALIA9ArdB3P7GT1w7+3gFIsu0RIwvYe46rS6ZBI0
         tfIB4iE7cdjZoQTPg3idsr3VRwK0lXfkiGE6+F8U9NBTqJxNfIThAfR6A6xanPP1JLK4
         KSl70+dzcRZmJ25NprXewYodpCUBuEe1aZrBAH3RBhXInGE1+vfrj2Qh0P4qM7yMudj2
         EjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAFyANTO0m4NxnhxkW+K/6J35H5Ad6CuaOG2nFlDWFE=;
        b=KoJ0LwhOPU8AQe8PYFxbj/iHXGe7B4HfnKr/Y4sX7JAEZWN7YWa8v+819z8jYUreAH
         mMH8WfppTLsX35xez8tvE0ZJSuPklqnEXZFGOE40xhLACww09wtO6f4WE9f7g7pTUV2+
         vu1/Dq80zAo3CKVvmBlw/dTEvAs/rDulZKkJgJ8QQboUouZhd+4CY2KoePqjIT5OSKZk
         fFpKgplYWA1dxDqI3+H2OZGETVsEloYLDtb5+WGoUEt0UALmOXZRo7ce0RWm58duY7eL
         Vd4ZuhX4OEzzDsNNEU2OagwriwslYfpJy+PSElDFLiolZUt+RAnprjy/+ptenRQkEk0x
         fx9g==
X-Gm-Message-State: AOAM533m0u3b+EmWgGovoGiWv1IU1kDyVmfwHfF/+E+RZnINm+HGHZDL
        HYLIJvJGgW/9/1X8K8xq4zLwNJVhJS5VFg==
X-Google-Smtp-Source: ABdhPJwMcFGIXPjo+H4kdxBJEyrHPSeOAIH5OKo3V1cu1OhPcHET+4U4l0e5P1Mkqo/9Q2EiJn4Kvg==
X-Received: by 2002:a17:902:7488:b0:13c:9740:3c13 with SMTP id h8-20020a170902748800b0013c97403c13mr5011795pll.76.1631801227526;
        Thu, 16 Sep 2021 07:07:07 -0700 (PDT)
Received: from debian.ljstaff.com ([211.155.93.243])
        by smtp.gmail.com with ESMTPSA id j6sm3427244pgq.0.2021.09.16.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 07:07:07 -0700 (PDT)
From:   Sheng Yong <shengyong2021@gmail.com>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: Extend ioctl to allow to suppress events
Date:   Thu, 16 Sep 2021 22:06:49 +0800
Message-Id: <20210916140649.1057-1-shengyong2021@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a new ioctl cmd INOTIFY_IOC_SUPRESS to stop queueing
events temporarily. A second ioctl could resume queueing events again.
With it enabled, we could easily suppress events instead of updating
or removing watches, especially if we have losts of watches referring
to one inotify instance, for example watching a directory recursively.

Signed-off-by: Sheng Yong <shengyong2021@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/group.c                  | 12 +++++++++---
 fs/notify/inotify/inotify_user.c   |  4 ++++
 fs/notify/mark.c                   |  3 ++-
 fs/notify/notification.c           |  4 ++--
 include/linux/fsnotify_backend.h   | 10 +++++++---
 include/uapi/linux/inotify.h       |  3 +++
 7 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6facdf476255..1e24738762d3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -773,7 +773,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	 * userspace cannot use fanotify fd anymore, no event can enter or
 	 * leave access_list by now either.
 	 */
-	fsnotify_group_stop_queueing(group);
+	fsnotify_group_stop_queueing(group, FS_GRP_SHUTDOWN);
 
 	/*
 	 * Process all permission events on access_list and notification queue
diff --git a/fs/notify/group.c b/fs/notify/group.c
index fb89c351295d..ce62ce6caf30 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -34,10 +34,16 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
  * Stop queueing new events for this group. Once this function returns
  * fsnotify_add_event() will not add any new events to the group's queue.
  */
-void fsnotify_group_stop_queueing(struct fsnotify_group *group)
+void fsnotify_group_stop_queueing(struct fsnotify_group *group, unsigned int st)
 {
+	if (st & ~FS_GRP_STOP_QUEUEING)
+		return;
+
 	spin_lock(&group->notification_lock);
-	group->shutdown = true;
+	if (group->state & st)
+		group->state &= ~st;
+	else
+		group->state |= st;
 	spin_unlock(&group->notification_lock);
 }
 
@@ -55,7 +61,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	 * fsnotify_destroy_group() is called and this makes the other callers
 	 * of fsnotify_destroy_group() to see the same behavior.
 	 */
-	fsnotify_group_stop_queueing(group);
+	fsnotify_group_stop_queueing(group, FS_GRP_SHUTDOWN);
 
 	/* Clear all marks for this group and queue them for destruction */
 	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 62051247f6d2..67cf47f1943b 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -327,6 +327,10 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 #endif /* CONFIG_CHECKPOINT_RESTORE */
+	case INOTIFY_IOC_SUPPRESS:
+		fsnotify_group_stop_queueing(group, FS_GRP_SUPPRESS);
+		ret = 0;
+		break;
 	}
 
 	return ret;
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index fa1d99101f89..08f9d1e480de 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -343,7 +343,8 @@ static void fsnotify_put_mark_wake(struct fsnotify_mark *mark)
 		 * We abuse notification_waitq on group shutdown for waiting for
 		 * all marks pinned when waiting for userspace.
 		 */
-		if (atomic_dec_and_test(&group->user_waits) && group->shutdown)
+		if (atomic_dec_and_test(&group->user_waits) &&
+		    group->state & FS_GRP_SHUTDOWN)
 			wake_up(&group->notification_waitq);
 	}
 }
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 32f45543b9c6..6586e09e9141 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -76,7 +76,7 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
  * 0 if the event was added to a queue
  * 1 if the event was merged with some other queued event
  * 2 if the event was not queued - either the queue of events has overflown
- *   or the group is shutting down.
+ *   or the group is suppressing or shutting down.
  */
 int fsnotify_add_event(struct fsnotify_group *group,
 		       struct fsnotify_event *event,
@@ -92,7 +92,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 
 	spin_lock(&group->notification_lock);
 
-	if (group->shutdown) {
+	if (group->state & FS_GRP_STOP_QUEUEING) {
 		spin_unlock(&group->notification_lock);
 		return 2;
 	}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..1f9b2afb26cb 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -103,6 +103,10 @@
 
 #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_EVENTS | ALL_FSNOTIFY_FLAGS)
 
+#define FS_GRP_SHUTDOWN 0x1	/* group is being shut down, don't queue more events */
+#define FS_GRP_SUPPRESS 0x2	/* group is being suppressed, don't queue more events */
+#define FS_GRP_STOP_QUEUEING (FS_GRP_SHUTDOWN | FS_GRP_SUPPRESS)
+
 struct fsnotify_group;
 struct fsnotify_event;
 struct fsnotify_mark;
@@ -202,7 +206,7 @@ struct fsnotify_group {
 	#define FS_PRIO_1	1 /* fanotify content based access control */
 	#define FS_PRIO_2	2 /* fanotify pre-content access */
 	unsigned int priority;
-	bool shutdown;		/* group is being shut down, don't queue more events */
+	unsigned int state;
 
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
 	struct mutex mark_mutex;	/* protect marks_list */
@@ -472,8 +476,8 @@ extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_op
 extern void fsnotify_get_group(struct fsnotify_group *group);
 /* drop reference on a group from fsnotify_alloc_group */
 extern void fsnotify_put_group(struct fsnotify_group *group);
-/* group destruction begins, stop queuing new events */
-extern void fsnotify_group_stop_queueing(struct fsnotify_group *group);
+/* group destruction begins or suppresses, stop queuing new events */
+extern void fsnotify_group_stop_queueing(struct fsnotify_group *group, unsigned int st);
 /* destroy group */
 extern void fsnotify_destroy_group(struct fsnotify_group *group);
 /* fasync handler function */
diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
index 884b4846b630..07155241d5a9 100644
--- a/include/uapi/linux/inotify.h
+++ b/include/uapi/linux/inotify.h
@@ -78,7 +78,10 @@ struct inotify_event {
  *
  * INOTIFY_IOC_SETNEXTWD: set desired number of next created
  * watch descriptor.
+ *
+ * INOTIFY_IOC_SUPPRESS: suppress events temporarily.
  */
 #define INOTIFY_IOC_SETNEXTWD	_IOW('I', 0, __s32)
+#define INOTIFY_IOC_SUPPRESS	_IOW('I', 1, __s32)
 
 #endif /* _UAPI_LINUX_INOTIFY_H */
-- 
2.20.1

