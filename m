Return-Path: <linux-fsdevel+bounces-47765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDCAA56C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DB59E7503
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A352D4B6B;
	Wed, 30 Apr 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+ofx2nx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD32BD93D;
	Wed, 30 Apr 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048128; cv=none; b=YZjXh5iTz4jczxf+FtcnUO9GP8WcIHPDuA19ei1Yw+Un2+bexzIA0+AJSk1ZRCgudPyIIyIOduu0zqIVVdXfyPhaBPAfahqtV56336w+8AIOdt8t37257UiwlDTJcHZyXuZ7m/W3EHAXqXhfoAY1HtKeudTm69KAzAw44cPzryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048128; c=relaxed/simple;
	bh=sWO2f/PxHT1FPtFUalwag2d9hPPO/aR7oKxfBHK7ykw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjBSIoVHgjCBQTOwFcojQT2DOmKg+sRgdT2nntV+FCbt6TiNysNflPSLjhYKoxJaWgWQ7gbhvNG6IoRd49WfzTy8ngsd6dmV8/Ip4BHaHwgZnVcy6Mb29esVufEvYETZfLGXuCUU6GYMv1s5+TlCPTjSu6xUUMgtjZPHmDQ9xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D+ofx2nx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=R5NIVw/93J/inPIJ3/N2tOuwD8pOE89NikFOGZTqiC4=; b=D+ofx2nxOGw3yGY/8psrCG4CGg
	wSpsZV3SlGqkToRY30U+M8OwT2tIVU2BU9Xbo01ttwJ4qF8tp6Q2MN6Sne/d2fWpc0htF53qI/VpF
	pcAWkMJ4LuGnqG9MKROb8Rsp1gsJLj7kUJSWrGJ+hH2KxwFHNd9gDeDfoUHAWGaU6EVZ1P6uvNsWX
	oqO/GM2yKUqRza45WoEqKPbPFRO4Zkb4o+jX2nvbwqH8ZDv0rJ6SmEh3bBmT06mRi2uHRxSagHn37
	9tVRNAzo1pXfMcp6c8qEY4pCmej3/P+diktB/1KYO5KeI1QdINlCnXwbUvwpLWolxUEZQc0NID/BR
	0JX12Smg==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsW-0000000E2W5-2808;
	Wed, 30 Apr 2025 21:22:04 +0000
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
Subject: [PATCH 01/19] block: add a bio_add_virt_nofail helper
Date: Wed, 30 Apr 2025 16:21:31 -0500
Message-ID: <20250430212159.2865803-2-hch@lst.de>
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

Add a helper to add a directly mapped kernel virtual address to a
bio so that callers don't have to convert to pages or folios.

For now only the _nofail variant is provided as that is what all the
obvious callers want.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 16 ++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 4e6c85a33d74..c1789a58f23f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -989,6 +989,22 @@ void __bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
+/**
+ * bio_add_virt_nofail - add data in the direct kernel mapping to a bio
+ * @bio: destination bio
+ * @vaddr: data to add
+ * @len: length of the data to add, may cross pages
+ *
+ * Add the data at @vaddr to @bio.  The caller must have ensure a segment
+ * is available for the added data.  No merging into an existing segment
+ * will be performed.
+ */
+void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len)
+{
+	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
+}
+EXPORT_SYMBOL_GPL(bio_add_virt_nofail);
+
 /**
  *	bio_add_page	-	attempt to add page(s) to bio
  *	@bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index cafc7c215de8..acca7464080c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,8 @@ void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
+void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len);
+
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.47.2


