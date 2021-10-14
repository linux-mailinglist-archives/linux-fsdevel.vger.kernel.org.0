Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1542E39E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhJNVll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhJNVll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:41:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE29C061570;
        Thu, 14 Oct 2021 14:39:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 17D671F44F8C;
        Thu, 14 Oct 2021 22:39:33 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 22/28] fanotify: Report FID entry even for zero-length file_handle
Date:   Thu, 14 Oct 2021 18:36:40 -0300
Message-Id: <20211014213646.1139469-23-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Non-inode errors will reported with an empty file_handle.  In
preparation for that, allow some events to print the FID record even if
there isn't any file_handle encoded

Even though FILEID_ROOT is used internally, make zero-length file
handles be reported as FILEID_INVALID.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify_user.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5324890500fc..39cf8ba4a6ce 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -127,6 +127,16 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 		       FANOTIFY_EVENT_ALIGN);
 }
 
+static bool fanotify_event_allows_empty_fh(struct fanotify_event *event)
+{
+	switch (event->type) {
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static size_t fanotify_event_len(unsigned int info_mode,
 				 struct fanotify_event *event)
 {
@@ -157,7 +167,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
 
-	if (fh_len)
+	if (fh_len || fanotify_event_allows_empty_fh(event))
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 
 	return event_len;
@@ -338,9 +348,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
 		 __func__, fh_len, name_len, info_len, count);
 
-	if (!fh_len)
-		return 0;
-
 	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
 		return -EFAULT;
 
@@ -375,6 +382,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 
 	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
+
+	/* Mangle handle_type for bad file_handle */
+	if (!fh_len)
+		handle.handle_type = FILEID_INVALID;
+
 	if (copy_to_user(buf, &handle, sizeof(handle)))
 		return -EFAULT;
 
@@ -467,7 +479,8 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
-	if (fanotify_event_object_fh_len(event)) {
+	if (fanotify_event_object_fh_len(event) ||
+	    fanotify_event_allows_empty_fh(event)) {
 		const char *dot = NULL;
 		int dot_len = 0;
 
-- 
2.33.0

