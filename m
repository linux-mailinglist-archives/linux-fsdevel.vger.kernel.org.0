Return-Path: <linux-fsdevel+bounces-16054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BD897616
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D149A28F734
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFED153585;
	Wed,  3 Apr 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tLVspOYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C222153518;
	Wed,  3 Apr 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164509; cv=none; b=OWugALprPw00fgHRcjmFSO+aFAnQuG6VznNGrXvp/Zkog/Nl8QHAvjQiRHcYbG3FLuaobCPIyFpX9kUe0oFqcgxSeHaWXvxSxwkaxAVHC7sZw+IdIwrlSSlaqpgsrydhgCnWzSPa+ZVA0r1HcyxXy43rGFQhaRLjd0veRg37fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164509; c=relaxed/simple;
	bh=Z1zJd2jh0x47SO1psxPi+U7qqX365ISKcvVsxesxhKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW+92YL5C5inrqZLLSYK1y47jukf9cfHWOI6F7xnj9oSvRXb5V5XocpIG02ODSoAqrEdnOiM5uBjVt/u4dIDy6f5k1BZ9DzDk2WdLPZKNU7GB6BHNuPSF21MZCYGL70fDnl6uFux9I93J9x7hxi58eRu58lpX2G+A7VhR6UMGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tLVspOYU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4iptMz7iSD6DXWLkWwgnqB96gIdT8SCjbHmreUMaKzw=; b=tLVspOYUdHehXPrlIVsS17Syyx
	qVwDtTnKGCgJR4mEvk69rFbm1UtyJOYvOvsImj4sZVqVRMAfF82EkNnqcsP/GDFZ+xSfCkMFxDlpa
	rgYab8ZAq3rp8r94El+Zfa1AUrclnIYJ69fnvnyvrqfR5DEcfJsWQ3+O8AdvTWkt0y3gKWc4N2/eY
	zP8tVnypyNn6Q3D5+0dJ2XEJ6cEtiOUUeYUOhnPHsuyIGGksFX3KKeTRSbC5lLEUk8URVbJBtCthJ
	rNJpOkE8CCsA5lgBHr+lcyNXvEyPyh86qN13KNgPC5K/eBH1+Q8VtRp1f+Wdd+ki8k8NTpc+kRXsC
	6oKiA7EA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4CQ-000000063wb-1M8s;
	Wed, 03 Apr 2024 17:14:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] proc: Pass a folio to smaps_page_accumulate()
Date: Wed,  3 Apr 2024 18:14:54 +0100
Message-ID: <20240403171456.1445117-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403171456.1445117-1-willy@infradead.org>
References: <20240403171456.1445117-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers already have a folio; pass it in instead of doing the
conversion each time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2a3133dd47b1..6d4f60bc8824 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -411,10 +411,9 @@ struct mem_size_stats {
 };
 
 static void smaps_page_accumulate(struct mem_size_stats *mss,
-		struct page *page, unsigned long size, unsigned long pss,
+		struct folio *folio, unsigned long size, unsigned long pss,
 		bool dirty, bool locked, bool private)
 {
-	struct folio *folio = page_folio(page);
 	mss->pss += pss;
 
 	if (folio_test_anon(folio))
@@ -484,8 +483,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * as mapcount == 1.
 	 */
 	if ((folio_ref_count(folio) == 1) || migration) {
-		smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
-			locked, true);
+		smaps_page_accumulate(mss, folio, size, size << PSS_SHIFT,
+				dirty, locked, true);
 		return;
 	}
 	for (i = 0; i < nr; i++, page++) {
@@ -493,8 +492,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
 		if (mapcount >= 2)
 			pss /= mapcount;
-		smaps_page_accumulate(mss, page, PAGE_SIZE, pss, dirty, locked,
-				      mapcount < 2);
+		smaps_page_accumulate(mss, folio, PAGE_SIZE, pss,
+				dirty, locked, mapcount < 2);
 	}
 }
 
-- 
2.43.0


