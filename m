Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D37517D82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiECGo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiECGnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0720A303
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=r+CYFeOXePy+J6U6EySURLhgv/r0S7wzDzjrfZfjEtw=; b=ksk8AzssEVTOarrRqN/Jy2Kc7Q
        4eMqcIQQcyXmuOrrzxM6izXO509rlAd2cIE8SY2Amn9DLO+Uuu5AYuD++L6L0sNO3V0nV7ci6nVar
        m1BNqRvnnwi5o89pJoKUSZosvJmlPQKZnF51WkHsT8BCKxnQsXfN5tMxQ73c4G9e+F3zauyJyIzyg
        ZdF+KMRlHuac1ZU1WyyS2tGPPRMJQGWKixS/ELqhg5NP+p5QA9cIkht0suaZgVsU4nvMg3zGjDsUo
        I/2V6R75DlfuuBdRPuEJMBcn6anK2Ka4JYUJBtX+A9CeyZ2Qi+dEqQiK44gbUekWF9jK8HrS82And
        /wA4NilA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCi-00FRxc-Aw; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 08/10] iomap: Reorder functions
Date:   Tue,  3 May 2022 07:40:06 +0100
Message-Id: <20220503064008.3682332-9-willy@infradead.org>
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

Move the ioend submission functions earlier in the file so write_iter
can submit ioends without requiring forward declarations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 204 ++++++++++++++++++++---------------------
 1 file changed, 101 insertions(+), 103 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4aa2209fb003..6c540390eec3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -665,6 +665,107 @@ static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
 	return ioend;
 }
 
+static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len, int error)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+
+	if (error) {
+		folio_set_error(folio);
+		mapping_set_error(inode->i_mapping, error);
+	}
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
+	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
+
+	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
+		folio_end_writeback(folio);
+}
+
+/*
+ * We're now finished for good with this ioend structure.  Update the page
+ * state, release holds on bios, and finally free up memory.  Do not use the
+ * ioend after this.
+ */
+static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+{
+	struct inode *inode = ioend->io_inode;
+	struct bio *bio = &ioend->io_inline_bio;
+	struct bio *last = ioend->io_bio, *next;
+	u64 start = bio->bi_iter.bi_sector;
+	loff_t offset = ioend->io_offset;
+	bool quiet = bio_flagged(bio, BIO_QUIET);
+	u32 folio_count = 0;
+
+	for (bio = &ioend->io_inline_bio; bio; bio = next) {
+		struct folio_iter fi;
+
+		/*
+		 * For the last bio, bi_private points to the ioend, so we
+		 * need to explicitly end the iteration here.
+		 */
+		if (bio == last)
+			next = NULL;
+		else
+			next = bio->bi_private;
+
+		/* walk all folios in bio, ending page IO on them */
+		bio_for_each_folio_all(fi, bio) {
+			iomap_finish_folio_write(inode, fi.folio, fi.length,
+					error);
+			folio_count++;
+		}
+		bio_put(bio);
+	}
+	/* The ioend has been freed by bio_put() */
+
+	if (unlikely(error && !quiet)) {
+		printk_ratelimited(KERN_ERR
+"%s: writeback error on inode %lu, offset %lld, sector %llu",
+			inode->i_sb->s_id, inode->i_ino, offset, start);
+	}
+	return folio_count;
+}
+
+static void iomap_writepage_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = bio->bi_private;
+
+	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
+}
+
+/*
+ * Submit the final bio for an ioend.
+ *
+ * If @error is non-zero, it means that we have a situation where some part of
+ * the submission process has failed after we've marked pages for writeback
+ * and unlocked them.  In this situation, we need to fail the bio instead of
+ * submitting it.  This typically only happens on a filesystem shutdown.
+ */
+static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc,
+		struct iomap_ioend *ioend, int error)
+{
+	ioend->io_bio->bi_private = ioend;
+	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
+
+	if (wpc && wpc->ops->prepare_ioend)
+		error = wpc->ops->prepare_ioend(ioend, error);
+	if (error) {
+		/*
+		 * If we're failing the IO now, just mark the ioend with an
+		 * error and finish it.  This will run IO completion immediately
+		 * as there is only one reference to the ioend at this point in
+		 * time.
+		 */
+		ioend->io_bio->bi_status = errno_to_blk_status(error);
+		bio_endio(ioend->io_bio);
+		return error;
+	}
+
+	submit_bio(ioend->io_bio);
+	return 0;
+}
+
 static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio *folio)
 {
@@ -1126,69 +1227,6 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-		size_t len, int error)
-{
-	struct iomap_page *iop = to_iomap_page(folio);
-
-	if (error) {
-		folio_set_error(folio);
-		mapping_set_error(inode->i_mapping, error);
-	}
-
-	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
-
-	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
-		folio_end_writeback(folio);
-}
-
-/*
- * We're now finished for good with this ioend structure.  Update the page
- * state, release holds on bios, and finally free up memory.  Do not use the
- * ioend after this.
- */
-static u32
-iomap_finish_ioend(struct iomap_ioend *ioend, int error)
-{
-	struct inode *inode = ioend->io_inode;
-	struct bio *bio = &ioend->io_inline_bio;
-	struct bio *last = ioend->io_bio, *next;
-	u64 start = bio->bi_iter.bi_sector;
-	loff_t offset = ioend->io_offset;
-	bool quiet = bio_flagged(bio, BIO_QUIET);
-	u32 folio_count = 0;
-
-	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct folio_iter fi;
-
-		/*
-		 * For the last bio, bi_private points to the ioend, so we
-		 * need to explicitly end the iteration here.
-		 */
-		if (bio == last)
-			next = NULL;
-		else
-			next = bio->bi_private;
-
-		/* walk all folios in bio, ending page IO on them */
-		bio_for_each_folio_all(fi, bio) {
-			iomap_finish_folio_write(inode, fi.folio, fi.length,
-					error);
-			folio_count++;
-		}
-		bio_put(bio);
-	}
-	/* The ioend has been freed by bio_put() */
-
-	if (unlikely(error && !quiet)) {
-		printk_ratelimited(KERN_ERR
-"%s: writeback error on inode %lu, offset %lld, sector %llu",
-			inode->i_sb->s_id, inode->i_ino, offset, start);
-	}
-	return folio_count;
-}
-
 /*
  * Ioend completion routine for merged bios. This can only be called from task
  * contexts as merged ioends can be of unbound length. Hence we have to break up
@@ -1289,46 +1327,6 @@ iomap_sort_ioends(struct list_head *ioend_list)
 }
 EXPORT_SYMBOL_GPL(iomap_sort_ioends);
 
-static void iomap_writepage_end_bio(struct bio *bio)
-{
-	struct iomap_ioend *ioend = bio->bi_private;
-
-	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
-}
-
-/*
- * Submit the final bio for an ioend.
- *
- * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we've marked pages for writeback
- * and unlocked them.  In this situation, we need to fail the bio instead of
- * submitting it.  This typically only happens on a filesystem shutdown.
- */
-static int
-iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
-		int error)
-{
-	ioend->io_bio->bi_private = ioend;
-	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
-
-	if (wpc && wpc->ops->prepare_ioend)
-		error = wpc->ops->prepare_ioend(ioend, error);
-	if (error) {
-		/*
-		 * If we're failing the IO now, just mark the ioend with an
-		 * error and finish it.  This will run IO completion immediately
-		 * as there is only one reference to the ioend at this point in
-		 * time.
-		 */
-		ioend->io_bio->bi_status = errno_to_blk_status(error);
-		bio_endio(ioend->io_bio);
-		return error;
-	}
-
-	submit_bio(ioend->io_bio);
-	return 0;
-}
-
 /*
  * We implement an immediate ioend submission policy here to avoid needing to
  * chain multiple ioends and hence nest mempool allocations which can violate
-- 
2.34.1

