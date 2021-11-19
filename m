Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF77456AD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhKSHUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhKSHUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02678C06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so6713380wmb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doaEFdEkruCJZPvutxr6JHq6+EhQEfwiw9SykkAMsFY=;
        b=STaCoshsydvgaa0XcEgXS3ZeXHaI9xDQ8z4xW2KnZh+//z9QZZ+PQA9lwINf1G51Yo
         9Jn7RxJQBJZZSdRtErXahh8mstGVkUi72RKOkt0m2BKibKhisuUK194On2SWpQxwuf/b
         2sUBN9EwiUWjhmyZqsdvIiPNT0+ZgaT0T2shorNSa9S/5U4jbTJuDXZo3OPzDubJ6gV+
         cZOLZ9p/kGjzLuhH3fxQEQE33UzqWKBsUoI5cLcYEdd6z9HySdeUDwQ94zqCrvXeaXGd
         0ng1lwDYWsixZI5FtkB5ypMuiow9rkFue6/eHKKWSyby3yjemGWXbPkvM2iJRnTE+beM
         mndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doaEFdEkruCJZPvutxr6JHq6+EhQEfwiw9SykkAMsFY=;
        b=Ds91ovlUraZxNMDWTXHj8nawOn8coLCqmAvRDMwDfjzJDsstCTVAg6uKTwXW+iZWQ0
         2gA3Y+3clBkWQ9Cg8tcweoQ/BVGLWKlUVKzbXvhHgQNPoF2b+N4yL5nQ+qELVwoMEogb
         zaFspsysHoA8FLWmMyu3QRrw5XO2lxTIJHIC4Fm7zd+mY5hBIsDF51zLA28wOOdwFFsv
         ujnC4pTWHtGwINf0nHm3BFkZG7h1dViGBglRjcQIC3K7HpWTmOD83rkWgGMtdxRCsIUN
         xjGj/uxxLnkvTewXgesfhWKz7ExGFsasDI8MaXPh1IKJwk2lXqiYXGEGC6nvfU8anK7P
         svbA==
X-Gm-Message-State: AOAM531VKQgvbQKMGY6p3Moqd7g8o+6/M4bbBwivRza75qS1Hg783sk9
        kH6BqvRj6DcsQuJZENn+KsxAjQr1Ue0=
X-Google-Smtp-Source: ABdhPJwQyNnxRbidp1WP0A3zDOzvtmBvCMR1GqKAbUw1aUlBQjOlpB5KHbRtz7JYmubaW8g4EKSV8g==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr4051645wmg.71.1637306265561;
        Thu, 18 Nov 2021 23:17:45 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:45 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/9] fanotify: use macros to get the offset to fanotify_info buffer
Date:   Fri, 19 Nov 2021 09:17:32 +0200
Message-Id: <20211119071738.1348957-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fanotify_info buffer contains up to two file handles and a name.
Use macros to simplify the code that access the different items within
the buffer.

Add assertions to verify that stored fh len and name len do not overflow
the u8 stored value in fanotify_info header.

Remove the unused fanotify_info_len() helper.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c |  2 +-
 fs/notify/fanotify/fanotify.h | 41 +++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 9b1641ecfe97..4a812411ae5b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -411,7 +411,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	 * be zero in that case if encoding fh len failed.
 	 */
 	err = -ENOENT;
-	if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4))
+	if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4) || fh_len > MAX_HANDLE_SZ)
 		goto out_err;
 
 	/* No external buffer in a variable size allocated fh */
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index d25f500bf7e7..dd23ba659e76 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -49,6 +49,22 @@ struct fanotify_info {
 	 * (optional) file_fh starts at buf[dir_fh_totlen]
 	 * name starts at buf[dir_fh_totlen + file_fh_totlen]
 	 */
+#define FANOTIFY_DIR_FH_SIZE(info)	((info)->dir_fh_totlen)
+#define FANOTIFY_FILE_FH_SIZE(info)	((info)->file_fh_totlen)
+#define FANOTIFY_NAME_SIZE(info)	((info)->name_len + 1)
+
+#define FANOTIFY_DIR_FH_OFFSET(info)	0
+#define FANOTIFY_FILE_FH_OFFSET(info) \
+	(FANOTIFY_DIR_FH_OFFSET(info) + FANOTIFY_DIR_FH_SIZE(info))
+#define FANOTIFY_NAME_OFFSET(info) \
+	(FANOTIFY_FILE_FH_OFFSET(info) + FANOTIFY_FILE_FH_SIZE(info))
+
+#define FANOTIFY_DIR_FH_BUF(info) \
+	((info)->buf + FANOTIFY_DIR_FH_OFFSET(info))
+#define FANOTIFY_FILE_FH_BUF(info) \
+	((info)->buf + FANOTIFY_FILE_FH_OFFSET(info))
+#define FANOTIFY_NAME_BUF(info) \
+	((info)->buf + FANOTIFY_NAME_OFFSET(info))
 } __aligned(4);
 
 static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
@@ -87,7 +103,7 @@ static inline struct fanotify_fh *fanotify_info_dir_fh(struct fanotify_info *inf
 {
 	BUILD_BUG_ON(offsetof(struct fanotify_info, buf) % 4);
 
-	return (struct fanotify_fh *)info->buf;
+	return (struct fanotify_fh *)FANOTIFY_DIR_FH_BUF(info);
 }
 
 static inline int fanotify_info_file_fh_len(struct fanotify_info *info)
@@ -101,32 +117,35 @@ static inline int fanotify_info_file_fh_len(struct fanotify_info *info)
 
 static inline struct fanotify_fh *fanotify_info_file_fh(struct fanotify_info *info)
 {
-	return (struct fanotify_fh *)(info->buf + info->dir_fh_totlen);
+	return (struct fanotify_fh *)FANOTIFY_FILE_FH_BUF(info);
 }
 
-static inline const char *fanotify_info_name(struct fanotify_info *info)
+static inline char *fanotify_info_name(struct fanotify_info *info)
 {
-	return info->buf + info->dir_fh_totlen + info->file_fh_totlen;
+	if (!info->name_len)
+		return NULL;
+
+	return FANOTIFY_NAME_BUF(info);
 }
 
 static inline void fanotify_info_init(struct fanotify_info *info)
 {
+	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
+	BUILD_BUG_ON(NAME_MAX > U8_MAX);
+
 	info->dir_fh_totlen = 0;
 	info->file_fh_totlen = 0;
 	info->name_len = 0;
 }
 
-static inline unsigned int fanotify_info_len(struct fanotify_info *info)
-{
-	return info->dir_fh_totlen + info->file_fh_totlen + info->name_len;
-}
-
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
+	if (WARN_ON_ONCE(name->len > NAME_MAX))
+		return;
+
 	info->name_len = name->len;
-	strcpy(info->buf + info->dir_fh_totlen + info->file_fh_totlen,
-	       name->name);
+	strcpy(fanotify_info_name(info), name->name);
 }
 
 /*
-- 
2.33.1

