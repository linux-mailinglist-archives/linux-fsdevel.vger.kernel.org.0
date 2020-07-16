Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB31221EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGPInK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGPInF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF9C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so10624436wmi.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r2qIPpe5/tmuFWIi0AmxdIUWuXImXcUu5bhQigOj0Tk=;
        b=POfKevVXqdOqFQWrr/izQHSv4Da/sFPQ6M2emHjCdRj2qHOh02vIaGvPgXPgwjibBi
         AOSSr6otsQJVGqxWPLKT+To+OWKebapC2gnwBGThIzHbJdJ7yd75s5Q+KKRpVPi7v3qY
         Sc+aWCA6n8thVSgpCCTaeP03kb0HyiSWUY2hT0PSeJvxJtMk0CaaBIMO7NxSRbVol/gP
         jLOgtMe/f9N2y1FG1FwN1SkDTO06QPvecipvwyXT7x2hck8b2F26oxOscH/jS5mrfI0P
         UE6y+G1daajpM6V+1O9wssVYje+wJ07B07counC6WPOmulbwfUoAup51LLvviAYvSZFB
         oOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2qIPpe5/tmuFWIi0AmxdIUWuXImXcUu5bhQigOj0Tk=;
        b=nlu7c4OAJdNdjXmpQgIstdx8kuic9QdTBOlyyLc1DyUBwpYyyxUb0JUxnM/CYgJifT
         Kj9iyrbBYhw1fWUC647dKStgVelvmAeO2fvGtII0ja+QMUrtQfIjEQjpt6Cau8MDgNEa
         caQKCgZqOpDpzB1ufNtIb4QqS/2CycmgV00Ba0i9D73fYIGI73/kTp3lYG8FXIWH8VLK
         2OXm/gTdBP24s//4ybtXf8Dcfu2K8mQwLy0TK76eeAg4cpvEnoXgrinxvL0s7weGjhIx
         rCWNjDEjsQinmgu5Y7g+6OzMCrwkxXnfELmst93V4EEheuASg0kU7tGXN9OMEH8GtIy6
         U2zg==
X-Gm-Message-State: AOAM532pzkrwy5/gQZWHLta8bveAegZcZ+rRDxUmmTIEjCIQW89fTN8q
        s4w/NzPRYLe6D448dt586ZEgS0N2
X-Google-Smtp-Source: ABdhPJxB6gLuFJTC2BSWuqOLl3W6LPjbeUC586TbZ5HIr9eck59yyuKO6OA0I7d/UzvIQzea1odH/g==
X-Received: by 2002:a1c:6246:: with SMTP id w67mr3275188wmb.42.1594888984110;
        Thu, 16 Jul 2020 01:43:04 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:43:03 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 20/22] fanotify: add support for FAN_REPORT_NAME
Date:   Thu, 16 Jul 2020 11:42:28 +0300
Message-Id: <20200716084230.30611-21-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new fanotify_init() flag FAN_REPORT_NAME.  It requires the
flag FAN_REPORT_DIR_FID and there is a constant for setting both flags
named FAN_REPORT_DFID_NAME.

For a group with flag FAN_REPORT_NAME, the parent fid and name are
reported for directory entry modification events (create/detete/move)
and for events on non-directory objects.

Events on directories themselves are reported with their own fid and
"." as the name.

The parent fid and name are reported with an info record of type
FAN_EVENT_INFO_TYPE_DFID_NAME, similar to the way that parent fid is
reported with into type FAN_EVENT_INFO_TYPE_DFID, but with an appended
null terminated name string.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 18 +++++++++++-
 fs/notify/fanotify/fanotify_user.c | 45 ++++++++++++++++++++++++------
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  4 +++
 4 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 09331b0acaf2..c77b37eb33a9 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -523,9 +523,25 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	bool name_event = false;
 
-	if ((fid_mode & FAN_REPORT_DIR_FID) && dir)
+	if ((fid_mode & FAN_REPORT_DIR_FID) && dir) {
 		id = fanotify_dfid_inode(mask, data, data_type, dir);
 
+		/*
+		 * We record file name only in a group with FAN_REPORT_NAME
+		 * and when we have a directory inode to report.
+		 *
+		 * For directory entry modification event, we record the fid of
+		 * the directory and the name of the modified entry.
+		 *
+		 * For event on non-directory that is reported to parent, we
+		 * record the fid of the parent and the name of the child.
+		 */
+		if ((fid_mode & FAN_REPORT_NAME) &&
+		    ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
+		     !(mask & FAN_ONDIR)))
+			name_event = true;
+	}
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 7caa64d028ba..6b839790cb42 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -64,18 +64,27 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
 }
 
-static int fanotify_event_info_len(struct fanotify_event *event)
+static int fanotify_event_info_len(unsigned int fid_mode,
+				   struct fanotify_event *event)
 {
 	struct fanotify_info *info = fanotify_event_info(event);
 	int dir_fh_len = fanotify_event_dir_fh_len(event);
 	int fh_len = fanotify_event_object_fh_len(event);
 	int info_len = 0;
+	int dot_len = 0;
 
-	if (dir_fh_len)
+	if (dir_fh_len) {
 		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
+	} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
+		/*
+		 * With group flag FAN_REPORT_NAME, if name was not recorded in
+		 * event on a directory, we will report the name ".".
+		 */
+		dot_len = 1;
+	}
 
 	if (fh_len)
-		info_len += fanotify_fid_info_len(fh_len, 0);
+		info_len += fanotify_fid_info_len(fh_len, dot_len);
 
 	return info_len;
 }
@@ -91,6 +100,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 {
 	size_t event_size = FAN_EVENT_METADATA_LEN;
 	struct fanotify_event *event = NULL;
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 
 	pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
 
@@ -98,8 +108,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	if (fsnotify_notify_queue_is_empty(group))
 		goto out;
 
-	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
-		event_size += fanotify_event_info_len(
+	if (fid_mode) {
+		event_size += fanotify_event_info_len(fid_mode,
 			FANOTIFY_E(fsnotify_peek_first_event(group)));
 	}
 
@@ -325,7 +335,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
 	metadata.event_len = FAN_EVENT_METADATA_LEN +
-					fanotify_event_info_len(event);
+				fanotify_event_info_len(fid_mode, event);
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
@@ -374,12 +384,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	}
 
 	if (fanotify_event_object_fh_len(event)) {
+		const char *dot = NULL;
+		int dot_len = 0;
+
 		if (fid_mode == FAN_REPORT_FID || info_type) {
 			/*
 			 * With only group flag FAN_REPORT_FID only type FID is
 			 * reported. Second info record type is always FID.
 			 */
 			info_type = FAN_EVENT_INFO_TYPE_FID;
+		} else if ((fid_mode & FAN_REPORT_NAME) &&
+			   (event->mask & FAN_ONDIR)) {
+			/*
+			 * With group flag FAN_REPORT_NAME, if name was not
+			 * recorded in an event on a directory, report the
+			 * name "." with info type DFID_NAME.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
+			dot = ".";
+			dot_len = 1;
 		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
 			   (event->mask & FAN_ONDIR)) {
 			/*
@@ -400,7 +423,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 		ret = copy_info_to_user(fanotify_event_fsid(event),
 					fanotify_event_object_fh(event),
-					info_type, NULL, 0, buf, count);
+					info_type, dot, dot_len, buf, count);
 		if (ret < 0)
 			return ret;
 
@@ -932,11 +955,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (fid_mode && class != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
-	/* Reporting either object fid or dir fid */
+	/*
+	 * Reporting either object fid or dir fid.
+	 * Child name is reported with parent fid so requires dir fid.
+	 */
 	switch (fid_mode) {
 	case 0:
 	case FAN_REPORT_FID:
 	case FAN_REPORT_DIR_FID:
+	case FAN_REPORT_DFID_NAME:
 		break;
 	default:
 		return -EINVAL;
@@ -1294,7 +1321,7 @@ COMPAT_SYSCALL_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 9);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4ddac97b2bf7..3e9c56ee651f 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -18,7 +18,7 @@
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
 				 FAN_CLASS_PRE_CONTENT)
 
-#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DIR_FID)
+#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
 				 FAN_REPORT_TID | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 21afebf77fd7..fbf9c5c7dd59 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -54,6 +54,10 @@
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
+#define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+
+/* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
+#define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.17.1

