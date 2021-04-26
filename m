Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21536B94B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhDZSpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbhDZSnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8DC06138B;
        Mon, 26 Apr 2021 11:43:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 671E21F422D9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 12/15] fanotify: Introduce the FAN_ERROR mark
Date:   Mon, 26 Apr 2021 14:41:58 -0400
Message-Id: <20210426184201.4177978-13-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The FAN_ERROR mark is used by filesystem wide monitoring tools to
receive notifications of type FS_ERROR_EVENT, emited by filesystems when
a problem is detected.  The error notification includes a generic error
descriptor, an optional location record and a filesystem specific blob.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c      | 48 +++++++++++++++++++----
 fs/notify/fanotify/fanotify.h      |  8 ++++
 fs/notify/fanotify/fanotify_user.c | 63 ++++++++++++++++++++++++++++++
 include/linux/fanotify.h           |  9 ++++-
 include/uapi/linux/fanotify.h      |  2 +
 5 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 98591a8155a7..6bae23d42e5e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -240,12 +240,14 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
 	if (!fid_mode) {
-		/* Do we have path to open a file descriptor? */
-		if (!path)
-			return 0;
-		/* Path type events are only relevant for files and dirs */
-		if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
-			return 0;
+		if (!fanotify_is_error_event(event_mask)) {
+			/* Do we have path to open a file descriptor? */
+			if (!path)
+				return 0;
+			/* Path type events are only relevant for files and dirs */
+			if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
+				return 0;
+		}
 	} else if (!(fid_mode & FAN_REPORT_FID)) {
 		/* Do we have a directory inode to report? */
 		if (!dir && !(event_mask & FS_ISDIR))
@@ -458,6 +460,25 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	return &pevent->fae;
 }
 
+static void fanotify_init_error_event(struct fanotify_event *fae,
+				      const struct fs_error_report *report,
+				      __kernel_fsid_t *fsid)
+{
+	struct fanotify_error_event *fee;
+
+	fae->type = FANOTIFY_EVENT_TYPE_ERROR;
+	fee = FANOTIFY_EE(fae);
+	fee->error = report->error;
+	fee->fsid = *fsid;
+
+	fee->loc.line = report->line;
+	fee->loc.function = report->function;
+
+	fee->fs_data_size = report->fs_data_size;
+
+	memcpy(&fee->fs_data, report->fs_data, report->fs_data_size);
+}
+
 static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 						       __kernel_fsid_t *fsid,
 						       gfp_t gfp)
@@ -618,6 +639,13 @@ static struct fanotify_event *fanotify_ring_get_slot(struct fsnotify_group *grou
 {
 	size_t size = 0;
 
+	if (fanotify_is_error_event(mask)) {
+		const struct fs_error_report *report = data;
+		size = sizeof(struct fanotify_error_event) + report->fs_data_size;
+	} else {
+		return ERR_PTR(-EINVAL);
+	}
+
 	pr_debug("%s: group=%p mask=%x size=%lu\n", __func__, group, mask, size);
 
 	return FANOTIFY_E(fsnotify_ring_alloc_event_slot(group, size));
@@ -629,6 +657,9 @@ static void fanotify_ring_write_event(struct fsnotify_group *group,
 {
 	fanotify_init_event(group, event, 0, mask);
 
+	if (fanotify_is_error_event(mask))
+		fanotify_init_error_event(event, data, fsid);
+
 	event->pid = get_pid(task_tgid(current));
 }
 
@@ -695,8 +726,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
+	BUILD_BUG_ON(FAN_ERROR != FS_ERROR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type, dir);
@@ -714,7 +746,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS) || mask == FAN_ERROR) {
 		fsid = fanotify_get_fsid(iter_info);
 		/* Racing with mark destruction or creation? */
 		if (!fsid.val[0] && !fsid.val[1])
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 0d1b4cb8b005..097667be9079 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -135,6 +135,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_ERROR,
 };
 
 struct fanotify_event {
@@ -207,6 +208,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 		return &FANOTIFY_FE(event)->fsid;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return &FANOTIFY_NE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_ERROR)
+		return &FANOTIFY_EE(event)->fsid;
 	else
 		return NULL;
 }
@@ -292,6 +295,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct fanotify_event, fse);
 }
 
+static inline bool fanotify_is_error_event(u32 mask)
+{
+	return mask & FANOTIFY_ERROR_EVENTS;
+}
+
 static inline bool fanotify_event_has_path(struct fanotify_event *event)
 {
 	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e2f4599dfc25..6270083bee36 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -96,6 +96,24 @@ static size_t fanotify_event_len(struct fanotify_event *event,
 	int fh_len;
 	int dot_len = 0;
 
+	if (fanotify_is_error_event(event->mask)) {
+		struct fanotify_error_event *fee = FANOTIFY_EE(event);
+		/*
+		 *  Error events (FAN_ERROR) have a different format
+		 *  as follows:
+		 * [ event_metadata            ]
+		 * [ fs-generic error header   ]
+		 * [ error location (optional) ]
+		 * [ fs-specific blob          ]
+		 */
+		event_len = fanotify_error_info_len(fee);
+		if (fee->loc.function)
+			event_len += fanotify_location_info_len(&fee->loc);
+		if (fee->fs_data)
+			event_len += fanotify_error_fsdata_len(fee);
+		return event_len;
+	}
+
 	if (!fid_mode)
 		return event_len;
 
@@ -322,6 +340,38 @@ static ssize_t copy_error_fsdata_info_to_user(struct fanotify_error_event *fee,
 	return info.hdr.len;
 }
 
+static int copy_error_event_to_user(struct fanotify_event *event,
+				    char __user *buf, int count)
+{
+	struct fanotify_error_event *fee = FANOTIFY_EE(event);
+	ssize_t len;
+	int original_count = count;
+
+	len = copy_error_info_to_user(fee, buf, count);
+	if (len < 0)
+		return -EFAULT;
+	buf += len;
+	count -= len;
+
+	if (fee->loc.function) {
+		len = copy_location_info_to_user(&fee->loc, buf, count);
+		if (len < 0)
+			return len;
+		buf += len;
+		count -= len;
+	}
+
+	if (fee->fs_data_size) {
+		len = copy_error_fsdata_info_to_user(fee, buf, count);
+		if (len < 0)
+			return len;
+		buf += len;
+		count -= len;
+	}
+
+	return original_count - count;
+}
+
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
@@ -528,6 +578,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		count -= ret;
 	}
 
+	if (fanotify_is_error_event(event->mask))
+		ret = copy_error_event_to_user(event, buf, count);
+
 	return metadata.event_len;
 
 out_close_fd:
@@ -1328,6 +1381,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    (mask & ~FANOTIFY_SUBMISSION_BUFFER_EVENTS))
 		goto fput_and_out;
 
+	if (fanotify_is_error_event(mask) &&
+	    !(group->flags & FSN_SUBMISSION_RING_BUFFER))
+		goto fput_and_out;
+
 	ret = fanotify_find_path(dfd, pathname, &path, flags,
 			(mask & ALL_FSNOTIFY_EVENTS), obj_type);
 	if (ret)
@@ -1350,6 +1407,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 
 		fsid = &__fsid;
 	}
+	if (mask & FAN_ERROR) {
+		ret = fanotify_check_path_fsid(&path, &__fsid);
+		if (ret)
+			goto path_put_and_out;
+		fsid = &__fsid;
+	}
 
 	/* inode held in place by reference to path; group by fget on fd */
 	if (mark_type == FAN_MARK_INODE)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 5a4cefb4b1c3..e08be5fae14a 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -56,9 +56,13 @@
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
 
+#define FANOTIFY_ERROR_EVENTS	(FAN_ERROR)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS)
+				 FANOTIFY_INODE_EVENTS | \
+				 FANOTIFY_ERROR_EVENTS)
+
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
@@ -70,9 +74,10 @@
 /* Events that may be reported to user */
 #define FANOTIFY_OUTGOING_EVENTS	(FANOTIFY_EVENTS | \
 					 FANOTIFY_PERM_EVENTS | \
+					 FANOTIFY_ERROR_EVENTS | \
 					 FAN_Q_OVERFLOW | FAN_ONDIR)
 
-#define FANOTIFY_SUBMISSION_BUFFER_EVENTS 0
+#define FANOTIFY_SUBMISSION_BUFFER_EVENTS FANOTIFY_ERROR_EVENTS
 
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 49808c857ee1..ee0ae8b1e20b 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,6 +25,8 @@
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 
+#define FAN_ERROR		0x00100000	/* Filesystem error */
+
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_ONDIR		0x40000000	/* Event occurred against dir */
-- 
2.31.0

