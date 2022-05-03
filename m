Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDD517D80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiECGoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiECGnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2F200
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FPAgjc8cietwEYq/FZXzPxSlo/iLr66s0PJvUP9s09A=; b=Oh1zJK6EZuibg8bHSuHew0Z8Gn
        8CoaXsYrLcT+oe2l155N8Ln1AwH38MAD2NSYyGeZ0tilT87oY6NkT9PyMhrfF6ts24K3Dy40j6w0T
        Xy6rFAd5CcyzcmZ5H4qAQjCjDDMkI2JIHzSO6L9Q9fIewQ8doYzkpx6rIxMYiPh27612p0EqxvPt0
        rUGEpjmQap6kXdO/uAWRl754W9z8SOH7AGwgSZAb0cFeXO8CyoXBveZjNejXTwKv48JthOXlOsdDz
        0DlbZD0+60VhvTvmdLGOPQIvFMqt/rGV7u1IKvEnWkblyRfsaZ6r8WzCupeeWqlxROwnQG2Zo2rqq
        4zeo02ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCi-00FRxQ-7H; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 07/10] iomap: Reorder functions
Date:   Tue,  3 May 2022 07:40:05 +0100
Message-Id: <20220503064008.3682332-8-willy@infradead.org>
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

Move the ioend creation functions earlier in the file so write_end can
create ioends without requiring forward declarations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 215 ++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 108 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5b69cea71f71..4aa2209fb003 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -558,6 +558,113 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 	return submit_bio_wait(&bio);
 }
 
+static bool iomap_can_add_to_ioend(struct iomap *iomap,
+		struct iomap_ioend *ioend, loff_t offset, sector_t sector)
+{
+	if ((iomap->flags & IOMAP_F_SHARED) !=
+	    (ioend->io_flags & IOMAP_F_SHARED))
+		return false;
+	if (iomap->type != ioend->io_type)
+		return false;
+	if (offset != ioend->io_offset + ioend->io_size)
+		return false;
+	if (sector != bio_end_sector(ioend->io_bio))
+		return false;
+	/*
+	 * Limit ioend bio chain lengths to minimise IO completion latency. This
+	 * also prevents long tight loops ending page writeback on all the
+	 * folios in the ioend.
+	 */
+	if (ioend->io_folios >= IOEND_BATCH_SIZE)
+		return false;
+	return true;
+}
+
+static struct iomap_ioend *iomap_alloc_ioend(struct inode *inode,
+		struct iomap *iomap, loff_t offset, sector_t sector,
+		struct writeback_control *wbc)
+{
+	struct iomap_ioend *ioend;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
+	bio_set_dev(bio, iomap->bdev);
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_opf = REQ_OP_WRITE;
+	bio->bi_write_hint = inode->i_write_hint;
+
+	if (wbc) {
+		bio->bi_opf |= wbc_to_write_flags(wbc);
+		wbc_init_bio(wbc, bio);
+	}
+
+	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
+	INIT_LIST_HEAD(&ioend->io_list);
+	ioend->io_type = iomap->type;
+	ioend->io_flags = iomap->flags;
+	ioend->io_inode = inode;
+	ioend->io_size = 0;
+	ioend->io_folios = 0;
+	ioend->io_offset = offset;
+	ioend->io_bio = bio;
+	ioend->io_sector = sector;
+	return ioend;
+}
+
+/*
+ * Allocate a new bio, and chain the old bio to the new one.
+ *
+ * Note that we have to perform the chaining in this unintuitive order
+ * so that the bi_private linkage is set up in the right direction for the
+ * traversal in iomap_finish_ioend().
+ */
+static struct bio *iomap_chain_bio(struct bio *prev)
+{
+	struct bio *new;
+
+	new = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
+	bio_copy_dev(new, prev);/* also copies over blkcg information */
+	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_opf = prev->bi_opf;
+	new->bi_write_hint = prev->bi_write_hint;
+
+	bio_chain(prev, new);
+	bio_get(prev);		/* for iomap_finish_ioend */
+	submit_bio(prev);
+	return new;
+}
+
+/*
+ * Test to see if we have an existing ioend structure that we could append to
+ * first; otherwise finish off the current ioend and start another.
+ */
+static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
+		loff_t pos, size_t len, struct folio *folio,
+		struct iomap_page *iop, struct iomap *iomap,
+		struct iomap_ioend *ioend, struct writeback_control *wbc,
+		struct list_head *iolist)
+{
+	sector_t sector = iomap_sector(iomap, pos);
+	size_t poff = offset_in_folio(folio, pos);
+
+	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, pos, sector)) {
+		if (ioend)
+			list_add(&ioend->io_list, iolist);
+		ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
+	}
+
+	if (!bio_add_folio(ioend->io_bio, folio, len, poff)) {
+		ioend->io_bio = iomap_chain_bio(ioend->io_bio);
+		bio_add_folio(ioend->io_bio, folio, len, poff);
+	}
+
+	if (iop)
+		atomic_add(len, &iop->write_bytes_pending);
+	ioend->io_size += len;
+	wbc_account_cgroup_owner(wbc, &folio->page, len);
+	return ioend;
+}
+
 static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio *folio)
 {
@@ -1222,114 +1329,6 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 	return 0;
 }
 
-static struct iomap_ioend *iomap_alloc_ioend(struct inode *inode,
-		struct iomap *iomap, loff_t offset, sector_t sector,
-		struct writeback_control *wbc)
-{
-	struct iomap_ioend *ioend;
-	struct bio *bio;
-
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
-	bio_set_dev(bio, iomap->bdev);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = REQ_OP_WRITE;
-	bio->bi_write_hint = inode->i_write_hint;
-
-	if (wbc) {
-		bio->bi_opf |= wbc_to_write_flags(wbc);
-		wbc_init_bio(wbc, bio);
-	}
-
-	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
-	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_type = iomap->type;
-	ioend->io_flags = iomap->flags;
-	ioend->io_inode = inode;
-	ioend->io_size = 0;
-	ioend->io_folios = 0;
-	ioend->io_offset = offset;
-	ioend->io_bio = bio;
-	ioend->io_sector = sector;
-	return ioend;
-}
-
-/*
- * Allocate a new bio, and chain the old bio to the new one.
- *
- * Note that we have to perform the chaining in this unintuitive order
- * so that the bi_private linkage is set up in the right direction for the
- * traversal in iomap_finish_ioend().
- */
-static struct bio *
-iomap_chain_bio(struct bio *prev)
-{
-	struct bio *new;
-
-	new = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
-	bio_copy_dev(new, prev);/* also copies over blkcg information */
-	new->bi_iter.bi_sector = bio_end_sector(prev);
-	new->bi_opf = prev->bi_opf;
-	new->bi_write_hint = prev->bi_write_hint;
-
-	bio_chain(prev, new);
-	bio_get(prev);		/* for iomap_finish_ioend */
-	submit_bio(prev);
-	return new;
-}
-
-static bool iomap_can_add_to_ioend(struct iomap *iomap,
-		struct iomap_ioend *ioend, loff_t offset, sector_t sector)
-{
-	if ((iomap->flags & IOMAP_F_SHARED) !=
-	    (ioend->io_flags & IOMAP_F_SHARED))
-		return false;
-	if (iomap->type != ioend->io_type)
-		return false;
-	if (offset != ioend->io_offset + ioend->io_size)
-		return false;
-	if (sector != bio_end_sector(ioend->io_bio))
-		return false;
-	/*
-	 * Limit ioend bio chain lengths to minimise IO completion latency. This
-	 * also prevents long tight loops ending page writeback on all the
-	 * folios in the ioend.
-	 */
-	if (ioend->io_folios >= IOEND_BATCH_SIZE)
-		return false;
-	return true;
-}
-
-/*
- * Test to see if we have an existing ioend structure that we could append to
- * first; otherwise finish off the current ioend and start another.
- */
-static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
-		loff_t pos, size_t len, struct folio *folio,
-		struct iomap_page *iop, struct iomap *iomap,
-		struct iomap_ioend *ioend, struct writeback_control *wbc,
-		struct list_head *iolist)
-{
-	sector_t sector = iomap_sector(iomap, pos);
-	size_t poff = offset_in_folio(folio, pos);
-
-	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, pos, sector)) {
-		if (ioend)
-			list_add(&ioend->io_list, iolist);
-		ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
-	}
-
-	if (!bio_add_folio(ioend->io_bio, folio, len, poff)) {
-		ioend->io_bio = iomap_chain_bio(ioend->io_bio);
-		bio_add_folio(ioend->io_bio, folio, len, poff);
-	}
-
-	if (iop)
-		atomic_add(len, &iop->write_bytes_pending);
-	ioend->io_size += len;
-	wbc_account_cgroup_owner(wbc, &folio->page, len);
-	return ioend;
-}
-
 /*
  * We implement an immediate ioend submission policy here to avoid needing to
  * chain multiple ioends and hence nest mempool allocations which can violate
-- 
2.34.1

