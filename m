Return-Path: <linux-fsdevel+bounces-58122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FFEB2996E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C333189FAFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D43272E66;
	Mon, 18 Aug 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPg55rm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E3272E71;
	Mon, 18 Aug 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497429; cv=none; b=tsfG01ncrDGarFpt9Mi573VR1DMQlxGDh68avb/rcnRIo4GX0LtPogFUfsFRitTalBwksuX40fRZ17qZjSqRbicwy6gYwUzeVRZO+73Ntsj8/JYfYoAyo9M4R0eBqZqw2oj2SslggnY5PEmFPgL78B51NnYkfPS8DoXoAvYa4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497429; c=relaxed/simple;
	bh=KUjBeneIizbrzejn6dI00yz7HLW6CEtclxutPpCFH5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksA3p38pYrOp4umxv/VmWZubesmOlkV1OYs+j/QvFjiTECk74ZppqJCeclsmAvR3vePLxg4oCGU6rdTg2yhktorkF4G6Pqmocutfk5MdoQAYTEwqeKqlxGhVG0h/4dbNaEYrR35RcrcKkJSqheNg8edfSUAsBcWBeEFqMKLeaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QPg55rm0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4J1/06gJDoy116dfpIOWW0QWPaS1Pkc+RGvAfs19vE4=; b=QPg55rm0rQfK16zrN/EzN/1j5A
	SzTVgY45blodBybCI5xGxFia2fC8Mcrgq0cJklfNWtRK9LP/dJuBDyJ9CIi16ChCjAr9oA+6X81xI
	irIOtJq4HbEyh5O3hdxFdlGzk57fpJKfVVzz0WD1V2q2t6JdP61P+DKanTrU3annX5br8NYt7Mmba
	4DseCVrBmxO5WbduUFYrbKKOfiZBy5ny2kqMwbqZu+ph8th9rZcmRtFq6wvB7KTZ7TT0EICzVDhfn
	tDXdXK8Nc4HAxT7P68c+2fUT95EZXywef3KHdkpycwAzJr/OOWJ/FKBM6mJQOHQPVhajAVCwv8wBA
	NQBX7NhA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unt4d-00000006bmt-1Vjk;
	Mon, 18 Aug 2025 06:10:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-bcachefs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm: remove write_cache_pages
Date: Mon, 18 Aug 2025 08:10:10 +0200
Message-ID: <20250818061017.1526853-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818061017.1526853-1-hch@lst.de>
References: <20250818061017.1526853-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  6 ------
 mm/page-writeback.c       | 30 ------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..2a7e134d03ee 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -360,12 +360,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 struct folio *writeback_iter(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int *error);
 
-typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
-				void *data);
-
-int write_cache_pages(struct address_space *mapping,
-		      struct writeback_control *wbc, writepage_t writepage,
-		      void *data);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
 void tag_pages_for_writeback(struct address_space *mapping,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..7e1e798e7213 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2590,36 +2590,6 @@ struct folio *writeback_iter(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(writeback_iter);
 
-/**
- * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
- * @mapping: address space structure to write
- * @wbc: subtract the number of written pages from *@wbc->nr_to_write
- * @writepage: function called for each page
- * @data: data passed to writepage function
- *
- * Return: %0 on success, negative error code otherwise
- *
- * Note: please use writeback_iter() instead.
- */
-int write_cache_pages(struct address_space *mapping,
-		      struct writeback_control *wbc, writepage_t writepage,
-		      void *data)
-{
-	struct folio *folio = NULL;
-	int error;
-
-	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
-		error = writepage(folio, wbc, data);
-		if (error == AOP_WRITEPAGE_ACTIVATE) {
-			folio_unlock(folio);
-			error = 0;
-		}
-	}
-
-	return error;
-}
-EXPORT_SYMBOL(write_cache_pages);
-
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
-- 
2.47.2


