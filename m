Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA32123E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGBM6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgGBM6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F0C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so27848066wml.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJu4uF/qCVu5luBu+CcGMSMZyh9Ry08Rhva2XdheEaI=;
        b=Lih5Tyib99Xu5Tp+Cm9IpPy9MwJrAtWfQ77uxlIrjrPINsasYNj9wfTSGd6g/j2Nuq
         FOAd0mkXzHBjzH/llxnSMd6bs0Hn+f/FG6RGUfW1dyxaQfHiRb90t26jDMFCax3WiDJ5
         SM1pH22itDjFtNdP1KLwrsvZlkYtVNsfRzbC+tzpKMoOjTkh37ARqtvSDE2GSZFNmNvN
         petw/tW2C3uJQ66aTqvtPhzFZFL3p8oAgiLxU+e3f7G8EtEDzDHY1uC4ZR3tlnbgbVbk
         z7I9ZJQQgo+txwKbp/OqY0pHuwMHLOEcCsynGrrZD7Vj73hy+y6c1tw8uKj9ZvAzJzRZ
         Rt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJu4uF/qCVu5luBu+CcGMSMZyh9Ry08Rhva2XdheEaI=;
        b=b974orKsv6DlytZXgphmSIPMsuK/89hufSyJlzhDSOtYXLwBFQ5ZFns1+nkDtsxPib
         LYS5LzXOLDZo10aCEVLazJPxh9rDaLiZ2Kp+tZ3guApD4J+j81R9K/pzZCu5ZTumHaWA
         yyVcFSv1ew40t7MVfht+SWkelOetwXQuX+5dytrH4gqBuBi/ysbcepWq0Ugjlvq/i61h
         HppCXclOmbuAH/fOCJ3SU0emATd2SY6RTI8LSz/kq5bhACIzIUu+OdbvoHgNMNIRy1Od
         8Qda6TMTHW0H7GqvYWqgy7nM3f+fJpvx2zCRItlv/Zv1huN9PPpBhwpnrrJTEUnh2m1t
         ERnw==
X-Gm-Message-State: AOAM533PzDu6dXZWkwKfumnywRZX93B6gE7grt2XU2Cv40UEia1E8+bU
        wY2XGh4Ms46uzzZtyKyxcRiCKd/U
X-Google-Smtp-Source: ABdhPJz606gmcf6JVkcUUIpsGezowCemK75XInhTjILE+sie89jfDbDpmmIH4L8FH0ilNGQl+v4zIA==
X-Received: by 2002:a1c:7f82:: with SMTP id a124mr29647461wmd.132.1593694685344;
        Thu, 02 Jul 2020 05:58:05 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:58:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 08/10] fanotify: add support for FAN_REPORT_NAME
Date:   Thu,  2 Jul 2020 15:57:42 +0300
Message-Id: <20200702125744.10535-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new fanotify_init() flag FAN_REPORT_NAME.  It requires the
flag FAN_REPORT_DIR_FID and there is a constant for setting both flags
named FAN_REPORT_DFID_NAME.

For a group with flag FAN_REPORT_NAME, the parent fid and name are
reported for directory entry modification events (create/detete/move)
and for events on non-directory objects.

Events on directories themselves are reported with their own fid and
"." as the name.

The parent fid and name are reported with an info record of type
FAN_EVENT_INFO_TYPE_DFID_NAME, similar to the way that parent fid is
reported with into type FAN_EVENT_INFO_TYPE_DFID, but with an appended
null terminated name string.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 18 +++++++++++-
 fs/notify/fanotify/fanotify_user.c | 47 +++++++++++++++++++++++-------
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  4 +++
 4 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c45d65fa8d1d..b22ab6630eba 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -495,9 +495,25 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	bool name_event = false;
 
-	if ((fid_mode & FAN_REPORT_DIR_FID) && dir)
+	if ((fid_mode & FAN_REPORT_DIR_FID) && dir) {
 		id = fanotify_dfid_inode(mask, data, data_type, dir);
 
+		/*
+		 * We record file name only in a group with FAN_REPORT_NAME
+		 * and when we have a directory inode to report.
+		 *
+		 * For directory entry modification event, we record the fid of
+		 * the directory and the name of the modified entry.
+		 *
+		 * For event on non-directory that is reported to parent, we
+		 * record the fid of the parent and the name of the child.
+		 */
+		if ((fid_mode & FAN_REPORT_NAME) &&
+		    ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
+		     !(mask & FAN_ONDIR)))
+			name_event = true;
+	}
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 20bb1c52b1cd..27116cfead66 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -64,17 +64,26 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
 }
 
-static int fanotify_event_info_len(struct fanotify_event *event)
+static int fanotify_event_info_len(unsigned int fid_mode,
+				   struct fanotify_event *event)
 {
-	int info_len = 0;
 	int fh_len = fanotify_event_object_fh_len(event);
 	struct fanotify_fh *dfh = fanotify_event_dir_fh(event);
+	int info_len = 0;
+	int dot_len = 0;
 
-	if (dfh)
+	if (dfh) {
 		info_len += fanotify_fid_info_len(dfh->len, dfh->name_len);
+	} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
+		/*
+		 * With group flag FAN_REPORT_NAME, if name was not recorded in
+		 * event on a directory, we will report the name ".".
+		 */
+		dot_len = 1;
+	}
 
 	if (fh_len)
-		info_len += fanotify_fid_info_len(fh_len, 0);
+		info_len += fanotify_fid_info_len(fh_len, dot_len);
 
 	return info_len;
 }
@@ -90,6 +99,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 {
 	size_t event_size = FAN_EVENT_METADATA_LEN;
 	struct fanotify_event *event = NULL;
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 
 	pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
 
@@ -97,8 +107,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	if (fsnotify_notify_queue_is_empty(group))
 		goto out;
 
-	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
-		event_size += fanotify_event_info_len(
+	if (fid_mode) {
+		event_size += fanotify_event_info_len(fid_mode,
 			FANOTIFY_E(fsnotify_peek_first_event(group)));
 	}
 
@@ -324,7 +334,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
 	metadata.event_len = FAN_EVENT_METADATA_LEN +
-					fanotify_event_info_len(event);
+				fanotify_event_info_len(fid_mode, event);
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
@@ -372,12 +382,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	}
 
 	if (fanotify_event_object_fh_len(event)) {
+		const char *dot = NULL;
+		int dot_len = 0;
+
 		if (fid_mode == FAN_REPORT_FID || info_type) {
 			/*
 			 * With only group flag FAN_REPORT_FID only type FID is
 			 * reported. Second info record type is always FID.
 			 */
 			info_type = FAN_EVENT_INFO_TYPE_FID;
+		} else if ((fid_mode & FAN_REPORT_NAME) &&
+			   (event->mask & FAN_ONDIR)) {
+			/*
+			 * With group flag FAN_REPORT_NAME, if name was not
+			 * recorded in an event on a directory, report the
+			 * name "." with info type DFID_NAME.
+			 */
+			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
+			dot = ".";
+			dot_len = 1;
 		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
 			   (event->mask & FAN_ONDIR)) {
 			/*
@@ -398,7 +421,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 		ret = copy_info_to_user(fanotify_event_fsid(event),
 					fanotify_event_object_fh(event),
-					info_type, NULL, 0, buf, count);
+					info_type, dot, dot_len, buf, count);
 		if (ret < 0)
 			return ret;
 
@@ -925,11 +948,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (fid_mode && class != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
-	/* Reporting either object fid or dir fid */
+	/*
+	 * Reporting either object fid or dir fid.
+	 * Child name is reported with parent fid so requires dir fid.
+	 */
 	switch (fid_mode) {
 	case 0:
 	case FAN_REPORT_FID:
 	case FAN_REPORT_DIR_FID:
+	case FAN_REPORT_DFID_NAME:
 		break;
 	default:
 		return -EINVAL;
@@ -1287,7 +1314,7 @@ COMPAT_SYSCALL_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 9);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4ddac97b2bf7..3e9c56ee651f 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -18,7 +18,7 @@
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
 				 FAN_CLASS_PRE_CONTENT)
 
-#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DIR_FID)
+#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
 				 FAN_REPORT_TID | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 21afebf77fd7..fbf9c5c7dd59 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -54,6 +54,10 @@
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
+#define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+
+/* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
+#define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.17.1

