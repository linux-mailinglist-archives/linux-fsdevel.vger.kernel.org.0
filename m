Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB184E4394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiCVP6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiCVP6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687C6E286;
        Tue, 22 Mar 2022 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a8yqpXlo3PLdAN/i0y52NyPSySH/SeyLcNn3B6zCdoA=; b=nLW+ZVBaDVjH1C4NJNZEhknvtQ
        X9BQL+JH/Q2It8nQTbvppX3WXsW2FbSjSM7Du81Ky0R1CToYEe0xQBEoW4YHzPA48DVYXlGXd3Bqh
        ZrrPDnFC7xYjs6nNhWqijTBbeSaoiRFZa9nIv+LHvwIJCs6org0K2xXrjVS5EEZzpxtIAjQP7Nkt1
        Y5FxK17lkF+GRwjz62EnR7uVq2GOux2U5Ur3LFOUfOodb7BF9O1YMGtKQvAtK5f8BCajmONASLpIi
        ljhMDoTsxD9u2ae3dEiJ34LBUz+fFUc1LbVFac0fQCAeq1djfHfN/rnT4xt2lx54TrN6lrDaTRsOe
        yjPcXBDA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsT-00Bap6-RD; Tue, 22 Mar 2022 15:56:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/40] btrfs: defer I/O completion based on the btrfs_raid_bio
Date:   Tue, 22 Mar 2022 16:55:45 +0100
Message-Id: <20220322155606.1267165-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of attaching a an extra allocation an indirect call to each
low-level bio issued by the RAID code, add a btrfs_work to struct
btrfs_raid_bio and only defer the per-rbio completion action.  The
per-bio action for all the I/Os are trivial and can be safely done
from interrupt context.

As a nice side effect this also allows sharing the boilerplate code
for the per-bio completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c |   6 +--
 fs/btrfs/disk-io.h |   1 -
 fs/btrfs/raid56.c  | 110 +++++++++++++++++++--------------------------
 3 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9b8ee74144910..dc497e17dcd06 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -740,14 +740,10 @@ static void end_workqueue_bio(struct bio *bio)
 			wq = fs_info->endio_meta_write_workers;
 		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
 			wq = fs_info->endio_freespace_worker;
-		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
-			wq = fs_info->endio_raid56_workers;
 		else
 			wq = fs_info->endio_write_workers;
 	} else {
-		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
-			wq = fs_info->endio_raid56_workers;
-		else if (end_io_wq->metadata)
+		if (end_io_wq->metadata)
 			wq = fs_info->endio_meta_workers;
 		else
 			wq = fs_info->endio_workers;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5e8bef4b7563a..2364a30cd9e32 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -21,7 +21,6 @@ enum btrfs_wq_endio_type {
 	BTRFS_WQ_ENDIO_DATA,
 	BTRFS_WQ_ENDIO_METADATA,
 	BTRFS_WQ_ENDIO_FREE_SPACE,
-	BTRFS_WQ_ENDIO_RAID56,
 };
 
 static inline u64 btrfs_sb_offset(int mirror)
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0c96e91e9ee03..69e45e14a0b39 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -145,6 +145,9 @@ struct btrfs_raid_bio {
 	atomic_t stripes_pending;
 
 	atomic_t error;
+
+	struct btrfs_work end_io_work;
+
 	/*
 	 * these are two arrays of pointers.  We allocate the
 	 * rbio big enough to hold them both and setup their
@@ -1428,15 +1431,7 @@ static void set_bio_pages_uptodate(struct bio *bio)
 		SetPageUptodate(bvec->bv_page);
 }
 
-/*
- * end io for the read phase of the rmw cycle.  All the bios here are physical
- * stripe bios we've read from the disk so we can recalculate the parity of the
- * stripe.
- *
- * This will usually kick off finish_rmw once all the bios are read in, but it
- * may trigger parity reconstruction if we had any errors along the way
- */
-static void raid_rmw_end_io(struct bio *bio)
+static void raid56_bio_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 
@@ -1449,21 +1444,33 @@ static void raid_rmw_end_io(struct bio *bio)
 
 	if (!atomic_dec_and_test(&rbio->stripes_pending))
 		return;
+	btrfs_queue_work(rbio->bioc->fs_info->endio_raid56_workers,
+			 &rbio->end_io_work);
+}
 
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		goto cleanup;
+/*
+ * End io handler for the read phase of the rmw cycle.  All the bios here are
+ * physical stripe bios we've read from the disk so we can recalculate the
+ * parity of the stripe.
+ *
+ * This will usually kick off finish_rmw once all the bios are read in, but it
+ * may trigger parity reconstruction if we had any errors along the way
+ */
+static void raid56_rmw_end_io_work(struct btrfs_work *work)
+{
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, end_io_work);
+
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
+		rbio_orig_end_io(rbio, BLK_STS_IOERR);
+		return;
+	}
 
 	/*
-	 * this will normally call finish_rmw to start our write
-	 * but if there are any failed stripes we'll reconstruct
-	 * from parity first
+	 * This will normally call finish_rmw to start our write but if there
+	 * are any failed stripes we'll reconstruct from parity first.
 	 */
 	validate_rbio_for_rmw(rbio);
-	return;
-
-cleanup:
-
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
 }
 
 /*
@@ -1537,11 +1544,9 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 * touch it after that.
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
+	btrfs_init_work(&rbio->end_io_work, raid56_rmw_end_io_work, NULL, NULL);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_rmw_end_io;
-
-		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
@@ -1980,25 +1985,13 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 }
 
 /*
- * This is called only for stripes we've read from disk to
- * reconstruct the parity.
+ * This is called only for stripes we've read from disk to reconstruct the
+ * parity.
  */
-static void raid_recover_end_io(struct bio *bio)
+static void raid_recover_end_io_work(struct btrfs_work *work)
 {
-	struct btrfs_raid_bio *rbio = bio->bi_private;
-
-	/*
-	 * we only read stripe pages off the disk, set them
-	 * up to date if there were no errors
-	 */
-	if (bio->bi_status)
-		fail_bio_stripe(rbio, bio);
-	else
-		set_bio_pages_uptodate(bio);
-	bio_put(bio);
-
-	if (!atomic_dec_and_test(&rbio->stripes_pending))
-		return;
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, end_io_work);
 
 	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
 		rbio_orig_end_io(rbio, BLK_STS_IOERR);
@@ -2082,11 +2075,10 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 * touch it after that.
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
+	btrfs_init_work(&rbio->end_io_work, raid_recover_end_io_work,
+			NULL, NULL);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_recover_end_io;
-
-		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 
@@ -2445,8 +2437,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	atomic_set(&rbio->stripes_pending, nr_data);
 
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_write_end_io;
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 	return;
@@ -2534,24 +2525,14 @@ static void validate_rbio_for_parity_scrub(struct btrfs_raid_bio *rbio)
  * This will usually kick off finish_rmw once all the bios are read in, but it
  * may trigger parity reconstruction if we had any errors along the way
  */
-static void raid56_parity_scrub_end_io(struct bio *bio)
+static void raid56_parity_scrub_end_io_work(struct btrfs_work *work)
 {
-	struct btrfs_raid_bio *rbio = bio->bi_private;
-
-	if (bio->bi_status)
-		fail_bio_stripe(rbio, bio);
-	else
-		set_bio_pages_uptodate(bio);
-
-	bio_put(bio);
-
-	if (!atomic_dec_and_test(&rbio->stripes_pending))
-		return;
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, end_io_work);
 
 	/*
-	 * this will normally call finish_rmw to start our write
-	 * but if there are any failed stripes we'll reconstruct
-	 * from parity first
+	 * This will normally call finish_rmw to start our write, but if there
+	 * are any failed stripes we'll reconstruct from parity first
 	 */
 	validate_rbio_for_parity_scrub(rbio);
 }
@@ -2621,11 +2602,10 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 * touch it after that.
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
+	btrfs_init_work(&rbio->end_io_work, raid56_parity_scrub_end_io_work,
+			NULL, NULL);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid56_parity_scrub_end_io;
-
-		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
-- 
2.30.2

