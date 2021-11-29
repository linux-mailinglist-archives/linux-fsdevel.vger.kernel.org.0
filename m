Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D64624AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhK2WYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhK2WV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A0C06FD4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l16so39415135wrp.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4czDWzMUzMhwHvdv20NTVGMnb1sHZUJx8LY6WwUiZk=;
        b=jPH8xrApkBBEQb2A+qYGDCUn6wG1R1FrtTN9xiBctaZw2+vT2ZSwV72NNfjfMGbdOZ
         ln9GjVGLVftaIOGtWhuC7Y+YiO1Y4s2i0/TJVcnBR3DnRbkPfdYIcXBWzTRtbDEwErM2
         KQT6sw1+04P3sLXviDGNsNqnYPRWzoXbHIyZVMDG4eBgIHb1TuxjygfPajmEqs3IovsJ
         TbZidtb6P3b8PCRT6kIJc2/3veJdjAtRjKY4S5WM7s2Xw6ZReqO78QQ/oVLssznXV0qL
         m6RsLGbh57x/qHYieICp21Aej9BdhO9vorgidKoFS1hCldPL+ZdCbPCnZ11szeaemqzO
         /BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4czDWzMUzMhwHvdv20NTVGMnb1sHZUJx8LY6WwUiZk=;
        b=KecCha4IK8DfmE8TmSIkvNAkyLXIXvKLJYFuBJIM4GFasvkyF7UgDsAwHg5nhBc7tK
         ih8lFXVBedVEfxVlOPztXBL/DToYrKiiBM2lV04DMkeNU1U4uWYnq+G80Htp/ewYcjyi
         egd4G4+dq9IqX7Dw9j8roAO2ZB40jKgLKNQ5E3Z+/ytwjrA0l30bH/mAsgGWpjXbJDZD
         p9x576V1UOlGmF0NoCnA9dE2237ee9UTeT+WejonJ2I2xKa5pCFo8a3TvuE4vxhf/JE3
         m5dTpcguzt8M8otRPd+nemwtSdTbNVrkP2RdsDs7AIPHcSAbTmAk+Hf6RZgq6Eys+U9l
         X7aQ==
X-Gm-Message-State: AOAM532SMIj4zEnvkNaqeUJO8Z+BZ7EmxnPmtCieScRqitKy4HOyU0En
        cv+rxOIDPFF3vqoK+19hA44=
X-Google-Smtp-Source: ABdhPJw0S0b3B810cL2ZPQa38+Kl0aGra7o8c6geWr+vHyjAOE22f3j6MakT+24Nc8tEfcvC15NCFQ==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr37331262wru.366.1638216951555;
        Mon, 29 Nov 2021 12:15:51 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:51 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 10/11] fanotify: report old and/or new parent+name in FAN_RENAME event
Date:   Mon, 29 Nov 2021 22:15:36 +0200
Message-Id: <20211129201537.1932819-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the special case of FAN_RENAME event, we report old or new or both
old and new parent+name.

A single info record will be reported if either the old or new dir
is watched and two records will be reported if both old and new dir
(or their filesystem) are watched.

The old and new parent+name are reported using new info record types
FAN_EVENT_INFO_TYPE_{OLD,NEW}_DFID_NAME, so if a single info record
is reported, it is clear to the application, to which dir entry the
fid+name info is referring to.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  9 +++++-
 fs/notify/fanotify/fanotify.h      | 18 +++++++++++
 fs/notify/fanotify/fanotify_user.c | 52 +++++++++++++++++++++++++++---
 include/uapi/linux/fanotify.h      |  6 ++++
 4 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 050f0fa79079..f8cca428361e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -153,6 +153,13 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 	if ((old->mask & FS_ISDIR) != (new->mask & FS_ISDIR))
 		return false;
 
+	/*
+	 * FAN_RENAME event is reported with special info record types,
+	 * so we cannot merge it with other events.
+	 */
+	if ((old->mask & FAN_RENAME) != (new->mask & FAN_RENAME))
+		return false;
+
 	switch (old->type) {
 	case FANOTIFY_EVENT_TYPE_PATH:
 		return fanotify_path_equal(fanotify_event_path(old),
@@ -767,7 +774,7 @@ static struct fanotify_event *fanotify_alloc_event(
 		if (mask & FAN_RENAME) {
 			bool report_old, report_new;
 
-			if (WARN_ON_ONCE(!(match_info.report_mask)))
+			if (WARN_ON_ONCE(!(match_info->report_mask)))
 				return NULL;
 
 			/* Report both old and new parent+name if sb watching */
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 8fa3bc0effd4..a3d5b751cac5 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -373,6 +373,13 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
 	return info ? fanotify_info_dir_fh_len(info) : 0;
 }
 
+static inline int fanotify_event_dir2_fh_len(struct fanotify_event *event)
+{
+	struct fanotify_info *info = fanotify_event_info(event);
+
+	return info ? fanotify_info_dir2_fh_len(info) : 0;
+}
+
 static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
 {
 	/* For error events, even zeroed fh are reported. */
@@ -386,6 +393,17 @@ static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
 	return fanotify_event_dir_fh_len(event) > 0;
 }
 
+static inline bool fanotify_event_has_dir2_fh(struct fanotify_event *event)
+{
+	return fanotify_event_dir2_fh_len(event) > 0;
+}
+
+static inline bool fanotify_event_has_any_dir_fh(struct fanotify_event *event)
+{
+	return fanotify_event_has_dir_fh(event) ||
+		fanotify_event_has_dir2_fh(event);
+}
+
 struct fanotify_path_event {
 	struct fanotify_event fae;
 	struct path path;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e4a11f56782d..eb2a0251b318 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -129,12 +129,29 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 		       FANOTIFY_EVENT_ALIGN);
 }
 
+/* FAN_RENAME may have one or two dir+name info records */
+static int fanotify_dir_name_info_len(struct fanotify_event *event)
+{
+	struct fanotify_info *info = fanotify_event_info(event);
+	int dir_fh_len = fanotify_event_dir_fh_len(event);
+	int dir2_fh_len = fanotify_event_dir2_fh_len(event);
+	int info_len = 0;
+
+	if (dir_fh_len)
+		info_len += fanotify_fid_info_len(dir_fh_len,
+						  info->name_len);
+	if (dir2_fh_len)
+		info_len += fanotify_fid_info_len(dir2_fh_len,
+						  info->name2_len);
+
+	return info_len;
+}
+
 static size_t fanotify_event_len(unsigned int info_mode,
 				 struct fanotify_event *event)
 {
 	size_t event_len = FAN_EVENT_METADATA_LEN;
 	struct fanotify_info *info;
-	int dir_fh_len;
 	int fh_len;
 	int dot_len = 0;
 
@@ -146,9 +163,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
 
 	info = fanotify_event_info(event);
 
-	if (fanotify_event_has_dir_fh(event)) {
-		dir_fh_len = fanotify_event_dir_fh_len(event);
-		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
+	if (fanotify_event_has_any_dir_fh(event)) {
+		event_len += fanotify_dir_name_info_len(event);
 	} else if ((info_mode & FAN_REPORT_NAME) &&
 		   (event->mask & FAN_ONDIR)) {
 		/*
@@ -379,6 +395,8 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			return -EFAULT;
 		break;
 	case FAN_EVENT_INFO_TYPE_DFID_NAME:
+	case FAN_EVENT_INFO_TYPE_OLD_DFID_NAME:
+	case FAN_EVENT_INFO_TYPE_NEW_DFID_NAME:
 		if (WARN_ON_ONCE(!name || !name_len))
 			return -EFAULT;
 		break;
@@ -478,11 +496,19 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 
 	/*
-	 * Event info records order is as follows: dir fid + name, child fid.
+	 * Event info records order is as follows:
+	 * 1. dir fid + name
+	 * 2. (optional) new dir fid + new name
+	 * 3. (optional) child fid
 	 */
 	if (fanotify_event_has_dir_fh(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
 					     FAN_EVENT_INFO_TYPE_DFID;
+
+		/* FAN_RENAME uses special info types */
+		if (event->mask & FAN_RENAME)
+			info_type = FAN_EVENT_INFO_TYPE_OLD_DFID_NAME;
+
 		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
 					    fanotify_info_dir_fh(info),
 					    info_type,
@@ -496,6 +522,22 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	/* New dir fid+name may be reported in addition to old dir fid+name */
+	if (fanotify_event_has_dir2_fh(event)) {
+		info_type = FAN_EVENT_INFO_TYPE_NEW_DFID_NAME;
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_info_dir2_fh(info),
+					    info_type,
+					    fanotify_info_name2(info),
+					    info->name2_len, buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	if (fanotify_event_has_object_fh(event)) {
 		const char *dot = NULL;
 		int dot_len = 0;
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 9d0e2dc5767b..e8ac38cc2fd6 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -134,6 +134,12 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 
+/* Special info types for FAN_RENAME */
+#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
+/* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID	11 */
+#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME	12
+/* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID	13 */
+
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
 	__u8 info_type;
-- 
2.33.1

