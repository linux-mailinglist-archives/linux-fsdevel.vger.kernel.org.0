Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A43517D84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiECGob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiECGnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12DB25F4
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0dCe1WB6ORwMe0scEVZDq3u+o381aHETVcM7HD9aQ3Q=; b=tTXkD9zZL2vx56180ECQHTreHf
        htidH5xq0h/gl8qMDk7uqOJzkVlHvWZ569GcY+X9AxuALFWbQQk97LT1Z7lZRaW4aTtf1fyKg4rgq
        m7n98nEdg/2Zv3iHUs63os1CCiD6GcvRlh+mvC+wB/IIJLyZGFywcqaOAEZ4nN0trnpz00eYT1m/v
        0OCmhC47K5A2EWwAepIerQfcWYVIoUGiJLxU3ZtTgoFbqQQQ53eZ34ewHJKti2B3EwR8ag/jH4pDV
        /Qb+uj9f+cItmomKls5IM50YQgP5LxPPd7UxRzAL06b2lMV+nb2a2/pUFVnhNOwL2PmjzVmTU1Dky
        z4ZD/orw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCi-00FRxO-4U; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 06/10] iomap: Pass a length to iomap_add_to_ioend()
Date:   Tue,  3 May 2022 07:40:04 +0100
Message-Id: <20220503064008.3682332-7-willy@infradead.org>
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

Allow the caller to specify how much of the page to add to the ioend
instead of assuming a single sector.  Somebody should probably enhance
iomap_writepage_map() to make one call per extent instead of one per
block.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 024e16fb95a8..5b69cea71f71 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1304,12 +1304,12 @@ static bool iomap_can_add_to_ioend(struct iomap *iomap,
  * first; otherwise finish off the current ioend and start another.
  */
 static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
-		loff_t pos, struct folio *folio, struct iomap_page *iop,
-		struct iomap *iomap, struct iomap_ioend *ioend,
-		struct writeback_control *wbc, struct list_head *iolist)
+		loff_t pos, size_t len, struct folio *folio,
+		struct iomap_page *iop, struct iomap *iomap,
+		struct iomap_ioend *ioend, struct writeback_control *wbc,
+		struct list_head *iolist)
 {
 	sector_t sector = iomap_sector(iomap, pos);
-	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
 
 	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, pos, sector)) {
@@ -1377,7 +1377,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		wpc->ioend = iomap_add_to_ioend(inode, pos, folio, iop,
+		wpc->ioend = iomap_add_to_ioend(inode, pos, len, folio, iop,
 				&wpc->iomap, wpc->ioend, wbc, &submit_list);
 		count++;
 	}
-- 
2.34.1

