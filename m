Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077E456AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhKSHUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhKSHUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45420C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7155370wmh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rZBLdsgOnXEUuEzMVPJfSZkyib3Ve4bmbVA52LhnRo=;
        b=SxpHkYUVzyesWTin9jz8d1v7KZTMLsUkXSxSvl2HyPyDWvs5fWOBkT3t3VqdmlIrt8
         z8ZFZRkwqJnP0rs+iDR4nZtiOmD3E5yUGtH/aih6CeE64Q9Dqmn3nKztBCwHmKwhozVg
         gvsvMHNXO0yhNQe2taUteZs9yI13Pk9dgW1TvXeLj30KdcOPZI2yTUWuUKzvYDSaJe4n
         iCOvNuKiuXPXHQKTWLqiEP+JuMC5r8p2/zQWkULyoiaU3rDHGeZv6Wo8jgbP70WD/Fdi
         n1l0byn38dBdyKxkuTD/ZaPGaU8VPZ5pArWo5horN2KCwvXu3kZwPFm8T9YjA6vJS+ju
         U8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rZBLdsgOnXEUuEzMVPJfSZkyib3Ve4bmbVA52LhnRo=;
        b=PKOQPFhsMbly+mWHErbufsrdy7mumGiZUgsTqjKt29ucNgWhocKKS5AnBZRHUSnZI+
         M4ZWPt6yWDzJSatdRgaHo79rSK4PZOFzmEGuWEa7AT7rTyBzqOvinJUwkcfJucbbtexm
         y0NfimnFvM252/1k6Lf/pREB4qc2HPZoTrZW1FaWNGnClx3RnTbz/xNA/fFKK50pDLEL
         m+lhfATUhnHw5kh55l3ezQ6vS4XewIWREMYG0x2lMT4aM4LUmkUprDQq3sV2Ava5q0u3
         9gWKlB0H1hiE582OoW9R2aByNjSSMI5AGhiFyVba1sYhGuJHZrM4WoMlm9bUoNZHfDQu
         y3Lw==
X-Gm-Message-State: AOAM531JoLwIQq8TcMj7pZudOAaSqarjwS3rl3V2dvaDHnYqWWOefaq5
        2qXTj/8YYiMe11q1iglN7H0/B5yRZIY=
X-Google-Smtp-Source: ABdhPJxmZg5Tdg7zEngo3xDib7lX/pnkwOejpyhrpNVk4wR0e8gklDrgh6zvQZqExoDgvXQrj4HGmg==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr3997465wmz.131.1637306266858;
        Thu, 18 Nov 2021 23:17:46 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:46 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/9] fanotify: use helpers to parcel fanotify_info buffer
Date:   Fri, 19 Nov 2021 09:17:33 +0200
Message-Id: <20211119071738.1348957-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
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
index 4a812411ae5b..a274f57726dd 100644
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

