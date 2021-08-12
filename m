Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA73EACAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhHLVmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:42:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45930 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbhHLVmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:42:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 052B21F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 17/21] fanotify: Report fid info for file related file system errors
Date:   Thu, 12 Aug 2021 17:40:06 -0400
Message-Id: <20210812214010.3197279-18-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Plumb the pieces to add a FID report to error records.  Since all error
event memory must be pre-allocated, we estimate a file handle size and
if it is insuficient, we report an invalid FID and increase the
prediction for the next error slot allocation.

For errors that don't expose a file handle report it with an invalid
FID.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Use preallocated MAX_HANDLE_SZ FH buffer
  - Report superblock errors with a zerolength INVALID FID (jan, amir)
---
 fs/notify/fanotify/fanotify.c      | 15 +++++++++++++++
 fs/notify/fanotify/fanotify.h      | 11 +++++++++++
 fs/notify/fanotify/fanotify_user.c |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 0c7667d3f5d1..f5c16ac37835 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -734,6 +734,8 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
 	struct fanotify_sb_mark *sb_mark =
 		FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
 	struct fanotify_error_event *fee = sb_mark->fee_slot;
+	struct inode *inode = report->inode;
+	int fh_len;
 
 	spin_lock(&group->notification_lock);
 	if (fee->err_count++) {
@@ -743,6 +745,19 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
 	spin_unlock(&group->notification_lock);
 
 	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
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
 
 	if (fsnotify_insert_event(group, &fee->fae.fse,
 				  NULL, fanotify_insert_error_event)) {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index eeb4a85af74e..158cf0c4b0bd 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -223,6 +223,13 @@ struct fanotify_error_event {
 	u32 err_count; /* Suppressed errors count */
 
 	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
+
+	__kernel_fsid_t fsid; /* FSID this error refers to. */
+
+	/* object_fh must be followed by the inline handle buffer. */
+	struct fanotify_fh object_fh;
+	/* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
+	unsigned char _inline_fh_buf[MAX_HANDLE_SZ];
 };
 
 static inline struct fanotify_error_event *
@@ -237,6 +244,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 		return &FANOTIFY_FE(event)->fsid;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return &FANOTIFY_NE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->fsid;
 	else
 		return NULL;
 }
@@ -248,6 +257,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 		return &FANOTIFY_FE(event)->object_fh;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->object_fh;
 	else
 		return NULL;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3fff0c994dc8..1ab8f9d8b3ac 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -177,6 +177,13 @@ static struct fanotify_event *fanotify_dup_error_to_stack(
 	error_on_stack->err_count = fee->err_count;
 	error_on_stack->sb_mark = fee->sb_mark;
 
+	error_on_stack->fsid = fee->fsid;
+
+	memcpy(&error_on_stack->object_fh, &fee->object_fh,
+	       sizeof(fee->object_fh));
+	memcpy(error_on_stack->object_fh.buf, fee->object_fh.buf,
+		fee->object_fh.len);
+
 	return &error_on_stack->fae;
 }
 
-- 
2.32.0

