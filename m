Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6D3E390C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 07:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhHHF0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 01:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHHF03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 01:26:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCCC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 22:26:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so29194144pjs.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smGLGyk968rUQUb/0XYMSEG+2NTZNNWq2aZxOZwXNrM=;
        b=CivhSrQOx2asM8d2i6Fsv1ek3X7bCyGRQYSUlVuXFz39zOUd6MvcmY2mT/TlGuAEUG
         UqDbxYQl1cIA5smpTJrNgq63746RBFWPukvwfufevCspifgTkjcBS1V7ORRTt34ERGeP
         uJ5jYAHDoT0XJY04KHd/tik4V0Vh0fpGSDN2BI0DdGQ09HXoabSwawTXPhQVF9t5vKGH
         +Tez6nA9qVFppdJVz8dimi9LU7HDY0lh/ltwsXWzH3XRFc1LL1zxqRs0gALyLBlMtvYG
         MF5Vx9Fg9+r6/OxC8xXY1Wt5NiQP9j/6OuQ/U7iM/wBwyCGDqIKbYYcFvkvFl/7gReuy
         EwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smGLGyk968rUQUb/0XYMSEG+2NTZNNWq2aZxOZwXNrM=;
        b=QJBsCKaP2ySLi4TCQQEW+42NJD3j14FdX70JrH1Daq70NC2zOO+QBkwYHJj4I2iSzk
         vfYC+v523LyLDrBy9Pui+ZEwxB6yRd1PrkIq7nCRmPG2xKtcqCNS18Os8JM3vn8Oj+OE
         sTgZtPQWR91VRNj/8BTO4OzVnxhKna+KWxEW5rPoSujbLYVt4o4mUF+xKwK/l25VcXxD
         bb2YbGk7cTjbwcHf765689SDRW7PcKGq6Hag7i2gLrEZ4ETQeX/YA6Iv0e1HUtVxlr6k
         Nx8ir3Llxc7n74WALYD43fvyS7gVh7aRg/mqinziMs8DABVjpcN2fRWpM7PS7YylEzS5
         B9Yg==
X-Gm-Message-State: AOAM530LgcFgk52tX1FDWDcAQ3Ef/zN2wAZFITWVKHGkDnpTWScG+bWF
        r4vf5R9LDsQWPV3/AOiAWl3rsQ==
X-Google-Smtp-Source: ABdhPJyTfQf/PrLwWrUBfE80lW7353i+0I1hYNkKcVeQc9SIbiJLGTCcO167b/JdUEaUY6O8L6QH3A==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr28832639pjg.229.1628400370653;
        Sat, 07 Aug 2021 22:26:10 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c29e:146d:490d:33cc])
        by smtp.gmail.com with ESMTPSA id 143sm11076911pfx.1.2021.08.07.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 22:26:10 -0700 (PDT)
Date:   Sun, 8 Aug 2021 15:25:58 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 4/5] fanotify: introduce a generic info record copying
 helper
Message-ID: <8872947dfe12ce8ae6e9a7f2d49ea29bc8006af0.1628398044.git.repnop@google.com>
References: <cover.1628398044.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628398044.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The copy_info_records_to_user() helper allows for the separation of
info record copying routines/conditionals from copy_event_to_user(),
which reduces the overall clutter within this function. This becomes
especially true as we start introducing additional info records in the
future i.e. struct fanotify_event_info_pidfd. On success, this helper
returns the total amount of bytes that have been copied into the user
supplied buffer and on error, a negative value is returned to the
caller.

The newly defined macro FANOTIFY_INFO_MODES can be used to obtain info
record types that have been enabled for a specific notification
group. This macro becomes useful in the subsequent patch when the
FAN_REPORT_PIDFD initialization flag is introduced.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v3:

 * Updated a typo (s/modification \n/modification) in the
   copy_info_records_to_user() helper.

 fs/notify/fanotify/fanotify_user.c | 155 ++++++++++++++++-------------
 include/linux/fanotify.h           |   2 +
 2 files changed, 90 insertions(+), 67 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 182fea255376..99d145eaab49 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -173,7 +173,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	size_t event_size = FAN_EVENT_METADATA_LEN;
 	struct fanotify_event *event = NULL;
 	struct fsnotify_event *fsn_event;
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 
 	pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
 
@@ -183,8 +183,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		goto out;
 
 	event = FANOTIFY_E(fsn_event);
-	if (fid_mode)
-		event_size += fanotify_event_info_len(fid_mode, event);
+	if (info_mode)
+		event_size += fanotify_event_info_len(info_mode, event);
 
 	if (event_size > count) {
 		event = ERR_PTR(-EINVAL);
@@ -401,6 +401,86 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	return info_len;
 }
 
+static int copy_info_records_to_user(struct fanotify_event *event,
+				     struct fanotify_info *info,
+				     unsigned int info_mode,
+				     char __user *buf, size_t count)
+{
+	int ret, total_bytes = 0, info_type = 0;
+	unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
+
+	/*
+	 * Event info records order is as follows: dir fid + name, child fid.
+	 */
+	if (fanotify_event_dir_fh_len(event)) {
+		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
+					     FAN_EVENT_INFO_TYPE_DFID;
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_info_dir_fh(info),
+					    info_type,
+					    fanotify_info_name(info),
+					    info->name_len, buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
+	if (fanotify_event_object_fh_len(event)) {
+		const char *dot = NULL;
+		int dot_len = 0;
+
+		if (fid_mode == FAN_REPORT_FID || info_type) {
+			/*
+			 * With only group flag FAN_REPORT_FID only type FID is
+			 * reported. Second info record type is always FID.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_FID;
+		} else if ((fid_mode & FAN_REPORT_NAME) &&
+			   (event->mask & FAN_ONDIR)) {
+			/*
+			 * With group flag FAN_REPORT_NAME, if name was not
+			 * recorded in an event on a directory, report the name
+			 * "." with info type DFID_NAME.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
+			dot = ".";
+			dot_len = 1;
+		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
+			   (event->mask & FAN_ONDIR)) {
+			/*
+			 * With group flag FAN_REPORT_DIR_FID, a single info
+			 * record has type DFID for directory entry modification
+			 * event and for event on a directory.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_DFID;
+		} else {
+			/*
+			 * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
+			 * a single info record has type FID for event on a
+			 * non-directory, when there is no directory to report.
+			 * For example, on FAN_DELETE_SELF event.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_FID;
+		}
+
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_event_object_fh(event),
+					    info_type, dot, dot_len,
+					    buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
+	return total_bytes;
+}
+
 static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  struct fanotify_event *event,
 				  char __user *buf, size_t count)
@@ -408,15 +488,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct fanotify_event_metadata metadata;
 	struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 	struct file *f = NULL;
 	int ret, fd = FAN_NOFD;
-	int info_type = 0;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
 	metadata.event_len = FAN_EVENT_METADATA_LEN +
-				fanotify_event_info_len(fid_mode, event);
+				fanotify_event_info_len(info_mode, event);
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
@@ -465,69 +544,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (f)
 		fd_install(fd, f);
 
-	/* Event info records order is: dir fid + name, child fid */
-	if (fanotify_event_dir_fh_len(event)) {
-		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
-					     FAN_EVENT_INFO_TYPE_DFID;
-		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
-					    fanotify_info_dir_fh(info),
-					    info_type,
-					    fanotify_info_name(info),
-					    info->name_len, buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-
-		buf += ret;
-		count -= ret;
-	}
-
-	if (fanotify_event_object_fh_len(event)) {
-		const char *dot = NULL;
-		int dot_len = 0;
-
-		if (fid_mode == FAN_REPORT_FID || info_type) {
-			/*
-			 * With only group flag FAN_REPORT_FID only type FID is
-			 * reported. Second info record type is always FID.
-			 */
-			info_type = FAN_EVENT_INFO_TYPE_FID;
-		} else if ((fid_mode & FAN_REPORT_NAME) &&
-			   (event->mask & FAN_ONDIR)) {
-			/*
-			 * With group flag FAN_REPORT_NAME, if name was not
-			 * recorded in an event on a directory, report the
-			 * name "." with info type DFID_NAME.
-			 */
-			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
-			dot = ".";
-			dot_len = 1;
-		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
-			   (event->mask & FAN_ONDIR)) {
-			/*
-			 * With group flag FAN_REPORT_DIR_FID, a single info
-			 * record has type DFID for directory entry modification
-			 * event and for event on a directory.
-			 */
-			info_type = FAN_EVENT_INFO_TYPE_DFID;
-		} else {
-			/*
-			 * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
-			 * a single info record has type FID for event on a
-			 * non-directory, when there is no directory to report.
-			 * For example, on FAN_DELETE_SELF event.
-			 */
-			info_type = FAN_EVENT_INFO_TYPE_FID;
-		}
-
-		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
-					    fanotify_event_object_fh(event),
-					    info_type, dot, dot_len,
-					    buf, count);
+	if (info_mode) {
+		ret = copy_info_records_to_user(event, info, info_mode,
+						buf, count);
 		if (ret < 0)
 			goto out_close_fd;
-
-		buf += ret;
-		count -= ret;
 	}
 
 	return metadata.event_len;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index a16dbeced152..10a7e26ddba6 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -27,6 +27,8 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS)
+
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
  * We do not allow unprivileged groups to request permission events.
-- 
2.32.0.605.g8dce9f2422-goog

/M
