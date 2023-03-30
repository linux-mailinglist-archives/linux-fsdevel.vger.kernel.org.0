Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0066D01E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjC3KqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjC3Kpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:34 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754358A61;
        Thu, 30 Mar 2023 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173104; x=1711709104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9gE6QmsdFRmz0ZVCVa1q8hek9wq1iRj98EqV3wB4Jk=;
  b=Usqp6+76o9Orepyc6tpBQQYooJ9MLxfeZ7VcvilS8l+MmPS9udekgB/7
   ct3UeuCPzirAyBlrYw1IBKs7dw5SjZ1t30On97rUIF5garkgadtZCUd7m
   8vYYRzlJx3nG9ej50bGQPN+9gY/H3EYhZAZDVB+hgCHkZwhPCObcG3PI+
   9A4jn8yHRCQhm0h+vKBr9kloQkw4/Rcm0ahfqzuLZ3KGAC7KFY/qsohIj
   0hS5A4XJAQaiH8RYYty4vpTp3V1OQUhbaGqaYZY+NSTbVMu1qkrCPo/G7
   Wc/xqngVXfYAfkDaq+sO/wOmdGeZcekmMI7byVlyHWLZeoyDJma31NQ5K
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:29 +0800
IronPort-SDR: bkJwR9quMh18/UdHxvOwQpqb2SzSgEn50+zkPLSwtqbTKKVBqmR97lq6usjPzNW9R/glqaWlEA
 HfcxTOQ0foluggd+EEOuLPHabRZv1pjFnsfs02JMQ8tyohlO+Q5V2Ufabq8JhaXanmrj5QsO/6
 3JJ0Kv3tZxzgbNeIzyXhatgokf/x9q2adBLqStbhlLTo3y8SldL8r0zTyr7iuHI+cxxG5GZe/E
 QrjP9+gsDVEpPMi/nUMvDD+TvigD4QkhK32G5sjwlCqPelC2FtvsGwGy8NEBraLW7187d+VhJA
 Iys=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:37 -0700
IronPort-SDR: 7VfBtatRUAMSKGZJhueT2GpjhxB7O4zmUTxm3R9MTyW1KAXQy9vKW9iV7AuhhA2jy1ZSsCp98O
 U1y/h8ZeZN+sRqZVsvVO4hAs927WNwruX7ksWwSZxQaZ7PhnaOJXPNDyTm+sgyqtE99mUZ4qrY
 atKl3lP0PB5GGkREm/HXgG7Yx5KK5w8jOv26buUSZPHatbFFFBRCcm6OyZcoqfvlkdXIYWwkqC
 cF0K5nj/s7lS0zwe1pS6KOfyNTJKWJLOIHUhjXr+avwW9dLSK/XfwgZxojo4KfnWNQ5FGo1gwc
 c7Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:27 -0700
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
Subject: [PATCH v2 08/19] btrfs: repair: use __bio_add_page for adding single page
Date:   Thu, 30 Mar 2023 03:43:50 -0700
Message-Id: <92c80a1b14a7f9cab366cce2e7c5778de5e0d6d3.1680172791.git.johannes.thumshirn@wdc.com>
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

The btrfs repair bio submission code uses bio_add_page() to add a page to
a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 726592868e9c..73220a219c91 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -224,7 +224,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
 				      &btrfs_repair_bioset);
 	repair_bio->bi_iter.bi_sector = failed_bbio->saved_iter.bi_sector;
-	bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
+	__bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
 
 	repair_bbio = btrfs_bio(repair_bio);
 	btrfs_bio_init(repair_bbio, failed_bbio->inode, NULL, fbio);
-- 
2.39.2

