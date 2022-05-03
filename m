Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C4517D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiECGns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiECGnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E761A4
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XCUVBbBEPVIU9BeQxjHqMwA6uziqJF6mSDyRf8zgf0Y=; b=LLHZ0lNyIJ65aqwUTUJXJDjhAu
        vv5+awhouGM2yQ5vmW0rf0ZW8z4XRyKA+EpppiWw1lGw6uYzAzdte725K8TSWpoqn8aehvHp8mf7Y
        AKCzSR2Cnt+dlH1dFQChrSbtfuPe0ObbXdnHHg12uRDsKIIkwFwTDYMed4/9/zTSyM6M9rfw2MOAX
        AtYkIUW3jMeFdwdLry/tB2fmajnr0hzQ/5BZ+2h4U3oSpi8Ox5kXWeU2JmkGUDSi+/dvCQvQPgoSm
        XRuxrui6BkovKwSqX5J6hH8wNqFiJTY0CvU4JbpXlgFhfm6BgI/jmS3gmDvhMMW/4LBTGVB/4g6wV
        uOKvcTRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCh-00FRxE-Mi; Tue, 03 May 2022 06:40:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 01/10] iomap: Pass struct iomap to iomap_alloc_ioend()
Date:   Tue,  3 May 2022 07:39:59 +0100
Message-Id: <20220503064008.3682332-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220503064008.3682332-1-willy@infradead.org>
References: <20220503064008.3682332-1-willy@infradead.org>
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

iomap_alloc_ioend() does not need the rest of iomap_writepage_ctx;
only the iomap contained in it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c51a75d0be6..03c7c97bc871 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1222,15 +1222,15 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 	return 0;
 }
 
-static struct iomap_ioend *
-iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
-		loff_t offset, sector_t sector, struct writeback_control *wbc)
+static struct iomap_ioend *iomap_alloc_ioend(struct inode *inode,
+		struct iomap *iomap, loff_t offset, sector_t sector,
+		struct writeback_control *wbc)
 {
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
-	bio_set_dev(bio, wpc->iomap.bdev);
+	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	bio->bi_write_hint = inode->i_write_hint;
@@ -1238,8 +1238,8 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_type = wpc->iomap.type;
-	ioend->io_flags = wpc->iomap.flags;
+	ioend->io_type = iomap->type;
+	ioend->io_flags = iomap->flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_folios = 0;
@@ -1305,14 +1305,15 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
-	sector_t sector = iomap_sector(&wpc->iomap, pos);
+	struct iomap *iomap = &wpc->iomap;
+	sector_t sector = iomap_sector(iomap, pos);
 	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, wpc, pos, sector, wbc);
+		wpc->ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
 	}
 
 	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
-- 
2.34.1

