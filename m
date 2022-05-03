Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC2517D87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiECGof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiECGoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:44:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB227107
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Di4jPnOXCZQJlZKyMXkv6+DkGMbrUEgKEtDIWyIlRv8=; b=ruzsaEx+JFdWQFikwZoqTgX7qL
        EnLeF+iY+EVACejAM+U6ZmuUMCQTrojr99olY000rBSe1cHFQN5UL9K20/P+rgKBKruuOPKbGJ2LS
        gygUL3efkBysmjAQkkvUEu6uENoTfuudwSHfTRn3li/o5P904yvaneSEYjg1qqftjNGo32frMgYoZ
        K0lGzpP25LaLn5qHDtZ4wIKxE4S5busLLlanV3i+4sp/ELMcMzV7n9De0GZKwrZ3s41LdAvFqYQE/
        Z5kTAc7wxC+Ylde9ZJOegTxkqQ0HshRCsjYschyvvggeqEeuWTkeNVt0UU+1V/TJ9cF0gQq+FH7n1
        K4H06+GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCh-00FRxG-Ps; Tue, 03 May 2022 06:40:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 02/10] iomap: Remove iomap_writepage_ctx from iomap_can_add_to_ioend()
Date:   Tue,  3 May 2022 07:40:00 +0100
Message-Id: <20220503064008.3682332-3-willy@infradead.org>
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

In preparation for using this function without an iomap_writepage_ctx,
pass in the iomap and ioend.  Also simplify iomap_add_to_ioend() by
using the iomap & ioend directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 03c7c97bc871..c91259530ac1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1273,25 +1273,24 @@ iomap_chain_bio(struct bio *prev)
 	return new;
 }
 
-static bool
-iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
-		sector_t sector)
+static bool iomap_can_add_to_ioend(struct iomap *iomap,
+		struct iomap_ioend *ioend, loff_t offset, sector_t sector)
 {
-	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
-	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
+	if ((iomap->flags & IOMAP_F_SHARED) !=
+	    (ioend->io_flags & IOMAP_F_SHARED))
 		return false;
-	if (wpc->iomap.type != wpc->ioend->io_type)
+	if (iomap->type != ioend->io_type)
 		return false;
-	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
+	if (offset != ioend->io_offset + ioend->io_size)
 		return false;
-	if (sector != bio_end_sector(wpc->ioend->io_bio))
+	if (sector != bio_end_sector(ioend->io_bio))
 		return false;
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
 	 * also prevents long tight loops ending page writeback on all the
 	 * folios in the ioend.
 	 */
-	if (wpc->ioend->io_folios >= IOEND_BATCH_SIZE)
+	if (ioend->io_folios >= IOEND_BATCH_SIZE)
 		return false;
 	return true;
 }
@@ -1306,24 +1305,26 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
 	struct iomap *iomap = &wpc->iomap;
+	struct iomap_ioend *ioend = wpc->ioend;
 	sector_t sector = iomap_sector(iomap, pos);
 	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
-		if (wpc->ioend)
-			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
+	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, pos, sector)) {
+		if (ioend)
+			list_add(&ioend->io_list, iolist);
+		ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
+		wpc->ioend = ioend;
 	}
 
-	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
-		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
-		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
+	if (!bio_add_folio(ioend->io_bio, folio, len, poff)) {
+		ioend->io_bio = iomap_chain_bio(ioend->io_bio);
+		bio_add_folio(ioend->io_bio, folio, len, poff);
 	}
 
 	if (iop)
 		atomic_add(len, &iop->write_bytes_pending);
-	wpc->ioend->io_size += len;
+	ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
 
-- 
2.34.1

