Return-Path: <linux-fsdevel+bounces-46962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259DA96E8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA835441421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948382857FA;
	Tue, 22 Apr 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3lsoS+UI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394728D82C;
	Tue, 22 Apr 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332014; cv=none; b=AeFffKvBrfHXIQ6jO/eEbf+lQ0nfvaK3rsa+vRkEWu4CMhygp8cnSlHKjgsyChkWyrhVORhhot5PE13mywqA3TkFczn2SVf6PqZMnXwAOHxbRPAqXrWc0G8I+wOUHzF8PTgykoAEGCfUisqspFoQb7Q27pXSGhFqFL0t6/vBtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332014; c=relaxed/simple;
	bh=GMnJNbh0bnbr/uv68Ua2bLyZHcwg1WRKJh0UI49DiWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMOm5wRYoFOX3zAZfl1LDA0QBIodqRJ1ZxBDk70c9/AeQUQzYz6j9+J5yGpcNFAB50Vljz3sYSe08uKJsSc8cShutnUck+LrqiFh5wny5rRUh9vvTwkuL1+4izo9y3Fyc3VB+n8mhHxZBqO3MM3Ts1H4MkWdzvaW1i4Yy81F10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3lsoS+UI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gpFSbLsEYB6IrecbF+TRA56loOF2u1prsLZbOWmJLPo=; b=3lsoS+UIHCzmaOUVYwGLgbmzyz
	APy0guHvr/3MBkJDQy8vJ9beq87zuNXgI8FPv7CbrVsRFuJAz8hjp3Dj6kzEbn5tyRapWVfsy5lXI
	sy6S8JOoia+3wCOxqoKEJp6nIqoR0ajLD/6QlB/tipTIxaWRkARwtNLICeXdg3dfX9GQMC08dPSAD
	cXABk/Ndylz6Rjk1qY8OI6alFiUoOaYHvl7gIc7vabKtvoOMPEyol+0iyqXR5JdY1/86A0hh7Um/7
	BUkZO1aO7pSMlXiRTkD8cHBrjmy/g3NBCj5eu6TWv+UQULgU6qd+CCR6fNQvbuHLCFz6k+JtuFf4F
	zr3WJHUA==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EaJ-00000007UFV-0flJ;
	Tue, 22 Apr 2025 14:26:51 +0000
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
Subject: [PATCH 05/17] block: pass the operation to bio_{map,copy}_kern
Date: Tue, 22 Apr 2025 16:26:06 +0200
Message-ID: <20250422142628.1553523-6-hch@lst.de>
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

That way the bio can be allocated with the right operation already
set and there is no need to pass the separated 'reading' argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


