Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD664FB9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 19:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLQSsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 13:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLQSsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:48:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5940A21B9;
        Sat, 17 Dec 2022 10:48:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso6213324wms.4;
        Sat, 17 Dec 2022 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcnhtLxGH6tMzfQBTTollTof8QECLCvQEKU1dU8eYaM=;
        b=KQzTZcGydWn32a4K64Xd1ZqvlcBiYEeu3HqrcdNPSSGzOly0ieFVYVo361b47M33VI
         D4Yc72UbGkYdoz8+GPTnoVg/yWy5Yc6ewh1P9x8v7tJpGZSiAuwQGS3jpzrblC9RV8Vh
         Wg/US4me+X2T4YxGPINjlK4DEMNpxxNSRE9WZb/iepFXEDcRtIn4GVGPHrvRM1ddBM+v
         qzeWum/jYz0xQ2xqIIDJuFM2ixorENL3BYsqJHrh9dZZXqLsRLah+GjBtnf7rovOz+qf
         /Z6WpS988t4T+F3kLXc2wZ2JO05p+U20lyQZ3aSeK7gxSYTdHJaVQaoE9HVY1B4Wvqmu
         OGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcnhtLxGH6tMzfQBTTollTof8QECLCvQEKU1dU8eYaM=;
        b=co4fvdS4+e50nSWeIY0LTltSDv0AYYHzD9xcqgo/6nZEvaV4YOKlfYQT1/5tEw5tSc
         B54AiC8mOH8GYgImNTAwjbGljKl9oW7LvkFwLoU15pjyDgD0t20i2Z2NNhLzFu98kcGx
         Vpn21GmTVUZxkdSqamok891/0KBqhF0M1OoVF7RyEAyq24XQW0EFGKrm4SGDeWWvynW7
         I2RoG4/S6JQNonAPkt/Q8f45gD2ko8bFdzT8Sn0B+kCgozGiqK9HktF+CgR4NegLbNyF
         /Y6jeVmAX9xLX9MslraFAkihNZTkhBn4bL/bTqoWSXvs4EhOs0xb+t3vAxP4vVXOD+Jy
         415w==
X-Gm-Message-State: ANoB5plP6ipB9C1VwPYCHWu9aDKVQFrLLod3mqtrcUlEr1cawDpRVm0P
        j5Ts3LmqLsluvTncnxzsv14A1CA0Wis=
X-Google-Smtp-Source: AA0mqf7mqBQRbkGRxrsM4kWhEOpzYRx+zE8rMZ+3DP7FWTgTtAvQUdfS9TKaRRqIVbzMfbYi4J+6uw==
X-Received: by 2002:a05:600c:1c0d:b0:3d2:3d7b:6115 with SMTP id j13-20020a05600c1c0d00b003d23d7b6115mr10671826wms.7.1671302885808;
        Sat, 17 Dec 2022 10:48:05 -0800 (PST)
Received: from localhost.localdomain (host-79-17-30-229.retail.telecomitalia.it. [79.17.30.229])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b003b4935f04a4sm7726062wmi.5.2022.12.17.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 10:48:05 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Sat, 17 Dec 2022 19:47:48 +0100
Message-Id: <20221217184749.968-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221217184749.968-1-fmdefrancesco@gmail.com>
References: <20221217184749.968-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the signature of ufs_get_page() in order to prepare this function
to the conversion to the use of kmap_local_page(). Change also those call
sites which are required to conform its invocations to the new
signature.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 69f78583c9c1..9fa86614d2d1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -185,7 +185,7 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *ufs_get_page(struct inode *dir, unsigned long n)
+static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
@@ -195,8 +195,10 @@ static struct page *ufs_get_page(struct inode *dir, unsigned long n)
 			if (!ufs_check_page(page))
 				goto fail;
 		}
+		*p = page;
+		return page_address(page);
 	}
-	return page;
+	return ERR_CAST(page);
 
 fail:
 	ufs_put_page(page);
@@ -227,15 +229,12 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = ufs_get_page(dir, 0);
-	struct ufs_dir_entry *de = NULL;
+	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
 
-	if (!IS_ERR(page)) {
-		de = ufs_next_entry(dir->i_sb,
-				    (struct ufs_dir_entry *)page_address(page));
-		*p = page;
-	}
-	return de;
+	if (!IS_ERR(de))
+		return ufs_next_entry(dir->i_sb, de);
+	else
+		return NULL;
 }
 
 /*
@@ -273,11 +272,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 		start = 0;
 	n = start;
 	do {
-		char *kaddr;
-		page = ufs_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
-			de = (struct ufs_dir_entry *) kaddr;
+		char *kaddr = ufs_get_page(dir, n, &page);
+
+		if (!IS_ERR(kaddr)) {
+			de = (struct ufs_dir_entry *)kaddr;
 			kaddr += ufs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
 				if (ufs_match(sb, namelen, name, de))
@@ -328,12 +326,10 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *dir_end;
 
-		page = ufs_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto out;
+		kaddr = ufs_get_page(dir, n, &page);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
 		lock_page(page);
-		kaddr = page_address(page);
 		dir_end = kaddr + ufs_last_byte(dir, n);
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - reclen;
@@ -395,7 +391,6 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	/* OFFSET_CACHE */
 out_put:
 	ufs_put_page(page);
-out:
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -429,6 +424,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 	unsigned flags = UFS_SB(sb)->s_flags;
+	struct page *page;
 
 	UFSD("BEGIN\n");
 
@@ -439,16 +435,14 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 		char *kaddr, *limit;
 		struct ufs_dir_entry *de;
 
-		struct page *page = ufs_get_page(inode, n);
-
-		if (IS_ERR(page)) {
+		kaddr = ufs_get_page(inode, n, &page);
+		if (IS_ERR(kaddr)) {
 			ufs_error(sb, __func__,
 				  "bad page in #%lu",
 				  inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
-		kaddr = page_address(page);
 		if (unlikely(need_revalidate)) {
 			if (offset) {
 				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
@@ -595,12 +589,11 @@ int ufs_empty_dir(struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		struct ufs_dir_entry *de;
-		page = ufs_get_page(inode, i);
 
-		if (IS_ERR(page))
+		kaddr = ufs_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = page_address(page);
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
 
-- 
2.39.0

