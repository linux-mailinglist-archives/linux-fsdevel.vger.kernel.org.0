Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629661BBB71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD1KqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15223 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgD1KqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070776; x=1619606776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OotE6pqUikz4fX/C7TWHfmvpf8MWIAKkCX/1em+dRcA=;
  b=lL2G0vT4w7UE0jt4HgDxeJXgIjfa7a8QjW9OGJZvlXpTTjoxcTwolMOc
   pBwBXVrumClY9Vuu0K66urRbAZGfy3gcmjR/RSmCQsR0UNA/e1xI9A4hN
   hI99CoIjF77DpTNrwXFwiHSek57hRzzr+D/yGFNMhY/Su1kXg/ceT4KVV
   wy17dsAKPRWqHEJ54P8q7E1NdXZNfXBS1SqICy0BAQPPTB3nSCMl/kxWD
   4tbKRkbfMmY6ibgdUGp8vD0anufEDjEI4LIhkoxiDb8FxFuHu6mQckk7v
   Lh6iof/jM2p3sS/Ag4PU0uwcPG9bsUzmc8LKZrWJqFqaaWgaH4kr7wRhx
   w==;
IronPort-SDR: ytD9M5Za8g1tne2pboPWKEjwsg8I1KNQidzaQUWGsgK48TQAEMCrs6bkoh69XIs7fh7SeLK+qC
 ztApW1XhnIh/o4Fp8K5523TNSPiAxFpwv/jQvX2FsTI3yLort+zIdbctonzSL3gj1o/SJvOb1C
 BYFqE8GD4xiTWDSyXmBlMvGochyZ+gAKMHe2zksjGUj8QZUujgbz6zCah2Hv4FrbBFzciw33s/
 sOwwJKFCWJZ139eJTOp/n0vGy70TjttzXCWXPq6abT1zar0uUDga17HCt9GU+NVoP9pShZzLmX
 KFo=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886563"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:15 +0800
IronPort-SDR: QCBSmqvDfRDenoZ1v0PXrXkZzEsO+Kdc5bMrkTQxzKvlw6Y4CXiYqazmgZ+cCqtq+6xc2pMhQx
 kuaD+eOokgeiNPF+uaOVLf6Zf4TyCTaF0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:21 -0700
IronPort-SDR: T8N/NxZc27RfXCWYVi1meJFAguS1D23vvCzSQ94yjCPgZL9hlyRB2V/jXv94Kdc4lDm45xamgt
 BwGc1HAG4hGQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:11 -0700
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
Subject: [PATCH v9 02/11] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Tue, 28 Apr 2020 19:45:56 +0900
Message-Id: <20200428104605.8143-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
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

