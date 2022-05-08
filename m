Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6151F167
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiEHUgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiEHUfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB12DEF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5q6pihEh5qHpwkIUMREQkE2pZvOoCqZcQAv/Kv9aXYE=; b=Wb2RntRE1gGDgBQ15KjWiu9pUw
        KWhxziA0OhF86h0S5L0U4aXw2BbRHpPLlGvIwmzp+dIpQ1/0NT4X0gmbnRXX3x1Ma87mCkqCvgn8G
        wiYNzu7aWEj8ZXL9u7mHcLYBZi1oKtRgnMOqD+X6/ubQaQqygVKtAcIWW1Ngw/glsoXvGNINnEODz
        eefanW8OgC+t8Yvtq3Dr+79pClR1Zm8lX6jpMqEu6hCKx2VaegYzBW2aWBOBLEARCT4ZwMa/uq5gM
        r2/mliqwPvqrWop5otiavzrqWFK+In3VRQBe66QNEk0TLQL8TZEyZEFdBJ8BQWZS9VKCG0Fglfk0g
        m8fl/gdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ5-002noL-1X; Sun, 08 May 2022 20:31:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/37] erofs: Convert erofs zdata to read_folio
Date:   Sun,  8 May 2022 21:31:11 +0100
Message-Id: <20220508203131.667959-18-willy@infradead.org>
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
 fs/erofs/zdata.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e6dea6dfca16..95efc127b2ba 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -791,7 +791,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
 				       unsigned int readahead_pages)
 {
-	/* auto: enable for readpage, disable for readahead */
+	/* auto: enable for read_folio, disable for readahead */
 	if ((sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO) &&
 	    !readahead_pages)
 		return true;
@@ -1488,8 +1488,9 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	}
 }
 
-static int z_erofs_readpage(struct file *file, struct page *page)
+static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *const inode = page->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
@@ -1563,6 +1564,6 @@ static void z_erofs_readahead(struct readahead_control *rac)
 }
 
 const struct address_space_operations z_erofs_aops = {
-	.readpage = z_erofs_readpage,
+	.read_folio = z_erofs_read_folio,
 	.readahead = z_erofs_readahead,
 };
-- 
2.34.1

