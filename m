Return-Path: <linux-fsdevel+bounces-73623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A4D1CE65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3EE83015AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A237A492;
	Wed, 14 Jan 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0b5LLbjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43263328B6A;
	Wed, 14 Jan 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376528; cv=none; b=Ty3zksWkZrkvOU4XbvlICgnhYdUBo4pG3mA50xqGWBaDnGWfcNMD69rD4gpRfS//zpLjRVog2p7/UXLDtRVgcNSYiMZ6p25hI3i99Ut0Z4hoZXMI3LNH38/z6YQQ4RDACRkTRJ8RQpo9UKXSbRasz9dbC1PR6Msco77omG8dUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376528; c=relaxed/simple;
	bh=maB5/GPSmi2l7kagwVdpBl9mnqgF2594JGrtgDOb4x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEvej3mtL5a3+HTLjFP1hpUQ1PZ5mn35IqSCDHYE2ghbw24X4bc+7vr0CJ4DOvLuZmxENK8Nm1C4zIsx3IYdHM1TgClUPzqcdUKtKn5+mIC1xNi5nMd1xixcZjWbteYkOz3d6ej0T3Jj1VHfdKfAC3hZW3fs6Zn6wUWEqFOAtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0b5LLbjH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7Ut16tkEOCcj980qUp1bVamKVu6n2WjZb4ANJhSlfn0=; b=0b5LLbjHhYehh/qe0EKKId5qex
	KK3lM/ACGyK1KSGh6cjhotCiJNWn7VzhZDYK1zCCxZEVyDL0BQyYBgKu06H5T5ZGyMVJyciSSZjSn
	i6iagCoFovSAxSq78ZIkOGm58LAS7dhegFBQKuf672eJus2L2tdKCVQ3rLIULmK3Kb5IUTInn3UPC
	IjB49yu+JojKRM5SriLPlP3lo+Oe/Q5JjHr286dtpMl0eV0P2ZKOudT49+fUId5WkUxF8ZQ+KRuS5
	IY6vHx+qt9wYige0SSB/z4vqE9cwTMoR7gB9FUwJ8nEU9x7c8phzXoHE3YljIQKC5tV8TnFUO02zJ
	5YZ21gTg==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvVq-00000008DmT-2rQR;
	Wed, 14 Jan 2026 07:41:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/14] block: refactor get_contig_folio_len
Date: Wed, 14 Jan 2026 08:40:59 +0100
Message-ID: <20260114074145.3396036-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move all of the logic to find the contigous length inside a folio into
get_contig_folio_len instead of keeping some of it in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 62 +++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e726c0e280a8..e22b7cf9b2bc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1169,33 +1169,35 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static unsigned int get_contig_folio_len(unsigned int *num_pages,
-					 struct page **pages, unsigned int i,
-					 struct folio *folio, size_t left,
+static unsigned int get_contig_folio_len(struct page **pages,
+					 unsigned int *num_pages, size_t left,
 					 size_t offset)
 {
-	size_t bytes = left;
-	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, bytes);
-	unsigned int j;
+	struct folio *folio = page_folio(pages[0]);
+	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
+	unsigned int max_pages, i;
+	size_t folio_offset, len;
+
+	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
+	len = min(folio_size(folio) - folio_offset, left);
 
 	/*
-	 * We might COW a single page in the middle of
-	 * a large folio, so we have to check that all
-	 * pages belong to the same folio.
+	 * We might COW a single page in the middle of a large folio, so we have
+	 * to check that all pages belong to the same folio.
 	 */
-	bytes -= contig_sz;
-	for (j = i + 1; j < i + *num_pages; j++) {
-		size_t next = min_t(size_t, PAGE_SIZE, bytes);
+	left -= contig_sz;
+	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+	for (i = 1; i < max_pages; i++) {
+		size_t next = min_t(size_t, PAGE_SIZE, left);
 
-		if (page_folio(pages[j]) != folio ||
-		    pages[j] != pages[j - 1] + 1) {
+		if (page_folio(pages[i]) != folio ||
+		    pages[i] != pages[i - 1] + 1)
 			break;
-		}
 		contig_sz += next;
-		bytes -= next;
+		left -= next;
 	}
-	*num_pages = j - i;
 
+	*num_pages = i;
 	return contig_sz;
 }
 
@@ -1219,8 +1221,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	ssize_t size;
-	unsigned int num_pages, i = 0;
-	size_t offset, folio_offset, left, len;
+	unsigned int i = 0;
+	size_t offset, left, len;
 	int ret = 0;
 
 	/*
@@ -1241,23 +1243,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		return size ? size : -EFAULT;
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
-	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
-		struct page *page = pages[i];
-		struct folio *folio = page_folio(page);
+	for (left = size; left > 0; left -= len) {
 		unsigned int old_vcnt = bio->bi_vcnt;
+		unsigned int nr_to_add;
 
-		folio_offset = ((size_t)folio_page_idx(folio, page) <<
-			       PAGE_SHIFT) + offset;
-
-		len = min(folio_size(folio) - folio_offset, left);
-
-		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
-
-		if (num_pages > 1)
-			len = get_contig_folio_len(&num_pages, pages, i,
-						   folio, left, offset);
-
-		if (!bio_add_folio(bio, folio, len, folio_offset)) {
+		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
+		if (!bio_add_page(bio, pages[i], len, offset)) {
 			WARN_ON_ONCE(1);
 			ret = -EINVAL;
 			goto out;
@@ -1272,8 +1263,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			 * single pin per page.
 			 */
 			if (offset && bio->bi_vcnt == old_vcnt)
-				unpin_user_folio(folio, 1);
+				unpin_user_folio(page_folio(pages[i]), 1);
 		}
+		i += nr_to_add;
 		offset = 0;
 	}
 
-- 
2.47.3


