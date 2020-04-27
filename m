Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7E1BA251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD0LcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54634 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgD0LcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987127; x=1619523127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0yhvLDJUwiJge4/uFegnU0GkbTWmfRbF5rAyH2r0ed4=;
  b=ZWZz1t7vNbjB1zQVNKx09L6zrY249srml90+UBaq+qgxkSioKQkfEMFb
   4987ZhkcTHHluP9cPixRudLrigoMIziyWMOi2nmEWgy557cHINALKSKNJ
   ICdpUi3f6iub+2MIKElJAOOClWRaTPEfiQ73m/+pL+TLCGnkChS4D9j4N
   u5KZ8S2t/zKpZYUtB877rwO6P6Q2BvUwMi41qBRHBlYPOjbsAY8mh07Lb
   YMY1AkwfwxUkNOa7wPZnK3bkCnBg6Luxlx5UhM3TGDpCzh63goFU97Zxd
   0cGpqiui5qvGyY4nu4sEpF8siLHlHW8QLH7Pxq7a4NN8rmGEeHTPcVPbx
   g==;
IronPort-SDR: H2I65gVDsGVH8tjXGZsLG0oV3Tez6s4kNH/uFrRCCnJAyQhOWvqf7kaPrOSkOaTrPp9ppCWHbp
 f5MQEfd6Nx+/qv/FYtRFup0VfDf19xo9YYQexqOHo8APtr5K+mHfjOPmbH8+sZgMNTVMHWMQOj
 GBtfOnqzx9GcF1Y6GjzynlmW6nTKrgQB4vxFK+2Gy/uMA3QRCdjwk82x8W7fy0VLNe2yhH032p
 aiFNS+eHM7zn0Iqdvi/YFMteTwm11EzRUo7DZlqJlJo9XY+FnJ/8LGmRGavV4dGxsYBkgLUSbp
 vIU=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136551980"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:06 +0800
IronPort-SDR: 9gMprIiqpI2BO2scJWodgFW8C4JtCp18ZS8Svaq+Yjscfy7EjYecGeSr2yM5X7vyexKawlJrXp
 kZnYgKNQFbMhPXRNMAZdaJAq6LXvkFC+g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:22:48 -0700
IronPort-SDR: /t7yFq2q3LNGqqx9TO+QJfAQWHOg1GUe2YCcL9TC80rTrByTkd23TgeQywwuD7CAweJysmelpG
 DjklqH6iqA4A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:05 -0700
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
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v8 02/11] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Mon, 27 Apr 2020 20:31:44 +0900
Message-Id: <20200427113153.31246-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called with
CONFIG_BLK_DEV_ZONED disabled until now.

The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f00bd4042295..91c6e413bf6b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -721,6 +721,16 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 {
 	return 0;
 }
+static inline bool blk_queue_zone_is_seq(struct request_queue *q,
+					 sector_t sector)
+{
+	return false;
+}
+static inline unsigned int blk_queue_zone_no(struct request_queue *q,
+					     sector_t sector)
+{
+	return 0;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 static inline bool rq_is_sync(struct request *rq)
-- 
2.24.1

