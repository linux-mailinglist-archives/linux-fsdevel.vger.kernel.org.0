Return-Path: <linux-fsdevel+bounces-40579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9024A25614
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1177A379E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A231FFC76;
	Mon,  3 Feb 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yyZIawju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262C1FF7AA;
	Mon,  3 Feb 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575811; cv=none; b=I/Y16FZNF8rRfuendqpO5C9mo2gj4l+9EtQ+a6QLLO5djS/eFoPTAglZ6lR++YmhBynxtS/PnyeSaverGr+YC9x+ZP5/gdUqOf1ORFivGjNE1QGBDuM3bx1KNMl8q0Li2gUzKA4UfbsZQnDDvXIYbpoaBc+541ScYq93siz/UNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575811; c=relaxed/simple;
	bh=sroJfLq3X/drWey6E3R7XSmSx29NBw8nU6wnqyau4O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRkCJqetLQDw+1gf1JkhcdkGlXZnEtuUFxCTl8pjNV7aqHjElGOx0dL5utuw0KLdpHOBKKt8FDqV0s0FNBMkSOAZH6MzbX64bjfuTVTmthAQGnFAa0opQiw+QHNfnClUG+lqY5i6l/BzNrVxj5E54h6CGsOI//HLJ3SuHVM/rY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yyZIawju; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bvfQgK+AKz4WUIi388qsNolaDh+rw/fXsHQu/CdS8Ms=; b=yyZIawjuJLJnugwQ79XdR2o2Bh
	oG7eNLqM40iJABagyAe42Mc3M6M2CU9agZzXHraZ9uSW/prZvfCoKf3nFa+xkSDLtkb1teOOEKQAA
	q2FUuLbU11n1rS9ygHBj8p41QYHp6dnn22yzFMpkqGSUCtH66DBpJxzdErlmH6yM0sNHjPN3TffGI
	vtRgDi3Id1OelfpCdXzGpS3OcFyw9pbYGBgEoAALeKdTeHgoh0FtlbXe82f+hQJtucJd7FW4YQ4NE
	XBlUHMCHQFDE8+Zbqn2G70u+65oBSiYSlGGDcjhbSdJtnOUvdCF+xT/2PC0HCZ+W+QDkCMgZy6ilj
	4CoKhXKQ==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszH-0000000F1gH-3njw;
	Mon, 03 Feb 2025 09:43:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 1/7] block: support integrity generation and verification from file systems
Date: Mon,  3 Feb 2025 10:43:05 +0100
Message-ID: <20250203094322.1809766-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250203094322.1809766-1-hch@lst.de>
References: <20250203094322.1809766-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new blk_integrity_verify_all helper  that uses the _all iterator to
verify the entire bio as built by the file system and doesn't require the
extra bvec_iter used by blk_integrity_verify_iter and export
blk_integrity_generate which can be used as-is.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h                   |  1 -
 block/t10-pi.c                | 90 ++++++++++++++++++++++++-----------
 include/linux/bio-integrity.h | 12 +++++
 3 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 8f5554a6989e..176b04cdddda 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -709,7 +709,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 
-void blk_integrity_generate(struct bio *bio);
 void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter);
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
diff --git a/block/t10-pi.c b/block/t10-pi.c
index de172d56b1f3..b59db61a8104 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -403,42 +403,51 @@ void blk_integrity_generate(struct bio *bio)
 		kunmap_local(kaddr);
 	}
 }
+EXPORT_SYMBOL_GPL(blk_integrity_generate);
 
+static blk_status_t blk_integrity_verify_bvec(struct blk_integrity *bi,
+		struct blk_integrity_iter *iter, struct bio_vec *bv)
+{
+	void *kaddr = bvec_kmap_local(bv);
+	blk_status_t ret = BLK_STS_OK;
+
+	iter->data_buf = kaddr;
+	iter->data_size = bv->bv_len;
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		ret = ext_pi_crc64_verify(iter, bi);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		ret = t10_pi_verify(iter, bi);
+		break;
+	default:
+		break;
+	}
+	kunmap_local(kaddr);
+	return ret;
+}
+
+/*
+ * At the moment verify is called, bi_iter could have been advanced by splits
+ * and completions, thus we have to use the saved copy here.
+ */
 void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct blk_integrity_iter iter;
+	struct blk_integrity_iter iter = {
+		.disk_name	= bio->bi_bdev->bd_disk->disk_name,
+		.interval	= 1 << bi->interval_exp,
+		.seed		= saved_iter->bi_sector,
+		.prot_buf	= bvec_virt(bip->bip_vec),
+	};
 	struct bvec_iter bviter;
 	struct bio_vec bv;
+	blk_status_t ret;
 
-	/*
-	 * At the moment verify is called bi_iter has been advanced during split
-	 * and completion, so use the copy created during submission here.
-	 */
-	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
-	iter.interval = 1 << bi->interval_exp;
-	iter.seed = saved_iter->bi_sector;
-	iter.prot_buf = bvec_virt(bip->bip_vec);
 	__bio_for_each_segment(bv, bio, bviter, *saved_iter) {
-		void *kaddr = bvec_kmap_local(&bv);
-		blk_status_t ret = BLK_STS_OK;
-
-		iter.data_buf = kaddr;
-		iter.data_size = bv.bv_len;
-		switch (bi->csum_type) {
-		case BLK_INTEGRITY_CSUM_CRC64:
-			ret = ext_pi_crc64_verify(&iter, bi);
-			break;
-		case BLK_INTEGRITY_CSUM_CRC:
-		case BLK_INTEGRITY_CSUM_IP:
-			ret = t10_pi_verify(&iter, bi);
-			break;
-		default:
-			break;
-		}
-		kunmap_local(kaddr);
-
+		ret = blk_integrity_verify_bvec(bi, &iter, &bv);
 		if (ret) {
 			bio->bi_status = ret;
 			return;
@@ -446,6 +455,33 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
 	}
 }
 
+/*
+ * For use by the file system which owns the entire bio.
+ */
+int blk_integrity_verify_all(struct bio *bio, sector_t seed)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct blk_integrity_iter iter = {
+		.disk_name	= bio->bi_bdev->bd_disk->disk_name,
+		.interval	= 1 << bi->interval_exp,
+		.seed		= seed,
+		.prot_buf	= bvec_virt(bip->bip_vec),
+	};
+	struct bvec_iter_all bviter;
+	struct bio_vec *bv;
+	blk_status_t ret;
+
+	bio_for_each_segment_all(bv, bio, bviter) {
+		ret = blk_integrity_verify_bvec(bi, &iter, bv);
+		if (ret)
+			return blk_status_to_errno(ret);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_integrity_verify_all);
+
 void blk_integrity_prepare(struct request *rq)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 0a25716820fe..26419eb5425a 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -81,6 +81,9 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
 void bio_integrity_trim(struct bio *bio);
 int bio_integrity_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp_mask);
 
+void blk_integrity_generate(struct bio *bio);
+int blk_integrity_verify_all(struct bio *bio, sector_t seed);
+
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
 static inline struct bio_integrity_payload *bio_integrity(struct bio *bio)
@@ -138,5 +141,14 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 {
 	return 0;
 }
+
+static inline void blk_integrity_generate(struct bio *bio)
+{
+}
+
+static inline int blk_integrity_verify_all(struct bio *bio, sector_t seed)
+{
+	return 0;
+}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BIO_INTEGRITY_H */
-- 
2.45.2


