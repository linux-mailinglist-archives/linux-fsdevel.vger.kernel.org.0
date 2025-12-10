Return-Path: <linux-fsdevel+bounces-71059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A397BCB34E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50AB315A794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0C2417F0;
	Wed, 10 Dec 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOFB87dL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612D3148B1;
	Wed, 10 Dec 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380240; cv=none; b=n4JBnr7hG8VGMnNAIQv5uSJyVJaYjhw545GarKIqY3HiZkDgN5BTuOVTV67kcPfMzZBOlsk9IPd5NTE+z2nwP27x79tdiJvCTqh0TwsE6tysf+b0wXl5UxHDD6kn81D0xL1qXUcittiYJF/CoC5ACJgYw/1fubXflNFm9ZRFWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380240; c=relaxed/simple;
	bh=Z1qRTGMzHk9Ps6roFTFZSL325JPCJeU7jdbNkq/ii54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB0ZaDPcKaawRmRR7g9tne9wJyfTRcTNtB9TtNom2zPiBem7D5WXBmCgoCw/L7clGcSd+5ajKxteX7tmKcNXfcagpYnTK7lqceM/5QYbGeGvqc+2qoBhdHtK3IuUI8tdmNelfJCSV6tQfhYiW9X8yNAdZq8ciX6R6MuMdrv6jDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NOFB87dL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CRhkZCowijXHhm0FTgt07obIr76QRAlxrBwCgbfW+SI=; b=NOFB87dLxxbWkRlSiWe2gRAWPQ
	jOMGncbNCLrjWC37/bNe7XDccfSbNdZXRE6tTVQQFUCNV+lRo6fBy0jjLu3Yrb8ssm+S9Wx0NaZjp
	YaQwelT5kzmSjXzpmrIYQ585O1SHc577/1zaiVbiipPH/yJICSdh4sRfhcj7vpQHVyDitGJxHI3I4
	OyZWUBN9Ce8mmfHpN/CiR95Audu3gfzTAfiNfc6hnwrs50Z2SqRLyKkUWCRLEPDvSP7wD4qYoLne4
	jHuKXGJ/dDQ0Eg/Ck/NhYiwAw4VEkC5j7ztCqjPGDJF0nlOAbiZBdBIGYvV3aYA+22qooy4l96Tgg
	q7RF4Jag==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTM2n-0000000FZ1w-2L1A;
	Wed, 10 Dec 2025 15:23:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 3/9] block: merge bio_split_rw_at into bio_split_io_at
Date: Wed, 10 Dec 2025 16:23:32 +0100
Message-ID: <20251210152343.3666103-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210152343.3666103-1-hch@lst.de>
References: <20251210152343.3666103-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bio_split_rw_at passes the queues dma_alignment into bio_split_io_at,
which that already checks unconditionally.  Remove the len_align_mask
argument from bio_split_io_at and switch all users of bio_split_rw_at
to directly call bio_split_io_at.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c        |  2 +-
 block/blk-merge.c      | 12 +++++-------
 fs/btrfs/bio.c         |  2 +-
 fs/iomap/ioend.c       |  2 +-
 fs/xfs/xfs_zone_gc.c   |  2 +-
 include/linux/bio.h    |  2 +-
 include/linux/blkdev.h |  7 -------
 7 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4533094d9458..106c6157c49b 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -432,7 +432,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 	int ret;
 
 	/* check that the data layout matches the hardware restrictions */
-	ret = bio_split_io_at(bio, lim, &nr_segs, max_bytes, 0);
+	ret = bio_split_io_at(bio, lim, &nr_segs, max_bytes);
 	if (ret) {
 		/* if we would have to split the bio, copy instead */
 		if (ret > 0)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index d3115d7469df..6cea8fb3e968 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -314,7 +314,6 @@ static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
  * @lim:  [in] queue limits to split based on
  * @segs: [out] number of segments in the bio with the first half of the sectors
  * @max_bytes: [in] maximum number of bytes per bio
- * @len_align_mask: [in] length alignment mask for each vector
  *
  * Find out if @bio needs to be split to fit the queue limits in @lim and a
  * maximum size of @max_bytes.  Returns a negative error number if @bio can't be
@@ -322,15 +321,14 @@ static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
  * @bio needs to be split.
  */
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
-		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
+		unsigned *segs, unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	unsigned nsegs = 0, bytes = 0, gaps = 0;
 	struct bvec_iter iter;
 
 	bio_for_each_bvec(bv, bio, iter) {
-		if (bv.bv_offset & lim->dma_alignment ||
-		    bv.bv_len & len_align_mask)
+		if (bv.bv_offset & lim->dma_alignment)
 			return -EINVAL;
 
 		/*
@@ -404,14 +402,14 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		unsigned *nr_segs)
 {
 	return bio_submit_split(bio,
-		bio_split_rw_at(bio, lim, nr_segs,
+		bio_split_io_at(bio, lim, nr_segs,
 			get_max_io_size(bio, lim) << SECTOR_SHIFT));
 }
 
 /*
  * REQ_OP_ZONE_APPEND bios must never be split by the block layer.
  *
- * But we want the nr_segs calculation provided by bio_split_rw_at, and having
+ * But we want the nr_segs calculation provided by bio_split_io_at, and having
  * a good sanity check that the submitter built the bio correctly is nice to
  * have as well.
  */
@@ -420,7 +418,7 @@ struct bio *bio_split_zone_append(struct bio *bio,
 {
 	int split_sectors;
 
-	split_sectors = bio_split_rw_at(bio, lim, nr_segs,
+	split_sectors = bio_split_io_at(bio, lim, nr_segs,
 			lim->max_zone_append_sectors << SECTOR_SHIFT);
 	if (WARN_ON_ONCE(split_sectors > 0))
 		split_sectors = -EINVAL;
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fa1d321a2fb8..c01154f8b956 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -726,7 +726,7 @@ static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 	int sector_offset;
 
 	map_length = min(map_length, fs_info->max_zone_append_size);
-	sector_offset = bio_split_rw_at(&bbio->bio, &fs_info->limits,
+	sector_offset = bio_split_io_at(&bbio->bio, &fs_info->limits,
 					&nr_segs, map_length);
 	if (sector_offset) {
 		/*
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 86f44922ed3b..41d60c7823b7 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -387,7 +387,7 @@ struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
 		max_len = min(max_len,
 			      lim->max_zone_append_sectors << SECTOR_SHIFT);
 
-		sector_offset = bio_split_rw_at(bio, lim, &nr_segs, max_len);
+		sector_offset = bio_split_io_at(bio, lim, &nr_segs, max_len);
 		if (unlikely(sector_offset < 0))
 			return ERR_PTR(sector_offset);
 		if (!sector_offset)
diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index 3c52cc1497d4..554c96cb92c6 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -767,7 +767,7 @@ xfs_zone_gc_split_write(
 	if (!chunk->is_seq)
 		return NULL;
 
-	split_sectors = bio_split_rw_at(&chunk->bio, lim, &nsegs,
+	split_sectors = bio_split_io_at(&chunk->bio, lim, &nsegs,
 			lim->max_zone_append_sectors << SECTOR_SHIFT);
 	if (!split_sectors)
 		return NULL;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad2d57908c1c..d1f38c47d2ee 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -323,7 +323,7 @@ void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
-		unsigned *segs, unsigned max_bytes, unsigned len_align);
+		unsigned *segs, unsigned max_bytes);
 u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
 		u8 gaps_bit);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 72e34acd439c..38b0bc8c6011 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1864,13 +1864,6 @@ bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
 	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
 }
 
-static inline int bio_split_rw_at(struct bio *bio,
-		const struct queue_limits *lim,
-		unsigned *segs, unsigned max_bytes)
-{
-	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
-}
-
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
 #endif /* _LINUX_BLKDEV_H */
-- 
2.47.3


