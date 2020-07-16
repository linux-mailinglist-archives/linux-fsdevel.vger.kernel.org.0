Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E2221EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGPInL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgGPInI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3286C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so9428767wmi.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iad1S2lFhDhoRYQbO5m1a69RfmaoOh0Vt4HIwiGJtvE=;
        b=culh9SIT8vaBAQzI+0OUictpGk0I06cJFwrqGfpYUT2uePJehV0epbc2FHHoQYE6VV
         ofPhQMOBpdGcVmopSuv1GFZl3InjhNZtAR732kanxniJK8PpH756L323WarHEsyaqNmH
         K7PuOmSL95lgbVAvV0f/lK1HaVaVzJcpefMi/9gjljq49LLpgawdX971jLV2/hTX3B7v
         4Y/46IPeNIiivLxTH6pWs6mt2EpwDQbstvkHI9oBnMvxaA0397bc79ytt3b4FBlzBRxK
         9MgJy1a72G5HjzQm5bLXoNapS3wOJwB5T4m4d+ilB94SDXuiDlYIqI8tOQgFJo0kWqRR
         A/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iad1S2lFhDhoRYQbO5m1a69RfmaoOh0Vt4HIwiGJtvE=;
        b=i/ljRUxYsOg1HUY3v+rPjRm4BKUYDp4Q7ZwAoiz0ZPC/G32knVQF+e4JkSrUSlmYJQ
         uhSj12vBNiykIxPtlqtDOG9qYG6ksJ16uGaXqto3RQnKxh1hoK+Q/f2LHwlga6tKP78V
         4bcbnlWOa3FpgflqiDyv3ow/g2/KJEB3+cYiw46r+94f6qT+IUKxePHrQcwvhH/4go2G
         CtWFRtI1wwAUqYbCf/1RkYugWmBT1Ro6zYL0TqPPsAa/PNQWBUcZ7HgVzo/hOJd0HFad
         ld3qFfPO6X9dsP6BnBEwp/q7sQkWXvYZ77DWyUGnBu0gMRViSGhO/XINb1nIn800jGDn
         8Low==
X-Gm-Message-State: AOAM533sQk9wLJXYVhNFukEehKQuKchxKdbXdIkOzTSopj2YwtYO47nG
        xJZuelFpcGsw2IrYjidjy04=
X-Google-Smtp-Source: ABdhPJwBq3ariwY8bMkJcPlkE22CHnHzz78WUPG0IY6q4iI7R4CFmOJjjS/ouxiC3cfIhcsOc1TvNQ==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr3311839wmi.35.1594888985506;
        Thu, 16 Jul 2020 01:43:05 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:43:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 21/22] fanotify: report parent fid + name + child fid
Date:   Thu, 16 Jul 2020 11:42:29 +0300
Message-Id: <20200716084230.30611-22-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a group with fanotify_init() flag FAN_REPORT_DFID_NAME, the parent
fid and name are reported for events on non-directory objects with an
info record of type FAN_EVENT_INFO_TYPE_DFID_NAME.

If the group also has the init flag FAN_REPORT_FID, the child fid
is also reported with another info record that follows the first info
record. The second info record is the same info record that would have
been reported to a group with only FAN_REPORT_FID flag.

When the child fid needs to be recorded, the variable size struct
fanotify_name_event is preallocated with enough space to store the
child fh between the dir fh and the name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 30 ++++++++++++++++++++++++++----
 fs/notify/fanotify/fanotify.h      |  8 +++++++-
 fs/notify/fanotify/fanotify_user.c |  3 ++-
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c77b37eb33a9..1d8eb886fe08 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -479,15 +479,22 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 							__kernel_fsid_t *fsid,
 							const struct qstr *file_name,
+							struct inode *child,
 							gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
-	struct fanotify_fh *dfh;
+	struct fanotify_fh *dfh, *ffh;
 	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
+	unsigned int child_fh_len = fanotify_encode_fh_len(child);
 	unsigned int size;
 
+	if (WARN_ON_ONCE(dir_fh_len % FANOTIFY_FH_HDR_LEN))
+		child_fh_len = 0;
+
 	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	if (child_fh_len)
+		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
 	if (file_name)
 		size += file_name->len + 1;
 	fne = kmalloc(size, gfp);
@@ -500,11 +507,15 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	fanotify_info_init(info);
 	dfh = fanotify_info_dir_fh(info);
 	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, 0);
+	if (child_fh_len) {
+		ffh = fanotify_info_file_fh(info);
+		info->file_fh_totlen = fanotify_encode_fh(ffh, child, child_fh_len, 0);
+	}
 	if (file_name)
 		fanotify_info_copy_name(info, file_name);
 
-	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u name_len=%u name='%.*s'\n",
-		 __func__, id->i_ino, size, dir_fh_len,
+	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
+		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
 
 	return &fne->fae;
@@ -521,9 +532,19 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	struct inode *child = NULL;
 	bool name_event = false;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dir) {
+		/*
+		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
+		 * report the child fid for events reported on a non-dir child
+		 * in addition to reporting the parent fid and child name.
+		 */
+		if ((fid_mode & FAN_REPORT_FID) &&
+		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
+			child = id;
+
 		id = fanotify_dfid_inode(mask, data, data_type, dir);
 
 		/*
@@ -559,7 +580,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
 	} else if (name_event && file_name) {
-		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
+		event = fanotify_alloc_name_event(id, fsid, file_name, child,
+						  gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, gfp);
 	} else {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 12c204b1489f..896c819a1786 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -193,6 +193,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->object_fh;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
+		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
 	else
 		return NULL;
 }
@@ -208,9 +210,13 @@ static inline struct fanotify_info *fanotify_event_info(
 
 static inline int fanotify_event_object_fh_len(struct fanotify_event *event)
 {
+	struct fanotify_info *info = fanotify_event_info(event);
 	struct fanotify_fh *fh = fanotify_event_object_fh(event);
 
-	return fh ? fh->len : 0;
+	if (info)
+		return info->file_fh_totlen ? fh->len : 0;
+	else
+		return fh ? fh->len : 0;
 }
 
 static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6b839790cb42..be328d7ee283 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -956,14 +956,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EINVAL;
 
 	/*
-	 * Reporting either object fid or dir fid.
 	 * Child name is reported with parent fid so requires dir fid.
+	 * If reporting child name, we can report both child fid and dir fid.
 	 */
 	switch (fid_mode) {
 	case 0:
 	case FAN_REPORT_FID:
 	case FAN_REPORT_DIR_FID:
 	case FAN_REPORT_DFID_NAME:
+	case FAN_REPORT_DFID_NAME | FAN_REPORT_FID:
 		break;
 	default:
 		return -EINVAL;
-- 
2.17.1

