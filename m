Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22AB1ADD1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDQMP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:15:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgDQMP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125756; x=1618661756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idI1WH8nxkPnh+O/RqijVff+VKCcvan/3RihAz7vyTw=;
  b=KjuyHPm1HBxuiYaPHs+0aPs5MxQmaFHLRRSNtD9ffer6+CkdBNKwUaqB
   fJyJrT7WQ3376mhTtCaO+7HlAd+oN72VOIV1lNz3MHLD4MBl8LF57c6hy
   3tKF+WDja0vxtbzfuMpP0lJKiXWLFYTDdyrhArM/6Sy4C8AvpPrR3sioE
   mFGvy4bUCreYONTSjMyNvkZz2J8XmpdrSjr01R06Tw5bPXYdose67qBjE
   pZO62YX7U3CpLYQJLYlonS0BntWpLY/TR6kT3JovsBIZqHa+SkGpiXHhK
   J7LDqjmCWw+RrDbm0yPC4MxDEWbmprFC5asPIYa3s4ifhbUlo4biKJKXY
   A==;
IronPort-SDR: eJhNd2b28ErsCnbRPBKJCxVa7DVFaXISphbe7+EiwSprmV/YGJ6U4oNOosfYlnmjagL1z6sm8r
 upfg1As+q4FK7okKmTLHQTaU6mGZVmTJTMEa8OY92sn+axb5wL7Xyc6SnodWHbwKK1WyvTlyJv
 gVqtamxLzaJu//tJ4wm9tSg3Ssr6hzVZcvtYdRCyi8NVpeny6A+TZ1dBZ+hU/MEd5eHs0vZapz
 DOKaB6C/QN1khCFFkrbcHbSJupuRcJsEXPgYpHXlPFeM5RKEK8IQ6MtX+TzzozzPPM5ZiwKTKS
 Ymg=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989209"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:15:56 +0800
IronPort-SDR: FOz5e14Rs4RJ5Zg5+0is7jELJPnVDNNCYq2iJTNt+ZlFLl4eC1FEoHwNDxQ86LEjK7Mm3xX/Rj
 P6O9lG1RfhXVBIdggXG8xeRjM0Y7H+JYQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:06:53 -0700
IronPort-SDR: 0erbExPLkPILObTH3yKq8aAPplNx7/l9ZZQdRXmIxlqL2N/Vr/nUymtdIK2ZEE103vTyUAOoh0
 9Ets8YGG6kyw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:15:54 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 05/11] block: introduce blk_req_zone_write_trylock
Date:   Fri, 17 Apr 2020 21:15:30 +0900
Message-Id: <20200417121536.5393-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
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
index 774947365341..0797d1e81802 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1740,6 +1740,7 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 bool blk_req_needs_zone_write_lock(struct request *rq);
+bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
 void __blk_req_zone_write_unlock(struct request *rq);
 
-- 
2.24.1

