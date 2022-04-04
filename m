Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29DE4F0E41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377167AbiDDEr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377158AbiDDErw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007A3334E;
        Sun,  3 Apr 2022 21:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sOybyUFq4FG4PjZ1V/mk0CVCooW26c95N3x8XaaSU/o=; b=c7lXaNHYiExPQcBtKc5Y63uYff
        vQN2uI4P9bFBSsXi5fFTXGDUKl/umaO4Os+D1GpyG6j5/7RM3jKQZRYRrbtcht0hIkklwSzCmw3ug
        Cq/jSwuuRz5tF+lJfOyeu5NhqaeQvJTrxtYIGRKEug+njJGW3TZNd7cyBQGb+MjgvNONmwLsfEALP
        fxwnTKaNSUL3kvNYVvufJbRBvcUvxn0mKOBeSgfZQthO0sm2L69Bm1ahnHE22CM+tysYUV9IfBOQq
        0zUhgfV02zSZzUfZWXsWqWCa7gJrwKeVdLtZrHb96+i7nKrQlVsPKIllyc/YsPsT9n2mdSBlOHdkA
        zvRHubyQ==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEbD-00D3bO-0K; Mon, 04 Apr 2022 04:45:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] btrfs: move the call to bio_set_dev out of submit_stripe_bio
Date:   Mon,  4 Apr 2022 06:45:23 +0200
Message-Id: <20220404044528.71167-8-hch@lst.de>
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

Prepare for additional refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c3581bbded035..5b72038d1530a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6745,7 +6745,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
-	bio_set_dev(bio, dev->bdev);
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
@@ -6837,6 +6836,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		else
 			bio = first_bio;
 
+		bio_set_dev(bio, dev->bdev);
 		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
 	}
 	btrfs_bio_counter_dec(fs_info);
-- 
2.30.2

