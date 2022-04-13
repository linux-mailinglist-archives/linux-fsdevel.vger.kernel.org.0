Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8A4FF313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiDMJMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiDMJMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27551CFEE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e21so1639529wrc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1whyWEIXH2ivb44csyQcGxAj08ELh3kxzmcthXa6UQ=;
        b=BJPkIEzH081jNyjdpNxRltIBRVGDULvBD4baXDCVH6fNG6wd9Yo+a0HO231otplyfR
         qRH9ND5d871fOOH5DSRnZtLHRTEiK5svUttdCOaGnMnkK4TVf/e0h+jhnO2Ap7hIh4kE
         2JKk6pk+dSCNygYA6O8S9xwHVDrjdrcJ52GvB7R3OB3OOJZKeQ1rKcM3KRk8Y9MbLldG
         AQ9B6j/wzDlfJlJhV8NuVv4Y6bHlaPffogr/m9GBSeQaoOF2D9eOKPuofbYxK/Y77EgY
         qwaUCUhYOM/Rt9E/hST0LJcaPVyNopAp7vykyJLxLBoHG5Md5QWCkRSCovqYdwWDNgQL
         vvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1whyWEIXH2ivb44csyQcGxAj08ELh3kxzmcthXa6UQ=;
        b=6M4hKhxBQQ9wMQ6BpRPM/JR3gQ/38hw7KdzvjNrsbbsSItBe7LuqXAoHRppGPKyZqc
         bcZqMyMWOn9pPYC8xViFC0Z++cKEz1cx5fm39+dlG8PGDc/D8LmEJJQ7IJWUeWVx1acE
         HrFm+vytevsf5ou3W9YtG6kbTcTN78Zi6Gq1GBq+B1/b3+vUFzEozMi5eWayV9krkbMS
         CwcN4yXT0iKQsKxP9QdBTc9CoSEZS+vqwwsnpApHL+hOeE1/GxOfTvWKZSsqiDHlIRRq
         LLd3r9uD+6/++gCRuwCd2TKubf7h5cGmRXrwe4VCaOyGBzA6+Ye9YV6SMlvinDnLjdOL
         W8Xw==
X-Gm-Message-State: AOAM533t7La4c5wQMGFw5MwzVj/mPJy3DVBAACf9Pmw7ZwOKW8hvlZI2
        Me8ul1Cax+SUCuBRGHgDFCSHVN6W0vM=
X-Google-Smtp-Source: ABdhPJxFXPfKfr0f7/HhpWBwBRxT6SCVqUGZKoCaW8EHwt0QtCL3hogcngXS6fPdjVbUvTRNef7+RQ==
X-Received: by 2002:adf:eb89:0:b0:1e4:b8f4:da74 with SMTP id t9-20020adfeb89000000b001e4b8f4da74mr32694744wrn.408.1649840986471;
        Wed, 13 Apr 2022 02:09:46 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/16] fsnotify: create helpers for group mark_mutex lock
Date:   Wed, 13 Apr 2022 12:09:25 +0300
Message-Id: <20220413090935.3127107-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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

Define a flag FSNOTIFY_GROUP_NOFS in fsnotify_group that determines
if the mark_mutex lock is fs reclaim safe or not.  If not safe, the
lock helpers take the lock and disable direct fs reclaim.

In that case we annotate the mutex with a different lockdep class to
express to lockdep that an allocation of mark of an fs reclaim safe group
may take the group lock of another "NOFS" group to evict inodes.

For now, converted only the callers in common code and no backend
defines the NOFS flag.  It is intended to be set by fanotify for
evictable marks support.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fdinfo.c               |  4 ++--
 fs/notify/group.c                | 11 +++++++++++
 fs/notify/mark.c                 | 24 +++++++++++-------------
 include/linux/fsnotify_backend.h | 28 ++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 3451708fd035..1f34c5c29fdb 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -28,13 +28,13 @@ static void show_fdinfo(struct seq_file *m, struct file *f,
 	struct fsnotify_group *group = f->private_data;
 	struct fsnotify_mark *mark;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	list_for_each_entry(mark, &group->marks_list, g_list) {
 		show(m, mark);
 		if (seq_has_overflowed(m))
 			break;
 	}
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 }
 
 #if defined(CONFIG_EXPORTFS)
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 18446b7b0d49..3664029af5ae 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -115,6 +115,7 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 				const struct fsnotify_ops *ops,
 				int flags, gfp_t gfp)
 {
+	static struct lock_class_key nofs_marks_lock;
 	struct fsnotify_group *group;
 
 	group = kzalloc(sizeof(struct fsnotify_group), gfp);
@@ -135,6 +136,16 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 
 	group->ops = ops;
 	group->flags = flags;
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
index ea8f557881b1..7120918d8251 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -398,9 +398,7 @@ void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
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
@@ -452,9 +450,9 @@ void fsnotify_free_mark(struct fsnotify_mark *mark)
 void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 			   struct fsnotify_group *group)
 {
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	fsnotify_detach_mark(mark);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 	fsnotify_free_mark(mark);
 }
 EXPORT_SYMBOL_GPL(fsnotify_destroy_mark);
@@ -673,7 +671,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	struct fsnotify_group *group = mark->group;
 	int ret = 0;
 
-	BUG_ON(!mutex_is_locked(&group->mark_mutex));
+	fsnotify_group_assert_locked(group);
 
 	/*
 	 * LOCKING ORDER!!!!
@@ -713,9 +711,9 @@ int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fsnotify_add_mark);
@@ -769,24 +767,24 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 * move marks to free to to_free list in one go and then free marks in
 	 * to_free list one by one.
 	 */
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
 		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
 	}
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 
 clear:
 	while (1) {
-		mutex_lock(&group->mark_mutex);
+		fsnotify_group_lock(group);
 		if (list_empty(head)) {
-			mutex_unlock(&group->mark_mutex);
+			fsnotify_group_unlock(group);
 			break;
 		}
 		mark = list_first_entry(head, struct fsnotify_mark, g_list);
 		fsnotify_get_mark(mark);
 		fsnotify_detach_mark(mark);
-		mutex_unlock(&group->mark_mutex);
+		fsnotify_group_unlock(group);
 		fsnotify_free_mark(mark);
 		fsnotify_put_mark(mark);
 	}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 2057ae4bf8e9..fc6fdbaac797 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -20,6 +20,7 @@
 #include <linux/user_namespace.h>
 #include <linux/refcount.h>
 #include <linux/mempool.h>
+#include <linux/sched/mm.h>
 
 /*
  * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
@@ -211,9 +212,11 @@ struct fsnotify_group {
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
+#define FSNOTIFY_GROUP_NOFS	0x02 /* group lock is not direct reclaim safe */
 #define FSNOTIFY_GROUP_FLAG(group, flag) \
 	((group)->flags & FSNOTIFY_GROUP_ ## flag)
 	int flags;
+	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
 	struct mutex mark_mutex;	/* protect marks_list */
@@ -255,6 +258,31 @@ struct fsnotify_group {
 	};
 };
 
+/*
+ * These helpers are used to prevent deadlock when reclaiming inodes with
+ * evictable marks of the same group that is allocating a new mark.
+ */
+static inline void fsnotify_group_lock(struct fsnotify_group *group)
+{
+	mutex_lock(&group->mark_mutex);
+	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
+		group->owner_flags = memalloc_nofs_save();
+}
+
+static inline void fsnotify_group_unlock(struct fsnotify_group *group)
+{
+	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
+		memalloc_nofs_restore(group->owner_flags);
+	mutex_unlock(&group->mark_mutex);
+}
+
+static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
+{
+	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
+	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
+		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
+}
+
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
-- 
2.35.1

