Return-Path: <linux-fsdevel+bounces-73626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E1D1CEC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F193B300F67B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0D37B40A;
	Wed, 14 Jan 2026 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0/jrjusH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B22F5306;
	Wed, 14 Jan 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376541; cv=none; b=OwLYCRDFIot4gTh+r97M5W+p8b3gF88BcyU8nUplAJSDV3w0nhEDkLvGog9knYwT+pscnrDF+PGEHSzootzIY94QSp9C9YJXKQHaIyWDVefhRR0eDuB5RYxL1IyEuuAfZ9jSsVB5tHQFBR+4PKy1dS+H9NJfLJ4BN7jiy2KPK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376541; c=relaxed/simple;
	bh=o3rV8u9AH+2TFTpRtvIjh96tRz/5QSiImONYPL54Df8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxPOYOc+A4+Op9lm1/s3jHJL2Y2UK+e1Su3au1fQO6cPbUmUUb/CvG/rMDzqmRd8ozCpX27251OjxJS4JhBs3HTOBzYQA83DQ08iHivuQA+/pW4QLkmeYJatD4EVcSdE8exRVv+7cYBst4p0hshgGIy5ToVRod6j2hQEwM3ttVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0/jrjusH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=as8HcMKT2uqOPz1FyW4HXgF5bpxdoCChRWoUdrF4kjc=; b=0/jrjusHgkdox514AHqAkZf/P0
	LW0Iy8mBo0BaaHKHkEZMIbLFPQlGRjQRoFfg7NWR/K5O85V4HJjbHxbd/j2zuC306rfyfHaxapjVF
	WAjgq/eisGMUr3upJyZU/8oMQj8WoW0xWaUCJY+4WEuSjuCNL2Zwyhe1grt4I4tO2zMOi+zhi+ne7
	GpmYltUiRgLuRnPxW+XV1L4mZHuiq0xjZ+81KWVqYqHGR2tV/c4dfcw8SOdJO3mnyCAcA2eH7fBKb
	xmFVaGKI3+NlJ/FxIA5cghpcjQZx9kUJBo0VX4tCmm7CmO8L2R0Y0cDgxOrxdDQsJ5waphALB0rUH
	omu2Q95Q==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWA-00000008Dqv-38Dz;
	Wed, 14 Jan 2026 07:42:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/14] block: remove bio_release_page
Date: Wed, 14 Jan 2026 08:41:02 +0100
Message-ID: <20260114074145.3396036-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Merge bio_release_page into the only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c |  4 +++-
 block/blk.h | 11 -----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9cd1193ed807..0955fe8b915e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1192,7 +1192,9 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 			break;
 		}
 
-		bio_release_page(bio, bv->bv_page);
+		if (bio_flagged(bio, BIO_PAGE_PINNED))
+			unpin_user_page(bv->bv_page);
+
 		bio->bi_vcnt--;
 		nbytes -= bv->bv_len;
 	} while (nbytes);
diff --git a/block/blk.h b/block/blk.h
index e4c433f62dfc..83b3cfa7dfe8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -589,17 +589,6 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
-
-/*
- * Clean up a page appropriately, where the page may be pinned, may have a
- * ref taken on it or neither.
- */
-static inline void bio_release_page(struct bio *bio, struct page *page)
-{
-	if (bio_flagged(bio, BIO_PAGE_PINNED))
-		unpin_user_page(page);
-}
-
 struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
-- 
2.47.3


