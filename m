Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D96D020F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjC3KrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjC3Kp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A689743;
        Thu, 30 Mar 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173120; x=1711709120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKPcab2XYTxKDTsHjq6NQ76PfpLzQxBfOz0TQbvI9A4=;
  b=MtLdEF/GYh8cUwyc4E3mlADIrWSLlfm1NtUIEHe1jyqKCPZKc4PD8g4h
   TmZcoeb4XL3FbalyeOVAh5rszzRNaj8kcOpg3wdQpbsGOSxNkCq6Fmu8P
   2y8jBN0SaANrNyTLCNpnM8mJUyXAQyW6fe8hmEJ5nOS4SEN1X1ch3kg2C
   DvoUaMxBFY+DxZfZXef8DqG2f7URAD2BrZsvw+frcz2ViHpVEd7eU9R7V
   6ziyQI2TS45dLO7XcdpWE6HBba5lJ6smuAtCoHBLX5EbvO0p11vYBDFLi
   dYFwSWzN0fqItk4fVpKIKu/QZST5ILVFoyRHKgJPZo/Bg9d+rUJZJ/vqF
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317931"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:59 +0800
IronPort-SDR: WbFcdkgzKvxi0CQ9Q6kfnM5ftMXts32o8oj+4I/4qA04abNLriLV3el9kR8+fYocXnjawsxKm2
 n0/653KCOYn7RBjvTaxC9R12jQYeOPiTABskcYr2WjnG7kDBVMPMmykH00uX7mRG7f3MRnUiVX
 3fBsnun74KCyDFPBl2ISxMiSKzl0JVy8jB95q6EsOgR2uG9srvIS9NSqVaA1UsA/v9uT1shzjF
 c9hYiabpVIquewe9z5TR2DbZSXRu5HoIzzGJ5+zOqbVFyyG7uFfvA6MXmrHM5ivYYJ71gGeGF/
 BZs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:01:07 -0700
IronPort-SDR: Uz7s+Dcx6yIQkvOUQB+fZBcewu2LBoSQ3pKR+yorfvauRCwyEfsemTaCli7NU9SOzvmIsB3Hts
 tNYBtX+nfuDEC5uXsXRcTKBMvdR7SGstEuCQUjhfSDF+BiYqMb/6WvHW+SrRgnWUnB48Q4E2C4
 fbh8vMwc892YV531EYcZRUKNAzwNrgHgza3EAt8v4dtp8X3HEbGwrP9VyDAFzQUEaHs+TfI18c
 xIpJgsXVErH/79qMVG8Ygjlt4VP7eLqwzcPd+tJBQVyBPVtGsmWswAn0jdBYeDXDy1fyvy4CzS
 HRA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:57 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 18/19] dm-crypt: check if adding pages to clone bio fails
Date:   Thu, 30 Mar 2023 03:44:00 -0700
Message-Id: <84973c41d58473dd50324853fb88a7fcff55745b.1680172791.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680172791.git.johannes.thumshirn@wdc.com>
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to clone bio fails and if it does retry with
reclaim. This mirrors the behaviour of page allocation in
crypt_alloc_buffer().

This way we can mark bio_add_pages as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-crypt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3ba53dc3cc3f..19f7e087c6df 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1693,7 +1693,14 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
 
-		bio_add_page(clone, page, len, 0);
+		if (!bio_add_page(clone, page, len, 0)) {
+			mempool_free(page, &cc->page_pool);
+			crypt_free_buffer_pages(cc, clone);
+			bio_put(clone);
+			gfp_mask |= __GFP_DIRECT_RECLAIM;
+			goto retry;
+
+		}
 
 		remaining_size -= len;
 	}
-- 
2.39.2

