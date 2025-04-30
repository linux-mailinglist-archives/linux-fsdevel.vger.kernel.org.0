Return-Path: <linux-fsdevel+bounces-47767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C086CAA56D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47A54E5B36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E72D5D17;
	Wed, 30 Apr 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tleX5N/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6182D0ABA;
	Wed, 30 Apr 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048130; cv=none; b=NUsf9nLLOO7n1NYYjSaR+6CNRJ4dT7rjPJXSWd/h3nseG97k+Neg+zU12dcMYSe+KmCz/Yc8pSP6KNQPfQH5ue1TzdBJgvSYNGD06QdWYXYI/Jsx236XKw22NsK/0OMqPjC7h5Y1qF+6cMTjIiuwV2UJYZwNlAZqR9kRbFzJpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048130; c=relaxed/simple;
	bh=KQD/7aUDcPfshCdC5wrOSoSgHOUfjW1/T4FjifhZ6r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPs5hes0QD/7e6nPcY5Thv9jizg/QzRRzW7/Y9ads2RrI9jh52jE3BLA9HHnMj1F55LFd3lBMm4eFRnAcFkZE/mQReFHxE9Wv4cHJs2pcMoJtQSsFdH8CzZEFl/0w2tKaK3MNvx50Qm4K1Qarkg2AGHmH0j/XOAVihYjdzJ+1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tleX5N/H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4AZ0e83YSqqAexI5BVOxX9+ELnf7u8xLP48RyNUi7l8=; b=tleX5N/H71n2VPQLiexI2uffp1
	VVCcJ1IGTO8kx6Zh8C8J62/4JPNvTJfg1dc88FLlBSm61AJv+lT4BZ+kLo4X6FWftrqBU8NewpgJJ
	w5HBokATVRlZTOKJPsHPPCDXZOCeATp0p4ohb1aIJXWh304sdrbUXUWCt30O8jkXtQ6y2ZZQUMF49
	we26MtMMuGS+KrVmrXho4EkGESBQRNpaHZAPXyCGXDtmS1L35QDMf46eW3q2dQiXMoWsPpCV3UT7b
	wkK/21Sv291QRSNR8RMpsA48JgZCOdSVgMu8YTrXhDvK2IcCc0h3m3MvCbJwcg/m7M1XUhWTKsjVK
	H0naRcNA==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsZ-0000000E2WL-1ADo;
	Wed, 30 Apr 2025 21:22:07 +0000
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
Subject: [PATCH 02/19] block: add a bdev_rw_virt helper
Date: Wed, 30 Apr 2025 16:21:32 -0500
Message-ID: <20250430212159.2865803-3-hch@lst.de>
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

Add a helper to perform synchronous I/O on a kernel direct map range.
Currently this is implemented in various places in usually not very
efficient ways, so provide a generic helper instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 30 ++++++++++++++++++++++++++++++
 include/linux/bio.h |  5 ++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index c1789a58f23f..8db2db0bba0f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1317,6 +1317,36 @@ int submit_bio_wait(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_wait);
 
+/**
+ * bdev_rw_virt - synchronously read into / write from kernel mapping
+ * @bdev:	block device to access
+ * @sector:	sector to access
+ * @data:	data to read/write
+ * @len:	length in byte to read/write
+ * @op:		operation (e.g. REQ_OP_READ/REQ_OP_WRITE)
+ *
+ * Performs synchronous I/O to @bdev for @data/@len.  @data must be in
+ * the kernel direct mapping and not a vmalloc address.
+ */
+int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
+		size_t len, enum req_op op)
+{
+	struct bio_vec bv;
+	struct bio bio;
+	int error;
+
+	if (WARN_ON_ONCE(is_vmalloc_addr(data)))
+		return -EIO;
+
+	bio_init(&bio, bdev, &bv, 1, op);
+	bio.bi_iter.bi_sector = sector;
+	bio_add_virt_nofail(&bio, data, len);
+	error = submit_bio_wait(&bio);
+	bio_uninit(&bio);
+	return error;
+}
+EXPORT_SYMBOL_GPL(bdev_rw_virt);
+
 static void bio_wait_end_io(struct bio *bio)
 {
 	complete(bio->bi_private);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index acca7464080c..ad54e6af20dc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -402,7 +402,6 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 
 struct request_queue;
 
-extern int submit_bio_wait(struct bio *bio);
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, blk_opf_t opf);
 extern void bio_uninit(struct bio *);
@@ -419,6 +418,10 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
 void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len);
 
+int submit_bio_wait(struct bio *bio);
+int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
+		size_t len, enum req_op op);
+
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.47.2


