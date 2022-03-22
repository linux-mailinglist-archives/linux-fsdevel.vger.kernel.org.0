Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8ED4E4389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiCVP6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbiCVP6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3066C948;
        Tue, 22 Mar 2022 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QNXUgzzng0SHaWq+diR7s7+gbXx3ueiv5Gd24KFKCQQ=; b=26YVb9HKGiJWKwVp4+q8nZblrE
        yh3aMHrfBfZmsyxJw3Y3Wayu5ngWWWH6KveEjX5m9nG/YjGdRLrUE0cAp524iwFAi00kZU0d8vRNa
        62oyETOjoN1efx8ltZlcbsX7OKUsku7zzcx4mfswLE2607gfxyoORzNSEsD1QSle8H6Sf2m6ydUGA
        VdWTtx54BkSciPKuW5eUAUJu9svZaxeXUZ/PEruN/EW8tMsPGM5mN0EzoWQXryWhCYcwBGFOjefhy
        vrbYpd+K0irJvKAj9cEyG9EwH+dVQq3Ua45q8aPskMLe49x4htcyFUzilU27R9+d91t/0HR3pKXcK
        4Yskue1g==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgs6-00BahK-MM; Tue, 22 Mar 2022 15:56:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/40] btrfs: simplify scrub_repair_page_from_good_copy
Date:   Tue, 22 Mar 2022 16:55:36 +0100
Message-Id: <20220322155606.1267165-11-hch@lst.de>
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

The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
so just use an on-stack bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/scrub.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 508c91e26b6e9..bb9382c02714f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1544,7 +1544,8 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 	BUG_ON(spage_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
 	    sblock_bad->checksum_error || spage_bad->io_error) {
-		struct bio *bio;
+		struct bio bio;
+		struct bio_vec bvec;
 		int ret;
 
 		if (!spage_bad->dev->bdev) {
@@ -1553,26 +1554,20 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, spage_bad->dev->bdev);
-		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
-		bio->bi_opf = REQ_OP_WRITE;
+		bio_init(&bio, spage_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
+		bio.bi_iter.bi_sector = spage_bad->physical >> 9;
+		__bio_add_page(&bio, spage_good->page, sectorsize, 0);
 
-		ret = bio_add_page(bio, spage_good->page, sectorsize, 0);
-		if (ret != sectorsize) {
-			bio_put(bio);
-			return -EIO;
-		}
+		btrfsic_check_bio(&bio);
+		ret = submit_bio_wait(&bio);
+		bio_uninit(&bio);
 
-		btrfsic_check_bio(bio);
-		if (submit_bio_wait(bio)) {
+		if (ret) {
 			btrfs_dev_stat_inc_and_print(spage_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
-			bio_put(bio);
 			return -EIO;
 		}
-		bio_put(bio);
 	}
 
 	return 0;
-- 
2.30.2

