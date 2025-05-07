Return-Path: <linux-fsdevel+bounces-48364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C20EAADE3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE74B7B2FCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D274325F969;
	Wed,  7 May 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYT1/Vn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA3259CAE;
	Wed,  7 May 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619515; cv=none; b=uuhG54sF3aJ3cMFCIEAMM7qqh3Lx1R12BytEX4ciVtQ/8SGsU2riYJMyP4Fvs8lrq46pYhRBvGU/rp2V8PKM41EI8DuyBTEbk6MC1fC+3FvzY+RjIEi+pGx8B+c3SwuZDZvGqZew8PHZ4akTqhXINLs4wgPh+I9J+Gq39wrfWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619515; c=relaxed/simple;
	bh=lGum6XD4zXcxWG6XBrr2nlok4UfN4Na63b1CC8fd0Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSjzVYr7JgvKX8jBMnqzUB2ovP6O9A+1T3zP7nkRHZJytV+Q4lTOcclglkJ16D5yDXC9tLAzT4JRp8Ygv36dgByPj1rGvw7qyOMAmuTn+E/1w5i5Pa8qwJphQ8HZVBBHPAO4nQQKPk0fkDyx6TD4Ihq+8cTGjNGEid5Cwr+cHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qYT1/Vn2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=01ogqu/uwla1l06qiy/NTfgzurLpoZhQuGl5N8B6zqI=; b=qYT1/Vn2iPjLrN4cZHPLEeMv+m
	e/OeZ5+jeo/49yyTIZnb4mn5aflXaSMPULnBnJIUfl0Q1oDn/op5qAEHXmV/Sn6dsIbkay9UNAWG5
	5XYtyDlUZPlKeG8RUGiEynpbSB0BcuIF4U1jEuCKELRw7C+cuwY6D4RcQKaWXug4Vs9Y+rmkL8/Iq
	XoGSeB35GW1qQbm/07e+dW1gar0l7spU5/reHxgNUUN1izguR8yB/XgT0YCmxTHwLrHAE2NsOyo/+
	4qTR25ZQVJAht31s10+Fl++akofJk1hURVMM7JTRKqlrvi3/xrZCWWw2MGe3HMlXWTfhmgolbY3vI
	AQHzKxbA==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWS-0000000FJ7Y-4BVn;
	Wed, 07 May 2025 12:05:13 +0000
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
	linux-pm@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/19] block: pass the operation to bio_{map,copy}_kern
Date: Wed,  7 May 2025 14:04:30 +0200
Message-ID: <20250507120451.4000627-7-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

That way the bio can be allocated with the right operation already
set and there is no need to pass the separated 'reading' argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-map.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9002cfe855b9..6f0bfe66b226 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -321,12 +321,14 @@ static void bio_map_kern_endio(struct bio *bio)
  *	bio_map_kern	-	map kernel address into bio
  *	@data: pointer to buffer to map
  *	@len: length in bytes
+ *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio allocation
  *
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(void *data, unsigned int len, gfp_t gfp_mask)
+static struct bio *bio_map_kern(void *data, unsigned int len,
+		enum req_op op, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -340,7 +342,7 @@ static struct bio *bio_map_kern(void *data, unsigned int len, gfp_t gfp_mask)
 	bio = bio_kmalloc(nr_pages, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, 0);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, op);
 
 	if (is_vmalloc) {
 		flush_kernel_vmap_range(data, len);
@@ -402,14 +404,14 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	bio_copy_kern	-	copy kernel address into bio
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
+ *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio and page allocation
- *	@reading: data direction is READ
  *
  *	copy the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_copy_kern(void *data, unsigned int len, gfp_t gfp_mask,
-		int reading)
+static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
+		gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -428,7 +430,7 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, gfp_t gfp_mask,
 	bio = bio_kmalloc(nr_pages, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, 0);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, op);
 
 	while (len) {
 		struct page *page;
@@ -441,7 +443,7 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, gfp_t gfp_mask,
 		if (!page)
 			goto cleanup;
 
-		if (!reading)
+		if (op_is_write(op))
 			memcpy(page_address(page), p, bytes);
 
 		if (bio_add_page(bio, page, bytes, 0) < bytes)
@@ -451,11 +453,11 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, gfp_t gfp_mask,
 		p += bytes;
 	}
 
-	if (reading) {
+	if (op_is_write(op)) {
+		bio->bi_end_io = bio_copy_kern_endio;
+	} else {
 		bio->bi_end_io = bio_copy_kern_endio_read;
 		bio->bi_private = data;
-	} else {
-		bio->bi_end_io = bio_copy_kern_endio;
 	}
 
 	return bio;
@@ -697,7 +699,6 @@ EXPORT_SYMBOL(blk_rq_unmap_user);
 int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 		gfp_t gfp_mask)
 {
-	int reading = rq_data_dir(rq) == READ;
 	unsigned long addr = (unsigned long) kbuf;
 	struct bio *bio;
 	int ret;
@@ -708,16 +709,13 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 		return -EINVAL;
 
 	if (!blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf))
-		bio = bio_copy_kern(kbuf, len, gfp_mask, reading);
+		bio = bio_copy_kern(kbuf, len, req_op(rq), gfp_mask);
 	else
-		bio = bio_map_kern(kbuf, len, gfp_mask);
+		bio = bio_map_kern(kbuf, len, req_op(rq), gfp_mask);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	bio->bi_opf &= ~REQ_OP_MASK;
-	bio->bi_opf |= req_op(rq);
-
 	ret = blk_rq_append_bio(rq, bio);
 	if (unlikely(ret)) {
 		bio_uninit(bio);
-- 
2.47.2


