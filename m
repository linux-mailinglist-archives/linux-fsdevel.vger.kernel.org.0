Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAE43A0AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhJYTdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:33:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhJYTax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:30:53 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C21AC1F4316F;
        Mon, 25 Oct 2021 20:28:28 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 05/31] fanotify: Fold event size calculation to its own function
Date:   Mon, 25 Oct 2021 16:27:20 -0300
Message-Id: <20211025192746.66445-6-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
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
Changes since v6:
  - Rebase on top of pidfd patches
Changes since v1:
  - rebased on top of hashing patches
---
 fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6facdf476255..6895ec310b5d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -126,17 +126,24 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 		       FANOTIFY_EVENT_ALIGN);
 }
 
-static int fanotify_event_info_len(unsigned int info_mode,
-				   struct fanotify_event *event)
+static size_t fanotify_event_len(unsigned int info_mode,
+				 struct fanotify_event *event)
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
 
+	if (!info_mode)
+		return event_len;
+
+	info = fanotify_event_info(event);
+	dir_fh_len = fanotify_event_dir_fh_len(event);
+	fh_len = fanotify_event_object_fh_len(event);
+
 	if (dir_fh_len) {
-		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
+		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
 	} else if ((info_mode & FAN_REPORT_NAME) &&
 		   (event->mask & FAN_ONDIR)) {
 		/*
@@ -147,12 +154,12 @@ static int fanotify_event_info_len(unsigned int info_mode,
 	}
 
 	if (info_mode & FAN_REPORT_PIDFD)
-		info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
+		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
 
 	if (fh_len)
-		info_len += fanotify_fid_info_len(fh_len, dot_len);
+		event_len += fanotify_fid_info_len(fh_len, dot_len);
 
-	return info_len;
+	return event_len;
 }
 
 /*
@@ -181,7 +188,7 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
 static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 					    size_t count)
 {
-	size_t event_size = FAN_EVENT_METADATA_LEN;
+	size_t event_size;
 	struct fanotify_event *event = NULL;
 	struct fsnotify_event *fsn_event;
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
@@ -194,8 +201,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		goto out;
 
 	event = FANOTIFY_E(fsn_event);
-	if (info_mode)
-		event_size += fanotify_event_info_len(info_mode, event);
+	event_size = fanotify_event_len(info_mode, event);
 
 	if (event_size > count) {
 		event = ERR_PTR(-EINVAL);
@@ -537,8 +543,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
-	metadata.event_len = FAN_EVENT_METADATA_LEN +
-				fanotify_event_info_len(info_mode, event);
+	metadata.event_len = fanotify_event_len(info_mode, event);
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
-- 
2.33.0

