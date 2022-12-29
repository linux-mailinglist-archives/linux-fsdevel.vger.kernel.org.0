Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0E658A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiL2INT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiL2INI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE910550
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jn22so18252559plb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPgg4/E3xwiWPCkuKUsuYriDQInX30Nw0OCXNJZ+bXk=;
        b=JRQzQRQ/h7n4/IZEyBjWvWRtcDuyVX+Iug4JMnDafdf2iXKCL2eZDsBxuEa5yueYbz
         GBtzujYQ+rtNV3fFWhrS01wFk9UXHIUawqQpFmfKsUPE+V+W140LW12HtP23wsQOc9TO
         1safTRCxSdYVsi2hSVsSmGRIpKPCrzb51h++E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPgg4/E3xwiWPCkuKUsuYriDQInX30Nw0OCXNJZ+bXk=;
        b=zG8QY5IpcuRCskIeuNKVWcD/drUcdecbavnFOthxr37ydRasAVYtteEn+HaVzv2neM
         QWEc9xOX5dX5deebrv2Iri6crSo3QCOIW/Mx+cZhqgz24mbjkvcvIoUYRXzp9t7wRP1g
         bOD065F30ZRmelwpTtWle53pR62BisJ9c3Lgo7+pwtoEtHDje2s1R6y8CyXrFktfBGY9
         gmbKdyuW+K/qr7ClOShMCJffjRf6KQIJHzOEXY/ZBYrRnERTDBYSuDrhd+UcklQRqzVA
         4h5077xPBFGIU8pAJLkzQn8KVrvI0bNoLa5cI6SIMFca/jqlaQcud/guyYbDrzGF9cwE
         wJnQ==
X-Gm-Message-State: AFqh2kpz5I4p3HtjJsK6gNARec8B5FMfOqCzAvP45tjP2mhn1gz1zELV
        Lhw+HPCg7OThUbcQUMFEbbgtog==
X-Google-Smtp-Source: AMrXdXsfqqYCIpyBiZr/cTv9/CTKLr3m3pQrIjpFfBa2/Eo9DJ18jgamvtyxXSOS/6bH1HpMdN9jKg==
X-Received: by 2002:a17:902:b60e:b0:189:89a4:3954 with SMTP id b14-20020a170902b60e00b0018989a43954mr30107986pls.41.1672301581332;
        Thu, 29 Dec 2022 00:13:01 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:00 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 1/7] block: Introduce provisioning primitives
Date:   Thu, 29 Dec 2022 00:12:46 -0800
Message-Id: <20221229081252.452240-2-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229081252.452240-1-sarthakkukreti@chromium.org>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce block request REQ_OP_PROVISION. The intent of this request
is to request underlying storage to preallocate disk space for the given
block range. Block device that support this capability will export
a provision limit within their request queues.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/blk-core.c          |  5 ++++
 block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         | 18 +++++++++++++
 block/blk-settings.c      | 19 ++++++++++++++
 block/blk-sysfs.c         |  8 ++++++
 block/bounce.c            |  1 +
 include/linux/bio.h       |  6 +++--
 include/linux/blk_types.h |  5 +++-
 include/linux/blkdev.h    | 16 ++++++++++++
 9 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..30bcabc7dc01 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -123,6 +123,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(DRV_IN),
 	REQ_OP_NAME(DRV_OUT),
+	REQ_OP_NAME(PROVISION)
 };
 #undef REQ_OP_NAME
 
@@ -785,6 +786,10 @@ void submit_bio_noacct(struct bio *bio)
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
index 35a8f75cc45d..3ab35bb2a333 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,6 +158,21 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
 	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *bio_split_provision(struct bio *bio,
+					const struct queue_limits *lim,
+					unsigned *nsegs, struct bio_set *bs)
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
@@ -355,6 +370,9 @@ struct bio *__bio_split_to_limits(struct bio *bio,
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
index 0477c4d527fe..57d88204fbbe 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -58,6 +58,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->max_provision_sectors = 0;
 }
 
 /**
@@ -81,6 +82,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_provision_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -202,6 +204,20 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
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
@@ -572,6 +588,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_provision_sectors = min_not_zero(t->max_provision_sectors,
+						b->max_provision_sectors);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93d9e9c9a6ea..2e678417b302 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -131,6 +131,12 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
 	return queue_var_show(queue_max_discard_segments(q), page);
 }
 
+static ssize_t queue_max_provision_sectors_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(queue_max_provision_sectors(q), (page));
+}
+
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->limits.max_integrity_segments, page);
@@ -589,6 +595,7 @@ QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
 QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
 
 QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
+QUEUE_RO_ENTRY(queue_max_provision_sectors, "max_provision_sectors");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
@@ -638,6 +645,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
 	&queue_max_discard_segments_entry.attr,
+	&queue_max_provision_sectors_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&elv_iosched_entry.attr,
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
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 22078a28d7cb..5025af105b7c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -55,7 +55,8 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_PROVISION)
 		return true;
 
 	return false;
@@ -65,7 +66,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
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
index 301cf1cf4f2f..f1abc7b43e25 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -302,6 +302,7 @@ struct queue_limits {
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
+	unsigned int		max_provision_sectors;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -918,6 +919,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_provision_sectors(struct request_queue *q,
+		unsigned int max_provision_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
@@ -1057,6 +1060,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 
+extern int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
 
@@ -1135,6 +1141,11 @@ static inline unsigned short queue_max_discard_segments(const struct request_que
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
@@ -1271,6 +1282,11 @@ static inline bool bdev_nowait(struct block_device *bdev)
 	return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_flags);
 }
 
+static inline unsigned int bdev_max_provision_sectors(struct block_device *bdev)
+{
+	return bdev_get_queue(bdev)->limits.max_provision_sectors;
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.37.3

