Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513884F0E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377176AbiDDEsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377165AbiDDErz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918632EEB;
        Sun,  3 Apr 2022 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IOgh46zGWR57WcPl1hUIMzPNs0Sl23XQjbsmMbaLo6E=; b=09WECZ5O8xcRQhLejUbvXlqWks
        Z3tzypAuoaKV6eb3B24b4/Gq2SwDNAKxoduB2YmW0ShT3hTel+U8LG6KcyUpdQ0sw97hDO0i+IeQQ
        PmaUyvA2VRR40d+6HhRBf+HvfF25gaUOSyecG4JnnoBScD55dsqPWXem05QAMsQK1maD/NBo5qmTm
        Z3kgphMFzNwbyOR+qrnWqT24VGnz9VU5T9OKPDHfzMrv/FSfSLHeCfeI10zdn4SP3RMCeYbXJq5DL
        o0yMceVety7734v+EBiYH8tpDZ6WaIO3T/cy4fdrVGNPa4IkFSEppbtgjnr7UsceZV6sBwhmr2Jo5
        mKSw2slA==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEbF-00D3f3-Vc; Mon, 04 Apr 2022 04:45:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] btrfs: pass a block_device to btrfs_bio_clone
Date:   Mon,  4 Apr 2022 06:45:24 +0200
Message-Id: <20220404044528.71167-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404044528.71167-1-hch@lst.de>
References: <20220404044528.71167-1-hch@lst.de>
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

Pass the block_device to bio_alloc_clone instead of setting it later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 4 ++--
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/volumes.c   | 9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e4af9a0935ca0..b625e1e865b6d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3153,13 +3153,13 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
 	return bio;
 }
 
-struct bio *btrfs_bio_clone(struct bio *bio)
+struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
 {
 	struct btrfs_bio *bbio;
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
-	new = bio_alloc_clone(bio->bi_bdev, bio, GFP_NOFS, &btrfs_bioset);
+	new = bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(new);
 	btrfs_bio_init(bbio);
 	bbio->iter = bio->bi_iter;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0399cf8e3c32c..72d86f228c56e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -278,7 +278,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
 struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone(struct bio *bio);
+struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5b72038d1530a..540b1f7f82449 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6831,12 +6831,13 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			continue;
 		}
 
-		if (dev_nr < total_devs - 1)
-			bio = btrfs_bio_clone(first_bio);
-		else
+		if (dev_nr < total_devs - 1) {
+			bio = btrfs_bio_clone(dev->bdev, first_bio);
+		} else {
 			bio = first_bio;
+			bio_set_dev(bio, dev->bdev);
+		}
 
-		bio_set_dev(bio, dev->bdev);
 		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
 	}
 	btrfs_bio_counter_dec(fs_info);
-- 
2.30.2

