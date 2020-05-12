Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950E81CEFA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgELI4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16012 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELI4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273765; x=1620809765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YWXANu2tzSwd2q0J4374R6vpioY6gmSMC2fMgiiszi8=;
  b=Od/t/O434QtETjOQz1jBQ/RPFHYA5oJfiiB+drW9QTZ4ggKljYntYTC4
   qKT7LtSF8B+DEPEqq6krpTRevi3vvH0hSeqwrT5Oof0GUK0ATgdL1gN3Z
   Y5wTMNvyPvjDshoPFJ0ne2tBO2f2x9BRS6Z/MuseCOTbq5g7rX5hS5f/T
   yulxJ/1Si92w9uyctIWy52fOZd5jaGhs90eiTzcCz8tqmPLD6pAvFScLo
   F27RBQ4UWyBaCbBaucne9v/1hKGZYWtEwA2SrG8encR811Af7YZRpzYtY
   e6jN9TEK3xl+QvyxwgooYhcZT4BdvsdWFA13bcSY8+xckjzwDumCR+cHu
   A==;
IronPort-SDR: ziwTGvV/u4nL3Iuv+zqgvDPrRY+Kq2PoWh2AZE+kzleTQcFRpw4bdrr2rNM73mMoxc7x9JMdQe
 iTp2Di4l81xJSuW0hV/ecgIIdVjXhNAMqM2njVwyw90jVareQ8i0sS7HAX5MgZJwEDk2qXEczL
 GCR8C6ki69myke1AnfAicZ5IpIx0NVuk1KF5A7MNhmAjMrmoQ6fNC/z/3YOWUNDDN448mMzGN3
 97NMZFqRomhrBhc6rKr0oyOm8amQ/KL6BzfZX2NKOPZprqgWtzpH4hUQTrLhTDIIaIEAOxjwTD
 aKY=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823527"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:05 +0800
IronPort-SDR: 8FLTNUwhTf7AzU7uDbJM7NiFUDRQAZPUvSXicZWHqXg0p3nL1hL95c/BXFbNdMpTUBBwjHtWWF
 LFOKLj7nYJ320BnVdP7MjZLaOrWgkOAM4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:45:47 -0700
IronPort-SDR: T/Il2f6XwNF00+XvPCJA4OUTvzFgNMT3F50auizYj+VWSaaVXaTigJDyflOVFnum+JmH7kxmlN
 HOMQYu4wnvWw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:02 -0700
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
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v11 01/10] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Tue, 12 May 2020 17:55:45 +0900
Message-Id: <20200512085554.26366-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

