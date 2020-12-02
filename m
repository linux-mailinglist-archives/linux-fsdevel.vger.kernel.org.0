Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8852CBC74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbgLBMIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgLBMIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:08:40 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2CC061A4C
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:22 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id d17so3788652ejy.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBohio/dzYx/427lCLMRQSn9ZMdaot71hh7SBHNLl+w=;
        b=nMmOGjDRiZTq+A/tkZtnhiUecKq569MzeTVZTVME9MvDetLlT/rf9RD8QLtJKHR3wH
         4bQMAiUS7iy76fwoBdMAi5DD8VKWIIvkiku/btJ41Z+WQSUFRc02daW1J1vZZHRipKWy
         SHQfh2HZq5WzuPIMUMSEUhjJaqjil/Xz/jyzTxLMm1eYmi0IKtaialRSqtuAInDVAs/J
         2kzAt8TvFnt6VZluFS1khtXucNymJOK6tJVc2FllwJy8/XveCUkXXUcipYCnwdkDuVA0
         ws6a3kLEKxuBRN+v9JRHPaeYTnAiFOSy4P+78rQ6e4L7npUFdnahrrGt4HWhvha7ZcOu
         RFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBohio/dzYx/427lCLMRQSn9ZMdaot71hh7SBHNLl+w=;
        b=eBxw89htk27KPlxj8yk2YJFTwcb3FYLTt/d/hVOAAuzJMZCI2J973kmP+lVFcXGWhC
         jlv3MQiWp3fydrkTybmyUH0j7u75/8bz3YQ9rkiQTq/CaKgZV73J1dvF8GID1TlfSwcv
         X8IVBcLBA1L+kJ9aGzxJyzJYjXWZB+cX5yxpNWv1IYxH7Pm0fcMwGek2dEsvAGFUg/aM
         /GM4b6g5KUUtMfadAelMckb6CwVUj4OZXiR0SDRpmWNSJCehCN7ZDqAwiNZEMAnWocRc
         Wd2+LUcKldcSRSnIhllMUGv8rPu+z8GJFDNcp6WhuJQl5Qi0Sjn/7i5WZirJMaAy5ya0
         oJBQ==
X-Gm-Message-State: AOAM531HAqB5C/Gt2if+o0dXzXPGafY5OPhNhGCUn25/23XFU3D0Os1T
        7td32GWPYg5p8UlpB3/VKsTmCEvXak8=
X-Google-Smtp-Source: ABdhPJyBHyKeA5eI8IyjcP9RroWhB9ddY/Jd1eOtvSN5JTeDYQBQ8XtuePJw8rIhVrMACTwiMTlELA==
X-Received: by 2002:a17:906:1646:: with SMTP id n6mr1934780ejd.89.1606910841369;
        Wed, 02 Dec 2020 04:07:21 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:20 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] fsnotify: fix events reported to watching parent and child
Date:   Wed,  2 Dec 2020 14:07:09 +0200
Message-Id: <20201202120713.702387-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify_parent() used to send two separate events to backends when a
parent inode is watcing children and the child inode is also watching.

In an attempt to avoid duplicate events in fanotify, we unified the two
backend callbacks to a single callback and handled the reporting of the
two separate events for the relevant backends (inotify and dnotify).

The unified event callback with two inode marks (parent and child) is
called when both parent and child inode are watched and interested in
the event, but they could each be watched by a different group.

So before reporting the parent or child event flavor to backend we need
to check that the group is really interested in that event flavor.

The semantics of INODE and CHILD marks were hard to follow and made the
logic more complicated than it should have been.  Replace it with INODE
and PARENT marks semantics to hopefully make the logic more clear.

Fixes: eca4784cbb18 ("fsnotify: send event to parent and child with single callback")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    |  7 ++-
 fs/notify/fsnotify.c             | 78 ++++++++++++++++++--------------
 include/linux/fsnotify_backend.h |  6 +--
 3 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 9167884a61ec..1192c9953620 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -268,12 +268,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			continue;
 
 		/*
-		 * If the event is for a child and this mark is on a parent not
+		 * If the event is on a child and this mark is on a parent not
 		 * watching children, don't send it!
 		 */
-		if (event_mask & FS_EVENT_ON_CHILD &&
-		    type == FSNOTIFY_OBJ_TYPE_INODE &&
-		     !(mark->mask & FS_EVENT_ON_CHILD))
+		if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
+		    !(mark->mask & FS_EVENT_ON_CHILD))
 			continue;
 
 		marks_mask |= mark->mask;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index c5c68bcbaadf..0676ce4d3352 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -152,6 +152,13 @@ static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
 	if (mask & FS_ISDIR)
 		return false;
 
+	/*
+	 * All events that are possible on child can also may be reported with
+	 * parent/name info to inode/sb/mount.  Otherwise, a watching parent
+	 * could result in events reported with unexpected name info to sb/mount.
+	 */
+	BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ~FS_EVENTS_POSS_TO_PARENT);
+
 	/* Did either inode/sb/mount subscribe for events with parent/name? */
 	marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
 	marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
@@ -249,6 +256,10 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 	    path && d_unlinked(path->dentry))
 		return 0;
 
+	/* Check interest of this mark in case event was sent with two marks */
+	if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
+		return 0;
+
 	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
 }
 
@@ -258,38 +269,40 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 				 u32 cookie, struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
-	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
+	struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
 	int ret;
 
 	if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
 	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
 
-	/*
-	 * An event can be sent on child mark iterator instead of inode mark
-	 * iterator because of other groups that have interest of this inode
-	 * and have marks on both parent and child.  We can simplify this case.
-	 */
-	if (!inode_mark) {
-		inode_mark = child_mark;
-		child_mark = NULL;
+	if (parent_mark) {
+		/*
+		 * parent_mark indicates that the parent inode is watching children
+		 * and interested in this event, which is an event possible on child.
+		 * But is this mark watching children and interested in this event?
+		 */
+		if (parent_mark->mask & FS_EVENT_ON_CHILD) {
+			ret = fsnotify_handle_inode_event(group, parent_mark, mask,
+							  data, data_type, dir, name, 0);
+			if (ret)
+				return ret;
+		}
+		if (!inode_mark)
+			return 0;
+
+		/*
+		 * Some events can be sent on both parent dir and child marks
+		 * (e.g. FS_ATTRIB).  If both parent dir and child are watching,
+		 * report the event once to parent dir with name (if interested)
+		 * and once to child without name (if interested).
+		 */
 		dir = NULL;
 		name = NULL;
 	}
 
-	ret = fsnotify_handle_inode_event(group, inode_mark, mask, data, data_type,
-					  dir, name, cookie);
-	if (ret || !child_mark)
-		return ret;
-
-	/*
-	 * Some events can be sent on both parent dir and child marks
-	 * (e.g. FS_ATTRIB).  If both parent dir and child are watching,
-	 * report the event once to parent dir with name and once to child
-	 * without name.
-	 */
-	return fsnotify_handle_inode_event(group, child_mark, mask, data, data_type,
-					   NULL, NULL, 0);
+	return fsnotify_handle_inode_event(group, inode_mark, mask, data, data_type,
+					   dir, name, cookie);
 }
 
 static int send_to_group(__u32 mask, const void *data, int data_type,
@@ -447,7 +460,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	struct fsnotify_iter_info iter_info = {};
 	struct super_block *sb;
 	struct mount *mnt = NULL;
-	struct inode *child = NULL;
+	struct inode *parent = NULL;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
 
@@ -459,11 +472,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		inode = dir;
 	} else if (mask & FS_EVENT_ON_CHILD) {
 		/*
-		 * Event on child - report on TYPE_INODE to dir if it is
-		 * watching children and on TYPE_CHILD to child.
+		 * Event on child - report on TYPE_PARENT to dir if it is
+		 * watching children and on TYPE_INODE to child.
 		 */
-		child = inode;
-		inode = dir;
+		parent = dir;
 	}
 	sb = inode->i_sb;
 
@@ -477,7 +489,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (!sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!child || !child->i_fsnotify_marks))
+	    (!parent || !parent->i_fsnotify_marks))
 		return 0;
 
 	marks_mask = sb->s_fsnotify_mask;
@@ -485,8 +497,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		marks_mask |= mnt->mnt_fsnotify_mask;
 	if (inode)
 		marks_mask |= inode->i_fsnotify_mask;
-	if (child)
-		marks_mask |= child->i_fsnotify_mask;
+	if (parent)
+		marks_mask |= parent->i_fsnotify_mask;
 
 
 	/*
@@ -509,9 +521,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
 			fsnotify_first_mark(&inode->i_fsnotify_marks);
 	}
-	if (child) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
-			fsnotify_first_mark(&child->i_fsnotify_marks);
+	if (parent) {
+		iter_info.marks[FSNOTIFY_OBJ_TYPE_PARENT] =
+			fsnotify_first_mark(&parent->i_fsnotify_marks);
 	}
 
 	/*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 4ee3044eedd0..a2e42d3cd87c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -278,7 +278,7 @@ static inline const struct path *fsnotify_data_path(const void *data,
 
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
-	FSNOTIFY_OBJ_TYPE_CHILD,
+	FSNOTIFY_OBJ_TYPE_PARENT,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
 	FSNOTIFY_OBJ_TYPE_COUNT,
@@ -286,7 +286,7 @@ enum fsnotify_obj_type {
 };
 
 #define FSNOTIFY_OBJ_TYPE_INODE_FL	(1U << FSNOTIFY_OBJ_TYPE_INODE)
-#define FSNOTIFY_OBJ_TYPE_CHILD_FL	(1U << FSNOTIFY_OBJ_TYPE_CHILD)
+#define FSNOTIFY_OBJ_TYPE_PARENT_FL	(1U << FSNOTIFY_OBJ_TYPE_PARENT)
 #define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL	(1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
 #define FSNOTIFY_OBJ_TYPE_SB_FL		(1U << FSNOTIFY_OBJ_TYPE_SB)
 #define FSNOTIFY_OBJ_ALL_TYPES_MASK	((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
@@ -331,7 +331,7 @@ static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 }
 
 FSNOTIFY_ITER_FUNCS(inode, INODE)
-FSNOTIFY_ITER_FUNCS(child, CHILD)
+FSNOTIFY_ITER_FUNCS(parent, PARENT)
 FSNOTIFY_ITER_FUNCS(vfsmount, VFSMOUNT)
 FSNOTIFY_ITER_FUNCS(sb, SB)
 
-- 
2.25.1

