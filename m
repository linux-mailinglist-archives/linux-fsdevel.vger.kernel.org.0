Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC216CF066
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjC2RHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjC2RHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1E7289;
        Wed, 29 Mar 2023 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109617; x=1711645617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HVSOyDSmhD70Nv/fkBkDeTGlq4JItHI/qNc4UYNza9Y=;
  b=biPMa8xS3Rnj83hzBKqEyQsITW3qoUKVYwMKa93XFEIVWmCVDKEVeWoJ
   xY5qUk0DmcyqM/HPvJOE7mRniXJT4ZceGh6QrX1ppGquCJMdaD2VMqm3j
   vizSAByGuGK8A2cAox8Mke2ybuHk6TUSCdQQpsnzm34mWy/33oNOzyCvV
   VSGpW1/lUZKnggtrq6H8+Nv4uIB9qK6MKO1TXU6+oMQ8wQPekR0OPNbX7
   YK6LH0LXk9MNC+Yg7oO0bgHZzhpzn7bmNkGDQGgW+AVBNvm4x5CvzT+Qx
   8LcPH/1Ql6C09aXRU40wojzvUcKq6+Kr9B9aCMc+DJfEohSoSInFXsTkp
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092876"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:52 +0800
IronPort-SDR: f2hPzcXXYqz6+fXzp5wbFvq+dM06E2iTM05Bw6GPMXdFDI8eUKjQhLxDLNDP7bSpAR23TV1Mze
 Ahh6yY09/T5NQ4+9PaT7RC78D+apJoKcBQB8yN5lNrf2XjYj5lOyy0KTXNM8sv2iplj45wCd5Y
 b0DJ7F7GSYlxg/Uloem3wy0CSjKGsy/l1thrKjwx2bEItvM05xxtqUTgO9KlrcCgrwiMkkIVIL
 NBjIYxFMZGdyp6+E3S0rbzLhp19A3nVzFdZ4QE46HKt8CQ2vjVcBLh2DdgzCs6YtCePvPuMZKF
 5VE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:01 -0700
IronPort-SDR: BQgCe592q5M7/+hA4h11/kqfHityq5CvcyPS2rBc00hC4byMFoMSONh7xRqYNa59BKcDsROUUt
 MTkgPvmq53Jx71bmK390FtI6XSqL4/k6hBD0d81URBbk3Tt/Bm6YA0CRTta2rw15YqZZnZQclD
 83BsLqej3Hs6EnxH5F5Dgte4ie6E3NSwc71KxqXcfciRA6bA8kvbBkRQZrz0pjrsGYBhyfiXmH
 Sm7ISx3Sy7yOK8htnsoXxQlu9j3TpCWlBVFzghrqQFDWQ1hiGWMf+dYL6Bi+aoFos5RsnY2nEB
 30k=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:51 -0700
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
Subject: [PATCH 11/19] gfs: use __bio_add_page for adding single page to bio
Date:   Wed, 29 Mar 2023 10:05:57 -0700
Message-Id: <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
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

The GFS superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6de901c3b89b..e0cd0d43b12f 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 
 	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
 	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	bio_add_page(bio, page, PAGE_SIZE, 0);
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
-- 
2.39.2

