Return-Path: <linux-fsdevel+bounces-42998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610BA4CAC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEF43AE6CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29962222597;
	Mon,  3 Mar 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vFudsMSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A3216395
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024894; cv=none; b=nuYA8q0aYOF3zjaShiaVyVogu+KCJQohzGBOTboenHckT/pnPu1wctLNR/kzOVARDjc4dOdcEMgelNISybwwoaxn21oE6jXs8NKThcIi2QwKYNyldv0aV0dEPOUwN4losE6F03dZrWOVJ6fOw8SKsIWiDcaEEjL75SDrzyB1Q/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024894; c=relaxed/simple;
	bh=ltd+CzroaAgVHUZwP56MGRkdxKI2UpUX7WD0wrPjEsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7wCsKvSgb8jThU35Poky/XysKYU9zWAKc8J3YV24FpVWWwdt2oS3Op4tdi+Fx5AUUqEpY+e7xOX46Do+6p9BH3koPOAJfXeHUJj6x7E1RY02mHTu5b4DgRIaqSPSu0t4cXmtmjzIsswDAkfMpbMZMls6sQXyWsxmeN9ZmSDW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vFudsMSq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RcgDT1xygmH/LT/R5zLj021l+cmpyVBR/9bFD0Q5VpM=; b=vFudsMSqkBn0xDDBiohbJEXHLa
	QLa7rHLnHAHYbpGTgBHCdeLaPxR/eDwkZ9Ogx8VBR6L5XhLgy+lJNRMNSca75E710QSEbHUOoNo1M
	L76wf7Jq9JAkMW/BsypioJ8w34UKNJyybD/t+CBF7TLwnFVUNaz96fEJQWnsaG+po5ISvbAvxc4iU
	JcmcWMhhFoStOofzLSG+0JY492ZJt5un3fqPpi16J3scE+Sm8eBrk6riOtX1CLMEIus+QkBd6sEIb
	Sl4ikXfWkJxHzG4hlFdcWc/5wgjBhQezQMrW5xk/ccwDsgPgRlM2KqdndnyrSmYcLgcVY5WSDE1pZ
	47MKkj2g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpA6P-0000000DqhH-09Od;
	Mon, 03 Mar 2025 18:01:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] mm: Delete thp_nr_pages()
Date: Mon,  3 Mar 2025 17:53:16 +0000
Message-ID: <20250303175317.3277891-7-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303175317.3277891-1-willy@infradead.org>
References: <20250303175317.3277891-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now use folio_nr_pages().  Delete this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d5844ade822c..39eef633d725 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2129,15 +2129,6 @@ static inline unsigned long compound_nr(struct page *page)
 #endif
 }
 
-/**
- * thp_nr_pages - The number of regular pages in this huge page.
- * @page: The head page of a huge page.
- */
-static inline int thp_nr_pages(struct page *page)
-{
-	return folio_nr_pages((struct folio *)page);
-}
-
 /**
  * folio_next - Move to the next physical folio.
  * @folio: The folio we're currently operating on.
-- 
2.47.2


