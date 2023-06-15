Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5B730FCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbjFOGub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbjFOGuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:50:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF72706;
        Wed, 14 Jun 2023 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TQxm0uGjCgxdrSRwnj0pjPTwH1EOrN5vgpiJC4YzX0c=; b=UfshM0ZqnpHuKWi0MQk85iIJ+l
        TPjWQbanvrDPQ328EgWsz/pvD5XIQ23y47ivh2jRTsE7yyzEcShi8qFqiVZhZhtdnKhFfISRID0Eo
        +/lzRo3MFhGPRMmBwgZYR496cFlw+6IJyKhdBj4i+LT9l3tPWcfTLRJJNS59r85kw0gmMPowXe9lS
        bzIC72IobvTqET74V0gWkTFlp4PpO7GtWV87JMBVr08Nn1+4utZcI3tJDpAyc2jHLBkOv6wgBMXxq
        Nb54Gg2Uk7OkpHagg5Zsp8biRbI1Scr6rbOMf52k7g/inXmXET752c25SKyoODCp3iB5t9AZLWsfg
        HI1u8aBw==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gn0-00DuBU-0m;
        Thu, 15 Jun 2023 06:49:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] md-bitmap: account for mddev->bitmap_info.offset in read_sb_page
Date:   Thu, 15 Jun 2023 08:48:37 +0200
Message-Id: <20230615064840.629492-9-hch@lst.de>
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

Diretly apply mddev->bitmap_info.offset to the sector number to read
instead of doing that in both callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index f4bff2dfe2fd8f..39ff75cc7a16ac 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -145,7 +145,8 @@ static int read_sb_page(struct mddev *mddev, loff_t offset,
 		struct page *page, unsigned long index, int size)
 {
 
-	sector_t sector = offset + index * (PAGE_SIZE / SECTOR_SIZE);
+	sector_t sector = mddev->bitmap_info.offset + offset +
+		index * (PAGE_SIZE / SECTOR_SIZE);
 	struct md_rdev *rdev;
 
 	rdev_for_each(rdev, mddev) {
@@ -593,7 +594,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 	unsigned long sectors_reserved = 0;
 	int err = -EINVAL;
 	struct page *sb_page;
-	loff_t offset = bitmap->mddev->bitmap_info.offset;
+	loff_t offset = 0;
 
 	if (!bitmap->storage.file && !bitmap->mddev->bitmap_info.offset) {
 		chunksize = 128 * 1024 * 1024;
@@ -620,7 +621,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 		bm_blocks = ((bm_blocks+7) >> 3) + sizeof(bitmap_super_t);
 		/* to 4k blocks */
 		bm_blocks = DIV_ROUND_UP_SECTOR_T(bm_blocks, 4096);
-		offset = bitmap->mddev->bitmap_info.offset + (bitmap->cluster_slot * (bm_blocks << 3));
+		offset = bitmap->cluster_slot * (bm_blocks << 3);
 		pr_debug("%s:%d bm slot: %d offset: %llu\n", __func__, __LINE__,
 			bitmap->cluster_slot, offset);
 	}
@@ -632,10 +633,8 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 		err = read_file_page(bitmap->storage.file, 0,
 				bitmap, bytes, sb_page);
 	} else {
-		err = read_sb_page(bitmap->mddev,
-				   offset,
-				   sb_page,
-				   0, sizeof(bitmap_super_t));
+		err = read_sb_page(bitmap->mddev, offset, sb_page, 0,
+				   sizeof(bitmap_super_t));
 	}
 	if (err)
 		return err;
@@ -1127,8 +1126,8 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 		if (file)
 			ret = read_file_page(file, i, bitmap, count, page);
 		else
-			ret = read_sb_page(mddev, mddev->bitmap_info.offset,
-					   page, i + node_offset, count);
+			ret = read_sb_page(mddev, 0, page, i + node_offset,
+					   count);
 		if (ret)
 			goto err;
 	}
-- 
2.39.2

