Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99CB7167B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjE3PuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjE3PuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54998C5;
        Tue, 30 May 2023 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461800; x=1716997800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3onFYf+ZZCsjR7ISuwDOJFQGwH0Ly8JQt0dIZLYRR0=;
  b=UKkSlQkvZcC4Wcb/CPeE7cAqMOex34cWZuWZfqrrwKO+QVEyHnfM1NNh
   3VFQ+mnnSPVw6vkNSknQKaJuSr+fY2OreVQQkpBojSzAYbj+1QsF24rVy
   0a1/2j9hO5aoL9nOHlb5fIFNzT8dUydTbXi2TEEgoiitjkcivmqE0hTfs
   Vl1gc6/vxWudP0sLKxe15ykiiZepVuo93F+zUlZtRSI/baz2QZdirNqwT
   mApQBNc4dgxUoAZghXzmpYDHGMwWpGv6RBpbJHcrk7rJ3PGfS7xmceIQG
   pICt2rbBmHaa/wK+krNU4rmJh1HzQI6fhMzJWfpMWPIpZW0Nn3czYvbVn
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129801"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:59 +0800
IronPort-SDR: m5NLxjXmc1Y1x0EwpqEgT1RkdwXdWe+HQfd19+oQFqOvZbcjJLZQaaHHY/1RbU2DTYJ2yLLVH4
 J0DxJj+tXxMvRhfq1zYtqjIawGFyRJzzrWB0ZAGI3ZAHp8znT1ORswqTmGW9Iy2veVv/N/jR/2
 rI+W7CLxfWbnYoZJQjytDUidvYtbYuhsccn+8kLIM4hAVli8hnu8wPJwgjuP65qEOGJnL2higR
 lTS6dMRG2kVmueNnqEvnfyGDR2l+x6CGhKy0JzCs2ksGQ8CPMo5dq8CUOvmd1wYxxwH7fLGZhG
 0oo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:53 -0700
IronPort-SDR: ZMHPyde+x3oZg2TtUSRL/5p5WqVr/ZfKqvYwCZxUYP2qYQ91FJJt40KpHRQdugU8uEYsX/I3K/
 I9FEFvtZk6Bs4sVviWPES8u2Sy6mkQSXkjcdYwONAcCuJSehDyyyLlFwpmPv+ibIXsEmu0GWG4
 2Y8ns+RdUjXQlTNei1wm9AL/aSe4WsIWt+fbIYohfizzZXwI2DiTr8AG9+VlPVIh3eTqf/W2/A
 sFbZ+/LPFzOwaTFd1WGs1qMqHoly+Y7z8CXi9+Jw0hugo7ke60l0xnB9VSjPDyKn0GdZOBduyf
 BL8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:57 -0700
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
Subject: [PATCH v6 10/20] zonefs: use __bio_add_page for adding single page to bio
Date:   Tue, 30 May 2023 08:49:13 -0700
Message-Id: <b1b488224117ed5e230478fee2d4c5536ee1fa45.1685461490.git.johannes.thumshirn@wdc.com>
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

The zonefs superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
2.40.1

