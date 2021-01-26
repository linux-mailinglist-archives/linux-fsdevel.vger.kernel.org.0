Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5403A30421B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406172AbhAZPSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406165AbhAZPSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:18:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42CC061A31;
        Tue, 26 Jan 2021 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BHMYrIZChAL94/n3vke3x6oFzyJ8B32MBvCjMF88fZE=; b=tXXHDJVdVvzYbTZuPz+vJ3gRhW
        jTyCl6y3lR/FgMqfGC0lVlhwXd94x5vhpKZBrNHoOqTtI3LV3teXJVAaz7w8cPfWP4VkrJGte08SF
        9Q6bSGsBok6JddSpN1RFCvTMrsHZfRmmZx8zWVHDObMHKfpEOCTtzX/hMVvUGsgnztpcxkrjTiU8e
        9ZKf1w5OZ1Gg5GprmibourOhlPUC0iQXmI52+b0qHt50lICpjBVyWtje5ywxovoTUmjlO9zK8JOEp
        t3VJw8M1t3EG47qkxdW9FhyheKUWMulLMx0s0ramrZJVQ7jZKzhjeeBFDXHW6ml0AF/49zKUsC4C+
        WYc0/Kkg==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Pzl-005nol-TW; Tue, 26 Jan 2021 15:11:23 +0000
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
Subject: [PATCH 11/17] md: remove bio_alloc_mddev
Date:   Tue, 26 Jan 2021 15:52:41 +0100
Message-Id: <20210126145247.1964410-12-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_alloc_mddev is never called with a NULL mddev, and ->bio_set is
initialized in md_run, so it always must be initialized as well.  Just
open code the remaining call to bio_alloc_bioset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c     | 12 +-----------
 drivers/md/md.h     |  2 --
 drivers/md/raid1.c  |  2 +-
 drivers/md/raid10.c |  2 +-
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7d1bb24add3107..e2b9dbb6e888f6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -340,16 +340,6 @@ static int start_readonly;
  */
 static bool create_on_open = true;
 
-struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
-			    struct mddev *mddev)
-{
-	if (!mddev || !bioset_initialized(&mddev->bio_set))
-		return bio_alloc(gfp_mask, nr_iovecs);
-
-	return bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
-}
-EXPORT_SYMBOL_GPL(bio_alloc_mddev);
-
 static struct bio *md_bio_alloc_sync(struct mddev *mddev)
 {
 	if (!mddev || !bioset_initialized(&mddev->sync_set))
@@ -613,7 +603,7 @@ static void submit_flushes(struct work_struct *ws)
 			atomic_inc(&rdev->nr_pending);
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
-			bi = bio_alloc_mddev(GFP_NOIO, 0, mddev);
+			bi = bio_alloc_bioset(GFP_NOIO, 0, &mddev->bio_set);
 			bi->bi_end_io = md_end_flush;
 			bi->bi_private = rdev;
 			bio_set_dev(bi, rdev->bdev);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index f13290ccc1c248..bcbba1b5ec4a71 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -742,8 +742,6 @@ extern void md_rdev_clear(struct md_rdev *rdev);
 extern void md_handle_request(struct mddev *mddev, struct bio *bio);
 extern void mddev_suspend(struct mddev *mddev);
 extern void mddev_resume(struct mddev *mddev);
-extern struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
-				   struct mddev *mddev);
 
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3b19141cdb4bc2..d2378765dc154f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1104,7 +1104,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 	int i = 0;
 	struct bio *behind_bio = NULL;
 
-	behind_bio = bio_alloc_mddev(GFP_NOIO, vcnt, r1_bio->mddev);
+	behind_bio = bio_alloc_bioset(GFP_NOIO, vcnt, &r1_bio->mddev->bio_set);
 	if (!behind_bio)
 		return;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index be8f14afb6d143..e1eefbec15d444 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4531,7 +4531,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		return sectors_done;
 	}
 
-	read_bio = bio_alloc_mddev(GFP_KERNEL, RESYNC_PAGES, mddev);
+	read_bio = bio_alloc_bioset(GFP_KERNEL, RESYNC_PAGES, &mddev->bio_set);
 
 	bio_set_dev(read_bio, rdev->bdev);
 	read_bio->bi_iter.bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
-- 
2.29.2

