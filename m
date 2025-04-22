Return-Path: <linux-fsdevel+bounces-46960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCDA96E89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B44189DFF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957428CF62;
	Tue, 22 Apr 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vdeo0FpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5C28C5D3;
	Tue, 22 Apr 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332006; cv=none; b=ZtDwqWlVVB5oZd8ysmN63HXp4TDqnuan4A+hTfggXSpdbaqiUpmtUlqOciKOYHPrPHY2mZD/k3t/5qtX36eFnmTgouMRBkFpELo4aJFmuUNP3OVxC+QR0MTsr9i8R1tdN/EXGSNd8wJo4Zn1GVasW8s8i1sIoDM0acbVIDVIEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332006; c=relaxed/simple;
	bh=2Q39959RjbcmzYtyEixpXqA4yI8Y7gpYS452QNfg3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1BZcgXCtHYyvG0UvFfny0q9I9rulaokuHJicA0BlPmV0ViaUQ7JeC1Y3PdRGz4TsjJEJwnrfYmr6u0ffmpzKvLR5eMDHB1laIpCntZzdVmFyoj9T5jniqnSTVjHdNP3/RKI7f/oVDywxstBVNtfVg3xV0gKacoC6wFoBAl3eQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vdeo0FpR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XsbZTjK8GF3y+2hiJG9TenFomiQFHwiGy10mmBTw+s0=; b=vdeo0FpREuTb3vVm1I/FMXS4au
	jrGceoYi4XL1DoWCGKmNcz5qkY7x0buYx4ALS3/bzY3mBnNPkCxx2ZyBqtKvbHYTLWl4wbbTt7RdY
	A3q7QF4nQ8Jhah8+FpjHHsLADOyPeyu2pPtrolS3/r5gapr8uI5vyIM2azFa5goQbZuHPeNkgSeao
	3VES8ummteH4peHGJXnogsGeCC8luEz0wqAn4RXlZkLfy4W4e37sDYspKDisxNeuK9J1eM288AMiT
	oYwHgWCoYVVr1KAaArwdCg0qJeDej9WXO2KXUD3ijscg5UGmJ5sOgInSlrAsvS66AoHifIwVuwGT1
	idD84OcQ==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EaB-00000007UBi-18Vz;
	Tue, 22 Apr 2025 14:26:44 +0000
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
Subject: [PATCH 03/17] block: add a bio_add_vmalloc helper
Date: Tue, 22 Apr 2025 16:26:04 +0200
Message-ID: <20250422142628.1553523-4-hch@lst.de>
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

Add a helper to add a vmalloc region to a bio, abstracting away the
vmalloc addresses from the underlying pages.  Also add a helper to
calculate how many segments need to be allocated for a vmalloc region.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 27 +++++++++++++++++++++++++++
 include/linux/bio.h | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index a6a867a432cf..3cc93bbdeeb9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1058,6 +1058,33 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 }
 EXPORT_SYMBOL(bio_add_folio);
 
+/**
+ * bio_add_vmalloc - add a vmalloc region to a bio
+ * @bio: destination bio
+ * @vaddr: virtual address to add
+ * @len: total length of the data to add
+ *
+ * Add the data at @vaddr to @bio and return how much was added.  This can an
+ * usually is less than the amount originally asked.  Returns 0 if no data could
+ * be added to the bio.
+ *
+ * This helper calls flush_kernel_vmap_range() for the range added.  For reads,
+ * the caller still needs to manually call invalidate_kernel_vmap_range() in
+ * the completion handler.
+ */
+unsigned int bio_add_vmalloc(struct bio *bio, void *vaddr, unsigned len)
+{
+	unsigned int offset = offset_in_page(vaddr);
+
+	len = min(len, PAGE_SIZE - offset);
+	if (bio_add_page(bio, vmalloc_to_page(vaddr), len, offset) < len)
+		return 0;
+	if (op_is_write(bio_op(bio)))
+		flush_kernel_vmap_range(vaddr, len);
+	return len;
+}
+EXPORT_SYMBOL_GPL(bio_add_vmalloc);
+
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct folio_iter fi;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 17a10220c57d..c4069422fd0a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -433,6 +433,23 @@ static inline void bio_add_virt_nofail(struct bio *bio, void *vaddr,
 	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
 }
 
+/**
+ * bio_vmalloc_max_vecs - number of segments needed to map vmalloc data
+ * @vaddr: address to map
+ * @len: length to map
+ *
+ * Calculate how many bio segments need to be allocated to map the vmalloc/vmap
+ * range in [@addr:@len].  This could be an overestimation if the vmalloc area
+ * is backed by large folios.
+ */
+static inline unsigned int bio_vmalloc_max_vecs(void *vaddr, unsigned int len)
+{
+	return DIV_ROUND_UP(offset_in_page(vaddr) + len, PAGE_SIZE);
+}
+
+unsigned int __must_check bio_add_vmalloc(struct bio *bio, void *vaddr,
+		unsigned len);
+
 int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
-- 
2.47.2


