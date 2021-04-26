Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFB36B930
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhDZSnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbhDZSnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF60C061756;
        Mon, 26 Apr 2021 11:42:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9BCA51F41E78
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 04/15] fsnotify: Wire up group information on event initialization
Date:   Mon, 26 Apr 2021 14:41:50 -0400
Message-Id: <20210426184201.4177978-5-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is used by following patches when deciding about which fields to
initialize.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c        | 2 +-
 fs/notify/fanotify/fanotify.h        | 5 +++--
 fs/notify/fanotify/fanotify_user.c   | 6 +++---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 fs/notify/inotify/inotify_user.c     | 2 +-
 include/linux/fsnotify_backend.h     | 3 ++-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1192c9953620..e3669d8a4a64 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -601,7 +601,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
 	 */
-	fanotify_init_event(event, (unsigned long)id, mask);
+	fanotify_init_event(group, event, (unsigned long)id, mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 896c819a1786..47299e3d6efd 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -144,10 +144,11 @@ struct fanotify_event {
 	struct pid *pid;
 };
 
-static inline void fanotify_init_event(struct fanotify_event *event,
+static inline void fanotify_init_event(struct fsnotify_group *group,
+				       struct fanotify_event *event,
 				       unsigned long id, u32 mask)
 {
-	fsnotify_init_event(&event->fse, id);
+	fsnotify_init_event(group, &event->fse, id);
 	event->mask = mask;
 	event->pid = NULL;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f50c4ab721e3..fe605359af88 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -911,7 +911,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 				 FSNOTIFY_OBJ_TYPE_INODE, mask, flags, fsid);
 }
 
-static struct fsnotify_event *fanotify_alloc_overflow_event(void)
+static struct fsnotify_event *fanotify_alloc_overflow_event(struct fsnotify_group *group)
 {
 	struct fanotify_event *oevent;
 
@@ -919,7 +919,7 @@ static struct fsnotify_event *fanotify_alloc_overflow_event(void)
 	if (!oevent)
 		return NULL;
 
-	fanotify_init_event(oevent, 0, FS_Q_OVERFLOW);
+	fanotify_init_event(group, oevent, 0, FS_Q_OVERFLOW);
 	oevent->type = FANOTIFY_EVENT_TYPE_OVERFLOW;
 
 	return &oevent->fse;
@@ -993,7 +993,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
-	group->overflow_event = fanotify_alloc_overflow_event();
+	group->overflow_event = fanotify_alloc_overflow_event(group);
 	if (unlikely(!group->overflow_event)) {
 		fd = -ENOMEM;
 		goto out_destroy_group;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 1901d799909b..c6eceb663ac3 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -107,7 +107,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		mask &= ~IN_ISDIR;
 
 	fsn_event = &event->fse;
-	fsnotify_init_event(fsn_event, 0);
+	fsnotify_init_event(group, fsn_event, 0);
 	event->mask = mask;
 	event->wd = i_mark->wd;
 	event->sync_cookie = cookie;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index f2687267bc15..fb9a62b988e5 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -642,7 +642,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 		return ERR_PTR(-ENOMEM);
 	}
 	group->overflow_event = &oevent->fse;
-	fsnotify_init_event(group->overflow_event, 0);
+	fsnotify_init_event(group, group->overflow_event, 0);
 	oevent->mask = FS_Q_OVERFLOW;
 	oevent->wd = -1;
 	oevent->sync_cookie = 0;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index ef4352563ede..190c6a402e98 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -579,7 +579,8 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
-static inline void fsnotify_init_event(struct fsnotify_event *event,
+static inline void fsnotify_init_event(struct fsnotify_group *group,
+				       struct fsnotify_event *event,
 				       unsigned long objectid)
 {
 	INIT_LIST_HEAD(&event->list);
-- 
2.31.0

