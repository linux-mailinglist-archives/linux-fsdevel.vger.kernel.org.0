Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6A43FB91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhJ2LnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhJ2LnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9928C061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g13so329818wmg.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2q8KNM34vrGnsSuHsXvSArX1nN2zm2pfj7JnKEoh3b4=;
        b=R2A7Q3hVN6t6+ijk2EKgKGR35VY2f49ADmZuQ0ODihNyOgiL+yTrtgIT82Mqp9kmCQ
         ni7X1ZZKWt8rWTZn+99GeD6EApZF+5GU0YO52RNPJ95ci8HIzrgk/dmR255qFRxBrCSc
         XGue13xvIBYvHZJKtllrUVKDgekAxBExsIVYSfo35ZMO6TnvjLw+COdUN68StgFqS0hU
         Z1wQOoN5Kq+/xAhMT18JKaRB5FA0ceKK47EvAN6R/xVF7HpVu3nayHrXGL0mKkfLZ+Fn
         hdcI4/pqwnAkmVotYmxZYGdHHBSNN09GLU4bQH4UgiwADvGQNL8i3xVpJu43nOAjNS/g
         6u9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2q8KNM34vrGnsSuHsXvSArX1nN2zm2pfj7JnKEoh3b4=;
        b=VA0jLjljva62v9+ybAwj7PRMRZrzMYea6g9Nwu7QpDkFA9KirgZBdQfij+XGvx+yO6
         p0FP/ifypVyxdEead5/fa4M6m85JHjo7w+KQ3fvlp+HyPSD0rwW9nU+l1gj+CZPtzlpq
         P2w83w87pMHCxF/6zeTHnfEDc5ekEckXBnApYpVtD/W6ZZQn+MmyfnQas9lUF5w4n/PR
         CxCc47U/WUKOSPboD6xt0i/yxXA8UOzTMDgHvzf7XD0gM5z5tpmFGmAWEoMUOvWAcXOz
         g2QZ1eHjTMewGEafkKYb5r9AD8dqIslFqHjqR8HBgGrreNBAYK5LzN+P9H9Sf+5Ur4LA
         ESUQ==
X-Gm-Message-State: AOAM531qXX/mzHYEuH33XgOG7mSsWo7LmacIHDqs6nLTpoe05cxL+Eye
        ljm1kZa+/prpPnlbexqQot0=
X-Google-Smtp-Source: ABdhPJxCrG3Wqv6z7Nx9uyA53Zp27zoiAhfzZ4an0jk3O+29CXZCQL0X/Fh8tFauy9PveOb5DTc1fA==
X-Received: by 2002:a05:600c:1c23:: with SMTP id j35mr10643257wms.1.1635507638521;
        Fri, 29 Oct 2021 04:40:38 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:38 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] fanotify: report new parent and name in MOVED_FROM event
Date:   Fri, 29 Oct 2021 14:40:27 +0300
Message-Id: <20211029114028.569755-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the special case of MOVED_FROM event, if we are reporting the child
fid due to FAN_REPORT_TARGET_FID init flag, we also report the new
parent and name.

The new parent and name are reported using a new info record of type
FAN_EVENT_INFO_TYPE_DFID_NAME2 that follows the info record of type
FAN_EVENT_INFO_TYPE_DFID_NAME with the old parent and name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      | 17 +++++++++++++++++
 fs/notify/fanotify/fanotify_user.c | 29 +++++++++++++++++++++++++++--
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 0864e7efe23c..26d471aab054 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -339,6 +339,13 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
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
@@ -352,6 +359,16 @@ static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
 	return fanotify_event_dir_fh_len(event) > 0;
 }
 
+/* For MOVED_FROM event with FAN_REPORT_TARGET_FID */
+static inline bool fanotify_event_has_two_names(struct fanotify_event *event)
+{
+	struct fanotify_info *info = fanotify_event_info(event);
+
+	return info && info->name_len && info->name2_len &&
+		fanotify_info_dir_fh_len(info) > 0 &&
+		fanotify_info_dir2_fh_len(info) > 0;
+}
+
 struct fanotify_path_event {
 	struct fanotify_event fae;
 	struct path path;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d973f36676a9..d6420e10740d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -134,7 +134,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 {
 	size_t event_len = FAN_EVENT_METADATA_LEN;
 	struct fanotify_info *info;
-	int dir_fh_len;
+	int dir_fh_len, dir2_fh_len;
 	int fh_len;
 	int dot_len = 0;
 
@@ -149,6 +149,11 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (fanotify_event_has_dir_fh(event)) {
 		dir_fh_len = fanotify_event_dir_fh_len(event);
 		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
+		if (fanotify_event_has_two_names(event)) {
+			dir2_fh_len = fanotify_event_dir2_fh_len(event);
+			event_len += fanotify_fid_info_len(dir2_fh_len,
+							   info->name2_len);
+		}
 	} else if ((info_mode & FAN_REPORT_NAME) &&
 		   (event->mask & FAN_ONDIR)) {
 		/*
@@ -379,6 +384,7 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 			return -EFAULT;
 		break;
 	case FAN_EVENT_INFO_TYPE_DFID_NAME:
+	case FAN_EVENT_INFO_TYPE_DFID_NAME2:
 		if (WARN_ON_ONCE(!name || !name_len))
 			return -EFAULT;
 		break;
@@ -478,7 +484,10 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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
@@ -496,6 +505,22 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	/* New dir fid + name can only be reported after old dir fid + name */
+	if (info_type && fanotify_event_has_two_names(event)) {
+		info_type = FAN_EVENT_INFO_TYPE_DFID_NAME2;
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
index f9202ce31b0d..1ac31a912cea 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -131,6 +131,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_DFID_NAME2	6 /* For FAN_MOVED_FROM */
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
-- 
2.33.1

