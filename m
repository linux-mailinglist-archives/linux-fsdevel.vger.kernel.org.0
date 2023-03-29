Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA16CF029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjC2RGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjC2RGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:06:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57C619F;
        Wed, 29 Mar 2023 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109586; x=1711645586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2tfkQJHOoMo9xPMUAirVs15MwxpHItWsELh86gGl5g=;
  b=TU1S0uXk6A9Xv6d+euBl9OrKHxVxBinbiFCByBcKwtUhaStMBpU0YTMU
   l0Mt3TyfdQAjNGJXOAMg/9tWYMq4RpNp5cTqDWFXCOUsJi6yUpkM+lDUN
   92uRGz65dBf3vkNAchDFcadgZu6odllXJDEXBOydIfELW4jeYxNZMYvzf
   B1n47AYO0WzmB+IAIEQQ4ziBK51dqWiig9fl4Rk81PlsaK4FqpG1xLcnt
   8VaRaGhnInLBmeVejEKk740QHo6f+02SuLsh0BYvfrt0+dxcLuk/eKFpa
   HIIg/YVQtBwNs6pSz0jNjnpUWiY9YRe98GBn55UGQ19MjGUWfaP3AU+H1
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092821"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:26 +0800
IronPort-SDR: ufSfQ4OYg3CsHe7rP994EPCC1FWbom7zSwo51TocjoeaGaNDvrtU/UB8OAy70oNb7BSnXpbl3W
 ui4AVazpzO4Ry2G7pGOvgskHVQOHThyaVsuxwp1LS0NCUYJ5XwfB7cWLcZNyeNAFeU3PD3FKGD
 NqnWCSIik9LeOrRjoiRGIyHD5ZYYK0Ftbnai6+pUahLaV8kHv1v5w2tcgK0TvudH6ywfA9AftH
 q5kUKKe7S63tWjFQTZxvGotUskd1Uvu/kR4sIh7W6kM0fTo01vz3EvK/Fk7p7u5mLUaiVs2Xce
 81Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:36 -0700
IronPort-SDR: oN2UR0L9Ic/bC5ZlKdub2hL2B3WzSMNwWPaTts8Go9tRNUBzKiBjVMXtPb1MCBqH30XhfX5VFK
 r3o3y5lK4V0syF4FJkhuPmKVn0NSvYTqzCGIASu7aUGIjtgkWZfbeiTvlj5dp1GTJ+SAbWxEQ1
 bH84aK1rLSnMEBKGsMwYaHXGhkfZPfTCuxZYs+HVziD2+k4Bdwtx3+/JcWFce+mApOYNcNV45r
 3t5a5tYLJENitHpxBEddwdCKeyJVZy3OKiWBV7xOctdwFhAm4r3Z/fd+xkk6SD/0qdXQzGwmhy
 sn0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/19] drbd: use __bio_add_page to add page to bio
Date:   Wed, 29 Mar 2023 10:05:48 -0700
Message-Id: <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680108414.git.johannes.thumshirn@wdc.com>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The drbd code only adds a single page to a newly created bio. So use
__bio_add_page() to add the page which is guaranteed to succeed in this
case.

This brings us closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 289876ffbc31..c542dcf8c457 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1043,9 +1043,11 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op, GFP_NOIO,
 			&drbd_md_io_bio_set);
 	bio->bi_iter.bi_sector = on_disk_sector;
-	/* bio_add_page of a single page to an empty bio will always succeed,
-	 * according to api.  Do we want to assert that? */
-	bio_add_page(bio, page, len, 0);
+	/*
+	 * __bio_add_page of a single page to an empty bio will always succeed,
+	 * according to api.  Do we want to assert that?
+	 */
+	__bio_add_page(bio, page, len, 0);
 	bio->bi_private = ctx;
 	bio->bi_end_io = drbd_bm_endio;
 
-- 
2.39.2

