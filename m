Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736C243A0D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhJYTfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:35:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58738 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhJYTdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:33:12 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 57E401F433DC;
        Mon, 25 Oct 2021 20:30:48 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 26/31] fanotify: Report fid info for file related file system errors
Date:   Mon, 25 Oct 2021 16:27:41 -0300
Message-Id: <20211025192746.66445-27-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v8:
  - Drop comment (Amir)
  - Move report dereference till after null check (jan)
  - Move has_object_fh hunk to earlier patch (jan)
Changes since v7:
  - Move WARN_ON to separate patch (Amir)
  - Avoid duplication in the structure definition (Amir)
Changes since v6:
  - pass fsid from handle_events
Changes since v5:
  - Use preallocated MAX_HANDLE_SZ FH buffer
  - Report superblock errors with a zerolength INVALID FID (jan, amir)
---
 fs/notify/fanotify/fanotify.c | 11 +++++++++++
 fs/notify/fanotify/fanotify.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 45df610debbe..465f07e70e6d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -609,7 +609,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
 {
 	struct fs_error_report *report =
 			fsnotify_data_error_report(data, data_type);
+	struct inode *inode;
 	struct fanotify_error_event *fee;
+	int fh_len;
 
 	if (WARN_ON_ONCE(!report))
 		return NULL;
@@ -622,6 +624,15 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	fee->err_count = 1;
 	fee->fsid = *fsid;
 
+	inode = report->inode;
+	fh_len = fanotify_encode_fh_len(inode);
+
+	/* Bad fh_len. Fallback to using an invalid fh. Should never happen. */
+	if (!fh_len && inode)
+		inode = NULL;
+
+	fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
+
 	*hash ^= fanotify_hash_fsid(fsid);
 
 	return &fee->fae;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index f51ab6e556e8..edd7587adcc5 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -208,6 +208,8 @@ struct fanotify_error_event {
 	u32 err_count; /* Suppressed errors count */
 
 	__kernel_fsid_t fsid; /* FSID this error refers to. */
+
+	FANOTIFY_INLINE_FH(object_fh, MAX_HANDLE_SZ);
 };
 
 static inline struct fanotify_error_event *
@@ -222,6 +224,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 		return &FANOTIFY_FE(event)->fsid;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return &FANOTIFY_NE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->fsid;
 	else
 		return NULL;
 }
@@ -233,6 +237,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
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

