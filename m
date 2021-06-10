Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281043A2149
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 02:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFJAXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFJAXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:23:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46687C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jun 2021 17:21:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so1615710pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/RrtSTzYOnaecnELz3PRF2XrFTZFYV/pfiIbnAfcV68=;
        b=LYp5DruWKTKzR1aLLCYODCcomIFP98N199CfO5jB+CcrsVq6XpPdoL/QipUkdIsNS0
         M7C04wiFPEYejK22czv+C+yclhz8b8lg9DILE5cF3Xd1KJVPacWMG5Ll9l/pEKwBrU9u
         tzuWWWCe5BEArAINLLp9Qs2i3hf3fKFrYeCAEbEjJgS1CyeNMj+xvpx3BRUVrVrTShLX
         oM0FnxyQbSTDVXmjwUn7q2d+466tGbUSt4LK/7KZjrmpnoNnLPiMfWN56IJfv940eTdi
         j4lZEt5+om6OgHgAs6jRAyvZWEjLDgwVUky4pL9AgYsbRqXOL+jZmw8JXVIOaWwlikhS
         HOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RrtSTzYOnaecnELz3PRF2XrFTZFYV/pfiIbnAfcV68=;
        b=f44DWoAzDDLdHFX2G0nKtLBl7lrUG0PZKZiaW4mFxK2k0EdekrofRTpf5pgg0UG6Wi
         WIiV93l3ClSkwL/rjdS3mL8koRbozBCcSD3OlOpDul6cHCpPFQrzSinC8jGtLATd2HWA
         qQqyDsGxaMtGBOnZZE45oqB0NRqQOk4sD3+j9mgKwhx8SiNlOFH1y9F7YN/o7Is34afs
         kWWDENMKqvm522RBSCku/c9/Kz++HsX4sFPmokZniQxi8tuBcZZEFKo9lGZYtyQeVEl7
         fU2FD08jzLPPnt0rNbhI1pxRgargoiZX8bEbs+yrCZf8mYQedvA+FJi2CGFXfWkvB1TQ
         0/5g==
X-Gm-Message-State: AOAM532dNGrhAKyNm5TkhLFJXYYo9hhVjXIMMZoEfi/v25ZIk+VYkYGl
        bMFb49GbBqEBD/2wMnMDRGPaSQ==
X-Google-Smtp-Source: ABdhPJxeB9Nv++FOprXjoBmEJXmmRJ9d/BpBRmrydAG+w+qckfJ0K4lnL4TXIn0ZOacYmZLf13PGSQ==
X-Received: by 2002:a17:90b:3593:: with SMTP id mm19mr366857pjb.28.1623284500602;
        Wed, 09 Jun 2021 17:21:40 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id g141sm556748pfb.210.2021.06.09.17.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:21:39 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:21:28 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying helper
Message-ID: <be8a5826badaf8ff97d9301069efd8f4cc41d2c2.1623282854.git.repnop@google.com>
References: <cover.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623282854.git.repnop@google.com>
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
FAN_REPORT_PIDFD initialisation flag is introduced.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---

Changes since v1:

* Renamed the new helper from copy_info_to_user() to
  copy_info_records_to_user().

* From the copy_info_records_to_user() helper, the total number of
  bytes that were copied to the user supplied buffer are returned,
  rather than only returning the number of bytes copied in the last
  call to copy_to_user().

 fs/notify/fanotify/fanotify_user.c | 155 ++++++++++++++++-------------
 include/linux/fanotify.h           |   2 +
 2 files changed, 90 insertions(+), 67 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6223ffd0e4db..85d6eea8d45d 100644
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
+			 * record has type DFID for directory entry
+			 * modificatio\ n event and for event on a directory.
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
+	if (info_mode) {
+		ret = copy_info_records_to_user(event, info, info_mode,
+						buf, count);
 		if (ret < 0)
 			return ret;
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
-		if (ret < 0)
-			return ret;
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
2.30.2

/M
