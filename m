Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAABF42E3A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhJNVls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:41:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54326 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhJNVls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:41:48 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 03CD41F415A6;
        Thu, 14 Oct 2021 22:39:40 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 23/28] fanotify: Report fid info for file related file system errors
Date:   Thu, 14 Oct 2021 18:36:41 -0300
Message-Id: <20211014213646.1139469-24-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Plumb the pieces to add a FID report to error records.  Since all error
event memory must be pre-allocated, we pre-allocate the maximum file
handle size possible, such that it should always fit.

For errors that don't expose a file handle report it with an invalid
FID.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v6:
  - pass fsid from handle_events
Changes since v5:
  - Use preallocated MAX_HANDLE_SZ FH buffer
  - Report superblock errors with a zerolength INVALID FID (jan, amir)
---
 fs/notify/fanotify/fanotify.c | 15 +++++++++++++++
 fs/notify/fanotify/fanotify.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7032083df62a..8a60c96f5fb2 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -611,7 +611,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
 {
 	struct fs_error_report *report =
 			fsnotify_data_error_report(data, data_type);
+	struct inode *inode = report->inode;
 	struct fanotify_error_event *fee;
+	int fh_len;
 
 	if (WARN_ON(!report))
 		return NULL;
@@ -622,6 +624,19 @@ static struct fanotify_event *fanotify_alloc_error_event(
 
 	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
 	fee->err_count = 1;
+	fee->fsid = *fsid;
+
+	fh_len = fanotify_encode_fh_len(inode);
+	if (WARN_ON(fh_len > MAX_HANDLE_SZ)) {
+		/*
+		 * Fallback to reporting the error against the super
+		 * block.  It should never happen.
+		 */
+		inode = NULL;
+		fh_len = fanotify_encode_fh_len(NULL);
+	}
+
+	fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
 
 	*hash ^= fanotify_hash_fsid(fsid);
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 2b032b79d5b0..b58400926f92 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -202,6 +202,10 @@ struct fanotify_error_event {
 	u32 err_count; /* Suppressed errors count */
 
 	__kernel_fsid_t fsid; /* FSID this error refers to. */
+	/* object_fh must be followed by the inline handle buffer. */
+	struct fanotify_fh object_fh;
+	/* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
+	unsigned char _inline_fh_buf[MAX_HANDLE_SZ];
 };
 
 static inline struct fanotify_error_event *
@@ -216,6 +220,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 		return &FANOTIFY_FE(event)->fsid;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return &FANOTIFY_NE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->fsid;
 	else
 		return NULL;
 }
@@ -227,6 +233,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 		return &FANOTIFY_FE(event)->object_fh;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->object_fh;
 	else
 		return NULL;
 }
-- 
2.33.0

