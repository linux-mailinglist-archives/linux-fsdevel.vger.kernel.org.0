Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D57653529
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiLUR2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUR2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:28:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9505E220CF;
        Wed, 21 Dec 2022 09:28:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so1940944wmb.5;
        Wed, 21 Dec 2022 09:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcnhtLxGH6tMzfQBTTollTof8QECLCvQEKU1dU8eYaM=;
        b=MRRdRzrXZo96VVroVxTkZ5/w5ldZaocJ6/BnB9jhWpKAorzkmI/U4jUhKFuPQ7pZ8X
         w5FqJj0iv/z/lSAzxCLTjuVxcnbOb6fvg9Lodgf1zppxO3aSm7AjBRI6hQVCvUPBTyJd
         RUpnusMiLIhcfpll7WHjtTaTMF0Xo2wRqvU6qlyxA5fCVKGSe/xva+3cLMC85KfcGWu6
         iyrfBkLdk9k8T7MRWc/97AIsLB/5kj2z1kM5tEqdy5AHFhbQ3YD5lFJs83Xf+pKpPYCo
         SHs0m/fE2VV8G1A2FlJHdG7r8/TgZ3l0b/5FZtVTD0M1I1+KE5uqkWP4Mo1wKLxITqKM
         jhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcnhtLxGH6tMzfQBTTollTof8QECLCvQEKU1dU8eYaM=;
        b=66RjKZN2R9td9IHANh7denxGyRbFFhiwE4atMLBYY5TFWoR1vk7VDdG6nWwme3uoWj
         33oBba5ZqHixHe3vXWEDCtOL/F8rImhoWynG2lwI60dPWZEIMuWhgwrYFifZaEWXjaU9
         /VpxuQK/8gQr9QIQ+RGhwBjrd0w6ueVnWVcpsvuhxPborPau80otn2IKVCTfpQd3kcuR
         mLQyQr6wbf28/HNRCRBXqV7XLUTngDLuZ+lGqVT6k1E2mO9W7u0T+LOC+urOVqaiXpMp
         GUFNmrnUyHaqbpaZA9+wSgePQ96RzfLxNSsQQmJSpQWLDYR1YO0VkXOOhsdax83UtXJC
         LjQg==
X-Gm-Message-State: AFqh2kpWF6QEKDeUqbM7jT0/XrYcJXE4PTcDGJjrtpKT277BX9qyzSoY
        L9fL4KZlBg61+QE5YWW+SeQ=
X-Google-Smtp-Source: AMrXdXs8ospSPlhyLxuv2Htp79Ddgwdcs8fd8xpu1dmOyhdY/4fKffxRurzQnAcBovfxatkxKoDiWw==
X-Received: by 2002:a7b:c408:0:b0:3d5:64bf:ccc2 with SMTP id k8-20020a7bc408000000b003d564bfccc2mr2181183wmi.32.1671643691078;
        Wed, 21 Dec 2022 09:28:11 -0800 (PST)
Received: from localhost.localdomain (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003cffd3c3d6csm3003260wmr.12.2022.12.21.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:28:10 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Wed, 21 Dec 2022 18:28:01 +0100
Message-Id: <20221221172802.18743-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221172802.18743-1-fmdefrancesco@gmail.com>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
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

