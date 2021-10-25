Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE0343A41A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhJYUM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbhJYUMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:12:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B68C04A42E;
        Mon, 25 Oct 2021 12:30:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C9BAA1F433E3;
        Mon, 25 Oct 2021 20:30:54 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 27/31] fanotify: Emit generic error info for error event
Date:   Mon, 25 Oct 2021 16:27:42 -0300
Message-Id: <20211025192746.66445-28-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The error info is a record sent to users on FAN_FS_ERROR events
documenting the type of error.  It also carries an error count,
documenting how many errors were observed since the last reporting.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v6:
  - Rebase on top of pidfd patches
Changes since v5:
  - Move error code here
---
 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify.h      |  1 +
 fs/notify/fanotify/fanotify_user.c | 35 ++++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      |  7 ++++++
 4 files changed, 44 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 465f07e70e6d..af61425e6e3b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -621,6 +621,7 @@ static struct fanotify_event *fanotify_alloc_error_event(
 		return NULL;
 
 	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	fee->error = report->error;
 	fee->err_count = 1;
 	fee->fsid = *fsid;
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index edd7587adcc5..d25f500bf7e7 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -205,6 +205,7 @@ FANOTIFY_NE(struct fanotify_event *event)
 
 struct fanotify_error_event {
 	struct fanotify_event fae;
+	s32 error; /* Error reported by the Filesystem. */
 	u32 err_count; /* Suppressed errors count */
 
 	__kernel_fsid_t fsid; /* FSID this error refers to. */
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ff4a7373f7a5..97ec5b005b50 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -115,6 +115,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
 #define FANOTIFY_PIDFD_INFO_HDR_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
+#define FANOTIFY_ERROR_INFO_LEN \
+	(sizeof(struct fanotify_event_info_error))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -139,6 +141,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (!info_mode)
 		return event_len;
 
+	if (fanotify_is_error_event(event->mask))
+		event_len += FANOTIFY_ERROR_INFO_LEN;
+
 	info = fanotify_event_info(event);
 
 	if (fanotify_event_has_dir_fh(event)) {
@@ -324,6 +329,28 @@ static int process_access_response(struct fsnotify_group *group,
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
+	info.hdr.len = FANOTIFY_ERROR_INFO_LEN;
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
 static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 				 int info_type, const char *name,
 				 size_t name_len,
@@ -530,6 +557,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_is_error_event(event->mask)) {
+		ret = copy_error_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+	}
+
 	return total_bytes;
 }
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 2990731ddc8b..bd1932c2074d 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -126,6 +126,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
+#define FAN_EVENT_INFO_TYPE_ERROR	5
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -160,6 +161,12 @@ struct fanotify_event_info_pidfd {
 	__s32 pidfd;
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
2.33.0

