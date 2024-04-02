Return-Path: <linux-fsdevel+bounces-15923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A27895D67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294A21F22DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B915DBA2;
	Tue,  2 Apr 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ql+wRWJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975615D5D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088784; cv=none; b=hJbZreCJpNraoM1CDUTlLcrsSSFDvxSA/G0RGY+7loFAumDoKq02hK1RToL4leh4eYuKJPQa7GGohYMfMBkEEEtyCn0eeul8dDBeuvKQZicQfUj4bQijrP+zgbxXVZnPJU/p7zNyLuLe0jf0fvAS8Ca2O0s0fd4KIwawQNhNnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088784; c=relaxed/simple;
	bh=bhjVpGWpPoEuqQw0l1Jh+K3sMgTRSeIw5JSxJn6jLEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjhVNU71q7XBTDjNIFfAQAJ8ja5Y7JdaxX1a/AZwXcEOs93UQvhAg6Hcb8SZoLMlnJC4C1UYwTy+ETLoyw0SnVM5KOKYsk4eMW1rHgUYp35UWEMj88pdmY8iOeLk7EzDcxD0ghfMPV5ifLExc+StjSTT9cKCyTO97PNZ2Q2W6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ql+wRWJ1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=e1hlJ7o2gk3mHAyuSZ6004f3QEoMdjwYdrk3GsoxpIc=; b=Ql+wRWJ1lLCueTZ/gqy0LLsh9P
	VENcmG/hSpXabmYcNpyTYxFrLaTiSTgK7jzG2aaK0SXqBDcOwVfWmvsmVQYNTEogzCsrVYK8XfCCa
	UVSkzLLTLL8NkPVR90FEyD4ADHSQgEmKwizHj0/T/OoyUUzjarKpAmXfPdgPhoHWSAtpURlqUUJbq
	WmhiKSLWQ1PhmyF9jM18aRlV3dwxm+Pq/C7YN5PGt1L4ZbC8KToC/ScCjyQmiIYOmLFy01ky+iDNw
	XNiwVg4udRFGvoUEhbSXbR7Sg8CMHJ8jF4Qh6vV4COchA3r7v2B0lexLgx3/wZOspm1BugZoTMYt6
	PtCRHUHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkV5-00000003qeB-2mET;
	Tue, 02 Apr 2024 20:12:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] proc: Convert smaps_account() to use a folio
Date: Tue,  2 Apr 2024 21:12:49 +0100
Message-ID: <20240402201252.917342-3-willy@infradead.org>
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

Replace seven calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b94101cd2706..e8d1008a838d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -444,6 +444,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		bool compound, bool young, bool dirty, bool locked,
 		bool migration)
 {
+	struct folio *folio = page_folio(page);
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
 
@@ -451,27 +452,28 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * First accumulate quantities that depend only on |size| and the type
 	 * of the compound page.
 	 */
-	if (PageAnon(page)) {
+	if (folio_test_anon(folio)) {
 		mss->anonymous += size;
-		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
+		if (!folio_test_swapbacked(folio) && !dirty &&
+		    !folio_test_dirty(folio))
 			mss->lazyfree += size;
 	}
 
-	if (PageKsm(page))
+	if (folio_test_ksm(folio))
 		mss->ksm += size;
 
 	mss->resident += size;
 	/* Accumulate the size in pages that have been accessed. */
-	if (young || page_is_young(page) || PageReferenced(page))
+	if (young || folio_test_young(folio) || folio_test_referenced(folio))
 		mss->referenced += size;
 
 	/*
 	 * Then accumulate quantities that may depend on sharing, or that may
 	 * differ page-by-page.
 	 *
-	 * page_count(page) == 1 guarantees the page is mapped exactly once.
+	 * refcount == 1 guarantees the page is mapped exactly once.
 	 * If any subpage of the compound page mapped with PTE it would elevate
-	 * page_count().
+	 * the refcount.
 	 *
 	 * The page_mapcount() is called to get a snapshot of the mapcount.
 	 * Without holding the page lock this snapshot can be slightly wrong as
@@ -480,7 +482,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * especially for migration entries.  Treat regular migration entries
 	 * as mapcount == 1.
 	 */
-	if ((page_count(page) == 1) || migration) {
+	if ((folio_ref_count(folio) == 1) || migration) {
 		smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
 			locked, true);
 		return;
-- 
2.43.0


