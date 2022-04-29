Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C8515204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379685AbiD2Rak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379614AbiD2R3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A889BA66E8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MbxjnmP4ZXSg5OMir1jLNbwogQDgOF2ioH/l9iNR8ww=; b=NlAgHbScUk5bi8UBvz0r4nf+co
        Raot42c/uNzPJKqyJHITt5KJftE5uJT1T41iz9kAZLTAV8NRAjkD2Fy+3VCmc/MG3ij0k+06Ki4+Z
        yLfB4AlZ/nttBUi+21GE90r4Pt1Zs9XxQMGrG9Euj44stLyC+B6r3936sROepEWOuNzrafTm/HK0m
        mT2J7VVEibAEOVOYcm8oCjHu8ip1O8sWgvYyKKQE3S52FbeKodw+Z/db12krOPSzxQDH+5C4aHTO0
        7tIjBP1yW/9W+Ld2osfO6feQYW5XnpRuNdyd/NKVXilhMiOz4bUpYvH1Kp14U+fhf7CYPy0L5X9dh
        6cCrzLjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNd-00Cdce-EB; Fri, 29 Apr 2022 17:26:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 57/69] jffs2: Convert jffs2 to read_folio
Date:   Fri, 29 Apr 2022 18:25:44 +0100
Message-Id: <20220429172556.3011843-58-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jffs2/file.c | 10 +++++-----
 fs/jffs2/fs.c   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 2b35811772de..f8616683fbee 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -27,7 +27,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
-static int jffs2_readpage (struct file *filp, struct page *pg);
+static int jffs2_read_folio(struct file *filp, struct folio *folio);
 
 int jffs2_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
@@ -72,7 +72,7 @@ const struct inode_operations jffs2_file_inode_operations =
 
 const struct address_space_operations jffs2_file_address_operations =
 {
-	.readpage =	jffs2_readpage,
+	.read_folio =	jffs2_read_folio,
 	.write_begin =	jffs2_write_begin,
 	.write_end =	jffs2_write_end,
 };
@@ -118,13 +118,13 @@ int jffs2_do_readpage_unlock(void *data, struct page *pg)
 }
 
 
-static int jffs2_readpage (struct file *filp, struct page *pg)
+static int jffs2_read_folio(struct file *file, struct folio *folio)
 {
-	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
+	struct jffs2_inode_info *f = JFFS2_INODE_INFO(folio->mapping->host);
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
+	ret = jffs2_do_readpage_unlock(folio->mapping->host, &folio->page);
 	mutex_unlock(&f->sem);
 	return ret;
 }
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 71f03a5d36ed..00a110f40e10 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -178,7 +178,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	jffs2_complete_reservation(c);
 
 	/* We have to do the truncate_setsize() without f->sem held, since
-	   some pages may be locked and waiting for it in readpage().
+	   some pages may be locked and waiting for it in read_folio().
 	   We are protected from a simultaneous write() extending i_size
 	   back past iattr->ia_size, because do_truncate() holds the
 	   generic inode semaphore. */
-- 
2.34.1

