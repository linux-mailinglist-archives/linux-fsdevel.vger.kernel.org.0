Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998987167D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjE3PvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjE3PuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D40133;
        Tue, 30 May 2023 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461809; x=1716997809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBiHAYrZ5iVLErIRk58IVnEcVkubX6MqVTAomfOuNwY=;
  b=at9iYzBijzJuDuHPhFDfKUc1IJRHk1ExEyAm21JLebBchAuAxzwLwAu1
   eA36i9QEuPZAge71+dbEaWJmq3o4dR6qweNXSnf1YwEWn2xs4fgFlEUc5
   BvC4dq9o7beBZoZ5jPwOTsK3+Er8OP79sJD3SqNwnhn1vswuxtaQwAOWo
   gzzafoFIYnUAT/ErEbjOtH42+RJ2G3Ij6As381q7iPVxfZ2b97hHGilq0
   hEckoL/BXdiM0sCGYoBiyEZ4gj6ayYRHQBW4Lw2CnjJKQy44DaXpJRwrO
   9wB4WDBbtqq6/Yt45vb3M2OC05Wx/9YPZ+ypT1mBbMcb5gpcaFy8fdcuE
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129826"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:09 +0800
IronPort-SDR: 4IvlfNB9X25BkY7lkaPxHlodCxJStDl73PgAA89PJicnWOAIIlmaQRxj6fiTEcyery0vnsVBlx
 HfrXyB/yUJd6QuKNTlQYgZ7t+Yj3/cfSnHOQtMBOl4mqyukbANDov5UbXLO4bPR9EWa7VyiADZ
 HeQlBqDaJ1d4Ws0vZ8nnRFQekE/AN4oaXy7ZBir8A9kznC2rrUvU3RKb9TDPuu1SpAfgDuJA1n
 1LdW0NBFQOGDLEuaAMsgIxrYZlGJXq8rB7qG4RE80seHvlR68keOYfhDqLNFR1Yq7KSGmBHSzr
 qbA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:02 -0700
IronPort-SDR: P8Y6Jd83vQweumNav4silCK78F18+npfP53U6otRJi27bXYVZjQeG19QgfdDPNWr1dSjMk/mR0
 TdQwe1yI9lQT8scICxHJ6QWWNvtw6CpvMEfGKX0/h2/HRnwwlFzCTEOhpHvRwXqArmvKCIqw33
 ppmdUhNH/kHH580hO75tFT3x/8Uyc3S+cBMv20/BBkhaZLKkAVgh0pxoEQ8eaQU2CR7VRKPGtI
 xQvmwMzb+rhKJ4KrnyzbkU6q4fYwpSUwIQMfpbXadsUNzjaagJ7+TEz8B0KEm1VNYW+RFH1x1t
 ltA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:06 -0700
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
Subject: [PATCH v6 13/20] md: check for failure when adding pages in alloc_behind_master_bio
Date:   Tue, 30 May 2023 08:49:16 -0700
Message-Id: <d7cfd04d410accee4148d8c0e51230bcb8b4bb8f.1685461490.git.johannes.thumshirn@wdc.com>
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

alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
is not checking for the return value of bio_add_page() if adding really
succeeded.

Check if the page adding succeeded and if not bail out.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..8283ef177f6c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1147,7 +1147,10 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 		if (unlikely(!page))
 			goto free_pages;
 
-		bio_add_page(behind_bio, page, len, 0);
+		if (!bio_add_page(behind_bio, page, len, 0)) {
+			free_page(page);
+			goto free_pages;
+		}
 
 		size -= len;
 		i++;
-- 
2.40.1

