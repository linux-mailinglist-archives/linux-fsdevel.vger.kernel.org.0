Return-Path: <linux-fsdevel+bounces-16055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904E897618
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7A11C279C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E294B153825;
	Wed,  3 Apr 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uv9Z4GOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96F15358B;
	Wed,  3 Apr 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164511; cv=none; b=cQu6eiqV5xmdwig1eVRZnMdP93mN8HH6CYfBuw4U2MBGBEYLFdQIa2km14rkGbL6t+hnXntBT0RLil0J2v7mR0FACtDkWQHQNCkXAuHOsMlEnjBGj7IeSGNmpTlVhHFFGAsQ7Bhd2FSUYyIOQ8mBJCdy7PDTX/Ca9ben3SZ5fZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164511; c=relaxed/simple;
	bh=Ed0wNz8ZAEpCmpMP3hzl7NOmskAcmEE86UAbx5J7HPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0mEr+aHSGrupllzMRE4sgyqZvDtuRMomG32+15iiTDb8LeGc9ajfPcPOeZI5UAJ/Pb7u4gBOSRCYknEUOz3hReqlyLyPmkcCs781xz6oqp7ji7FEd90xlxHNJAJEKVrl8NS9RqORIJYkhMw3lJj7TLZn+HaWDCpGcqP6aTGQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uv9Z4GOP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wbcNRsb1B9OYyyrrlq1n5AUXVLnlKeePbbuQlBkeIGo=; b=uv9Z4GOPcU9GrYuVe8vFQvs4wb
	FykzKMLugI66A2IzTVi0QUC1kE9TBiYbaKEtcUK9zNvPJ1EkotCNOGAcZT8SHdsGMEUTjFagya8mL
	11sii8ap6W1w9r+zeGgY9/t7ZpLQOIz6iA86bjk8KQoCfF7Y6+CQeHW55t9S6wSgcQ/YyT4wYgJTf
	PQZPiW4kNV//tGP6mRut5v0i2+tRoZvo6O2rnOFKivIFdAFW/w2WzRvm+7NbqKrf9YfRPBFLTGaw8
	z5WiAAx1WFoOcWJhsC71C47cOizzZAZQ668LTjiXdOuBg2lXoC6kewTMi28sHFFRLGr7e2BoyQUv0
	9Zh38Byw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4CQ-000000063wZ-12bp;
	Wed, 03 Apr 2024 17:14:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] proc: Convert smaps_page_accumulate to use a folio
Date: Wed,  3 Apr 2024 18:14:53 +0100
Message-ID: <20240403171456.1445117-3-willy@infradead.org>
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

Replaces three calls to compound_head() with one.  Shrinks the function
from 2614 bytes to 1112 bytes in an allmodconfig build.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5260a2788f74..2a3133dd47b1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -414,11 +414,12 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 		struct page *page, unsigned long size, unsigned long pss,
 		bool dirty, bool locked, bool private)
 {
+	struct folio *folio = page_folio(page);
 	mss->pss += pss;
 
-	if (PageAnon(page))
+	if (folio_test_anon(folio))
 		mss->pss_anon += pss;
-	else if (PageSwapBacked(page))
+	else if (folio_test_swapbacked(folio))
 		mss->pss_shmem += pss;
 	else
 		mss->pss_file += pss;
@@ -426,7 +427,7 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 	if (locked)
 		mss->pss_locked += pss;
 
-	if (dirty || PageDirty(page)) {
+	if (dirty || folio_test_dirty(folio)) {
 		mss->pss_dirty += pss;
 		if (private)
 			mss->private_dirty += size;
-- 
2.43.0


