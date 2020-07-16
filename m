Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C4221EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGPInF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgGPInD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E69C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so9422027wmh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnud4Xl7WkQXgoOhZ/+QvdEzXuyAhadoSpKQk8BvgHA=;
        b=jF1vnyS8k3C3Ab+lgsKPTqAQdLGvp0t002ysPZYJoTt72zmRazMxPTJiNKLYDoKV8E
         3xY27msVu7FAFk4ilJ8Jl0c2pYQTktlAuSuC1XjYnVNS0hySnfkLuMHjrV4MXPfh0Use
         KlW7ij+XeuyBX1dvmFF5AYItZ9acJmDs1J0Pv/81py+163O7f5T4dRKsBr/WirP7nto7
         fOjaXx1o5XU/RxoMvtJ2vAHsstttfK/q7rWC1t8g8NPiejOw/J/OPWfO6bq1Hmnd8SEy
         PLVG9QEyWfLTbiQnaoxnfDcwGRTL2ncDghgVaBpxxnmH3gbuQ+yRO9dP15/HWPlC5VzO
         M35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dnud4Xl7WkQXgoOhZ/+QvdEzXuyAhadoSpKQk8BvgHA=;
        b=LlDajYlN3vqIDblBiLWJSBfXJszhqsdl8m5zthl4ayfphSPNhYYsy3rb65E8eyhsAm
         AhSYznW88i37iMTwc6NX4vIYit9ILrcQL05JAqLUdAUjtUYZXVZIKbnmcklHUOYZB1VK
         0yukFlMy7A2uQResQJGLM9iqbL4UFi/DDAXWUJKNy7/fR+VNZaTYEFUyUfsHjYHTfVTl
         YYgmZGgktnK++nkez0TIXPWZSpCUqiM6mFpH4gh88HALeGBb3UQ1moYYDsKyW51nm/zY
         0VHwJ8VRquAEkscsFOkIpEPIRzmb6WES0mkd1+EW/XHZTY1V9t1hHMBx8XgVNSBh0pZN
         mlug==
X-Gm-Message-State: AOAM532gHlORd8JYZ1NKmnfuaQl+r772b6ZxAq8vx2ukNRTYLC4v3AYY
        dL3i3rit3QbcfUmNtj/BcQU=
X-Google-Smtp-Source: ABdhPJwo/ShUiEFsysHbAiFvqGP0lfq2ahNhAkMCke8oJlCSSHDGvXdUIcDjnPRj8sDyxXNfRGVl7A==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr3300677wmf.124.1594888981377;
        Thu, 16 Jul 2020 01:43:01 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:43:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 18/22] fanotify: add basic support for FAN_REPORT_DIR_FID
Date:   Thu, 16 Jul 2020 11:42:26 +0300
Message-Id: <20200716084230.30611-19-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, the flag is mutually exclusive with FAN_REPORT_FID.
Events include a single info record of type FAN_EVENT_INFO_TYPE_DFID
with a directory file handle.

For now, events are only reported for:
- Directory modification events
- Events on children of a watching directory
- Events on directory objects

Soon, we will add support for reporting the parent directory fid
for events on non-directories with filesystem/mount mark and
support for reporting both parent directory fid and child fid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 33 +++++++++++++-
 fs/notify/fanotify/fanotify_user.c | 71 +++++++++++++++++++++++++-----
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      | 11 +++--
 4 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1ec760960c93..4cbdb40e0d54 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -223,7 +223,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
 static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct fsnotify_iter_info *iter_info,
 				     u32 event_mask, const void *data,
-				     int data_type)
+				     int data_type, struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
@@ -243,6 +243,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		/* Path type events are only relevant for files and dirs */
 		if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
 			return 0;
+	} else if (!(fid_mode & FAN_REPORT_FID)) {
+		/* Do we have a directory inode to report? */
+		if (!dir)
+			return 0;
 	}
 
 	fsnotify_foreach_obj_type(type) {
@@ -399,6 +403,28 @@ static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
 	return fsnotify_data_inode(data, data_type);
 }
 
+/*
+ * The inode to use as identifier when reporting dir fid depends on the event.
+ * Report the modified directory inode on dirent modification events.
+ * Report the "victim" inode if "victim" is a directory.
+ * Report the parent inode if "victim" is not a directory and event is
+ * reported to parent.
+ * Otherwise, do not report dir fid.
+ */
+static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
+					 int data_type, struct inode *dir)
+{
+	struct inode *inode = fsnotify_data_inode(data, data_type);
+
+	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+		return dir;
+
+	if (S_ISDIR(inode->i_mode))
+		return inode;
+
+	return dir;
+}
+
 static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 							gfp_t gfp)
 {
@@ -498,6 +524,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	bool name_event = false;
 
+	if ((fid_mode & FAN_REPORT_DIR_FID) && dir)
+		id = fanotify_dfid_inode(mask, data, data_type, dir);
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
@@ -608,7 +637,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
-					 data_type);
+					 data_type, dir);
 	if (!mask)
 		return 0;
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3842ef00b52e..e494400711c9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -216,7 +216,7 @@ static int process_access_response(struct fsnotify_group *group,
 }
 
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
-			     const char *name, size_t name_len,
+			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
@@ -229,7 +229,7 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
 		 __func__, fh_len, name_len, info_len, count);
 
-	if (!fh_len || (name && !name_len))
+	if (!fh_len)
 		return 0;
 
 	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
@@ -239,8 +239,21 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	 * Copy event info fid header followed by variable sized file handle
 	 * and optionally followed by variable sized filename.
 	 */
-	info.hdr.info_type = name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
-					FAN_EVENT_INFO_TYPE_FID;
+	switch (info_type) {
+	case FAN_EVENT_INFO_TYPE_FID:
+	case FAN_EVENT_INFO_TYPE_DFID:
+		if (WARN_ON_ONCE(name_len))
+			return -EFAULT;
+		break;
+	case FAN_EVENT_INFO_TYPE_DFID_NAME:
+		if (WARN_ON_ONCE(!name || !name_len))
+			return -EFAULT;
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	info.hdr.info_type = info_type;
 	info.hdr.len = len;
 	info.fsid = *fsid;
 	if (copy_to_user(buf, &info, sizeof(info)))
@@ -304,8 +317,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct fanotify_event_metadata metadata;
 	struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct file *f = NULL;
 	int ret, fd = FAN_NOFD;
+	int info_type = 0;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -346,9 +361,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	/* Event info records order is: dir fid + name, child fid */
 	if (fanotify_event_dir_fh_len(event)) {
+		info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
 		ret = copy_info_to_user(fanotify_event_fsid(event),
 					fanotify_info_dir_fh(info),
-					fanotify_info_name(info),
+					info_type, fanotify_info_name(info),
 					info->name_len, buf, count);
 		if (ret < 0)
 			return ret;
@@ -358,9 +374,33 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	}
 
 	if (fanotify_event_object_fh_len(event)) {
+		if (fid_mode == FAN_REPORT_FID || info_type) {
+			/*
+			 * With only group flag FAN_REPORT_FID only type FID is
+			 * reported. Second info record type is always FID.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_FID;
+		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
+			   (event->mask & FAN_ONDIR)) {
+			/*
+			 * With group flag FAN_REPORT_DIR_FID, a single info
+			 * record has type DFID for directory entry modification
+			 * event and for event on a directory.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_DFID;
+		} else {
+			/*
+			 * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
+			 * a single info record has type FID for event on a
+			 * non-directory, when there is no directory to report.
+			 * For example, on FAN_DELETE_SELF event.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_FID;
+		}
+
 		ret = copy_info_to_user(fanotify_event_fsid(event),
 					fanotify_event_object_fh(event),
-					NULL, 0, buf, count);
+					info_type, NULL, 0, buf, count);
 		if (ret < 0)
 			return ret;
 
@@ -861,6 +901,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	struct fsnotify_group *group;
 	int f_flags, fd;
 	struct user_struct *user;
+	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
+	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -887,10 +929,19 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EINVAL;
 	}
 
-	if ((flags & FANOTIFY_FID_BITS) &&
-	    (flags & FANOTIFY_CLASS_BITS) != FAN_CLASS_NOTIF)
+	if (fid_mode && class != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
+	/* Reporting either object fid or dir fid */
+	switch (fid_mode) {
+	case 0:
+	case FAN_REPORT_FID:
+	case FAN_REPORT_DIR_FID:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	user = get_current_user();
 	if (atomic_read(&user->fanotify_listeners) > FANOTIFY_DEFAULT_MAX_LISTENERS) {
 		free_uid(user);
@@ -926,7 +977,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->fanotify_data.f_flags = event_f_flags;
 	init_waitqueue_head(&group->fanotify_data.access_waitq);
 	INIT_LIST_HEAD(&group->fanotify_data.access_list);
-	switch (flags & FANOTIFY_CLASS_BITS) {
+	switch (class) {
 	case FAN_CLASS_NOTIF:
 		group->priority = FS_PRIO_0;
 		break;
@@ -1236,7 +1287,7 @@ COMPAT_SYSCALL_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 8);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 9);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index bbbee11d2521..4ddac97b2bf7 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -18,7 +18,7 @@
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
 				 FAN_CLASS_PRE_CONTENT)
 
-#define FANOTIFY_FID_BITS	(FAN_REPORT_FID)
+#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DIR_FID)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
 				 FAN_REPORT_TID | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 7f2f17eacbf9..21afebf77fd7 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -53,6 +53,7 @@
 /* Flags to determine fanotify event format */
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
+#define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
@@ -117,6 +118,7 @@ struct fanotify_event_metadata {
 
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
+#define FAN_EVENT_INFO_TYPE_DFID	3
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -126,10 +128,11 @@ struct fanotify_event_info_header {
 };
 
 /*
- * Unique file identifier info record. This is used both for
- * FAN_EVENT_INFO_TYPE_FID records and for FAN_EVENT_INFO_TYPE_DFID_NAME
- * records. For FAN_EVENT_INFO_TYPE_DFID_NAME there is additionally a null
- * terminated name immediately after the file handle.
+ * Unique file identifier info record.
+ * This structure is used for records of types FAN_EVENT_INFO_TYPE_FID,
+ * FAN_EVENT_INFO_TYPE_DFID and FAN_EVENT_INFO_TYPE_DFID_NAME.
+ * For FAN_EVENT_INFO_TYPE_DFID_NAME there is additionally a null terminated
+ * name immediately after the file handle.
  */
 struct fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
-- 
2.17.1

