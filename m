Return-Path: <linux-fsdevel+bounces-40581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B30A2561D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140373A93FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B53200B95;
	Mon,  3 Feb 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x+VTF81G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B311FF619;
	Mon,  3 Feb 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575817; cv=none; b=h55CrgQzI/oDS3XvShWHXI7WKUlrMTEBqLgNsM4oSr1yJc2vjkSWktWZQf2q2uaaPlBC1vL41Og6ZTzrC9Q207RoHSravLxFiMyFoftVvPc7hxRLM8HvoVXiQYtgztrUj6XutmduXRfTc3BiOo1T6AE4r0NXtjlSQ+RBEGptub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575817; c=relaxed/simple;
	bh=WbPOZY/3NRfUnKFn1TQ7znkwH2q8Lwcv2m9OLFIL/k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNHeuEDzgspJ771ESXd6Dh9Qb/wREmHBngOgH6U/dPw/vYWAttmB/7lOgYk3uiQwxmAWZghqW8EOfViz55kSAGPuA37HOgy9UQePyfX5aM2j8lm3hMmeL8EX22cDt5KzEimlb1asdicYqhDRUjiBQ/HBmkaurSnHSYv6UxNyRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x+VTF81G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=j8azhDW1wfzhNKmZcgt1wCHCrfjnFNGdrafHVpplpj8=; b=x+VTF81GFTJNz7eyf2mP2toROZ
	SHEpdIriXlpHPjfR2H/lPizBozCUfb47JUEMZYI6xe8RskjjGa6izSkNFGDYFctDd5iJv0eYJ0Acm
	vIiRA839HuJ3RBflsi7Sw2fldHGeysVYxkUy4UvLa9TdbTNGpxBugQ2YtgzDFGvdrWoAIlOfNUU+2
	LDC4fGCPtHfP0Okq5wfskXbXoBlxkpNGxO0cXCUsU4QDmUbq2yfua7DQxjSRIQiWm4ERI8i2IkOM3
	uLSdGv8pfbTbbGyIadvaZh/tgCbLNsQPBhm5QcgdIJ0xZ7HQSNTAmRlJOsMAo10ZD71iYzVfpVHEZ
	MJAodGUQ==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszM-0000000F1hg-2CwK;
	Mon, 03 Feb 2025 09:43:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 3/7] iomap: add bioset in iomap_read_folio_ops for filesystems to use own bioset
Date: Mon,  3 Feb 2025 10:43:07 +0100
Message-ID: <20250203094322.1809766-4-hch@lst.de>
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

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Allocate the bio from the bioset provided in iomap_read_folio_ops.
If no bioset is provided, fs_bio_set is used which is the standard
bioset for filesystems.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
[hch: factor out two helpers]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 51 ++++++++++++++++++++++++++++--------------
 include/linux/iomap.h  |  6 +++++
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 804527dcc9ba..eaffa23eb8e4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -364,6 +364,39 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+static struct bio_set *iomap_read_bio_set(struct iomap_readpage_ctx *ctx)
+{
+	if (ctx->ops && ctx->ops->bio_set)
+		return ctx->ops->bio_set;
+	return &fs_bio_set;
+}
+
+static struct bio *iomap_read_alloc_bio(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t length)
+{
+	unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
+	struct block_device *bdev = iter->iomap.bdev;
+	struct bio_set *bio_set = iomap_read_bio_set(ctx);
+	gfp_t gfp = mapping_gfp_constraint(iter->inode->i_mapping, GFP_KERNEL);
+	gfp_t orig_gfp = gfp;
+	struct bio *bio;
+
+	if (ctx->rac) /* same as readahead_gfp_mask */
+		gfp |= __GFP_NORETRY | __GFP_NOWARN;
+
+	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_vecs), REQ_OP_READ, gfp,
+			bio_set);
+
+	/*
+	 * If the bio_alloc fails, try it again for a single page to avoid
+	 * having to deal with partial page reads.  This emulates what
+	 * do_mpage_read_folio does.
+	 */
+	if (!bio)
+		bio = bio_alloc_bioset(bdev, 1, REQ_OP_READ, orig_gfp, bio_set);
+	return bio;
+}
+
 static void iomap_read_submit_bio(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
@@ -411,27 +444,11 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
 		if (ctx->bio)
 			iomap_read_submit_bio(iter, ctx);
 
 		ctx->bio_start_pos = offset;
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
-		/*
-		 * If the bio_alloc fails, try it again for a single page to
-		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_read_folio does.
-		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
+		ctx->bio = iomap_read_alloc_bio(iter, ctx, length);
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2930861d1ef1..304be88ecd23 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -311,6 +311,12 @@ struct iomap_read_folio_ops {
 	 */
 	void (*submit_io)(struct inode *inode, struct bio *bio,
 			  loff_t file_offset);
+
+	/*
+	 * Optional, allows filesystem to specify own bio_set, so new bio's
+	 * can be allocated from the provided bio_set.
+	 */
+	struct bio_set *bio_set;
 };
 
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
-- 
2.45.2


