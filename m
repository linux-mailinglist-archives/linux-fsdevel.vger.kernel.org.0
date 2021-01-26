Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7594C304248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391796AbhAZPXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406330AbhAZPW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:22:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48CC061A29;
        Tue, 26 Jan 2021 07:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f0VB07mdqOWmqrSUWksOrW1/tOJIZooJI1RGwrnSP1g=; b=wYGytAGz504DGBR0OQvEpSGo49
        2JdJ3gnCfCQl1vwNpmdVhDxHbx+ZmO0AnoppdLH4OS7wuSWjiTRLFcAdIsHiIiaaGhcFJpdnDwdDD
        Qd1JnCAwW6br1SDLkqBeyRwDqUbw5gNqXxt5KDFpCodoxq6hkP1X4WXCAwl0X208GB/Q8MyX3OGZV
        w45G0QGuCRcfbcuzk2uK6tgo9j0HRaREGMAvY/f8RxriCxk2j+sxH/hcXgvMowOXL5t+95RBtSIL9
        94mzmX/aWv0W4VcAok5uc1g5wTmUXSGYr7X1JCQqdSPgz47uJEitWn/3NozsKFWnQ3tSwLSAt5eXw
        MVD8d2Hg==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Q5i-005oNB-Sc; Tue, 26 Jan 2021 15:17:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/17] md/raid6: refactor raid5_read_one_chunk
Date:   Tue, 26 Jan 2021 15:52:44 +0100
Message-Id: <20210126145247.1964410-15-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor raid5_read_one_chunk so that all simple checks are done
before allocating the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 108 +++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f411b9e5c332f4..a348b2adf2a9f9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5393,90 +5393,72 @@ static void raid5_align_endio(struct bio *bi)
 static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 {
 	struct r5conf *conf = mddev->private;
-	int dd_idx;
-	struct bio* align_bi;
+	struct bio *align_bio;
 	struct md_rdev *rdev;
-	sector_t end_sector;
+	sector_t sector, end_sector, first_bad;
+	int bad_sectors, dd_idx;
 
 	if (!in_chunk_boundary(mddev, raid_bio)) {
 		pr_debug("%s: non aligned\n", __func__);
 		return 0;
 	}
-	/*
-	 * use bio_clone_fast to make a copy of the bio
-	 */
-	align_bi = bio_clone_fast(raid_bio, GFP_NOIO, &mddev->bio_set);
-	if (!align_bi)
-		return 0;
-	/*
-	 *   set bi_end_io to a new function, and set bi_private to the
-	 *     original bio.
-	 */
-	align_bi->bi_end_io  = raid5_align_endio;
-	align_bi->bi_private = raid_bio;
-	/*
-	 *	compute position
-	 */
-	align_bi->bi_iter.bi_sector =
-		raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector,
-				     0, &dd_idx, NULL);
 
-	end_sector = bio_end_sector(align_bi);
+	sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
+				      &dd_idx, NULL);
+	end_sector = bio_end_sector(raid_bio);
+
 	rcu_read_lock();
+	if (r5c_big_stripe_cached(conf, sector))
+		goto out_rcu_unlock;
+
 	rdev = rcu_dereference(conf->disks[dd_idx].replacement);
 	if (!rdev || test_bit(Faulty, &rdev->flags) ||
 	    rdev->recovery_offset < end_sector) {
 		rdev = rcu_dereference(conf->disks[dd_idx].rdev);
-		if (rdev &&
-		    (test_bit(Faulty, &rdev->flags) ||
+		if (!rdev)
+			goto out_rcu_unlock;
+		if (test_bit(Faulty, &rdev->flags) ||
 		    !(test_bit(In_sync, &rdev->flags) ||
-		      rdev->recovery_offset >= end_sector)))
-			rdev = NULL;
+		      rdev->recovery_offset >= end_sector))
+			goto out_rcu_unlock;
 	}
 
-	if (r5c_big_stripe_cached(conf, align_bi->bi_iter.bi_sector)) {
-		rcu_read_unlock();
-		bio_put(align_bi);
+	atomic_inc(&rdev->nr_pending);
+	rcu_read_unlock();
+
+	align_bio = bio_clone_fast(raid_bio, GFP_NOIO, &mddev->bio_set);
+	bio_set_dev(align_bio, rdev->bdev);
+	align_bio->bi_end_io = raid5_align_endio;
+	align_bio->bi_private = raid_bio;
+	align_bio->bi_iter.bi_sector = sector;
+
+	raid_bio->bi_next = (void *)rdev;
+
+	if (is_badblock(rdev, sector, bio_sectors(align_bio), &first_bad,
+			&bad_sectors)) {
+		bio_put(align_bio);
+		rdev_dec_pending(rdev, mddev);
 		return 0;
 	}
 
-	if (rdev) {
-		sector_t first_bad;
-		int bad_sectors;
-
-		atomic_inc(&rdev->nr_pending);
-		rcu_read_unlock();
-		raid_bio->bi_next = (void*)rdev;
-		bio_set_dev(align_bi, rdev->bdev);
-
-		if (is_badblock(rdev, align_bi->bi_iter.bi_sector,
-				bio_sectors(align_bi),
-				&first_bad, &bad_sectors)) {
-			bio_put(align_bi);
-			rdev_dec_pending(rdev, mddev);
-			return 0;
-		}
+	/* No reshape active, so we can trust rdev->data_offset */
+	align_bio->bi_iter.bi_sector += rdev->data_offset;
 
-		/* No reshape active, so we can trust rdev->data_offset */
-		align_bi->bi_iter.bi_sector += rdev->data_offset;
+	spin_lock_irq(&conf->device_lock);
+	wait_event_lock_irq(conf->wait_for_quiescent, conf->quiesce == 0,
+			    conf->device_lock);
+	atomic_inc(&conf->active_aligned_reads);
+	spin_unlock_irq(&conf->device_lock);
 
-		spin_lock_irq(&conf->device_lock);
-		wait_event_lock_irq(conf->wait_for_quiescent,
-				    conf->quiesce == 0,
-				    conf->device_lock);
-		atomic_inc(&conf->active_aligned_reads);
-		spin_unlock_irq(&conf->device_lock);
+	if (mddev->gendisk)
+		trace_block_bio_remap(align_bio, disk_devt(mddev->gendisk),
+				      raid_bio->bi_iter.bi_sector);
+	submit_bio_noacct(align_bio);
+	return 1;
 
-		if (mddev->gendisk)
-			trace_block_bio_remap(align_bi, disk_devt(mddev->gendisk),
-					      raid_bio->bi_iter.bi_sector);
-		submit_bio_noacct(align_bi);
-		return 1;
-	} else {
-		rcu_read_unlock();
-		bio_put(align_bi);
-		return 0;
-	}
+out_rcu_unlock:
+	rcu_read_unlock();
+	return 0;
 }
 
 static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
-- 
2.29.2

