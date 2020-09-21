Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20865271D6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIUII5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUIH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:07:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFBBC0613D1;
        Mon, 21 Sep 2020 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H8hk1GyqLuto/InuvfMfeFX2w3KpymgO3wY2UL3PIN8=; b=OKzekSWMOFLiy8XYn1TMxhALGt
        kRwgcpt0XYJtc4V7goE8WN4kaWcf7VsU/DFo/mAkua8a7pws37JcPIVTkuFw2WkZBdIyHBHyRZ2Hl
        efRKIiqeDB2TDhhWi8CpKEpSfJyRPhs8UcqISd/axMnNchEUg9Cm8+7G67A7XD4cU96M5jjfVZ/rt
        XcgN1XSNDcvDP2Y3SPnOwN7Wyx21+TVNlmtFsfVJqcKtPOVAX69npI5mrRWRG84EPrfggMTd0PcmE
        zWYXkKH0EXUeKsXkGTTY+M1S2w8T9sJxZ/00RwrunzS6vvZ+Za1E42Whoh3pbBv9UzNVjlvdDW4Mv
        BzaU75ZA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKGrL-0006XE-BX; Mon, 21 Sep 2020 08:07:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/13] md: update the optimal I/O size on reshape
Date:   Mon, 21 Sep 2020 10:07:27 +0200
Message-Id: <20200921080734.452759-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921080734.452759-1-hch@lst.de>
References: <20200921080734.452759-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The raid5 and raid10 drivers currently update the read-ahead size,
but not the optimal I/O size on reshape.  To prepare for deriving the
read-ahead size from the optimal I/O size make sure it is updated
as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid10.c | 22 ++++++++++++++--------
 drivers/md/raid5.c  | 10 ++++++++--
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index e8fa327339171c..9956a04ac13bd6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3703,10 +3703,20 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return ERR_PTR(err);
 }
 
+static void raid10_set_io_opt(struct r10conf *conf)
+{
+	int raid_disks = conf->geo.raid_disks;
+
+	if (!(conf->geo.raid_disks % conf->geo.near_copies))
+		raid_disks /= conf->geo.near_copies;
+	blk_queue_io_opt(conf->mddev->queue, (conf->mddev->chunk_sectors << 9) *
+			 raid_disks);
+}
+
 static int raid10_run(struct mddev *mddev)
 {
 	struct r10conf *conf;
-	int i, disk_idx, chunk_size;
+	int i, disk_idx;
 	struct raid10_info *disk;
 	struct md_rdev *rdev;
 	sector_t size;
@@ -3742,18 +3752,13 @@ static int raid10_run(struct mddev *mddev)
 	mddev->thread = conf->thread;
 	conf->thread = NULL;
 
-	chunk_size = mddev->chunk_sectors << 9;
 	if (mddev->queue) {
 		blk_queue_max_discard_sectors(mddev->queue,
 					      mddev->chunk_sectors);
 		blk_queue_max_write_same_sectors(mddev->queue, 0);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-		blk_queue_io_min(mddev->queue, chunk_size);
-		if (conf->geo.raid_disks % conf->geo.near_copies)
-			blk_queue_io_opt(mddev->queue, chunk_size * conf->geo.raid_disks);
-		else
-			blk_queue_io_opt(mddev->queue, chunk_size *
-					 (conf->geo.raid_disks / conf->geo.near_copies));
+		blk_queue_io_min(mddev->queue, mddev->chunk_sectors << 9);
+		raid10_set_io_opt(conf);
 	}
 
 	rdev_for_each(rdev, mddev) {
@@ -4727,6 +4732,7 @@ static void end_reshape(struct r10conf *conf)
 		stripe /= conf->geo.near_copies;
 		if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
 			conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
+		raid10_set_io_opt(conf);
 	}
 	conf->fullsync = 0;
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 225380efd1e24f..9a7d1250894ef1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7232,6 +7232,12 @@ static int only_parity(int raid_disk, int algo, int raid_disks, int max_degraded
 	return 0;
 }
 
+static void raid5_set_io_opt(struct r5conf *conf)
+{
+	blk_queue_io_opt(conf->mddev->queue, (conf->chunk_sectors << 9) *
+			 (conf->raid_disks - conf->max_degraded));
+}
+
 static int raid5_run(struct mddev *mddev)
 {
 	struct r5conf *conf;
@@ -7521,8 +7527,7 @@ static int raid5_run(struct mddev *mddev)
 
 		chunk_size = mddev->chunk_sectors << 9;
 		blk_queue_io_min(mddev->queue, chunk_size);
-		blk_queue_io_opt(mddev->queue, chunk_size *
-				 (conf->raid_disks - conf->max_degraded));
+		raid5_set_io_opt(conf);
 		mddev->queue->limits.raid_partial_stripes_expensive = 1;
 		/*
 		 * We can only discard a whole stripe. It doesn't make sense to
@@ -8115,6 +8120,7 @@ static void end_reshape(struct r5conf *conf)
 						   / PAGE_SIZE);
 			if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
 				conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
+			raid5_set_io_opt(conf);
 		}
 	}
 }
-- 
2.28.0

