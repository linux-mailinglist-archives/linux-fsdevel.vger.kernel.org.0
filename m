Return-Path: <linux-fsdevel+bounces-20280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5448D0EF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE43E282A63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695D1649C8;
	Mon, 27 May 2024 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsuVjs01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B316191B;
	Mon, 27 May 2024 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843704; cv=none; b=tc6MUZE7VUrt8/jqbJ8Jcn++xdRmJ0ZMjqI2CES08DMk/T91aapLN3AXj6d1P6zXvoq5PX3IvfPmpO9nbcyCJjW0craLhoU3ocK+ucYL71Dewhkfis1qgVGtJX+oG3cXkDPwm3NjCyp1g621hNho8ONAdyMrZv0ZSby5pOQbmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843704; c=relaxed/simple;
	bh=d0tVjBIZ50XMn1Z2omCL0kJaG42f2EEBao3K7MDcvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QyFrVJdt3Bk2dooQBHw4M658+Ns5xp5G+ur3Uc957OZN8YmwsiehCGvc3mPIPPsDUWc3JPP8jZJ3EQOYs77Q7FtPySwHilHgzgIPaOm7IOfnn6FZECmdd7XMyuKlmLdnaeJmYwO8r/Y6MtT4y5LFUSR+XSWS8FBVOX6b5IjMWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XsuVjs01; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=HDLaoQD7cnvad9Y4kohJVJq8Wi/o15RfSw0EInJn85g=; b=XsuVjs01D2A4snvIOF0Tkf2krm
	Bd4zzZilKsucxO4d0BOVKcbaDAHrIdKrC/JQdKnTEZWBcLQe/jL2CmpPN5agCqjD8lfKIv3ilZs0v
	0ZmkrbK8cmhLjJBoRa8kajFepFpRSjfrB5F68CezJOH4HNlVkbUKv0PaeYUOi7B2rA2W3ahfig8U2
	0aC3Q35KhX4zT8Zy5RNW67HYbTMe3p8hh1+cYcVjiCHu8mud1r97EcMZCALq8Mp7BkUGpnEmnXEK6
	Bw7dE+mGrKkk/Qj7GcnhQpb2qQiFIQyajYIblqZ2/a8+4hT90E46rkoMyQrEzzDf/TYszEv8N1GGy
	W3n+g2Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBhTJ-00000007zjV-12Yd;
	Mon, 27 May 2024 21:01:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Date: Mon, 27 May 2024 22:01:23 +0100
Message-ID: <20240527210125.1905586-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need filesystems to be able to communicate acceptable folio sizes
to the pagecache for a variety of uses (e.g. large block sizes).
Support a range of folio sizes between order-0 and order-31.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
For this version, I fixed the TODO that the maximum folio size was not
being honoured.  I made some other changes too like adding const, moving
the location of the constants, checking CONFIG_TRANSPARENT_HUGEPAGE, and
dropping some of the functions which aren't needed until later patches.
(They can be added in the commits that need them).  Also rebased against
current Linus tree, so MAX_PAGECACHE_ORDER no longer needs to be moved).

 include/linux/pagemap.h | 81 +++++++++++++++++++++++++++++++++++------
 mm/filemap.c            |  6 +--
 mm/readahead.c          |  4 +-
 3 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1ed9274a0deb..c6aaceed0de6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,13 +204,18 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
-	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
-	AS_STABLE_WRITES,	/* must wait for writeback before modifying
+	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
+	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
-	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
+	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
+	AS_FOLIO_ORDER_MIN = 16,
+	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
 };
 
+#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
+#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
+#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
+
 /**
  * mapping_set_error - record a writeback error in the address_space
  * @mapping: the mapping in which an error should be set
@@ -359,9 +364,48 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #define MAX_PAGECACHE_ORDER	8
 #endif
 
+/*
+ * mapping_set_folio_order_range() - Set the orders supported by a file.
+ * @mapping: The address space of the file.
+ * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
+ * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate which base size (min) and maximum size (max) of folio the VFS
+ * can use to cache the contents of the file.  This should only be used
+ * if the filesystem needs special handling of folio sizes (ie there is
+ * something the core cannot know).
+ * Do not tune it based on, eg, i_size.
+ *
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_folio_order_range(struct address_space *mapping,
+		unsigned int min, unsigned int max)
+{
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return;
+
+	if (min > MAX_PAGECACHE_ORDER)
+		min = MAX_PAGECACHE_ORDER;
+	if (max > MAX_PAGECACHE_ORDER)
+		max = MAX_PAGECACHE_ORDER;
+	if (max < min)
+		max = min;
+
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+		(min << AS_FOLIO_ORDER_MIN) | (max << AS_FOLIO_ORDER_MAX);
+}
+
+static inline void mapping_set_folio_min_order(struct address_space *mapping,
+		unsigned int min)
+{
+	mapping_set_folio_order_range(mapping, min, MAX_PAGECACHE_ORDER);
+}
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
- * @mapping: The file.
+ * @mapping: The address space of the file.
  *
  * The filesystem should call this function in its inode constructor to
  * indicate that the VFS can use large folios to cache the contents of
@@ -372,7 +416,23 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
+}
+
+static inline
+unsigned int mapping_max_folio_order(const struct address_space *mapping)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
+}
+
+static inline
+unsigned int mapping_min_folio_order(const struct address_space *mapping)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
 /*
@@ -381,16 +441,13 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return mapping_max_folio_order(mapping) > 0;
 }
 
 /* Return the maximum folio size for this pagecache mapping, in bytes. */
-static inline size_t mapping_max_folio_size(struct address_space *mapping)
+static inline size_t mapping_max_folio_size(const struct address_space *mapping)
 {
-	if (mapping_large_folio_support(mapping))
-		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
-	return PAGE_SIZE;
+	return PAGE_SIZE << mapping_max_folio_order(mapping);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
diff --git a/mm/filemap.c b/mm/filemap.c
index 382c3d06bfb1..0557020f130e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1933,10 +1933,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
 
-		if (!mapping_large_folio_support(mapping))
-			order = 0;
-		if (order > MAX_PAGECACHE_ORDER)
-			order = MAX_PAGECACHE_ORDER;
+		if (order > mapping_max_folio_order(mapping))
+			order = mapping_max_folio_order(mapping);
 		/* If we're not aligned, allocate a smaller folio */
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d9ca..66058ae02f2e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -503,9 +503,9 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < mapping_max_folio_order(mapping)) {
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+		new_order = min(mapping_max_folio_order(mapping), new_order);
 		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	}
 
-- 
2.43.0


