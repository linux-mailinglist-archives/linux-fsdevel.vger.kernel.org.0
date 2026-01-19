Return-Path: <linux-fsdevel+bounces-74389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3836D3A04E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7701302AFAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFF3382D9;
	Mon, 19 Jan 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCbzFiBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74C33067F;
	Mon, 19 Jan 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808688; cv=none; b=aypjRndt1pW7uJVFM0nEr6Pvk0c//rhZ444AJqU0OLdH0Q5BAHdR0aMAslj+xwmmb+c6n5bE9yvwk3WCD7xUa+0SgixcS+MQCzVZAFe7KYvxiW/wwkuOEbsosbYCVKPdcCmdPkhCm+RG442FrWelKZuxpbAkzuFTQEuJT1WI550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808688; c=relaxed/simple;
	bh=J+KBiBEpqOXmUetU9CsIrd2dVIUKC3jcOklxrWqsEV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWlFlJObQWbP1qHVmhIpSqq7sA8+pnyQaHzYGzF2Ynt02IIUAqRx56tE94PB2IlNqXjNVPSENTglymHjSgCNzFiizDUp496bNP8HngNzQzNHkbLhMYR/FCGzxwIR8LjmtqZcwce2sCc9oU2JhLbpOFmeU4EnRlkLL32HM4/ghTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YCbzFiBg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gpoY2tjfq2znL/riDumaQTv31IJvykNZ6zAT3janN6U=; b=YCbzFiBgzNDKha8Zru+miESPNp
	g0xm5pJxKRGCbZtVkk6AhkQDfUCI5uDdhATLaIyRHCxwAz7JxjcUxq4YLTjvWovzTe8W50a8s89kf
	VJ/fMi4frwxD/M/k02cUwdYMN8bXNQpbmj0vsSceh4E/N4xeVUBI7Ej8GVlELi38JzjM98qgLqM+o
	hmHf+pxN1XVWQdpFJ2s/x1zHvvq6VP3dOdf+wIXEnprcoU85mC+lWh6JHHGbeeHyNa2jjfp1aDaDn
	qpHqGHrYmqxykZH4git4ZJes65cj63NCSRrXuLjUHSCHDZTNGZPOD3VEPbBAfuicg3z3LkuCqYV6C
	CwVRljiQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwM-00000001WAj-0OqD;
	Mon, 19 Jan 2026 07:44:46 +0000
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
Date: Mon, 19 Jan 2026 08:44:11 +0100
Message-ID: <20260119074425.4005867-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
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
index 12cd3c5f6d6d..c51b4e2470e2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1195,7 +1195,9 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
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
index 980eef1f5690..886238cae5f1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -595,17 +595,6 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
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


