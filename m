Return-Path: <linux-fsdevel+bounces-45526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFCA791BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2F3168A4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A6F23C8AF;
	Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rgpmie3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BEA23C8C1
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606017; cv=none; b=TFDpSU2ufqCUxHzEmAhxsSDIWIStHtnlDHmBOTWIURsWXGts2PW9/WFBwnxkkeIJJ3TKBad5zLOmm674zK8WoZtsodfACKbVCpIa7PgsFMnYkGT8gzQd/I4451AUGbx+xsRd52aPjJ5ZbLJL6hX1/kj+hvSKpatljKhgMjyd4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606017; c=relaxed/simple;
	bh=1oyQwolfHOaScVoIGXCbf04phmU13qPnlRDJGsrwQNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xj4Sjs53TRXSe0qIS+CKvGOPSqY44rqIeD3LsjwDCVghgJ4eYpoHt/22IMyp7xnCtcpuMouiTGcXztJof0prcfxowgDN8F8ZIgi/hF7A/cCyPTVD0r2QB+vALqVjaJCv+7Yy0aIRhttzimjXUR6CtBIUI74rCGXIgkjIF5WO9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rgpmie3P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HxorfBgE1Uv1byaGENr7pDp1WuWnctNAqk3G3c3CU84=; b=Rgpmie3PxYC1mfYW3w8XJdLFLM
	68IZm5NGrCaClZqC3nKJYdIKGsB9h3JMsYOLPPY8ATYR0OcEt13uXZk9CS0jPSa/6/OEnVSnp+edn
	JtxL3K6k/cAaAPnIWeuw6+iwIVR25bAFZBbxqjronOrOtc8H5iobhcWmrZQdGWb2o0JqDsgecbGEB
	HfdWvIXKNnyRerhjAo32CuQy3pHoEKaBz0FHeCA9ZaSmapfUsfM+zxb2hRq+btwmZYOlie2LnekjW
	vQoPBKxXlold4/4j1Yc7w9yTYhuj1kWqrWw/hO7N07E6HYSJUOZHneXcoL9DAx1IweKyALy4yV8tG
	M75fmUIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gsR-2QUj;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 6/9] i915: Use writeback_iter()
Date: Wed,  2 Apr 2025 16:00:00 +0100
Message-ID: <20250402150005.2309458-7-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert from an inefficient loop to the standard writeback iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 32 ++++++-----------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ae3343c81a64..5e784db9f315 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -305,36 +305,20 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 		.range_end = LLONG_MAX,
 		.for_reclaim = 1,
 	};
-	unsigned long i;
+	struct folio *folio = NULL;
+	int error = 0;
 
 	/*
 	 * Leave mmapings intact (GTT will have been revoked on unbinding,
-	 * leaving only CPU mmapings around) and add those pages to the LRU
+	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
 	 */
-
-	/* Begin writeback on each dirty page */
-	for (i = 0; i < size >> PAGE_SHIFT; i++) {
-		struct page *page;
-
-		page = find_lock_page(mapping, i);
-		if (!page)
-			continue;
-
-		if (!page_mapped(page) && clear_page_dirty_for_io(page)) {
-			int ret;
-
-			SetPageReclaim(page);
-			ret = mapping->a_ops->writepage(page, &wbc);
-			if (!PageWriteback(page))
-				ClearPageReclaim(page);
-			if (!ret)
-				goto put;
-		}
-		unlock_page(page);
-put:
-		put_page(page);
+	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
+		if (folio_mapped(folio))
+			folio_redirty_for_writepage(&wbc, folio);
+		else
+			error = shmem_writeout(folio, &wbc);
 	}
 }
 
-- 
2.47.2


