Return-Path: <linux-fsdevel+bounces-65331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7696BC01A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287CE3B83F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EA3161A2;
	Thu, 23 Oct 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3CP0T1qz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CD323411;
	Thu, 23 Oct 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227771; cv=none; b=XTGerCAgAQIYX3RxREJmeN1Zb5OJe+r5dKJBOw62Z2/gO3l1Kh1LX81WGTkTFLZ4Y/WjTYvA7l22EMFFbSdWoEvuIop8bpeJc11hIuqvx1RZEEgz/2gTiIp6NGZF98jlgF2wcKd0s+cC4zqYkbnZqETpeSfEX53O1fBPmbn1pL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227771; c=relaxed/simple;
	bh=R38UW1cSMYDogdfcEkNwU3zhEQaoBBuxfZq+zyfSoi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq/TCz7hmGdc8Nv2Z+doCjbInSA5wsMzceBv1qG1y0NSLDEis3gTPI6dx6pAS9kaYegWxLeT5n4A2psziXhDGmuSGbXVoury9QDEfwuaAYlLqrdtbCIrGLQ6wttg8FCmJnnsQjmUlAYok4qPRggWiR6viBvIjm8bZVsD42EqfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3CP0T1qz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ub21A56iwl4rcu8kqsPSE5pl3dJWvYpLLPuSq52T1OU=; b=3CP0T1qzEevQHY6CCqhxDxndAq
	IU6R8Cmca/wxTNlen1sFZgjE9Ht8zAtPrkxyV75WdkW0Z7NT3dHXm4+WZtAXiw9R+x/M3prlE3pMW
	FWX2N3Q9OH4qRJSwUzfpuSoqKD5utl65rMWNga2ES0EgLnfG00MDmPKaF3j/9+dxV5q9DlC40yDS8
	auuEZmxEmm131JKfQ5S8E4SJDgn5r0TMjM8QwwmIj7ZlUM8ujNrYykjvhVvtOlJ/Qz1r5vXvO8rDm
	N6BhrBTjdkHl5+MZ2QrGebCNNZIloJjP3mxiG/0EST+uWZzmALakGbSb0ZNKheW1R/pDnHn6P0PWu
	BPL627gA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvnT-00000006Uck-35Zu;
	Thu, 23 Oct 2025 13:56:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Date: Thu, 23 Oct 2025 15:55:42 +0200
Message-ID: <20251023135559.124072-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023135559.124072-1-hch@lst.de>
References: <20251023135559.124072-1-hch@lst.de>
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
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 13 ++++++++++++-
 include/linux/iomap.h |  8 ++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..ce9cbd2bace0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -336,10 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
+	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
 
+	/*
+	 * Align to the larger one of bdev and fs block size, to meet the
+	 * alignment requirement of both layers.
+	 */
+	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
+		alignment = max(alignment, fs_block_size);
+
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
 
@@ -434,7 +442,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
-				bdev_logical_block_size(iomap->bdev) - 1);
+					     alignment - 1);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
@@ -639,6 +647,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
+		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
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


