Return-Path: <linux-fsdevel+bounces-74386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA93D3A071
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7FF30F2CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E6337BB5;
	Mon, 19 Jan 2026 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ABbdj8VL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685A337B8D;
	Mon, 19 Jan 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808678; cv=none; b=V9LY13b0Hnzp/xsF7DaoE+eHAz7FPDzXIKOZm90F0FnLv92xmhJ7ftGG22yfB1e0+ZQzbZTSdMWSxp1T3Z/ecqfi8fny1MyjJnVgjkintwz9A93QjbQnbj+CFl3X99vu4vQTJWMtD/YqNucLfwLh0sGV2Tsvlch4YhP8NgjPdd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808678; c=relaxed/simple;
	bh=FRYHx2ZE+tnmw/JCkuL2PsOP/zBEP+MYmEH+ekxySvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR+KSNz9xx/IiyNCzls0NSxmXaODCgyfQk+lzxRb4PPNDlDvllQ0ARMBH8qgybeo1BIk0iQhRK/UiIBtOO7KWcR7ImslVqbtms3xeMELpR+z5icJEt6zm++IIQT2Z5WmYnN7VESmrH32cPTydAEZFKG7PBpN2CVTNc+IoFBUQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ABbdj8VL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wzbKOYA62V3eqvhZl/SZh5w3/pX+HsT8KNqYuMduYKk=; b=ABbdj8VLH8TJXZfTThzut2W/nw
	2SPdbS4XR8cSfEZLH6is7ZcOTYdvJQTdtXn5IjY+AnVM679mnXZAyt7JqxpTqOuhsXNxFl9yXI0nQ
	+DNPrOxRxng0DKrdGwqV9bzTUgetUQUFuKs/wB6dz1xGqbCSb3khaUaxmznd1h+clKn0aedc4K8iX
	pr9AVMfXlpNB6r9jSLF8YYStjbYk3stIeDs+cWRLAY9WO6N/Buli11+DcmwBFyhNJQeBrY7Goocr1
	DvbHmYoWaeYHmzkiZEetNAKfO7EgssBu4x4YJw44qEOrjv/FdDP1LPn+YZRDRLNzQPdEgh9Gp/X+f
	X29BPZDw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwA-00000001W8v-0bjU;
	Mon, 19 Jan 2026 07:44:34 +0000
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
Date: Mon, 19 Jan 2026 08:44:08 +0100
Message-ID: <20260119074425.4005867-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
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
index 2359c0723b88..18dfdaba0c73 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1172,33 +1172,35 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
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
 
@@ -1222,8 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	ssize_t size;
-	unsigned int num_pages, i = 0;
-	size_t offset, folio_offset, left, len;
+	unsigned int i = 0;
+	size_t offset, left, len;
 	int ret = 0;
 
 	/*
@@ -1244,23 +1246,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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
@@ -1275,8 +1266,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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


