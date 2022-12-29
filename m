Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816C16592A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiL2WvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 17:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiL2WvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:51:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970D20A;
        Thu, 29 Dec 2022 14:51:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d4so10476847wrw.6;
        Thu, 29 Dec 2022 14:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qndbUmC9baF10x7bSkAHM3x3kD+tq9+2IIVOyDJtXYU=;
        b=oLM32qdIfkhLdBigD9vfim8MEh9R9nSwgIuPyHowclcQ5FDWtuQxzIpDLgHOW2xGkg
         tlswl+R6jZpvZNCstmKFT3HsAjIJ9Jyx2HbpJLCeRMH3o58om/XnqWlahgyJdQmue0JT
         AR37HMaPtU1K1UgWuz6KNdaBvY3LFApglT4QSQTIeBXw3eHIuaJ9dLIM8NXMSx/Et+NF
         jZxg+jtJh95NzQ8aGE/wYAG59252aGN6Hg8gEGk5GtyqqR80sPEPxju7Ukf2XjoOIeQ+
         h2vw51/HB3Yv+6YVNVNtgYhXNbSkD5mwuVUiCCJvKOEUB2ts/kk2cqT/NrA4LpI8ADOW
         JAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qndbUmC9baF10x7bSkAHM3x3kD+tq9+2IIVOyDJtXYU=;
        b=lFUzGANjd2KO1WiPwnxrSzAegL2MJcfIUHLCd9LO9HKXvEh+welEGmUG1Z9h+LHp6S
         wM6eZiGLcnKJ2cosBqYzqZnnlivi+Wgz4Ndh73HE8pp/Jxe0caAsG8Etb1JOBX25skOn
         fFttAJD5yB8H5DgiF95TAiuJ65VRCy8TL3vFs60rXBi00KH8PFUaA8d8eyTB+rywEv3k
         timI+2tunMep5Uv9S7UWyRR4RlII6X3u1s3cNj5Avjj7F0hP1X7GvnkahESNzfkze5r6
         HjLr/ZxGGtmKi8r/y5iSkGC8Rm3yF7uJud7QzCAVAAGUKDcWUwBBWwmcNirDWxWTQ7HK
         7PqA==
X-Gm-Message-State: AFqh2kpZlOJiBrju0BRHEjRHTINNFJ5NWactccy83VldQg3IKPEsjd4z
        WzNXtUbr/fm4Ggwk8xNmZpY=
X-Google-Smtp-Source: AMrXdXs9Bv7c7MGRQ6dBTSJsSfNlI9eYGhiJ0MEkv+u+pmNpUJaAHONfV7wRr+NaydocvkGURy94AQ==
X-Received: by 2002:a05:6000:d1:b0:242:5698:6faf with SMTP id q17-20020a05600000d100b0024256986fafmr16850518wrx.2.1672354267430;
        Thu, 29 Dec 2022 14:51:07 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id p3-20020adfcc83000000b0027a57c1a6fbsm13493312wrj.22.2022.12.29.14.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:51:06 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 2/4] fs/ufs: Change the signature of ufs_get_page()
Date:   Thu, 29 Dec 2022 23:50:58 +0100
Message-Id: <20221229225100.22141-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229225100.22141-1-fmdefrancesco@gmail.com>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 69f78583c9c1..ae3b20354a28 100644
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
@@ -438,17 +433,16 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct ufs_dir_entry *de;
+		struct page *page;
 
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

