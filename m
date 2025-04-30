Return-Path: <linux-fsdevel+bounces-47771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D9AA56E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDE7503DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723652D7AF9;
	Wed, 30 Apr 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ogm5d+Oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA12BD93D;
	Wed, 30 Apr 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048140; cv=none; b=NJpUl1ciTkAq/KtbwdzryNDN2piDdQbWOrn7fMCBD2WA6JK/niPBXoOph9vLefMHjnV4GvNfYvCQX50pSvk0mrjQZrRAhccvJdC79kMxnSKFDrp7Z7nUNackFfo83SEMpmesurSVWJMINYJFwwjxU7tCQ+yR1ecpI3ECLIuoybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048140; c=relaxed/simple;
	bh=f/SCktuVLQ3i76ed/sgw4S/2ksk+BmCglPIcaaQvhko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzTXKqXv38F4PkJWyOYG34IWJpX/ydbGDpsABR3x5sGYAOsyAQuBCmTpLfI6574dFXChl3X7ByfV3BkZDDHhV1ZxwKxK1sWyMe4QMH7fLiDVyIfQYSXK0hUAg1MFdQwwyPiNJ7wuS/ONFQ42lgGO3fhfEkiDLe1/xOZhVQYZ1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ogm5d+Oa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hWWdHC5y/JUq54b2u3PyEO5FfJhHi9A7bx3OXutuWMk=; b=ogm5d+OaNwwwAbG787lUCQvMkL
	jc99GRrS1knW++uOrAV9CiNE4R37GwofC6rShRlRLk9XXJa1yL8apLiMnYJ6eiVeP8kgISUycP+8W
	DcuOQ4INKIhua8fDKvnNtxq4Iq6dH12H4dp0T5t3UPxGOiB20FgGLi+LG6QwUA8rAcvkZ1zmnA8cq
	nIsTI2h6NTXO3A2jx6cMR15tdFa40OrGy72fBwyOXG7C64qe4kPHIb3V4dt3edAvtFQlN7uDkDrOy
	JO3CgNKz/7rF01YOQP7GhIEv9LQBluY+FrUFgoAtNFedJvaCzv12gYjcKJhnBVuOp7OENsZVFr+6l
	cCwhlvJg==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsk-0000000E2Ym-14xO;
	Wed, 30 Apr 2025 21:22:18 +0000
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
Date: Wed, 30 Apr 2025 16:21:36 -0500
Message-ID: <20250430212159.2865803-7-hch@lst.de>
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
index 0cbceb2671c9..ca6b55ac0da1 100644
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
@@ -699,7 +701,6 @@ EXPORT_SYMBOL(blk_rq_unmap_user);
 int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 		gfp_t gfp_mask)
 {
-	int reading = rq_data_dir(rq) == READ;
 	unsigned long addr = (unsigned long) kbuf;
 	struct bio *bio;
 	int ret;
@@ -711,16 +712,13 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 
 	if (!blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf) ||
 	    blk_queue_may_bounce(rq->q))
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


