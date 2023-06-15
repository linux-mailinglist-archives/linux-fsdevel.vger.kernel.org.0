Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663F730FD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjFOGue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbjFOGt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A118D;
        Wed, 14 Jun 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WxGCOD+kS6tqPx/B3Mt82Pt+WtvAZhIcaDzeuGE0dN0=; b=CgoCVoJxkvFusGPw4qcsUVrB/I
        fxfyzimIjbttFMbs0DcrhMN/ol2VxprI+f7Aec+tXhFh11JWhdfhG7rOKemyq6MsjaRY5tRAx4iNw
        kFlCinzgjbykOwbfTAf5bk5jCtnHwoLICBrxRv2o86i4B6rbZoGydKnov1jSw0flyu+JnoA2Z1k6Y
        fRNkOkqHnBv6O0ju//NCSA/AlwZe5Gj0tU3IFgV+i/RBC9D1u1H4MIY9e+hf5FGMLX+59p5Fgwex9
        bnvGO5piDJVI6GKL3k7N/f4uDso2on5iCdz2WBD5DX8fQ79q1nx9Du0A0FbUL6RJsIlTvBfZiMg21
        RVq3DbDA==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gmx-00DuBG-2h;
        Thu, 15 Jun 2023 06:49:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/11] md-bitmap: cleanup read_sb_page
Date:   Thu, 15 Jun 2023 08:48:36 +0200
Message-Id: <20230615064840.629492-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
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

Convert read_sb_page to the normal kernel coding style, calculate the
target sector only once, and add a local iosize variable to make the call
to sync_page_io more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 1f71683b417981..f4bff2dfe2fd8f 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -139,26 +139,25 @@ static void md_bitmap_checkfree(struct bitmap_counts *bitmap, unsigned long page
  */
 
 /* IO operations when bitmap is stored near all superblocks */
+
+/* choose a good rdev and read the page from there */
 static int read_sb_page(struct mddev *mddev, loff_t offset,
-			struct page *page,
-			unsigned long index, int size)
+		struct page *page, unsigned long index, int size)
 {
-	/* choose a good rdev and read the page from there */
 
+	sector_t sector = offset + index * (PAGE_SIZE / SECTOR_SIZE);
 	struct md_rdev *rdev;
-	sector_t target;
 
 	rdev_for_each(rdev, mddev) {
-		if (! test_bit(In_sync, &rdev->flags)
-		    || test_bit(Faulty, &rdev->flags)
-		    || test_bit(Bitmap_sync, &rdev->flags))
-			continue;
+		u32 iosize = roundup(size, bdev_logical_block_size(rdev->bdev));
 
-		target = offset + index * (PAGE_SIZE/512);
+		if (!test_bit(In_sync, &rdev->flags) ||
+		    test_bit(Faulty, &rdev->flags) ||
+		    test_bit(Bitmap_sync, &rdev->flags))
+			continue;
 
-		if (sync_page_io(rdev, target,
-				 roundup(size, bdev_logical_block_size(rdev->bdev)),
-				 page, REQ_OP_READ, true)) {
+		if (sync_page_io(rdev, sector, iosize, page, REQ_OP_READ,
+				true)) {
 			page->index = index;
 			return 0;
 		}
-- 
2.39.2

