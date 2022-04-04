Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449B4F0E48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377153AbiDDErv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377149AbiDDErq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CA3334E;
        Sun,  3 Apr 2022 21:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MSyqhojbTr6+Zu4U8qR37RYA+kqT9MeMoJxKx1jyu/A=; b=IITKgsF9jb11YzGUVkZ4n9yju6
        Y/HXZ7V6mPPRPODEnbqTfNTFgkeLQXFBVys9bEYlrIY+L1D9TNkusejB/Zkg0HYlLMK/zXSMqF7TU
        vh+h4aUzxVrvauupA76KXUM0zdvut4zxPWd9gJhtaamvCqdAqq9GeZheHiusJOmdhvmmQxMXU2NkD
        R7tuUGwrSVuScNvjbdCBe2mvBLngz9h8ydsDLUo7SKUrhcRNp/LA2k4mpFYJqew5Y382oHM86HqDx
        mfiQAFYlWs1HPbzuNq5Lj6yMAQ99Dhu5l9Wp/aqjRFKFu9CLV361J53Ifjw6/qNM5eQ4GYlJ/lfn2
        30q0xgTg==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEb6-00D3Ym-VW; Mon, 04 Apr 2022 04:45:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] btrfs: simplify scrub_recheck_block
Date:   Mon,  4 Apr 2022 06:45:21 +0200
Message-Id: <20220404044528.71167-6-hch@lst.de>
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

The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
so just use an on-stack bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a726962a51984..74c0557e6a2f9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1462,8 +1462,9 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		return scrub_recheck_block_on_raid56(fs_info, sblock);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
-		struct bio *bio;
 		struct scrub_page *spage = sblock->pagev[page_num];
+		struct bio bio;
+		struct bio_vec bvec;
 
 		if (spage->dev->bdev == NULL) {
 			spage->io_error = 1;
@@ -1472,20 +1473,17 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!spage->page);
-		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, spage->dev->bdev);
-
-		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
-		bio->bi_iter.bi_sector = spage->physical >> 9;
-		bio->bi_opf = REQ_OP_READ;
+		bio_init(&bio, spage->dev->bdev, &bvec, 1, REQ_OP_READ);
+		bio_add_page(&bio, spage->page, fs_info->sectorsize, 0);
+		bio.bi_iter.bi_sector = spage->physical >> 9;
 
-		btrfsic_check_bio(bio);
-		if (submit_bio_wait(bio)) {
+		btrfsic_check_bio(&bio);
+		if (submit_bio_wait(&bio)) {
 			spage->io_error = 1;
 			sblock->no_io_error_seen = 0;
 		}
 
-		bio_put(bio);
+		bio_uninit(&bio);
 	}
 
 	if (sblock->no_io_error_seen)
-- 
2.30.2

