Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC071211E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbjEZHdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbjEZHdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:33:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B275CB6;
        Fri, 26 May 2023 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=RQzHrIRCFqHArqIrnKCyvyHklB4zdcXT4MP2qOnLDko=; b=xIU9TLdnNYizB06PmvtzYlTdR5
        HlTQdpKGeyyWACTTR95smi75XqDqgG9cDCVGjAOdZdR3m8BPT3TY8BNggYNMWsvJTYAI3fPk8ZdnX
        +BPgRSFHUYMlBkhvzll8T3HI/Xl9csNmtX8QKMKtP/iRaIPqnstKYFRv4S7XfWPyCylLC1KlvR72z
        xZm4OyGRiK0FlBL7bEZCD6oegED5VqaXt1eqNzYb6Rc3bdAejGjBTYfmdB5Mdvz6UDPn/5p642Nn9
        5WC3HcP4OrbSccmqITnp/WDQKvQYcQr/4mAHruC7ragwNbVz4FX6+BYEFG0dF9uA91YTcz/4vzB+7
        v43VXK/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2RxB-001RdT-0G;
        Fri, 26 May 2023 07:33:37 +0000
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
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, kbusch@kernel.org, mcgrof@kernel.org
Subject: [PATCH v2 2/5] drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
Date:   Fri, 26 May 2023 00:33:33 -0700
Message-Id: <20230526073336.344543-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526073336.344543-1-mcgrof@kernel.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace common constants with generic versions.
This produces no functional changes.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/drbd/drbd_bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 6ac8c54b44c7..b556e6634f13 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1000,7 +1000,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	unsigned int len;
 
 	first_bm_sect = device->ldev->md.md_offset + device->ldev->md.bm_offset;
-	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << (PAGE_SHIFT-SECTOR_SHIFT));
+	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << PAGE_SECTORS_SHIFT);
 
 	/* this might happen with very small
 	 * flexible external meta data device,
@@ -1008,7 +1008,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	last_bm_sect = drbd_md_last_bitmap_sector(device->ldev);
 	if (first_bm_sect <= on_disk_sector && last_bm_sect >= on_disk_sector) {
 		sector_t len_sect = last_bm_sect - on_disk_sector + 1;
-		if (len_sect < PAGE_SIZE/SECTOR_SIZE)
+		if (len_sect < PAGE_SECTORS)
 			len = (unsigned int)len_sect*SECTOR_SIZE;
 		else
 			len = PAGE_SIZE;
-- 
2.39.2

