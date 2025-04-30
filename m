Return-Path: <linux-fsdevel+bounces-47768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05264AA56E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435C07BE7FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DF2D0AD1;
	Wed, 30 Apr 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGWqT+St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B42D0AA0;
	Wed, 30 Apr 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048132; cv=none; b=MI7j316JtjSWp3lER8Jd/Q89jlwcok/9aSNzbXZGBHjjAWGksa1B2GF0Qv01T7I/lYXUjleU0MTEb8jGQZ8REbksKWeLeohyyN7Fp2JMdn7GXp8fz8JOQj+d/bOy8IJha0xc9CIAG1Uj4D7bEoqVjJ512jLldk5Enj3vp8PxtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048132; c=relaxed/simple;
	bh=BpJF4NGDkSTGDV9LdSq1zgHzPe35LFQ3nkdm+lCnFnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qazzX1yfx+mNxZGYpalTs1fqIV3WHOWfVCwfseH6oj2DmoouJPPLz9mdrWGtNCKRjzc+5vSOQHIIgZIeOEugzHVGi1qcDC6rIvVNTXyyLwVoJspCrv2vLvdgXAzQ5Et07ztn4AyzCoaZwJFz6zH3nweY/evM4bzdstIcG5xgU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VGWqT+St; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=76E7tD7ociy3CC2IELQesb+33+NqL8JeK+ACYOG3Lfk=; b=VGWqT+StPZtob8DITiQIbH7L6n
	AIcDjiHAucnlvazBY7lQF6Wirb//tSCFDYKmVRaogxqHPLYH5k0UbzBQvmMYbjRUzw5dr5RswEtma
	ZDLW0wlDMiBiXWJbEpvXp5zRe0IK8AlyH/WWwozEQ7BafOfnYkN72fNH85HfwbgdLJW9Meixbq2FQ
	h7LvsFXHKbsm68AhiZLBI81BZ3ffBYipt1WRvrAyM6ka51iMW5AQELi54sHih54b337VMCeCtMHof
	mp0g6aT9YEC6vJzjCH6tvMTXZcdRNOeo4+OyxxPBC4P89DIzoKKi6393xFuxZu9dkAFzc3PbVEK1e
	nfpthmbA==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsc-0000000E2Wg-0K8C;
	Wed, 30 Apr 2025 21:22:10 +0000
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
Subject: [PATCH 03/19] block: add a bio_add_max_vecs helper
Date: Wed, 30 Apr 2025 16:21:33 -0500
Message-ID: <20250430212159.2865803-4-hch@lst.de>
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

Add a helper to check how many bio_vecs are needed to add a kernel
virtual address range to a bio, accounting for the always contiguous
direct mapping and vmalloc mappings that usually need a bio_vec
per page sized chunk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad54e6af20dc..128b1c6ca648 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -418,6 +418,21 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
 void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len);
 
+/**
+ * bio_add_max_vecs - number of bio_vecs needed to add data to a bio
+ * @kaddr: kernel virtual address to add
+ * @len: length in bytes to add
+ *
+ * Calculate how many bio_vecs need to be allocated to add the kernel virtual
+ * address range in [@kaddr:@len] in the worse case.
+ */
+static inline unsigned int bio_add_max_vecs(void *kaddr, unsigned int len)
+{
+	if (is_vmalloc_addr(kaddr))
+		return DIV_ROUND_UP(offset_in_page(kaddr) + len, PAGE_SIZE);
+	return 1;
+}
+
 int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
-- 
2.47.2


