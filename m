Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62A936B942
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbhDZSpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:45:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbhDZSnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9F2F41F41E27
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 10/15] fanotify: Introduce code location record
Date:   Mon, 26 Apr 2021 14:41:56 -0400
Message-Id: <20210426184201.4177978-11-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces an optional info record that describes the
source (as in the region of the source-code where an event was
initiated).  This record is not produced for other type of existing
notification, but it is optionally enabled for FAN_ERROR notifications.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.h      |  6 +++++
 fs/notify/fanotify/fanotify_user.c | 35 ++++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      |  7 ++++++
 3 files changed, 48 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4cb9dd31f084..0d1b4cb8b005 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -161,6 +161,11 @@ struct fanotify_fid_event {
 	unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
 };
 
+struct fanotify_event_location {
+	int line;
+	const char *function;
+};
+
 static inline struct fanotify_fid_event *
 FANOTIFY_FE(struct fanotify_event *event)
 {
@@ -183,6 +188,7 @@ struct fanotify_error_event {
 	struct fanotify_event fae;
 	int error;
 	__kernel_fsid_t fsid;
+	struct fanotify_event_location loc;
 
 	int fs_data_size;
 	/* Must be the last item in the structure */
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 21162d347bd1..cb79a4a8e6fb 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -69,6 +69,16 @@ static size_t fanotify_error_info_len(struct fanotify_error_event *fee)
 	return sizeof(struct fanotify_event_info_error);
 }
 
+static size_t fanotify_location_info_len(const struct fanotify_event_location *loc)
+{
+	if (!loc->function)
+		return 0;
+
+	/* Includes NULL byte at end of loc->function */
+	return (sizeof(struct fanotify_event_info_location) +
+		strlen(loc->function) + 1);
+}
+
 static size_t fanotify_event_len(struct fanotify_event *event,
 				 unsigned int fid_mode)
 {
@@ -260,6 +270,31 @@ static size_t copy_error_info_to_user(struct fanotify_error_event *fee,
 
 }
 
+static size_t copy_location_info_to_user(struct fanotify_event_location *location,
+					 char __user *buf, int count)
+{
+	size_t len = fanotify_location_info_len(location);
+	size_t tail = len - sizeof(struct fanotify_event_info_location);
+	struct fanotify_event_info_location info;
+
+	if (!len)
+		return 0;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_LOCATION;
+	info.hdr.len = len;
+	info.line = location->line;
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	buf += sizeof(info);
+
+	if (copy_to_user(buf, location->function, tail))
+		return -EFAULT;
+
+	return info.hdr.len;
+}
+
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index cc9a1fa80e30..67217756dac9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -125,6 +125,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_ERROR	4
+#define FAN_EVENT_INFO_TYPE_LOCATION	5
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -159,6 +160,12 @@ struct fanotify_event_info_error {
 	__kernel_fsid_t fsid;
 };
 
+struct fanotify_event_info_location {
+	struct fanotify_event_info_header hdr;
+	int line;
+	char function[0];
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
-- 
2.31.0

