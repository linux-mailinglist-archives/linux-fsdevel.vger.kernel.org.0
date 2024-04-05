Return-Path: <linux-fsdevel+bounces-16214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86789A3CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 20:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540C9286301
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACAA171E5F;
	Fri,  5 Apr 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AU/CDJNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3917167C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340049; cv=none; b=iyubd4J2FocGYRxB5zC7MbExJOktf1gSnCags/blAlCLV2jcTsl8ZB21VQVuSoQZEw4GeYHUJ6DiU/0crFrwHUIZ1Xj1LantTcj6YxECNIp880y73Mh2K79RXaD6jsHY6ob4E9DURgOXzAxFpMGX15AoPKFUMiUZ780IXwTlLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340049; c=relaxed/simple;
	bh=OFcnEvFZaI5ex8/g7qJYVzw/X8bZiKcPiQ4eA9IMNN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFqfozgRMQOf+NRbY4XF4avjDgrYNgfIN1hqeHDQyYrW107oZelya7Lwcyb1jturDLBE+dZL1b5JCCLWUXCPqPnUtIzj78/g4+keo1nStj3Lj30JRZlOSRyNxemT0Y3ymuaMFImwyS6DO7d6sOeT1rHb7amBJEIPpLGwqmYHByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AU/CDJNw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M4riCvTPkZb+WtxBvfsCwZTYI/DsC93Onz8kbQCsRn4=; b=AU/CDJNwaRYN1UsFM4SmhTELRn
	ZekAtC/91hXhUGtKDJ4baLx6thDE6G3cj2YCpkORgniXWa27DOXQPVGqCk+DY5lL62NuNESuYFflX
	QUV/LA2GLnyFAmn1qD8pK1ywjW1pHAVPDV8pPa8QoVrH/Msy7SmxGv8SI5MUaqC5lU+sJL8V0VIXe
	kWzshSISNI77GCNu3MIekXcHolS90GUo5gkZvbcWFafTZ0iF8krHtvREzAj4Drk4FJttEeYCMdWLI
	TCurxArypOtOQzwtrTNj8aBuzmAhmGYnPhgbtGwGIBlEPQgC4BzyFkoP68xptdFdVQDxyNpxouIjD
	s4Hj6lag==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsnrj-0000000AzEO-0g9H;
	Fri, 05 Apr 2024 18:00:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] mm: Convert pagecache_isize_extended to use a folio
Date: Fri,  5 Apr 2024 19:00:36 +0100
Message-ID: <20240405180038.2618624-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove four hidden calls to compound_head().  Also exit early if the
filesystem block size is >= PAGE_SIZE instead of just equal to PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/truncate.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..e99085bf3d34 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -764,15 +764,15 @@ EXPORT_SYMBOL(truncate_setsize);
  * @from:	original inode size
  * @to:		new inode size
  *
- * Handle extension of inode size either caused by extending truncate or by
- * write starting after current i_size. We mark the page straddling current
- * i_size RO so that page_mkwrite() is called on the nearest write access to
- * the page.  This way filesystem can be sure that page_mkwrite() is called on
- * the page before user writes to the page via mmap after the i_size has been
- * changed.
+ * Handle extension of inode size either caused by extending truncate or
+ * by write starting after current i_size.  We mark the page straddling
+ * current i_size RO so that page_mkwrite() is called on the first
+ * write access to the page.  The filesystem will update its per-block
+ * information before user writes to the page via mmap after the i_size
+ * has been changed.
  *
  * The function must be called after i_size is updated so that page fault
- * coming after we unlock the page will already see the new i_size.
+ * coming after we unlock the folio will already see the new i_size.
  * The function must be called while we still hold i_rwsem - this not only
  * makes sure i_size is stable but also that userspace cannot observe new
  * i_size value before we are prepared to store mmap writes at new inode size.
@@ -781,31 +781,29 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 {
 	int bsize = i_blocksize(inode);
 	loff_t rounded_from;
-	struct page *page;
-	pgoff_t index;
+	struct folio *folio;
 
 	WARN_ON(to > inode->i_size);
 
-	if (from >= to || bsize == PAGE_SIZE)
+	if (from >= to || bsize >= PAGE_SIZE)
 		return;
 	/* Page straddling @from will not have any hole block created? */
 	rounded_from = round_up(from, bsize);
 	if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
 		return;
 
-	index = from >> PAGE_SHIFT;
-	page = find_lock_page(inode->i_mapping, index);
-	/* Page not cached? Nothing to do */
-	if (!page)
+	folio = filemap_lock_folio(inode->i_mapping, from / PAGE_SIZE);
+	/* Folio not cached? Nothing to do */
+	if (IS_ERR(folio))
 		return;
 	/*
-	 * See clear_page_dirty_for_io() for details why set_page_dirty()
+	 * See folio_clear_dirty_for_io() for details why folio_mark_dirty()
 	 * is needed.
 	 */
-	if (page_mkclean(page))
-		set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
+	if (folio_mkclean(folio))
+		folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 EXPORT_SYMBOL(pagecache_isize_extended);
 
-- 
2.43.0


