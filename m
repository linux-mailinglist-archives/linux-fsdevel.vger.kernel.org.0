Return-Path: <linux-fsdevel+bounces-13306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1D86E630
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9BEB280E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137203EA7B;
	Fri,  1 Mar 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="HN/hGMWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909483D96B;
	Fri,  1 Mar 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311510; cv=none; b=Q7sgTUrRXKz9oXIW0jbi7Ao+7wmJaPavr+gjuxtUQyfnRDmIBQ7B8Q4JqOQvjHToOwo9IkIZvh7cfqeSksfR4w4I05bsuNwk1c0bSIn0pLH5k3gRaWuXgcqk1Iyx7gCYbyBfv9Sp6S/NCR4lh7zyDfXvc11uru81Sqq9IhMh03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311510; c=relaxed/simple;
	bh=Dhf0XL34Ux242LTLDdtsnVgCvNkORmcL/S9/XRzpBuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIOfPEfMFo3hp0Yrat40V98exv8By/NJQjIIzuGlrHAc2DDb1ykTEK+MHpS/bDqYXBoaYDJMdRbOJsrqOZcDx2ER7y5yf2zI36mu1W8+YzE6O9B9cWesNormD6QQzfttUHcK9xZatAT47qxalrwBwxV5xuEQQaF6zxBUbPIzEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=HN/hGMWj; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmYpz35Y1z9t7Z;
	Fri,  1 Mar 2024 17:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCQodYVgPvK7zJztO22OSwzZBWMPBsGjwa0dIcNZkr8=;
	b=HN/hGMWj2gC5ZojLre62sCdhsS18t89JR0BD9LJzX7iJ/Hqx9zmSsQtDrhYImhyoAxGAO/
	ruoKmN06+/h7LtqfkBwARYmoZ0+J8PfLGGkOmqyqs2wo8Ib04XGqutAvFrw9JWq1uMImwZ
	5J4jlTrgdOVujUjaWDNOgaDR6C9KMlCIw/5oCv6ERInUn8FOInxxcRlA0aZecyczCv1d9D
	MkEyl3pqTJHM2TU2ErxfE3hE5dV3hL3yj/GVot+TyNb6m9tcmVWrVLRdLf/Pd3C7qUD5UW
	3Dv2OCudXJiZqfb5sxfmf6tQheb+gjipAbANPdwH71pSHy4a3Jgu/Ikv8G8i+g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 03/13] filemap: align the index to mapping_min_order in the page cache
Date: Fri,  1 Mar 2024 17:44:34 +0100
Message-ID: <20240301164444.3799288-4-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TmYpz35Y1z9t7Z

From: Luis Chamberlain <mcgrof@kernel.org>

Supporting mapping_min_order implies that we guarantee each folio in the
page cache has at least an order of mapping_min_order. So when adding new
folios to the page cache we must ensure the index used is aligned to the
mapping_min_order as the page cache requires the index to be aligned to
the order of the folio.

A higher order folio than min_order by definition is a multiple of the
min_order. If an index is aligned to an order higher than a min_order, it
will also be aligned to the min order.

This effectively introduces no new functional changes when min order is
not set other than a few rounding computations that should result in the
same value.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/pagemap.h | 10 +++++++++-
 mm/filemap.c            | 16 ++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fc8eb9c94e9c..b3cf8ef89826 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1328,6 +1328,14 @@ struct readahead_control {
 		._index = i,						\
 	}
 
+#define DEFINE_READAHEAD_ALIGNED(ractl, f, r, m, i)			\
+	struct readahead_control ractl = {				\
+		.file = f,						\
+		.mapping = m,						\
+		.ra = r,						\
+		._index = mapping_align_start_index(m, i),		\
+	}
+
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
 
 void page_cache_ra_unbounded(struct readahead_control *,
@@ -1356,7 +1364,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file, pgoff_t index,
 		unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+	DEFINE_READAHEAD_ALIGNED(ractl, file, ra, mapping, index);
 	page_cache_sync_ra(&ractl, req_count);
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 2b00442b9d19..96fe5c7fe094 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2416,11 +2416,13 @@ static int filemap_update_page(struct kiocb *iocb,
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
 
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
 	if (!folio)
@@ -2440,6 +2442,8 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
+	/* index in PAGE units but aligned to min_order number of pages. */
+	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2500,8 +2504,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -3093,7 +3096,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
+	DEFINE_READAHEAD_ALIGNED(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
@@ -3147,7 +3150,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
-	ractl._index = ra->start;
+	ractl._index = mapping_align_start_index(mapping, ra->start);
 	page_cache_ra_order(&ractl, ra, 0);
 	return fpin;
 }
@@ -3162,7 +3165,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
-	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
+	DEFINE_READAHEAD_ALIGNED(ractl, file, ra, file->f_mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
@@ -3657,6 +3660,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 	struct folio *folio;
 	int err;
 
+	index = mapping_align_start_index(mapping, index);
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
 repeat:
-- 
2.43.0


