Return-Path: <linux-fsdevel+bounces-16053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA12897613
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7EC28E96D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886481534E0;
	Wed,  3 Apr 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O6+39Y3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51523152DE7;
	Wed,  3 Apr 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164506; cv=none; b=flqBlwsdE4tBp61GnAbVNQ8sUtmR0uilGjVUNy6RdZv4oMTNRL1KzR1wFYLbgBKoOwSvDRuGgiB5oUsFN88vuB6OVfgx4mnrEC75NgsHS4cHOAg0nJCvueZe19V5BMtsnONDIBJKkEm0RJXygr9XAIe0uWAQI0lvknLiY+iJX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164506; c=relaxed/simple;
	bh=YEZSyj08uAWUgvVNCL0bhk/P8dX/wHCa62h9mJQyDxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDXrdaiqXHHpWcEYE8XC0dos0rjHpUhm9Vw/ffwwd3/WiES4yFnlCt/JVgwBpkmkrW3vrLBFMMBAVbhfAILLM8QP1w9v3fmCHmw8sYPY9mW60RcZUD3FUl9lD6Z5SNxh2pi7+ibbFZBXRTz5C6ZARJyRneWUsrnRLikEWY9lNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O6+39Y3c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PV5UzSxT44kEb6CXRTq0MrEyiFGg30Ta3X7PuDVeqgc=; b=O6+39Y3cqfq3/j0yYE+/iPXAL0
	hbwNKgv7dJBqPHYibJqj/20b3p6ucW8gY4agsx4sUkPXoaKMfQUANxQLb3T5GCU5p34NhrbzjoeBq
	88619o6cVdcdZzPcLHEQIQKpFzlWZzsb3N7X75LAvXw0IEoDzxipLREDBUTGw8PAYheqJOcj2Crut
	Q6rxT/qcD3pXBfdtaZ9PqyULVT67OS/NwMmBFElvq5Gk0eseYGyD3QOWflvhIT1D3afPn/nVVNhVA
	Ppgy7ekTjYs5bX3147tEggxSQjgNNvY96EW7042kehl1iFkUzdmjJOxe87S5zOW+8eOnpIVehrAGJ
	pLRZNwUg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4CQ-000000063wX-0l0Y;
	Wed, 03 Apr 2024 17:14:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] proc: Convert gather_stats to use a folio
Date: Wed,  3 Apr 2024 18:14:52 +0100
Message-ID: <20240403171456.1445117-2-willy@infradead.org>
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

Replaces six calls to compound_head() with one.  Shrinks the function
from 5054 bytes to 1756 bytes in an allmodconfig build.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e8d1008a838d..5260a2788f74 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2549,28 +2549,29 @@ struct numa_maps_private {
 static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
+	struct folio *folio = page_folio(page);
 	int count = page_mapcount(page);
 
 	md->pages += nr_pages;
-	if (pte_dirty || PageDirty(page))
+	if (pte_dirty || folio_test_dirty(folio))
 		md->dirty += nr_pages;
 
-	if (PageSwapCache(page))
+	if (folio_test_swapcache(folio))
 		md->swapcache += nr_pages;
 
-	if (PageActive(page) || PageUnevictable(page))
+	if (folio_test_active(folio) || folio_test_unevictable(folio))
 		md->active += nr_pages;
 
-	if (PageWriteback(page))
+	if (folio_test_writeback(folio))
 		md->writeback += nr_pages;
 
-	if (PageAnon(page))
+	if (folio_test_anon(folio))
 		md->anon += nr_pages;
 
 	if (count > md->mapcount_max)
 		md->mapcount_max = count;
 
-	md->node[page_to_nid(page)] += nr_pages;
+	md->node[folio_nid(folio)] += nr_pages;
 }
 
 static struct page *can_gather_numa_stats(pte_t pte, struct vm_area_struct *vma,
-- 
2.43.0


