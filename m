Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6D2123E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgGBM6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgGBM6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212F6C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so28136426wrj.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47f5Fg2bDjO/xlYwJFWq7A2i6hl0RqTjNnaFtsB10EA=;
        b=cv4AmCzcgOAkfgKXe+ZPGLzTPxsHeb1levt1bQqBekgqsE0Trpfw41Aya6WtT4obc9
         GWiBk51WAg13Ab5Pq47ebiJq+W5O6d95pkTaP6yvJJXIjnU3QwRqSdwuWMwB3ejzdWga
         p8zEwCjTa6emrcuRz6+2fgGG4drBg7gbbaqYCEm1Nwx3HO8ZT2SVaR+VCuYjsVA2SAnS
         yRupnSbkvdw4HkYo9kw7eEvo27uXJXI4apRIqR+WPdINxRhZVZrkucykgpza1moTeE29
         tW+tmZczrlTUzIjuPbvkt+vHouRA9lDQ9awmtGFFSn81OC1FUfVwzf0NpJqWcSzaZJmv
         i/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47f5Fg2bDjO/xlYwJFWq7A2i6hl0RqTjNnaFtsB10EA=;
        b=XmkicsIIi1YWukR1uFnvYh1m3t+ViNbzwY7m2/1SUmwJA55hwoGwLhtG0xaEjl9XZk
         0l/7ZhwSXw6S0O++WHDpHZCOg1d/hZjX52VYTx+Ls/Ac83S0iAauBy/Bb+hGeTDYhHxY
         /tXO26cj5g8TVGJ0OoGsB54IeShaFao6lERwJRKf3u3FuQtwdFDO9ACo+/nWTB/urnML
         TG542+/x5lW0bfLSUXDP93WcoXtPCnJNsarrIy8imvqI1fwqE9j6BDH9UMdOGgsvfR0S
         c4f1au9Rhdl+01SqLArhKIwPmRXpa4dIVcEIkg8SEd2slz3hDcVWSdMFCIS08i/Evyo2
         8dZw==
X-Gm-Message-State: AOAM530TJTq/pNlf5zun2qedZmpWId3zdrgaeKObdOxDjP1N/0z5TXgk
        HapeUzpnZ7cuOcaE4ZDTtw87Dbvz
X-Google-Smtp-Source: ABdhPJy5OBZWhknBFfc05yiFDyl5Uf1sxE9z205M52yqb/zVxu0IrEhw2XgJNCu68C+BfOKthb0gWA==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr27835766wru.220.1593694682796;
        Thu, 02 Jul 2020 05:58:02 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:58:02 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 06/10] fanotify: add basic support for FAN_REPORT_DIR_FID
Date:   Thu,  2 Jul 2020 15:57:40 +0300
Message-Id: <20200702125744.10535-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify_user.c | 69 ++++++++++++++++++++++++++----
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      | 11 +++--
 4 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7f40b8f57934..23fb1bfb6945 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -206,7 +206,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
 static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct fsnotify_iter_info *iter_info,
 				     u32 event_mask, const void *data,
-				     int data_type)
+				     int data_type, struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
@@ -226,6 +226,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		/* Path type events are only relevant for files and dirs */
 		if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
 			return 0;
+	} else if (!(fid_mode & FAN_REPORT_FID)) {
+		/* Do we have a directory inode to report? */
+		if (!dir)
+			return 0;
 	}
 
 	fsnotify_foreach_obj_type(type) {
@@ -375,6 +379,28 @@ static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
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
 struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 						 gfp_t gfp)
 {
@@ -470,6 +496,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	bool name_event = false;
 
+	if ((fid_mode & FAN_REPORT_DIR_FID) && dir)
+		id = fanotify_dfid_inode(mask, data, data_type, dir);
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
@@ -580,7 +609,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
-					 data_type);
+					 data_type, dir);
 	if (!mask)
 		return 0;
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index af8268b44c68..fe2c25e26753 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -215,7 +215,7 @@ static int process_access_response(struct fsnotify_group *group,
 }
 
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
-			     const char *name, size_t name_len,
+			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
@@ -238,8 +238,21 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
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
+		if (WARN_ON_ONCE(!name_len))
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
@@ -303,8 +316,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct fanotify_event_metadata metadata;
 	struct path *path = fanotify_event_path(event);
 	struct fanotify_fh *dfh = fanotify_event_dir_fh(event);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct file *f = NULL;
 	int ret, fd = FAN_NOFD;
+	int info_type = 0;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -345,8 +360,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	/* Event info records order is: dir fid + name, child fid */
 	if (dfh) {
+		info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
 		ret = copy_info_to_user(fanotify_event_fsid(event), dfh,
-					fanotify_fh_name(dfh),
+					info_type, fanotify_fh_name(dfh),
 					dfh->name_len, buf, count);
 		if (ret < 0)
 			return ret;
@@ -356,9 +372,33 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
 
@@ -854,6 +894,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	struct fsnotify_group *group;
 	int f_flags, fd;
 	struct user_struct *user;
+	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
+	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -880,10 +922,19 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
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
@@ -919,7 +970,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->fanotify_data.f_flags = event_f_flags;
 	init_waitqueue_head(&group->fanotify_data.access_waitq);
 	INIT_LIST_HEAD(&group->fanotify_data.access_list);
-	switch (flags & FANOTIFY_CLASS_BITS) {
+	switch (class) {
 	case FAN_CLASS_NOTIF:
 		group->priority = FS_PRIO_0;
 		break;
@@ -1229,7 +1280,7 @@ COMPAT_SYSCALL_DEFINE6(fanotify_mark,
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

