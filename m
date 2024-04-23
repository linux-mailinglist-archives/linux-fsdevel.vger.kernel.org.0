Return-Path: <linux-fsdevel+bounces-17560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3CC8AFC43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D89B2379F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D631758;
	Tue, 23 Apr 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWz1hx0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E018B04;
	Tue, 23 Apr 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912961; cv=none; b=i9VwKUwzZuf3dtbfyPtydUi4uHZmKFJIaTLVHSYgPICQzSvHXNUZ7y1oRTqKGc5cSjlNREvgFYAi9vgePWHZYAPfxeH07ewVV0kYl1nmVaNVq1iM1CWEn13tIuaO78NVnPuvXbfwu526Y0p70rlQSNYYdBYdqnY1etgrXguo7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912961; c=relaxed/simple;
	bh=mY02sjApj92WbOT1RK08GYS2x+06eI7Qu6cd3MFYGGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmFE6PHkCZW9gPC/Nnwl70qve0i24S4pUpBdnhEsPuzs/nIXW+NxsoTGMTlonoxgaubjvbSXzNOu5ZQNUR6r+Glf1q96r40Q+DcctKp7A16a/O3beiWGvLR2+rqsB4PjcWOBDu8jN0yttS275t10nX11VdbKCn4urdZ9TOC9dOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fWz1hx0j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HkiZG9m0iZUn7YHN2uAFIsSMCWAiQIiQFvg2/jh9MHY=; b=fWz1hx0jDqtp05rXrTDwSTlW1l
	oZeuyvzFJHEc/0+YW3p1DyW3UWM9dRaBZjHbmz1C2E2jOB081Aye+WIX7P/XqgdmV3Q8eP/iI/ryH
	IBIzcVOSH1sK7V8oDiocBKo6gv42nFvkExjp6vRYblqvxaazX6cDDC4vZtSxOcaBVbPeheHmXvL2Y
	k/WZKL/TVFnczAEaKfgpo7QUMvQsNxDyf8R9tZI3BePQ/lc9p6Ng0uqXMg0uvh1mlm/8c0PzoZq/D
	JiJEX09m8u2IIH8YhGn/N7Fv7wzw5XCysAFi3vVgjr8VPfs3ZvqeDOJCkoh8FHu8h1YQzPomRTlhV
	f6LivFTw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6K-2IMq;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 4/6] migrate: Expand the use of folio in __migrate_device_pages()
Date: Tue, 23 Apr 2024 23:55:35 +0100
Message-ID: <20240423225552.4113447-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a few calls to compound_head() and a call to page_mapping().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/migrate_device.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index a68616c1965f..aecc71972a87 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -692,6 +692,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
+		struct folio *folio;
 		int r;
 
 		if (!newpage) {
@@ -726,15 +727,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			continue;
 		}
 
-		mapping = page_mapping(page);
+		folio = page_folio(page);
+		mapping = folio_mapping(folio);
 
 		if (is_device_private_page(newpage) ||
 		    is_device_coherent_page(newpage)) {
 			if (mapping) {
-				struct folio *folio;
-
-				folio = page_folio(page);
-
 				/*
 				 * For now only support anonymous memory migrating to
 				 * device private or coherent memory.
@@ -757,11 +755,10 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		if (migrate && migrate->fault_page == page)
 			r = migrate_folio_extra(mapping, page_folio(newpage),
-						page_folio(page),
-						MIGRATE_SYNC_NO_COPY, 1);
+						folio, MIGRATE_SYNC_NO_COPY, 1);
 		else
 			r = migrate_folio(mapping, page_folio(newpage),
-					page_folio(page), MIGRATE_SYNC_NO_COPY);
+					folio, MIGRATE_SYNC_NO_COPY);
 		if (r != MIGRATEPAGE_SUCCESS)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 	}
-- 
2.43.0


