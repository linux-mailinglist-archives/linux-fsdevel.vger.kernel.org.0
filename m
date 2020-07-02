Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A482123E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgGBM6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgGBM6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E5FC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so26345507wmf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJIfdyxwRv1mWJDflQVDWRnd1lBeTD7FMN0KqLYDIP8=;
        b=lXPo5eDs9c7qVN6EqdGwGxz7dxAoMGxxSAg6AjGtODu97q26Iw/zgnc2mEEGMUViBT
         XVQG3EicXEsUvfEuEJlnJRqIyOnUEaI7u56oKqxpO/H/5XN8lqKuBrWSNMikOHJHSiSm
         W7el+RaxJ2uYfHT0kxNJw2JSiNzA2U+mZk8pQcEGHCLOhu1eywx0/IOsYtCCaPHHV4P5
         xxbWPtdPDgjl6d/6ndLQ8E6373Svxacq1OADpsGmhRV9YOQ9xKzcdgNhVhXfC2cvxANM
         ywCeDfzFv7ZcxbVeBAVe1w/lHh0pbkRST/UDxW3eZQYVdLJFoCpYGjyVc1We4AwYaxxy
         ayvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJIfdyxwRv1mWJDflQVDWRnd1lBeTD7FMN0KqLYDIP8=;
        b=husVHgzXfms4xz+mtbOb87pal9UbyzXZwCj0rWCEhxNMqRLck8dEfLnk8RkT7wjQ12
         eoA1x6FGMbml19eFQ51/i6YFrPGMZ16dc2fReyt8duuNWB3WTeDlkZxVKtN5OTmMQopC
         JmV/5DpIxpaX4EMx60gHkyHoanv31ZOcW1ELfUiN517YUqXqA0puN0e3RIH8dnvuzYMl
         fzkDw36e03ty73rVXmenqxPL2yR+1G0oHJB6zsL57RgnLyaSOVbgBdX6SsJ6XFWkyWyo
         VfrP2lMrIVeq+agdo6Lv6wtWNUafKUrBD5HskmrQbhv5wvL4ft0a5hQVLqzdGzbStnnb
         CwyQ==
X-Gm-Message-State: AOAM5332ztsVUC7Cx1DD6M507HShXEVGlFp5z4RR0qC5gvkW5bTPBxz3
        lu8mpdDOS3IoeRNRl//Qr7M=
X-Google-Smtp-Source: ABdhPJzuurzerOw/cXuBvRhsvFSnluDkRg2WAuy/v8taP8Pt6VDCzt+gY2cL/pdNzb1iZRMJecdNiw==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr30125269wml.57.1593694680201;
        Thu, 02 Jul 2020 05:58:00 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:57:59 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 04/10] fsnotify: send event with parent/name info to sb/mount/non-dir marks
Date:   Thu,  2 Jul 2020 15:57:38 +0300
Message-Id: <20200702125744.10535-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to events "on child" to watching directory, send event "on child"
with parent/name info if sb/mount/non-dir marks are interested in
parent/name info.

The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
interest in parent/name info for events on non-directory inodes.

Events on "orphan" children (disconnected dentries) are sent without
parent/name info.

Events on direcories are send with parent/name info only if the parent
directory is watching.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 50 +++++++++++++++++++++++---------
 include/linux/fsnotify.h         | 10 +++++--
 include/linux/fsnotify_backend.h | 32 +++++++++++++++++---
 3 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7c6e624b24c9..6683c77a5b13 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -144,27 +144,55 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 
 /*
  * Notify this dentry's parent about a child's events with child name info
- * if parent is watching.
- * Notify only the child without name info if parent is not watching.
+ * if parent is watching or if inode/sb/mount are interested in events with
+ * parent and name info.
+ *
+ * Notify only the child without name info if parent is not watching and
+ * inode/sb/mount are not interested in events with parent and name info.
  */
 int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		      int data_type)
 {
+	const struct path *path = fsnotify_data_path(data, data_type);
+	struct mount *mnt = path ? real_mount(path->mnt) : NULL;
 	struct inode *inode = d_inode(dentry);
 	struct dentry *parent;
+	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
+	__u32 p_mask, test_mask, marks_mask = 0;
 	struct inode *p_inode;
 	int ret = 0;
 
+	/*
+	 * Do inode/sb/mount care about parent and name info on non-dir?
+	 * Do they care about any event at all?
+	 */
+	if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
+	    (!mnt || !mnt->mnt_fsnotify_marks)) {
+		if (!parent_watched)
+			return 0;
+	} else if (!(mask & FS_ISDIR) && !IS_ROOT(dentry)) {
+		marks_mask |= fsnotify_want_parent(inode->i_fsnotify_mask);
+		marks_mask |= fsnotify_want_parent(inode->i_sb->s_fsnotify_mask);
+		if (mnt)
+			marks_mask |= fsnotify_want_parent(mnt->mnt_fsnotify_mask);
+	}
+
 	parent = NULL;
-	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+	test_mask = mask & FS_EVENTS_POSS_TO_PARENT;
+	if (!(marks_mask & test_mask) && !parent_watched)
 		goto notify_child;
 
+	/* Does parent inode care about events on children? */
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
+	p_mask = fsnotify_inode_watches_children(p_inode);
 
-	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
+	if (p_mask)
+		marks_mask |= p_mask;
+	else if (unlikely(parent_watched))
 		__fsnotify_update_child_dentry_flags(p_inode);
-	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
+
+	if ((marks_mask & test_mask) && p_inode != inode) {
 		struct name_snapshot name;
 
 		/* When notifying parent, child should be passed as data */
@@ -346,15 +374,11 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	    (!child || !child->i_fsnotify_marks))
 		return 0;
 
-	/* An event "on child" is not intended for a mount/sb mark */
-	marks_mask = to_tell->i_fsnotify_mask;
-	if (!child) {
-		marks_mask |= sb->s_fsnotify_mask;
-		if (mnt)
-			marks_mask |= mnt->mnt_fsnotify_mask;
-	} else {
+	marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
+	if (mnt)
+		marks_mask |= mnt->mnt_fsnotify_mask;
+	if (child)
 		marks_mask |= child->i_fsnotify_mask;
-	}
 
 	/*
 	 * if this is a modify event we may need to clear the ignored masks
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 9b2566d273a9..044cae3a0628 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -44,10 +44,16 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 {
 	struct inode *inode = d_inode(dentry);
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		mask |= FS_ISDIR;
 
-	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+		/* sb/mount marks are not interested in name of directory */
+		if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+			goto notify_child;
+	}
+
+	/* disconnected dentry cannot notify parent */
+	if (IS_ROOT(dentry))
 		goto notify_child;
 
 	return __fsnotify_parent(dentry, mask, data, data_type);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 2c62628566c5..a7363c33211e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -49,8 +49,11 @@
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
 #define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
-/* This inode cares about things that happen to its children.  Always set for
- * dnotify and inotify. */
+/*
+ * Set on inode mark that cares about things that happen to its children.
+ * Always set for dnotify and inotify.
+ * Set on inode/sb/mount marks that care about parenet/name info.
+ */
 #define FS_EVENT_ON_CHILD	0x08000000
 
 #define FS_DN_RENAME		0x10000000	/* file renamed */
@@ -72,14 +75,22 @@
 				  FS_OPEN_EXEC_PERM)
 
 /*
- * This is a list of all events that may get sent to a parent based on fs event
- * happening to inodes inside that directory.
+ * This is a list of all events that may get sent to a parent that is watching
+ * with flag FS_EVENT_ON_CHILD based on fs event on a child of that directory.
  */
 #define FS_EVENTS_POSS_ON_CHILD   (ALL_FSNOTIFY_PERM_EVENTS | \
 				   FS_ACCESS | FS_MODIFY | FS_ATTRIB | \
 				   FS_CLOSE_WRITE | FS_CLOSE_NOWRITE | \
 				   FS_OPEN | FS_OPEN_EXEC)
 
+/*
+ * This is a list of all events that may get sent with the parent inode as the
+ * @to_tell argument of fsnotify().
+ * It may include events that can be sent to an inode/sb/mount mark, but cannot
+ * be sent to a parent watching children.
+ */
+#define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD)
+
 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
@@ -398,6 +409,19 @@ extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
 
+static inline __u32 fsnotify_want_parent(__u32 mask)
+{
+	/* FS_EVENT_ON_CHILD is set on marks that want parent/name info */
+	if (!(mask & FS_EVENT_ON_CHILD))
+		return 0;
+	/*
+	 * This object might be watched by a mark that cares about parent/name
+	 * info, does it care about the specific set of events that can be
+	 * reported with parent/name info?
+	 */
+	return mask & FS_EVENTS_POSS_TO_PARENT;
+}
+
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-- 
2.17.1

