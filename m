Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7026CF06D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjC2RHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjC2RHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:17 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAD7297;
        Wed, 29 Mar 2023 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109619; x=1711645619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6quq1m4TWQi9osOf7yGXSERsZmThGo4OIw78ZEc0Rk=;
  b=Mf6HaRzcxbSgfFTOSoI9C+edevGxjNHQJeCtRQ25Ualn9plh1tsUzW4X
   XD133Ryld2WwpW7vu/6sRzRi/veu7uaE38XLS4bapuL9ajWudrFu/po7E
   c0DnOBjduRGOkYVCdLk/wdAvf6cBnl710AgJX8ZU9Xzt+B3G7SMpXitNL
   vn4/YtoklsCIwfU3J2zSvcIdZDW5klUIRInf7jJ/9+NJpoTnQrmw25VEY
   K0dNp2UfNNoAMyVPen1tL+ncVsIfvxYb6Cihu81CdD81zhJ0UxR6syFyM
   zWBgyEhuiRDWmMO/xvfOf/BQFa4OtzCAgvogZ+FRPtQGrvedGwVglNmHw
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092878"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:55 +0800
IronPort-SDR: aJpmXOwkWoPYxRNihvkytLPxnrCRkqoKcdvIEfwkHSnS97Snw4uD6wIXTH+xES6JV6rCWfba83
 Hw6tCycpeGcMmTt+/uh1vA9LhAKKmE0/capdgfIMsRyXnZd/H2HD2gNbBAC5iSIXKNmd6NxDyq
 1KF0KrXeYCivrbrn+DNX4dtKE2bWaXMc3aMdHnUCiDGfn0HhkpgkvSzJdj7vULyMK4qSh6IHRn
 YwyR+y9z6+6tpgNaX0Su7z6T5S5qFR6hIcyrQG0ky04nVZOA/yYPEcKGoSJuOUzpagNmzJpQaP
 DuU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:04 -0700
IronPort-SDR: EfB1mid7Yp3/W8x0cv1xCvTqB4tmpDb7gKC20U950XR4Kv25uQEBdHD2sX3z0ZSLxA8GI0cOXU
 jE1Ay6UJMQxVqHXD8lvWm2TZROkyzsfKMaMopjdSYaXULQyEClmuQw9VtaHAuYJDBQyPZUJCRQ
 vKqkM9YtA+Ksasx1R3ikQB7dJRHIW5dQWGWw/GmsLQGP/xKSrev88U8DdNIM9yoEmWmnU6huII
 pnzvTC1RT/B69S+Qs3+2aJU0lcD20LvjPRlcXyQ/bpLKfriwZ9RZdJzOSPmCY3zHV4Gxs0dMBD
 Qdk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:54 -0700
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
Subject: [PATCH 12/19] zonefs: use __bio_add_page for adding single page to bio
Date:   Wed, 29 Mar 2023 10:05:58 -0700
Message-Id: <ef742ee32fd0623008114e929d9a3e688fd721f7.1680108414.git.johannes.thumshirn@wdc.com>
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

The zonefs superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 23b8b299c64e..9350221abfc5 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1128,7 +1128,7 @@ static int zonefs_read_super(struct super_block *sb)
 
 	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = 0;
-	bio_add_page(&bio, page, PAGE_SIZE, 0);
+	__bio_add_page(&bio, page, PAGE_SIZE, 0);
 
 	ret = submit_bio_wait(&bio);
 	if (ret)
-- 
2.39.2

