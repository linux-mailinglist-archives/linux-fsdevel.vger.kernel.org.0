Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C933CFEBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhGTP1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:27:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56022 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbhGTPTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:19:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 842631F43128
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v4 02/16] fanotify: Fold event size calculation to its own function
Date:   Tue, 20 Jul 2021 11:59:30 -0400
Message-Id: <20210720155944.1447086-3-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720155944.1447086-1-krisman@collabora.com>
References: <20210720155944.1447086-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Every time this function is invoked, it is immediately added to
FAN_EVENT_METADATA_LEN, since there is no need to just calculate the
length of info records. This minor clean up folds the rest of the
calculation into the function, which now operates in terms of events,
returning the size of the entire event, including metadata.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - rebased on top of hashing patches
---
 fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 64864fb40b40..68a53d3534f8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -117,17 +117,24 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
 }
 
-static int fanotify_event_info_len(unsigned int fid_mode,
-				   struct fanotify_event *event)
+static size_t fanotify_event_len(struct fanotify_event *event,
+				 unsigned int fid_mode)
 {
-	struct fanotify_info *info = fanotify_event_info(event);
-	int dir_fh_len = fanotify_event_dir_fh_len(event);
-	int fh_len = fanotify_event_object_fh_len(event);
-	int info_len = 0;
+	size_t event_len = FAN_EVENT_METADATA_LEN;
+	struct fanotify_info *info;
+	int dir_fh_len;
+	int fh_len;
 	int dot_len = 0;
 
+	if (!fid_mode)
+		return event_len;
+
+	info = fanotify_event_info(event);
+	dir_fh_len = fanotify_event_dir_fh_len(event);
+	fh_len = fanotify_event_object_fh_len(event);
+
 	if (dir_fh_len) {
-		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
+		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
 	} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
 		/*
 		 * With group flag FAN_REPORT_NAME, if name was not recorded in
@@ -137,9 +144,9 @@ static int fanotify_event_info_len(unsigned int fid_mode,
 	}
 
 	if (fh_len)
-		info_len += fanotify_fid_info_len(fh_len, dot_len);
+		event_len += fanotify_fid_info_len(fh_len, dot_len);
 
-	return info_len;
+	return event_len;
 }
 
 /*
@@ -168,7 +175,7 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
 static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 					    size_t count)
 {
-	size_t event_size = FAN_EVENT_METADATA_LEN;
+	size_t event_size;
 	struct fanotify_event *event = NULL;
 	struct fsnotify_event *fsn_event;
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
@@ -181,8 +188,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		goto out;
 
 	event = FANOTIFY_E(fsn_event);
-	if (fid_mode)
-		event_size += fanotify_event_info_len(fid_mode, event);
+	event_size = fanotify_event_len(event, fid_mode);
 
 	if (event_size > count) {
 		event = ERR_PTR(-EINVAL);
@@ -412,8 +418,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
-	metadata.event_len = FAN_EVENT_METADATA_LEN +
-				fanotify_event_info_len(fid_mode, event);
+	metadata.event_len = fanotify_event_len(event, fid_mode);
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
-- 
2.32.0

