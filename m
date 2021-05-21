Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBD38BC87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhEUCnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:43:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUCng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:43:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 413EE1F43D57
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 04/11] fanotify: Expose fanotify_mark
Date:   Thu, 20 May 2021 22:41:27 -0400
Message-Id: <20210521024134.1032503-5-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
References: <20210521024134.1032503-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_ERROR will require an error structure to be stored per mark.
Therefore, wrap fsnotify_mark in a fanotify specific structure in
preparation for that.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c      |  4 +++-
 fs/notify/fanotify/fanotify.h      | 10 ++++++++++
 fs/notify/fanotify/fanotify_user.c | 14 +++++++-------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 711b36a9483e..34e2ee759b39 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -869,7 +869,9 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
 
 static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
 {
-	kmem_cache_free(fanotify_mark_cache, fsn_mark);
+	struct fanotify_mark *mark = FANOTIFY_MARK(fsn_mark);
+
+	kmem_cache_free(fanotify_mark_cache, mark);
 }
 
 const struct fsnotify_ops fanotify_fsnotify_ops = {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4a5e555dc3d2..a399c5e2615d 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -129,6 +129,16 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 	       name->name);
 }
 
+struct fanotify_mark {
+	struct fsnotify_mark fsn_mark;
+	struct fanotify_error_event *error_event;
+};
+
+static inline struct fanotify_mark *FANOTIFY_MARK(struct fsnotify_mark *mark)
+{
+	return container_of(mark, struct fanotify_mark, fsn_mark);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9cc6c8808ed5..00210535a78e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -914,7 +914,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
-	struct fsnotify_mark *mark;
+	struct fanotify_mark *mark;
 	int ret;
 
 	/*
@@ -926,20 +926,20 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
 
-	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	mark = kmem_cache_zalloc(fanotify_mark_cache, GFP_KERNEL);
 	if (!mark) {
 		ret = -ENOMEM;
 		goto out_dec_ucounts;
 	}
 
-	fsnotify_init_mark(mark, group);
-	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
+	fsnotify_init_mark(&mark->fsn_mark, group);
+	ret = fsnotify_add_mark_locked(&mark->fsn_mark, connp, type, 0, fsid);
 	if (ret) {
-		fsnotify_put_mark(mark);
+		fsnotify_put_mark(&mark->fsn_mark);
 		goto out_dec_ucounts;
 	}
 
-	return mark;
+	return &mark->fsn_mark;
 
 out_dec_ucounts:
 	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS))
@@ -1477,7 +1477,7 @@ static int __init fanotify_user_setup(void)
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
-	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
+	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
 	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
 					       SLAB_PANIC);
-- 
2.31.0

