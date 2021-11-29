Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC346276A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhK2XEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236469AbhK2XDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:03:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FDBC06FD46
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:44 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l16so39414417wrp.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYjymlYAKhZtgcKgqY6to9RuxYUhlt5MgfPZbrsMX0c=;
        b=QYRgkqWfxQ5VXxaI3fDrsTFwy0he9OvGPEZhGUaJdV4ef0DuTJKlTimgiNq9YhZCjT
         uOKS40xyUGzaMKBbNbdqR9d0sRbLEyWvIMdhqk6Ck51r6xLPyLzxHBBUUmPmrtjGST9C
         HY+7zW8YuTnharD1DTfSVL1DQqCVOFIXVDhz5/YJrFwL388Bq1jjqjVk1s2Up3HN3/6D
         MwfxzSMn8FWRbDgMeD8dpGsZlaslfhwZrGZijXIqho7dJxHfsQj3+hXTu7/ksQfXnz77
         GyCQDc2GZmUA979IhI6uQobvgPobz7qNAhjv5McOvBisE/8oJE9EvzURE38zBRj/WyVd
         ipLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYjymlYAKhZtgcKgqY6to9RuxYUhlt5MgfPZbrsMX0c=;
        b=z6EQ/rL7s0jEKd8Y/KW0J/pUyXwuHUslZ2t/AjB5hC6MYH6qXEUmexIEelZ8UBuIot
         UJKfPbj5eKWmUgwBKEBfMyweUJWVQPn2ooLlUvSY3d7yoyGSU4BOBagicrWQhqiI/kuB
         VFva47qUMXRfkQnXu7zGFmq1lmRx2gfepM55w9C9+CVFVnog6zs6DDEytZtFLcN9mYCR
         egtUoBC6DWT3RhRL5kovFLWC6SAUp50FaYEqbVzgjDOqWm55qjcUHchVjUBPlC+rQiG4
         WqMrth8EvYGItXd4AkAQHhM6EFtjIw8wp/xPeglUsBh53UFMLbO2HgXdcEtQTPF4si9h
         TvpQ==
X-Gm-Message-State: AOAM532PzzsYnkXQ7LLBHy4w8h3C0fZBcQIszJ6esrqWQAKPW6D38Gir
        SVG19uNxB7Qnml/yC0bsmto=
X-Google-Smtp-Source: ABdhPJwZn5PMqMeStW+CCpzSGgqZEcPwIaVFNO6ZrnViW6jhZ8bT5unzlZtxYbHpmQF8GPAuKSnagg==
X-Received: by 2002:a5d:6e85:: with SMTP id k5mr36346764wrz.545.1638216942669;
        Mon, 29 Nov 2021 12:15:42 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:42 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/11] fsnotify: separate mark iterator type from object type enum
Date:   Mon, 29 Nov 2021 22:15:28 +0200
Message-Id: <20211129201537.1932819-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

They are two different types that use the same enum, so this confusing.

Use the object type to indicate the type of object mark is attached to
and the iter type to indicate the type of watch.

A group can have two different watches of the same object type (parent
and child watches) that match the same event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    |  6 ++---
 fs/notify/fsnotify.c             | 18 +++++++-------
 fs/notify/mark.c                 |  4 ++--
 include/linux/fsnotify_backend.h | 41 ++++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b6091775aa6e..652fe84cb8ac 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -299,7 +299,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			return 0;
 	}
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		if (!fsnotify_iter_should_report_type(iter_info, type))
 			continue;
 		mark = iter_info->marks[type];
@@ -318,7 +318,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		 * If the event is on a child and this mark is on a parent not
 		 * watching children, don't send it!
 		 */
-		if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
+		if (type == FSNOTIFY_ITER_TYPE_PARENT &&
 		    !(mark->mask & FS_EVENT_ON_CHILD))
 			continue;
 
@@ -746,7 +746,7 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	int type;
 	__kernel_fsid_t fsid = {};
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		struct fsnotify_mark_connector *conn;
 
 		if (!fsnotify_iter_should_report_type(iter_info, type))
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 4034ca566f95..0c94457c625e 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -330,7 +330,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 
 	/* clear ignored on inode modification */
 	if (mask & FS_MODIFY) {
-		fsnotify_foreach_obj_type(type) {
+		fsnotify_foreach_iter_type(type) {
 			if (!fsnotify_iter_should_report_type(iter_info, type))
 				continue;
 			mark = iter_info->marks[type];
@@ -340,7 +340,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 		}
 	}
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		if (!fsnotify_iter_should_report_type(iter_info, type))
 			continue;
 		mark = iter_info->marks[type];
@@ -405,7 +405,7 @@ static unsigned int fsnotify_iter_select_report_types(
 	int type;
 
 	/* Choose max prio group among groups of all queue heads */
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
 		if (mark &&
 		    fsnotify_compare_groups(max_prio_group, mark->group) > 0)
@@ -417,7 +417,7 @@ static unsigned int fsnotify_iter_select_report_types(
 
 	/* Set the report mask for marks from same group as max prio group */
 	iter_info->report_mask = 0;
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
 		if (mark &&
 		    fsnotify_compare_groups(max_prio_group, mark->group) == 0)
@@ -435,7 +435,7 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 {
 	int type;
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		if (fsnotify_iter_should_report_type(iter_info, type))
 			iter_info->marks[type] =
 				fsnotify_next_mark(iter_info->marks[type]);
@@ -519,18 +519,18 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
+	iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
 		fsnotify_first_mark(&sb->s_fsnotify_marks);
 	if (mnt) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
+		iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}
 	if (inode) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
+		iter_info.marks[FSNOTIFY_ITER_TYPE_INODE] =
 			fsnotify_first_mark(&inode->i_fsnotify_marks);
 	}
 	if (parent) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_PARENT] =
+		iter_info.marks[FSNOTIFY_ITER_TYPE_PARENT] =
 			fsnotify_first_mark(&parent->i_fsnotify_marks);
 	}
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 52af2e9dadc0..9007d6affff3 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -353,7 +353,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 {
 	int type;
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		/* This can fail if mark is being removed */
 		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
 			__release(&fsnotify_mark_srcu);
@@ -382,7 +382,7 @@ void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
 	int type;
 
 	iter_info->srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
-	fsnotify_foreach_obj_type(type)
+	fsnotify_foreach_iter_type(type)
 		fsnotify_put_mark_wake(iter_info->marks[type]);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index b9c84b1dbcc8..73739fee1710 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -337,10 +337,25 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 	}
 }
 
+/*
+ * Index to merged marks iterator array that correlates to a type of watch.
+ * The type of watched object can be deduced from the iterator type, but not
+ * the other way around, because an event can match different watched objects
+ * of the same object type.
+ * For example, both parent and child are watching an object of type inode.
+ */
+enum fsnotify_iter_type {
+	FSNOTIFY_ITER_TYPE_INODE,
+	FSNOTIFY_ITER_TYPE_VFSMOUNT,
+	FSNOTIFY_ITER_TYPE_SB,
+	FSNOTIFY_ITER_TYPE_PARENT,
+	FSNOTIFY_ITER_TYPE_COUNT
+};
+
+/* The type of object that a mark is attached to */
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_ANY = -1,
 	FSNOTIFY_OBJ_TYPE_INODE,
-	FSNOTIFY_OBJ_TYPE_PARENT,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
 	FSNOTIFY_OBJ_TYPE_COUNT,
@@ -353,37 +368,37 @@ static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
 }
 
 struct fsnotify_iter_info {
-	struct fsnotify_mark *marks[FSNOTIFY_OBJ_TYPE_COUNT];
+	struct fsnotify_mark *marks[FSNOTIFY_ITER_TYPE_COUNT];
 	unsigned int report_mask;
 	int srcu_idx;
 };
 
 static inline bool fsnotify_iter_should_report_type(
-		struct fsnotify_iter_info *iter_info, int type)
+		struct fsnotify_iter_info *iter_info, int iter_type)
 {
-	return (iter_info->report_mask & (1U << type));
+	return (iter_info->report_mask & (1U << iter_type));
 }
 
 static inline void fsnotify_iter_set_report_type(
-		struct fsnotify_iter_info *iter_info, int type)
+		struct fsnotify_iter_info *iter_info, int iter_type)
 {
-	iter_info->report_mask |= (1U << type);
+	iter_info->report_mask |= (1U << iter_type);
 }
 
 static inline void fsnotify_iter_set_report_type_mark(
-		struct fsnotify_iter_info *iter_info, int type,
+		struct fsnotify_iter_info *iter_info, int iter_type,
 		struct fsnotify_mark *mark)
 {
-	iter_info->marks[type] = mark;
-	iter_info->report_mask |= (1U << type);
+	iter_info->marks[iter_type] = mark;
+	iter_info->report_mask |= (1U << iter_type);
 }
 
 #define FSNOTIFY_ITER_FUNCS(name, NAME) \
 static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 		struct fsnotify_iter_info *iter_info) \
 { \
-	return (iter_info->report_mask & (1U << FSNOTIFY_OBJ_TYPE_##NAME)) ? \
-		iter_info->marks[FSNOTIFY_OBJ_TYPE_##NAME] : NULL; \
+	return (iter_info->report_mask & (1U << FSNOTIFY_ITER_TYPE_##NAME)) ? \
+		iter_info->marks[FSNOTIFY_ITER_TYPE_##NAME] : NULL; \
 }
 
 FSNOTIFY_ITER_FUNCS(inode, INODE)
@@ -391,8 +406,8 @@ FSNOTIFY_ITER_FUNCS(parent, PARENT)
 FSNOTIFY_ITER_FUNCS(vfsmount, VFSMOUNT)
 FSNOTIFY_ITER_FUNCS(sb, SB)
 
-#define fsnotify_foreach_obj_type(type) \
-	for (type = 0; type < FSNOTIFY_OBJ_TYPE_COUNT; type++)
+#define fsnotify_foreach_iter_type(type) \
+	for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++)
 
 /*
  * fsnotify_connp_t is what we embed in objects which connector can be attached
-- 
2.33.1

