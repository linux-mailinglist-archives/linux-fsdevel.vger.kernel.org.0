Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA13EACB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhHLVmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbhHLVmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:42:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692BC061756;
        Thu, 12 Aug 2021 14:41:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 538831F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 18/21] fanotify: Emit generic error info type for error event
Date:   Thu, 12 Aug 2021 17:40:07 -0400
Message-Id: <20210812214010.3197279-19-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The Error info type is a record sent to users on FAN_FS_ERROR events
documenting the type of error.  It also carries an error count,
documenting how many errors were observed since the last reporting.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Move error code here
---
 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify.h      |  1 +
 fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      |  7 ++++++
 4 files changed, 45 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index f5c16ac37835..b49a474c1d7f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -745,6 +745,7 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
 	spin_unlock(&group->notification_lock);
 
 	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	fee->error = report->error;
 	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
 
 	fh_len = fanotify_encode_fh_len(inode);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 158cf0c4b0bd..0cfe376c6fd9 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -220,6 +220,7 @@ FANOTIFY_NE(struct fanotify_event *event)
 
 struct fanotify_error_event {
 	struct fanotify_event fae;
+	s32 error; /* Error reported by the Filesystem. */
 	u32 err_count; /* Suppressed errors count */
 
 	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1ab8f9d8b3ac..ca53159ce673 100644
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
@@ -176,6 +181,7 @@ static struct fanotify_event *fanotify_dup_error_to_stack(
 	error_on_stack->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
 	error_on_stack->err_count = fee->err_count;
 	error_on_stack->sb_mark = fee->sb_mark;
+	error_on_stack->error = fee->error;
 
 	error_on_stack->fsid = fee->fsid;
 
@@ -342,6 +348,28 @@ static int process_access_response(struct fsnotify_group *group,
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
+	info.hdr.len = FANOTIFY_INFO_ERROR_LEN;
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
@@ -505,6 +533,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 16402037fc7a..80040a92e9d9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -124,6 +124,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
+#define FAN_EVENT_INFO_TYPE_ERROR	4
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
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

