Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB11612FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBQNPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgBQNP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so19738037wrt.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YXRsI1FLp1ez4RjlBLLPoXSAG6JY/ciFQ8Zwwl8DhpQ=;
        b=FpWJATGo8c/CR2bW6pMfuLl6VrkmKJvAzcnijzkNY3Y/15t0rMmUOjPFPnduL95qGR
         uVvyYScKAmo3wyfhplZnBtwMudnp4bVIj3MMlMNaXULGTPxwyuF2nTC8MPVXVxWjWCR5
         tKHesXdt+ybvPkHxbhpGZ+w4URvqhNkXL3hLXOsbYwj5YXY686P50oY8Xei4gKqNSX6p
         fSdYj1mjqKdl+ggo30w3qvJhaVX50TsLYjSsWUhFmTX8NM7BpoPDFchZY23zTvZpwP/P
         En0k3vq45sgLK8UYq0Uae3oiZIjDfZsljTR2O6ai8Pdj46TnodwKaGa68HIz2VZDekR0
         +KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YXRsI1FLp1ez4RjlBLLPoXSAG6JY/ciFQ8Zwwl8DhpQ=;
        b=f8V29AUeu1ESbHhr7aBUN2HkwlMC6OMDZuc7t62xBToBNnzlpRNC2kapM/OfzyYPAY
         HQartAEBFnmjAarzo7U6Ho79w5oPOzjWIy/RWQzDnSx3NeNX5q4/VH5AFGlxi8ZkDZ+Z
         VMx5vYwQUDGKMqyZN2AiE1xXJnKWyoPQjkAtUwnHo5UitFTY6asJgzHGRDzvHSg1o5KL
         108k4vAHFjeC/R2rZ7/9u8bnAn82Jnyixmd4cyblqYaVwQU+2dVcAah0c4ObELWEHVcX
         hFguIrfSoRidgpe/6SG/3/+XLD9JC1nXA5e8j9T1scfO6DD3EiHAPewI6YLRQruPoGp1
         QKzg==
X-Gm-Message-State: APjAAAUXjzNpc3/F5hNYQFhRbO8mNDrUnQyMqO527BU2ZjX6F9yOz/B7
        GkLnunZdgtFSj6xCQnvnpls=
X-Google-Smtp-Source: APXvYqzjf6eu5g4GcuyYd36C8PfXQ0wLum0xFgMEGT8Xlga9X7WDZkt6OcdL2O+ne/R6FD9eXRoojg==
X-Received: by 2002:adf:df83:: with SMTP id z3mr22070045wrl.389.1581945325564;
        Mon, 17 Feb 2020 05:15:25 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:25 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 15/16] fanotify: refine rules for when name is reported
Date:   Mon, 17 Feb 2020 15:14:54 +0200
Message-Id: <20200217131455.31107-16-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With FAN_REPORT_NAME, name will be reported if event is in the mask of a
watching parent or filesystem mark.

Name will not be reported if event is only in the mask of a mark on the
victim inode itself.

If event is only in the mask of a marked mount, name will be reported if
the victim inode is not the mount's root.  Note that the mount's root
could be a non-directory in case of bind mount.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 37 +++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 43c338a8a2f1..45203c1484b9 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -202,6 +202,32 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		     !(mark->mask & FS_EVENT_ON_CHILD)))
 			continue;
 
+		/*
+		 * fanotify_alloc_event() uses the "on child" flag as indication
+		 * for reporting name, but the flag will be masked out before
+		 * reporting to user.
+		 *
+		 * With FAN_REPORT_NAME, name will be reported if event is in
+		 * the mask of a watching parent or filesystem mark.
+		 * name will not be reported if event is only in the mask of a
+		 * mark on the victim inode itself.
+		 * If event is only in the mask of a marked mount, name will be
+		 * reported if the victim inode is not the mount's root. Note
+		 * that the mount's root could be a non-directory in case of
+		 * bind mount.
+		 */
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_NAME) &&
+		    event_mask & mark->mask & FS_EVENTS_POSS_ON_CHILD) {
+			user_mask |= FS_EVENT_ON_CHILD;
+			if (type == FSNOTIFY_OBJ_TYPE_SB ||
+			    (type == FSNOTIFY_OBJ_TYPE_VFSMOUNT &&
+			     !WARN_ON_ONCE(data_type != FSNOTIFY_EVENT_PATH) &&
+			     path->dentry != path->mnt->mnt_root)) {
+				event_mask |= FS_EVENT_ON_CHILD;
+				marks_mask |= FS_EVENT_ON_CHILD;
+			}
+		}
+
 		marks_mask |= mark->mask;
 		marks_ignored_mask |= mark->ignored_mask;
 	}
@@ -344,9 +370,8 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * With flag FAN_REPORT_NAME, we report the parent fid and name for
 	 * events possible "on child" in addition to reporting the child fid.
 	 * If parent is unknown (dentry is disconnected) or parent is not on the
-	 * same filesystem as child (dentry is sb root), only "child" fid is
-	 * reported. Events are reported the same way when reported to sb, mount
-	 * or inode marks and when reported to a directory watching children.
+	 * same filesystem/mount as child (dentry is sb/mount root), only the
+	 * "child" fid is reported.
 	 * Allocate an fanotify_name_event struct and copy the name.
 	 */
 	if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
@@ -357,7 +382,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		id = NULL;
 		dir = inode;
 	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_NAME) &&
-		   mask & FS_EVENTS_POSS_ON_CHILD &&
+		   mask & FS_EVENT_ON_CHILD &&
 		   likely(dentry && !IS_ROOT(dentry))) {
 		parent = dget_parent(dentry);
 		dir = d_inode(parent);
@@ -400,7 +425,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * directory and child watches exist.
 	 */
 	fsnotify_init_event(&event->fse, (void *)dentry ?: inode);
-	event->mask = mask;
+	event->mask = mask & FANOTIFY_OUTGOING_EVENTS;
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
@@ -503,7 +528,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type);
-	if (!mask)
+	if (!(mask & FANOTIFY_OUTGOING_EVENTS))
 		return 0;
 
 	pr_debug("%s: group=%p inode=%p mask=%x\n", __func__, group, inode,
-- 
2.17.1

