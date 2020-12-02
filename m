Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8432CBC81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbgLBMJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388630AbgLBMJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:09:19 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CCC061A51
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:25 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id qw4so3765719ejb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBfwF7f1z3lWQIK1kOHunMt4z+tzVG6uRhe6POr10HI=;
        b=IxChIr6CnTVNZrcMdCT4Swp0nqyI/+TlHeYkLnfuh6OFOsdAkvd/epN3RjEA8j6M03
         hE14t1L+c2fbEcLWn/fhYD7IRb43j/VywEc5GXghaIogZFbCNlrv6frnV4hAgCiADzYO
         0KWL7epuib/5pm5niWaYLT1KGizWIX6MB8rzm3qV8SwMHNEnomBhgvPK4Rsumj3UHca6
         e8f3n1X4s7vCTQfOr0dXI8luqNIUgpM0gujErdjAgjtoBXJMKnRu92KJsjiCTw4pOCyO
         q7ONAMIFsTQGbIwd4929b16Hx+r6SG7Brh3jPIOa2Qs55d24HympyVinOk3UOLYxl8Dx
         29Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBfwF7f1z3lWQIK1kOHunMt4z+tzVG6uRhe6POr10HI=;
        b=eqPMY8Lglq2rYcaXYe5LFSIbCkZJBWfqCJBIiv0SImTvGfkBAB7U/bexft4xhMXs5j
         w6exMnax9xIrxmvamfnRHJXwTW+WJefQmxXFoBtPRTP6kCITlWFoDNCQiV1liCRgT7v5
         6vzZmW+d8pWfNqdwCHGQW46vI/lJ1fmWlScWVJ6YHJ/5UywWFii7hMylhzi+ivYUeuUb
         x18Tyi2wRKiBQ3qHBk9Haw1iZVQ2Kxw/zaL80uzZv0nzJxiIvFsVGuXnOOdNbUUTquYR
         zLTS05i+73NpOvuayVdFXoU9kU3BXjZDpzHjokq2Et9qEXGx/U2rCEgzLWSTJ75/yO1v
         jEzw==
X-Gm-Message-State: AOAM531IlSllSexjRq9qi0HxcpNgvm8IZ19Ls3j5+eubWYteC+aTvjrK
        YCuOaegP6SdWFNJYr8w4mNA=
X-Google-Smtp-Source: ABdhPJyUNw1e6BzyAVzVRCd9UB+8xBe5Rzq8ypjY+72OL0TwNqtBZVnDIMvOQ8vBcEfnhLSk/oPFnw==
X-Received: by 2002:a17:906:b857:: with SMTP id ga23mr2059381ejb.122.1606910843884;
        Wed, 02 Dec 2020 04:07:23 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:23 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] fsnotify: separate mark iterator type from object type enum
Date:   Wed,  2 Dec 2020 14:07:11 +0200
Message-Id: <20201202120713.702387-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
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
 fs/notify/fsnotify.c             | 26 +++++++++++++-------
 fs/notify/mark.c                 |  4 ++--
 include/linux/fsnotify_backend.h | 41 ++++++++++++++++++++++----------
 4 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1192c9953620..8655a1e7c6a6 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -252,7 +252,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			return 0;
 	}
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		if (!fsnotify_iter_should_report_type(iter_info, type))
 			continue;
 		mark = iter_info->marks[type];
@@ -271,7 +271,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		 * If the event is on a child and this mark is on a parent not
 		 * watching children, don't send it!
 		 */
-		if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
+		if (type == FSNOTIFY_ITER_TYPE_PARENT &&
 		    !(mark->mask & FS_EVENT_ON_CHILD))
 			continue;
 
@@ -622,7 +622,7 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	int type;
 	__kernel_fsid_t fsid = {};
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		struct fsnotify_mark_connector *conn;
 
 		if (!fsnotify_iter_should_report_type(iter_info, type))
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0676ce4d3352..bae3f306ed79 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -321,7 +321,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 
 	/* clear ignored on inode modification */
 	if (mask & FS_MODIFY) {
-		fsnotify_foreach_obj_type(type) {
+		fsnotify_foreach_iter_type(type) {
 			if (!fsnotify_iter_should_report_type(iter_info, type))
 				continue;
 			mark = iter_info->marks[type];
@@ -331,7 +331,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 		}
 	}
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		if (!fsnotify_iter_should_report_type(iter_info, type))
 			continue;
 		mark = iter_info->marks[type];
@@ -396,7 +396,7 @@ static unsigned int fsnotify_iter_select_report_types(
 	int type;
 
 	/* Choose max prio group among groups of all queue heads */
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
 		if (mark &&
 		    fsnotify_compare_groups(max_prio_group, mark->group) > 0)
@@ -408,7 +408,7 @@ static unsigned int fsnotify_iter_select_report_types(
 
 	/* Set the report mask for marks from same group as max prio group */
 	iter_info->report_mask = 0;
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
 		if (mark &&
 		    fsnotify_compare_groups(max_prio_group, mark->group) == 0)
@@ -426,7 +426,7 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 {
 	int type;
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		if (fsnotify_iter_should_report_type(iter_info, type))
 			iter_info->marks[type] =
 				fsnotify_next_mark(iter_info->marks[type]);
@@ -511,18 +511,26 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
+	/*
+	 * Just in case some backend still assumes that iterator type means
+	 * object type. We can relax this in the future.
+	 */
+	BUILD_BUG_ON(FSNOTIFY_OBJ_TYPE_INODE != (int)FSNOTIFY_ITER_TYPE_INODE);
+	BUILD_BUG_ON(FSNOTIFY_OBJ_TYPE_VFSMOUNT != (int)FSNOTIFY_ITER_TYPE_VFSMOUNT);
+	BUILD_BUG_ON(FSNOTIFY_OBJ_TYPE_SB != (int)FSNOTIFY_ITER_TYPE_SB);
+
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
index 7792f5486d61..ffa682cb747b 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -329,7 +329,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 {
 	int type;
 
-	fsnotify_foreach_obj_type(type) {
+	fsnotify_foreach_iter_type(type) {
 		/* This can fail if mark is being removed */
 		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
 			__release(&fsnotify_mark_srcu);
@@ -358,7 +358,7 @@ void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
 	int type;
 
 	iter_info->srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
-	fsnotify_foreach_obj_type(type)
+	fsnotify_foreach_iter_type(type)
 		fsnotify_put_mark_wake(iter_info->marks[type]);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 72bc120a65bc..9d03f031a41b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -276,10 +276,25 @@ static inline const struct path *fsnotify_data_path(const void *data,
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
@@ -292,37 +307,37 @@ static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
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
@@ -330,8 +345,8 @@ FSNOTIFY_ITER_FUNCS(parent, PARENT)
 FSNOTIFY_ITER_FUNCS(vfsmount, VFSMOUNT)
 FSNOTIFY_ITER_FUNCS(sb, SB)
 
-#define fsnotify_foreach_obj_type(type) \
-	for (type = 0; type < FSNOTIFY_OBJ_TYPE_COUNT; type++)
+#define fsnotify_foreach_iter_type(type) \
+	for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++)
 
 /*
  * fsnotify_connp_t is what we embed in objects which connector can be attached
-- 
2.25.1

