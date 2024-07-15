Return-Path: <linux-fsdevel+bounces-23678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983E9311B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7C2857B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99577187340;
	Mon, 15 Jul 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="U+bLMh81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E581862AB;
	Mon, 15 Jul 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037239; cv=none; b=BASDYfAugvbP1Du5xUepnQOsAUKffr2QUOYpAIqfgcQ7cbDCOiUwAo7Ew2vy9s8RQ/X6co5Q/VbL8AqzmiRPgYPnBOhYNKp78XkDcytqTNXOR5ahPBKMlsAXtSx0yjHIPzMuMKpeR7a+lC109rtM7VVph5xfDs42hlfp6Ro1c1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037239; c=relaxed/simple;
	bh=GnZflYlCJ3mo94Xvn/Dl3itRXNRTni36Mzu3RYkZuUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frHCQik+8fNio3D+/9raCUlJspNPRD7PA+fOE7t4qizNHKiux7r2h6gPasnNJbVBDuA76LkxH2sMzolA0cxwOZZF6caGJCRsng+NQfCfOyUmpaOo+hSYftieHIoRDoA32gRlzclvlFbjuGS9LwHn+N/Y2AbhcMFFcLRcCrZ0kKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=U+bLMh81; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WMy3z4kd4z9shb;
	Mon, 15 Jul 2024 11:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721036719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZYOFJ5P/VY9rKNoUL4YY6KJOafbO93OrjcSUWzfqT8=;
	b=U+bLMh81rZAD88aO93Zk6o93HUHVdTk/j05mVwIqiDKOQkJKwVOu0py2aYW1hjKKlKpob2
	6n4LMGwVdGmkrtxF9S7uQYsbGRxVKDtI5S2GHx45O16exybKjBvghZRXWo6D17I+OKcaAT
	j6Eppobgt0SgXpjK23XnsZvw0VZJGGomcWzYMjQFAodqTGVqkGD1rLELbNBWsX+cgwk3qF
	ar8l7LlSEiVSidN5fqG5/LSS2EpJ8o1vaMNPhwHQ6lHBLzytvkzni7imQYUUWPWbCa70Ak
	jTpvqZD5t+kdzSNAuOu6rpkPNNqzXP2cT62tfDG7L99r1ZgwCQ4y3Oqi6TiaCQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 02/10] filemap: allocate mapping_min_order folios in the page cache
Date: Mon, 15 Jul 2024 11:44:49 +0200
Message-ID: <20240715094457.452836-3-kernel@pankajraghav.com>
In-Reply-To: <20240715094457.452836-1-kernel@pankajraghav.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

filemap_create_folio() and do_read_cache_folio() were always allocating
folio of order 0. __filemap_get_folio was trying to allocate higher
order folios when fgp_flags had higher order hint set but it will default
to order 0 folio if higher order memory allocation fails.

Supporting mapping_min_order implies that we guarantee each folio in the
page cache has at least an order of mapping_min_order. When adding new
folios to the page cache we must also ensure the index used is aligned to
the mapping_min_order as the page cache requires the index to be aligned
to the order of the folio.

Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 mm/filemap.c            | 24 ++++++++++++++++--------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8d2b5c51461b0..68edbea9ae25a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -467,6 +467,26 @@ mapping_min_folio_order(const struct address_space *mapping)
 	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
+static inline unsigned long
+mapping_min_folio_nrpages(struct address_space *mapping)
+{
+	return 1UL << mapping_min_folio_order(mapping);
+}
+
+/**
+ * mapping_align_index() - Align index for this mapping.
+ * @mapping: The address_space.
+ *
+ * The index of a folio must be naturally aligned.  If you are adding a
+ * new folio to the page cache and need to know what index to give it,
+ * call this function.
+ */
+static inline pgoff_t mapping_align_index(struct address_space *mapping,
+					  pgoff_t index)
+{
+	return round_down(index, mapping_min_folio_nrpages(mapping));
+}
+
 /*
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
diff --git a/mm/filemap.c b/mm/filemap.c
index ad5e4a848070e..d27e9ac54309d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -859,6 +859,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
 	mapping_set_update(&xas, mapping);
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
@@ -1919,8 +1921,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
-		unsigned order = FGF_GET_ORDER(fgp_flags);
+		unsigned int min_order = mapping_min_folio_order(mapping);
+		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
 		int err;
+		index = mapping_align_index(mapping, index);
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
 			gfp |= __GFP_WRITE;
@@ -1943,7 +1947,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order > 0)
+			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
 			folio = filemap_alloc_folio(alloc_gfp, order);
 			if (!folio)
@@ -1958,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
@@ -2447,13 +2451,15 @@ static int filemap_update_page(struct kiocb *iocb,
 }
 
 static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, pgoff_t index,
+		struct address_space *mapping, loff_t pos,
 		struct folio_batch *fbatch)
 {
 	struct folio *folio;
 	int error;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	pgoff_t index;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
 
@@ -2471,6 +2477,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
+	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2531,8 +2538,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -3748,9 +3754,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
+		index = mapping_align_index(mapping, index);
 		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
 			folio_put(folio);
-- 
2.44.1


