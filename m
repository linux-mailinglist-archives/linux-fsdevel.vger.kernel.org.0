Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF61BA259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgD0LcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54642 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgD0LcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987132; x=1619523132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+Asya7qHD7Npi/b1f2d6pXw5nXvysaYWQfCoo6wvJM=;
  b=iC0n7xiaR+gUE2GpHnYlm+m35unH2mOn5ys1fO6FY4PsgUITnOx91P0e
   c6YEPBKKA6tfANzJNROl78VzTYOw9l2IIvXsqqloYOAlzIXBYVLvoDSZf
   n8AvShWl5KMVDQsRXnzC1VdjZ4HAL0OpMOrcYVEDyiP1mPbfKvs5VidzR
   5P6IaVnt03AKzhteI79Hjuono5WbD/LVsiu5qlyMHYI6xW1UWpRw+lfWs
   J5X9n3bU+87fMJCFMiMCfNy88qiO4eKoS+Rs7gidOcO9PRFvLavp9gl/B
   SSkMInDpAAra5CX/+/Loqk9PMgpi94jIq6e28eY5W2wPaNbfp+ghY7ma8
   g==;
IronPort-SDR: h6S2xga5WsGZPkxyn5JHxMTToyfupnkBA2BPYE+sdwmGG2glCa1yKqMKukjn/d9wPGQRpcJsfy
 cDdUr2PQ0asjJLSQSypDzpcyg1c/PTPbgbzmVKZDotQxClJtm5hqSSW2vknCkIfiNLur0SXNKv
 PKsbhfdf7ZthDNQxRNUFD2mCZ3h8MTpUivDxtgUYk5uc8sOvKGni/jlxeP8kZb69snRAI8n2Ez
 Bs8++BhUBWyk8+GRoVGfh2iVjc3OFpkXsTgKh2IC8NZy4Vs6B3Geif6Y/12XoGjCeAQMm4hVSp
 03g=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136552001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:12 +0800
IronPort-SDR: opsO3ACQ3lQftk/+QiQHuL8AURrzX/LVbZF1G1q2yJxHiZS1/Tzg1gex5+AvT78I4kPSZvLcLH
 izfN0j6u/PeQ9S177A6EHyjv3oc+6IHTc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:22:53 -0700
IronPort-SDR: NxDwttYMJ04EkqO6xyh+hk7n4BiFEf867Eiz4grSLwGBHSOk9EGwWm3WgyY7X//t+TB+ZNmz34
 Xp5kYbmx729A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:11 -0700
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 05/11] block: introduce blk_req_zone_write_trylock
Date:   Mon, 27 Apr 2020 20:31:47 +0900
Message-Id: <20200427113153.31246-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
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

