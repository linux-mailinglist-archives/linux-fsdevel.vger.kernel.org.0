Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C014E4390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiCVP6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiCVP6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4586D959;
        Tue, 22 Mar 2022 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XVAvg8evTgTkKo7Ej0Zd/pBWi/mPnzn9V42LhYa6D7Q=; b=B8eOY6PWUk734xaox4ZICfKPZV
        IxzZ4jAg9Jkki5xaf1hhfqU8icWJRQXFhAoCDP0yz+Z9qKckQU+I0JN2csA0QqcJCzYmO82e7i9He
        R+OOtO8sGpF+62RkFhG+C8SI9Of5dg6vD5qeKOPvn5ttq1kZvcgKbTpGzPIwIsh7Af2PGkcJrzJA7
        nskvRapWOtkXovaOjqi3hS0uLkwJ8DoBhpL/7avSDY1VS8f+bSpuua24KLMhImnCv9dd3g9xeKlUo
        DtvTcinHHsZIzuBC0DS0IOuK2B7YRhYCRkJiw/Prb7zKhs3pdbf+CevP4cBanMU5LUqPYxPWN366X
        VPoXnVFQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsR-00BaoX-9T; Tue, 22 Mar 2022 15:56:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/40] btrfs: move more work into btrfs_end_bioc
Date:   Tue, 22 Mar 2022 16:55:44 +0100
Message-Id: <20220322155606.1267165-19-hch@lst.de>
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

Assign ->mirror_num and ->bi_status in btrfs_end_bioc instead of
duplicating the logic in the callers.  Also remove the bio argument as
it always must be bioc->orig_bio and the now pointless bioc_error that
did nothing but assign bi_sector to the same value just sampled in the
caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 68 ++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4dd54b80dac81..9d1f8c27eff33 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6659,19 +6659,29 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
 }
 
-static inline void btrfs_end_bioc(struct btrfs_io_context *bioc, struct bio *bio)
+static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
 {
+	struct bio *bio = bioc->orig_bio;
+
+	btrfs_bio(bio)->mirror_num = bioc->mirror_num;
 	bio->bi_private = bioc->private;
 	bio->bi_end_io = bioc->end_io;
-	bio_endio(bio);
 
+	/*
+	 * Only send an error to the higher layers if it is beyond the tolerance
+	 * threshold.
+	 */
+	if (atomic_read(&bioc->error) > bioc->max_errors)
+		bio->bi_status = BLK_STS_IOERR;
+	else
+		bio->bi_status = BLK_STS_OK;
+	bio_endio(bio);
 	btrfs_put_bioc(bioc);
 }
 
 static void btrfs_end_bio(struct bio *bio)
 {
 	struct btrfs_io_context *bioc = bio->bi_private;
-	int is_orig_bio = 0;
 
 	if (bio->bi_status) {
 		atomic_inc(&bioc->error);
@@ -6692,35 +6702,12 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	if (bio == bioc->orig_bio)
-		is_orig_bio = 1;
+	if (bio != bioc->orig_bio)
+		bio_put(bio);
 
 	btrfs_bio_counter_dec(bioc->fs_info);
-
-	if (atomic_dec_and_test(&bioc->stripes_pending)) {
-		if (!is_orig_bio) {
-			bio_put(bio);
-			bio = bioc->orig_bio;
-		}
-
-		btrfs_bio(bio)->mirror_num = bioc->mirror_num;
-		/* only send an error to the higher layers if it is
-		 * beyond the tolerance of the btrfs bio
-		 */
-		if (atomic_read(&bioc->error) > bioc->max_errors) {
-			bio->bi_status = BLK_STS_IOERR;
-		} else {
-			/*
-			 * this bio is actually up to date, we didn't
-			 * go over the max number of errors
-			 */
-			bio->bi_status = BLK_STS_OK;
-		}
-
-		btrfs_end_bioc(bioc, bio);
-	} else if (!is_orig_bio) {
-		bio_put(bio);
-	}
+	if (atomic_dec_and_test(&bioc->stripes_pending))
+		btrfs_end_bioc(bioc);
 }
 
 static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
@@ -6758,23 +6745,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 	submit_bio(bio);
 }
 
-static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logical)
-{
-	atomic_inc(&bioc->error);
-	if (atomic_dec_and_test(&bioc->stripes_pending)) {
-		/* Should be the original bio. */
-		WARN_ON(bio != bioc->orig_bio);
-
-		btrfs_bio(bio)->mirror_num = bioc->mirror_num;
-		bio->bi_iter.bi_sector = logical >> 9;
-		if (atomic_read(&bioc->error) > bioc->max_errors)
-			bio->bi_status = BLK_STS_IOERR;
-		else
-			bio->bi_status = BLK_STS_OK;
-		btrfs_end_bioc(bioc, bio);
-	}
-}
-
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
@@ -6833,7 +6803,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 						   &dev->dev_state) ||
 		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-			bioc_error(bioc, first_bio, logical);
+			atomic_inc(&bioc->error);
+			if (atomic_dec_and_test(&bioc->stripes_pending))
+				btrfs_end_bioc(bioc);
 			continue;
 		}
 
-- 
2.30.2

