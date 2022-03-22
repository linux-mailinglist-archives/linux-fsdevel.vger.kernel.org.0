Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD74E437A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiCVP6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiCVP6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E46D38A;
        Tue, 22 Mar 2022 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zcRCYIVhN3/sxBY+iR+GBf6fOdhxyBjACLuMuxq+kaE=; b=LtmyLILAHIjUhx7lPggK/73Sdn
        8W2CoLHA6oBBe0IcCRcG/hXXL9SYRM1gEbTip5C8UwfhRVjSpDA7HUJlqpYz545E3C7VFJM0obhjW
        eZKASuAGLshQZzKPo6nT349uPMib0aAspwTyz+qv8KjGXibYU5oVb45rTHetOdVj/Vcjwu6wrnuCu
        ZPzo9dZaSX5qYWNdpq+NfsP4fnrnBO9Tb+FDYT9A21WsgQedo0EgzPtfHfdOljpDYxo84gvDUL5kc
        SJnyyENqPOTYueX2hCUSUuQZL2D9OJrLOxBj+EUhlyWcF0SiDEjckpQ6JJ3caUD5PQkOqiMOcNwYF
        Ge1Rvoow==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsB-00BaiC-Qw; Tue, 22 Mar 2022 15:56:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/40] btrfs: pass a block_device to btrfs_bio_clone
Date:   Tue, 22 Mar 2022 16:55:38 +0100
Message-Id: <20220322155606.1267165-13-hch@lst.de>
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

Pass the block_device to bio_alloc_clone instead of setting it later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 4 ++--
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/volumes.c   | 9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index be523581c0ac1..88d3a46e89a51 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3150,13 +3150,13 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
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
index 5dc2a89682a22..4dd54b80dac81 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6837,12 +6837,13 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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

