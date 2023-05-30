Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7C7167D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjE3PvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjE3PuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B7FE5;
        Tue, 30 May 2023 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461812; x=1716997812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLNFQ6oFKOXzjx1/s8qharxbtLHt5SQOkfsl+Pqo6CU=;
  b=RZs6pH3+N1cRwu/ore0dkY+Df0I0tetdTjqKsK+3dd5TmZcWSYvIGOot
   jbk+JLup9XES5XdWf3d1LySHqjDgnREWI8XJYX0mJQHPZ+zJr/lpQzT2R
   Q0AFk0Y2qRBDtxBtb1SGLw7YC7uc72wfrMIv/U36qvti2rpEmklHy11+O
   WBXB3L6JgGXm3KAqmj5lVAj3O3Fs/clpdpPWwLtpBZN/WMCwGchQ3Hec9
   hMUBOLE4gLDI1k8ZYUTrt9k7BwC2DWIzXLTZXP7pVz75u0IeEMqItVq7Y
   N4mTE1VwHkDl0RBCXJpxwbOIcRGixV20P+DAvd01MzAC7Aj8JV8vEAhAb
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129842"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:12 +0800
IronPort-SDR: APtLt6F/eeOYLEYPuXi3/HG/7IKPG/e0XqJx5ivT2TsZYJCfoyPhwDA7gO1nLg37JWM77aMn4v
 60s8MyxFU43MYL58oVldSCZpLprxTWqh5FToU3P3/vDsIA4iVeUk9oShe3STtmmyGsTk+ZQI2O
 TC8Qkzl/oBqRHaJOUlNOL8rPxaKikstLCTHXAqvY4fl0MY+ZWCNYAxDDUbhh6I3oXvo162kdSG
 5B0iwMgUiRCsuSx8q2ZS5ZEheW9Fo6FMrDx1gke5oVjzB2w3wKONtBfugECaxYlIV7Viep8Fuu
 XQs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:05 -0700
IronPort-SDR: snoYL5vkwQY2fHovd8/bCtXAqv6z6MFk87CGOha3y1t4nQ3bzraGCrnIzedV0/LXm49W2WzhWH
 OUgIPuepqt5ylCZ0SV/DMCPXbIyw1ZMmkUrTUJnzVN/uHZbS+HyYQMQ7p9zgdDgEpDAO0bKSNQ
 b9sBV2ZsNYFfhtNaL7pMTYRcvQHa2AW5lh3lf8gZABJoQuBL9ohV1zESC6t075E2qXQDGdMKNU
 jeEnItThG3PlPxvvohrB/SNHt+pgq8Cps3WQ5E3BrPDTb9RtzCLgejg2k7fg+5N4Buz0u9oIhz
 Zbw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:09 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 14/20] md: raid1: use __bio_add_page for adding single page to bio
Date:   Tue, 30 May 2023 08:49:17 -0700
Message-Id: <05f4a70914885813a2ccdbb8aa7eb7d75f79329a.1685461490.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685461490.git.johannes.thumshirn@wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sync request code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8283ef177f6c..ff89839455ec 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2917,7 +2917,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				 * won't fail because the vec table is big
 				 * enough to hold all these pages
 				 */
-				bio_add_page(bio, page, len, 0);
+				__bio_add_page(bio, page, len, 0);
 			}
 		}
 		nr_sectors += len>>9;
-- 
2.40.1

