Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6601612F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgBQNP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:28 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37660 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgBQNP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:26 -0500
Received: by mail-wm1-f51.google.com with SMTP id a6so18438484wme.2;
        Mon, 17 Feb 2020 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8F0CX6it1nL7U9hvMyLSspSI86vC4vkI7nzEDH4dLio=;
        b=SStQvpfjFS/G/sZ1jYT5Zy631Hp06tAKeQu42LY4NUG5rkO7AZefVmtdjd1o/QFiSD
         Oz1Bt5YXrrzntwQxdcIIT3Fyx1vY4Oki3tAp1PNik+xwiA1LWvX9uqlAuTCdbhYSY0iY
         jQ7sNwKRLELgNy3uEz7BANyO6YnqEgEXCPlBvT6Wm11Q6PSoIHH1IO79a5q18IYx62rS
         9IeTp51XsEDDOg3P1AodbQx0MVC8m0QMO0vfaks7uwuDMbVd2qvUCjMEbau+FM8Ip8Gp
         VxrD4ptaRm3meTpiBp2HcHXrfe7FuycL9oK+SHIUzhM2RT8S65JG7d8iogYd6e+cnXWl
         mZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8F0CX6it1nL7U9hvMyLSspSI86vC4vkI7nzEDH4dLio=;
        b=Vsw7RVxyZA01fcsnj48ODfxstUYaYA6eGX0MtytGtmdvBTMvGtw70bcHdJleTNZ53B
         ERD7tOEHN0wR2lI+GN607qOZsEyvccXblA+AUdxOID7UrR1beBRFJ7P18RJbM7mP6qzG
         TI2m+Gdq4ozYz9CTAT0mBJdsXdgephBJ8x/JORL/bHIokOK5puZHfQQV7zdtu7ex9VLE
         GCKHERuZLPKe/lp6UNWSoJTH3rjDF7J0mnBS+ollY6nb27RNGJqjNqNEiZBwC79ZozZj
         /6ZTsIM8IMYl5mJGUccaSTl9Z9xRJUBntLIjh2UZ6gylt4j26Q2a9n90+LLPw4l7ZvX6
         M7KQ==
X-Gm-Message-State: APjAAAXHrcvZJtskV+tfdpIXFHU2PUiNz3I9bpoLfulSaTEMr/vTtosF
        yrXd6omdlMl0OnRsRBfH3R84krtW
X-Google-Smtp-Source: APXvYqwWDykXdOOvHNRbvLMYrCiHlGu16fI+ZwqQO3AUpU7auFal6T1OSRhkzaIsYbHbXIfYXyULRQ==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr21419112wmb.76.1581945324455;
        Mon, 17 Feb 2020 05:15:24 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:23 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 14/16] fanotify: report parent fid + name with FAN_REPORT_NAME
Date:   Mon, 17 Feb 2020 15:14:53 +0200
Message-Id: <20200217131455.31107-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a group with fanotify_init() flag FAN_REPORT_NAME, we report the
parent fid and name for events possible "on child" (e.g. FAN_MODIFY)
in addition to reporting the child fid.

The flag FAN_REPORT_NAME requires the flag FAN_REPORT_FID and there is
a constant for setting both flags named FAN_REPORT_FID_NAME.

The parent fid and name are reported with an info record of type
FAN_EVENT_INFO_TYPE_DFID_NAME, similar to the way that name info is
reported for FAN_DIR_MODIFY events.

The child fid is reported with another info record of type
FAN_EVENT_INFO_TYPE_FID that follows the first info record, with the
same fid info that is reported to a group with FAN_REPORT_FID flag.

Events with name are reported the same way when reported to sb, mount
or inode marks and when reported to a directory watching children.

Events not possible "on child" (e.g. FAN_DELETE_SELF) are reported
with a single FAN_EVENT_INFO_TYPE_FID record, same as they are reported
to a group with FAN_REPORT_FID flag.

If parent is unknown (dentry is disconnected) or parent is not on the
same filesystem as child (dentry is sb root), event is also reported
with a single FAN_EVENT_INFO_TYPE_FID record.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 25 +++++++++++++++++++++++--
 fs/notify/fanotify/fanotify_user.c |  6 +++++-
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  4 ++++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b651c18d3a93..43c338a8a2f1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -302,6 +302,8 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct dentry *dentry = fsnotify_data_dentry(data, data_type);
+	struct dentry *parent = NULL;
+	struct name_snapshot child_name;
 	struct inode *dir = NULL;
 
 	/*
@@ -339,17 +341,32 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	/*
 	 * For FAN_DIR_MODIFY event, we report the fid of the directory and
 	 * the name of the modified entry.
+	 * With flag FAN_REPORT_NAME, we report the parent fid and name for
+	 * events possible "on child" in addition to reporting the child fid.
+	 * If parent is unknown (dentry is disconnected) or parent is not on the
+	 * same filesystem as child (dentry is sb root), only "child" fid is
+	 * reported. Events are reported the same way when reported to sb, mount
+	 * or inode marks and when reported to a directory watching children.
 	 * Allocate an fanotify_name_event struct and copy the name.
 	 */
 	if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
-		char *name = NULL;
-
 		/*
 		 * Make sure that fanotify_event_has_name() is true and that
 		 * fanotify_event_has_fid() is false for FAN_DIR_MODIFY events.
 		 */
 		id = NULL;
 		dir = inode;
+	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_NAME) &&
+		   mask & FS_EVENTS_POSS_ON_CHILD &&
+		   likely(dentry && !IS_ROOT(dentry))) {
+		parent = dget_parent(dentry);
+		dir = d_inode(parent);
+		take_dentry_name_snapshot(&child_name, dentry);
+		file_name = &child_name.name;
+	}
+	if (dir) {
+		char *name = NULL;
+
 		if (file_name->len + 1 > FANOTIFY_INLINE_NAME_LEN) {
 			name = kmalloc(file_name->len + 1, gfp);
 			if (!name)
@@ -409,6 +426,10 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event->path.dentry = NULL;
 	}
 out:
+	if (parent) {
+		dput(parent);
+		release_dentry_name_snapshot(&child_name);
+	}
 	memalloc_unuse_memcg();
 	return event;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a1bafc21ebbb..5d369aa5d1bc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -875,6 +875,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (flags & FANOTIFY_CLASS_BITS) != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
+	/* Child name is reported with partent fid */
+	if ((flags & FAN_REPORT_NAME) && !(flags & FAN_REPORT_FID))
+		return -EINVAL;
+
 	user = get_current_user();
 	if (atomic_read(&user->fanotify_listeners) > FANOTIFY_DEFAULT_MAX_LISTENERS) {
 		free_uid(user);
@@ -1210,7 +1214,7 @@ COMPAT_SYSCALL_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 8);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 9);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3049a6c06d9e..5412a25c54c0 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -19,7 +19,7 @@
 				 FAN_CLASS_PRE_CONTENT)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | \
-				 FAN_REPORT_TID | FAN_REPORT_FID | \
+				 FAN_REPORT_TID | FAN_REPORT_FID_NAME | \
 				 FAN_CLOEXEC | FAN_NONBLOCK | \
 				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 2b56e194b858..04181769bb50 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -54,6 +54,10 @@
 /* Flags to determine fanotify event format */
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
+#define FAN_REPORT_NAME		0x00000400	/* Report events with name */
+
+/* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_FID */
+#define FAN_REPORT_FID_NAME	(FAN_REPORT_FID | FAN_REPORT_NAME)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.17.1

