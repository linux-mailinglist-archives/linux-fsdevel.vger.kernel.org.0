Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56108389B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 04:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhETCNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 22:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 22:13:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B5C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:11:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k15so10757237pgb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nElsQs9KhVjPVqSuH17xQ8oJCu/FAHZ5f7Ip3OvniLQ=;
        b=GM52TECYmDx45gJn/rI3RdKUP/ZhwEHElfbbUJ3bm9FkAhER3hOQGSBMb6MWFcNcGI
         0heLRrgFAbjSNeh7JP5HVhguba+qoKdmP/pJAGm66ssDTVMN/331f7jdQ7D+hh3LVUFj
         2PyqhWcVVQlrrMFUcguOgHe3+kmh7f5zgSa7KIFXHFoafA0BPHitRSxFXWLGMusjomRz
         q1jhElISKdgVFdyGCpq0WXRKlenXnq5+8MxWUWIMjjZz4SqWvoaJFPv+Nkg45SzYFjqw
         R4KfB+4y94l0Rb/s+mgFKW1VWu7JPvNPZD5EMYuNbYyN9u5RFI7RVOSRQZxnV/yVAxzv
         e+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nElsQs9KhVjPVqSuH17xQ8oJCu/FAHZ5f7Ip3OvniLQ=;
        b=h01Xd2uxdvopaDGvmYLAp2MopCXsHEHrizVGAfslsA20SbcrTGuEopJJ8PaF0nfl04
         054Y636X4sWER6jDJBaIYlUYUh+TTjWg/mzxV2ATZa5ENMFn8SoTG6i25+HHNK6Fr9Dg
         kN2aYGTlcM/RerkB5l/hgXYZI3pvmFVVeCvI/rQFu0CaXTpvUWWCNeGg8OnYt+XRYYYd
         jN+H1PJiYNcWreP0TwhuujrIx9BeEIYgiEmofOo7IPMJ9wPFzqVeiVXNV9yqKS4MzsIV
         xnKwKC2TYJvDZKvxk31HE8BZsTGOK9ykUzLjd1BJBC0NTCkimAY+JyIl7dtNnOhKgdnB
         imeg==
X-Gm-Message-State: AOAM532ifomOGSUFdSnRq7+VA9QgkHWjV6vCeJ5BYgpr7qbQgxjsm59j
        2IxOPCkuO+u4hcSMqBqsGnjZwuwSCGmBSQ==
X-Google-Smtp-Source: ABdhPJwRaQYft2M56454vg2HLv1vsWs11q3WmFaKU5n0RKALTa/c+o+uwHjQHjbh2sxhsxra237LyA==
X-Received: by 2002:a63:c142:: with SMTP id p2mr2242013pgi.14.1621476702208;
        Wed, 19 May 2021 19:11:42 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id a18sm529834pfn.147.2021.05.19.19.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:11:41 -0700 (PDT)
Date:   Thu, 20 May 2021 12:11:29 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying function
Message-ID: <24c761bd0bd1618c911a392d0c310c24da7d8941.1621473846.git.repnop@google.com>
References: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621473846.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The copy_info_to_user() function has been repurposed with the idea to
handle the copying of different info record types. This helper allows
for the separation of info record copying routines/conditionals from
copy_event_to_user(), which reduces the overall clutter within this
function.

The newly defined macro FANOTIFY_INFO_MODES can be used to obtain info
record types that have been enabled for a specific notification
group. This becomes useful when FAN_REPORT_PIDFD is introduced.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 fs/notify/fanotify/fanotify_user.c | 145 ++++++++++++++++-------------
 include/linux/fanotify.h           |   2 +
 2 files changed, 81 insertions(+), 66 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 914ff8cf30df..1e15f3222eb2 100644
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
@@ -401,6 +401,78 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
 	return info_len;
 }
 
+static int copy_info_to_user(struct fanotify_event *event,
+			     struct fanotify_info *info,
+			     unsigned int info_mode,
+			     char __user *buf, size_t count)
+{
+	int ret, info_type = 0;
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
+		} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
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
+			 * modification event and for event on a directory.
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
+	}
+
+	return ret;
+}
+
 static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  struct fanotify_event *event,
 				  char __user *buf, size_t count)
@@ -408,15 +480,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
@@ -458,68 +529,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (f)
 		fd_install(fd, f);
 
-	/* Event info records order is: dir fid + name, child fid */
-	if (fanotify_event_dir_fh_len(event)) {
-		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
-					     FAN_EVENT_INFO_TYPE_DFID;
-		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
-					    fanotify_info_dir_fh(info),
-					    info_type, fanotify_info_name(info),
-					    info->name_len, buf, count);
+	if (info_mode) {
+		ret = copy_info_to_user(event, info, info_mode, buf, count);
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
index bad41bcb25df..f76c7635efc8 100644
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
2.31.1.751.gd2f1c929bd-goog

/M
