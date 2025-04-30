Return-Path: <linux-fsdevel+bounces-47780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C7AA5734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC52B17DC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166342D192D;
	Wed, 30 Apr 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpLyQj5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212D2D190B;
	Wed, 30 Apr 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048167; cv=none; b=o2FeEgVYGE5p2BmaWZF+/oJU/ONwqmzjF9+TGPtr2w/daK+UkivhPd5eoMOR1zQ+CyOwR52hOrupPD1zChGflGsQr4Xcc1HK1z024XDnOzfSNhHR8WZwfwsl37489M9P1tzgClfHmqZ0NCfWqDlVvV6HAn0H/9HwXzITS5P8ZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048167; c=relaxed/simple;
	bh=kuNWUXyfRAKizlHHV5edITwG6xoFKrtIOWh10TOsmac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQXMs5nLfBliEdF0K7mbvkwp7sqdGxGQyuNOzwMgznWKoSZLY8r7wP2QTi2TEYrM3XN49cwx4p3b+LHFazkwtfmOb4K/TbHv84CZH7/3pg2nEwvz8Zto56zvVyNpYmt30FtlRY7Q6Edv3x0VDZBYAo1qO45pdI0/eWvbErKxH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fpLyQj5L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+UsRIHnRQEzRjz1JEQAuOBQt5/XgOIJZMpUhTVJGuKQ=; b=fpLyQj5LcR9N7Sq13IoFVix2Zn
	jYIRUvvfnn03uiT3I55a7enRpAzotlSh+yusr3MLOqG4gy8Fcs27lEOoGsRlCVDi/q/EIZYKubBb6
	zB6a9Zsg3GgrOVz65Kr/NWSPeDkx35fhR36eyjK44+5JcuwE4ueBoiN7DedpFuQpCpW/TbRq3gek0
	fq73WSOGBbt58eXgGKnskTL/C2xTuklYAPdwnPkYsykltMXundFzbPIGy9+A+0WXj1+H6RHJ6pQ2e
	/Ft7bAijRYm/F9ALxb3AA9JetK+31Yr48uP8//LIm9g+iLtAfOI4X8NpI0Lx9Rh6c5uy0YntYbzSQ
	mIql4eUQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEtA-0000000E2gJ-2nke;
	Wed, 30 Apr 2025 21:22:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 15/19] xfs: simplify xfs_buf_submit_bio
Date: Wed, 30 Apr 2025 16:21:45 -0500
Message-ID: <20250430212159.2865803-16-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430212159.2865803-1-hch@lst.de>
References: <20250430212159.2865803-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it and use bio_add_vmalloc
to insulate xfs from the details of adding vmalloc memory to a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_buf.c | 43 ++++++++-----------------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a2b3f06fa71..f2d00774a84f 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1333,45 +1333,18 @@ static void
 xfs_buf_submit_bio(
 	struct xfs_buf		*bp)
 {
+	unsigned int		len = BBTOB(bp->b_length);
+	unsigned int		nr_vecs = bio_add_max_vecs(bp->b_addr, len);
 	unsigned int		map = 0;
 	struct blk_plug		plug;
 	struct bio		*bio;
 
-	if (is_vmalloc_addr(bp->b_addr)) {
-		unsigned int	size = BBTOB(bp->b_length);
-		unsigned int	alloc_size = roundup(size, PAGE_SIZE);
-		void		*data = bp->b_addr;
-
-		bio = bio_alloc(bp->b_target->bt_bdev, alloc_size >> PAGE_SHIFT,
-				xfs_buf_bio_op(bp), GFP_NOIO);
-
-		do {
-			unsigned int	len = min(size, PAGE_SIZE);
-
-			ASSERT(offset_in_page(data) == 0);
-			__bio_add_page(bio, vmalloc_to_page(data), len, 0);
-			data += len;
-			size -= len;
-		} while (size);
-
-		flush_kernel_vmap_range(bp->b_addr, alloc_size);
-	} else {
-		/*
-		 * Single folio or slab allocation.  Must be contiguous and thus
-		 * only a single bvec is needed.
-		 *
-		 * This uses the page based bio add helper for now as that is
-		 * the lowest common denominator between folios and slab
-		 * allocations.  To be replaced with a better block layer
-		 * helper soon (hopefully).
-		 */
-		bio = bio_alloc(bp->b_target->bt_bdev, 1, xfs_buf_bio_op(bp),
-				GFP_NOIO);
-		__bio_add_page(bio, virt_to_page(bp->b_addr),
-				BBTOB(bp->b_length),
-				offset_in_page(bp->b_addr));
-	}
-
+	bio = bio_alloc(bp->b_target->bt_bdev, nr_vecs, xfs_buf_bio_op(bp),
+			GFP_NOIO);
+	if (is_vmalloc_addr(bp->b_addr))
+		bio_add_vmalloc(bio, bp->b_addr, len);
+	else
+		bio_add_virt_nofail(bio, bp->b_addr, len);
 	bio->bi_private = bp;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 
-- 
2.47.2


