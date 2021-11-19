Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E69456AD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhKSHUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhKSHUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBEC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso6718355wme.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J39aaDexhztw7oyBWU3wiRKPDiup181acFLjJmms/nw=;
        b=gktTQsHc9Vtv/5DQP+8EUraXSPLgSCTBoK4vR62qN+DPIrAXrTWBMQgIoCWY+lqGi+
         P9xGVlSz8H/A4w+BnnSTbzVvhpkxTTzOxIiqC9T47aDzlPaIbKVlmQWtHpoFC0WYfne2
         fmzXXeg5qTsaMP4j+GRe+M1G6MN2OB7phiAdYOs0ESqX0ipmbWCv6bjFzTYJAXMmEtnv
         wML2mQhvycpR9SODCXT+p98gFfx3RPXcbSmVCvfqODyUxBbls19OAi1O+GzCEhpTalyk
         umdAl0uDGgN4jmEGtbranZxNcus/wrZ7qgKw9AU+ppjTSOcFJOwuo9t81DlsrBZVl3kA
         aRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J39aaDexhztw7oyBWU3wiRKPDiup181acFLjJmms/nw=;
        b=5hBrZ1/797Mku05j2+o95bvPIum2XDcbKqsVcsC0Nd3M0M5hsy8oYJTGactEiXfAwF
         xr0EADItSXh2RSR7bTvW0wOIJq2fpe7FXaMeqtN8phcICSP20snwSkQnMdTpxSx0133+
         2unF1LHrX0bEKsaEkfH3G87WG5Gl6Xq9eBawQCGVgeM6eXHMS5QaUXn4yrQ0QZsrdrAj
         usy7c1nUC8inSO9+BFM8g4HxcZs8frPuxy+xvdMmwutrDnrBygHCvA+7i7GouEYXQmov
         wPVtmXR3xSdQC7T4l4W1D1PsE5r1BB/JBdC0C8/VOGS4EP+I+8AgYOxBAz00kEukmxg1
         JxnQ==
X-Gm-Message-State: AOAM5313vXZgszx9DC/dyHIiePQUM+rQPQSPqC5hfCfxuUpcUBFjpzOo
        NcUs4m6bB3bWV8M2qALpFc0=
X-Google-Smtp-Source: ABdhPJxZq/a/vNaTlPZhJAryMszMFMT2XaS/VgUw03N2NTH9A1sCi0R2Z8/O561PSm/7pg7LYBfv4g==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr4074102wmg.140.1637306268384;
        Thu, 18 Nov 2021 23:17:48 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:47 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/9] fanotify: support secondary dir fh and name in fanotify_info
Date:   Fri, 19 Nov 2021 09:17:34 +0200
Message-Id: <20211119071738.1348957-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow storing a secondary dir fh and name tupple in fanotify_info.
This will be used to store the new parent and name information in
FAN_RENAME event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 20 ++++++--
 fs/notify/fanotify/fanotify.h      | 79 +++++++++++++++++++++++++++---
 fs/notify/fanotify/fanotify_user.c |  3 +-
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a274f57726dd..447e97396c58 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -76,8 +76,10 @@ static bool fanotify_info_equal(struct fanotify_info *info1,
 				struct fanotify_info *info2)
 {
 	if (info1->dir_fh_totlen != info2->dir_fh_totlen ||
+	    info1->dir2_fh_totlen != info2->dir2_fh_totlen ||
 	    info1->file_fh_totlen != info2->file_fh_totlen ||
-	    info1->name_len != info2->name_len)
+	    info1->name_len != info2->name_len ||
+	    info1->name2_len != info2->name2_len)
 		return false;
 
 	if (info1->dir_fh_totlen &&
@@ -85,14 +87,24 @@ static bool fanotify_info_equal(struct fanotify_info *info1,
 			       fanotify_info_dir_fh(info2)))
 		return false;
 
+	if (info1->dir2_fh_totlen &&
+	    !fanotify_fh_equal(fanotify_info_dir2_fh(info1),
+			       fanotify_info_dir2_fh(info2)))
+		return false;
+
 	if (info1->file_fh_totlen &&
 	    !fanotify_fh_equal(fanotify_info_file_fh(info1),
 			       fanotify_info_file_fh(info2)))
 		return false;
 
-	return !info1->name_len ||
-		!memcmp(fanotify_info_name(info1), fanotify_info_name(info2),
-			info1->name_len);
+	if (info1->name_len &&
+	    memcmp(fanotify_info_name(info1), fanotify_info_name(info2),
+		   info1->name_len))
+		return false;
+
+	return !info1->name2_len ||
+		!memcmp(fanotify_info_name2(info1), fanotify_info_name2(info2),
+			info1->name2_len);
 }
 
 static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7ac6f9f1e414..8fa3bc0effd4 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -40,31 +40,45 @@ struct fanotify_fh {
 struct fanotify_info {
 	/* size of dir_fh/file_fh including fanotify_fh hdr size */
 	u8 dir_fh_totlen;
+	u8 dir2_fh_totlen;
 	u8 file_fh_totlen;
 	u8 name_len;
-	u8 pad;
+	u8 name2_len;
+	u8 pad[3];
 	unsigned char buf[];
 	/*
 	 * (struct fanotify_fh) dir_fh starts at buf[0]
-	 * (optional) file_fh starts at buf[dir_fh_totlen]
-	 * name starts at buf[dir_fh_totlen + file_fh_totlen]
+	 * (optional) dir2_fh starts at buf[dir_fh_totlen]
+	 * (optional) file_fh starts at buf[dir_fh_totlen + dir2_fh_totlen]
+	 * name starts at buf[dir_fh_totlen + dir2_fh_totlen + file_fh_totlen]
+	 * ...
 	 */
 #define FANOTIFY_DIR_FH_SIZE(info)	((info)->dir_fh_totlen)
+#define FANOTIFY_DIR2_FH_SIZE(info)	((info)->dir2_fh_totlen)
 #define FANOTIFY_FILE_FH_SIZE(info)	((info)->file_fh_totlen)
 #define FANOTIFY_NAME_SIZE(info)	((info)->name_len + 1)
+#define FANOTIFY_NAME2_SIZE(info)	((info)->name2_len + 1)
 
 #define FANOTIFY_DIR_FH_OFFSET(info)	0
-#define FANOTIFY_FILE_FH_OFFSET(info) \
+#define FANOTIFY_DIR2_FH_OFFSET(info) \
 	(FANOTIFY_DIR_FH_OFFSET(info) + FANOTIFY_DIR_FH_SIZE(info))
+#define FANOTIFY_FILE_FH_OFFSET(info) \
+	(FANOTIFY_DIR2_FH_OFFSET(info) + FANOTIFY_DIR2_FH_SIZE(info))
 #define FANOTIFY_NAME_OFFSET(info) \
 	(FANOTIFY_FILE_FH_OFFSET(info) + FANOTIFY_FILE_FH_SIZE(info))
+#define FANOTIFY_NAME2_OFFSET(info) \
+	(FANOTIFY_NAME_OFFSET(info) + FANOTIFY_NAME_SIZE(info))
 
 #define FANOTIFY_DIR_FH_BUF(info) \
 	((info)->buf + FANOTIFY_DIR_FH_OFFSET(info))
+#define FANOTIFY_DIR2_FH_BUF(info) \
+	((info)->buf + FANOTIFY_DIR2_FH_OFFSET(info))
 #define FANOTIFY_FILE_FH_BUF(info) \
 	((info)->buf + FANOTIFY_FILE_FH_OFFSET(info))
 #define FANOTIFY_NAME_BUF(info) \
 	((info)->buf + FANOTIFY_NAME_OFFSET(info))
+#define FANOTIFY_NAME2_BUF(info) \
+	((info)->buf + FANOTIFY_NAME2_OFFSET(info))
 } __aligned(4);
 
 static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
@@ -106,6 +120,20 @@ static inline struct fanotify_fh *fanotify_info_dir_fh(struct fanotify_info *inf
 	return (struct fanotify_fh *)FANOTIFY_DIR_FH_BUF(info);
 }
 
+static inline int fanotify_info_dir2_fh_len(struct fanotify_info *info)
+{
+	if (!info->dir2_fh_totlen ||
+	    WARN_ON_ONCE(info->dir2_fh_totlen < FANOTIFY_FH_HDR_LEN))
+		return 0;
+
+	return info->dir2_fh_totlen - FANOTIFY_FH_HDR_LEN;
+}
+
+static inline struct fanotify_fh *fanotify_info_dir2_fh(struct fanotify_info *info)
+{
+	return (struct fanotify_fh *)FANOTIFY_DIR2_FH_BUF(info);
+}
+
 static inline int fanotify_info_file_fh_len(struct fanotify_info *info)
 {
 	if (!info->file_fh_totlen ||
@@ -128,31 +156,55 @@ static inline char *fanotify_info_name(struct fanotify_info *info)
 	return FANOTIFY_NAME_BUF(info);
 }
 
+static inline char *fanotify_info_name2(struct fanotify_info *info)
+{
+	if (!info->name2_len)
+		return NULL;
+
+	return FANOTIFY_NAME2_BUF(info);
+}
+
 static inline void fanotify_info_init(struct fanotify_info *info)
 {
 	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
 	BUILD_BUG_ON(NAME_MAX > U8_MAX);
 
 	info->dir_fh_totlen = 0;
+	info->dir2_fh_totlen = 0;
 	info->file_fh_totlen = 0;
 	info->name_len = 0;
+	info->name2_len = 0;
 }
 
 /* These set/copy helpers MUST be called by order */
 static inline void fanotify_info_set_dir_fh(struct fanotify_info *info,
 					    unsigned int totlen)
 {
-	if (WARN_ON_ONCE(info->file_fh_totlen > 0) ||
-	    WARN_ON_ONCE(info->name_len > 0))
+	if (WARN_ON_ONCE(info->dir2_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->file_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->name_len > 0) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->dir_fh_totlen = totlen;
 }
 
+static inline void fanotify_info_set_dir2_fh(struct fanotify_info *info,
+					     unsigned int totlen)
+{
+	if (WARN_ON_ONCE(info->file_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->name_len > 0) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
+		return;
+
+	info->dir2_fh_totlen = totlen;
+}
+
 static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 					     unsigned int totlen)
 {
-	if (WARN_ON_ONCE(info->name_len > 0))
+	if (WARN_ON_ONCE(info->name_len > 0) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->file_fh_totlen = totlen;
@@ -161,13 +213,24 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
-	if (WARN_ON_ONCE(name->len > NAME_MAX))
+	if (WARN_ON_ONCE(name->len > NAME_MAX) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->name_len = name->len;
 	strcpy(fanotify_info_name(info), name->name);
 }
 
+static inline void fanotify_info_copy_name2(struct fanotify_info *info,
+					    const struct qstr *name)
+{
+	if (WARN_ON_ONCE(name->len > NAME_MAX))
+		return;
+
+	info->name2_len = name->len;
+	strcpy(fanotify_info_name2(info), name->name);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0ade5031733d..ba72e49819f1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -332,11 +332,10 @@ static int process_access_response(struct fsnotify_group *group,
 static size_t copy_error_info_to_user(struct fanotify_event *event,
 				      char __user *buf, int count)
 {
-	struct fanotify_event_info_error info;
+	struct fanotify_event_info_error info = { };
 	struct fanotify_error_event *fee = FANOTIFY_EE(event);
 
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
-	info.hdr.pad = 0;
 	info.hdr.len = FANOTIFY_ERROR_INFO_LEN;
 
 	if (WARN_ON(count < info.hdr.len))
-- 
2.33.1

