Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE51CEFAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgELI4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16022 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgELI4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273771; x=1620809771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9S/KYy5dLV7OMmurO/YDlMGEqqAyiyisBAqUMQa/FM=;
  b=JDngQPSjjKartAbH28IOjC6urnd99D/W10ib3zn+W+T+nDX686LF5H0Q
   TIVFrRGeEVvovgj2yvPUpUUBM4DouGwQTWRlsl0bdrYKQ8nQyigfUWSzu
   SSVuTNx3BvGvYvVjgsZVEcF6uB3U07kwKdV/i62pA7O6UVnwdv7QEq0Hu
   cNrYN9tXwRIjw6o7xqR3efJGJ2+y4SHA7jNmMH/ciwh0DWFV0QriESHRW
   ycnRRQwAOQweKbpS6iCBfHesrXoKyGoDXEqM3UeVhZRW5qciK8o/doDy2
   uaSCN0h4hhZl9gi62yg72vFkpDvmMEOYH3zkGekFR1LOI6kHobf3Smzag
   g==;
IronPort-SDR: l4nNK0FkJ+GOm6L5u+7tNTnMm9YsuOy9eDeCi0BI2TdMFmkYZxw3+PLYCn92Kl7/nDwmq/tkAi
 tMyZyzID63lizrHhTlhQlWaaO9CfsNFP5GiUlsoWj/iMa01nfyRhjthxmmTcMUx4IJUW55i4Kf
 9Q82CXq5PIpRsWilt3T8CS5+S8W8/XcxGupBz5g+v43LYqBVSoMHThy/dOgJLaIqdfz6yQayCq
 E2Daz7DGHiE6kAYv1S+/DXni2FnIsYxLrI6xjeyd6OY1x5w9Q6iBK4dKOjYNkEOa8CMeAFbt77
 myY=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823547"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:11 +0800
IronPort-SDR: sGI1MCmrhWD3XdE9DM53bmQkUAsD5aJOOBd9sJl1pzFliT7r7iMIT62u3OVvwGjA/DIpa+X05t
 Oi+9bvV+NwfXVasH3CwM5E0W+/71+j5Y4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:45:53 -0700
IronPort-SDR: r6+UklOx8F4TUqAimMRNYy4eIWtvZWjIRKQOfY7RcOKgNP+fGbACTI2UEmRIM4ogStazY1o8BQ
 RtgV1llrTD0w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:08 -0700
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
Subject: [PATCH v11 04/10] block: introduce blk_req_zone_write_trylock
Date:   Tue, 12 May 2020 17:55:48 +0900
Message-Id: <20200512085554.26366-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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

