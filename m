Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2943FB8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhJ2LnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhJ2LnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4CC061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j35-20020a05600c1c2300b0032caeca81b7so6287413wms.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uHdcHLK3HL6YvF7t01X/TPud3lCRN25c62u2gCgvw4=;
        b=Gw1cek89MrZvjGzIhtNWcJNdX4Tw8TDFJsTw+01hLSnSevN2OAYz9zP9PxXQsaakcW
         kqAW0ScKL3/VfUnyNoB7H7OG8PCmZi8laxeUwlYt68ams7Vu9JFRqnOMwvDzQbXPIDQ2
         VpQy22oKRDUWPD3J5Kigjy1yO05vdgVQNP8vsScPbU5rYzfZHve1dfzus5h5X+ihJ0Rc
         W601lBnBza9FKNGfttIb7+j8GEaQrUwLcdTWqoqqvp3cnCsECHC35/+ER3/kh8roWfiC
         x74CzVA8i4pU3Ga0NzajJtDM/kNBY+wNGst7jYrYqY4aIM/TYlFpsEeK6VSQf9Hqc99J
         U0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uHdcHLK3HL6YvF7t01X/TPud3lCRN25c62u2gCgvw4=;
        b=RDskXAv9y6SzD5CtNYecq0Ir0fDe6U/WDZ08DLG3BxQ1H9OBDGz4AeGXS4obEJZiYn
         I0yxmdr6ciVz/EXHHLmbR2d6LAiHWxO0pr3uvq3NuSpI016V3TBpFKMl3svOi9efb7wL
         65espCEt+Tl0RdhEgZAX2ZuO1uDr72EvbrClsKCde2vIjOwy7/2xTARxEUduj3wurs8o
         06Qp0OPdaVQSb3H/CB5+mgk0ql4Ak7wqJ2wWSpOxBlAltWB0Cb0vog+RbaM0yciNnOXb
         qAOJm+Y8TQLGJ609CR5xX/UvdmXvDVNO2oVu/FD+sy4wUsY5wA1W2XwfHe8v8H4JU+9I
         mfRg==
X-Gm-Message-State: AOAM5308EX7EqxSfhx5Hb1Qi8S4HmFo8c8wPYj0Z4Tg2Rhe8pVNIBGdM
        49vXQjdFXyy6/mK+tCbEq745PnecvBE=
X-Google-Smtp-Source: ABdhPJzA7GwS3QvUkbfm/9zKLJ9eBHkszL4za75U3DmQ7cdbcBe4tW/uBB5D9HKB/IVXOsCe+2TNqg==
X-Received: by 2002:a05:600c:8a4:: with SMTP id l36mr19427836wmp.17.1635507636154;
        Fri, 29 Oct 2021 04:40:36 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:35 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] fanotify: support secondary dir fh and name in fanotify_info
Date:   Fri, 29 Oct 2021 14:40:25 +0300
Message-Id: <20211029114028.569755-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow storing a secondary dir fh and name tupple in fanotify_info.
The secondary dir fh and name can only be stored after storing the
primary dir fh and name.

This will be used to store the new parent and name information in
MOVED_FROM event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 20 ++++++++---
 fs/notify/fanotify/fanotify.h      | 57 +++++++++++++++++++++++++++---
 fs/notify/fanotify/fanotify_user.c |  3 +-
 3 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4a812411ae5b..795bedcb6f9b 100644
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
index dd23ba659e76..0864e7efe23c 100644
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
@@ -128,14 +156,24 @@ static inline char *fanotify_info_name(struct fanotify_info *info)
 	return FANOTIFY_NAME_BUF(info);
 }
 
+static inline char *fanotify_info_name2(struct fanotify_info *info)
+{
+	if (!info->name_len || !info->name2_len)
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
 
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
@@ -148,6 +186,17 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 	strcpy(fanotify_info_name(info), name->name);
 }
 
+static inline void fanotify_info_copy_name2(struct fanotify_info *info,
+					    const struct qstr *name)
+{
+	if (WARN_ON_ONCE(name->len > NAME_MAX) ||
+	    WARN_ON_ONCE(!info->name_len))
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
index 6ec26b124041..d973f36676a9 100644
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

