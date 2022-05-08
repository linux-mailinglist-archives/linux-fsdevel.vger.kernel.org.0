Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493BD51F16E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiEHUg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiEHUfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E52C6D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rfqqXMeB9rJaPeF1zuhJSPvJieW4idxHLaMUnr+URVs=; b=RHijWenYiVtDun/Jzxg9xqiq1M
        E1OQ3dV9BNvgGHyhYZyxtHVsv8DM7to4rAQ9TQTZEQZQ55r7xaxYth1c6REzrjbKmDwSaaflDinqd
        GC5CC3MN9+eE4A+XFYCda59bmSyMdRg2xBImJdLWFwsfpWNIzx/zkNvwE0cFG+4mlxxzwnh+wz6A5
        EZw/M5pwibHaS+dFJ/T44ICQA2MhDokelpXCKVycMalayxRBu3SPCe37vNq1b/kvyqWWJdJN3fzRL
        Mp58Z4pNtRGlWQHqI7gYY4rUgux9C+BMnqsaCvIKoJl6+OSqRicm404w7eaeJBxIDz7GlYp5wmpBj
        dlriIItA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ6-002npF-6b; Sun, 08 May 2022 20:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 26/37] jfs: Convert metadata pages to read_folio
Date:   Sun,  8 May 2022 21:31:20 +0100
Message-Id: <20220508203131.667959-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/jfs/jfs_metapage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index c4220ccdedef..2fc78405b3f2 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -467,8 +467,9 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	return -EIO;
 }
 
-static int metapage_readpage(struct file *fp, struct page *page)
+static int metapage_read_folio(struct file *fp, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct bio *bio = NULL;
 	int block_offset;
@@ -563,7 +564,7 @@ static void metapage_invalidate_folio(struct folio *folio, size_t offset,
 }
 
 const struct address_space_operations jfs_metapage_aops = {
-	.readpage	= metapage_readpage,
+	.read_folio	= metapage_read_folio,
 	.writepage	= metapage_writepage,
 	.releasepage	= metapage_releasepage,
 	.invalidate_folio = metapage_invalidate_folio,
-- 
2.34.1

