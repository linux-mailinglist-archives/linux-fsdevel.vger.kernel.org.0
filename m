Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70201ADD13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgDQMPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:15:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50639 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgDQMPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125751; x=1618661751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rp/9OsypQVA9Jov9x+82RNHkk+PbM/KfEuomMQ2uw8w=;
  b=Qolbq8Lo9uOHddaxWJNvb71ix03dASDl4c9h1RPXNQUs1ICmuwsxptWC
   v0hR9PHJeQWZAWJHZMlLyMUReM+DRIYSNS/KRDc0AsjBuFcOVpAPUMe3J
   HaSYAeHL31YVLdqWLeS6lgp71fxEe/Efi7GXBd+AWI2/5lR7TaR4RMvEW
   p831rnKXoFBM9LFgSqfCTdL/F8t3YvsnoGwvVGshyjMaik1T82aQlXPe6
   Z/QYMstRxHw7zxbRceIR7ofa0X3NxvQkY4JMEYJnIuXjNI42m3E+8jIVV
   ubqJaPbyNmXX1iUol34y7w0UkGRRjlcrtdEAJm4JqKwJAMaw1M1223mIo
   w==;
IronPort-SDR: F5YNONMjzsKj6GMFWTMS9jJdaj5/ObJzbxPp6AlX3age/yZ7TAAdY9X3u0wlDdgUYWNJPfOs4E
 rkzZMrlyTLhX9q2hGTDF8qoRNj+8GR4HlA02lmo68FpcKG9X7YsBrPKsafa9Dhu3ES2S0JUBMy
 U3LW5HjoHb3nbtboFvmnpzEA236MPI9viEFv2m9laNBz2AuBbkrQidRUlL1F9gie1fPvSD/YeB
 3eSavtCgqJkNyWO23hkbGpmHDGTrWg1uocy/Y0QH9wL4qh5jWe5GJNzSBV/A0QfqIKyEAwuBzp
 M5M=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989190"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:15:51 +0800
IronPort-SDR: jiBKecB7tyb+aekJxEz+GK3o0vsgqdn4AKHx4UPErX9LK/7Qqvcq2XAOiF5tVpOk2IO+LsJpSl
 DavzO606E0dAUgjriIOglrw/8OYCJyShM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:06:48 -0700
IronPort-SDR: z4sZFldNIYr7WM9G1Ho96dYm8aPmzCNCl/euZB8zO80kJJ9s+EX37MB8H6vvXtwvPNsjM72tkH
 cdJrzMk+0GrA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:15:48 -0700
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
Subject: [PATCH v7 02/11] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Fri, 17 Apr 2020 21:15:27 +0900
Message-Id: <20200417121536.5393-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
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
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..e47888a7d80b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -729,6 +729,16 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
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

