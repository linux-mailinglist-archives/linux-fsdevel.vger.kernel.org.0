Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDC367073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbhDUQqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:46:46 -0400
Received: from mx2.veeam.com ([64.129.123.6]:42084 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244389AbhDUQqk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:46:40 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 487DA42350;
        Wed, 21 Apr 2021 12:46:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1619023562; bh=+4ksYHOT7aGXjWbZBgawfNTamqurVBEje7DtePISQH4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RT+W8WBPUUAKAfHvdsSnZ2S/4wPPwesJCqmuir7z2TBj7xA1Eky1WjfQROMPxTDK1
         BVUTSVXX+He/r3AxLr/c98whBOoWVbwxuNgw5vzvmcpSEWyFuI9RWQkIRen0gTi6fZ
         QGmKMyt6ctxDOIZX5ffXfbyc+4YEef6NQ6yfeirw=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 21 Apr 2021 18:45:57 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v9 2/4] Applying the blk_interposer in the block device layer
Date:   Wed, 21 Apr 2021 19:45:43 +0300
Message-ID: <1619023545-23431-3-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
References: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59677566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to prevent the same bio request from being intercepted multiple
times, the BIO_INTERPOSED flag was added.

The blk_partition_remap() function was moved from submit_bio_checks()
to submit_bio_noacct(). This allows the interposer to receive the bio
request unchanged.

The __submit_bio() and __submit_bio_noacct_mq() functions have been
removed and their respective functionalities were merged into
submit_bio_noacct() and __submit_bio_noacct() accordingly. This allows
to process bio requests from request-based and bio-based block devices
in one common loop.

Functions bio_interposer_lock() and bio_interposer_unlock() in
submit_bio_noacct() allow to stop the receipt of new bio requests for
processing, but not lock the processing of bio requests that have been
already added to the current->bio_list. To keep the penalty for a new
lock to a minimum, percpu_rw_sem is used.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/bio.c      |   2 +
 block/blk-core.c | 194 ++++++++++++++++++++++++++---------------------
 2 files changed, 108 insertions(+), 88 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 50e579088aca..6fc9e8f395a6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -640,6 +640,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 		bio_set_flag(bio, BIO_THROTTLED);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
+	if (bio_flagged(bio_src, BIO_INTERPOSED))
+		bio_set_flag(bio, BIO_INTERPOSED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..a987daa76a79 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -735,26 +735,27 @@ static inline int bio_check_eod(struct bio *bio)
 		handle_bad_sector(bio, maxsector);
 		return -EIO;
 	}
+
+	if (unlikely(should_fail_request(bio->bi_bdev, bio->bi_iter.bi_size)))
+		return -EIO;
+
 	return 0;
 }
 
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
-static int blk_partition_remap(struct bio *bio)
+static inline void blk_partition_remap(struct bio *bio)
 {
-	struct block_device *p = bio->bi_bdev;
+	struct block_device *bdev = bio->bi_bdev;
 
-	if (unlikely(should_fail_request(p, bio->bi_iter.bi_size)))
-		return -EIO;
-	if (bio_sectors(bio)) {
-		bio->bi_iter.bi_sector += p->bd_start_sect;
-		trace_block_bio_remap(bio, p->bd_dev,
+	if (bdev->bd_partno && bio_sectors(bio)) {
+		bio->bi_iter.bi_sector += bdev->bd_start_sect;
+		trace_block_bio_remap(bio, bdev->bd_dev,
 				      bio->bi_iter.bi_sector -
-				      p->bd_start_sect);
+				      bdev->bd_start_sect);
 	}
 	bio_set_flag(bio, BIO_REMAPPED);
-	return 0;
 }
 
 /*
@@ -819,8 +820,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
-		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
-			goto end_io;
 	}
 
 	/*
@@ -910,20 +909,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static blk_qc_t __submit_bio(struct bio *bio)
-{
-	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	blk_qc_t ret = BLK_QC_T_NONE;
-
-	if (blk_crypto_bio_prep(&bio)) {
-		if (!disk->fops->submit_bio)
-			return blk_mq_submit_bio(bio);
-		ret = disk->fops->submit_bio(bio);
-	}
-	blk_queue_exit(disk->queue);
-	return ret;
-}
-
 /*
  * The loop in this function may be a bit non-obvious, and so deserves some
  * explanation:
@@ -931,7 +916,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
  *  - Before entering the loop, bio->bi_next is NULL (as all callers ensure
  *    that), so we have a list with a single bio.
  *  - We pretend that we have just taken it off a longer list, so we assign
- *    bio_list to a pointer to the bio_list_on_stack, thus initialising the
+ *    bio_list to a pointer to the current->bio_list, thus initialising the
  *    bio_list of new bios to be added.  ->submit_bio() may indeed add some more
  *    bios through a recursive call to submit_bio_noacct.  If it did, we find a
  *    non-NULL value in bio_list and re-enter the loop from the top.
@@ -939,83 +924,75 @@ static blk_qc_t __submit_bio(struct bio *bio)
  *    pretending) and so remove it from bio_list, and call into ->submit_bio()
  *    again.
  *
- * bio_list_on_stack[0] contains bios submitted by the current ->submit_bio.
- * bio_list_on_stack[1] contains bios that were submitted before the current
+ * current->bio_list[0] contains bios submitted by the current ->submit_bio.
+ * current->bio_list[1] contains bios that were submitted before the current
  *	->submit_bio_bio, but that haven't been processed yet.
  */
 static blk_qc_t __submit_bio_noacct(struct bio *bio)
 {
-	struct bio_list bio_list_on_stack[2];
-	blk_qc_t ret = BLK_QC_T_NONE;
-
-	BUG_ON(bio->bi_next);
-
-	bio_list_init(&bio_list_on_stack[0]);
-	current->bio_list = bio_list_on_stack;
-
-	do {
-		struct request_queue *q = bio->bi_bdev->bd_disk->queue;
-		struct bio_list lower, same;
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct bio_list lower, same;
+	blk_qc_t ret;
 
-		if (unlikely(bio_queue_enter(bio) != 0))
-			continue;
+	if (!blk_crypto_bio_prep(&bio)) {
+		blk_queue_exit(disk->queue);
+		return BLK_QC_T_NONE;
+	}
 
-		/*
-		 * Create a fresh bio_list for all subordinate requests.
-		 */
-		bio_list_on_stack[1] = bio_list_on_stack[0];
-		bio_list_init(&bio_list_on_stack[0]);
+	if (queue_is_mq(disk->queue))
+		return blk_mq_submit_bio(bio);
 
-		ret = __submit_bio(bio);
+	/*
+	 * Create a fresh bio_list for all subordinate requests.
+	 */
+	current->bio_list[1] = current->bio_list[0];
+	bio_list_init(&current->bio_list[0]);
 
-		/*
-		 * Sort new bios into those for a lower level and those for the
-		 * same level.
-		 */
-		bio_list_init(&lower);
-		bio_list_init(&same);
-		while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
-			if (q == bio->bi_bdev->bd_disk->queue)
-				bio_list_add(&same, bio);
-			else
-				bio_list_add(&lower, bio);
+	WARN_ON_ONCE(!disk->fops->submit_bio);
+	ret = disk->fops->submit_bio(bio);
+	blk_queue_exit(disk->queue);
+	/*
+	 * Sort new bios into those for a lower level and those
+	 * for the same level.
+	 */
+	bio_list_init(&lower);
+	bio_list_init(&same);
+	while ((bio = bio_list_pop(&current->bio_list[0])) != NULL)
+		if (disk->queue == bio->bi_bdev->bd_disk->queue)
+			bio_list_add(&same, bio);
+		else
+			bio_list_add(&lower, bio);
 
-		/*
-		 * Now assemble so we handle the lowest level first.
-		 */
-		bio_list_merge(&bio_list_on_stack[0], &lower);
-		bio_list_merge(&bio_list_on_stack[0], &same);
-		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
-	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
+	/*
+	 * Now assemble so we handle the lowest level first.
+	 */
+	bio_list_merge(&current->bio_list[0], &lower);
+	bio_list_merge(&current->bio_list[0], &same);
+	bio_list_merge(&current->bio_list[0], &current->bio_list[1]);
 
-	current->bio_list = NULL;
 	return ret;
 }
 
-static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
+static inline struct block_device *bio_interposer_lock(struct bio *bio)
 {
-	struct bio_list bio_list[2] = { };
-	blk_qc_t ret = BLK_QC_T_NONE;
-
-	current->bio_list = bio_list;
-
-	do {
-		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-		if (unlikely(bio_queue_enter(bio) != 0))
-			continue;
+	bool locked;
+	struct block_device *bdev = bio->bi_bdev;
 
-		if (!blk_crypto_bio_prep(&bio)) {
-			blk_queue_exit(disk->queue);
-			ret = BLK_QC_T_NONE;
-			continue;
+	if (bio->bi_opf & REQ_NOWAIT) {
+		locked = percpu_down_read_trylock(&bdev->bd_interposer_lock);
+		if (unlikely(!locked)) {
+			bio_wouldblock_error(bio);
+			return NULL;
 		}
+	} else
+		percpu_down_read(&bdev->bd_interposer_lock);
 
-		ret = blk_mq_submit_bio(bio);
-	} while ((bio = bio_list_pop(&bio_list[0])));
+	return bdev;
+}
 
-	current->bio_list = NULL;
-	return ret;
+static inline void bio_interposer_unlock(struct block_device *locked_bdev)
+{
+	percpu_up_read(&locked_bdev->bd_interposer_lock);
 }
 
 /**
@@ -1029,6 +1006,10 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
  */
 blk_qc_t submit_bio_noacct(struct bio *bio)
 {
+	struct block_device *locked_bdev;
+	struct bio_list bio_list_on_stack[2] = { };
+	blk_qc_t ret = BLK_QC_T_NONE;
+
 	if (!submit_bio_checks(bio))
 		return BLK_QC_T_NONE;
 
@@ -1043,9 +1024,46 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
-		return __submit_bio_noacct_mq(bio);
-	return __submit_bio_noacct(bio);
+	BUG_ON(bio->bi_next);
+
+	locked_bdev = bio_interposer_lock(bio);
+	if (!locked_bdev)
+		return BLK_QC_T_NONE;
+
+	current->bio_list = bio_list_on_stack;
+
+	do {
+		if (unlikely(bio_queue_enter(bio) != 0)) {
+			ret = BLK_QC_T_NONE;
+			continue;
+		}
+
+		if (!bio_flagged(bio, BIO_INTERPOSED) &&
+		    bio->bi_bdev->bd_interposer) {
+			struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+			bio_set_dev(bio, bio->bi_bdev->bd_interposer);
+			bio_set_flag(bio, BIO_INTERPOSED);
+
+			bio_list_add(&bio_list_on_stack[0], bio);
+
+			blk_queue_exit(disk->queue);
+			ret = BLK_QC_T_NONE;
+			continue;
+		}
+
+		if (!bio_flagged(bio, BIO_REMAPPED))
+			blk_partition_remap(bio);
+
+		ret = __submit_bio_noacct(bio);
+
+	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
+
+	current->bio_list = NULL;
+
+	bio_interposer_unlock(locked_bdev);
+
+	return ret;
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
-- 
2.20.1

