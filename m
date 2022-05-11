Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72262523CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346554AbiEKTCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbiEKTCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 15:02:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A883A612AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:02:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m1so4241166wrb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEJbm4gUtr69bpGsViBPKbM80G9gbG73CglGcuRj9ik=;
        b=hG7YsmYdRQSS9qd83Y4sL8FK6Rq7HyVrdH//SRrrTLLv1FoJ8sz6rskSnjoQmmy/jC
         U+5sdGTlnK5JrhyfrjJ5LO4ch8GxwKqRA64duDuy+c8G8pemogy5UZNbgokZ1rds0mP1
         fCvvcK0h7ha/PpjwvvuLa1L7eDMWnUaqcPmbE/xkFKHeTPImVR4q5vXO3r3ZtUMatzMo
         RLoY/z+GUbUxICGpvg2B62HvY8vM6snVoU0+jpgcSWDNjVl9kJvZF1YE0n1PR8awPNOk
         zzZVJ10wXk0XFBqaMZ6ZwtLo8tJph6binDhwwtbN2i5MUTjohSGNRddCzbBOiqer36I3
         nJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEJbm4gUtr69bpGsViBPKbM80G9gbG73CglGcuRj9ik=;
        b=63yY1F4098VewdL1TqgU+zhHc/k/s7w2rsFIuR0KWvjMUmgzEvjSm8QMrJqG2BsILO
         5Evqh1dEoV4KdIkiYQU58YGzL3oAeWINWRr6v56btdvwijw02dyQa9NtRgE5ZYnJLzo/
         EQr2d4gCnou2rXYAMSigbGSIX0YouXrcQ5k7Uj8tjqTbcalR5VqNaE7OTiTOK8yeNhiv
         EczardV7oGDx5ZSUHjCUL8YTCCJpa/fDbBmcYDt9SXwESAlxfWUGLDISzjoNFvqCY31O
         7kFX8YB65m5uapqNFSoRNKG8EWhwWvtQYzljZ4TCuLRjGZPQs/iCeqk9HvEVv/pA5+4a
         VHfw==
X-Gm-Message-State: AOAM5338CPIfGuzNFadk/pbsGHFV7mBN+SlyA46m2J6NAVecbSF3ysS9
        451MWoQnVWwItZYB90fzasYgz43qjWk=
X-Google-Smtp-Source: ABdhPJzWjs8TjvApPCGKDmfqyWfAFo3KNgzCxzx3FPTjZDjMBDxWTYRPmcAh1L6p05CuQTpRmSIUHA==
X-Received: by 2002:adf:e449:0:b0:20c:d56a:6020 with SMTP id t9-20020adfe449000000b0020cd56a6020mr8722714wrm.425.1652295739010;
        Wed, 11 May 2022 12:02:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([77.137.68.18])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003942a244eebsm435527wmj.48.2022.05.11.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:02:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fsnotify: introduce mark type iterator
Date:   Wed, 11 May 2022 22:02:12 +0300
Message-Id: <20220511190213.831646-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511190213.831646-1-amir73il@gmail.com>
References: <20220511190213.831646-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
of iterating all marks of a specific group interested in an event
by consulting the iterator report_mask.

Use an open coded version of that iterator in fsnotify_iter_next()
that collects all marks of the current iteration group without
consulting the iterator report_mask.

At the moment, the two iterator variants are the same, but this
decoupling will allow us to exclude some of the group's marks from
reporting the event, for example for event on child and inode marks
on parent did not request to watch events on children.

Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
Reported-by: Jan Kara <jack@suse.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 14 +++------
 fs/notify/fsnotify.c             | 53 ++++++++++++++++----------------
 include/linux/fsnotify_backend.h | 31 ++++++++++++++-----
 3 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 985e995d2a39..263d303d8f8f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -319,11 +319,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			return 0;
 	}
 
-	fsnotify_foreach_iter_type(type) {
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-		mark = iter_info->marks[type];
-
+	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		/* Apply ignore mask regardless of ISDIR and ON_CHILD flags */
 		marks_ignored_mask |= mark->ignored_mask;
 
@@ -849,16 +845,14 @@ static struct fanotify_event *fanotify_alloc_event(
  */
 static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 {
+	struct fsnotify_mark *mark;
 	int type;
 	__kernel_fsid_t fsid = {};
 
-	fsnotify_foreach_iter_type(type) {
+	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		struct fsnotify_mark_connector *conn;
 
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-
-		conn = READ_ONCE(iter_info->marks[type]->connector);
+		conn = READ_ONCE(mark->connector);
 		/* Mark is just getting destroyed or created? */
 		if (!conn)
 			continue;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 6eee19d15e8c..c5bb2405ead3 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -335,31 +335,23 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	struct fsnotify_mark *mark;
 	int type;
 
-	if (WARN_ON(!iter_info->report_mask))
+	if (!iter_info->report_mask)
 		return 0;
 
 	/* clear ignored on inode modification */
 	if (mask & FS_MODIFY) {
-		fsnotify_foreach_iter_type(type) {
-			if (!fsnotify_iter_should_report_type(iter_info, type))
-				continue;
-			mark = iter_info->marks[type];
-			if (mark &&
-			    !(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
+		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
+			if (!(mark->flags &
+			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
 				mark->ignored_mask = 0;
 		}
 	}
 
-	fsnotify_foreach_iter_type(type) {
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-		mark = iter_info->marks[type];
-		/* does the object mark tell us to do something? */
-		if (mark) {
-			group = mark->group;
-			marks_mask |= mark->mask;
-			marks_ignored_mask |= mark->ignored_mask;
-		}
+	/* Are any of the group marks interested in this event? */
+	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
+		group = mark->group;
+		marks_mask |= mark->mask;
+		marks_ignored_mask |= mark->ignored_mask;
 	}
 
 	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
@@ -403,11 +395,11 @@ static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
 
 /*
  * iter_info is a multi head priority queue of marks.
- * Pick a subset of marks from queue heads, all with the
- * same group and set the report_mask for selected subset.
- * Returns the report_mask of the selected subset.
+ * Pick a subset of marks from queue heads, all with the same group
+ * and set the report_mask to a subset of the selected marks.
+ * Returns false if there are no more groups to iterate.
  */
-static unsigned int fsnotify_iter_select_report_types(
+static bool fsnotify_iter_select_report_types(
 		struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_group *max_prio_group = NULL;
@@ -423,30 +415,37 @@ static unsigned int fsnotify_iter_select_report_types(
 	}
 
 	if (!max_prio_group)
-		return 0;
+		return false;
 
 	/* Set the report mask for marks from same group as max prio group */
+	iter_info->current_group = max_prio_group;
 	iter_info->report_mask = 0;
 	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
-		if (mark &&
-		    fsnotify_compare_groups(max_prio_group, mark->group) == 0)
+		if (mark && mark->group == iter_info->current_group)
 			fsnotify_iter_set_report_type(iter_info, type);
 	}
 
-	return iter_info->report_mask;
+	return true;
 }
 
 /*
- * Pop from iter_info multi head queue, the marks that were iterated in the
+ * Pop from iter_info multi head queue, the marks that belong to the group of
  * current iteration step.
  */
 static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 {
+	struct fsnotify_mark *mark;
 	int type;
 
+	/*
+	 * We cannot use fsnotify_foreach_iter_mark_type() here because we
+	 * may need to check if next group has a mark of type X even if current
+	 * group did not have a mark of type X.
+	 */
 	fsnotify_foreach_iter_type(type) {
-		if (fsnotify_iter_should_report_type(iter_info, type))
+		mark = iter_info->marks[type];
+		if (mark && mark->group == iter_info->current_group)
 			iter_info->marks[type] =
 				fsnotify_next_mark(iter_info->marks[type]);
 	}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9a1a9e78f69f..9560734759fa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -399,6 +399,7 @@ static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
 
 struct fsnotify_iter_info {
 	struct fsnotify_mark *marks[FSNOTIFY_ITER_TYPE_COUNT];
+	struct fsnotify_group *current_group;
 	unsigned int report_mask;
 	int srcu_idx;
 };
@@ -415,20 +416,31 @@ static inline void fsnotify_iter_set_report_type(
 	iter_info->report_mask |= (1U << iter_type);
 }
 
-static inline void fsnotify_iter_set_report_type_mark(
-		struct fsnotify_iter_info *iter_info, int iter_type,
-		struct fsnotify_mark *mark)
+static inline struct fsnotify_mark *fsnotify_iter_mark(
+		struct fsnotify_iter_info *iter_info, int iter_type)
 {
-	iter_info->marks[iter_type] = mark;
-	iter_info->report_mask |= (1U << iter_type);
+	if (fsnotify_iter_should_report_type(iter_info, iter_type))
+		return iter_info->marks[iter_type];
+	return NULL;
+}
+
+static inline int fsnotify_iter_step(struct fsnotify_iter_info *iter, int type,
+				     struct fsnotify_mark **markp)
+{
+	while (type < FSNOTIFY_ITER_TYPE_COUNT) {
+		*markp = fsnotify_iter_mark(iter, type);
+		if (*markp)
+			break;
+		type++;
+	}
+	return type;
 }
 
 #define FSNOTIFY_ITER_FUNCS(name, NAME) \
 static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 		struct fsnotify_iter_info *iter_info) \
 { \
-	return (iter_info->report_mask & (1U << FSNOTIFY_ITER_TYPE_##NAME)) ? \
-		iter_info->marks[FSNOTIFY_ITER_TYPE_##NAME] : NULL; \
+	return fsnotify_iter_mark(iter_info, FSNOTIFY_ITER_TYPE_##NAME); \
 }
 
 FSNOTIFY_ITER_FUNCS(inode, INODE)
@@ -438,6 +450,11 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
 
 #define fsnotify_foreach_iter_type(type) \
 	for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++)
+#define fsnotify_foreach_iter_mark_type(iter, mark, type) \
+	for (type = 0; \
+	     type = fsnotify_iter_step(iter, type, &mark), \
+	     type < FSNOTIFY_ITER_TYPE_COUNT; \
+	     type++)
 
 /*
  * fsnotify_connp_t is what we embed in objects which connector can be attached
-- 
2.25.1

