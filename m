Return-Path: <linux-fsdevel+bounces-66589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B498C25327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED32B3497DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EEA34B1BD;
	Fri, 31 Oct 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3v/zE3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47034B183;
	Fri, 31 Oct 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916256; cv=none; b=spnLIljQauFUYB6FMZwTOaQDrml/Q0rBX+pnnviVqq/s3IrpNHSzj7dlPrDoT4g9Hjo5eDtVAycdmg2ex2CFZLzw8EOTuG3rQeybWKNYhWoHvPQyW3uD93UiL/7yc6EJl9lVnbBUf2L/S0shxFCLLC2wbjJiVUQoItyJ9i96/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916256; c=relaxed/simple;
	bh=OFaHMATk2lsU1TOBh35V4cjgaWFqvLRo18LHNSon7Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr39sMA4aya9tMGwBeK4CPuNf5DIWfcDBt0ehivf+73mCPmKJ01CFkAyTOoJ2hSKoeBKH++az/7fxvvWHwqQ5sbN8zoj7fzwrdPPsEddx+2IEpGu9pzNLarEE6Vx0274WTeKHdDuXKxLrW8SbKDw0tw/TXFet0wzzf3OkNVTEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3v/zE3C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UA2VFsQcZ0PWD6y+j0v26oiVurMW79we8O3OBeFsMY4=; b=f3v/zE3CDVit6Nq1DpJJaNTgS2
	02mekMfvalOvsfYNC1b1HTTUiXHDQEnUTRFHSg9agwVi3Dvbu2mwX8nrJywgu4WqtahlfaC1vJa9e
	7MxpPWjEeTrSct1DM2IcDYp60tHP22Fsav/FBknOYeeIfUKnROditL5pQdTczMRV3eFFSzkoI+7Sl
	eJKIsfsbI6H1xuAwgMzYLYefchX278j7KNlDA1F7DtMM7BcC4w//TIa5kBE9hcRd41nWIhx0T/ZM1
	mqKEkI4o0x8wmbwConuQX28wS0AbEzG8iv4vXO4ifIOOBavEG4AzY77uiuMK5plbtfSwNh+ElthNZ
	9XxZEu0g==;
Received: from [2001:4bb8:2dc:10e5:1f29:7b81:1da3:7ada] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEou4-0000000699T-37Yq;
	Fri, 31 Oct 2025 13:10:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Date: Fri, 31 Oct 2025 14:10:26 +0100
Message-ID: <20251031131045.1613229-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031131045.1613229-1-hch@lst.de>
References: <20251031131045.1613229-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Qu Wenruo <wqu@suse.com>

Btrfs requires all of its bios to be fs block aligned, normally it's
totally fine but with the incoming block size larger than page size
(bs > ps) support, the requirement is no longer met for direct IOs.

Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
requiring alignment to be bdev_logical_block_size().

In the real world that value is either 512 or 4K, on 4K page sized
systems it means bio_iov_iter_get_pages() can break the bio at any page
boundary, breaking btrfs' requirement for bs > ps cases.

To address this problem, introduce a new public iomap dio flag,
IOMAP_DIO_FSBLOCK_ALIGNED.

When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
inherit that new flag, and iomap_dio_bio_iter() will take fs block size
into the calculation of the alignment, and pass the alignment to
bio_iov_iter_get_pages(), respecting the fs block size requirement.

The initial user of this flag will be btrfs, which needs to calculate the
checksum for direct read and thus requires the biovec to be fs block
aligned for the incoming bs > ps support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
[hch: also align pos/len, incorporate the trace flags from Darrick]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 17 +++++++++++++++--
 fs/iomap/trace.h      |  7 ++++---
 include/linux/iomap.h |  8 ++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..13def8418659 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -336,8 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
+	unsigned int alignment;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
+	/*
+	 * File systems that write out of place and always allocate new blocks
+	 * need each bio to be block aligned as that's the unit of allocation.
+	 */
+	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
+		alignment = fs_block_size;
+	else
+		alignment = bdev_logical_block_size(iomap->bdev);
+
+	if ((pos | length) & (alignment - 1))
 		return -EINVAL;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
@@ -434,7 +444,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
-				bdev_logical_block_size(iomap->bdev) - 1);
+					     alignment - 1);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
@@ -639,6 +649,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
+		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index a61c1dae4742..532787277b16 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -122,9 +122,10 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
 
 
 #define IOMAP_DIO_STRINGS \
-	{IOMAP_DIO_FORCE_WAIT,	"DIO_FORCE_WAIT" }, \
-	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
-	{IOMAP_DIO_PARTIAL,	"DIO_PARTIAL" }
+	{IOMAP_DIO_FORCE_WAIT,		"DIO_FORCE_WAIT" }, \
+	{IOMAP_DIO_OVERWRITE_ONLY,	"DIO_OVERWRITE_ONLY" }, \
+	{IOMAP_DIO_PARTIAL,		"DIO_PARTIAL" }, \
+	{IOMAP_DIO_FSBLOCK_ALIGNED,	"DIO_FSBLOCK_ALIGNED" }
 
 DECLARE_EVENT_CLASS(iomap_class,
 	TP_PROTO(struct inode *inode, struct iomap *iomap),
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..4da13fe24ce8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -518,6 +518,14 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Ensure each bio is aligned to fs block size.
+ *
+ * For filesystems which need to calculate/verify the checksum of each fs
+ * block. Otherwise they may not be able to handle unaligned bios.
+ */
+#define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.47.3


