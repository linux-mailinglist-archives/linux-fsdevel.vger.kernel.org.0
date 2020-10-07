Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A1285BCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgJGJUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 05:20:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33865 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgJGJUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602062415; x=1633598415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mVXJD/HmBXUaYpJmBbZLOsC8B5CT7o9dSHz18WsTBTc=;
  b=eoxDmeokIVo4lT3DDq1pV+qzXG1DvCUSuoAoyNOsJJNZIO/keNaKxRoB
   n+a5X4CU2R6YnesoNWKeM4i2+7PMaM1TLlAdCijVJ/A4IbN48PGOsCg1s
   yed0eYxVU1ttDuhIBPZrt27yYYLfc5z51esaNYUS6Iv8eQB2BUgGyoTky
   OHEkqf31kfTfBaH+FOE3NVmbDebculBZbugjXYwp/OCXsz1Gkic/gY8o9
   Yz+b2PNEkWIjkh5BylUhGb+8bJ1H8aXuhEvC9nEZ6PZWrkpqZT037V+5j
   p4JHW6UAc9xUXjMZ8wC5pWF6p0DfhR64qrpYWvVjr+clwdnoMs/HE+nBp
   A==;
IronPort-SDR: bzjQ4W5P1tJHI+POUaYuJlsBSMhVCAafeU1RdaiEBVnMsF2I/8c7EHVYfa/ckn6N8DBaQ8rRXd
 OGuFzTIxrUhnp/NvXv4UWM8p6zx+m8NfRbe3JvXLmVIpg5WhS2EPYC9uniobJb37M+lKW5XF5F
 bwIcYNIpa4VU57lUF+7IN/X/PCBA3HR9kpGqPi13EoVhd+bTLTB1JmL+OLwaKR52zE2cp1h9Pb
 rAdm5iHvlSZpTi1OmUsGt3j4QNjocjNvXhuUweZ1bEaW0H75ZU7559qQJ0yaAYjwFFBBnFgvug
 Lps=
X-IronPort-AV: E=Sophos;i="5.77,346,1596470400"; 
   d="scan'208";a="149317682"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 17:20:15 +0800
IronPort-SDR: xEwFrTzpufW/QOgDjkWGmbnobEGC3jpvVCw4bhjzC0JtiqMq/cLZObQleRHPkOv0W11a1qDkvH
 L1fTA1tTnZhw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 02:06:04 -0700
IronPort-SDR: r4kM4InNEEBYrVaYRbj3eDNt1IZnjRKUatK6JfPH4+a1n7AHPAjbE1+ey93M59C4K0MVR2PFND
 MLZKuZXusU2Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Oct 2020 02:20:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block: soft limit zone-append sectors as well
Date:   Wed,  7 Oct 2020 18:20:05 +0900
Message-Id: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Martin rightfully noted that for normal filesystem IO we have soft limits
in place, to prevent them from getting too big and not lead to
unpredictable latencies. For zone append we only have the hardware limit
in place.

Cap the max sectors we submit via zone-append to the maximal number of
sectors if the second limit is lower.

Link: https://lore.kernel.org/linux-btrfs/yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com
Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blkdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cf80e61b4c5e..967cd76f16d4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1406,7 +1406,10 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 
 static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)
 {
-	return q->limits.max_zone_append_sectors;
+
+	struct queue_limits *l = q->limits;
+
+	return min(l->max_zone_append_sectors, l->max_sectors);
 }
 
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
-- 
2.26.2

