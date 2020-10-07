Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A474F285F44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgJGMfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 08:35:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28981 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgJGMfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602074116; x=1633610116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mjsoio5FDmCGi9OstamRDqY2oZ+HVDFqkJF5iO+O0a0=;
  b=li44w3RCE6vjQ8YeFldQ4Lwsb2Zfeg4M6JQRG7v62/sUXtBm2kYXDKFu
   AJklEzBMCBNw6/lWiWWo4v07y+r5/2RflfNkukvKsUUDkjSFAoVzBNZtm
   lZeegAizOiajkUO65KItknudyoMgzgkFFE+MNzjRPbO6C43JzJIuYNOfB
   juhjqFZQSZVe7DPwxdUt1xWO341F+lbFDq2ndAiHScymst5l+mHgy0M8W
   YeK09Zrx901oK9hyWa0u+1i9RgzlPAsuHwdSALG2PLYcjN46yaZ1IJt1z
   vFNNylrIrvLwL84bt1hKj8clCjdv54yormPMOVaZdzhtWVvUeSk7R8wpg
   A==;
IronPort-SDR: nGtzO1ZWbsJNJRVZM05iZ4MLxqPePzHO53ps56buMjs4uA/3sFRMCYCg08av4YKmjnUypIVyD6
 +pG7yripTZnOkQppLrOpmbTuazFatHv4vPx6wR05fNG9+K91Z/sJJ0fdY4BiyCd+yx4L56+OJl
 +4qixLnQCSI6CQntCGvAhGQpbB0WvY9zhl/JUE9PBusfbKCMJphmylj4vlH9zBlAZgT683qr4y
 40aF2iALkL0bCI/pVbfPecgQ9m6PjQU6a44ezNPEHx+4CcdAZ4xlziPl8XiphDDhhMzIyuRRbV
 Lt4=
X-IronPort-AV: E=Sophos;i="5.77,346,1596470400"; 
   d="scan'208";a="259061590"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 20:35:16 +0800
IronPort-SDR: KewiPEkYMF5zLhQTDqJc8HUFjI/0neMKbBLAhPt3I+uUb1a+kyiAeIPWNvTjqkOyCHNNRk6D3y
 hfmDav3nJXNw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 05:21:06 -0700
IronPort-SDR: NPSjAkACwFbLKfAlKAvYneQ/SdNYcYD+70Dk2mavhhH8uRm5D3h85i/+DGQXtxV7jUoMRqRILe
 9VaEFeEyGmMw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Oct 2020 05:35:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2] block: soft limit zone-append sectors as well
Date:   Wed,  7 Oct 2020 21:35:08 +0900
Message-Id: <628d87042f902553d0f27028801f857393ae225b.1602074038.git.johannes.thumshirn@wdc.com>
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
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
- Commit the compile error fix *doh*
- Add reviews

 include/linux/blkdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cf80e61b4c5e..ed52fbf1fa31 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1406,7 +1406,10 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 
 static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)
 {
-	return q->limits.max_zone_append_sectors;
+
+	const struct queue_limits *l = &q->limits;
+
+	return min(l->max_zone_append_sectors, l->max_sectors);
 }
 
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
-- 
2.26.2

