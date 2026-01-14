Return-Path: <linux-fsdevel+bounces-73624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E7D1CE6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E3E33019B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0E637BE65;
	Wed, 14 Jan 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CkoxT4l0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF735FF41;
	Wed, 14 Jan 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376529; cv=none; b=DvrF17mophDzirXLscQbZKFcMhfHYrPDl8IDAL80x++ykF9HvgKPz+SdQ2sslUhGFV/XWEDir1aoHjuAQK5yS57mI1l+UISXjxGVeZ1/9zCYVdEgqt4L9kwLWQ2Z7qaNAE6CQQuY0Z6M0Gb9hih4XZV6NtJysd4AquN2SA43bBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376529; c=relaxed/simple;
	bh=3QI2OO74LcnVbEedP0aMj12D2ZfFiFKrrb/nAJ0+f7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tArt4QFjmZzoL8v4nsxnRY2+hwkfBiFMgW7QhZdLjAdacPbNKiIBO/IYG2SoA2L7DgMy3AoPnh9qMduYERm6UJdIiXZS5bohEj+MvartwvtCKOy8u6/+UoMzpITfClGdmAB3OPprbzxC6uzlHNZwFwO1Ppq3vQhm4aYEKWlxEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CkoxT4l0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xhB7qOXlkIRSnyXgwM2xYIn6O20yDEwPG+xHcKOTJb8=; b=CkoxT4l0D7vsNGv3IEQ4D+8oLq
	aZOhLbLNlWWO7jQYen9htChc2L3OsMKzEfPUlAYE1WSxyN6+yMo4yuPPU1swkKBnCC8gkgyZCSJK+
	pNcIVYBgKPmiQcwEsAECmUrFTQzOuU5NqCWuKAD1zjK2TRo/RWzdQ44+ZsS7iznJM+WOq8B13u1am
	QQtsaMB2AmS6oRMF+awEeh7+wTDQaQ4A89D84hKDtsOKiTluWdOyAjB6UNw7dKrhz2/XodjGDxFLP
	sqX8e6AIBTRKn18Fi/QCfvuIojmZ3UhvNmWg9kZBzjZ00TlimRNfj4wJGZQILG0UpsLHzIMnr4RAh
	ck/0DnRg==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvVy-00000008Dnu-2jG2;
	Wed, 14 Jan 2026 07:42:03 +0000
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
Subject: [PATCH 02/14] block: open code bio_add_page and fix handling of mismatching P2P ranges
Date: Wed, 14 Jan 2026 08:41:00 +0100
Message-ID: <20260114074145.3396036-3-hch@lst.de>
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

bio_add_page fails to add data to the bio when mixing P2P with non-P2P
ranges, or ranges that map to different P2P providers.  In that case
it will trigger that WARN_ON and return an error up the chain instead of
simply starting a new bio as intended.  Fix this by open coding
bio_add_page and handling this case explicitly.  While doing so, stop
merging physical contiguous data that belongs to multiple folios.  While
this merge could lead to more efficient bio packing in some case,
dropping will allow to remove handling of this corner case in other
places and make the code more robust.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e22b7cf9b2bc..48d9f1592313 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1213,7 +1213,7 @@ static unsigned int get_contig_folio_len(struct page **pages,
  * For a multi-segment *iter, this function only adds pages from the next
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+static ssize_t __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	iov_iter_extraction_t extraction_flags = 0;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
@@ -1223,7 +1223,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size;
 	unsigned int i = 0;
 	size_t offset, left, len;
-	int ret = 0;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1244,37 +1243,26 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 	for (left = size; left > 0; left -= len) {
-		unsigned int old_vcnt = bio->bi_vcnt;
 		unsigned int nr_to_add;
 
-		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
-		if (!bio_add_page(bio, pages[i], len, offset)) {
-			WARN_ON_ONCE(1);
-			ret = -EINVAL;
-			goto out;
-		}
+		if (bio->bi_vcnt > 0) {
+			struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (bio_flagged(bio, BIO_PAGE_PINNED)) {
-			/*
-			 * We're adding another fragment of a page that already
-			 * was part of the last segment.  Undo our pin as the
-			 * page was pinned when an earlier fragment of it was
-			 * added to the bio and __bio_release_pages expects a
-			 * single pin per page.
-			 */
-			if (offset && bio->bi_vcnt == old_vcnt)
-				unpin_user_folio(page_folio(pages[i]), 1);
+			if (!zone_device_pages_have_same_pgmap(prev->bv_page,
+					pages[i]))
+				break;
 		}
+
+		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
+		__bio_add_page(bio, pages[i], len, offset);
 		i += nr_to_add;
 		offset = 0;
 	}
 
 	iov_iter_revert(iter, left);
-out:
 	while (i < nr_pages)
 		bio_release_page(bio, pages[i++]);
-
-	return ret;
+	return size - left;
 }
 
 /*
@@ -1334,7 +1322,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned len_align_mask)
 {
-	int ret = 0;
+	ssize_t ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1347,9 +1335,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
+
 	do {
 		ret = __bio_iov_iter_get_pages(bio, iter);
-	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
+	} while (ret > 0 && iov_iter_count(iter) && !bio_full(bio, 0));
 
 	if (bio->bi_vcnt)
 		return bio_iov_iter_align_down(bio, iter, len_align_mask);
-- 
2.47.3


