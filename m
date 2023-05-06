Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8886F8F19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEFG3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEFG3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 02:29:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06459008
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 23:29:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaea3909d1so23864675ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683354563; x=1685946563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGCO1+chOz8ZsEeidoSAE5ECmzVmvGKdvg8GGLeqxAw=;
        b=i0GrJraTcrZLoNSZMIOSi6UUClxCqyD2S4qjZsiNX9qAlSw3ITXcN9YVkJKw3PenGf
         yAALV93u9ZjviPgboTdVADJbm1EkhkrvCbk1Y47cytpBHI6Zhwk2D1JT7k6fnIa7QGCB
         E/fTqkifE0pt14NB2d0plNFIcR/vYFN8TCsUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354563; x=1685946563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGCO1+chOz8ZsEeidoSAE5ECmzVmvGKdvg8GGLeqxAw=;
        b=CCXwJEeAOey0bWw2uSGehn3gHLo8+rlgijT9cYGbm+3dTRTLsn8/NKaklglIhIvN+t
         qzG+hNtZv9v3dmlIUEuhz7rebr3WaxKdkY9mWNXBoGMoNQ1gKehfInQYhjbDPcwuqi9P
         ckPGZ2u2+hfmbQ9IXrD8ooX2Ds62QO2rA/05b2lI5dv73usPWsRoMp5sBe483pm9wfTH
         50EImb5ucdM4+RaMuqZPLnMwqOiXlEdvAnzJ7NriOnodkISs8ws3uQweDlCppWSTL6pe
         nTxVJgp7YveesLD6ez83slsuyYevb+i+LJhtEf/iL+vny6m/geQq6oj8pJkryfyTLuMI
         m8Ww==
X-Gm-Message-State: AC+VfDy/T6C2FPYU+G2D9fEwegNukAjtZUeyWDaxhnnP/MsDnSSIaSqo
        09XCoQ5j9JKgMgnDl//CBqc0lA==
X-Google-Smtp-Source: ACHHUZ5u67CqdUKm1SeXYJiZWtFwFiYJ0a+fv4w6oQEfjOvgLdak62WJ7FdaOBxQkVjoz+95J2/UkQ==
X-Received: by 2002:a17:903:11cc:b0:1aa:f616:f5a5 with SMTP id q12-20020a17090311cc00b001aaf616f5a5mr4021763plh.29.1683354563128;
        Fri, 05 May 2023 23:29:23 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:f19c:a713:5517:ed4])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ac381f1ce9sm2793598plx.185.2023.05.05.23.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:29:22 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v6 2/5] block: Introduce provisioning primitives
Date:   Fri,  5 May 2023 23:29:06 -0700
Message-ID: <20230506062909.74601-3-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230506062909.74601-1-sarthakkukreti@chromium.org>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce block request REQ_OP_PROVISION. The intent of this request
is to request underlying storage to preallocate disk space for the given
block range. Block devices that support this capability will export
a provision limit within their request queues.

This patch also adds the capability to call fallocate() in mode 0
on block devices, which will send REQ_OP_PROVISION to the block
device for the specified range,

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/blk-core.c          |  5 ++++
 block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         | 18 +++++++++++++
 block/blk-settings.c      | 19 ++++++++++++++
 block/blk-sysfs.c         |  9 +++++++
 block/bounce.c            |  1 +
 block/fops.c              | 10 +++++++-
 include/linux/bio.h       |  6 +++--
 include/linux/blk_types.h |  5 +++-
 include/linux/blkdev.h    | 16 ++++++++++++
 10 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 42926e6cb83c..4a2342ba3a8b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -123,6 +123,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(DRV_IN),
 	REQ_OP_NAME(DRV_OUT),
+	REQ_OP_NAME(PROVISION)
 };
 #undef REQ_OP_NAME
 
@@ -798,6 +799,10 @@ void submit_bio_noacct(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_PROVISION:
+		if (!q->limits.max_provision_sectors)
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..647b6451660b 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -343,3 +343,56 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_secure_erase);
+
+/**
+ * blkdev_issue_provision - provision a block range
+ * @bdev:	blockdev to write
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to provision
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *  Issues a provision request to the block device for the range of sectors.
+ *  For thinly provisioned block devices, this acts as a signal for the
+ *  underlying storage pool to allocate space for this block range.
+ */
+int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp)
+{
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	unsigned int max_sectors = bdev_max_provision_sectors(bdev);
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret = 0;
+
+	if (max_sectors == 0)
+		return -EOPNOTSUPP;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	blk_start_plug(&plug);
+	for (;;) {
+		unsigned int req_sects = min_t(sector_t, nr_sects, max_sectors);
+
+		bio = blk_next_bio(bio, bdev, 0, REQ_OP_PROVISION, gfp);
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_iter.bi_size = req_sects << SECTOR_SHIFT;
+
+		sector += req_sects;
+		nr_sects -= req_sects;
+		if (!nr_sects) {
+			ret = submit_bio_wait(bio);
+			if (ret == -EOPNOTSUPP)
+				ret = 0;
+			bio_put(bio);
+			break;
+		}
+		cond_resched();
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_provision);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6460abdb2426..a3ffebb97a1d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,6 +158,21 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
 	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *bio_split_provision(struct bio *bio,
+					const struct queue_limits *lim,
+					unsigned int *nsegs, struct bio_set *bs)
+{
+	*nsegs = 0;
+
+	if (!lim->max_provision_sectors)
+		return NULL;
+
+	if (bio_sectors(bio) <= lim->max_provision_sectors)
+		return NULL;
+
+	return bio_split(bio, lim->max_provision_sectors, GFP_NOIO, bs);
+}
+
 /*
  * Return the maximum number of sectors from the start of a bio that may be
  * submitted as a single request to a block device. If enough sectors remain,
@@ -366,6 +381,9 @@ struct bio *__bio_split_to_limits(struct bio *bio,
 	case REQ_OP_WRITE_ZEROES:
 		split = bio_split_write_zeroes(bio, lim, nr_segs, bs);
 		break;
+	case REQ_OP_PROVISION:
+		split = bio_split_provision(bio, lim, nr_segs, bs);
+		break;
 	default:
 		split = bio_split_rw(bio, lim, nr_segs, bs,
 				get_max_io_size(bio, lim) << SECTOR_SHIFT);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..d303e6614c36 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->max_provision_sectors = 0;
 }
 
 /**
@@ -82,6 +83,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_provision_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -208,6 +210,20 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_provision_sectors - set max sectors for a single provision
+ *
+ * @q:  the request queue for the device
+ * @max_provision_sectors: maximum number of sectors to provision per command
+ **/
+
+void blk_queue_max_provision_sectors(struct request_queue *q,
+		unsigned int max_provision_sectors)
+{
+	q->limits.max_provision_sectors = max_provision_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_provision_sectors);
+
 /**
  * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
  * @q:  the request queue for the device
@@ -578,6 +594,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_provision_sectors = min_not_zero(t->max_provision_sectors,
+						b->max_provision_sectors);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f1fce1c7fa44..0a3165211c66 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -213,6 +213,13 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
 	return queue_var_show(0, page);
 }
 
+static ssize_t queue_provision_max_show(struct request_queue *q,
+		char *page)
+{
+	return sprintf(page, "%llu\n",
+		(unsigned long long)q->limits.max_provision_sectors << 9);
+}
+
 static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(0, page);
@@ -604,6 +611,7 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_provision_max, "provision_max_bytes");
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
@@ -661,6 +669,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_provision_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/block/bounce.c b/block/bounce.c
index 7cfcb242f9a1..ab9d8723ae64 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -176,6 +176,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_PROVISION:
 		break;
 	default:
 		bio_for_each_segment(bv, bio_src, iter)
diff --git a/block/fops.c b/block/fops.c
index 4c70fdc546e7..be2e41f160bf 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -613,7 +613,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |	\
+		 FALLOC_FL_UNSHARE_RANGE)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -653,6 +654,13 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	 * de-allocate mode calls to fallocate().
 	 */
 	switch (mode) {
+	case 0:
+	case FALLOC_FL_UNSHARE_RANGE:
+	case FALLOC_FL_KEEP_SIZE:
+	case FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
+					       len >> SECTOR_SHIFT, GFP_KERNEL);
+		break;
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
 		error = truncate_bdev_range(bdev, file->f_mode, start, end);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..9820b3b039f2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -57,7 +57,8 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_PROVISION)
 		return true;
 
 	return false;
@@ -67,7 +68,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	       bio_op(bio) == REQ_OP_PROVISION;
 }
 
 static inline void *bio_data(struct bio *bio)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..27bdf88f541c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -385,7 +385,10 @@ enum req_op {
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
 	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
 
-	REQ_OP_LAST		= (__force blk_opf_t)36,
+	/* request device to provision block */
+	REQ_OP_PROVISION        = (__force blk_opf_t)37,
+
+	REQ_OP_LAST		= (__force blk_opf_t)38,
 };
 
 enum req_flag_bits {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..239e2f418b6e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -303,6 +303,7 @@ struct queue_limits {
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
+	unsigned int		max_provision_sectors;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -921,6 +922,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_provision_sectors(struct request_queue *q,
+		unsigned int max_provision_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
@@ -1060,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 
+extern int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
 
@@ -1139,6 +1145,11 @@ static inline unsigned short queue_max_discard_segments(const struct request_que
 	return q->limits.max_discard_segments;
 }
 
+static inline unsigned short queue_max_provision_sectors(const struct request_queue *q)
+{
+	return q->limits.max_provision_sectors;
+}
+
 static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 {
 	return q->limits.max_segment_size;
@@ -1281,6 +1292,11 @@ static inline bool bdev_nowait(struct block_device *bdev)
 	return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_flags);
 }
 
+static inline unsigned int bdev_max_provision_sectors(struct block_device *bdev)
+{
+	return bdev_get_queue(bdev)->limits.max_provision_sectors;
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	return blk_queue_zoned_model(bdev_get_queue(bdev));
-- 
2.40.1.521.gf1e218fcd8-goog

