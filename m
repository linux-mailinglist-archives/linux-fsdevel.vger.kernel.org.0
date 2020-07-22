Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3247C2298D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgGVM7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgGVM7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA55C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so1903306wmi.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V2oZQN2akVvLYSP+sJpUUnq/OiaARIQGx4WrZ4Cv6Zk=;
        b=TKwHJ8mta58irgRN2P+ewWVkiGtogDhdSUtTQ0x0mp87mivGIydmPj2xAKEAYagUM6
         H9YgkSl75fIcM77PqzROY0s4RywBCQOqt9qOJ9ZVK+jd4FubmP716O3rVKyvwRZdOP7J
         gSM7/f+Vbwk8IZobC25QZBn47gaMXZECCXK/erO1d49ZAIKsRVZs9efA/HZdNwHFI35E
         J1ZINs8jIMQmPEwajgPFI8vK2rGWqXi8NX5WxFpZNQ018LmVzXt29c/siswpNsk1IS5c
         YxExhQexWD8GqDDKOGWQ1872d5APd+cUCGXffy5uRyBT2XzTq7GeRow71zuWMlQXQ4QV
         xnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V2oZQN2akVvLYSP+sJpUUnq/OiaARIQGx4WrZ4Cv6Zk=;
        b=bhIcheP1Bwj/9K6ZTKhzPzTi5Jg5dxaXtszDhlMVKJcTBlofx4ExcHlZGYW2Vfzn26
         hhRzef4MoMmTvAmAh/qFWCDP1hg68spqtQ5REE6HgM28E4SsA0K+J8oVC1kQJ9ezjSm0
         muQchjO7rQbvdVSVejiltfROsb7e668sY5sjpvHPEAKH9EZzxBmRQi/rWuX+QuoYxB8i
         V0PYdo58NTnsvfDww9S8ukoukfY4TC6FB/ZikGJUCKDMJm4APdOmA0EIZRd31QiqI30g
         t398AFENMU207TDBHcECw61wHspHW1KMqUuOxbCtkOiP7R7WN6lDcuS48fkNyUxxhuOE
         E6lw==
X-Gm-Message-State: AOAM533m6IRU52lBWQttwLY8UK9qKIDAXeu3z9Q+xqtVOFZ2WZtBLuh4
        tbUwat0tGVQ5eo81ShudjUM=
X-Google-Smtp-Source: ABdhPJy1YKQvUb0M/a+RrJE7ERWTbgIsLhk91zMJTc+5yJmRZJ1QJldKiFSXT2/Ki0fVYIg2pocZLA==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr1737047wmk.136.1595422753213;
        Wed, 22 Jul 2020 05:59:13 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] fsnotify: create method handle_inode_event() in fsnotify_operations
Date:   Wed, 22 Jul 2020 15:58:48 +0300
Message-Id: <20200722125849.17418-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The method handle_event() grew a lot of complexity due to the design of
fanotify and merging of ignore masks.

Most backends do not care about this complex functionality, so we can hide
this complexity from them.

Introduce a method handle_inode_event() that serves those backends and
passes a single inode mark and less arguments.

This change converts all backends except fanotify and inotify to use the
simplified handle_inode_event() method.  In pricipal, inotify could have
also used the new method, but that would require passing more arguments
on the simple helper (data, data_type, cookie), so we leave it with the
handle_event() method.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c              | 12 +++-----
 fs/notify/dnotify/dnotify.c      | 38 +++++------------------
 fs/notify/fsnotify.c             | 52 ++++++++++++++++++++++++++++++--
 include/linux/fsnotify_backend.h | 19 ++++++++++--
 kernel/audit_fsnotify.c          | 20 +++++-------
 kernel/audit_tree.c              | 10 +++---
 kernel/audit_watch.c             | 17 +++++------
 7 files changed, 97 insertions(+), 71 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index bbc7892d2928..c8b9d2667ee6 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -598,14 +598,10 @@ static struct notifier_block nfsd_file_lease_notifier = {
 };
 
 static int
-nfsd_file_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
-				const void *data, int data_type,
-				struct inode *dir,
-				const struct qstr *file_name, u32 cookie,
-				struct fsnotify_iter_info *iter_info)
+nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
+				struct inode *inode, struct inode *dir,
+				const struct qstr *name)
 {
-	struct inode *inode = fsnotify_data_inode(data, data_type);
-
 	trace_nfsd_file_fsnotify_handle_event(inode, mask);
 
 	/* Should be no marks on non-regular files */
@@ -626,7 +622,7 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 
 static const struct fsnotify_ops nfsd_file_fsnotify_ops = {
-	.handle_event = nfsd_file_fsnotify_handle_event,
+	.handle_inode_event = nfsd_file_fsnotify_handle_event,
 	.free_mark = nfsd_file_mark_free,
 };
 
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index ca78d3f78da8..5dcda8f20c04 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -70,8 +70,9 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
  * destroy the dnotify struct if it was not registered to receive multiple
  * events.
  */
-static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
-			      struct fsnotify_mark *inode_mark)
+static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
+				struct inode *inode, struct inode *dir,
+				const struct qstr *name)
 {
 	struct dnotify_mark *dn_mark;
 	struct dnotify_struct *dn;
@@ -79,6 +80,10 @@ static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
 	struct fown_struct *fown;
 	__u32 test_mask = mask & ~FS_EVENT_ON_CHILD;
 
+	/* not a dir, dnotify doesn't care */
+	if (!dir && !(mask & FS_ISDIR))
+		return 0;
+
 	dn_mark = container_of(inode_mark, struct dnotify_mark, fsn_mark);
 
 	spin_lock(&inode_mark->lock);
@@ -100,33 +105,6 @@ static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	spin_unlock(&inode_mark->lock);
-}
-
-static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
-				const void *data, int data_type,
-				struct inode *dir,
-				const struct qstr *file_name, u32 cookie,
-				struct fsnotify_iter_info *iter_info)
-{
-	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
-	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
-
-	/* not a dir, dnotify doesn't care */
-	if (!dir && !(mask & FS_ISDIR))
-		return 0;
-
-	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
-		return 0;
-
-	/*
-	 * Some events can be sent on both parent dir and subdir marks
-	 * (e.g. DN_ATTRIB).  If both parent dir and subdir are watching,
-	 * report the event once to parent dir and once to subdir.
-	 */
-	if (inode_mark)
-		dnotify_one_event(group, mask, inode_mark);
-	if (child_mark)
-		dnotify_one_event(group, mask, child_mark);
 
 	return 0;
 }
@@ -143,7 +121,7 @@ static void dnotify_free_mark(struct fsnotify_mark *fsn_mark)
 }
 
 static const struct fsnotify_ops dnotify_fsnotify_ops = {
-	.handle_event = dnotify_handle_event,
+	.handle_inode_event = dnotify_handle_event,
 	.free_mark = dnotify_free_mark,
 };
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 494d5d70323f..a960ec3a569a 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -230,6 +230,49 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
+static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
+				 const void *data, int data_type,
+				 struct inode *dir, const struct qstr *name,
+				 u32 cookie, struct fsnotify_iter_info *iter_info)
+{
+	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
+	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
+	struct inode *inode = fsnotify_data_inode(data, data_type);
+	const struct fsnotify_ops *ops = group->ops;
+	int ret;
+
+	if (WARN_ON_ONCE(!ops->handle_inode_event))
+		return 0;
+
+	if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
+	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
+		return 0;
+
+	/*
+	 * An event can be sent on child mark iterator instead of inode mark
+	 * iterator because of other groups that have interest of this inode
+	 * and have marks on both parent and child.  We can simplify this case.
+	 */
+	if (!inode_mark) {
+		inode_mark = child_mark;
+		child_mark = NULL;
+		dir = NULL;
+		name = NULL;
+	}
+
+	ret = ops->handle_inode_event(inode_mark, mask, inode, dir, name);
+	if (ret || !child_mark)
+		return ret;
+
+	/*
+	 * Some events can be sent on both parent dir and child marks
+	 * (e.g. FS_ATTRIB).  If both parent dir and child are watching,
+	 * report the event once to parent dir with name and once to child
+	 * without name.
+	 */
+	return ops->handle_inode_event(child_mark, mask, inode, NULL, NULL);
+}
+
 static int send_to_group(__u32 mask, const void *data, int data_type,
 			 struct inode *dir, const struct qstr *file_name,
 			 u32 cookie, struct fsnotify_iter_info *iter_info)
@@ -275,8 +318,13 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	if (!(test_mask & marks_mask & ~marks_ignored_mask))
 		return 0;
 
-	return group->ops->handle_event(group, mask, data, data_type, dir,
-					file_name, cookie, iter_info);
+	if (group->ops->handle_event) {
+		return group->ops->handle_event(group, mask, data, data_type, dir,
+						file_name, cookie, iter_info);
+	}
+
+	return fsnotify_handle_event(group, mask, data, data_type, dir,
+				     file_name, cookie, iter_info);
 }
 
 static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 32104cfc27a5..f8529a3a2923 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -128,17 +128,30 @@ struct mem_cgroup;
  * @cookie:	inotify rename cookie
  * @iter_info:	array of marks from this group that are interested in the event
  *
+ * handle_inode_event - simple variant of handle_event() for groups that only
+ *		have inode marks and don't have ignore mask
+ * @mark:	mark to notify
+ * @mask:	event type and flags
+ * @inode:	inode that event happened on
+ * @dir:	optional directory associated with event -
+ *		if @file_name is not NULL, this is the directory that
+ *		@file_name is relative to.
+ * @file_name:	optional file name associated with event
+ *
  * free_group_priv - called when a group refcnt hits 0 to clean up the private union
  * freeing_mark - called when a mark is being destroyed for some reason.  The group
- * 		MUST be holding a reference on each mark and that reference must be
- * 		dropped in this function.  inotify uses this function to send
- * 		userspace messages that marks have been removed.
+ *		MUST be holding a reference on each mark and that reference must be
+ *		dropped in this function.  inotify uses this function to send
+ *		userspace messages that marks have been removed.
  */
 struct fsnotify_ops {
 	int (*handle_event)(struct fsnotify_group *group, u32 mask,
 			    const void *data, int data_type, struct inode *dir,
 			    const struct qstr *file_name, u32 cookie,
 			    struct fsnotify_iter_info *iter_info);
+	int (*handle_inode_event)(struct fsnotify_mark *mark, u32 mask,
+			    struct inode *inode, struct inode *dir,
+			    const struct qstr *file_name);
 	void (*free_group_priv)(struct fsnotify_group *group);
 	void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
 	void (*free_event)(struct fsnotify_event *event);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index bd3a6b79316a..bfcfcd61adb6 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -152,35 +152,31 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
 }
 
 /* Update mark data in audit rules based on fsnotify events. */
-static int audit_mark_handle_event(struct fsnotify_group *group, u32 mask,
-				   const void *data, int data_type,
-				   struct inode *dir,
-				   const struct qstr *dname, u32 cookie,
-				   struct fsnotify_iter_info *iter_info)
+static int audit_mark_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
+				   struct inode *inode, struct inode *dir,
+				   const struct qstr *dname)
 {
-	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct audit_fsnotify_mark *audit_mark;
-	const struct inode *inode = fsnotify_data_inode(data, data_type);
 
 	audit_mark = container_of(inode_mark, struct audit_fsnotify_mark, mark);
 
-	BUG_ON(group != audit_fsnotify_group);
-
-	if (WARN_ON(!inode))
+	if (WARN_ON_ONCE(inode_mark->group != audit_fsnotify_group) ||
+	    WARN_ON_ONCE(!inode))
 		return 0;
 
 	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
 		if (audit_compare_dname_path(dname, audit_mark->path, AUDIT_NAME_FULL))
 			return 0;
 		audit_update_mark(audit_mark, inode);
-	} else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
+	} else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF)) {
 		audit_autoremove_mark_rule(audit_mark);
+	}
 
 	return 0;
 }
 
 static const struct fsnotify_ops audit_mark_fsnotify_ops = {
-	.handle_event =	audit_mark_handle_event,
+	.handle_inode_event = audit_mark_handle_event,
 	.free_mark = audit_fsnotify_free_mark,
 };
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 2ce2ac1ce100..025d24abf15d 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -1037,11 +1037,9 @@ static void evict_chunk(struct audit_chunk *chunk)
 		audit_schedule_prune();
 }
 
-static int audit_tree_handle_event(struct fsnotify_group *group, u32 mask,
-				   const void *data, int data_type,
-				   struct inode *dir,
-				   const struct qstr *file_name, u32 cookie,
-				   struct fsnotify_iter_info *iter_info)
+static int audit_tree_handle_event(struct fsnotify_mark *mark, u32 mask,
+				   struct inode *inode, struct inode *dir,
+				   const struct qstr *file_name)
 {
 	return 0;
 }
@@ -1070,7 +1068,7 @@ static void audit_tree_freeing_mark(struct fsnotify_mark *mark,
 }
 
 static const struct fsnotify_ops audit_tree_ops = {
-	.handle_event = audit_tree_handle_event,
+	.handle_inode_event = audit_tree_handle_event,
 	.freeing_mark = audit_tree_freeing_mark,
 	.free_mark = audit_tree_destroy_watch,
 };
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index e23d54bcc587..246e5ba704c0 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -464,20 +464,17 @@ void audit_remove_watch_rule(struct audit_krule *krule)
 }
 
 /* Update watch data in audit rules based on fsnotify events. */
-static int audit_watch_handle_event(struct fsnotify_group *group, u32 mask,
-				    const void *data, int data_type,
-				    struct inode *dir,
-				    const struct qstr *dname, u32 cookie,
-				    struct fsnotify_iter_info *iter_info)
+static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
+				    struct inode *inode, struct inode *dir,
+				    const struct qstr *dname)
 {
-	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
-	const struct inode *inode = fsnotify_data_inode(data, data_type);
 	struct audit_parent *parent;
 
 	parent = container_of(inode_mark, struct audit_parent, mark);
 
-	BUG_ON(group != audit_watch_group);
-	WARN_ON(!inode);
+	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group) ||
+	    WARN_ON_ONCE(!inode))
+		return 0;
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
 		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
@@ -490,7 +487,7 @@ static int audit_watch_handle_event(struct fsnotify_group *group, u32 mask,
 }
 
 static const struct fsnotify_ops audit_watch_fsnotify_ops = {
-	.handle_event = 	audit_watch_handle_event,
+	.handle_inode_event =	audit_watch_handle_event,
 	.free_mark =		audit_watch_free_mark,
 };
 
-- 
2.17.1

