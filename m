Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243EE1BBB78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgD1KqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15241 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgD1KqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070781; x=1619606781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjEiKSyX/5ExI8QU/1+6EBjmcgbu9CF+Cx+Onz15dkQ=;
  b=FxXi35eZfpMWEUgVa+mEHWWLELc3YWzt9TsJvvtcgbhKh2zbbGn3+NbK
   4fipWE9EDBEVM0fQsxSuT9hWdIFk2lnNhT/2GhJ1HJZjiS15wvu/xUMpO
   QgL86G3BgjOmzsjOKLIyqsTCck2it7LaJS8ddWXnzD+aXvybCIUE9dYJc
   7/4GTa8ni7nTtOhwm8CLkuggyHG8xpq7GGc25WiDTnVqTo4CAfH0h2ocI
   7Vu7M0LWcqVq6QnWQliusk+lUT7oSPVkTAOIBzLv7PNikVTlExWPg7ogO
   cOXL5pg1S1/9v3aKkd10j6A3guncbPwfIqf7TQtpH68LP0QNtqED+K17B
   g==;
IronPort-SDR: 7p9acuh598sH85UeSxnc6kGImaZfvlzTLga0cR2gW5F4g3FbVyp+hry93awraMBokGxI4VW8rR
 5R5pNF923lfsrLAr8DHdtu53MMQvXVLPVRoph2slgncZh3SO+hHjvLDPEcdCs4x9lgDNKNc511
 E0FBs1aJfEyaOns3LNhC9g3NyCyM9xm5HJhjcKF/maY53OhojUt3zAzOfkSLGFaKWItfxDULnA
 2wu09Q80keX0tYN5O+Olybeyl4pr85IgnrLVs84WwjeGkQdRQOVf0wDenEpHs7w2NO5lEPKHip
 D9s=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886576"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:21 +0800
IronPort-SDR: nXXDVWiNHtFOUBqf/agxSFy0yU9p6PbmIZ9Zzgv84LKe+IJ+zPCoQ+f1+WTdDBM2jwyaVp2qE6
 BXKwLsSyn6qo9t0IXhTecprPibXKAka6Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:26 -0700
IronPort-SDR: 9W5OVkKpDM4nY4E7+YZs6EfkiR+QGyBj1rNL6YkwXETRlo0ROa2/Q0Mnn8kLhtga96rFISL/DI
 ZtOLzQn71lbw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:17 -0700
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
Subject: [PATCH v9 05/11] block: introduce blk_req_zone_write_trylock
Date:   Tue, 28 Apr 2020 19:45:59 +0900
Message-Id: <20200428104605.8143-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
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

