Return-Path: <linux-fsdevel+bounces-46963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED623A96E92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DDB16975B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBD28EA44;
	Tue, 22 Apr 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kf+sEdtp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB628D85F;
	Tue, 22 Apr 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332018; cv=none; b=fL8ieZ8kr1W0MoYLr//EdHxrxIwhWVhr5ddiv2UPNNTrhSBoSJ2ra+5lFlS9YKG6oPedw+wvxexYPuxgYNL0pkW8l24QsWSKz/8J3IFDxlzzDwdwu7DYpt02EhGvBye7enxcJP0h3dZh0k1gPTcXqXOKfxFz3wvQPS72tIdnx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332018; c=relaxed/simple;
	bh=RN6qr8KB++sqobdLpxCpzJaSPfLTSEeR7g4wEByxwq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBFE0eiYcnbyUSL3ENyBM4WuZMss5uY5BtaCQufHLBuiFJ2LpdJZafEOSYkA83i1TZOl9tmM6n7mPDfdzA9OZB1tEeR7JCnKjt1f7EYuuRp3+o1tYrbMhApCuhD1VmnwfQT8GKPgW6/951g2ULUEUH31pRHSpzS0PyvB4W+XyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kf+sEdtp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=68Tn1igUt/JuNfW5rEJJVB2i5Asl84FEzAf7uiXqVqg=; b=kf+sEdtpUl9ArNeaOoHDHLJ2Eb
	iRYhi98H8H541OTEK0noVq/b+svjEndl7YPBXkqssBmo2z+lLhHd092joMhIwfksRmYzOkrOPNaV2
	x89Gj3WFp4F2IbCDMBfqFSEwpQV2VAPvK+PM4K7GhP/c3WgiOe+Aih0EWz2u5jWUon0DhDccx11i4
	mifmjWJdT4N1D2ue05+/wxC6Jzk0h3JC0HTzJpMc6YPPz0yrGmyYeIBOUdOjK3afp9Pzz0fIrz/ht
	CEsbU8wPOVbC/xUtTyjKUUhMwHcw8i51Wk/cqMWzZvB3A2vIJlKHQDlXycETOwP6yvkVkyS+gohai
	Pum2n8dA==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EaN-00000007UHd-0uxe;
	Tue, 22 Apr 2025 14:26:56 +0000
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
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 06/17] block: simplify bio_map_kern
Date: Tue, 22 Apr 2025 16:26:07 +0200
Message-ID: <20250422142628.1553523-7-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422142628.1553523-1-hch@lst.de>
References: <20250422142628.1553523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split bio_map_kern into a simple version that can use bio_add_virt_nofail
for kernel direct mapping addresses and a more complex bio_map_vmalloc
with the logic to chunk up and map vmalloc ranges using the
bio_add_vmalloc helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 74 +++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index ca6b55ac0da1..7742d3cb0499 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -317,65 +317,47 @@ static void bio_map_kern_endio(struct bio *bio)
 	kfree(bio);
 }
 
-/**
- *	bio_map_kern	-	map kernel address into bio
- *	@data: pointer to buffer to map
- *	@len: length in bytes
- *	@op: bio/request operation
- *	@gfp_mask: allocation flags for bio allocation
- *
- *	Map the kernel address into a bio suitable for io to a block
- *	device. Returns an error pointer in case of error.
- */
-static struct bio *bio_map_kern(void *data, unsigned int len,
-		enum req_op op, gfp_t gfp_mask)
+static struct bio *bio_map_virt(void *data, unsigned int len, enum req_op op,
+		gfp_t gfp_mask)
 {
-	unsigned long kaddr = (unsigned long)data;
-	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	unsigned long start = kaddr >> PAGE_SHIFT;
-	const int nr_pages = end - start;
-	bool is_vmalloc = is_vmalloc_addr(data);
-	struct page *page;
-	int offset, i;
 	struct bio *bio;
 
-	bio = bio_kmalloc(nr_pages, gfp_mask);
+	bio = bio_kmalloc(1, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, op);
-
-	if (is_vmalloc) {
-		flush_kernel_vmap_range(data, len);
-		bio->bi_private = data;
-	}
-
-	offset = offset_in_page(kaddr);
-	for (i = 0; i < nr_pages; i++) {
-		unsigned int bytes = PAGE_SIZE - offset;
+	bio_init(bio, NULL, bio->bi_inline_vecs, 1, op);
+	bio_add_virt_nofail(bio, data, len);
+	bio->bi_end_io = bio_map_kern_endio;
+	return bio;
+}
 
-		if (len <= 0)
-			break;
+static struct bio *bio_map_vmalloc(void *data, unsigned int len, enum req_op op,
+		gfp_t gfp_mask)
+{
+	unsigned int nr_vecs = bio_vmalloc_max_vecs(data, len);
+	unsigned int added;
+	struct bio *bio;
 
-		if (bytes > len)
-			bytes = len;
+	bio = bio_kmalloc(nr_vecs, gfp_mask);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, op);
+	bio->bi_private = data;
+	bio->bi_end_io = bio_map_kern_endio;
 
-		if (!is_vmalloc)
-			page = virt_to_page(data);
-		else
-			page = vmalloc_to_page(data);
-		if (bio_add_page(bio, page, bytes, offset) < bytes) {
+	do {
+		added = bio_add_vmalloc(bio, data, len);
+		if (!added) {
 			/* we don't support partial mappings */
 			bio_uninit(bio);
 			kfree(bio);
 			return ERR_PTR(-EINVAL);
 		}
 
-		data += bytes;
-		len -= bytes;
-		offset = 0;
-	}
+		data += added;
+		len -= added;
+	} while (len);
 
-	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
 
@@ -713,8 +695,10 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 	if (!blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf) ||
 	    blk_queue_may_bounce(rq->q))
 		bio = bio_copy_kern(kbuf, len, req_op(rq), gfp_mask);
+	else if (is_vmalloc_addr(kbuf))
+		bio = bio_map_vmalloc(kbuf, len, req_op(rq), gfp_mask);
 	else
-		bio = bio_map_kern(kbuf, len, req_op(rq), gfp_mask);
+		bio = bio_map_virt(kbuf, len, req_op(rq), gfp_mask);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
-- 
2.47.2


