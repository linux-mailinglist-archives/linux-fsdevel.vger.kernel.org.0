Return-Path: <linux-fsdevel+bounces-47772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D700AA56EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE8D1C23FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7132D819C;
	Wed, 30 Apr 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zGtqvVP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DB2D8186;
	Wed, 30 Apr 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048143; cv=none; b=eEZ+8cBexJ0eeg5+PjXMvXzwNyppg2iG89as6jcMAeW7owt6qz47XCol6ZxqzX+hO0R1Ne/7/c1yCBe6BoQ3S7tnRiG+OpN/hsQMbcODp79p5+NYyMn4G4kBa6ZbzCCSaqb75DngGpNlXW4l80oPGzdpTaAK1tTmwx6HIyIlyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048143; c=relaxed/simple;
	bh=zyN31dQCUk7Kj8NYuiLclol2iN4sWzjl3zrmDzKjbWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMshjcaJ75+6FoHPuhaKJBTsjF5A3heQXVT9fwB4ho1hAKs6vORt9JBEYzaDepktBwNyh87uDSijnSq8sakwQ4hWiwgukzgfXZNGpMmUYmAgRJXpvJFj67TF6vig7BL/G56jm7GYMkg1nQHcvOqv63fPyrRYjGqc7KbOLQACZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zGtqvVP2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MDYAE+wTkZKlt1ipq2OI7rC2CgptbVzDvIWendsvrRI=; b=zGtqvVP287T0XCsR1sDQnnxuzf
	toZ4rcATDdxd3LG50bZUHPFEILRUdjlyBUq6Rg8QPJdIjHJTIzg0vbA+qwt/jNT3W+RkkV7Xt0HNj
	X7NuPP0C9T8vljKY0nicTOCj4rzCsKa6dU6i1q+2C0zlswn+/t/qrolo0zGl66m5Dz7TK946Yn3Oq
	girDN8GIvb7Ikwl3R4Xr6y+QVW/X2mwm53uStKMLm5ApEQHu0rtLAsPBX0B3XJVz+yy/cvEvoE2tN
	0zYIaSE7td+GNC6mDOl4nusZgh+ItPuXpZjCIS8lgtWQquAeVAP7K5qr/njTLpTxav5D270zq4f7V
	fQNhJEAg==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsm-0000000E2ZO-3pUU;
	Wed, 30 Apr 2025 21:22:21 +0000
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
Subject: [PATCH 07/19] block: simplify bio_map_kern
Date: Wed, 30 Apr 2025 16:21:37 -0500
Message-ID: <20250430212159.2865803-8-hch@lst.de>
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

Rewrite bio_map_kern using the new bio_add_* helpers and drop the
kerneldoc comment that is superfluous for an internal helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 56 ++++++++-----------------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index ca6b55ac0da1..0bc823b168e4 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -317,64 +317,26 @@ static void bio_map_kern_endio(struct bio *bio)
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
+static struct bio *bio_map_kern(void *data, unsigned int len, enum req_op op,
+		gfp_t gfp_mask)
 {
-	unsigned long kaddr = (unsigned long)data;
-	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	unsigned long start = kaddr >> PAGE_SHIFT;
-	const int nr_pages = end - start;
-	bool is_vmalloc = is_vmalloc_addr(data);
-	struct page *page;
-	int offset, i;
+	unsigned int nr_vecs = bio_add_max_vecs(data, len);
 	struct bio *bio;
 
-	bio = bio_kmalloc(nr_pages, gfp_mask);
+	bio = bio_kmalloc(nr_vecs, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, op);
-
-	if (is_vmalloc) {
-		flush_kernel_vmap_range(data, len);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, op);
+	if (is_vmalloc_addr(data)) {
 		bio->bi_private = data;
-	}
-
-	offset = offset_in_page(kaddr);
-	for (i = 0; i < nr_pages; i++) {
-		unsigned int bytes = PAGE_SIZE - offset;
-
-		if (len <= 0)
-			break;
-
-		if (bytes > len)
-			bytes = len;
-
-		if (!is_vmalloc)
-			page = virt_to_page(data);
-		else
-			page = vmalloc_to_page(data);
-		if (bio_add_page(bio, page, bytes, offset) < bytes) {
-			/* we don't support partial mappings */
+		if (!bio_add_vmalloc(bio, data, len)) {
 			bio_uninit(bio);
 			kfree(bio);
 			return ERR_PTR(-EINVAL);
 		}
-
-		data += bytes;
-		len -= bytes;
-		offset = 0;
+	} else {
+		bio_add_virt_nofail(bio, data, len);
 	}
-
 	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
-- 
2.47.2


