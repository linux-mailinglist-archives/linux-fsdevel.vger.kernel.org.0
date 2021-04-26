Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2196336B92E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbhDZSna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47418 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbhDZSnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D25BA1F41E1C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 03/15] fsnotify: Wire flags field on group allocation
Date:   Mon, 26 Apr 2021 14:41:49 -0400
Message-Id: <20210426184201.4177978-4-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a flags field in fsnotify_group to track the mode of
submission this group has.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/dnotify/dnotify.c        |  2 +-
 fs/notify/fanotify/fanotify_user.c |  4 ++--
 fs/notify/group.c                  | 13 ++++++++-----
 fs/notify/inotify/inotify_user.c   |  2 +-
 include/linux/fsnotify_backend.h   |  7 +++++--
 kernel/audit_fsnotify.c            |  2 +-
 kernel/audit_tree.c                |  2 +-
 kernel/audit_watch.c               |  2 +-
 8 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e85e13c50d6d..37960c8750e4 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -383,7 +383,7 @@ static int __init dnotify_init(void)
 					  SLAB_PANIC|SLAB_ACCOUNT);
 	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_ACCOUNT);
 
-	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
+	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
 	return 0;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e0d113e3b65c..f50c4ab721e3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -929,7 +929,7 @@ static struct fsnotify_event *fanotify_alloc_overflow_event(void)
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
 	struct fsnotify_group *group;
-	int f_flags, fd;
+	int f_flags, fd, fsn_flags = 0;
 	struct user_struct *user;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
@@ -982,7 +982,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		f_flags |= O_NONBLOCK;
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
-	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops, fsn_flags);
 	if (IS_ERR(group)) {
 		free_uid(user);
 		return PTR_ERR(group);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index ffd723ffe46d..08acb1afc0c2 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -112,7 +112,7 @@ void fsnotify_put_group(struct fsnotify_group *group)
 EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
 static struct fsnotify_group *__fsnotify_alloc_group(
-				const struct fsnotify_ops *ops, gfp_t gfp)
+	const struct fsnotify_ops *ops, unsigned int flags, gfp_t gfp)
 {
 	struct fsnotify_group *group;
 
@@ -134,6 +134,7 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 	INIT_LIST_HEAD(&group->marks_list);
 
 	group->ops = ops;
+	group->flags = flags;
 
 	return group;
 }
@@ -141,18 +142,20 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
  */
-struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
+struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
+					    unsigned int flags)
 {
-	return __fsnotify_alloc_group(ops, GFP_KERNEL);
+	return __fsnotify_alloc_group(ops, flags, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
  */
-struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
+struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops,
+						 unsigned int flags)
 {
-	return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
+	return __fsnotify_alloc_group(ops, flags, GFP_KERNEL_ACCOUNT);
 }
 EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c71be4fb7dc5..f2687267bc15 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -632,7 +632,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct fsnotify_group *group;
 	struct inotify_event_info *oevent;
 
-	group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(&inotify_fsnotify_ops, 0);
 	if (IS_ERR(group))
 		return group;
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index e5409b83e731..ef4352563ede 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -221,6 +221,7 @@ struct fsnotify_group {
 						 * full */
 
 	struct mem_cgroup *memcg;	/* memcg to charge allocations */
+	unsigned int flags;
 
 	/* groups can define private fields here or use the void *private */
 	union {
@@ -469,8 +470,10 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 /* called from fsnotify listeners, such as fanotify or dnotify */
 
 /* create a new group */
-extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
-extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops);
+extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
+						   unsigned int flags);
+extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops,
+							unsigned int flags);
 /* get reference to a group */
 extern void fsnotify_get_group(struct fsnotify_group *group);
 /* drop reference on a group from fsnotify_alloc_group */
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 60739d5e3373..dce6a6212f8f 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -182,7 +182,7 @@ static const struct fsnotify_ops audit_mark_fsnotify_ops = {
 
 static int __init audit_fsnotify_init(void)
 {
-	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops);
+	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops, 0);
 	if (IS_ERR(audit_fsnotify_group)) {
 		audit_fsnotify_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 6c91902f4f45..3d045fc791f2 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -1077,7 +1077,7 @@ static int __init audit_tree_init(void)
 
 	audit_tree_mark_cachep = KMEM_CACHE(audit_tree_mark, SLAB_PANIC);
 
-	audit_tree_group = fsnotify_alloc_group(&audit_tree_ops);
+	audit_tree_group = fsnotify_alloc_group(&audit_tree_ops, 0);
 	if (IS_ERR(audit_tree_group))
 		audit_panic("cannot initialize fsnotify group for rectree watches");
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 2acf7ca49154..80a8c14de961 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -493,7 +493,7 @@ static const struct fsnotify_ops audit_watch_fsnotify_ops = {
 
 static int __init audit_watch_init(void)
 {
-	audit_watch_group = fsnotify_alloc_group(&audit_watch_fsnotify_ops);
+	audit_watch_group = fsnotify_alloc_group(&audit_watch_fsnotify_ops, 0);
 	if (IS_ERR(audit_watch_group)) {
 		audit_watch_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
-- 
2.31.0

