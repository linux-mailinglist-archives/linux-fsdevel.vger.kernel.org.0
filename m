Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813C23E055B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhHDQHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhHDQHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:07:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B1C0613D5;
        Wed,  4 Aug 2021 09:07:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A90831F4080F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 10/23] fsnotify: Allow events reported with an empty inode
Date:   Wed,  4 Aug 2021 12:05:59 -0400
Message-Id: <20210804160612.3575505-11-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some file system events (i.e. FS_ERROR) might not be associated with an
inode.  For these, it makes sense to associate them directly with the
super block of the file system they apply to.  This patch allows the
event to be reported directly against the super block instead of an
inode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/kernfs/file.c                 |  6 +++---
 fs/notify/fsnotify.c             | 14 +++++++++-----
 include/linux/fsnotify.h         |  8 +++++---
 include/linux/fsnotify_backend.h | 10 ++++++----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c75719312147..eaa0de3a6520 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -883,9 +883,9 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
-				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
-					 inode, FSNOTIFY_EVENT_INODE,
-					 p_inode, &name, inode, 0);
+				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD, inode,
+					 FSNOTIFY_EVENT_INODE, NULL, p_inode,
+					 &name, inode, 0);
 				iput(p_inode);
 			}
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 30d422b8c0fc..36045d5f9d41 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -229,7 +229,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	}
 
 notify:
-	ret = fsnotify(mask, data, data_type, p_inode, file_name, inode, 0);
+	ret = fsnotify(mask, data, data_type, NULL, p_inode, file_name,
+		       inode, 0);
 
 	if (file_name)
 		release_dentry_name_snapshot(&name);
@@ -459,12 +460,13 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
  *		if both are non-NULL event may be reported to both.
  * @cookie:	inotify rename cookie
  */
-int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
-	     const struct qstr *file_name, struct inode *inode, u32 cookie)
+int fsnotify(__u32 mask, const void *data, int data_type,
+	     struct super_block *sb, struct inode *dir,
+	     const struct qstr *file_name, struct inode *inode,
+	     u32 cookie)
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
-	struct super_block *sb;
 	struct mount *mnt = NULL;
 	struct inode *parent = NULL;
 	int ret = 0;
@@ -483,7 +485,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		 */
 		parent = dir;
 	}
-	sb = inode->i_sb;
+
+	if (!sb)
+		sb = inode->i_sb;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..39c9dbc46d36 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -30,7 +30,8 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
 				 struct inode *child,
 				 const struct qstr *name, u32 cookie)
 {
-	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
+	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, NULL, dir, name, NULL,
+		 cookie);
 }
 
 static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
@@ -44,7 +45,8 @@ static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	fsnotify(mask, inode, FSNOTIFY_EVENT_INODE, NULL, NULL, inode, 0);
+	fsnotify(mask, inode, FSNOTIFY_EVENT_INODE, NULL, NULL, NULL, inode,
+		 0);
 }
 
 /* Notify this dentry's parent about a child's events. */
@@ -68,7 +70,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 	return __fsnotify_parent(dentry, mask, data, data_type);
 
 notify_child:
-	return fsnotify(mask, data, data_type, NULL, NULL, inode, 0);
+	return fsnotify(mask, data, data_type, NULL, NULL, NULL, inode, 0);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 693fe4cb48cf..4a765edd3b2a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -423,8 +423,9 @@ struct fsnotify_mark {
 
 /* main fsnotify call to send events */
 extern int fsnotify(__u32 mask, const void *data, int data_type,
-		    struct inode *dir, const struct qstr *name,
-		    struct inode *inode, u32 cookie);
+		    struct super_block *sb, struct inode *dir,
+		    const struct qstr *name, struct inode *inode,
+		    u32 cookie);
 extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 			   int data_type);
 extern void __fsnotify_inode_delete(struct inode *inode);
@@ -618,8 +619,9 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
-			   struct inode *dir, const struct qstr *name,
-			   struct inode *inode, u32 cookie)
+			   struct super_block *sb, struct inode *dir,
+			   const struct qstr *name, struct inode *inode,
+			   u32 cookie)
 {
 	return 0;
 }
-- 
2.32.0

