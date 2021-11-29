Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC98446269B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhK2Wz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhK2Wyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:54:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B4C06FD49
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s13so39489471wrb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUz63shG/X1V3v89z/5+pj4ZpdezqtcpEtHhW4EM/H8=;
        b=ZbKiTuSLVGurnOyJGCZf0mdpHwfs35S+tv4DtASDkvYe/Gch0/3vf1q6KghCTvZVU8
         E0RwRGzjx2cUoEWQ6rvG5Kdpx3BN6p8Qyo9FHRQ6CcurXaLTmgbWvFQ67RNdMc1A3Mjs
         flClDk6Sz0NYqKChWyii6pPJb03e4r6vjjJrN2SycOjDFaU4aGT8uze8AXvt5be+DAWj
         xGU6DQp3DuBrzIEB3mB/1XwgYF+eOhEwjAqTU9myNgKTKVWdO49UUtLI5KsJh74BvJfa
         YfR7AosRxGLIT9FVJQjpkXEuqlGRiMWdcdfXKWsCXigsn1ASEhQsdeXQ0oWxmldx8PwW
         VPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUz63shG/X1V3v89z/5+pj4ZpdezqtcpEtHhW4EM/H8=;
        b=xH6WnsigsZ+HOVf8D/sbIxD5+DVKb3EvVA+DsaFLkmPoLbogTnXiDVT5+Jqb6+Fuf0
         ma0xOlY1IfbGw828peWChfo44xFRWsqJPmA7kteOkzcz2rdZHEJEj5kNlODFFYm8yMDw
         8fCGwaL/SRNT8B2UeC91nxWzwtwbJUe+wqNTiHe7YXPmKazGfKZJJLooag8bmrSUcz83
         7sNW5apHhIKeAagkuXsijiz5q7jNG5p0yoyYg5MwrpV+91SIWONBAijqVa6DMQkPSJlY
         T3ciQaSCSxtfCLPMimE0intvTpdFY9wuRaP3oqUmI+nESYd2eo0D2/+FyHozmh+BrGll
         rtyQ==
X-Gm-Message-State: AOAM530BoGKY/nWfoy1GmUngMYxwsRB9Xrr+LB2NsnSumtuuRFcYcxTJ
        PXfm9/7XQPsAvBRNHtK0U8UjABtKS9g=
X-Google-Smtp-Source: ABdhPJw32tMR6sgvqf4fzWcZdmJqgJM7mz5u17Ea4ImRnrrb4ZHhtKn+M8mvJSXNjoEC679ic//sEw==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr36013850wry.279.1638216946066;
        Mon, 29 Nov 2021 12:15:46 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:45 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/11] fanotify: use macros to get the offset to fanotify_info buffer
Date:   Mon, 29 Nov 2021 22:15:31 +0200
Message-Id: <20211129201537.1932819-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
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
index 85e542b164c8..ffad224be014 100644
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

