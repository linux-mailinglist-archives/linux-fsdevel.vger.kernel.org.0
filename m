Return-Path: <linux-fsdevel+bounces-48365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E12AADE3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CED9A565D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D462620CD;
	Wed,  7 May 2025 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6OnIi1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BB259CAE;
	Wed,  7 May 2025 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619518; cv=none; b=LeNgE/35gSMT4l1oAqOCogkn/P7YyyqjW8OREf/WyGtwt9+fkRY1MA6f/EWzxqhRzeFRztQyvft1791KVJiVbRmhpY1z3N6f/egJlWyHdyASO7a6H1RvKSRYZ3ctZQA9pUeWmay2VuBYG0zM1gI7ugNwa1PzaCVOMw7w1JNH9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619518; c=relaxed/simple;
	bh=Tq/+N0YrdpTvPnWlz7LhucM2tphH/RufqyXb5ixfXQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUeCQ1RmAGiA0hdM+cRRRJ3V/g5fQB1qquChmvFOALUix+XoGyikxEXvsj9sRFzs8nf46SxiqMJgFBn7shwsLhT9RpIefaqrp7sXoaW1BFH0OmMqNsPiHkuqWGAEWV2Z1VdlnUvI8r7vI0Qghejgt92flzXfhfUzcOfFvPO7UaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B6OnIi1p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=StOIaxwqTC7rwUI8Vfl4Ox3fGNeZ9G5xhJT3q1h3+20=; b=B6OnIi1pCOc74Md2LOcSVCRYWY
	tAWqTYVJr0oUUEegLQmFTxo18RqTMnT57m5qLl0DvqsOIdMGgqWCwriLpXlf0TtefHRaLRUuSfSeb
	UVNmJwi+zXIUXon/vlbjCDTe3Hr8v+N1kETqlHSAQ/Rhv3iFYrY11mrTu4oCa/3yi6jDUvYjKJMCW
	riigL/l9CBPn6393XhYkjsqyX1O82nfaFf2cE/G5u9K6tt73i9L5KdOD87rHTuTdmXmEo7S5v8fO1
	/g3JHsW7slT2UwqAQU8jLE8pSKHwmhflsfgDK8bqpRE5qVQqcw0SvZMrwBE1POshYO6ql1z8QbJdh
	qpMCHvsA==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWV-0000000FJ8D-2zm6;
	Wed, 07 May 2025 12:05:16 +0000
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/19] block: simplify bio_map_kern
Date: Wed,  7 May 2025 14:04:31 +0200
Message-ID: <20250507120451.4000627-8-hch@lst.de>
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

Rewrite bio_map_kern using the new bio_add_* helpers and drop the
kerneldoc comment that is superfluous for an internal helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-map.c | 56 ++++++++-----------------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 6f0bfe66b226..23e5d5ebe59e 100644
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


