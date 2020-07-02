Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448922123E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgGBM6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgGBM6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC10C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so15377258wmi.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ze3DVsnpLn6955ziqlJW9g7AtOACBHG2fh7ZGcDMi7Q=;
        b=TcMXclvrfhPl229dKEw4Xp6YwKKPzjQlkAI5MGSvKgo2z9KNBpA5LpOWBophlpzG4F
         Av7YnCKRmH0ELZ04iJD954zaoyXUiRbSu8WIPkhRJlgbt+v+KH1LwJzFkz65kbXuaYjt
         Je6vQXo1UmA/T6MzY4WNTMoW9xVzJ3pcRe9HJqrfb44X7Kixqq4elpYMeItyJu6zWpAk
         Nf+kJAE5NzSmZArXPMnOo/pG/F8H4Jm6/qtSbJ0VHc+7+kKoUfLC56FEMMAuBJdQpQpQ
         jGUtKBS2L5bXi1Rx6R2tP+h1d9/oXQc2uWi/cQZVnA7xB4T9TeTakb+XYuDehn4LDvHY
         ePOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ze3DVsnpLn6955ziqlJW9g7AtOACBHG2fh7ZGcDMi7Q=;
        b=aNevx+tR7eFhCABF1+2/yAbWZBicvzPnnFGtPs7ZuykPTxP+8WXJTZSboY75VmjIrg
         ObEwVYnUMm5uj2CLBDLt6bzjW0jJzoLoiebAGVELDuF8XpzE1pDU6Zn+ttmXqIUwEASZ
         pJgjkbWpRiCLX0DAKmCvzVK2cYWRc4qEcuvDAMcHso+IKpU40jb4hK5oQVIpkF1ABSsV
         ZpCYMMsD4RxV7QxgPUWH/pC/RECm59pEbNgeyV70JbQXzTJFcsgdv4FLR6z6roKETWm/
         xYh83hyxKk/K3PbGmDFL/EqsWMN49bRcLd34KBXStL3OCk9jjN39xCWSUtc3NGQpWuGK
         2TFg==
X-Gm-Message-State: AOAM532EmWWn97Mp2IZ39A3RQVD/j3Nap0GpXTG3k1KmIj1EhnylosUI
        YSqOP7FD/g617aVrpXPk90o=
X-Google-Smtp-Source: ABdhPJy9UELndzk6dc5R4xrTdcwcgt+TSJ+ca7VAIRyyFy41h6J6W9jmyFZelt72TFnbjBtY/IVBGA==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr32156420wmj.86.1593694681497;
        Thu, 02 Jul 2020 05:58:01 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:58:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 05/10] fsnotify: send MOVE_SELF event with parent/name info
Date:   Thu,  2 Jul 2020 15:57:39 +0300
Message-Id: <20200702125744.10535-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MOVE_SELF event does not get reported to a parent watching children
when a child is moved, but it can be reported to sb/mount mark with
parent/name info if group is interested in parent/name info.

Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
fsnotify() to handle the case of an event "on child" that should not
be sent to the watching parent's inode mark.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 21 +++++++++++++++++----
 include/linux/fsnotify.h         |  5 +----
 include/linux/fsnotify_backend.h |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 6683c77a5b13..0faf5b09a73e 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -352,6 +352,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	struct super_block *sb = to_tell->i_sb;
 	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
 	struct mount *mnt = NULL;
+	struct inode *inode = NULL;
 	struct inode *child = NULL;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
@@ -362,6 +363,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	if (mask & FS_EVENT_ON_CHILD)
 		child = fsnotify_data_inode(data, data_type);
 
+	/*
+	 * If event is "on child" then to_tell is a watching parent.
+	 * An event "on child" may be sent to mount/sb mark with parent/name
+	 * info, but not appropriate for watching parent (e.g. FS_MOVE_SELF).
+	 */
+	if (!child || (mask & FS_EVENTS_POSS_ON_CHILD))
+		inode = to_tell;
+
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
 	 * be expensive.  It protects walking the *_fsnotify_marks lists.
@@ -369,14 +378,17 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	 * SRCU because we have no references to any objects and do not
 	 * need SRCU to keep them "alive".
 	 */
-	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
+	if (!sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
+	    (!inode || !inode->i_fsnotify_marks) &&
 	    (!child || !child->i_fsnotify_marks))
 		return 0;
 
-	marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
+	marks_mask = sb->s_fsnotify_mask;
 	if (mnt)
 		marks_mask |= mnt->mnt_fsnotify_mask;
+	if (inode)
+		marks_mask |= inode->i_fsnotify_mask;
 	if (child)
 		marks_mask |= child->i_fsnotify_mask;
 
@@ -390,14 +402,15 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
-		fsnotify_first_mark(&to_tell->i_fsnotify_marks);
 	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
 		fsnotify_first_mark(&sb->s_fsnotify_marks);
 	if (mnt) {
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}
+	if (inode)
+		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
+			fsnotify_first_mark(&inode->i_fsnotify_marks);
 	if (child) {
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
 			fsnotify_first_mark(&child->i_fsnotify_marks);
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 044cae3a0628..61dccaf21e7b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -131,7 +131,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	u32 fs_cookie = fsnotify_get_cookie();
 	__u32 old_dir_mask = FS_MOVED_FROM;
 	__u32 new_dir_mask = FS_MOVED_TO;
-	__u32 mask = FS_MOVE_SELF;
 	const struct qstr *new_name = &moved->d_name;
 
 	if (old_dir == new_dir)
@@ -140,7 +139,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	if (isdir) {
 		old_dir_mask |= FS_ISDIR;
 		new_dir_mask |= FS_ISDIR;
-		mask |= FS_ISDIR;
 	}
 
 	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
@@ -149,8 +147,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	if (target)
 		fsnotify_link_count(target);
 
-	if (source)
-		fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_dentry(moved, FS_MOVE_SELF);
 	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a7363c33211e..28f6cf704875 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -89,7 +89,7 @@
  * It may include events that can be sent to an inode/sb/mount mark, but cannot
  * be sent to a parent watching children.
  */
-#define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD)
+#define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD | FS_MOVE_SELF)
 
 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
-- 
2.17.1

