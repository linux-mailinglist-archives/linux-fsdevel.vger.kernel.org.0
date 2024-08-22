Return-Path: <linux-fsdevel+bounces-26729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCFA95B785
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E4728243B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48C1CCB58;
	Thu, 22 Aug 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ovaCvJpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA81CCB22;
	Thu, 22 Aug 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334652; cv=none; b=WlC584uhkiNE3oemTcxF4FvCSQvAXE+IAblKcy4GO+CzPs2yP+45zyb369TXQTldGfvrf+SsqR5JXvCzVXRqki/r7OBmLVbil55f7ue35+dguk0+Tu9PP06VNdFfNSxLxvG3ZGv/uEcI/NjeatGCN+rexRvxJnuJOaXM0f2iENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334652; c=relaxed/simple;
	bh=e9KBc+PzEDCed+kd1hK3826CMsn+0IF4bbuqYt2YcWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLkkQ4SO2NB1/gMQFPui9vWuEfFf/Z8/3X5kJx6xQXenoXpmzSL/WbMzzXPzzYsqGYw1vYyyr3tKb6MPgsRNmPj2YKLhIjPp+MZRg9xMVKcfTr1j8nWE+7lP7x1lGcAFjh9U14c6NNPUFTiP/YNwX9rZjsf1O6bfYv7pFUJG6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ovaCvJpN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WqPjY3DRkz9t26;
	Thu, 22 Aug 2024 15:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724334641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvALe0si8mmJx8BbZzMNyuIQl/NHASIyzDu6VP1nIVA=;
	b=ovaCvJpNLGBJI2GBTEYrdBeqMLC7yel9OuonCATHEU9m6EmFu9rMSZPb/oNyjXYF5OUdNe
	INTtVtM4kti9F6p0oGL0VYFdbDgKEkZROQrPUorypLF+zQvSonEUz+pMqIv0pSeZdotpdS
	i3jSNC8CjbdShx8br9RzKyElRaMn2HvPG0q08p9vvPYSOKKZ5hDlDyLdR6X4k5ROQ2JX2j
	K9gJ28tjKVMl79CXcduAm2VN3+VSknitgLzx6UwdancjSb3NK8qIS9+M3dUKapxcUn3Umw
	FN8prU2mX2T5aAGRr2Uvr9t/wT8Uatut3aCLTVALbEoRIPIdYgaJ66LtZc2hrg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v13 02/10] filemap: allocate mapping_min_order folios in the page cache
Date: Thu, 22 Aug 2024 15:50:10 +0200
Message-ID: <20240822135018.1931258-3-kernel@pankajraghav.com>
In-Reply-To: <20240822135018.1931258-1-kernel@pankajraghav.com>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WqPjY3DRkz9t26

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
Tested-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 mm/filemap.c            | 24 ++++++++++++++++--------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c60025bb584c5..4cc170949e9c0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -448,6 +448,26 @@ mapping_min_folio_order(const struct address_space *mapping)
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
index 5c148144d5548..9a047c6d03e4e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -858,6 +858,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
 	mapping_set_update(&xas, mapping);
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
@@ -1918,8 +1920,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
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
@@ -1942,7 +1946,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order > 0)
+			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
 			folio = filemap_alloc_folio(alloc_gfp, order);
 			if (!folio)
@@ -1957,7 +1961,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
@@ -2443,13 +2447,15 @@ static int filemap_update_page(struct kiocb *iocb,
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
 
@@ -2467,6 +2473,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
+	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2527,8 +2534,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
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


