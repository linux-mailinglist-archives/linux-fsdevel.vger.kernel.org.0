Return-Path: <linux-fsdevel+bounces-43430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B8A56990
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70E8189B581
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53321C192;
	Fri,  7 Mar 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bCVkhALH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919A21ADC3
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355660; cv=none; b=Aqli6CYhKTe6VXDT6hvjQsPHlXyWk8Qjr49+1RVywvJUCD4hrffuVqphyBZILCQ7DO0omxGbEXK4+xMfrWrhFkSuN7Lw0aghcCxVIQcf8l1aGzwc/gV7tQ9R6NBAMSd/9m1B1KkqxStdPHaKvjmAy0ZLr1qvQcA2Jn1Q4y6PYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355660; c=relaxed/simple;
	bh=1oyQwolfHOaScVoIGXCbf04phmU13qPnlRDJGsrwQNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGTOZjKqZdP+TWeD18Fd2A7aKh64nC4s/XERKZNBNU+1zb1+WNzAejgDc8s56QEaZSB2n/9hoq3Cw9hrky4bD32dZUWOG+ATLWaldkvjLSnpwIZD3qIJyHrL4r0Ra3jOjzjw46389LqBvHdNBHhVAweDPwzvWztH+M5h4LMrXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bCVkhALH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HxorfBgE1Uv1byaGENr7pDp1WuWnctNAqk3G3c3CU84=; b=bCVkhALHyYVYY1ZRHBnGCe1QqL
	8t9wy2R3quPKYY4KBJyKMDggEYqBMvyCoNB8ICvghWixxhaz2jHMV6kVsIBsS+bOqoviiM8jrxF93
	KK7250g/MVmbkejykejPIZUR7m1LWlifvA2DGHN9yI6tQfjMfPBUXmF/5ACR0oDEtKoUqUhDtY5EP
	qLR1PHgla+HM0OaedXb5zEhjTMpfsPsUkAk/EYR0zSWDnyo9UaJNpVmVJeHbpksEvmq8VwlSllVEm
	FPc66REQWUxZNFcxxaKY7WUBtHPkb9W77w4/IYg+4Xb6ET1gl7Tnsyb1P0/KRqSHbLzl4c8QG/TFQ
	dVrqbC0A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGh-2pLo;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] i915: Use writeback_iter()
Date: Fri,  7 Mar 2025 13:54:09 +0000
Message-ID: <20250307135414.2987755-10-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
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


