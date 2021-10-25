Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947743A0DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhJYTf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:35:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbhJYTcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:32:39 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 30E891F41B51;
        Mon, 25 Oct 2021 20:30:14 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 21/31] fanotify: Support merging of error events
Date:   Mon, 25 Oct 2021 16:27:36 -0300
Message-Id: <20211025192746.66445-22-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Error events (FAN_FS_ERROR) against the same file system can be merged
by simply iterating the error count.  The hash is taken from the fsid,
without considering the FH.  This means that only the first error object
is reported.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v7:
  - Move fee->fsid assignment here (Amir)
  - Open code error event merge logic in fanotify_merge (Jan)
---
 fs/notify/fanotify/fanotify.c | 26 ++++++++++++++++++++++++--
 fs/notify/fanotify/fanotify.h |  4 +++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1f195c95dfcd..cedcb1546804 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -111,6 +111,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	return fanotify_info_equal(info1, info2);
 }
 
+static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
+				       struct fanotify_error_event *fee2)
+{
+	/* Error events against the same file system are always merged. */
+	if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
+		return false;
+
+	return true;
+}
+
 static bool fanotify_should_merge(struct fanotify_event *old,
 				  struct fanotify_event *new)
 {
@@ -141,6 +151,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 	case FANOTIFY_EVENT_TYPE_FID_NAME:
 		return fanotify_name_event_equal(FANOTIFY_NE(old),
 						 FANOTIFY_NE(new));
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		return fanotify_error_event_equal(FANOTIFY_EE(old),
+						  FANOTIFY_EE(new));
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -176,6 +189,10 @@ static int fanotify_merge(struct fsnotify_group *group,
 			break;
 		if (fanotify_should_merge(old, new)) {
 			old->mask |= new->mask;
+
+			if (fanotify_is_error_event(old->mask))
+				FANOTIFY_EE(old)->err_count++;
+
 			return 1;
 		}
 	}
@@ -577,7 +594,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 static struct fanotify_event *fanotify_alloc_error_event(
 						struct fsnotify_group *group,
 						__kernel_fsid_t *fsid,
-						const void *data, int data_type)
+						const void *data, int data_type,
+						unsigned int *hash)
 {
 	struct fs_error_report *report =
 			fsnotify_data_error_report(data, data_type);
@@ -591,6 +609,10 @@ static struct fanotify_event *fanotify_alloc_error_event(
 		return NULL;
 
 	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+	fee->err_count = 1;
+	fee->fsid = *fsid;
+
+	*hash ^= fanotify_hash_fsid(fsid);
 
 	return &fee->fae;
 }
@@ -664,7 +686,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event = fanotify_alloc_perm_event(path, gfp);
 	} else if (fanotify_is_error_event(mask)) {
 		event = fanotify_alloc_error_event(group, fsid, data,
-						   data_type);
+						   data_type, &hash);
 	} else if (name_event && (file_name || child)) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, child,
 						  &hash, gfp);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index ebef952481fa..2b032b79d5b0 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -199,6 +199,9 @@ FANOTIFY_NE(struct fanotify_event *event)
 
 struct fanotify_error_event {
 	struct fanotify_event fae;
+	u32 err_count; /* Suppressed errors count */
+
+	__kernel_fsid_t fsid; /* FSID this error refers to. */
 };
 
 static inline struct fanotify_error_event *
@@ -332,7 +335,6 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
 	return !(fanotify_is_perm_event(mask) ||
-		 fanotify_is_error_event(mask) ||
 		 fsnotify_is_overflow_event(mask));
 }
 
-- 
2.33.0

