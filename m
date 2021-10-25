Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AC43A417
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhJYUMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbhJYULv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:11:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8CC04A428;
        Mon, 25 Oct 2021 12:30:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A481F1F4316F;
        Mon, 25 Oct 2021 20:30:35 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 24/31] fanotify: Report fid entry even for zero-length file_handle
Date:   Mon, 25 Oct 2021 16:27:39 -0300
Message-Id: <20211025192746.66445-25-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v8:
  - Move fanotify_event_has_object_fh check here (jan)
---
 fs/notify/fanotify/fanotify.h      | 3 +++
 fs/notify/fanotify/fanotify_user.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 80af269eebb8..f51ab6e556e8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -266,6 +266,9 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
 
 static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
 {
+	/* For error events, even zeroed fh are reported. */
+	if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+		return true;
 	return fanotify_event_object_fh_len(event) > 0;
 }
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a9b5c36ee49e..ff4a7373f7a5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -339,9 +339,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
 		 __func__, fh_len, name_len, info_len, count);
 
-	if (!fh_len)
-		return 0;
-
 	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
 		return -EFAULT;
 
@@ -376,6 +373,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 
 	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
+
+	/* Mangle handle_type for bad file_handle */
+	if (!fh_len)
+		handle.handle_type = FILEID_INVALID;
+
 	if (copy_to_user(buf, &handle, sizeof(handle)))
 		return -EFAULT;
 
-- 
2.33.0

