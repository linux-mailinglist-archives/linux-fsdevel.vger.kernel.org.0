Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91072298D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgGVM7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgGVM7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27180C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so1859905wme.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7eTqHQLUCWKWQRufe18gQN1hCUN7B4GBXZpVXhLVG68=;
        b=uZoGXfwFgsnWFZYkS1bl2JgqTctJuvHLZ3HGRZkLhMJFdlyEfZGtHPZz05EjfPSspA
         yv0fXoHbxLWtWviL4AxVFYsl7E5ygghLhCLSetf9QsJSsseFlsnD6E8KBmtpUzlKMQO2
         jhg75FjCLvgWAKl8p+6bdVONFiddqvdAIQf6fi2LRYbxweyq+oSiaVgnsbzV81N0VzDD
         E9pL2Xn6iyDed3JpCbaktZmzVNJakMt9jQrVEWsDHWY7n+HerLvCx1ra9bzq1YL5Z4CV
         US5wL0ZUIeDXspca3+cDEkHjaIa59uKFT52is3RvR0G4v0GoGz6yLw7+TP3IQOok7F87
         2jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7eTqHQLUCWKWQRufe18gQN1hCUN7B4GBXZpVXhLVG68=;
        b=pQUk28kJhwtpByIvcsBoKYXbtAbPNHxq19YwVJMP6HO5cW7QRpIhwCCE2phO70/bvf
         VL5nUUIRRNlqsFlsp8fHaiUy7Ro9uYn3F8MtADnt3JRcxO59TPGKdi7lD8tNf1ptz6bD
         Ssih20kiVVc+T+z4UHLT5AhVbFgc9MXwkYwLZrxDNaXTfUf7FY6C9sd/j3jWc5clAqUE
         zvTmu5eSxIkE0hMqI37qUxBwKjEkcQjHOWPp3UmLMamfRbzMftm/3ZEcb9Kl7Wv4Mg11
         ZBmzdpQlbEoLQHAH5bQDaIJFbLkYmEUqICROedtxjuOWoOl9ZgAz8HSzWc3/ko+QXb4j
         jXfw==
X-Gm-Message-State: AOAM530SSyZUxJOJ2LyDdfWSmFogb7KitzMgLlm5jBuyzkanBiITzMDK
        /vZRK2qUt2Tddy++v/1GTec=
X-Google-Smtp-Source: ABdhPJx+3nx4pY7+/fAMD2IB9tpJh3AcbqTmVB4UHWFZxqto0w1AtwPkZx58zPG8Wss1eHiNFZyBNA==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr9037312wmr.133.1595422751824;
        Wed, 22 Jul 2020 05:59:11 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] fsnotify: fix merge with parent mark masks
Date:   Wed, 22 Jul 2020 15:58:47 +0300
Message-Id: <20200722125849.17418-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When reporting event with parent/name info, we should not merge
parent's mark mask and ignore mask, unless the parent has the flag
FS_EVENT_ON_CHILD in the mask.

Therefore, in fsnotify_parent(), set the FS_EVENT_ON_CHILD flag in event
mask only if parent is watching and use this flag to decide if the
parent mark masks should be merged with child/sb/mount marks.

After this change, even groups that do not subscribe to events on
children could get an event with mark iterator type TYPE_CHILD and
without mark iterator type TYPE_INODE if fanotify has marks on the same
objects.

dnotify and inotify event handlers can already cope with that situation.
audit does not subscribe to events that are possible on child, so won't
get to this situation. nfsd does not access the marks iterator from its
event handler at the moment, so it is not affected.

This is a bit too fragile, so we should prepare all groups to cope with
mark type TYPE_CHILD preferably using a generic helper.

Link: https://lore.kernel.org/linux-fsdevel/20200716223441.GA5085@quack2.suse.cz/
Fixes: ecf13b5f8fd6 ("fsnotify: send event with parent/name info to sb/mount/non-dir marks")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c |  2 +-
 fs/notify/fsnotify.c          | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 03e3dce2a97c..3336157d895d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -538,7 +538,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		 * in addition to reporting the parent fid and maybe child name.
 		 */
 		if ((fid_mode & FAN_REPORT_FID) &&
-		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
+		    id != dirid && !(mask & FAN_ONDIR))
 			child = id;
 
 		id = dirid;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 3b805e05c02d..494d5d70323f 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -215,7 +215,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		/* Notify both parent and child with child name info */
 		take_dentry_name_snapshot(&name, dentry);
 		file_name = &name.name;
-		mask |= FS_EVENT_ON_CHILD;
+		if (parent_watched)
+			mask |= FS_EVENT_ON_CHILD;
 	}
 
 notify:
@@ -391,8 +392,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		inode = dir;
 	} else if (mask & FS_EVENT_ON_CHILD) {
 		/*
-		 * Event on child - report on TYPE_INODE to dir
-		 * and on TYPE_CHILD to child.
+		 * Event on child - report on TYPE_INODE to dir if it is
+		 * watching children and on TYPE_CHILD to child.
 		 */
 		child = inode;
 		inode = dir;
@@ -406,14 +407,17 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	 * SRCU because we have no references to any objects and do not
 	 * need SRCU to keep them "alive".
 	 */
-	if (!inode->i_fsnotify_marks && !sb->s_fsnotify_marks &&
+	if (!sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
+	    (!inode || !inode->i_fsnotify_marks) &&
 	    (!child || !child->i_fsnotify_marks))
 		return 0;
 
-	marks_mask = inode->i_fsnotify_mask | sb->s_fsnotify_mask;
+	marks_mask = sb->s_fsnotify_mask;
 	if (mnt)
 		marks_mask |= mnt->mnt_fsnotify_mask;
+	if (inode)
+		marks_mask |= inode->i_fsnotify_mask;
 	if (child)
 		marks_mask |= child->i_fsnotify_mask;
 
@@ -428,14 +432,16 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
-		fsnotify_first_mark(&inode->i_fsnotify_marks);
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
-- 
2.17.1

