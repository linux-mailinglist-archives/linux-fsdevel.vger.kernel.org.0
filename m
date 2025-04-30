Return-Path: <linux-fsdevel+bounces-47769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF6AA56E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C229827D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA22D6459;
	Wed, 30 Apr 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="20uQwirK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC52D643D;
	Wed, 30 Apr 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048135; cv=none; b=gXK5Zu0cQR0ce5S1bSaEh1c5AP7RIGBy32fAMaBx3zZ1V3MsaeOBJhyqdzgXJgedSFvJ1Qofy8DY50B+WhoExIm2fqt91eWvz3hslAJZamfbzaVVOBSWtV0VFIu5m6BxeruzMxSHuAA6+cPnDNmj1pJgid3Z+B6TS+g7/wk/kWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048135; c=relaxed/simple;
	bh=oHt7k0ATOlag8su5uID7QhFjuWncQCCw/RBdey6XSJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SObXPHWsXEHkBCB4QUzyyjk8XqHCFXopqdjYmy2j2uDAoam1THVCgGwM9rqkAva8o1tOVo7kyyk6F08MUTYDxn3bIqCg2eXUMJj2xjHMXbrde2B2r0IGOGsN3KA7iUPx9oExN5Qq1iQzZXjin9mlQ5xUma7qRYJAM/Jnvtj7ElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=20uQwirK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BV13n3qNH9gK6w5ciD7+8l8MqTjGtb1kFaQOlROr3iw=; b=20uQwirKNl+/zR92iJKSLZkgOg
	l7gsiQR0G7K+4Ty7rw0WwV/tk1FoNMqzsrWo6V+XzWJk8/ohLn+ZTATcfIaNmS7HDEM/HeTYFhW3L
	+FBqK8Z5eKmU3QZvdErNzPNTUuSztN5TVBl9TYCa0tB1kgSPFEVgbVD2hQMsbLSOnKA80VKyeULpG
	d+wJhDwfgbCQ9YM1ajguIQxYZBqCXAkRXpXY4030LmxSdRox/aOaYKDg5Bzl3olkkZE19SggPZfoR
	GddTaRJA2UuSJRUSIgPsv5dgP7clrUE9aIsC4lsUuaNY9UVt9aQwp/KxzkrjxOC9+PfJJhAR4D6Qf
	xNM1gmkw==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEse-0000000E2XO-2kcJ;
	Wed, 30 Apr 2025 21:22:13 +0000
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
Subject: [PATCH 04/19] block: add a bio_add_vmalloc helpers
Date: Wed, 30 Apr 2025 16:21:34 -0500
Message-ID: <20250430212159.2865803-5-hch@lst.de>
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

Add a helper to add a vmalloc region to a bio, abstracting away the
vmalloc addresses from the underlying pages and another one wrapping
it for the simple case where all data fits into a single bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 8db2db0bba0f..1efe63e375ae 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1074,6 +1074,61 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
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


