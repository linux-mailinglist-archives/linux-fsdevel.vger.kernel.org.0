Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370BE432AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhJSAF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:05:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40936 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhJSAFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:05:25 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1B5E31F411B7;
        Tue, 19 Oct 2021 01:03:11 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 21/32] fanotify: Support enqueueing of error events
Date:   Mon, 18 Oct 2021 21:00:04 -0300
Message-Id: <20211019000015.1666608-22-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once an error event is triggered, enqueue it in the notification group,
similarly to what is done for other events.  FAN_FS_ERROR is not
handled specially, since the memory is now handled by a preallocated
mempool.

For now, make the event unhashed.  A future patch implements merging of
this kind of event.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v7:
  - WARN_ON -> WARN_ON_ONCE (Amir)
---
 fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++++++++++++++++++
 fs/notify/fanotify/fanotify.h |  6 ++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 01d68dfc74aa..1f195c95dfcd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -574,6 +574,27 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	return &fne->fae;
 }
 
+static struct fanotify_event *fanotify_alloc_error_event(
+						struct fsnotify_group *group,
+						__kernel_fsid_t *fsid,
+						const void *data, int data_type)
+{
+	struct fs_error_report *report =
+			fsnotify_data_error_report(data, data_type);
+	struct fanotify_error_event *fee;
+
+	if (WARN_ON_ONCE(!report))
+		return NULL;
+
+	fee = mempool_alloc(&group->fanotify_data.error_events_pool, GFP_NOFS);
+	if (!fee)
+		return NULL;
+
+	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
+
+	return &fee->fae;
+}
+
 static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 						   u32 mask, const void *data,
 						   int data_type, struct inode *dir,
@@ -641,6 +662,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
+	} else if (fanotify_is_error_event(mask)) {
+		event = fanotify_alloc_error_event(group, fsid, data,
+						   data_type);
 	} else if (name_event && (file_name || child)) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, child,
 						  &hash, gfp);
@@ -850,6 +874,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 	kfree(FANOTIFY_NE(event));
 }
 
+static void fanotify_free_error_event(struct fsnotify_group *group,
+				      struct fanotify_event *event)
+{
+	struct fanotify_error_event *fee = FANOTIFY_EE(event);
+
+	mempool_free(fee, &group->fanotify_data.error_events_pool);
+}
+
 static void fanotify_free_event(struct fsnotify_group *group,
 				struct fsnotify_event *fsn_event)
 {
@@ -873,6 +905,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
 	case FANOTIFY_EVENT_TYPE_OVERFLOW:
 		kfree(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_FS_ERROR:
+		fanotify_free_error_event(group, event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a577e87fac2b..ebef952481fa 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -298,6 +298,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct fanotify_event, fse);
 }
 
+static inline bool fanotify_is_error_event(u32 mask)
+{
+	return mask & FAN_FS_ERROR;
+}
+
 static inline bool fanotify_event_has_path(struct fanotify_event *event)
 {
 	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
@@ -327,6 +332,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
 	return !(fanotify_is_perm_event(mask) ||
+		 fanotify_is_error_event(mask) ||
 		 fsnotify_is_overflow_event(mask));
 }
 
-- 
2.33.0

