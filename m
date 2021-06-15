Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F013A8D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhFOX6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhFOX6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B0C06175F;
        Tue, 15 Jun 2021 16:56:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id AB2BF1F43342
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 11/14] fanotify: Introduce FAN_FS_ERROR event
Date:   Tue, 15 Jun 2021 19:55:53 -0400
Message-Id: <20210615235556.970928-12-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The FAN_FS_ERROR event is used by filesystem wide monitoring tools to
receive notifications of type FS_ERROR_EVENT, emited by filesystems when
a problem is detected.  The error notification includes a generic error
descriptor.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Pass dentry to fanotify_check_fsid (Amir)
  - FANOTIFY_EVENT_TYPE_ERROR -> FANOTIFY_EVENT_TYPE_FS_ERROR
  - Merge previous patch into it
  - Use a single slot
  - Move fanotify_mark.error_event definition to this commit
  - Rename FAN_ERROR -> FAN_FS_ERROR
  - Restrict FAN_FS_ERROR to FAN_MARK_FILESYSTEM
---
 fs/notify/fanotify/fanotify.c      | 115 ++++++++++++++++++++++--
 fs/notify/fanotify/fanotify.h      |  30 +++++++
 fs/notify/fanotify/fanotify_user.c | 137 ++++++++++++++++++++++++++---
 include/linux/fanotify.h           |   6 +-
 include/uapi/linux/fanotify.h      |  11 +++
 5 files changed, 281 insertions(+), 18 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index f64234489811..58b2dd01f1ae 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -247,6 +247,14 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	return ret;
 }
 
+static bool fanotify_event_reports_path(const struct fsnotify_group *group,
+					u32 mask)
+{
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+
+	return !fid_mode && !fanotify_is_error_event(mask);
+}
+
 /*
  * This function returns a mask for an event that only contains the flags
  * that have been specifically requested by the user. Flags that may have
@@ -261,7 +269,6 @@ static u32 fanotify_group_event_mask(
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
 				     FANOTIFY_EVENT_FLAGS;
-	const struct path *path = fsnotify_event_info_path(event_info);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
 	int type;
@@ -270,14 +277,17 @@ static u32 fanotify_group_event_mask(
 		 __func__, iter_info->report_mask, event_mask,
 		 event_info->data, event_info->data_type);
 
-	if (!fid_mode) {
+	if (fanotify_event_reports_path(group, event_mask)) {
+		const struct path *path;
+
 		/* Do we have path to open a file descriptor? */
+		path = fsnotify_event_info_path(event_info);
 		if (!path)
 			return 0;
 		/* Path type events are only relevant for files and dirs */
 		if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
 			return 0;
-	} else if (!(fid_mode & FAN_REPORT_FID)) {
+	} else if (fid_mode && !(fid_mode & FAN_REPORT_FID)) {
 		/* Do we have a directory inode to report? */
 		if (!event_info->dir && !(event_mask & FS_ISDIR))
 			return 0;
@@ -658,6 +668,78 @@ static struct fanotify_event *fanotify_alloc_event(
 	return event;
 }
 
+static void fanotify_init_error_event(struct fanotify_error_event *event,
+				      __kernel_fsid_t fsid,
+				      const struct fs_error_report *report)
+{
+	event->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	event->err_count = 1;
+	event->fsid = fsid;
+	event->error = report->error;
+	event->ino = (report->inode) ? report->inode->i_ino : 0;
+	event->ino_generation =
+		(report->inode) ? report->inode->i_generation : 0;
+}
+
+struct fanotify_insert_error_data {
+	const struct fs_error_report *report;
+	__kernel_fsid_t fsid;
+};
+
+static void fanotify_insert_error_event(struct fsnotify_group *group,
+					struct fsnotify_event *event,
+					const void *data)
+{
+	struct fanotify_event *fae = FANOTIFY_E(event);
+	struct fanotify_error_event *error_event = FANOTIFY_EE(fae);
+	const struct fanotify_insert_error_data *idata =
+		((struct fanotify_insert_error_data *) data);
+
+	fsnotify_get_mark(error_event->mark);
+	fanotify_init_error_event(error_event, idata->fsid, idata->report);
+}
+
+static int fanotify_merge_error_event(struct fsnotify_group *group,
+				      struct fsnotify_event *event)
+{
+	struct fanotify_event *fae = FANOTIFY_E(event);
+
+	if (!list_empty(&event->list)) {
+		FANOTIFY_EE(fae)->err_count++;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int fanotify_queue_error_event(struct fsnotify_iter_info *iter_info,
+				      struct fsnotify_group *group,
+				      __kernel_fsid_t fsid,
+				      const struct fs_error_report *report)
+{
+	struct fanotify_error_event *error_event;
+	struct fsnotify_mark *mark = fsnotify_iter_sb_mark(iter_info);
+	int ret = -ENOMEM;
+
+	if (!mark || !FANOTIFY_SB_MARK(mark)->error_event)
+		return ret;
+
+	spin_lock(&mark->lock);
+	error_event = FANOTIFY_SB_MARK(mark)->error_event;
+	if (error_event) {
+		ret = fsnotify_add_event(group, &error_event->fae.fse,
+					 fanotify_merge_error_event,
+					 fanotify_insert_error_event,
+					 &(struct fanotify_insert_error_data) {
+						 .fsid = fsid,
+						 .report = report
+					 });
+	}
+	spin_unlock(&mark->lock);
+
+	return ret;
+}
+
 /*
  * Get cached fsid of the filesystem containing the object from any connector.
  * All connectors are supposed to have the same fsid, but we do not verify that
@@ -738,8 +820,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
+	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, mask, event_info, iter_info);
 	if (!mask)
@@ -756,13 +839,20 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS) ||
+	    fanotify_is_error_event(mask)) {
 		fsid = fanotify_get_fsid(iter_info);
 		/* Racing with mark destruction or creation? */
 		if (!fsid.val[0] && !fsid.val[1])
 			return 0;
 	}
 
+	if (fanotify_is_error_event(mask)) {
+		ret = fanotify_queue_error_event(iter_info, group, fsid,
+						 event_info->data);
+		goto finish;
+	}
+
 	event = fanotify_alloc_event(group, mask, event_info, &fsid);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
@@ -831,6 +921,17 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 	kfree(FANOTIFY_NE(event));
 }
 
+static void fanotify_free_error_event(struct fanotify_event *event)
+{
+	/*
+	 * Just drop the reference acquired by
+	 * fanotify_queue_error_event.
+	 *
+	 * The actual memory is freed with the mark.
+	 */
+	fsnotify_put_mark(FANOTIFY_EE(event)->mark);
+}
+
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
@@ -853,6 +954,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	case FANOTIFY_EVENT_TYPE_OVERFLOW:
 		kfree(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		fanotify_free_error_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -870,6 +974,7 @@ static void fanotify_free_mark(struct fsnotify_mark *mark)
 	if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
 		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
 
+		kfree(fa_mark->error_event);
 		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
 	} else {
 		kmem_cache_free(fanotify_mark_cache, mark);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7e00c05a979a..882d056b3a7a 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -132,11 +132,14 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 
 struct fanotify_sb_mark {
 	struct fsnotify_mark fsn_mark;
+	struct fanotify_error_event *error_event;
 };
 
 static inline
 struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
 {
+	WARN_ON(!(mark->flags & FSNOTIFY_MARK_FLAG_SB));
+
 	return container_of(mark, struct fanotify_sb_mark, fsn_mark);
 }
 
@@ -152,6 +155,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -207,12 +211,32 @@ FANOTIFY_NE(struct fanotify_event *event)
 	return container_of(event, struct fanotify_name_event, fae);
 }
 
+struct fanotify_error_event {
+	struct fanotify_event fae;
+	s32 error;
+	u32 err_count;
+	__kernel_fsid_t fsid;
+	u64 ino;
+	u32 ino_generation;
+
+	/* Back reference to the mark this error refers to. */
+	struct fsnotify_mark *mark;
+};
+
+static inline struct fanotify_error_event *
+FANOTIFY_EE(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_error_event, fae);
+}
+
 static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->fsid;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return &FANOTIFY_NE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->fsid;
 	else
 		return NULL;
 }
@@ -298,6 +322,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
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
@@ -327,6 +356,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
 	return !(fanotify_is_perm_event(mask) ||
+		 fanotify_is_error_event(mask) ||
 		 fsnotify_is_overflow_event(mask));
 }
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index db378480f1b1..7ec99bec2746 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -107,6 +107,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
+#define FANOTIFY_INFO_ERROR_LEN \
+	(sizeof(struct fanotify_event_info_error))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -127,6 +129,9 @@ static size_t fanotify_event_len(struct fanotify_event *event,
 	int fh_len;
 	int dot_len = 0;
 
+	if (fanotify_is_error_event(event->mask))
+		return event_len + FANOTIFY_INFO_ERROR_LEN;
+
 	if (!fid_mode)
 		return event_len;
 
@@ -150,6 +155,35 @@ static size_t fanotify_event_len(struct fanotify_event *event,
 	return event_len;
 }
 
+static struct fanotify_event *fanotify_dequeue_error_event(
+					struct fsnotify_group *group,
+					struct fanotify_event *event,
+					struct fanotify_error_event *dest)
+{
+	struct fanotify_error_event *error_event = FANOTIFY_EE(event);
+
+	/*
+	 * In order to avoid missing an error count update, the
+	 * queued event is de-queued and duplicated to an
+	 * in-stack fanotify_error_event while still inside
+	 * mark->lock.  Once the event is dequeued, it can be
+	 * immediately re-used for a new event.
+	 *
+	 * The ownership of the mark reference is dropped later
+	 * by destroy_event.
+	 */
+	spin_lock(&error_event->mark->lock);
+
+	memcpy(dest, error_event, sizeof(*error_event));
+	fsnotify_init_event(&dest->fae.fse);
+
+	fsnotify_remove_queued_event(group, &event->fse);
+
+	spin_unlock(&error_event->mark->lock);
+
+	return &dest->fae;
+}
+
 /*
  * Remove an hashed event from merge hash table.
  */
@@ -173,8 +207,10 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
  * is not large enough. When permission event is dequeued, its state is
  * updated accordingly.
  */
-static struct fanotify_event *get_one_event(struct fsnotify_group *group,
-					    size_t count)
+static struct fanotify_event *get_one_event(
+				struct fsnotify_group *group,
+				size_t count,
+				struct fanotify_error_event *error_event)
 {
 	size_t event_size;
 	struct fanotify_event *event = NULL;
@@ -198,9 +234,14 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 
 	/*
 	 * Held the notification_lock the whole time, so this is the
-	 * same event we peeked above.
+	 * same event we peeked above, unless it is copied to
+	 * error_event.
 	 */
-	fsnotify_remove_first_event(group);
+	if (fanotify_is_error_event(event->mask))
+		event = fanotify_dequeue_error_event(group, event, error_event);
+	else
+		fsnotify_remove_first_event(group);
+
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
 	if (fanotify_is_hashed_event(event->mask))
@@ -310,6 +351,31 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
+static size_t copy_error_info_to_user(struct fanotify_event *event,
+				      char __user *buf, int count)
+{
+	struct fanotify_event_info_error info;
+	struct fanotify_error_event *fee = FANOTIFY_EE(event);
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
+	info.hdr.pad = 0;
+	info.hdr.len = sizeof(struct fanotify_event_info_error);
+
+	if (WARN_ON(count < info.hdr.len))
+		return -EFAULT;
+
+	info.fsid = fee->fsid;
+	info.error = fee->error;
+	info.ino = fee->ino;
+	info.ino_generation = fee->ino_generation;
+	info.error_count = fee->err_count;
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	return info.hdr.len;
+}
+
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
@@ -531,6 +597,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		count -= ret;
 	}
 
+	if (fanotify_is_error_event(event->mask)) {
+		ret = copy_error_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+	}
+
 	return metadata.event_len;
 
 out_close_fd:
@@ -559,6 +633,7 @@ static __poll_t fanotify_poll(struct file *file, poll_table *wait)
 static ssize_t fanotify_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *pos)
 {
+	struct fanotify_error_event error_event;
 	struct fsnotify_group *group;
 	struct fanotify_event *event;
 	char __user *start;
@@ -577,7 +652,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		 * in case there are lots of available events.
 		 */
 		cond_resched();
-		event = get_one_event(group, count);
+		event = get_one_event(group, count, &error_event);
 		if (IS_ERR(event)) {
 			ret = PTR_ERR(event);
 			break;
@@ -896,16 +971,34 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				    flags, umask);
 }
 
-static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask,
-				       unsigned int flags)
+static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
+				     __u32 mask, unsigned int flags,
+				     __u32 *added_mask)
 {
+	struct fanotify_error_event *error_event = NULL;
+	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	__u32 oldmask = -1;
 
+	/* Only pre-alloc error_event if needed. */
+	if (!ignored && (mask & FAN_FS_ERROR) &&
+	    (fsn_mark->flags & FSNOTIFY_MARK_FLAG_SB) &&
+	    !FANOTIFY_SB_MARK(fsn_mark)->error_event) {
+		error_event = kzalloc(sizeof(*error_event), GFP_KERNEL);
+		if (!error_event)
+			return -ENOMEM;
+		fanotify_init_event(&error_event->fae, 0, FS_ERROR);
+		error_event->mark = fsn_mark;
+	}
+
 	spin_lock(&fsn_mark->lock);
-	if (!(flags & FAN_MARK_IGNORED_MASK)) {
+	if (!ignored) {
 		oldmask = fsn_mark->mask;
 		fsn_mark->mask |= mask;
+
+		if (error_event && !FANOTIFY_SB_MARK(fsn_mark)->error_event) {
+			FANOTIFY_SB_MARK(fsn_mark)->error_event = error_event;
+			error_event = NULL;
+		}
 	} else {
 		fsn_mark->ignored_mask |= mask;
 		if (flags & FAN_MARK_IGNORED_SURV_MODIFY)
@@ -913,7 +1006,10 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	}
 	spin_unlock(&fsn_mark->lock);
 
-	return mask & ~oldmask;
+	kfree(error_event);
+
+	*added_mask = mask & ~oldmask;
+	return 0;
 }
 
 static struct fsnotify_mark *fanotify_alloc_mark(unsigned int type)
@@ -987,6 +1083,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	__u32 added;
+	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -997,13 +1094,18 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			return PTR_ERR(fsn_mark);
 		}
 	}
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
+	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &added);
+	if (ret)
+		goto out;
+
 	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
+
+out:
 	mutex_unlock(&group->mark_mutex);
 
 	fsnotify_put_mark(fsn_mark);
-	return 0;
+	return ret;
 }
 
 static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
@@ -1419,6 +1521,17 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 
 		fsid = &__fsid;
 	}
+	if (mask & FAN_FS_ERROR) {
+		if (mark_type != FAN_MARK_FILESYSTEM) {
+			ret = -EINVAL;
+			goto path_put_and_out;
+		}
+
+		ret = fanotify_test_fsid(path.dentry, &__fsid);
+		if (ret)
+			goto path_put_and_out;
+		fsid = &__fsid;
+	}
 
 	/* inode held in place by reference to path; group by fget on fd */
 	if (mark_type == FAN_MARK_INODE)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index a16dbeced152..3bdfe227e2c2 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -85,9 +85,12 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
 
+#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS)
+				 FANOTIFY_INODE_EVENTS | \
+				 FANOTIFY_ERROR_EVENTS)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
@@ -99,6 +102,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 /* Events that may be reported to user */
 #define FANOTIFY_OUTGOING_EVENTS	(FANOTIFY_EVENTS | \
 					 FANOTIFY_PERM_EVENTS | \
+					 FANOTIFY_ERROR_EVENTS | \
 					 FAN_Q_OVERFLOW | FAN_ONDIR)
 
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index fbf9c5c7dd59..a987150a446c 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -20,6 +20,7 @@
 #define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
 
 #define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
 
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
@@ -123,6 +124,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
+#define FAN_EVENT_INFO_TYPE_ERROR	4
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -148,6 +150,15 @@ struct fanotify_event_info_fid {
 	unsigned char handle[0];
 };
 
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+	__kernel_fsid_t fsid;
+	__u64 ino;
+	__u32 ino_generation;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
-- 
2.31.0

