Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7571C75EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgEFQMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 12:12:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61295 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgEFQL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 12:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588781517; x=1620317517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9S/KYy5dLV7OMmurO/YDlMGEqqAyiyisBAqUMQa/FM=;
  b=mfNH2g5GPoLBU3H7UgrmEI2xpr8UyHAReVCg8yBxTmaRGBTI0XYoZbGt
   FjLrar5ednbwkeSPLiSSn4V0cjloNGlCjdv5OipSza5eE+Moa3uhhZml4
   VU0iaNrel5xAFaN7bbxAZ/inidugJN5Z4NPFit2+44JBMuc/2TvCEwAuF
   zM7bCQhaSTc8V2T8SKDFMt8wz75Su4CJqMAH0BFfg4nM8q9qaueIGM/oz
   ljVwejPun3XHDKUYJM9vS6QLgtFpqWnRHXh7gUy3PHhY7Sj54rAyiyZYr
   SCqGM8yc2+OlsyaEQvjx/JVsjfWP0bHPN8k3BiGQYY+4uOjGKwUQ4ZZxG
   w==;
IronPort-SDR: i3I9NwaVk7bbaXs8U1Rj187TZI/+LQXz7Pk6SgDcFR1zN1WlJkiblU2zpD9dITJ+srB43OPHML
 zzGEwmfsvwOG5gy1ew1bRohuN4MCV7gHun+X7VUVSXVBBOjS0dRnXoJ7s/qz9YWdrDWYyZ2NJf
 tZN37PzSX42bisccGPUORnuLlMt72m6Ekbr57UZBRW2WnEZ1vNg4kv73/GFBDOCz80MEygAZ78
 XwJu7wcoLpf/kQD/fBTIIR0LTuFp1eTacG/g4pgbvn8RD5XZWTgqEtZFu4quB+fdjQau7OIqa1
 y/0=
X-IronPort-AV: E=Sophos;i="5.73,359,1583164800"; 
   d="scan'208";a="245917893"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 00:11:57 +0800
IronPort-SDR: IlBnOC75v79L/xqOIQY5f/VJzCgd4tevv+IOzHk3sn6cYWAgFNxWk+iNl9Y5ia0IIFgvf5S9dq
 iHpI2+1L42GCVnUMJFJpOBhmhZ0Iy0xro=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 09:02:22 -0700
IronPort-SDR: fY20b7ZPeqzydX5jhkxue8GW4ruf1c7x7cFvxrX5Y+5kpc0E6K5JNVTN26x1Ym4Re0xivYcrD6
 YM5lf1D5h0fQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2020 09:11:55 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v10 3/9] block: introduce blk_req_zone_write_trylock
Date:   Thu,  7 May 2020 01:11:39 +0900
Message-Id: <20200506161145.9841-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
References: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce blk_req_zone_write_trylock(), which either grabs the write-lock
for a sequential zone or returns false, if the zone is already locked.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-zoned.c      | 14 ++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f87956e0dcaf..c822cfa7a102 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -82,6 +82,20 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
+bool blk_req_zone_write_trylock(struct request *rq)
+{
+	unsigned int zno = blk_rq_zone_no(rq);
+
+	if (test_and_set_bit(zno, rq->q->seq_zones_wlock))
+		return false;
+
+	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
+	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_req_zone_write_trylock);
+
 void __blk_req_zone_write_lock(struct request *rq)
 {
 	if (WARN_ON_ONCE(test_and_set_bit(blk_rq_zone_no(rq),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 158641fbc7cd..d6e6ce3dc656 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1737,6 +1737,7 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 bool blk_req_needs_zone_write_lock(struct request *rq);
+bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
 void __blk_req_zone_write_unlock(struct request *rq);
 
-- 
2.24.1

