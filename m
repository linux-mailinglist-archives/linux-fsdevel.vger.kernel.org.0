Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15E336B940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhDZSn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbhDZSnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E5C06175F;
        Mon, 26 Apr 2021 11:42:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 67AB21F41E27
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 09/15] fanotify: Introduce generic error record
Date:   Mon, 26 Apr 2021 14:41:55 -0400
Message-Id: <20210426184201.4177978-10-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This record describes a fs error in a fs agnostic way.  It will be send
back to userspace in response to a FSNOTIFY_EVENT_ERROR for groups with
the FAN_ERROR mark.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.h      | 16 ++++++++++++++++
 fs/notify/fanotify/fanotify_user.c | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      | 10 ++++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 47299e3d6efd..4cb9dd31f084 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -179,6 +179,22 @@ FANOTIFY_NE(struct fanotify_event *event)
 	return container_of(event, struct fanotify_name_event, fae);
 }
 
+struct fanotify_error_event {
+	struct fanotify_event fae;
+	int error;
+	__kernel_fsid_t fsid;
+
+	int fs_data_size;
+	/* Must be the last item in the structure */
+	char fs_data[0];
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
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5031198bf7db..21162d347bd1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -64,6 +64,11 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
 }
 
+static size_t fanotify_error_info_len(struct fanotify_error_event *fee)
+{
+	return sizeof(struct fanotify_event_info_error);
+}
+
 static size_t fanotify_event_len(struct fanotify_event *event,
 				 unsigned int fid_mode)
 {
@@ -232,6 +237,29 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
+static size_t copy_error_info_to_user(struct fanotify_error_event *fee,
+				      char __user *buf, int count)
+{
+	struct fanotify_event_info_error info;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
+	info.hdr.pad = 0;
+	info.hdr.len = fanotify_error_info_len(fee);
+
+	if (WARN_ON(count < info.hdr.len))
+		return -EFAULT;
+
+	info.version = FANOTIFY_EVENT_INFO_ERROR_VERS_1;
+	info.error = fee->error;
+	info.fsid = fee->fsid;
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	return info.hdr.len;
+
+}
+
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index b283531549f1..cc9a1fa80e30 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -124,6 +124,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
+#define FAN_EVENT_INFO_TYPE_ERROR	4
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -149,6 +150,15 @@ struct fanotify_event_info_fid {
 	unsigned char handle[0];
 };
 
+#define FANOTIFY_EVENT_INFO_ERROR_VERS_1   1
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	int version;
+	int error;
+	__kernel_fsid_t fsid;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
-- 
2.31.0

