Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1082298CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgGVM7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbgGVM7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D9C0619DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so1849108wmh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U4hE0z0mT1JIFl7L7587W+MGDvyQ1LjWWxTwG/xOIbU=;
        b=BR8i3I/IssWovvDF9+6355Ta/WFj7W1v7Ju3XyZnQSmXuCZLGmBg+9xNGmVsrIWVyh
         yXFJkvCXZOJGTUGUkJfiR9XZFFvypuU0zwwUt+YVfoFXFFbUTEoYJ7IaBK0bjIehU1kq
         hWQEnpnGSIO7mIjlr4Tevk4VuAw7esZPaZetj4geD+AleYqRF5M+ULNJ5uuh1Oc3pULK
         x72nQgRt36Nd0UhEiDuHvi28ANTd7SPsbYsggr8azkTpEKXxyWCzv6vLWfTWn8+u80QA
         SNyjFSWaMoQTcQkAABOUEHqufirVXjEa5xwDri/i+67CNbuFgo/ZNSZxvyJyK0sxlbp5
         YASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U4hE0z0mT1JIFl7L7587W+MGDvyQ1LjWWxTwG/xOIbU=;
        b=eLyZPeAN0hTjq94e7Humru5ZrqQh7hgiBzIon8iOESEJHE31tHv1smnB4JnG96WPr7
         rjhhLdRo+qz83uyQ9NdI+jdCEtsE0PhN12KBglTO1PzmutFcQiq4IEWl9kpe+GIu0x9o
         pdFCSBvRrJEIhDQUQWw7g5P/tv28e9xjWPqQRqa0onOGBr+K8O5N+djlNeUf5hubOpWv
         6FG4whPa3jViNzO1bzEQQ0cXcbmpQpNBnJc3aguqz30fltGH8IcAKqinUuE7n/hoh1Lt
         rwCfsqZnyr8Jle35H/11XeOTikZCqm805DSbl5O4aAJmShUJ2yPD/2ZlxIuZi5/5cn1N
         XRRA==
X-Gm-Message-State: AOAM530VcimO13gqOhX3GLUyPvWQF2VF+C2TzZGLZoYTbe5ZXUATQQB3
        hSLm/hwiUkiYddkoGhAGL5nHK0f2
X-Google-Smtp-Source: ABdhPJwTOcilqyCTjv38lnB4+bRB8pkCcJeoG2GgkEpf9cOhPRw2eCznPUYyuzcBpqcZRi2ekRQjkw==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr8332385wmj.105.1595422750561;
        Wed, 22 Jul 2020 05:59:10 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:10 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] fsnotify: pass dir and inode arguments to fsnotify()
Date:   Wed, 22 Jul 2020 15:58:46 +0300
Message-Id: <20200722125849.17418-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The arguments of fsnotify() are overloaded and mean different things
for different event types.

Replace the to_tell argument with separate arguments @dir and @inode,
because we may be sending to both dir and child.  Using the @data
argument to pass the child is not enough, because dirent events pass
this argument (for audit), but we do not report to child.

Document the new fsnotify() function argumenets.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/kernfs/file.c                 |  5 +--
 fs/notify/fsnotify.c             | 54 ++++++++++++++++++++++----------
 include/linux/fsnotify.h         |  9 +++---
 include/linux/fsnotify_backend.h | 10 +++---
 4 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 1d185bffc52f..f277d023ebcd 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -902,8 +902,9 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
-				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
-					 inode, FSNOTIFY_EVENT_INODE, &name, 0);
+				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
+					 inode, FSNOTIFY_EVENT_INODE,
+					 p_inode, &name, inode, 0);
 				iput(p_inode);
 			}
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 834775f61f6b..3b805e05c02d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -179,7 +179,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	struct dentry *parent;
 	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
 	__u32 p_mask;
-	struct inode *p_inode;
+	struct inode *p_inode = NULL;
 	struct name_snapshot name;
 	struct qstr *file_name = NULL;
 	int ret = 0;
@@ -213,14 +213,13 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
 
 		/* Notify both parent and child with child name info */
-		inode = p_inode;
 		take_dentry_name_snapshot(&name, dentry);
 		file_name = &name.name;
 		mask |= FS_EVENT_ON_CHILD;
 	}
 
 notify:
-	ret = fsnotify(inode, mask, data, data_type, file_name, 0);
+	ret = fsnotify(mask, data, data_type, p_inode, file_name, inode, 0);
 
 	if (file_name)
 		release_dentry_name_snapshot(&name);
@@ -354,18 +353,31 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 }
 
 /*
- * This is the main call to fsnotify.  The VFS calls into hook specific functions
- * in linux/fsnotify.h.  Those functions then in turn call here.  Here will call
- * out to all of the registered fsnotify_group.  Those groups can then use the
- * notification event in whatever means they feel necessary.
+ * fsnotify - This is the main call to fsnotify.
+ *
+ * The VFS calls into hook specific functions in linux/fsnotify.h.
+ * Those functions then in turn call here.  Here will call out to all of the
+ * registered fsnotify_group.  Those groups can then use the notification event
+ * in whatever means they feel necessary.
+ *
+ * @mask:	event type and flags
+ * @data:	object that event happened on
+ * @data_type:	type of object for fanotify_data_XXX() accessors
+ * @dir:	optional directory associated with event -
+ *		if @file_name is not NULL, this is the directory that
+ *		@file_name is relative to
+ * @file_name:	optional file name associated with event
+ * @inode:	optional inode associated with event -
+ *		either @dir or @inode must be non-NULL.
+ *		if both are non-NULL event may be reported to both.
+ * @cookie:	inotify rename cookie
  */
-int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
-	     const struct qstr *file_name, u32 cookie)
+int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
+	     const struct qstr *file_name, struct inode *inode, u32 cookie)
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
-	struct super_block *sb = to_tell->i_sb;
-	struct inode *dir = file_name ? to_tell : NULL;
+	struct super_block *sb;
 	struct mount *mnt = NULL;
 	struct inode *child = NULL;
 	int ret = 0;
@@ -374,8 +386,18 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	if (path)
 		mnt = real_mount(path->mnt);
 
-	if (mask & FS_EVENT_ON_CHILD)
-		child = fsnotify_data_inode(data, data_type);
+	if (!inode) {
+		/* Dirent event - report on TYPE_INODE to dir */
+		inode = dir;
+	} else if (mask & FS_EVENT_ON_CHILD) {
+		/*
+		 * Event on child - report on TYPE_INODE to dir
+		 * and on TYPE_CHILD to child.
+		 */
+		child = inode;
+		inode = dir;
+	}
+	sb = inode->i_sb;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
@@ -384,12 +406,12 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	 * SRCU because we have no references to any objects and do not
 	 * need SRCU to keep them "alive".
 	 */
-	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
+	if (!inode->i_fsnotify_marks && !sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!child || !child->i_fsnotify_marks))
 		return 0;
 
-	marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
+	marks_mask = inode->i_fsnotify_mask | sb->s_fsnotify_mask;
 	if (mnt)
 		marks_mask |= mnt->mnt_fsnotify_mask;
 	if (child)
@@ -407,7 +429,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
 	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
-		fsnotify_first_mark(&to_tell->i_fsnotify_marks);
+		fsnotify_first_mark(&inode->i_fsnotify_marks);
 	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
 		fsnotify_first_mark(&sb->s_fsnotify_marks);
 	if (mnt) {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 01b71ad91339..d9b26c6552ee 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -23,13 +23,14 @@
  * have changed (i.e. renamed over).
  *
  * Unlike fsnotify_parent(), the event will be reported regardless of the
- * FS_EVENT_ON_CHILD mask on the parent inode.
+ * FS_EVENT_ON_CHILD mask on the parent inode and will not be reported if only
+ * the child is interested and not the parent.
  */
 static inline void fsnotify_name(struct inode *dir, __u32 mask,
 				 struct inode *child,
 				 const struct qstr *name, u32 cookie)
 {
-	fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
+	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
 }
 
 static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
@@ -43,7 +44,7 @@ static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify(mask, inode, FSNOTIFY_EVENT_INODE, NULL, NULL, inode, 0);
 }
 
 /* Notify this dentry's parent about a child's events. */
@@ -67,7 +68,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 	return __fsnotify_parent(dentry, mask, data, data_type);
 
 notify_child:
-	return fsnotify(inode, mask, data, data_type, NULL, 0);
+	return fsnotify(mask, data, data_type, NULL, NULL, inode, 0);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d94a50e0445a..32104cfc27a5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -398,8 +398,9 @@ struct fsnotify_mark {
 /* called from the vfs helpers */
 
 /* main fsnotify call to send events */
-extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
-		    int data_type, const struct qstr *name, u32 cookie);
+extern int fsnotify(__u32 mask, const void *data, int data_type,
+		    struct inode *dir, const struct qstr *name,
+		    struct inode *inode, u32 cookie);
 extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 			   int data_type);
 extern void __fsnotify_inode_delete(struct inode *inode);
@@ -569,8 +570,9 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
 
 #else
 
-static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
-			   int data_type, const struct qstr *name, u32 cookie)
+static inline int fsnotify(__u32 mask, const void *data, int data_type,
+			   struct inode *dir, const struct qstr *name,
+			   struct inode *inode, u32 cookie)
 {
 	return 0;
 }
-- 
2.17.1

