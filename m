Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B651F12B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiEHUdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiEHUc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:32:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B370BDFFD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WYHnNN+2ykxYiDCyblVp4lBV6PG8pQEizF6ha8GGHUw=; b=R7D7mievhC07eN9g/R2b8u8BIK
        XlEyo8XTPnZ7reext009o+sbo9PI7oZkwixQ1o8M06/Dc9i1/HtFF8oTQK9knxcMh/Sp6Bgl6nfxV
        3/tZOxoiOUP7GpTh/5FL/o7OzUhCjYmRC2qSulCAZ2p3mwDvbNUaFgbqgIeyZ6PJ27W/x76mBS8xb
        WAPicZiTlaKMf2hUawFAF/Fvdd3Kkg3SuASTumkIYDCu3kBNHYw9N6uCSUKbPk7UUFb/COJLYJkTP
        c21J0bY6n4MnWeO4GZmkArrCZ7cK1jn4+GIo+HNcI35o7+Q/MzWyMpiUqg+WAExAUicT58VFro/nA
        AGgLC98w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnWc-002nUK-Tk; Sun, 08 May 2022 20:29:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] scsicam: Fix use of page cache
Date:   Sun,  8 May 2022 21:28:49 +0100
Message-Id: <20220508202849.666756-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YngbFluT9ftR5dqf@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
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

Convert scsicam to use a folio instead of a page.  There is no need to
check the error flag here; read_cache_folio() will return -EIO if the
folio cannot be read correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/scsi/scsicam.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index acdc0aceca5e..e2c7d8ef205f 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -34,15 +34,14 @@ unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
 	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
 	unsigned char *res = NULL;
-	struct page *page;
+	struct folio *folio;
 
-	page = read_mapping_page(mapping, 0, NULL);
-	if (IS_ERR(page))
+	folio = read_mapping_folio(mapping, 0, NULL);
+	if (IS_ERR(folio))
 		return NULL;
 
-	if (!PageError(page))
-		res = kmemdup(page_address(page) + 0x1be, 66, GFP_KERNEL);
-	put_page(page);
+	res = kmemdup(folio_address(folio) + 0x1be, 66, GFP_KERNEL);
+	folio_put(folio);
 	return res;
 }
 EXPORT_SYMBOL(scsi_bios_ptable);
-- 
2.34.1

