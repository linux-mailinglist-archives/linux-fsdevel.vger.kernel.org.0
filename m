Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40136B944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhDZSpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbhDZSnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADADC061760;
        Mon, 26 Apr 2021 11:43:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id BC1A81F422DA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 11/15] fanotify: Introduce filesystem specific data record
Date:   Mon, 26 Apr 2021 14:41:57 -0400
Message-Id: <20210426184201.4177978-12-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow a FS_ERROR_TYPE notification to send a filesystem provided blob
back to userspace.  This is useful for filesystems who want to provide
debug information for recovery tools.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify_user.c | 27 +++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      | 10 ++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index cb79a4a8e6fb..e2f4599dfc25 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -69,6 +69,14 @@ static size_t fanotify_error_info_len(struct fanotify_error_event *fee)
 	return sizeof(struct fanotify_event_info_error);
 }
 
+static size_t fanotify_error_fsdata_len(struct fanotify_error_event *fee)
+{
+	if (!fee->fs_data_size)
+		return 0;
+
+	return sizeof(struct fanotify_event_info_fsdata) + fee->fs_data_size;
+}
+
 static size_t fanotify_location_info_len(const struct fanotify_event_location *loc)
 {
 	if (!loc->function)
@@ -295,6 +303,25 @@ static size_t copy_location_info_to_user(struct fanotify_event_location *locatio
 	return info.hdr.len;
 }
 
+static ssize_t copy_error_fsdata_info_to_user(struct fanotify_error_event *fee,
+					      char __user *buf, int count)
+{
+	struct fanotify_event_info_fsdata info;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_FSDATA;
+	info.hdr.len = fanotify_error_fsdata_len(fee);
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	buf += sizeof(info);
+
+	if (copy_to_user(buf, fee->fs_data, fee->fs_data_size))
+		return -EFAULT;
+
+	return info.hdr.len;
+}
+
 static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			     int info_type, const char *name, size_t name_len,
 			     char __user *buf, size_t count)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 67217756dac9..49808c857ee1 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -124,8 +124,9 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
-#define FAN_EVENT_INFO_TYPE_ERROR	4
-#define FAN_EVENT_INFO_TYPE_LOCATION	5
+#define FAN_EVENT_INFO_TYPE_LOCATION	4
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_FSDATA	6
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -166,6 +167,11 @@ struct fanotify_event_info_location {
 	char function[0];
 };
 
+struct fanotify_event_info_fsdata {
+	struct fanotify_event_info_header hdr;
+	char data[0];
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
-- 
2.31.0

