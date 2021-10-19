Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58477432AE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhJSAFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJSAFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:05:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616CC06161C;
        Mon, 18 Oct 2021 17:03:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9C55D1F43440;
        Tue, 19 Oct 2021 01:03:34 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 24/32] fanotify: Add helpers to decide whether to report FID/DFID
Date:   Mon, 18 Oct 2021 21:00:07 -0300
Message-Id: <20211019000015.1666608-25-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that there is an event that reports FID records even for a zeroed
file handle, wrap the logic that deides whether to issue the records
into helper functions.  This shouldn't have any impact on the code, but
simplifies further patches.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
 fs/notify/fanotify/fanotify_user.c | 13 +++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a5e81d759f65..bdf01ad4f9bf 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -265,6 +265,19 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
 	return info ? fanotify_info_dir_fh_len(info) : 0;
 }
 
+static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
+{
+	if (fanotify_event_object_fh_len(event) > 0)
+		return true;
+
+	return false;
+}
+
+static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
+{
+	return (fanotify_event_dir_fh_len(event) > 0) ? true : false;
+}
+
 struct fanotify_path_event {
 	struct fanotify_event fae;
 	struct path path;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a860c286e885..ae848306a017 100644
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

