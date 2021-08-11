Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809E73E882E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhHKCst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhHKCss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:48:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D93C061765;
        Tue, 10 Aug 2021 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2YA2b7pftMFV7dkw6sXMklaqvYwnAauYpwGBWDTH2Ss=; b=EhbvHFIRUwUn+EMephulQplcSi
        SwnSf3AlAbqhRJSo4OWnuXCRfrrJ8D44wsXkRff37EnqUuUM5uwYNWL8ZfJmlore+FWlV03cOONA5
        NxKsTTp4F6CP1UGtcLF4sydb372pr4O/y7QTvgYQpkN2U9zKS8Vl5fHk3Wki7nOXGYv1HjdFSxwzs
        eHTeMpNGjtNQwjWckGzHxjQOJRYGkcGsjRqwewhI0s1LKWZM1joNs57CfChGsRzU6mjCluVr4gx/G
        gOLebs9vk8V/m2XkuAZh3i2cUOQKHCOPMstKpdsjMgFEBUd7Ty3oqXLH0C8xxRDmL/pKP07RLjgsX
        zUqXUQOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeH2-00Cs7o-5I; Wed, 11 Aug 2021 02:47:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/8] iomap: Pass struct iomap to iomap_alloc_ioend()
Date:   Wed, 11 Aug 2021 03:46:40 +0100
Message-Id: <20210811024647.3067739-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_alloc_ioend() does not need the rest of iomap_writepage_ctx;
only the iomap contained in it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c1c8cd41ea81..3bf65daf55fc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1190,15 +1190,15 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
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
@@ -1206,8 +1206,8 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_type = wpc->iomap.type;
-	ioend->io_flags = wpc->iomap.flags;
+	ioend->io_type = iomap->type;
+	ioend->io_flags = iomap->flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
@@ -1264,14 +1264,16 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
-	sector_t sector = iomap_sector(&wpc->iomap, offset);
+	struct iomap *iomap = &wpc->iomap;
+	sector_t sector = iomap_sector(iomap, offset);
 	unsigned len = i_blocksize(inode);
 	unsigned poff = offset & (PAGE_SIZE - 1);
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
+		wpc->ioend = iomap_alloc_ioend(inode, iomap, offset, sector,
+				wbc);
 	}
 
 	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
-- 
2.30.2

