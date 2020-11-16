Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D12B46D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgKPO7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgKPO7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD190C0613CF;
        Mon, 16 Nov 2020 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ceSruCVWzLax0XFB3PV+YChHyJOUoDTFl1AuzUG7uKo=; b=CW2g8R0fi9IlSMs6PB15CroPmB
        VwoaOYD9bMi1DVWfaTM4vlulUe111h2RI3tztOT5WMq0qsSqGFH2pFQe0NOcqNLdex+g9q4BMMVZP
        /6TuwzASGMA1SrkPTvS7l/wvEgTeWNYqEdTqZb/ZtDyfrlGP270HGrcmH7UeWoKasPCt9CokG+QBB
        a2OdxXHzodz4vx5g/ZqCX44oTJtSk/OzRCJ8dKXSw80cEaDg4gDxz1oQY0QautKMW+b4o+TDgBAIv
        i8SHCduCi7NL+7FPVx6mbW4O37u1Dt6jRtYD7qdW2goUC6ahFPGml0cbg+8h8UcWX3F//bKVJttjN
        HevPpOdA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefy7-0003wG-IY; Mon, 16 Nov 2020 14:58:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 35/78] block: cleanup del_gendisk a bit
Date:   Mon, 16 Nov 2020 15:57:26 +0100
Message-Id: <20201116145809.410558-36-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge three hidden gendisk checks into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b0f0b0cac9aa7f..8180195b76634b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -892,6 +892,9 @@ void del_gendisk(struct gendisk *disk)
 
 	might_sleep();
 
+	if (WARN_ON_ONCE(!disk->queue))
+		return;
+
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -914,20 +917,18 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
 
-	if (!(disk->flags & GENHD_FL_HIDDEN))
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-	if (disk->queue) {
+
 		/*
 		 * Unregister bdi before releasing device numbers (as they can
 		 * get reused and we'd get clashes in sysfs).
 		 */
-		if (!(disk->flags & GENHD_FL_HIDDEN))
-			bdi_unregister(disk->queue->backing_dev_info);
-		blk_unregister_queue(disk);
-	} else {
-		WARN_ON(1);
+		bdi_unregister(disk->queue->backing_dev_info);
 	}
 
+	blk_unregister_queue(disk);
+	
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		blk_unregister_region(disk_devt(disk), disk->minors);
 	/*
-- 
2.29.2

