Return-Path: <linux-fsdevel+bounces-16052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545C897611
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461771C25F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE13152DF5;
	Wed,  3 Apr 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EyN7KUC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2715218F;
	Wed,  3 Apr 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164504; cv=none; b=Gavthn+ZVteJbkM2p+MpnR62E+9E28zK7JEVDbOaxmM4vDlzx2xvSWVarkxPp7fHgcJjUZGNch/mplG9ZJOeIuiZa6MDCySFdRBQVoK/EYEWNP3lJyGTL9oiEkvXZB30Vazmoe9iVwEH4yecgd/0V/6Ona3a6AJ1zHlXrsnO9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164504; c=relaxed/simple;
	bh=4NQWmwuZTarG2/kHv3KnA3lC4if3hblZ373xS71aU5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3asKn8rc/4vwkRHjaUNrcGgjhW8VSFNBq4Gj85b/IM6dP7P33eDCHnUKJgMO2r4Z6fxd7c40STKXkdReFajdD2ksbaVta0xoHBmV/H4b3nI9NOS2qvaNdjGrK3DvEAprgUAyQpMuhy7AIthX8MiZtdGbwaSI73FfJc0DBKHMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EyN7KUC8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zWvUIcsgXfFVuJ3plWmn3jZ25kr2d4+5CtI/6v4IbBA=; b=EyN7KUC8CWA2zAqaLb9X7NG1GP
	GiSUNPS5vCVIIMlu35ZijnrORpg4bFnx1SG0fwp47fcz0JivmxA4ljepc7FfUUJFStQIsk6geXoHq
	xuJGMUjuSk0Lsl4pnJ6N9a7wlNslepkcuIjr/DPavSZEIiqrVztxU8O/vh41CBlA27k4kcOvkiS8d
	5uOUtp8fbCvv6mQcpkbzeJJ2w5WkFqPrXrheTO96txE5EdVCIUxEql5NtRwOOOtNW2Top9YH6kyEJ
	rWamjBmbFg90mAGxY/MoGrDN13bPd0cHR6ou2rSq0ZiSNiqDAGhEh2O4KpoyWOs27H8B5Ab1kEdAg
	n26ENKww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4CQ-000000063wd-1hvu;
	Wed, 03 Apr 2024 17:14:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] proc: Convert smaps_pmd_entry to use a folio
Date: Wed,  3 Apr 2024 18:14:55 +0100
Message-ID: <20240403171456.1445117-5-willy@infradead.org>
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

Replace two calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6d4f60bc8824..8ff79bd427ec 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -578,6 +578,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
+	struct folio *folio;
 	bool migration = false;
 
 	if (pmd_present(*pmd)) {
@@ -592,11 +593,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
-	if (PageAnon(page))
+	folio = page_folio(page);
+	if (folio_test_anon(folio))
 		mss->anonymous_thp += HPAGE_PMD_SIZE;
-	else if (PageSwapBacked(page))
+	else if (folio_test_swapbacked(folio))
 		mss->shmem_thp += HPAGE_PMD_SIZE;
-	else if (is_zone_device_page(page))
+	else if (folio_is_zone_device(folio))
 		/* pass */;
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
-- 
2.43.0


