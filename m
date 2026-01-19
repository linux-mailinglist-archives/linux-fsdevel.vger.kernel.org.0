Return-Path: <linux-fsdevel+bounces-74387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107DD3A073
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98ADA312C698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55657337B8D;
	Mon, 19 Jan 2026 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2sDrWJGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCC3375CB;
	Mon, 19 Jan 2026 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808682; cv=none; b=OiYy+lVgKoQkcfxTKUnk3vcBwg2lbewB0CF4NVPPeLjb+dZTT11aga2L7y2Z8O48RHCDpo0c4kPyLbLrzhkPJZS8XJBvTUjFyh74taAZzl8kIVpCf0hHcpNZvmULeBy+PKEpxDlfJ6gSXCiHq8cf6mA4qCRDWRQ4B/KhBagKX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808682; c=relaxed/simple;
	bh=AtALBAHVLTMP4BQNE3DlRXDBFkt2RZhpnHaEum0Ussw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ritVM2xeBdb3rjLffAx+o+TskmCRaUwhSIP9+yDC4SMOmaT9YepoZRsyirBYWxKMiE5AA64msM1MZZhEcsueGR69gnseEg6kKdeWy3hlyYLkOPJN2QKkcqoWE/JO4Bantu6R/OX4nMBURJ8mzE/IDs04+lRpUfN+PZds1e1zG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2sDrWJGY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dUrSsEjZpIeiOZlyW2dk1u2m7CMm1V9LhtGWZDxTQJw=; b=2sDrWJGYxiL0ns7fpya9s6zyld
	72j8J8nTTVsDlCAzvP0w4wtMNCUC7BnX1RyKK+v0bcjupSNmZS2FADpUB0/ML0O0PxWMavkQZylEG
	d248EbzGacosCpgkN48MLmzjggit1PHFDnJPmRvDGuCNDwXLwTdC2WvoUM4CyhA7XJFAkplbQyPsN
	jtKO96/ClIJPp9YsXfr50Afved6eYqJNj9hgmKY0aAeqvUxZI8tM9QbUrs0YECsu7JLnxxxA8TdB/
	3KG6Olgybq8BgKgSB4sWLY6sB3uPvm1Di+5uIoxqfaMD7ARvF1QAFQDALpjKOSTvWoz4Viiu+i9j+
	6f0f35FQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwD-00000001W9P-4BSM;
	Mon, 19 Jan 2026 07:44:38 +0000
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
Date: Mon, 19 Jan 2026 08:44:09 +0100
Message-ID: <20260119074425.4005867-3-hch@lst.de>
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
index 18dfdaba0c73..46ff33f4de04 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1216,7 +1216,7 @@ static unsigned int get_contig_folio_len(struct page **pages,
  * For a multi-segment *iter, this function only adds pages from the next
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+static ssize_t __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	iov_iter_extraction_t extraction_flags = 0;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
@@ -1226,7 +1226,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size;
 	unsigned int i = 0;
 	size_t offset, left, len;
-	int ret = 0;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1247,37 +1246,26 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
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
@@ -1337,7 +1325,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned len_align_mask)
 {
-	int ret = 0;
+	ssize_t ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1350,9 +1338,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
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


