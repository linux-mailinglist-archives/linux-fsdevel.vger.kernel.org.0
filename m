Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326F7432AEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhJSAGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:06:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41038 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhJSAGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:06:17 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4BABD1F40F21;
        Tue, 19 Oct 2021 01:04:03 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 27/32] fanotify: Report fid info for file related file system errors
Date:   Mon, 18 Oct 2021 21:00:10 -0300
Message-Id: <20211019000015.1666608-28-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
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
Changes since v7:
  - Move WARN_ON to separate patch (Amir)
  - Avoid duplication in the structure definition (Amir)
Changes since v6:
  - pass fsid from handle_events
Changes since v5:
  - Use preallocated MAX_HANDLE_SZ FH buffer
  - Report superblock errors with a zerolength INVALID FID (jan, amir)
---
 fs/notify/fanotify/fanotify.c | 10 ++++++++++
 fs/notify/fanotify/fanotify.h | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 45df610debbe..335ce8f88eb8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -609,7 +609,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
 {
 	struct fs_error_report *report =
 			fsnotify_data_error_report(data, data_type);
+	struct inode *inode = report->inode;
 	struct fanotify_error_event *fee;
+	int fh_len;
 
 	if (WARN_ON_ONCE(!report))
 		return NULL;
@@ -622,6 +624,14 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	fee->err_count = 1;
 	fee->fsid = *fsid;
 
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
index bdf01ad4f9bf..4246a34667b5 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -209,6 +209,9 @@ struct fanotify_error_event {
 	u32 err_count; /* Suppressed errors count */
 
 	__kernel_fsid_t fsid; /* FSID this error refers to. */
+
+	/* This must be the last element of the structure. */
+	FANOTIFY_INLINE_FH(MAX_HANDLE_SZ);
 };
 
 static inline struct fanotify_error_event *
@@ -223,6 +226,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 		return &FANOTIFY_FE(event)->fsid;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return &FANOTIFY_NE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->fsid;
 	else
 		return NULL;
 }
@@ -234,6 +239,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 		return &FANOTIFY_FE(event)->object_fh;
 	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
 		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
+	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return &FANOTIFY_EE(event)->object_fh;
 	else
 		return NULL;
 }
@@ -267,6 +274,10 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
 
 static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
 {
+
+	/* For error events, even zeroed fh are reported. */
+	if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return true;
 	if (fanotify_event_object_fh_len(event) > 0)
 		return true;
 
-- 
2.33.0

