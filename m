Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA693D08D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhGUFlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhGUFir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:38:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71CDC0613E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:18:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d9so1466300pfv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bwSGq2+2N9Ym0S0vdErsfXkf1wBOnbO5unmsadijD/c=;
        b=judp3ZMAguK9eGmKOEuGqhY3LC5bBv2jks7mTtDs0UhoQyTv13AsQf1CjhnNb6xOtO
         lYEOqmLcfH6fi7wIXvPENGJHF8re301Vx7ghU9gU7a4ThLEt9q214bh0YrL7w/teTNPf
         Z6CYghOklTnSWs6oRVzb5P1fYo8ntDK6bvay0bVE5mucHtLqKNa+Z3/umrKO9CFynxnO
         /XJJsnLV1fLnC1y+qaKtn97KYytK2eXB8Augk6tkCwlBAu8ihe57NaYDIewo3CV6PgVj
         I0pdyz/d5ZOPyREk6GNRBTgnk6rr7Wqfaqcx0ermcoq8H/0clKlTEy85DKMjLhmr521g
         ZVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bwSGq2+2N9Ym0S0vdErsfXkf1wBOnbO5unmsadijD/c=;
        b=WpWOqCW7cg1vnNV83hRl7IS85D/oGUvfr1xoYWkX5tVJWci9xRrQLlNcjhezV+2U3X
         8Q8FTZ7hHDs95d7bwDfp2eSABjEJtNJj6PXIBuhaMAhBxGfyYVc8dElG3bXv/q/b0sW6
         MuuSTdD3PtFE+atw2s0mH5L4DfC5YRibomQP5WVy+ewBR0fgLioXmhNtV3YjYTE9Xu1N
         bv9XdruvngoR1r+BppaxHcopzeRB51OH77IT08JT6HU1UxGMWuaJ3MIMi4aFmV64WyLW
         sx7avTtlOGusscyI/2SGuMiNoULWlpAzQryWf5DRLCpYP+QgG5QUunbnARWnrDlcQCf0
         QkVw==
X-Gm-Message-State: AOAM533qktNHEoDn5Id29NeBXQbGGogygMKJ1QQjGHFFXkFhAnGfbxRQ
        a26JspWebtBnxd9B11tlJEmuLg==
X-Google-Smtp-Source: ABdhPJyNawQBGxZQTicFmmttJChFF3A5H6Q/fNFdWp9wbyrY1oZR1GqIv7ZlrflCMHzNwconbZ2p5Q==
X-Received: by 2002:a62:3045:0:b029:32b:880f:c03a with SMTP id w66-20020a6230450000b029032b880fc03amr35058403pfw.22.1626848336881;
        Tue, 20 Jul 2021 23:18:56 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id n33sm28308474pgm.55.2021.07.20.23.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:18:56 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:18:45 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying helper
Message-ID: <5ac9237ed6f055613c817eb1b9eedcaf1e53d4e6.1626845288.git.repnop@google.com>
References: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626845287.git.repnop@google.com>
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
---
 fs/notify/fanotify/fanotify_user.c | 155 ++++++++++++++++-------------
 include/linux/fanotify.h           |   2 +
 2 files changed, 90 insertions(+), 67 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 182fea255376..d19f70b2c24c 100644
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
2.32.0.432.gabb21c7263-goog

/M
