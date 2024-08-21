Return-Path: <linux-fsdevel+bounces-26535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7B95A550
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FA71C21F81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1816F0CB;
	Wed, 21 Aug 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIrktxoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270515C159
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268896; cv=none; b=H3IjGDiPQpu+CSquc10fA8CoAUKzsfzNBmQOdI//VJdeYk+Pf4ti6J+4t5qdg7niyId05SJrRY7y3ijDRqHXqljXKBGwMEo2Rtafrkbi3TjnYhYh3ffF2enFKeZXgtFxhWj00kk1MStvlhtHU755kJhGRJI28Z9ZKRGiwzGEb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268896; c=relaxed/simple;
	bh=okeipfWeIRteDqHs/F51CaOLIcWGfiDuyV8zMvKKvlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzczmltMlnbIGQ1qZovlQy722MEIbzqoYUuZNYcNIT46NWYHZI5xV93X/lRbLV6eu2uq8QXB1eKhBR0IPcgC++K7mQFQJs/70egzdE0W4Ly5UCTyDVUqWvm+gXM0BQnZQ82xxcVBBtsSS/q84AZE2VbydmcFnSUIbH8GIbVG0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aIrktxoI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=w4IRfGFkiFrrB3pF7j3Lr77Y/eA+6+Dyb/+szPk1dX8=; b=aIrktxoIwlcDGpbGt35aAZG/EM
	3nrAiWG+k8rQ1VBGsAzOglgpYNVayUlM0N2pPxOtaoFUNUntpMNBBwpDjf0f33ogajeNZHPjC83vu
	NhLUdrCxnYatOroIT1+6AdQ82tooWlFaSRwtP9A2EY1o25FmxZioC9E4DMgz9WCryABX1OzVhTIug
	CMkM7EmHyGj47aoMJO6mSDreAhyHMpYjcaj+7ll5DRT5dycWWQr50fRo8Hi96+rtNBGcJcI4pKWqu
	RNcFEeN7pOZUIxUZIQ2dyYQlqKQLQy6EAZ4WKyaYDfM+VAVOYeN7Fq2H9NWuJ5PbqRMbmqeR7t40i
	DNsJT++g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009cqp-1w4I;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 08/10] mm: Remove page_has_private()
Date: Wed, 21 Aug 2024 20:34:41 +0100
Message-ID: <20240821193445.2294269-9-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function has no more callers, except folio_has_private().
Combine the two functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5112049cc102..3513aa666c31 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1175,20 +1175,15 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
 /**
- * page_has_private - Determine if page has private stuff
- * @page: The page to be checked
+ * folio_has_private - Determine if folio has private stuff
+ * @folio: The folio to be checked
  *
- * Determine if a page has private stuff, indicating that release routines
+ * Determine if a folio has private stuff, indicating that release routines
  * should be invoked upon it.
  */
-static inline int page_has_private(const struct page *page)
+static inline int folio_has_private(const struct folio *folio)
 {
-	return !!(page->flags & PAGE_FLAGS_PRIVATE);
-}
-
-static inline bool folio_has_private(const struct folio *folio)
-{
-	return page_has_private(&folio->page);
+	return !!(folio->flags & PAGE_FLAGS_PRIVATE);
 }
 
 #undef PF_ANY
-- 
2.43.0


