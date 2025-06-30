Return-Path: <linux-fsdevel+bounces-53316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C120AED836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D717614D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635732459D7;
	Mon, 30 Jun 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kKCraec8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E224501B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274535; cv=none; b=jiQ2IzqxoQPeNu/u6zC/DwAv9W8O6vkZ2Gy73yiCQFSyCWo4/KDooaJ9u6fmb/tv6G6auXESLgRUbQOdTwdjjE96HbYeiihiUyOuEiMTeRYQmcFHnGIZHGLAEvj4dAwZ236VxvJRP6BSeJBVRM/J8Pk7Tf1baWCesnke4mk03eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274535; c=relaxed/simple;
	bh=+bDD4bo8jHBZhJOAnTwCEmCgSbQQs8+A8b9cK7yOiws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mqddtB5EIwnWZyc6JfiNgsYUmjEVeRnj51ajmSuNtO/VzU7kwCehN67ZPMcMAEO4QZKnDaIx2G9nUDfF+CWla0T3FxA7ZytrVuWuo6jGh6SkoblbQLswJFkgaXF/b0EY9rrrHYgSueU/9tKJXgWNqFVLFXSBIaWViWO4yF3tuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kKCraec8; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250630090846epoutp049c188a7e64b9f7d439b4ce3fd082e081~Nxuca9QFa2313623136epoutp04S
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:08:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250630090846epoutp049c188a7e64b9f7d439b4ce3fd082e081~Nxuca9QFa2313623136epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751274526;
	bh=9bSeSta7JLOrglF/W6spICiV7ZNVu/Jzv52Edv9Hx9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKCraec83wMkpCK39DwmvJ8BUQfDIR2Ygzqq7SNRF1LQbIVyyu5J38Kj3EtNsHDUg
	 +OqYGJ8BIs5wf3pYHUNhAxsLfiufkoX4w72D72ExwA12xZGRQjfcum3tJrKrpHOFoQ
	 J9dAWgyD650+/gVVXkUdoUazvoXKytWLyuKqoTQ8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250630090845epcas5p4b34cd3c5e0cf6e9ad22adf9384ae27ca~Nxub6vGk20739107391epcas5p4B;
	Mon, 30 Jun 2025 09:08:45 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bW0hC4Kg2z6B9mH; Mon, 30 Jun
	2025 09:08:43 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250630090608epcas5p192ace2db81d6cc04854919225464444c~NxsKEWCEZ0151501515epcas5p1x;
	Mon, 30 Jun 2025 09:06:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090606epsmtip2c999573ce0bc298f997f181b31b42c1c~NxsHyoLz41134211342epsmtip2b;
	Mon, 30 Jun 2025 09:06:06 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH for-next v5 1/4] block: rename tuple_size field in
 blk_integrity to metadata_size
Date: Mon, 30 Jun 2025 14:35:45 +0530
Message-Id: <20250630090548.3317-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250630090608epcas5p192ace2db81d6cc04854919225464444c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090608epcas5p192ace2db81d6cc04854919225464444c
References: <20250630090548.3317-1-anuj20.g@samsung.com>
	<CGME20250630090608epcas5p192ace2db81d6cc04854919225464444c@epcas5p1.samsung.com>

The tuple_size field in blk_integrity currently represents the total
size of metadata associated with each data interval. To make the meaning
more explicit, rename tuple_size to metadata_size. This is a purely
mechanical rename with no functional changes.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bio-integrity-auto.c        |  4 ++--
 block/blk-integrity.c             |  2 +-
 block/blk-settings.c              |  6 +++---
 block/t10-pi.c                    | 16 ++++++++--------
 drivers/md/dm-crypt.c             |  4 ++--
 drivers/md/dm-integrity.c         | 12 ++++++------
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  2 +-
 include/linux/blk-integrity.h     |  4 ++--
 include/linux/blkdev.h            |  2 +-
 12 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 9c6657664792..687952f63bbb 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -54,10 +54,10 @@ static bool bi_offload_capable(struct blk_integrity *bi)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		return bi->tuple_size == sizeof(struct crc64_pi_tuple);
+		return bi->metadata_size == sizeof(struct crc64_pi_tuple);
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		return bi->tuple_size == sizeof(struct t10_pi_tuple);
+		return bi->metadata_size == sizeof(struct t10_pi_tuple);
 	default:
 		pr_warn_once("%s: unknown integrity checksum type:%d\n",
 			__func__, bi->csum_type);
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9..c1102bf4cd8d 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -239,7 +239,7 @@ static ssize_t format_show(struct device *dev, struct device_attribute *attr,
 {
 	struct blk_integrity *bi = dev_to_bi(dev);
 
-	if (!bi->tuple_size)
+	if (!bi->metadata_size)
 		return sysfs_emit(page, "none\n");
 	return sysfs_emit(page, "%s\n", blk_integrity_profile_name(bi));
 }
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..787500ff00c3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -114,7 +114,7 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 {
 	struct blk_integrity *bi = &lim->integrity;
 
-	if (!bi->tuple_size) {
+	if (!bi->metadata_size) {
 		if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE ||
 		    bi->tag_size || ((bi->flags & BLK_INTEGRITY_REF_TAG))) {
 			pr_warn("invalid PI settings.\n");
@@ -875,7 +875,7 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 		return true;
 
 	if (ti->flags & BLK_INTEGRITY_STACKED) {
-		if (ti->tuple_size != bi->tuple_size)
+		if (ti->metadata_size != bi->metadata_size)
 			goto incompatible;
 		if (ti->interval_exp != bi->interval_exp)
 			goto incompatible;
@@ -891,7 +891,7 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 		ti->flags |= (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) |
 			     (bi->flags & BLK_INTEGRITY_REF_TAG);
 		ti->csum_type = bi->csum_type;
-		ti->tuple_size = bi->tuple_size;
+		ti->metadata_size = bi->metadata_size;
 		ti->pi_offset = bi->pi_offset;
 		ti->interval_exp = bi->interval_exp;
 		ti->tag_size = bi->tag_size;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 851db518ee5e..0c4ed9702146 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -56,7 +56,7 @@ static void t10_pi_generate(struct blk_integrity_iter *iter,
 			pi->ref_tag = 0;
 
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 }
@@ -105,7 +105,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 next:
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 
@@ -125,7 +125,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 static void t10_pi_type1_prepare(struct request *rq)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
@@ -177,7 +177,7 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
 	unsigned intervals = nr_bytes >> bi->interval_exp;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
@@ -234,7 +234,7 @@ static void ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 			put_unaligned_be48(0ULL, pi->ref_tag);
 
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 }
@@ -289,7 +289,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 
 next:
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 
@@ -299,7 +299,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 static void ext_pi_type1_prepare(struct request *rq)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
@@ -340,7 +340,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
 	unsigned intervals = nr_bytes >> bi->interval_exp;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 381b37f181e5..bec91cfb5cb8 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1207,11 +1207,11 @@ static int crypt_integrity_ctr(struct crypt_config *cc, struct dm_target *ti)
 		return -EINVAL;
 	}
 
-	if (bi->tuple_size < cc->used_tag_size) {
+	if (bi->metadata_size < cc->used_tag_size) {
 		ti->error = "Integrity profile tag size mismatch.";
 		return -EINVAL;
 	}
-	cc->tuple_size = bi->tuple_size;
+	cc->tuple_size = bi->metadata_size;
 	if (1 << bi->interval_exp != cc->sector_size) {
 		ti->error = "Integrity profile sector size mismatch.";
 		return -EINVAL;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 4395657fa583..efeee0a873c0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3906,8 +3906,8 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		struct blk_integrity *bi = &limits->integrity;
 
 		memset(bi, 0, sizeof(*bi));
-		bi->tuple_size = ic->tag_size;
-		bi->tag_size = bi->tuple_size;
+		bi->metadata_size = ic->tag_size;
+		bi->tag_size = bi->metadata_size;
 		bi->interval_exp =
 			ic->sb->log2_sectors_per_block + SECTOR_SHIFT;
 	}
@@ -4746,18 +4746,18 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 			ti->error = "Integrity profile not supported";
 			goto bad;
 		}
-		/*printk("tag_size: %u, tuple_size: %u\n", bi->tag_size, bi->tuple_size);*/
-		if (bi->tuple_size < ic->tag_size) {
+		/*printk("tag_size: %u, metadata_size: %u\n", bi->tag_size, bi->metadata_size);*/
+		if (bi->metadata_size < ic->tag_size) {
 			r = -EINVAL;
 			ti->error = "The integrity profile is smaller than tag size";
 			goto bad;
 		}
-		if ((unsigned long)bi->tuple_size > PAGE_SIZE / 2) {
+		if ((unsigned long)bi->metadata_size > PAGE_SIZE / 2) {
 			r = -EINVAL;
 			ti->error = "Too big tuple size";
 			goto bad;
 		}
-		ic->tuple_size = bi->tuple_size;
+		ic->tuple_size = bi->metadata_size;
 		if (1 << bi->interval_exp != ic->sectors_per_block << SECTOR_SHIFT) {
 			r = -EINVAL;
 			ti->error = "Integrity profile sector size mismatch";
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 423dcd190906..2a1aa32e6693 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1506,7 +1506,7 @@ static int btt_blk_init(struct btt *btt)
 	int rc;
 
 	if (btt_meta_size(btt) && IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY)) {
-		lim.integrity.tuple_size = btt_meta_size(btt);
+		lim.integrity.metadata_size = btt_meta_size(btt);
 		lim.integrity.tag_size = btt_meta_size(btt);
 	}
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..de8d27ceefc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1866,7 +1866,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		break;
 	}
 
-	bi->tuple_size = head->ms;
+	bi->metadata_size = head->ms;
 	bi->pi_offset = info->pi_offset;
 	return true;
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index eba42df2f821..42fb19f94ab8 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -65,7 +65,7 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 		return;
 
 	if (bi->csum_type == BLK_INTEGRITY_CSUM_CRC) {
-		ns->metadata_size = bi->tuple_size;
+		ns->metadata_size = bi->metadata_size;
 		if (bi->flags & BLK_INTEGRITY_REF_TAG)
 			ns->pi_type = NVME_NS_DPS_PI_TYPE1;
 		else
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index ae6ce6f5d622..18bfca1f1c78 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -52,7 +52,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp, struct queue_limits *lim)
 	if (type != T10_PI_TYPE3_PROTECTION)
 		bi->flags |= BLK_INTEGRITY_REF_TAG;
 
-	bi->tuple_size = sizeof(struct t10_pi_tuple);
+	bi->metadata_size = sizeof(struct t10_pi_tuple);
 
 	if (dif && type) {
 		bi->flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c7eae0bfb013..d27730da47f3 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -33,7 +33,7 @@ int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
 {
-	return q->limits.integrity.tuple_size;
+	return q->limits.integrity.metadata_size;
 }
 
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
@@ -74,7 +74,7 @@ static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
-	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
+	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
 static inline bool blk_integrity_rq(struct request *rq)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a51f92b6c340..edc3b458fbd9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -116,7 +116,7 @@ enum blk_integrity_checksum {
 struct blk_integrity {
 	unsigned char				flags;
 	enum blk_integrity_checksum		csum_type;
-	unsigned char				tuple_size;
+	unsigned char				metadata_size;
 	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
-- 
2.25.1


