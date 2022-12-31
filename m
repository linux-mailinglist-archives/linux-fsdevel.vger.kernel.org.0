Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4D65A327
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 08:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiLaH5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 02:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiLaH53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:57:29 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024933F;
        Fri, 30 Dec 2022 23:57:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso13832357wms.5;
        Fri, 30 Dec 2022 23:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WGDj24HpD7Fo6/hb6lWcextCLZNM+3WgApo42pp5bs=;
        b=PLbdELi1nRGwMCglDcSwc1BWlakcf17hJxcXqkHIeaL1xfgDECfdFpOFMLNuZsuRRR
         AtE97k3gY3oflnsRlxm8empC08LnfGuSSvv07iLbZ3DxV/5mNE+hATn4rUmjcNwOi43V
         BG7yIvoA3l/m4aGM0fd0hSTeGv/Ig1EmsNfkq4F/WxFOLueggX9dDtZxm1zkA0yBegi6
         DXthstEJ9YOAt0vgtPK47xQwyUAvi2c8LZqu6oopzlmbXzD0yZHUWD/QUqP0EFAexTW0
         +rrQxEExL8nb7xCtuA+KZ9m+2Jo/Fd5DAI4fNuxTJxWKgZiAy8qaZX7tJHks6t2Ype2f
         XpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WGDj24HpD7Fo6/hb6lWcextCLZNM+3WgApo42pp5bs=;
        b=ndEXL3aCXhczamIjg0ahWFYtrgehiFErlcNaiQg8QnOSNCYkEGWEiwo7FVzeV64FXP
         TNwEaUFFYUX69aKmP5SD+sM9WmC5Y2rP9PjgxMTvAHxYYUuYGDK/G266KxddOXLFNJTg
         eN2dZq3eoxgzgN3WMBGcGOG44PDQMM+Z547s70vwhbgvwJz085dXYbCeSTgk8VDUyJO5
         lYRdLAle6Gd+NyUhHk6JTn4mczJXyABFaYAVQOk48HQkE1Nvoau8tOS9DYtdxdoW3xzc
         aB8JT+VqNTVOP2PaB4MgqU+dQ8rCu69pSImqrzYRvboxPU6c/mD6pMUxlzNsap1KtqIc
         zo1w==
X-Gm-Message-State: AFqh2kqku6olZQVZK1qTJygC0/13uS+v4JPDbarZTzOPdmv4oj88IhAQ
        6HdzLlnmQX/PdgOPG9JKdHRHCvSoTXw=
X-Google-Smtp-Source: AMrXdXs4Kavj3cJknZ10v1GrO1/fa7oLrOIX049dDFrrZETbqVZvPi8vNuEUER8+Ie6WoQULyGyosQ==
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id m34-20020a05600c3b2200b003c6e63e814bmr24007443wms.2.1672473445417;
        Fri, 30 Dec 2022 23:57:25 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm39389232wms.11.2022.12.30.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:57:24 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/4] fs/sysv: Change the signature of dir_get_page()
Date:   Sat, 31 Dec 2022 08:57:15 +0100
Message-Id: <20221231075717.10258-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231075717.10258-1-fmdefrancesco@gmail.com>
References: <20221231075717.10258-1-fmdefrancesco@gmail.com>
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

Change the signature of dir_get_page() in order to prepare this function
to the conversion to the use of kmap_local_page(). Change also those call
sites which are required to conform to the new signature.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 685379bc9d64..0a8b5828c390 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -52,13 +52,15 @@ static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static struct page * dir_get_page(struct inode *dir, unsigned long n)
+static void *dir_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
+	if (IS_ERR(page))
+		return ERR_CAST(page);
+	kmap(page);
+	*p = page;
+	return page_address(page);
 }
 
 static int sysv_readdir(struct file *file, struct dir_context *ctx)
@@ -80,11 +82,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct sysv_dir_entry *de;
-		struct page *page = dir_get_page(inode, n);
+		struct page *page;
 
-		if (IS_ERR(page))
+		kaddr = dir_get_page(inode, n, &page);
+		if (IS_ERR(kaddr))
 			continue;
-		kaddr = (char *)page_address(page);
 		de = (struct sysv_dir_entry *)(kaddr+offset);
 		limit = kaddr + PAGE_SIZE - SYSV_DIRSIZE;
 		for ( ;(char*)de <= limit; de++, ctx->pos += sizeof(*de)) {
@@ -142,11 +144,10 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 	n = start;
 
 	do {
-		char *kaddr;
-		page = dir_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = (char*)page_address(page);
-			de = (struct sysv_dir_entry *) kaddr;
+		char *kaddr = dir_get_page(dir, n, &page);
+
+		if (!IS_ERR(kaddr)) {
+			de = (struct sysv_dir_entry *)kaddr;
 			kaddr += PAGE_SIZE - SYSV_DIRSIZE;
 			for ( ; (char *) de <= kaddr ; de++) {
 				if (!de->inode)
@@ -185,11 +186,10 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 
 	/* We take care of directory expansion in the same loop */
 	for (n = 0; n <= npages; n++) {
-		page = dir_get_page(dir, n);
+		kaddr = dir_get_page(dir, n, &page);
 		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto out;
-		kaddr = (char*)page_address(page);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
 		de = (struct sysv_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
 		while ((char *)de <= kaddr) {
@@ -219,7 +219,6 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 out_page:
 	dir_put_page(page);
-out:
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -288,12 +287,11 @@ int sysv_empty_dir(struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		struct sysv_dir_entry * de;
-		page = dir_get_page(inode, i);
 
-		if (IS_ERR(page))
+		kaddr = dir_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = (char *)page_address(page);
 		de = (struct sysv_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE-SYSV_DIRSIZE;
 
@@ -339,16 +337,16 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	mark_inode_dirty(dir);
 }
 
-struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
+struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = dir_get_page(dir, 0);
-	struct sysv_dir_entry *de = NULL;
+	struct page *page = NULL;
+	struct sysv_dir_entry *de = dir_get_page(dir, 0, &page);
 
-	if (!IS_ERR(page)) {
-		de = (struct sysv_dir_entry*) page_address(page) + 1;
+	if (!IS_ERR(de)) {
 		*p = page;
+		return (struct sysv_dir_entry *)page_address(page) + 1;
 	}
-	return de;
+	return NULL;
 }
 
 ino_t sysv_inode_by_name(struct dentry *dentry)
-- 
2.39.0

