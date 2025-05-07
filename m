Return-Path: <linux-fsdevel+bounces-48362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47EAADE26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE313BBECD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E025F78E;
	Wed,  7 May 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3hQtTGlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF9258CD7;
	Wed,  7 May 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619510; cv=none; b=lq5h+52H/YNdYaumrhC0i7uGLYSacyMafdOPwJ/A66/lPCZX0gJIBIBa44Z8QJzxWkT0Qr7CzeqR1P01sGmUJCSX4o++iVSfemFtbM57FT4e/Gz1HX6ynfdA8Pyz9QxlgdimfXnWHG49pBJCP28hb9rn9G6gDtZUQOJA2mANJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619510; c=relaxed/simple;
	bh=KuBY6LtACbwqb/zFHkXewWq55txMxcrKDbIsj1B3zvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9+LFun1+MDDJPN5tc4+71oXNUlyqRQ473ukNmGGbhYcfHccSTuwS2SorEn5pgKMHF8HqkPywOB6D5xCkbjYMsr3RDVPUq5aoVUJVObT8DOVYoC5cot+Ln0K4YA0qj+eKQey4AVho9UOq3nq6x4rJNiTmhiTbbwQ7f6SJwK9/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3hQtTGlU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JBCkxERCaY17eUam+RKeYBI+iZwFhXND9E1Te3bQWPU=; b=3hQtTGlUhLXnSizxa3hU1XVmUu
	MuW6YydCDnqjXJVLm+U6a70/jmwXutL927D9d6y3ETBfbymL/niMMlfmVtEPRvbghZrKxpFaBHXuZ
	d1uNdQ8p9iBs8g9Q3qw9JCQ0wdAyXxEEEXbXVgRMb14UMvsngYzETOqv4+vVY3rjEV1Oy9Wqk+Lut
	EDpqF/rdUHRjtbo7fLE+pHB/D4+u0E4lAgS1zd4FLsN7414bqMiBu/aY3SOomLVYeF78074RCj+z1
	0q/fILhroFOA4jO/6qV5CGzeJJRxdBJsAad60jWXldAJPajBUyPks3jjiq7vDF0Zi+pxROGQ05Iw0
	mfNCzs+w==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWN-0000000FJ5r-3Vub;
	Wed, 07 May 2025 12:05:08 +0000
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
Subject: [PATCH 04/19] block: add a bio_add_vmalloc helpers
Date: Wed,  7 May 2025 14:04:28 +0200
Message-ID: <20250507120451.4000627-5-hch@lst.de>
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

Add a helper to add a vmalloc region to a bio, abstracting away the
vmalloc addresses from the underlying pages and another one wrapping
it for the simple case where all data fits into a single bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 26782ff85dbf..988f5de3c02c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1076,6 +1076,61 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 }
 EXPORT_SYMBOL(bio_add_folio);
 
+/**
+ * bio_add_vmalloc_chunk - add a vmalloc chunk to a bio
+ * @bio: destination bio
+ * @vaddr: vmalloc address to add
+ * @len: total length in bytes of the data to add
+ *
+ * Add data starting at @vaddr to @bio and return how many bytes were added.
+ * This may be less than the amount originally asked.  Returns 0 if no data
+ * could be added to @bio.
+ *
+ * This helper calls flush_kernel_vmap_range() for the range added.  For reads
+ * the caller still needs to manually call invalidate_kernel_vmap_range() in
+ * the completion handler.
+ */
+unsigned int bio_add_vmalloc_chunk(struct bio *bio, void *vaddr, unsigned len)
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
+EXPORT_SYMBOL_GPL(bio_add_vmalloc_chunk);
+
+/**
+ * bio_add_vmalloc - add a vmalloc region to a bio
+ * @bio: destination bio
+ * @vaddr: vmalloc address to add
+ * @len: total length in bytes of the data to add
+ *
+ * Add data starting at @vaddr to @bio.  Return %true on success or %false if
+ * @bio does not have enough space for the payload.
+ *
+ * This helper calls flush_kernel_vmap_range() for the range added.  For reads
+ * the caller still needs to manually call invalidate_kernel_vmap_range() in
+ * the completion handler.
+ */
+bool bio_add_vmalloc(struct bio *bio, void *vaddr, unsigned int len)
+{
+	do {
+		unsigned int added = bio_add_vmalloc_chunk(bio, vaddr, len);
+
+		if (!added)
+			return false;
+		vaddr += added;
+		len -= added;
+	} while (len);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(bio_add_vmalloc);
+
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct folio_iter fi;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 128b1c6ca648..5d880903bcc5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -433,6 +433,9 @@ static inline unsigned int bio_add_max_vecs(void *kaddr, unsigned int len)
 	return 1;
 }
 
+unsigned int bio_add_vmalloc_chunk(struct bio *bio, void *vaddr, unsigned len);
+bool bio_add_vmalloc(struct bio *bio, void *vaddr, unsigned int len);
+
 int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
-- 
2.47.2


