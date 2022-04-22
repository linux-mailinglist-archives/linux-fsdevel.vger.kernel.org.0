Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429450B6C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447272AbiDVMIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447328AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43115677F
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d6so5057622ede.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/b4lS/w6C4scZsh91/4tW0LpgxIjN4MQZkywQnGOm4=;
        b=jNVmi6T9mbT+3lwpiZ0e4Kb++E2tYX3Gf9wP7tdTBn1DEhHvNgK8dra5L39lzxw3Dh
         bVpNh82xAcKL3Pb2gLvd9jnXRMNZEez8g1D6HbC+UGkiGn8BOG+QDByu/ij9TVq7xitl
         e2VG7G2bik2XbHT05jcsasYVKnCN5geEP1rHFH5Rp5LtGP7O84zHv9/QnRQJjJ+Lk4AU
         a+dfGyPoVoXMQuQj5qtow0SkdEj5dhN8EkR7K5YT5Twaetx2lMaaSfPfJKfrIj4kqyyO
         p3DvCet8eEkDpiA1MNePGUQZgEgVilp7xvb8RMqZVKE6C8U3hLBhAwA5BkPX2kuMUrK6
         YkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/b4lS/w6C4scZsh91/4tW0LpgxIjN4MQZkywQnGOm4=;
        b=weHo8STRlmC0s9JBDLN64CaGbIujNkRRvu2gUHXKpK711s8o/CD33aekgA6Y7ehkNu
         GhgCQtulrBkO8GfMUVG1/iWpQHOb9DUYDyyXUT/HSCF2H1y37iDhA+FemYL97NK3kxnY
         7PyBkClyGXF2r04eYmunKkjg3VMFSxRM7JCQqGQ5PZJGKQBrY/8KAyFiUFq/Hkeii9j3
         5Ls3U4yG7hn4t8fG9bFMnVfGZBYuHiLHGnlViN2GCiVQ6BrTb1m40+K/5jrR2cVHjmRB
         B6OnJhd4wuZToE393YSuI8PA66BxsX4xqMutNjobt7Q4ZW8u2M08dcqwPybRz2fL9V+C
         m4ig==
X-Gm-Message-State: AOAM531hiQyZt+v4KOCkOV7b4aGwGLlJVlxZfbSCoENmhc3xeUJKK/CI
        n3ZJwq1GW2hk/LLOspVsj8M=
X-Google-Smtp-Source: ABdhPJzJgtEBN39wXhAQGs8lhGAgRc+WiWnEQgCE9sPOhi0hvbqP5wCuCCacsXLbfOxiJNqWg0q0XA==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr4489132edz.164.1650629023077;
        Fri, 22 Apr 2022 05:03:43 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 06/16] fsnotify: create helpers for group mark_mutex lock
Date:   Fri, 22 Apr 2022 15:03:17 +0300
Message-Id: <20220422120327.3459282-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 18446b7b0d49..1de6631a3925 100644
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
+	if (flags & FSNOTIFY_GROUP_NOFS)
+		lockdep_set_class(&group->mark_mutex, &nofs_marks_lock);
 
 	return group;
 }
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 1fb246ea6175..982ca2f20ff5 100644
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
@@ -714,9 +712,9 @@ int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, add_flags, fsid);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fsnotify_add_mark);
@@ -770,24 +768,24 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
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
index dd440e6ff528..d62111e83244 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -20,6 +20,7 @@
 #include <linux/user_namespace.h>
 #include <linux/refcount.h>
 #include <linux/mempool.h>
+#include <linux/sched/mm.h>
 
 /*
  * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
@@ -212,7 +213,9 @@ struct fsnotify_group {
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
+#define FSNOTIFY_GROUP_NOFS	0x04 /* group lock is not direct reclaim safe */
 	int flags;
+	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
 	struct mutex mark_mutex;	/* protect marks_list */
@@ -254,6 +257,31 @@ struct fsnotify_group {
 	};
 };
 
+/*
+ * These helpers are used to prevent deadlock when reclaiming inodes with
+ * evictable marks of the same group that is allocating a new mark.
+ */
+static inline void fsnotify_group_lock(struct fsnotify_group *group)
+{
+	mutex_lock(&group->mark_mutex);
+	if (group->flags & FSNOTIFY_GROUP_NOFS)
+		group->owner_flags = memalloc_nofs_save();
+}
+
+static inline void fsnotify_group_unlock(struct fsnotify_group *group)
+{
+	if (group->flags & FSNOTIFY_GROUP_NOFS)
+		memalloc_nofs_restore(group->owner_flags);
+	mutex_unlock(&group->mark_mutex);
+}
+
+static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
+{
+	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
+	if (group->flags & FSNOTIFY_GROUP_NOFS)
+		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
+}
+
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
-- 
2.35.1

