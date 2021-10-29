Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79443FB8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhJ2LnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhJ2LnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E7C061767
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so15662112wrd.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doaEFdEkruCJZPvutxr6JHq6+EhQEfwiw9SykkAMsFY=;
        b=a1oSi2qq3nGyoDLZ7vf7rNygNPk3OBqHE6NukaVHYjhiaUWT9k25wK48RTbm8KvoQs
         XQ58GupmiE/52NoiKqzk5U8CabrjcKxDLmZ3dWj0GHyzvsl2PPm56Y5XBfGUMRKmXWUj
         1QBriltSW/AtURZ1mZPeTEr+cW7eFbb8HY+ifh0ys548mj7yuM806/IQDtOl2EMpRCay
         YmBBwQrrTrVLuZpJ3N2IKqFBDtA57hHw5zw8Z6YK+z6+X0shbnKbQaf2HkMqW36WGwKg
         /LZf3GIzfAHhlcrRds5b9V3LG/XnztGVYqQohteGLZIo2OrPpgT6BCqGo4qnboLk2Uis
         cvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doaEFdEkruCJZPvutxr6JHq6+EhQEfwiw9SykkAMsFY=;
        b=In9XkhXdJqYlOgUdjHqrvtDcxuU96+V9dqJZ42rtGBKY2OaGzArHQJ4+AIYk9g5CMY
         k4Ghg4fNw7aFrVNlu02uEErSZuSzfELGD7/COy+mEkwytJwNPn6zyVPfSBKDYUVCmnoM
         r2On4hfOsPadPKWKyHWQYCuW4K0v+7gsQOvpBZTFB+UJtd0o0trAy/cZyqRieOiZHKw9
         xJy4yJEhLGPO+HpKtrqO5yii6TK4KScZ60vyTOsxW6+ZPtHy1jAaVT3pmLqnPq0QuCj8
         o28WyP96m7dldFf0mNu9wU2jloB/XWq9rYpf2e7kaLNU0/JKS5yIrtOGuwK6QyChhkTn
         ecYw==
X-Gm-Message-State: AOAM53214IDFK9PWFMh+wGA0npX49Ap03+jGxMz6zXu1VTwtTpZ40Wej
        OAdXB4inhLINsRPRObpCWVuX88ZlLck=
X-Google-Smtp-Source: ABdhPJxiUcecBjXyHHNFBDs1oMv4qKrhO9NwXiR8jwD21cYs3uvk/L1ghFhSP2YBt9ZiDcwFKbXEKw==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr13830391wrp.49.1635507634922;
        Fri, 29 Oct 2021 04:40:34 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:34 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] fanotify: use macros to get the offset to fanotify_info buffer
Date:   Fri, 29 Oct 2021 14:40:24 +0300
Message-Id: <20211029114028.569755-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
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

