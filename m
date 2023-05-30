Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D477167F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjE3Pv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjE3PvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:51:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977AF123;
        Tue, 30 May 2023 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461830; x=1716997830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eyPQiHOzD3W2DQRKwVAI2Cbe6Umke2Yu0VLdprV7VgA=;
  b=B+xdn/zItxk6VZTLGReToDp/fwoeh2V4UxHrimaBzcC/IwHaX+uncGkH
   Gyh2pCWLdjUK4DPLr2YKTtgzJqpwkAKSVTuWT9qFRUbVVcjiRkbEsP6OP
   y5kgiTgD/GmysLEvqfTwEdD9RD6arQySKj3tQkL+dR0GRWQHcyaj+IGHm
   xmcEQw/pUmaoo8gGNMF1OstRCoFdu6HnLPLUKuPXJkDudS8zTGy6+6/Da
   +DMc2RM+5Nx26hMuMVCI7VcrLdfQhbXhkUy0RnbX13LzxlvtguWS62qp5
   Tt7Jy0LwSJmNO5mI1G8Sm3b1AOsXwtlWDec+CZMdMvA+2RkpRsV+dVUcY
   w==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129909"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:29 +0800
IronPort-SDR: F9jKRLUXq/OoUCrD7C/Q4DPRQnFptPSsFWYc16lgtCpx4zpY5E8ftX4BqeYV+wL28YlKFh/M95
 JfPtuiASJ404lullBRYc9lZh9lNAilMwChHXfLIdYb/cw7XfWv4XWUZ1k8dLnZ8IPfxlTyT5fQ
 vGFEi8RDNGh721cRImVAxdE7XXQa4mggAHxJZnDf+UXJAZ/xsFOG2mxVcrDaNyFnFjo/QuSd4j
 QcgTTSMukdJwDzI4pHxYp7DzAtoUDaQeKaQAKGWdTVn2AuOQ4NjtrDS3uDCqmAjpUjQO9QUIMe
 IRk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:23 -0700
IronPort-SDR: bSqBFzv7rrWvPvkE4gwhOHj9e0jpcVXnuD/Kq3xELlTSi+Nq3cUl8HGoaL0rUxB1OR25AAJdei
 TIPhTBMTndkhO2YNy8PxBhVVLv4Kla8ZXnfIi5I7M3fxa3gTd8oOlhRXj2aVcnNgmc/rxQ3lh0
 pt68H/iNv5aYOaAvAaRNX6IexlshH2MNcr7cPmRVBzj+I1Z64b2NARfsMPI8qXzvdg6WEXxV+l
 Bxa2dMoJnICTi4jECIHCBYec6Uvp0PaRuTsjD5YAUZHSr6x9Mm/SzMBT9zXRe7WaHmXxtQTl7o
 Jr8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:27 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 20/20] block: mark bio_add_folio as __must_check
Date:   Tue, 30 May 2023 08:49:23 -0700
Message-Id: <3d45098a7640897cbace54713efe10d88b74c160.1685461490.git.johannes.thumshirn@wdc.com>
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

Now that all callers of bio_add_folio() check the return value, mark it as
__must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4232a17e6b10..fef9f3085a02 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -466,7 +466,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
 int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
-bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
+bool __must_check bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.40.1

