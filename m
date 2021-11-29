Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34538462621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhK2Wrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhK2Wqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:46:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB6C06FD4A
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso17814441wms.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPhaoY2sEMTSluaWgM54Ynnzw+GTULN3xj40CiEudZo=;
        b=MAZ0g6DC5jY+kS8Bdkq3p/4EzpXV6mhSh3zroSL/YafrJ+w5HygWszefq3THJVW9gz
         pcaD0f7a16OhNW3PITGseCVTsTW1/6BVpTaYzPyeyjlk8IQ/3/QTvLL2YsZtAkYQg0nh
         muuaphZg4+eWtOD8pU9Ak1nju6IuEJ+kiMr31KYKvIf80AnKarNQKYYCXrJUYqk31W0O
         m5seCE7nnOaKT5XUWY762jg2jPGenQ8RnRbMm8AyupE3UZppyhSWtfret70oOSOY86C8
         6fwO4U/iP90ibVawNf+1BTMcZvsko2tB/mLz6yIXsLSLolk7ttCCFOLGbNkWHBfanmAJ
         KY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPhaoY2sEMTSluaWgM54Ynnzw+GTULN3xj40CiEudZo=;
        b=1N1NlzdqgXg7QxTi0CL7W80fHtqehQ6HNqrr+DS6CMI0cucrbLp+lbkoQHk62F96U5
         7FkA7kGZzUeb+Z6TPVF+cOhaL2ZPY6nGd14NcGl8jP6pt4EmMEVoxIXXcU+LffsHyjZR
         3MHew2OEIuny+JphtH6iHzSsitnJm1YZZaXaY6/rz72rmBBqDHu7zcY3j/wJJI4KzOQD
         1sioi+b+t85VBgt71eNyYGbj4ssZZi0FvGuR9NqkfevScmobdsG6V6AMr9orQ3x2lHys
         geRHp5912auqCp0CtWGT0MDlE/eDVItQ4JKHT4suJQSZeBmAQKRLnQhWQsRyqMn9+PcW
         jvBw==
X-Gm-Message-State: AOAM530X9hFi2wOgUUaDPCugEqvjfhn1jX2pa/03eNTs11bIe/lBiO/F
        QUyepu+UGYYLKu5vZLgdUWx72UXdBe0=
X-Google-Smtp-Source: ABdhPJyWQQ+UmobqIg+dbXOFT3lzUdjXzA1GGFYdwDfPA9kv3sgO5wzlcYFYGTx+TWPmWS+b4Yj9Kg==
X-Received: by 2002:a05:600c:1f0c:: with SMTP id bd12mr270136wmb.56.1638216947157;
        Mon, 29 Nov 2021 12:15:47 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:46 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/11] fanotify: use helpers to parcel fanotify_info buffer
Date:   Mon, 29 Nov 2021 22:15:32 +0200
Message-Id: <20211129201537.1932819-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fanotify_info buffer is parceled into variable sized records, so the
records must be written in order: dir_fh, file_fh, name.

Use helpers to assert that order and make fanotify_alloc_name_event()
a bit more generic to allow empty dir_fh record and to allow expanding
to more records (i.e. name2) soon.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++----------------
 fs/notify/fanotify/fanotify.h | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index ffad224be014..2b13c79cebc6 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -576,7 +576,7 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 	return &ffe->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
+static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 							__kernel_fsid_t *fsid,
 							const struct qstr *name,
 							struct inode *child,
@@ -586,15 +586,17 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
-	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
+	unsigned int dir_fh_len = fanotify_encode_fh_len(dir);
 	unsigned int child_fh_len = fanotify_encode_fh_len(child);
-	unsigned int size;
+	unsigned long name_len = name ? name->len : 0;
+	unsigned int len, size;
 
-	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	/* Reserve terminating null byte even for empty name */
+	size = sizeof(*fne) + name_len + 1;
+	if (dir_fh_len)
+		size += FANOTIFY_FH_HDR_LEN + dir_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
-	if (name)
-		size += name->len + 1;
 	fne = kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
@@ -604,22 +606,23 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	*hash ^= fanotify_hash_fsid(fsid);
 	info = &fne->info;
 	fanotify_info_init(info);
-	dfh = fanotify_info_dir_fh(info);
-	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, hash, 0);
+	if (dir_fh_len) {
+		dfh = fanotify_info_dir_fh(info);
+		len = fanotify_encode_fh(dfh, dir, dir_fh_len, hash, 0);
+		fanotify_info_set_dir_fh(info, len);
+	}
 	if (child_fh_len) {
 		ffh = fanotify_info_file_fh(info);
-		info->file_fh_totlen = fanotify_encode_fh(ffh, child,
-							child_fh_len, hash, 0);
+		len = fanotify_encode_fh(ffh, child, child_fh_len, hash, 0);
+		fanotify_info_set_file_fh(info, len);
 	}
-	if (name) {
-		long salt = name->len;
-
+	if (name_len) {
 		fanotify_info_copy_name(info, name);
-		*hash ^= full_name_hash((void *)salt, name->name, name->len);
+		*hash ^= full_name_hash((void *)name_len, name->name, name_len);
 	}
 
-	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
-		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
+	pr_debug("%s: size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
+		 __func__, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
 
 	return &fne->fae;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index dd23ba659e76..7ac6f9f1e414 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -138,6 +138,26 @@ static inline void fanotify_info_init(struct fanotify_info *info)
 	info->name_len = 0;
 }
 
+/* These set/copy helpers MUST be called by order */
+static inline void fanotify_info_set_dir_fh(struct fanotify_info *info,
+					    unsigned int totlen)
+{
+	if (WARN_ON_ONCE(info->file_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->name_len > 0))
+		return;
+
+	info->dir_fh_totlen = totlen;
+}
+
+static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
+					     unsigned int totlen)
+{
+	if (WARN_ON_ONCE(info->name_len > 0))
+		return;
+
+	info->file_fh_totlen = totlen;
+}
+
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
-- 
2.33.1

