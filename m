Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DE4BFD61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiBVPrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiBVPrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:47:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAF2A711;
        Tue, 22 Feb 2022 07:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+U8cxPvWKrvxpKekOCC5dqw8suy2lTzpNt0Z4iXLejo=; b=mQLRZJy2Jqv/KuVeCdT4HHJA2U
        LzZMFpfze3cdBygMl4Y+GIuFDPE9conHrq+1Z67JdBTeJj7tbFMFHwQBw02hHjZNk2R2w+IBOjxLV
        mDcJGmbFGfRqceK5/HLSqQEhbj07Vd3QDvMYzJcI/7hJaC6ftH6nJOQlsViYOp9x/4YdDgWEliOpw
        z2mY5ccVq7YrV1/UHe+ZHKWRYa92h5bPSz65+tl2q49fTAEsM+VebGcYK+oP6oi9fCFvjUOKFmSuL
        0bn4Ine/T86sqivRxd7n6ifRuO0eeMbVVn2BsO53n2b/01OqxIpBN50r5w9eOTHvyf1KA6kBYYEP0
        mVB0lqOQ==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXNE-00ANbH-Lr; Tue, 22 Feb 2022 15:46:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 3/3] nilfs2: pass the operation to bio_alloc
Date:   Tue, 22 Feb 2022 16:46:34 +0100
Message-Id: <20220222154634.597067-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222154634.597067-1-hch@lst.de>
References: <20220222154634.597067-1-hch@lst.de>
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

Refactor the segbuf write code to pass the op to bio_alloc instead of
setting it just before the submission.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nilfs2/segbuf.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 4f71faacd8253..a3bb0c856ec80 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -337,8 +337,7 @@ static void nilfs_end_bio_write(struct bio *bio)
 }
 
 static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
-				   struct nilfs_write_info *wi, int mode,
-				   int mode_flags)
+				   struct nilfs_write_info *wi)
 {
 	struct bio *bio = wi->bio;
 	int err;
@@ -356,7 +355,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 
 	bio->bi_end_io = nilfs_end_bio_write;
 	bio->bi_private = segbuf;
-	bio_set_op_attrs(bio, mode, mode_flags);
 	submit_bio(bio);
 	segbuf->sb_nbio++;
 
@@ -384,15 +382,15 @@ static void nilfs_segbuf_prepare_write(struct nilfs_segment_buffer *segbuf,
 
 static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 				  struct nilfs_write_info *wi,
-				  struct buffer_head *bh, int mode)
+				  struct buffer_head *bh)
 {
 	int len, err;
 
 	BUG_ON(wi->nr_vecs <= 0);
  repeat:
 	if (!wi->bio) {
-		wi->bio = bio_alloc(wi->nilfs->ns_bdev, wi->nr_vecs, 0,
-				    GFP_NOIO);
+		wi->bio = bio_alloc(wi->nilfs->ns_bdev, wi->nr_vecs,
+				    REQ_OP_WRITE, GFP_NOIO);
 		wi->bio->bi_iter.bi_sector = (wi->blocknr + wi->end) <<
 			(wi->nilfs->ns_blocksize_bits - 9);
 	}
@@ -403,7 +401,7 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 		return 0;
 	}
 	/* bio is FULL */
-	err = nilfs_segbuf_submit_bio(segbuf, wi, mode, 0);
+	err = nilfs_segbuf_submit_bio(segbuf, wi);
 	/* never submit current bh */
 	if (likely(!err))
 		goto repeat;
@@ -433,13 +431,13 @@ static int nilfs_segbuf_write(struct nilfs_segment_buffer *segbuf,
 	nilfs_segbuf_prepare_write(segbuf, &wi);
 
 	list_for_each_entry(bh, &segbuf->sb_segsum_buffers, b_assoc_buffers) {
-		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh, REQ_OP_WRITE);
+		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh);
 		if (unlikely(res))
 			goto failed_bio;
 	}
 
 	list_for_each_entry(bh, &segbuf->sb_payload_buffers, b_assoc_buffers) {
-		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh, REQ_OP_WRITE);
+		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh);
 		if (unlikely(res))
 			goto failed_bio;
 	}
@@ -449,8 +447,8 @@ static int nilfs_segbuf_write(struct nilfs_segment_buffer *segbuf,
 		 * Last BIO is always sent through the following
 		 * submission.
 		 */
-		res = nilfs_segbuf_submit_bio(segbuf, &wi, REQ_OP_WRITE,
-					      REQ_SYNC);
+		wi.bio->bi_opf |= REQ_SYNC;
+		res = nilfs_segbuf_submit_bio(segbuf, &wi);
 	}
 
  failed_bio:
-- 
2.30.2

