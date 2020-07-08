Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFB2185B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgGHLMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67380C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so48494279wrm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6BLOVTFUs/XkZ6qUttQS+b8ADkcX5E4cpFoZFhr13Vo=;
        b=mOlmjRwxTbYBdKTbGevhj2hwFbO+cOpCu0cH5wPjH+ElCzuS9HZldHi38Z03oGP92T
         /CCFpPvV5GoRKMHtbaUu8HFTdKT4E6LzRFQpZ80FxHmgw7QjwLcAXQCGmFkzwJB3CA/v
         641xi/AEE9QRRJggriJWID/axjQjT2tWq/SD7n9L8xQ0K+iRfdl+HLpnDlSsRh6ZFWug
         Rk9Gothzl3F79En25osTKVlh1+9SNToZqFT+kOpY+TVpNEuSn7tzfm9Y1f2BY9aE72+M
         rgO6AASNDlhqKdFuvX5yEhAg4cBDCy4kkBcf/EExXSJZy1OQ39b/lHMnQJiHnlWV/39w
         XUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6BLOVTFUs/XkZ6qUttQS+b8ADkcX5E4cpFoZFhr13Vo=;
        b=bg4c3B6O4vlVSoVPtl8E/WGXx5g6s/At38O2m7H8zLxDa/QLsrDIY43fi3w/xNP53H
         /6n3eAtQ8M/Cq5nx5Iu5czRcjV/3fjP01ptLchcLUg9ibQ3UQMXj4XVXeX3wi8DKeSE1
         O1D7vh6nQtWWaliAst1jj3lEX/eGq4dRSarFzkAq9mjUWuzhG5t3c1PImwI5RWd9uJbZ
         HA9HcWomBGIUKRsxmYdtsvl4TmtMagJek9uExCq+aqKC5mUKSGqX9INKHc1YGI0XTMZO
         EIEaAxn+BWl6pMBznhc0V0C6ATgaALLa57g7AICm7TfoBIkPlYFX4oFdafoQQ2N9qPxm
         s+BA==
X-Gm-Message-State: AOAM5308W5FTqElJaPYWX293jSLhWpVLKHgsRkTJ77kX4/SI2WBw0R17
        /vOKx4/2l0gn/tczK/7m9JT0TVM+
X-Google-Smtp-Source: ABdhPJx9LgfFArpYjg8h7Gsm5VFX9EhU+qWLUFySLY763k0BRQemtgOKH8c96JeEW659894vhL8AGg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr58844314wrp.415.1594206738766;
        Wed, 08 Jul 2020 04:12:18 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/20] fsnotify: pass dir argument to handle_event() callback
Date:   Wed,  8 Jul 2020 14:11:44 +0300
Message-Id: <20200708111156.24659-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 'inode' argument to handle_event(), sometimes referred to as
'to_tell' is somewhat obsolete.
It is a remnant from the times when a group could only have an inode mark
associated with an event.

We now pass an iter_info array to the callback, with all marks associated
with an event.

Most backends ignore this argument, with two exceptions:
1. dnotify uses it for sanity check that event is on directory
2. fanotify uses it to report fid of directory on directory entry
   modification events

Remove the 'inode' argument and add a 'dir' argument.
The callback function signature is deliberately changed, because
the meaning of the argument has changed and the arguments have
been documented.

The 'dir' argument is NULL when "sending" to a non-dir inode.
When 'file_name' argument is non NULL, 'dir' is always referring to
the directory that the 'file_name' entry belongs to.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c                  |  6 +++---
 fs/notify/dnotify/dnotify.c          |  8 ++++----
 fs/notify/fanotify/fanotify.c        | 23 +++++++++++------------
 fs/notify/fsnotify.c                 | 26 ++++++++++++--------------
 fs/notify/inotify/inotify.h          |  6 +++---
 fs/notify/inotify/inotify_fsnotify.c |  7 +++----
 fs/notify/inotify/inotify_user.c     |  4 ++--
 include/linux/fsnotify_backend.h     | 18 +++++++++++++++---
 kernel/audit_fsnotify.c              | 10 +++++-----
 kernel/audit_tree.c                  |  6 +++---
 kernel/audit_watch.c                 |  6 +++---
 11 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ace8e5c30952..bbc7892d2928 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -598,9 +598,9 @@ static struct notifier_block nfsd_file_lease_notifier = {
 };
 
 static int
-nfsd_file_fsnotify_handle_event(struct fsnotify_group *group,
-				struct inode *to_tell,
-				u32 mask, const void *data, int data_type,
+nfsd_file_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
+				const void *data, int data_type,
+				struct inode *dir,
 				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info)
 {
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 7a42c2ebe28d..608c3e70e81f 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -70,9 +70,9 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
  * destroy the dnotify struct if it was not registered to receive multiple
  * events.
  */
-static int dnotify_handle_event(struct fsnotify_group *group,
-				struct inode *inode,
-				u32 mask, const void *data, int data_type,
+static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
+				const void *data, int data_type,
+				struct inode *dir,
 				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info)
 {
@@ -84,7 +84,7 @@ static int dnotify_handle_event(struct fsnotify_group *group,
 	__u32 test_mask = mask & ~FS_EVENT_ON_CHILD;
 
 	/* not a dir, dnotify doesn't care */
-	if (!S_ISDIR(inode->i_mode))
+	if (!dir)
 		return 0;
 
 	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c4ada3501014..e68a9fad98bd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -335,11 +335,11 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
  * FS_ATTRIB reports the child inode even if reported on a watched parent.
  * FS_CREATE reports the modified dir inode and not the created inode.
  */
-static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
-					const void *data, int data_type)
+static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
+					int data_type, struct inode *dir)
 {
 	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
-		return to_tell;
+		return dir;
 
 	return fsnotify_data_inode(data, data_type);
 }
@@ -416,14 +416,14 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 }
 
 static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
-						struct inode *inode, u32 mask,
-						const void *data, int data_type,
+						u32 mask, const void *data,
+						int data_type, struct inode *dir,
 						const struct qstr *file_name,
 						__kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
-	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
+	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 
 	/*
@@ -507,9 +507,9 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	return fsid;
 }
 
-static int fanotify_handle_event(struct fsnotify_group *group,
-				 struct inode *inode,
-				 u32 mask, const void *data, int data_type,
+static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
+				 const void *data, int data_type,
+				 struct inode *dir,
 				 const struct qstr *file_name, u32 cookie,
 				 struct fsnotify_iter_info *iter_info)
 {
@@ -546,8 +546,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	if (!mask)
 		return 0;
 
-	pr_debug("%s: group=%p inode=%p mask=%x\n", __func__, group, inode,
-		 mask);
+	pr_debug("%s: group=%p mask=%x\n", __func__, group, mask);
 
 	if (fanotify_is_perm_event(mask)) {
 		/*
@@ -565,7 +564,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 			return 0;
 	}
 
-	event = fanotify_alloc_event(group, inode, mask, data, data_type,
+	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 30628a72ca01..e05f3b2cf664 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -185,11 +185,9 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
-static int send_to_group(struct inode *to_tell,
-			 __u32 mask, const void *data,
-			 int data_is, u32 cookie,
-			 const struct qstr *file_name,
-			 struct fsnotify_iter_info *iter_info)
+static int send_to_group(__u32 mask, const void *data, int data_type,
+			 struct inode *dir, const struct qstr *file_name,
+			 u32 cookie, struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_group *group = NULL;
 	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
@@ -225,15 +223,14 @@ static int send_to_group(struct inode *to_tell,
 		}
 	}
 
-	pr_debug("%s: group=%p to_tell=%p mask=%x marks_mask=%x marks_ignored_mask=%x"
-		 " data=%p data_is=%d cookie=%d\n",
-		 __func__, group, to_tell, mask, marks_mask, marks_ignored_mask,
-		 data, data_is, cookie);
+	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
+		 __func__, group, mask, marks_mask, marks_ignored_mask,
+		 data, data_type, dir, cookie);
 
 	if (!(test_mask & marks_mask & ~marks_ignored_mask))
 		return 0;
 
-	return group->ops->handle_event(group, to_tell, mask, data, data_is,
+	return group->ops->handle_event(group, mask, data, data_type, dir,
 					file_name, cookie, iter_info);
 }
 
@@ -317,12 +314,13 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
  * out to all of the registered fsnotify_group.  Those groups can then use the
  * notification event in whatever means they feel necessary.
  */
-int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
+int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	     const struct qstr *file_name, u32 cookie)
 {
-	const struct path *path = fsnotify_data_path(data, data_is);
+	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
 	struct super_block *sb = to_tell->i_sb;
+	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
 	struct mount *mnt = NULL;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
@@ -375,8 +373,8 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	 * That's why this traversal is so complicated...
 	 */
 	while (fsnotify_iter_select_report_types(&iter_info)) {
-		ret = send_to_group(to_tell, mask, data, data_is, cookie,
-				    file_name, &iter_info);
+		ret = send_to_group(mask, data, data_type, dir, file_name,
+				    cookie, &iter_info);
 
 		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
 			goto out;
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 3f246f7b8a92..4327d0e9c364 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -24,9 +24,9 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
 
 extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 					   struct fsnotify_group *group);
-extern int inotify_handle_event(struct fsnotify_group *group,
-				struct inode *inode,
-				u32 mask, const void *data, int data_type,
+extern int inotify_handle_event(struct fsnotify_group *group, u32 mask,
+				const void *data, int data_type,
+				struct inode *dir,
 				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info);
 
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 9b481460a2dc..dfd455798a1b 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -55,9 +55,8 @@ static int inotify_merge(struct list_head *list,
 	return event_compare(last_event, event);
 }
 
-int inotify_handle_event(struct fsnotify_group *group,
-			 struct inode *inode,
-			 u32 mask, const void *data, int data_type,
+int inotify_handle_event(struct fsnotify_group *group, u32 mask,
+			 const void *data, int data_type, struct inode *dir,
 			 const struct qstr *file_name, u32 cookie,
 			 struct fsnotify_iter_info *iter_info)
 {
@@ -82,7 +81,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 		alloc_len += len + 1;
 	}
 
-	pr_debug("%s: group=%p inode=%p mask=%x\n", __func__, group, inode,
+	pr_debug("%s: group=%p mark=%p mask=%x\n", __func__, group, inode_mark,
 		 mask);
 
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index f88bbcc9efeb..5385d5817dd9 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -490,8 +490,8 @@ void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 					   fsn_mark);
 
 	/* Queue ignore event for the watch */
-	inotify_handle_event(group, NULL, FS_IN_IGNORED, NULL,
-			     FSNOTIFY_EVENT_NONE, NULL, 0, &iter_info);
+	inotify_handle_event(group, FS_IN_IGNORED, NULL, FSNOTIFY_EVENT_NONE,
+			     NULL, NULL, 0, &iter_info);
 
 	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
 	/* remove this mark from the idr */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 97300f3b8ff0..430d131d11c6 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -108,6 +108,19 @@ struct mem_cgroup;
  * these operations for each relevant group.
  *
  * handle_event - main call for a group to handle an fs event
+ * @group:	group to notify
+ * @mask:	event type and flags
+ * @data:	object that event happened on
+ * @data_type:	type of object for fanotify_data_XXX() accessors
+ * @dir:	optional directory associated with event -
+ *		if @file_name is not NULL, this is the directory that
+ *		@file_name is relative to. Otherwise, @dir is the object
+ *		inode if event happened on directory and NULL if event
+ *		happenned on a non-directory.
+ * @file_name:	optional file name associated with event
+ * @cookie:	inotify rename cookie
+ * @iter_info:	array of marks from this group that are interested in the event
+ *
  * free_group_priv - called when a group refcnt hits 0 to clean up the private union
  * freeing_mark - called when a mark is being destroyed for some reason.  The group
  * 		MUST be holding a reference on each mark and that reference must be
@@ -115,9 +128,8 @@ struct mem_cgroup;
  * 		userspace messages that marks have been removed.
  */
 struct fsnotify_ops {
-	int (*handle_event)(struct fsnotify_group *group,
-			    struct inode *inode,
-			    u32 mask, const void *data, int data_type,
+	int (*handle_event)(struct fsnotify_group *group, u32 mask,
+			    const void *data, int data_type, struct inode *dir,
 			    const struct qstr *file_name, u32 cookie,
 			    struct fsnotify_iter_info *iter_info);
 	void (*free_group_priv)(struct fsnotify_group *group);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 3596448bfdab..30ca239285a3 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -152,11 +152,11 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
 }
 
 /* Update mark data in audit rules based on fsnotify events. */
-static int audit_mark_handle_event(struct fsnotify_group *group,
-				    struct inode *to_tell,
-				    u32 mask, const void *data, int data_type,
-				    const struct qstr *dname, u32 cookie,
-				    struct fsnotify_iter_info *iter_info)
+static int audit_mark_handle_event(struct fsnotify_group *group, u32 mask,
+				   const void *data, int data_type,
+				   struct inode *dir,
+				   const struct qstr *dname, u32 cookie,
+				   struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct audit_fsnotify_mark *audit_mark;
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e49c912f862d..2ce2ac1ce100 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -1037,9 +1037,9 @@ static void evict_chunk(struct audit_chunk *chunk)
 		audit_schedule_prune();
 }
 
-static int audit_tree_handle_event(struct fsnotify_group *group,
-				   struct inode *to_tell,
-				   u32 mask, const void *data, int data_type,
+static int audit_tree_handle_event(struct fsnotify_group *group, u32 mask,
+				   const void *data, int data_type,
+				   struct inode *dir,
 				   const struct qstr *file_name, u32 cookie,
 				   struct fsnotify_iter_info *iter_info)
 {
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index e09c551ae52d..61fd601f1edf 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -464,9 +464,9 @@ void audit_remove_watch_rule(struct audit_krule *krule)
 }
 
 /* Update watch data in audit rules based on fsnotify events. */
-static int audit_watch_handle_event(struct fsnotify_group *group,
-				    struct inode *to_tell,
-				    u32 mask, const void *data, int data_type,
+static int audit_watch_handle_event(struct fsnotify_group *group, u32 mask,
+				    const void *data, int data_type,
+				    struct inode *dir,
 				    const struct qstr *dname, u32 cookie,
 				    struct fsnotify_iter_info *iter_info)
 {
-- 
2.17.1

