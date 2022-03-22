Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36A4E437C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiCVP6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiCVP5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:57:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C46B089;
        Tue, 22 Mar 2022 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=14qv+oG7OdpbtaSjwz7xo6sYF3is1Uz5/Izd3meoZRM=; b=M/DmlfkFZ/GJQYBXHxhy1QwgAF
        Z4WApsYToRY4O3TLfI3k6BYhkdxc8Db4YfeGGjoE3fZh4hlAAzIwQkQoTmI5uPHjJEkWJkMi5Sg5D
        y+j6q2SZt4QNiHpvJQeDDSIaxPOQs2VizS94FATcxdn0Zs3MQoRyifeEviglLJb9loAxLn2lvCw93
        IzLEdw/uXhnNPTmdaPMpyQ7dqT0LfRRHPGoi0/dxUzIqcLZC9G58GbSnyrvGLytD1MiPz2H8soxn6
        5+IA3fHXrCHDx6MacRrywdcGVeno/7N1RjNX9STk+WGPC/SXufMc62KkiiyUWPh7uNLAMQX0OJbFb
        DSamh+IA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgrt-00Bae2-PH; Tue, 22 Mar 2022 15:56:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/40] btrfs: refactor __btrfsic_submit_bio
Date:   Tue, 22 Mar 2022 16:55:31 +0100
Message-Id: <20220322155606.1267165-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out two helpers to mak __btrfsic_submit_bio more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/check-integrity.c | 150 +++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index abac86a758401..9efc1feb6cb08 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2635,6 +2635,74 @@ static struct btrfsic_dev_state *btrfsic_dev_state_lookup(dev_t dev)
 						  &btrfsic_dev_state_hashtable);
 }
 
+static void btrfsic_check_write_bio(struct bio *bio,
+		struct btrfsic_dev_state *dev_state)
+{
+	unsigned int segs = bio_segments(bio);
+	u64 dev_bytenr = 512 * bio->bi_iter.bi_sector;
+	u64 cur_bytenr = dev_bytenr;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	char **mapped_datav;
+	int bio_is_patched = 0;
+	int i = 0;
+
+	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
+		pr_info("submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
+		       bio_op(bio), bio->bi_opf, segs,
+		       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
+
+	mapped_datav = kmalloc_array(segs, sizeof(*mapped_datav), GFP_NOFS);
+	if (!mapped_datav)
+		return;
+
+	bio_for_each_segment(bvec, bio, iter) {
+		BUG_ON(bvec.bv_len != PAGE_SIZE);
+		mapped_datav[i] = page_address(bvec.bv_page);
+		i++;
+
+		if (dev_state->state->print_mask &
+		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
+			pr_info("#%u: bytenr=%llu, len=%u, offset=%u\n",
+			       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
+		cur_bytenr += bvec.bv_len;
+	}
+
+	btrfsic_process_written_block(dev_state, dev_bytenr, mapped_datav, segs,
+				      bio, &bio_is_patched, bio->bi_opf);
+	kfree(mapped_datav);
+}
+
+static void btrfsic_check_flush_bio(struct bio *bio,
+		struct btrfsic_dev_state *dev_state)
+{
+	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
+		pr_info("submit_bio(rw=%d,0x%x FLUSH, bdev=%p)\n",
+		       bio_op(bio), bio->bi_opf, bio->bi_bdev);
+
+	if (dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
+		struct btrfsic_block *const block =
+			&dev_state->dummy_block_for_bio_bh_flush;
+
+		block->is_iodone = 0;
+		block->never_written = 0;
+		block->iodone_w_error = 0;
+		block->flush_gen = dev_state->last_flush_gen + 1;
+		block->submit_bio_bh_rw = bio->bi_opf;
+		block->orig_bio_private = bio->bi_private;
+		block->orig_bio_end_io = bio->bi_end_io;
+		block->next_in_same_bio = NULL;
+		bio->bi_private = block;
+		bio->bi_end_io = btrfsic_bio_end_io;
+	} else if ((dev_state->state->print_mask &
+		   (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
+		    BTRFSIC_PRINT_MASK_VERBOSE))) {
+		pr_info(
+"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ignored)!\n",
+		       dev_state->bdev);
+	}
+}
+
 static void __btrfsic_submit_bio(struct bio *bio)
 {
 	struct btrfsic_dev_state *dev_state;
@@ -2642,80 +2710,18 @@ static void __btrfsic_submit_bio(struct bio *bio)
 	if (!btrfsic_is_initialized)
 		return;
 
-	mutex_lock(&btrfsic_mutex);
-	/* since btrfsic_submit_bio() is also called before
-	 * btrfsic_mount(), this might return NULL */
+	/*
+	 * We can be called before btrfsic_mount, so there might not be a
+	 * dev_state.
+	 */
 	dev_state = btrfsic_dev_state_lookup(bio->bi_bdev->bd_dev);
-	if (NULL != dev_state &&
-	    (bio_op(bio) == REQ_OP_WRITE) && bio_has_data(bio)) {
-		int i = 0;
-		u64 dev_bytenr;
-		u64 cur_bytenr;
-		struct bio_vec bvec;
-		struct bvec_iter iter;
-		int bio_is_patched;
-		char **mapped_datav;
-		unsigned int segs = bio_segments(bio);
-
-		dev_bytenr = 512 * bio->bi_iter.bi_sector;
-		bio_is_patched = 0;
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-			pr_info("submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
-			       bio_op(bio), bio->bi_opf, segs,
-			       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
-
-		mapped_datav = kmalloc_array(segs,
-					     sizeof(*mapped_datav), GFP_NOFS);
-		if (!mapped_datav)
-			goto leave;
-		cur_bytenr = dev_bytenr;
-
-		bio_for_each_segment(bvec, bio, iter) {
-			BUG_ON(bvec.bv_len != PAGE_SIZE);
-			mapped_datav[i] = page_address(bvec.bv_page);
-			i++;
-
-			if (dev_state->state->print_mask &
-			    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
-				pr_info("#%u: bytenr=%llu, len=%u, offset=%u\n",
-				       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
-			cur_bytenr += bvec.bv_len;
-		}
-		btrfsic_process_written_block(dev_state, dev_bytenr,
-					      mapped_datav, segs,
-					      bio, &bio_is_patched,
-					      bio->bi_opf);
-		kfree(mapped_datav);
-	} else if (NULL != dev_state && (bio->bi_opf & REQ_PREFLUSH)) {
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-			pr_info("submit_bio(rw=%d,0x%x FLUSH, bdev=%p)\n",
-			       bio_op(bio), bio->bi_opf, bio->bi_bdev);
-		if (!dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
-			if ((dev_state->state->print_mask &
-			     (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
-			      BTRFSIC_PRINT_MASK_VERBOSE)))
-				pr_info(
-"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ignored)!\n",
-				       dev_state->bdev);
-		} else {
-			struct btrfsic_block *const block =
-				&dev_state->dummy_block_for_bio_bh_flush;
-
-			block->is_iodone = 0;
-			block->never_written = 0;
-			block->iodone_w_error = 0;
-			block->flush_gen = dev_state->last_flush_gen + 1;
-			block->submit_bio_bh_rw = bio->bi_opf;
-			block->orig_bio_private = bio->bi_private;
-			block->orig_bio_end_io = bio->bi_end_io;
-			block->next_in_same_bio = NULL;
-			bio->bi_private = block;
-			bio->bi_end_io = btrfsic_bio_end_io;
-		}
+	mutex_lock(&btrfsic_mutex);
+	if (dev_state) {
+		if (bio_op(bio) == REQ_OP_WRITE && bio_has_data(bio))
+			btrfsic_check_write_bio(bio, dev_state);
+		else if (bio->bi_opf & REQ_PREFLUSH)
+			btrfsic_check_flush_bio(bio, dev_state);
 	}
-leave:
 	mutex_unlock(&btrfsic_mutex);
 }
 
-- 
2.30.2

