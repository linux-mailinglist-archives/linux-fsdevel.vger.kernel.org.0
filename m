Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BEB3CFEDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhGTPaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbhGTPUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:20:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CAC061762;
        Tue, 20 Jul 2021 09:00:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DCFBD1F43149
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 13/16] fanotify: Introduce FAN_FS_ERROR event
Date:   Tue, 20 Jul 2021 11:59:41 -0400
Message-Id: <20210720155944.1447086-14-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720155944.1447086-1-krisman@collabora.com>
References: <20210720155944.1447086-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The FAN_FS_ERROR event is a new inode event used by filesystem wide
monitoring tools to receive notifications of type FS_ERROR_EVENT,
emitted directly by filesystems when a problem is detected.  The error
notification includes a generic error descriptor and a FID identifying
the file affected.

FID is sent for every FAN_FS_ERROR. Errors not linked to a regular inode
are reported against the root inode.

An error reporting structure is attached per-mark, and only a single
error can be stored at a time.  This is ok, since once an error occurs,
it is common for a stream of related errors to be reported.  We only log
accumulate the total of errors occurred since the last notification.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v3:
  - Convert WARN_ON to pr_warn (amir)
  - Remove unecessary READ/WRITE_ONCE (amir)
  - Alloc with GFP_KERNEL_ACCOUNT(amir)
  - Simplify flags on mark allocation (amir)
  - Avoid atomic set of error_count (amir)
  - Simplify rules when merging error_event (amir)
  - Allocate new error_event on get_one_event (amir)
  - Report superblock error with invalid FH (amir,jan)

Changes since v2:
  - Support and equire FID mode (amir)
  - Goto error path instead of early return (amir)
  - Simplify get_one_event (me)
  - Base merging on error_count
  - drop fanotify_queue_error_event

Changes since v1:
  - Pass dentry to fanotify_check_fsid (Amir)
  - FANOTIFY_EVENT_TYPE_ERROR -> FANOTIFY_EVENT_TYPE_FS_ERROR
  - Merge previous patch into it
  - Use a single slot
  - Move fanotify_mark.error_event definition to this commit
  - Rename FAN_ERROR -> FAN_FS_ERROR
  - Restrict FAN_FS_ERROR to FAN_MARK_FILESYSTEM
---
 fs/notify/fanotify/fanotify.c      | 137 ++++++++++++++++++----
 fs/notify/fanotify/fanotify.h      |  53 +++++++++
 fs/notify/fanotify/fanotify_user.c | 180 +++++++++++++++++++++++++++--
 include/linux/fanotify.h           |   8 +-
 include/uapi/linux/fanotify.h      |   8 ++
 5 files changed, 353 insertions(+), 33 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 912d120b9e48..477596b92bc5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -335,24 +335,6 @@ static u32 fanotify_group_event_mask(
 	return test_mask & user_mask;
 }
 
-/*
- * Check size needed to encode fanotify_fh.
- *
- * Return size of encoded fh without fanotify_fh header.
- * Return 0 on failure to encode.
- */
-static int fanotify_encode_fh_len(struct inode *inode)
-{
-	int dwords = 0;
-
-	if (!inode)
-		return 0;
-
-	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
-
-	return dwords << 2;
-}
-
 /*
  * Encode fanotify_fh.
  *
@@ -404,8 +386,12 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	fh->type = type;
 	fh->len = fh_len;
 
-	/* Mix fh into event merge key */
-	*hash ^= fanotify_hash_fh(fh);
+	/*
+	 * Mix fh into event merge key.  Hash might be NULL in case of
+	 * unhashed FID events (i.e. FAN_FS_ERROR).
+	 */
+	if (hash)
+		*hash ^= fanotify_hash_fh(fh);
 
 	return FANOTIFY_FH_HDR_LEN + fh_len;
 
@@ -420,6 +406,27 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	return 0;
 }
 
+#define FANOTIFY_EMPTY_FH_LEN	8
+/*
+ * Encode an empty fanotify_fh
+ *
+ * Empty FHs are used on FAN_FS_ERROR for errors not linked to any
+ * inode. fh needs to guarantee at least 8 bytes of inline space.
+ */
+static int fanotify_encode_empty_fh(struct fanotify_fh *fh, int max_len)
+{
+	if (max_len < FANOTIFY_EMPTY_FH_LEN || fh->flags)
+		return -EINVAL;
+
+	fh->type = FILEID_INVALID;
+	fh->len = FANOTIFY_EMPTY_FH_LEN;
+	fh->flags = 0;
+
+	memset(fh->buf, 0, FANOTIFY_EMPTY_FH_LEN);
+
+	return 0;
+}
+
 /*
  * The inode to use as identifier when reporting fid depends on the event.
  * Report the modified directory inode on dirent modification events.
@@ -691,6 +698,63 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	return fsid;
 }
 
+static int fanotify_merge_error_event(struct fsnotify_group *group,
+				      struct fsnotify_event *event)
+{
+	struct fanotify_event *fae = FANOTIFY_E(event);
+	struct fanotify_error_event *fee = FANOTIFY_EE(fae);
+
+	/*
+	 * When err_count > 0, the reporting slot is full.  Just account
+	 * the additional error and abort the insertion.
+	 */
+	if (fee->err_count) {
+		fee->err_count++;
+		return 1;
+	}
+
+	return 0;
+}
+
+static void fanotify_insert_error_event(struct fsnotify_group *group,
+					struct fsnotify_event *event,
+					const void *data)
+{
+	struct fanotify_event *fae = FANOTIFY_E(event);
+	const struct fsnotify_event_info *ei =
+		(struct fsnotify_event_info *) data;
+	const struct fs_error_report *report =
+		(struct fs_error_report *) ei->data;
+	struct inode *inode = report->inode;
+	struct fanotify_error_event *fee;
+	int fh_len;
+
+	/* This might be an unexpected type of event (i.e. overflow). */
+	if (!fanotify_is_error_event(fae->mask))
+		return;
+
+	fee = FANOTIFY_EE(fae);
+	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	fee->error = report->error;
+	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
+	fee->err_count = 1;
+
+	/*
+	 * Error reporting needs to happen in atomic context.  If this
+	 * inode's file handler is more than we initially predicted,
+	 * there is nothing better we can do than report the error with
+	 * a bad FH.
+	 */
+	fh_len = inode ? fanotify_encode_fh_len(inode) : FANOTIFY_EMPTY_FH_LEN;
+	if (fh_len > fee->max_fh_len)
+		return;
+
+	if (inode)
+		fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
+	else
+		fanotify_encode_empty_fh(&fee->object_fh, fee->max_fh_len);
+}
+
 /*
  * Add an event to hash table for faster merge.
  */
@@ -741,8 +805,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
+	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, mask, event_info, iter_info);
 	if (!mask)
@@ -766,6 +831,18 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
+	if (fanotify_is_error_event(mask)) {
+		struct fanotify_sb_mark *sb_mark =
+			FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
+
+		ret = fsnotify_insert_event(group,
+					    &sb_mark->error_event->fae.fse,
+					    fanotify_merge_error_event,
+					    fanotify_insert_error_event,
+					    event_info);
+		goto finish;
+	}
+
 	event = fanotify_alloc_event(group, mask, event_info, &fsid);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
@@ -833,6 +910,20 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 	kfree(FANOTIFY_NE(event));
 }
 
+static void fanotify_free_error_event(struct fanotify_event *event)
+{
+	struct fanotify_error_event *fee = FANOTIFY_EE(event);
+
+	/*
+	 * The event currently associated with the mark is freed by
+	 * fanotify_free_mark.
+	 */
+	if (fee->sb_mark->error_event == fee)
+		return;
+
+	kfree(fee);
+}
+
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
@@ -855,6 +946,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	case FANOTIFY_EVENT_TYPE_OVERFLOW:
 		kfree(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		fanotify_free_error_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -872,6 +966,7 @@ static void fanotify_free_mark(struct fsnotify_mark *mark)
 	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
 		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
 
+		kfree(fa_mark->error_event);
 		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
 	} else {
 		kmem_cache_free(fanotify_mark_cache, mark);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index d4a562c2619f..00dfec5f9a80 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -142,6 +142,7 @@ FANOTIFY_MARK_FLAG(SB_MARK);
 
 struct fanotify_sb_mark {
 	struct fsnotify_mark fsn_mark;
+	struct fanotify_error_event *error_event;
 };
 
 static inline
@@ -164,6 +165,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -219,12 +221,37 @@ FANOTIFY_NE(struct fanotify_event *event)
 	return container_of(event, struct fanotify_name_event, fae);
 }
 
+struct fanotify_error_event {
+	struct fanotify_event fae;
+	s32 error;				/* Error reported by the Filesystem. */
+	u32 err_count;				/* Suppressed errors count */
+	__kernel_fsid_t fsid;			/* FSID this error refers to. */
+
+	struct fanotify_sb_mark *sb_mark;	/* Back reference to the mark. */
+	int max_fh_len;				/* Maximum object_fh buffer size. */
+
+	/*
+	 * object_fh is followed by a variable sized buffer, so it must
+	 * be the last element of this structure.
+	 */
+	struct fanotify_fh object_fh;
+};
+
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
@@ -236,6 +263,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 		return &FANOTIFY_FE(event)->object_fh;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->object_fh;
 	else
 		return NULL;
 }
@@ -310,6 +339,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct fanotify_event, fse);
 }
 
+static inline bool fanotify_is_error_event(u32 mask)
+{
+	return mask & FAN_FS_ERROR;
+}
+
 static inline bool fanotify_event_has_path(struct fanotify_event *event)
 {
 	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
@@ -339,6 +373,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
 	return !(fanotify_is_perm_event(mask) ||
+		 fanotify_is_error_event(mask) ||
 		 fsnotify_is_overflow_event(mask));
 }
 
@@ -348,3 +383,21 @@ static inline unsigned int fanotify_event_hash_bucket(
 {
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
+
+/*
+ * Check size needed to encode fanotify_fh.
+ *
+ * Return size of encoded fh without fanotify_fh header.
+ * Return 0 on failure to encode.
+ */
+static inline int fanotify_encode_fh_len(struct inode *inode)
+{
+	int dwords = 0;
+
+	if (!inode)
+		return 0;
+
+	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+
+	return dwords << 2;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0696f2121781..bfc6bf6be197 100644
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
@@ -130,6 +132,9 @@ static size_t fanotify_event_len(struct fanotify_event *event,
 	if (!fid_mode)
 		return event_len;
 
+	if (fanotify_is_error_event(event->mask))
+		event_len += FANOTIFY_INFO_ERROR_LEN;
+
 	info = fanotify_event_info(event);
 	dir_fh_len = fanotify_event_dir_fh_len(event);
 	fh_len = fanotify_event_object_fh_len(event);
@@ -167,6 +172,90 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
 	hlist_del_init(&event->merge_list);
 }
 
+static struct fanotify_error_event *fanotify_alloc_error_event(
+					struct fanotify_sb_mark *sb_mark,
+					int fh_len)
+{
+	struct fanotify_error_event *fee;
+	struct super_block *sb;
+
+	if (!fh_len) {
+		/*
+		 * The FH buffer size is predicted to be the same size
+		 * as the root inode file handler.  This should work for
+		 * file systems without variable sized FH.
+		 */
+		sb = container_of(sb_mark->fsn_mark.connector->obj,
+				  struct super_block, s_fsnotify_marks);
+		fh_len = fanotify_encode_fh_len(sb->s_root->d_inode);
+	}
+
+	fee = kzalloc(sizeof(*fee) + fh_len, GFP_KERNEL_ACCOUNT);
+	if (!fee)
+		return NULL;
+
+	fanotify_init_event(&fee->fae, 0, FS_ERROR);
+	fee->sb_mark = sb_mark;
+	fee->max_fh_len = fh_len;
+
+	return fee;
+}
+
+/*
+ * Replace a mark's error event with a new structure in preparation for
+ * it to be dequeued.  This is a bit annoying since we need to drop the
+ * lock, so another thread might just steal the event from us.
+ */
+static struct fanotify_event *fanotify_replace_fs_error_event(
+					struct fsnotify_group *group,
+					struct fanotify_event *fae)
+{
+	struct fanotify_error_event *new, *fee = FANOTIFY_EE(fae);
+	struct fanotify_sb_mark *sb_mark = fee->sb_mark;
+	struct fsnotify_event *fse;
+	int max_fh_len = fee->max_fh_len;
+	int fh_len = fanotify_event_object_fh_len(fae);
+
+	pr_debug("%s: event=%p\n", __func__, fae);
+
+	assert_spin_locked(&group->notification_lock);
+
+	spin_unlock(&group->notification_lock);
+	new = fanotify_alloc_error_event(sb_mark, fee->max_fh_len);
+	spin_lock(&group->notification_lock);
+
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Since we temporarily dropped the notification_lock, the event
+	 * might have been taken from under us and reported by another
+	 * reader.  Peek again prior to removal.
+	 *
+	 * Maybe this is not the same event we started handling.  But as
+	 * long as it is also a same size error event for the same
+	 * filesystem, it is safe to reuse the allocated memory.
+	 */
+	fse = fsnotify_peek_first_event(group);
+	if (!fse || !fanotify_is_error_event(FANOTIFY_E(fse)->mask))
+		goto fail;
+
+	fae = FANOTIFY_E(fse);
+	fee = FANOTIFY_EE(fae);
+	if (fee->sb_mark != sb_mark || max_fh_len != fee->max_fh_len  ||
+	    fh_len < fanotify_event_object_fh_len(fae))
+		goto fail;
+
+	sb_mark->error_event = new;
+
+	return fae;
+
+fail:
+	kfree(new);
+
+	return ERR_PTR(-EAGAIN);
+}
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -196,9 +285,20 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		goto out;
 	}
 
+	if (fanotify_is_error_event(event->mask)) {
+		/*
+		 * Recreate the error event ahead of dequeueing so we
+		 * don't need to handle a incorrectly dequeued event.
+		 */
+		event = fanotify_replace_fs_error_event(group, event);
+		if (IS_ERR(event))
+			goto out;
+	}
+
 	/*
-	 * Held the notification_lock the whole time, so this is the
-	 * same event we peeked above.
+	 * This might not be the same event peeked above, if
+	 * fanotify_recreate_fs_error raced with another reader. It is
+	 * guaranteed to succeed, though.
 	 */
 	fsnotify_remove_first_event(group);
 	if (fanotify_is_perm_event(event->mask))
@@ -310,6 +410,28 @@ static int process_access_response(struct fsnotify_group *group,
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
+	info.error = fee->error;
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
@@ -468,6 +590,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (f)
 		fd_install(fd, f);
 
+	if (fanotify_is_error_event(event->mask)) {
+		ret = copy_error_info_to_user(event, buf, count);
+		if (ret < 0)
+			goto out_close_fd;
+		buf += ret;
+		count -= ret;
+	}
+
 	/* Event info records order is: dir fid + name, child fid */
 	if (fanotify_event_dir_fh_len(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
@@ -580,6 +710,8 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		event = get_one_event(group, count);
 		if (IS_ERR(event)) {
 			ret = PTR_ERR(event);
+			if (ret == -EAGAIN)
+				continue;
 			break;
 		}
 
@@ -993,7 +1125,9 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
+	struct fanotify_sb_mark *sb_mark;
 	__u32 added;
+	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -1004,13 +1138,34 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			return PTR_ERR(fsn_mark);
 		}
 	}
+
+	/*
+	 * Error events are allocated per super-block mark, but only if
+	 * strictly needed (i.e. FAN_FS_ERROR was requested).
+	 */
+	if (type == FSNOTIFY_OBJ_TYPE_SB && !(flags & FAN_MARK_IGNORED_MASK) &&
+	    (mask & FAN_FS_ERROR)) {
+		sb_mark = FANOTIFY_SB_MARK(fsn_mark);
+
+		if (!sb_mark->error_event) {
+			sb_mark->error_event =
+				fanotify_alloc_error_event(sb_mark, 0);
+			if (!sb_mark->error_event) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
 	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
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
@@ -1382,14 +1537,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * Events with data type inode do not carry enough information to report
-	 * event->fd, so we do not allow setting a mask for inode events unless
-	 * group supports reporting fid.
-	 * inode events are not supported on a mount mark, because they do not
-	 * carry enough information (i.e. path) to be filtered by mount point.
-	 */
+	* Events that do not carry enough information to report
+	* event->fd require a group that supports reporting fid.  Those
+	* events are not supported on a mount mark, because they do not
+	* carry enough information (i.e. path) to be filtered by mount
+	* point.
+	*/
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	if (mask & FANOTIFY_INODE_EVENTS &&
+	if (!(mask & FANOTIFY_FD_EVENTS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		goto fput_and_out;
 
@@ -1427,6 +1582,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		fsid = &__fsid;
 	}
 
+	if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
+		ret = -EINVAL;
+		goto path_put_and_out;
+	}
+
 	/* inode held in place by reference to path; group by fget on fd */
 	if (mark_type == FAN_MARK_INODE)
 		inode = path.dentry->d_inode;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index a16dbeced152..407f3f14bac4 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -81,9 +81,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  */
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
 
-/* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
+/* Events that can be reported with event->fd */
+#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
+
+/* Events that can only be reported to groups that support FID mode */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
-				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
+				 FAN_ATTRIB | FAN_MOVE_SELF | \
+				 FAN_DELETE_SELF | FAN_FS_ERROR)
 
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index fbf9c5c7dd59..80040a92e9d9 100644
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
@@ -148,6 +150,12 @@ struct fanotify_event_info_fid {
 	unsigned char handle[0];
 };
 
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
-- 
2.32.0

