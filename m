Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED6649681
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLKVba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 16:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLKVb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 16:31:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896FBC99;
        Sun, 11 Dec 2022 13:31:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso8565765wmb.0;
        Sun, 11 Dec 2022 13:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO4/ERMIN9nZq44yFlvMqRszu/PsYtiiSWLF6dQbDKM=;
        b=emEK43fXCYtt0QOkugug9uHbdapiTHrNAxtcEWvYoNQGWhuSZnEd4TR7z2ITdOAAud
         Gp8SA8r1M/CdoknWxd8+Lg7X09IuWtpT8hAGrciRbkX6aZIYQv6jxfnzZvf8CyMs3jPP
         pv12GmWfDJAbFJGJI34m9YlswEd5KdiIP29RF8eMF+nlC7Ziu38S2dSPQ1eqAsKMXSYC
         R5IqTgCQeEHK3rxG5uvgDmwUP0n/5p6TMurISJH8nrtipeXwflu6L4Ab3/Js/R7W63mm
         xIgPsgwtmSBzMMfkxKdbTg/qdPLIswK7E9A7CSb9oeLT2uMQlftNPSt5GNSfo/9Kqlf7
         sQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO4/ERMIN9nZq44yFlvMqRszu/PsYtiiSWLF6dQbDKM=;
        b=GZjzYd50+9W8wPoUnC+ncOLFose53WTiDGuf/KltJZRL90CxcplU7LQy8XG4VMWQ8A
         TEvqMRNVjPoMZCvkmbdYWcN8yWWAsdI3qiKfZGHlNOPc9N2LCkhgWV9lH5qENjM/dW8S
         MRfNS8s2bQ5humz8yL2y7ia67j31+y4GJcCJRnbZiPTtTDZusLnOa3CggEpzFxX3HowX
         U0AjcPL7aGAfHZvsBUPtpfWiTVQOrQEzSHjHFb3o2ITlQzYtisrdg975BU7N8mxba3gT
         q39cJq80/BMfGQv828x1ZPGyxF/cSe9po85y4NcJmaUQD3v/AbAWAHMXda/a2VxQ/Vh4
         OEtw==
X-Gm-Message-State: ANoB5pkxwcH2ZxLTr8HvIs8vxzWfacvJlZADgI+I5m4AfFvFsE0l/vlc
        HI5swqNMvp6DjptiDvianHwA5iVgBPs=
X-Google-Smtp-Source: AA0mqf5ihx4Q3YPN5I2Y9XxUAf6J9EFqWmBBkwpx33fAjG+z+QhZK13KI9X2/heFqtSRr9Nsk2LR8Q==
X-Received: by 2002:a05:600c:a54:b0:3cf:894f:964b with SMTP id c20-20020a05600c0a5400b003cf894f964bmr10646599wmq.16.1670794281261;
        Sun, 11 Dec 2022 13:31:21 -0800 (PST)
Received: from localhost.localdomain (host-95-247-100-134.retail.telecomitalia.it. [95.247.100.134])
        by smtp.gmail.com with ESMTPSA id m127-20020a1c2685000000b003d1d5a83b2esm6866350wmm.35.2022.12.11.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 13:31:20 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Sun, 11 Dec 2022 22:31:10 +0100
Message-Id: <20221211213111.30085-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211213111.30085-1-fmdefrancesco@gmail.com>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
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
 fs/ufs/dir.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 69f78583c9c1..bb6b29ce1d3a 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -185,21 +185,21 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *ufs_get_page(struct inode *dir, unsigned long n)
+static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page)) {
-		kmap(page);
-		if (unlikely(!PageChecked(page))) {
-			if (!ufs_check_page(page))
+	*page = read_mapping_page(mapping, n, NULL);
+	if (!IS_ERR(*page)) {
+		kmap(*page);
+		if (unlikely(!PageChecked(*page))) {
+			if (!ufs_check_page(*page))
 				goto fail;
 		}
 	}
 	return page;
 
 fail:
-	ufs_put_page(page);
+	ufs_put_page(*page);
 	return ERR_PTR(-EIO);
 }
 
@@ -227,15 +227,12 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 
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
@@ -273,11 +270,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
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
@@ -328,12 +324,10 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
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
@@ -395,8 +389,6 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	/* OFFSET_CACHE */
 out_put:
 	ufs_put_page(page);
-out:
-	return err;
 out_unlock:
 	unlock_page(page);
 	goto out_put;
@@ -429,6 +421,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 	unsigned flags = UFS_SB(sb)->s_flags;
+	struct page *page;
 
 	UFSD("BEGIN\n");
 
@@ -439,16 +432,14 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
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
@@ -595,12 +586,11 @@ int ufs_empty_dir(struct inode * inode)
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
2.38.1

