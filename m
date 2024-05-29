Return-Path: <linux-fsdevel+bounces-20438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCA8D3836
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B701F24DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03581F95E;
	Wed, 29 May 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kHV48mAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F991F941;
	Wed, 29 May 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990337; cv=none; b=TU7JqGRgHA/dxERUM3Y4KRPGhzyxjuS/AqfLTIoU2C2xxyptmwwTRjwSu2oM19m21Kq81wdj1b0v1dpB+N0E+sDPBeTHN7sCiyKoNhRlc+ufJaklKEsnrWPZ1fW1bG7L1zUrq9JDkz6+2bLay+Mgwngs9It3asV1cKexR8WqXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990337; c=relaxed/simple;
	bh=I49ymY8zk+o1SKyWlQeRdikmg2VdVuI8ocXvxlvl84o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAtEPE/t62DAbJgIA7LI8a0LwgrbHxZOXbmvI/P/Y43Zk/X66BVRNh4Vm30/+CZLMF04kiB0Kq+QsTdC9ODwRnO3w6myfBcRpS6gley0Rb/oADP9mtproGhwWkLWNj1AwJaJjpOinCBapwNDnH3tddlPmNbGLaj+Bwg5yhibTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kHV48mAC; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vq9cq6JLcz9spB;
	Wed, 29 May 2024 15:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlQpRGWS6k8Nnmy1d5M+f7+JbGsV1KjNjVvW+vslAEQ=;
	b=kHV48mAC0R1wMXDUMrp9Emz/8PU1P2Vl+zzKRA1uZ0pu73iv/EC5smkoAHXFjLyfOXZygD
	RK8uFCQ3Nr4P4tpUdYLWhO88JffmKdvuskTCs6XV2cwKujvmlX/NeSHgjVApHVyfOII49H
	D+AIaMHTRL8rVRqsOG8w+L+PzMck3yiHNbUnB52tXOCOdY7O63fhH6kZ1itxmOQd5/rB5N
	0JXcZ01gdb2YQwndaJZ7Py7kSo/5DcTQyR6wOiZ7CJ9Cs32m+NtVNL5ABFMu+JaxVdjpvh
	sS6coq29XFSmLtES5gr2HhMXkjBz8vrXmrWbKNIM0c4GdQFosaIf2EAxyeIgWQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 03/11] filemap: allocate mapping_min_order folios in the page cache
Date: Wed, 29 May 2024 15:45:01 +0200
Message-Id: <20240529134509.120826-4-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9cq6JLcz9spB

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

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 mm/filemap.c            | 24 +++++++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 228275e7049f..899b8d751768 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -439,6 +439,26 @@ unsigned int mapping_min_folio_order(const struct address_space *mapping)
 	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
+static inline unsigned long mapping_min_folio_nrpages(struct address_space *mapping)
+{
+	return 1UL << mapping_min_folio_order(mapping);
+}
+
+/**
+ * mapping_align_start_index() - Align starting index based on the min
+ * folio order of the page cache.
+ * @mapping: The address_space.
+ *
+ * Ensure the index used is aligned to the minimum folio order when adding
+ * new folios to the page cache by rounding down to the nearest minimum
+ * folio number of pages.
+ */
+static inline pgoff_t mapping_align_start_index(struct address_space *mapping,
+						pgoff_t index)
+{
+	return round_down(index, mapping_min_folio_nrpages(mapping));
+}
+
 /*
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
diff --git a/mm/filemap.c b/mm/filemap.c
index 308714a44a0f..0914ef2e8256 100644
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
+		index = mapping_align_start_index(mapping, index);
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
 			gfp |= __GFP_WRITE;
@@ -1958,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
@@ -2447,13 +2451,16 @@ static int filemap_update_page(struct kiocb *iocb,
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
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    min_order);
 	if (!folio)
 		return -ENOMEM;
 
@@ -2471,6 +2478,8 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
+	/* index in PAGE units but aligned to min_order number of pages. */
+	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2531,8 +2540,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -3748,9 +3756,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
+		index = mapping_align_start_index(mapping, index);
 		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
 			folio_put(folio);
-- 
2.34.1


