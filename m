Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272E6D01E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjC3Kqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjC3Kpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF75A240;
        Thu, 30 Mar 2023 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173110; x=1711709110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=losNsOzC/f7Y139Rf9MlNoUaYWQhJEhtWroEro9w4/M=;
  b=Z6xh8ceIF4/MmBWK/AKeTw3V/z3jJyA2FEum3jYLjv1W/6pJ34z6Pt+L
   6Ygkcgp2Q1Bqm2qLsJD7pekPoYDlkS7NkoxDCIQ20DHkz28kEkp20eYdU
   VZFHxrRJrs52gxlYDoNRMBw3YsAnriuBdjfjXqBg19cZB3lU/JYkuSVPj
   smpAPxQfqSbAgQgA95hSLHmtYs9flQni0R0GoN0nf+VN1lMlE9Zj6YB7a
   rznnV0XnrprfMfKi1FEIxv3JkCxdtqzPbbFBf7UN8EthlxbLulTsM39PG
   DmrHKI3m4RgEFaMKtuBuCLB3FOLoC+BgwnL8rT+BpnCR59rzNLjSoukbz
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317852"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:32 +0800
IronPort-SDR: 7GPm3hwvU5PR7DWk3eeGl0q4NEfRdmXuCWHBbhIwrx+aVBSqBKkWEgByoh+pTlYsyFakbPYZzq
 4/x52Y/wmZLDvR52nirPgD4Uh+zoz3ol5IBoHvYHEIKw3EF+g/cUKKEtE5Hkk6qbQdnx/XZejm
 CwFTdpTd6pA6BDfPJlexBuLRpgYT2Nbt1wBp9/Sdr3XK045wP3V7H8nQn/aT9QOeQfVZhtVXDU
 BTKUfGXKGIJpVJqwuhLAfF1ybZX/IAhHKLSrNYoh+2Kt2Ti7j9aZoteQr+sEngDACUomiVd+M4
 q+c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:40 -0700
IronPort-SDR: LLyR2Npm2+MAJM3XIZClgMxoi6I/W/dIVvFOaKwZbXR+FXU/hAizNCjpHL6vVJ53LRicCLvlw6
 5vJSG8HqxBWOqmVv/563WgNcBAKcQrTbUaISiCtdAKhBTNUkKx21Cw/LpFv6nwsVXjwJUXttT1
 Ouz87wSgGmy/lK21UBktPDa5DL8h2pGw5G6UoHn1GsKFWFrgaBgxcgxKAEyMdk+8OOry+WySWP
 2F6SU6oJeDkTWv5KZR1md8qL0MPIRJYLz7AIbGmgoPFt1/WpjDzmEIsUXysP0EYjsW8qL4qhU5
 Fe4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:30 -0700
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
Subject: [PATCH v2 09/19] btrfs: raid56: use __bio_add_page to add single page
Date:   Thu, 30 Mar 2023 03:43:51 -0700
Message-Id: <e12bd574e0b6e8f12ee80e44908d8463e647053f.1680172791.git.johannes.thumshirn@wdc.com>
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

The btrfs raid58 sector submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/btrfs/raid56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 642828c1b299..c8173e003df6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1108,7 +1108,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
-	bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
+	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
 	bio_list_add(bio_list, bio);
 	return 0;
 }
-- 
2.39.2

