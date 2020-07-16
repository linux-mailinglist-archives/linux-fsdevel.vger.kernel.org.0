Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284CC221EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgGPInE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgGPInB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4CFC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so6131174wrp.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1FPrhMQPtYqvY1liMDVg4wL8CDzPV9+9nLoS7Y7SrQ=;
        b=U1vLx49uVdIPgI5loAaJwytuFdlonq+ODqzYXc62mWeQ7OLuOiPhRvd+97jzbYTv05
         /Z038nm1ZdH9I4JNXCmWb3aWUZqVgrWqNIiwNHfxeRHiY4B/eayfrhjctSZk//lVzxyC
         MCTgesK/cHFdFG7jkv7tplTqj6JLsRBFcGq8vScwX6YvSTR8K439OBXyYAZJ/zY8IIV0
         XXRlrmAYdVj1M046Slkq+iAg6z2sgj+oXyz05DNu4wKq9fWC2EKJ9096hDF8I0wqHwh8
         w1X87bgzkx8n3N8PS0MNfj8r7BFOjS+fgXY4SQxY2jkf4VV3DErZ74bJe8MhIUulNDwL
         pxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z1FPrhMQPtYqvY1liMDVg4wL8CDzPV9+9nLoS7Y7SrQ=;
        b=rsF3y55rOr5lkglwAGCI9lb0PnnAPWmkpfEdWjF3rGs0Rk56WFodmAqMoWy7I0Nxix
         E27OdChW73MYfXvBRnWt/JCJW7sPGFUvzaYg+6Zev4vba0qnHEAvJZTRI7nW1fE2Z4nn
         D9QOlT0QEXXpiSRhDFRa+xMxY0y8dpuclh+Gp5s32GQMdp1WjNUSXyY98HMisfPy51Y+
         bK1ZppW56pAaPbpjOEmFuhNHmQkhMCrYww8kRItntYvCHbElA1xkD6yFiSxQJmHRDeXr
         ZELOpaKPteRN+0uaSfXYkNKwlujYJKHwU2C3kZ5WEAgDGHp0Vx0uSmt76gFWloszJJ8N
         rdLg==
X-Gm-Message-State: AOAM530Dd/wCQlMRdRHtg+4r9H7Xug8U7Zv+J6zgrZ8mmdaOVQk5bo74
        f/P1xkLBbmtfoujavZRIq8Q=
X-Google-Smtp-Source: ABdhPJzXpeaxcnEvTWzn1gzYPk+3ai784EFKfhxaacwemnvKl1pBqGFPOdjiTBVXeuNMej94rXkoRw==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr3756216wrn.281.1594888980079;
        Thu, 16 Jul 2020 01:43:00 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:59 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 17/22] fsnotify: send MOVE_SELF event with parent/name info
Date:   Thu, 16 Jul 2020 11:42:25 +0300
Message-Id: <20200716084230.30611-18-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MOVE_SELF event does not get reported to a parent watching children
when a child is moved, but it can be reported to sb/mount mark or to
the moved inode itself with parent/name info if group is interested
in parent/name info.

Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
fsnotify() to handle the case of an event "on child" that should not
be sent to the watching parent's inode mark.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 22 ++++++++++++++++++----
 include/linux/fsnotify.h         |  4 +---
 include/linux/fsnotify_backend.h |  2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index efa5c1c4908a..fa84aea47b20 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -367,6 +367,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	struct super_block *sb = to_tell->i_sb;
 	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
 	struct mount *mnt = NULL;
+	struct inode *inode = NULL;
 	struct inode *child = NULL;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
@@ -377,6 +378,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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
@@ -384,14 +393,17 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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
 
@@ -406,14 +418,16 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
-		fsnotify_first_mark(&to_tell->i_fsnotify_marks);
 	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
 		fsnotify_first_mark(&sb->s_fsnotify_marks);
 	if (mnt) {
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}
+	if (inode) {
+		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
+			fsnotify_first_mark(&inode->i_fsnotify_marks);
+	}
 	if (child) {
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
 			fsnotify_first_mark(&child->i_fsnotify_marks);
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index fe4f2bc5b4c2..61dccaf21e7b 100644
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
@@ -149,7 +147,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	if (target)
 		fsnotify_link_count(target);
 
-	fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_dentry(moved, FS_MOVE_SELF);
 	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 6f0df110e9f8..acce2ec17edf 100644
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

