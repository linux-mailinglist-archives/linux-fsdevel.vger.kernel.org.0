Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82C74EA8C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiC2HvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiC2HvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB241E531D
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w21so18962652wra.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/F1Ew7dXYUqEaMuDBnlNJujrZTt52AYtu1m8MN13CU=;
        b=M63RkBdVrSG00tsmuRXpmEKn8ook/LNQOey4o04i9vTd2g6DI2z+FJCbFDYqRFG+f5
         BITpnyHRJrV02mX4LSm8nxYzCdEDPKfNiM2MPMAmYyakaIuhmAI0zNyVQE1Ui67ZdfoG
         CsICX2R6Lcvc3bztjiqPFlgV6l5gfcC2WSO8wXADn3ODWBOrzmfdJU12qqR/5HATmYJx
         2fz4u00/+c2WjRkLaGM13VwnwmJkAjtvR2eyVE8Hwq83g5yT9alt2JjoAX92Y91jOYPs
         VUXzOKCgWbi9u/aVBVph8UmqXS4VGvQh9iUm3kKFgV18aFbEgSJYKFwi+6P9X97HKGJf
         Etfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/F1Ew7dXYUqEaMuDBnlNJujrZTt52AYtu1m8MN13CU=;
        b=2m+o8kw+zzTAVunKtG6SpnUUHtqL17g9RExJI2gMeCfRjBfo2GZ9xZmOZaa+GAbOx8
         6FI1VgCOU2JY0q0/6YMS3O885OTAWmTk+dxJ1DfBa5IO1yG6XS7GK38Q4AZ7fHsLzqSS
         GiCB6y73qXy2dCpX5ADVzFfo6jNr/fNgTe3OYJATz4Z6HMzNq3SHPMeaCCK7G6Ln1oui
         UjpmILEuX10vDP8DL9nFHwP0VqN+N+ajUOmBPq9/fFHcUkqPaAzrxEsASxeyxCi6CICN
         yzZ3Tii1/8jWJNiKxGe8X9bTDrfrmGfE0zvwoFhwLd+KS3RrD82UOFnTIvlsJZA9qsee
         D5Bg==
X-Gm-Message-State: AOAM5335/LFd6/Y2jY5gD9jg5OUUxogspBH4YUdDuMm+C3uCUQd6nMAW
        XzKYaf1JIGkzvOkTaUNE+7Zn5O0yzk8=
X-Google-Smtp-Source: ABdhPJz1JmxhSCh5ThPSBth5Rpvb6KHg65pK5o34hvbJkhEO0vaoHFgUoNqf7vLqiU7yzKAzy1txVg==
X-Received: by 2002:a5d:64c4:0:b0:203:f468:c518 with SMTP id f4-20020a5d64c4000000b00203f468c518mr29964837wri.676.1648540158414;
        Tue, 29 Mar 2022 00:49:18 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:17 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/16] fsnotify: create helpers for group mark_mutex lock
Date:   Tue, 29 Mar 2022 10:48:54 +0300
Message-Id: <20220329074904.2980320-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
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

Create helpers to take and release the group mark_mutex lock.

Define a flag FSNOTIFY_GROUP_NOFS in fsnotify backend operations struct
that determines if the mark_mutex lock is fs reclaim safe or not.
If not safe, the nofs lock helpers should be used to take the lock and
disable direct fs reclaim.

In that case we annotate the mutex with different lockdep class to
express to lockdep that an allocation of mark of an fs reclaim safe group
may take the group lock of another "NOFS" group to evict inodes.

For now, converted only the callers in common code and no backend
defines the NOFS flag.  It is intended to be set by fanotify for
evictable marks support.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fdinfo.c               |  5 ++--
 fs/notify/group.c                | 11 ++++++++
 fs/notify/mark.c                 | 28 ++++++++++---------
 include/linux/fsnotify_backend.h | 48 ++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 3451708fd035..754a546d647d 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -27,14 +27,15 @@ static void show_fdinfo(struct seq_file *m, struct file *f,
 {
 	struct fsnotify_group *group = f->private_data;
 	struct fsnotify_mark *mark;
+	unsigned int nofs;
 
-	mutex_lock(&group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(group);
 	list_for_each_entry(mark, &group->marks_list, g_list) {
 		show(m, mark);
 		if (seq_has_overflowed(m))
 			break;
 	}
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_nofs_unlock(group, nofs);
 }
 
 #if defined(CONFIG_EXPORTFS)
diff --git a/fs/notify/group.c b/fs/notify/group.c
index b7d4d64f87c2..0f585febf3d7 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -114,6 +114,7 @@ EXPORT_SYMBOL_GPL(fsnotify_put_group);
 static struct fsnotify_group *__fsnotify_alloc_group(
 				const struct fsnotify_ops *ops, gfp_t gfp)
 {
+	static struct lock_class_key nofs_marks_lock;
 	struct fsnotify_group *group;
 
 	group = kzalloc(sizeof(struct fsnotify_group), gfp);
@@ -133,6 +134,16 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 	INIT_LIST_HEAD(&group->marks_list);
 
 	group->ops = ops;
+	/*
+	 * For most backends, eviction of inode with a mark is not expected,
+	 * because marks hold a refcount on the inode against eviction.
+	 *
+	 * Use a different lockdep class for groups that support evictable
+	 * inode marks, because with evictable marks, mark_mutex is NOT
+	 * fs-reclaim safe - the mutex is taken when evicting inodes.
+	 */
+	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
+		lockdep_set_class(&group->mark_mutex, &nofs_marks_lock);
 
 	return group;
 }
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 3faf47def7d8..94d53f9d2b5f 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -383,9 +383,7 @@ void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
  */
 void fsnotify_detach_mark(struct fsnotify_mark *mark)
 {
-	struct fsnotify_group *group = mark->group;
-
-	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
+	fsnotify_group_assert_locked(mark->group);
 	WARN_ON_ONCE(!srcu_read_lock_held(&fsnotify_mark_srcu) &&
 		     refcount_read(&mark->refcnt) < 1 +
 			!!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED));
@@ -437,9 +435,11 @@ void fsnotify_free_mark(struct fsnotify_mark *mark)
 void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 			   struct fsnotify_group *group)
 {
-	mutex_lock(&group->mark_mutex);
+	unsigned int nofs;
+
+	nofs = fsnotify_group_nofs_lock(group);
 	fsnotify_detach_mark(mark);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_nofs_unlock(group, nofs);
 	fsnotify_free_mark(mark);
 }
 EXPORT_SYMBOL_GPL(fsnotify_destroy_mark);
@@ -658,7 +658,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	struct fsnotify_group *group = mark->group;
 	int ret = 0;
 
-	BUG_ON(!mutex_is_locked(&group->mark_mutex));
+	fsnotify_group_assert_locked(group);
 
 	/*
 	 * LOCKING ORDER!!!!
@@ -697,10 +697,11 @@ int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
+	unsigned int nofs;
 
-	mutex_lock(&group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(group);
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_nofs_unlock(group, nofs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fsnotify_add_mark);
@@ -739,6 +740,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	struct fsnotify_mark *lmark, *mark;
 	LIST_HEAD(to_free);
 	struct list_head *head = &to_free;
+	unsigned int nofs;
 
 	/* Skip selection step if we want to clear all marks. */
 	if (obj_type == FSNOTIFY_OBJ_TYPE_ANY) {
@@ -754,24 +756,24 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 * move marks to free to to_free list in one go and then free marks in
 	 * to_free list one by one.
 	 */
-	mutex_lock(&group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(group);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
 		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
 	}
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_nofs_unlock(group, nofs);
 
 clear:
 	while (1) {
-		mutex_lock(&group->mark_mutex);
+		nofs = fsnotify_group_nofs_lock(group);
 		if (list_empty(head)) {
-			mutex_unlock(&group->mark_mutex);
+			fsnotify_group_nofs_unlock(group, nofs);
 			break;
 		}
 		mark = list_first_entry(head, struct fsnotify_mark, g_list);
 		fsnotify_get_mark(mark);
 		fsnotify_detach_mark(mark);
-		mutex_unlock(&group->mark_mutex);
+		fsnotify_group_nofs_unlock(group, nofs);
 		fsnotify_free_mark(mark);
 		fsnotify_put_mark(mark);
 	}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9e8b5b52b9de..083333ad451c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -20,6 +20,7 @@
 #include <linux/user_namespace.h>
 #include <linux/refcount.h>
 #include <linux/mempool.h>
+#include <linux/sched/mm.h>
 
 /*
  * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
@@ -152,6 +153,10 @@ struct mem_cgroup;
  *		userspace messages that marks have been removed.
  */
 struct fsnotify_ops {
+#define FSNOTIFY_GROUP_NOFS	0x01 /* group lock is not direct reclaim safe */
+#define FSNOTIFY_GROUP_FLAG(group, flag) \
+	((group)->ops->group_flags & FSNOTIFY_GROUP_ ## flag)
+	int group_flags;
 	int (*handle_event)(struct fsnotify_group *group, u32 mask,
 			    const void *data, int data_type, struct inode *dir,
 			    const struct qstr *file_name, u32 cookie,
@@ -250,6 +255,49 @@ struct fsnotify_group {
 	};
 };
 
+/*
+ * Use this from common code to prevent deadlock when reclaiming inodes with
+ * evictable marks of the same group that is allocating a new mark.
+ */
+static inline unsigned int fsnotify_group_nofs_lock(
+						struct fsnotify_group *group)
+{
+	unsigned int nofs = current->flags & PF_MEMALLOC_NOFS;
+
+	mutex_lock(&group->mark_mutex);
+	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
+		nofs = memalloc_nofs_save();
+	return nofs;
+}
+
+static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
+{
+	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
+	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
+		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
+}
+
+static inline void fsnotify_group_nofs_unlock(struct fsnotify_group *group,
+					      unsigned int nofs)
+{
+	memalloc_nofs_restore(nofs);
+	mutex_unlock(&group->mark_mutex);
+}
+
+/*
+ * Use this from common code that does not allocate memory or from backends
+ * who are known to be fs reclaim safe (i.e. no evictable inode marks).
+ */
+static inline void fsnotify_group_lock(struct fsnotify_group *group)
+{
+	mutex_lock(&group->mark_mutex);
+}
+
+static inline void fsnotify_group_unlock(struct fsnotify_group *group)
+{
+	mutex_unlock(&group->mark_mutex);
+}
+
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
-- 
2.25.1

