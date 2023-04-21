Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB86EB2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjDUT62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjDUT6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:58:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B352D5A;
        Fri, 21 Apr 2023 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=74KqhpMHp5ljBuyIWW+6b9AuPyxaDpBnVwotQeAK7X8=; b=DzgJIkzUgKZlS2lZbWSyNPJKAX
        fJ02zvtu2wcM2DrLnEL1z7nGFJhWQvwx0ZwBONfF2vKqh9gW2iMSwkRFRy6mbGiWHd/jSQ2su2LMY
        Vg1njHfWWwn48um+f7MBerBHqbIfnt/XRDZ3iutZDQy8hUwy8N6Yh3vKPnhAmFE3nYJoRwN79EvZv
        tdJt0bXHBK0ddw7cry5Xwc3+fl7vlOOZWg4mFRKw3odez/kARFEZf3yQSfwQCVqea4Y8Q7KXQrNON
        m0DQiRTZm1Zq/OK4LTgJgai/TEYyHmUWvunLdAzqFTvAbW2mmA8qG/Di14CugGU7PsPFRhpLOzysJ
        0Eq2Rsmw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppwtU-00Blaf-2A;
        Fri, 21 Apr 2023 19:58:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org
Cc:     patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org, mcgrof@kernel.org
Subject: [PATCH 5/5] zram: use generic PAGE_SECTORS and PAGE_SECTORS_SHIFT
Date:   Fri, 21 Apr 2023 12:58:07 -0700
Message-Id: <20230421195807.2804512-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421195807.2804512-1-mcgrof@kernel.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of re-defining the already existing constants use the provided ones:

So replace:

 o SECTORS_PER_PAGE_SHIFT with PAGE_SECTORS_SHIFT
 o SECTORS_PER_PAGE       with PAGE_SECTORS

This produces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 12 ++++++------
 drivers/block/zram/zram_drv.h |  2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a84c4268257a..11c9b5a9ac7a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1834,8 +1834,8 @@ static ssize_t recompress_store(struct device *dev,
 static void zram_bio_discard(struct zram *zram, struct bio *bio)
 {
 	size_t n = bio->bi_iter.bi_size;
-	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-	u32 offset = (bio->bi_iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+	u32 index = bio->bi_iter.bi_sector >> PAGE_SECTORS_SHIFT;
+	u32 offset = (bio->bi_iter.bi_sector & (PAGE_SECTORS - 1)) <<
 			SECTOR_SHIFT;
 
 	/*
@@ -1876,8 +1876,8 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 
 	start_time = bio_start_io_acct(bio);
 	bio_for_each_segment(bv, bio, iter) {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+		u32 index = iter.bi_sector >> PAGE_SECTORS_SHIFT;
+		u32 offset = (iter.bi_sector & (PAGE_SECTORS - 1)) <<
 				SECTOR_SHIFT;
 
 		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
@@ -1903,8 +1903,8 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 
 	start_time = bio_start_io_acct(bio);
 	bio_for_each_segment(bv, bio, iter) {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+		u32 index = iter.bi_sector >> PAGE_SECTORS_SHIFT;
+		u32 offset = (iter.bi_sector & (PAGE_SECTORS - 1)) <<
 				SECTOR_SHIFT;
 
 		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index ca7a15bd4845..9f2543af5c76 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -21,8 +21,6 @@
 
 #include "zcomp.h"
 
-#define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
 #define ZRAM_LOGICAL_BLOCK_SHIFT 12
 #define ZRAM_LOGICAL_BLOCK_SIZE	(1 << ZRAM_LOGICAL_BLOCK_SHIFT)
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
-- 
2.39.2

