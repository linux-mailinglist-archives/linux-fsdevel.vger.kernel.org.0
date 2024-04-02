Return-Path: <linux-fsdevel+bounces-15922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB23895D66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D02E1C22E04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4383E15D5D1;
	Tue,  2 Apr 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFSBRA+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EC12BF20
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088781; cv=none; b=hGOq9i6reQsZZFKLX73KO0rVtVDOv5P2LUUE5/AycLARTF5c5RKpProZMiZFIZVrWZLhnhdsbmkpKA/rtQPY6mNo3BluvFPcDa8NXUJIPx21okBgydmoa9L+7IvyKplk6iYW/2PRdQreyPEm5Sn61MfhFQT0iMhu2T8sYdBcYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088781; c=relaxed/simple;
	bh=AKKQUQVL9PPEY9ddlf6WvJr0f0geZN4h9eAfU+3sDFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xka9zGIsZwrZz6oYjYvzZiAeXuEr9BablzGOqPZYwpao8HFpR/PsuS4w6IEQxk4e3N8+/QMz0ojOD1csnGovHK3YLjwjqqTafcyptNsw8wjDQ1O2t/H44eWToQfPpLbaHYwTbBkrNyC6S3T+eIZN4sZacfKpRZLb3Ep6vsIh8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFSBRA+D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aGWyUYT48YDE0Cw8D9rqi8Yjlewy6qzvPlzZEpe8jC4=; b=KFSBRA+DOIo/e3gn0cB/MqI584
	BZhGwMIi1Fbj5QSAzWFE/2KsMjLQ5og1aJBVTsZ+exboTHaAo6wcL9Ruh6gEK5K31iCrFiTLMX9Er
	uhLmtz2Ihs1MDcf1Gf+XiYBcmfWPGIHf1novrK+wJEI6fOyoE/9PDGH+uiXvulPrlwoM3wUcJdZie
	MHRZRvVjJmvrwLgGWA+OPJR+SHQE0buExlLRQKzpkxi4Sav2x/cm+qXKq6uCmCpwl+qe9SwzAFILY
	pX3qXCuCLd+voMTc/1bzLJKKMXdTgSgr6TCQ2ML0yyO9/IhgZc8R6FS0MYqhmSDPog9g0Vc93pH0b
	CQ4YJoEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkV5-00000003qe8-2Ulc;
	Tue, 02 Apr 2024 20:12:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] proc: Convert clear_refs_pte_range to use a folio
Date: Tue,  2 Apr 2024 21:12:48 +0100
Message-ID: <20240402201252.917342-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402201252.917342-1-willy@infradead.org>
References: <20240402201252.917342-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces four calls to compound_head() with two.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 23fbab954c20..b94101cd2706 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1161,7 +1161,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte, ptent;
 	spinlock_t *ptl;
-	struct page *page;
+	struct folio *folio;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -1173,12 +1173,12 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pmd_present(*pmd))
 			goto out;
 
-		page = pmd_page(*pmd);
+		folio = pmd_folio(*pmd);
 
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
-		test_and_clear_page_young(page);
-		ClearPageReferenced(page);
+		folio_test_clear_young(folio);
+		folio_clear_referenced(folio);
 out:
 		spin_unlock(ptl);
 		return 0;
@@ -1200,14 +1200,14 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(ptent))
 			continue;
 
-		page = vm_normal_page(vma, addr, ptent);
-		if (!page)
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio)
 			continue;
 
 		/* Clear accessed and referenced bits. */
 		ptep_test_and_clear_young(vma, addr, pte);
-		test_and_clear_page_young(page);
-		ClearPageReferenced(page);
+		folio_test_clear_young(folio);
+		folio_clear_referenced(folio);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
-- 
2.43.0


