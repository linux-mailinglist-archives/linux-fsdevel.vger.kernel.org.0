Return-Path: <linux-fsdevel+bounces-17561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB248AFC42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB327282668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E15339AC;
	Tue, 23 Apr 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXyig58g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192B2D7B8;
	Tue, 23 Apr 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912961; cv=none; b=KhjGDqHOikKYI2H5p/oY2WrNU8igQiuEEjmD5OINWhVzGJendGdVqMiHhQRO8tqVOSZH+9qrYxYByP5Ltd8baE1GLSeYt4zF8zDrZT9Remutz/Qo+nO20yzvc13MsZY9KCxFm2GOudm+Vw7Ve2t5kE8vJKVjaVeY0hbcZ+LPjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912961; c=relaxed/simple;
	bh=x05nB8CV24cVY9QFR/FA8A3qcUuLXnziParyT35nHvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF5ehyrskuJ/l0PT93204mSPftZb7WcibZiBlhE1T+b/hxqZM+ngWFAQNgquSE648kJbiaWSHm7n/kNd4qRfHjJwsTp+LMZTICveqtarkxxgDiZtfdlrU9s1cB8hTtcVxafsB5aa/UhzlnMjW2jomX5HRDOuL9yvqFLXaHqjkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FXyig58g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1UBrmnaxgdYln7b2mU/BBhde5q/G6uvD2LkDa5Pux+I=; b=FXyig58gEqE0F6D2bAAxl1bEFd
	TbFp9s4R4fwTdL3FoSptQkFN5bTLYpT2jK+iDm6A9Vd2xto13SwNEaT1EwGTWmHY1vfbQefgEJuOR
	b/BHY7oS1QcrvdIAreAEC6wH3j+qFshjaaKAPEK3+Po/R/mODKCCYi59tgvKXJci0zKzuL66k1o8i
	4eYUH1+6nTLEPJc8Yut2z5NOHLc3JqxriqRcbP7ZBOS06YHw0F5qkjuzColyWuGAuOyZbByJWdqHu
	eN0FPCovV+XhG6nor35qADfuyXqAP339rkydvrF9oaJrG+/FwSONIFwhfZ9uaTxpLs0ZwZSOumrKM
	mX1TZc+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6I-1wTt;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 3/6] memory-failure: Remove calls to page_mapping()
Date: Tue, 23 Apr 2024 23:55:34 +0100
Message-ID: <20240423225552.4113447-4-willy@infradead.org>
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

This is mostly just inlining page_mapping() into the two callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e065dd9be21e..62aa3db17854 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -216,6 +216,7 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
 static int hwpoison_filter_dev(struct page *p)
 {
+	struct folio *folio = page_folio(p);
 	struct address_space *mapping;
 	dev_t dev;
 
@@ -223,7 +224,7 @@ static int hwpoison_filter_dev(struct page *p)
 	    hwpoison_filter_dev_minor == ~0U)
 		return 0;
 
-	mapping = page_mapping(p);
+	mapping = folio_mapping(folio);
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
 
@@ -1090,7 +1091,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
  */
 static int me_pagecache_dirty(struct page_state *ps, struct page *p)
 {
-	struct address_space *mapping = page_mapping(p);
+	struct folio *folio = page_folio(p);
+	struct address_space *mapping = folio_mapping(folio);
 
 	/* TBD: print more information about the file. */
 	if (mapping) {
-- 
2.43.0


