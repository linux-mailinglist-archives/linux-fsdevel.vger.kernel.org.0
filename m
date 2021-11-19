Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4E456AD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhKSHU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhKSHU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C0C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so6724529wme.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OU8HHTRykLCD6sM7gHw1h3Vmry3Tv1Z13eRE57f+m9M=;
        b=DTFvyBN40JiwmX1TENllhxwgU2BMDPL/bU7IV6wrh+H9OTfxw9cVwmVGOw5vkD6pQY
         smRnkupNVxZyxapXxOsVUfO9e9P3owpIT7GQEgg12GfGMRusw0tUzPuBhpEW8PDFcL7l
         DIjRpbsKsduETcMW8jHXhFYia4iWnURf0jSBsNdKdZq7azxHqSWTYGyuLZ0ctH0VlRf/
         68jpf19JlMmOAGk4YA1y3WIt5bqp+kFjO90OQEczEOiW2/CYEp0I13fP/+9A0rG/2qDb
         625qUc0iveVh9OEVlHWGkNYNiG/GOD7C14YXkDhQvS+Vesf9RuT6eFZDu9vt2awL3Qxe
         SOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OU8HHTRykLCD6sM7gHw1h3Vmry3Tv1Z13eRE57f+m9M=;
        b=5T0jV4uYhgCWNuj8CRf3cegvsIgqRYWowScJ/ygbDVQDd0S2ONy8Dbf6iB8rKa+5IL
         bI02AX1Oyt0wXiE7cA68Vq7/RghaDLL0CQ8hSxH7eapC/RvDszs56+JEWpJZrp0onvFS
         PvBrVquyQwj+w12vsewOhVEa/Dn+TYFPD2fimyjfcPjuOaxOHMWrOA999Y/eDGvE5YK8
         bnZcqMXo/mlwdp+nq/wx0Cgm2JZ8siYwHmAlWUt7aHUngUygzUSKy+0bh8s5cQ93jOQO
         9/vHizO3FLldiWznEYR5Om0scRZStHtVXkLpT7WKM02d0I0hpPOfFsXiY8iK6sS7+nny
         CCHQ==
X-Gm-Message-State: AOAM532FgWu5fzqAZDy8Rg/Bg0uH6xCFn9Xe+ia+Yk1XFbe4ndrlAlZV
        NG/5UjjII4MmbgSaGzE73Bs=
X-Google-Smtp-Source: ABdhPJyyekg7B16QETIJjSNCXhFaAZzZYj93qh011Du02ksfaflIev+jYG8PERjyPlv7gkv/3FmckA==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr4212820wmk.78.1637306274361;
        Thu, 18 Nov 2021 23:17:54 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:53 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 8/9] fanotify: report old and/or new parent+name in FAN_RENAME event
Date:   Fri, 19 Nov 2021 09:17:37 +0200
Message-Id: <20211119071738.1348957-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify.c      |  7 ++++
 fs/notify/fanotify/fanotify.h      | 18 ++++++++++
 fs/notify/fanotify/fanotify_user.c | 53 +++++++++++++++++++++++++++---
 include/uapi/linux/fanotify.h      |  6 ++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c0a3fb1dd066..4f06b17e209d 100644
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
index ba72e49819f1..5ec60db3cfbb 100644
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
@@ -163,6 +179,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
+
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
@@ -379,6 +396,8 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			return -EFAULT;
 		break;
 	case FAN_EVENT_INFO_TYPE_DFID_NAME:
+	case FAN_EVENT_INFO_TYPE_OLD_DFID_NAME:
+	case FAN_EVENT_INFO_TYPE_NEW_DFID_NAME:
 		if (WARN_ON_ONCE(!name || !name_len))
 			return -EFAULT;
 		break;
@@ -478,11 +497,19 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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
@@ -496,6 +523,22 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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

