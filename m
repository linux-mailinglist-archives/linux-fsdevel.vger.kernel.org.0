Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A284221EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGPInA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgGPIm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE7C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so9439149wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iS8h8xcgbsn5E7yVxWKMHYCGwIn2hPpcQCv3Ur50qR0=;
        b=pMmDMKZ3QmL/VJsVT6fsgLp5kY6/ADYa10g2cKbATF8grNxZffYdLExT2VWuYE7PHR
         wG5mVloLgJblWKcgYSMm2BI46ZnOj4WUWopTLXYcAcowxRae74ag1yl3/1kACi/Rt/kh
         JCfWYffXjDvhz8wH9oQA+Y0pb0/ZmgT5/GMRhu+0qifDuvNCEkg1hldwEKhOL42v4lJS
         U2c3cfTlNrlqM3AjqrlMXjUtjbjNyMM8qNOZLCPWjvL+onKj2wwAmLr2xpxQEmkHAz+1
         2HP89B3zI9hlkdOcqDOxkFRit1dFWjCnTD6XgZwlLCAyyWfKgquKd+LpTeJtZp/NV4q/
         6QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iS8h8xcgbsn5E7yVxWKMHYCGwIn2hPpcQCv3Ur50qR0=;
        b=DkYPdN3If55FtO4wtdedUs5fl18xtmBGfv9di6Z8yyRYdr8U3SUtXoT4STBQ1kFvgz
         peULU8Fr5sQW61E5VZc9oP0nqCkoGwZlLCWqEZLV3tTgZdlv0r3CYg2PJiY1J8LHpjmF
         rogmGMWR9lw2XpqwkZxlcHSYnymRA6+0kNm9mVWNxGUNb4zDBj80jeTc7SERyvSsa9q9
         x+uolfUvL5SSQJSP5v7flnUxjR1FLmnKKTj5duTMUPHHzh1G6LAUXC0Ahkig2T3cwxyj
         o2lYl3p6W8FAROKwEQlevzcAy4iZ7k8wMgBVl2EzHJdkDDlJtZjWluooMDdj0Zd00/oe
         bCVA==
X-Gm-Message-State: AOAM533XoC0/0MlkhXvTEukH4+CFbwsnTe3OPytdGSSlefz1yT9i2OU7
        IpyWAUTM6BJEqnhXMSz5A53qFFXB
X-Google-Smtp-Source: ABdhPJwyjLcCIVz++LdGAnlB0/2UjrB4DAUkkx+n/6seQuQV/FqNzSvUMx+GkWZwS5j3sKsZgCkLEQ==
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr3189104wme.61.1594888977324;
        Thu, 16 Jul 2020 01:42:57 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 15/22] fsnotify: send event with parent/name info to sb/mount/non-dir marks
Date:   Thu, 16 Jul 2020 11:42:23 +0300
Message-Id: <20200716084230.30611-16-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
 fs/notify/fsnotify.c             | 54 ++++++++++++++++++++++++++++----
 include/linux/fsnotify.h         | 10 ++++--
 include/linux/fsnotify_backend.h | 32 ++++++++++++++++---
 3 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7120c675e9a6..efa5c1c4908a 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -142,31 +142,73 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+/* Are inode/sb/mount interested in parent and name info with this event? */
+static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
+					__u32 mask)
+{
+	__u32 marks_mask = 0;
+
+	/* We only send parent/name to inode/sb/mount for events on non-dir */
+	if (mask & FS_ISDIR)
+		return false;
+
+	/* Did either inode/sb/mount subscribe for events with parent/name? */
+	marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
+	marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
+	if (mnt)
+		marks_mask |= fsnotify_parent_needed_mask(mnt->mnt_fsnotify_mask);
+
+	/* Did they subscribe for this event with parent/name info? */
+	return mask & marks_mask;
+}
+
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
+	__u32 p_mask;
 	struct inode *p_inode;
 	struct name_snapshot name;
 	struct qstr *file_name = NULL;
 	int ret = 0;
 
+	/*
+	 * Do inode/sb/mount care about parent and name info on non-dir?
+	 * Do they care about any event at all?
+	 */
+	if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
+	    (!mnt || !mnt->mnt_fsnotify_marks) && !parent_watched)
+		return 0;
+
 	parent = NULL;
-	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+	if (!parent_watched && !fsnotify_event_needs_parent(inode, mnt, mask))
 		goto notify;
 
+	/* Does parent inode care about events on children? */
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
-
-	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
+	p_mask = fsnotify_inode_watches_children(p_inode);
+	if (unlikely(parent_watched && !p_mask))
 		__fsnotify_update_child_dentry_flags(p_inode);
-	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
+
+	/*
+	 * Include parent/name in notification either if some notification
+	 * groups require parent info (!parent_watched case) or the parent is
+	 * interested in this event.
+	 */
+	if (!parent_watched || (mask & p_mask & ALL_FSNOTIFY_EVENTS)) {
 		/* When notifying parent, child should be passed as data */
 		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
 
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
index 2c62628566c5..6f0df110e9f8 100644
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
 
+static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
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

