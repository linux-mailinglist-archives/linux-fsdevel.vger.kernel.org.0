Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB186CF044
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjC2RHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjC2RGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:06:52 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA66192;
        Wed, 29 Mar 2023 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109595; x=1711645595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z0WRD7PSxT1MI9gFHxfmzZuO828C1XYh8k3AzLzoH+A=;
  b=NpfBoHuL3XAkv8dI3dL+X0d02PMW6pMsMfIphw0BUZ58DzwzqVpYUBYY
   JbRNT2eMyKj4ENdkLOwb7oOoVrwSb2kw/E6fe2JdlGhJMVGShb0nbxxXB
   26VYoFETtND2fMUbFWUDDYDI4HGvUCVaYGfAfCOAD7vKHM9dq2H6CgMus
   MDKROKsIfdi0nFHwMesbFzMzZ8RnmRj+V6lyP0yzJ0taVMgzg+cGBS5A0
   LhbgORjH2NfeN+jg4+oQLBw86JnoOfFKHQpQM+hE/fcdi4C4XpQrSN5NO
   N03ZBXE/UjdvlMLw/CxwjYvvkvcK9InjU8yr+hy61TzHCTAd/479nV1E5
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092841"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:35 +0800
IronPort-SDR: kBJgDeAosX9OqpK+VGPPTvqBehG9cSaSxeN2O20R5WxOQl7R2XwbVuUfSp4sBkhO4LGK4iWU1x
 s50zcAJrFLYmlbQJz1MIXutBN2BXw5QDDcFpW1d/6oUaN4kLZuP08+1nOp84VIGXr7vzlF+8oS
 lg+Wacx4z85omgq8JJc2+be6hV3q3Tj7WCmR8ErnPohdCz4YtHje7E/2Ocyv7LgmwQqUH1+UBq
 jTp8/L2F8hrJTdtMXnOyHPNgILVObTke7sGDQD8dsq3kq7F/CWfLZQ+4nS2GSg1rHVC+AAHB2J
 MUM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:44 -0700
IronPort-SDR: LCzDjMY5FJ5sr8pIsHJapmUnHR/HrhUl79JV22sYdEO2rzY0+ynCU/VuOjv7ZALoaIA05uNHnA
 KLRyUMuwlt12IwC+VHi4otXGnYicO4UmHegZ9Kplvajn0f/LaNS4Vr15N4xbFpRBJEti4HjRX1
 Bvit1PEiowY0ep8DeA0czhvEoDRP3Kll86DnbETpHg8w4X4G9iHJmSKb1l58xWudqk0JK6OIZ/
 BvTjCmaxL3mPyUI1B6gKVzuL8y2j4E/ZHPehNYyHvH3JipeuiATzGUF76GOIcEtetNffS4rAKx
 brQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:34 -0700
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
Subject: [PATCH 05/19] md: use __bio_add_page to add single page
Date:   Wed, 29 Mar 2023 10:05:51 -0700
Message-Id: <55ec6659d861fd13e8e4f46d3e5a7fbad07e3721.1680108414.git.johannes.thumshirn@wdc.com>
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

The md-raid superblock writing code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-of_-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 39e49e5d7182..e730c3627d00 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -958,7 +958,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	atomic_inc(&rdev->nr_pending);
 
 	bio->bi_iter.bi_sector = sector;
-	bio_add_page(bio, page, size, 0);
+	__bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
 
@@ -999,7 +999,7 @@ int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		bio.bi_iter.bi_sector = sector + rdev->new_data_offset;
 	else
 		bio.bi_iter.bi_sector = sector + rdev->data_offset;
-	bio_add_page(&bio, page, size, 0);
+	__bio_add_page(&bio, page, size, 0);
 
 	submit_bio_wait(&bio);
 
-- 
2.39.2

