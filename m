Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AA43A0CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhJYTfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:35:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhJYTcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:32:52 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DD4671F430E8;
        Mon, 25 Oct 2021 20:30:28 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 23/31] fanotify: Add helpers to decide whether to report FID/DFID
Date:   Mon, 25 Oct 2021 16:27:38 -0300
Message-Id: <20211025192746.66445-24-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that there is an event that reports FID records even for a zeroed
file handle, wrap the logic that deides whether to issue the records
into helper functions.  This shouldn't have any impact on the code, but
simplifies further patches.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v8:
  - Simplify constructs (Amir)
---
 fs/notify/fanotify/fanotify.h      | 10 ++++++++++
 fs/notify/fanotify/fanotify_user.c | 13 +++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 3510d06654ed..80af269eebb8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -264,6 +264,16 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
 	return info ? fanotify_info_dir_fh_len(info) : 0;
 }
 
+static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
+{
+	return fanotify_event_object_fh_len(event) > 0;
+}
+
+static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
+{
+	return fanotify_event_dir_fh_len(event) > 0;
+}
+
 struct fanotify_path_event {
 	struct fanotify_event fae;
 	struct path path;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2f4182b754b2..a9b5c36ee49e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -140,10 +140,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		return event_len;
 
 	info = fanotify_event_info(event);
-	dir_fh_len = fanotify_event_dir_fh_len(event);
-	fh_len = fanotify_event_object_fh_len(event);
 
-	if (dir_fh_len) {
+	if (fanotify_event_has_dir_fh(event)) {
+		dir_fh_len = fanotify_event_dir_fh_len(event);
 		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
 	} else if ((info_mode & FAN_REPORT_NAME) &&
 		   (event->mask & FAN_ONDIR)) {
@@ -157,8 +156,10 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
 
-	if (fh_len)
+	if (fanotify_event_has_object_fh(event)) {
+		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
+	}
 
 	return event_len;
 }
@@ -451,7 +452,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 	/*
 	 * Event info records order is as follows: dir fid + name, child fid.
 	 */
-	if (fanotify_event_dir_fh_len(event)) {
+	if (fanotify_event_has_dir_fh(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
 					     FAN_EVENT_INFO_TYPE_DFID;
 		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
@@ -467,7 +468,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
-	if (fanotify_event_object_fh_len(event)) {
+	if (fanotify_event_has_object_fh(event)) {
 		const char *dot = NULL;
 		int dot_len = 0;
 
-- 
2.33.0

