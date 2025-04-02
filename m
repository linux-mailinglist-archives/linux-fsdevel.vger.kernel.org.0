Return-Path: <linux-fsdevel+bounces-45562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4EFA7971C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A516A1713F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41151F09B8;
	Wed,  2 Apr 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2DK+Qms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECE1F12FC
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627979; cv=none; b=Znxxol0TCTBvUDHGxGlj8OiIVLzOyYQfBlLyPq6ChkbjptC7zcRgihbxdKvvsNEFc0Ozw9c0QtvfYBeSAEcKxVbUufzQw8Ocd+cs50zc5uLCAQa5meslmcFYLe6T+4aIfAxBJ1+v/IXpH642aYW9m7UnbiAtFIoYezBP+M9woEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627979; c=relaxed/simple;
	bh=631XXxZ6QxK0nwCz9l0I946hVkNjfd19zySPawygyS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7fknmlkz508PUkXtopyYlCITxhnOVkMFTeDs2HUmWPb+hhexCuOVJNdBi+S5cy3oySWmWmE6kA16FU66eqh4oHdiYM16bUZzPaNQNfCiF6X3odlZTCZC4ylEjExNtFskuDZ3CGLCdx+Tn4of4xn14QjdC6AqpnLikexo11K+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f2DK+Qms; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gdGXfhvjWL/gl6s0ULg0sXpHWuECaey6MytSISUvSmU=; b=f2DK+QmsfkUD/9y4y4p6uFyAwb
	QLKoKT75nwTlNhnRPTNi4DRKLsQoa9GtN6h3hra4F9k9HdCm1YwdBPh6yfjNF7TKxYvc6Y6v3rLss
	VgWtvxQcw4Tg8/JpilLjBADO2U/dDu5JhewobDEw0UQreO3z5YMvcVI5Nhg2vJYlMtIexflianipV
	xPZD0HM/TzY6GxJDkjlkgGGFefv9/Zx6p8etSM+UZ5hw/CkXF6nn+cYzffzwgYI5qDL3fU/wybR0O
	MRWnM6IHE4AoGFEejZBW//wZypeDTU3eOybS8sDyc2IeoqsgK7Ct9iiDKqsUylW7aeewwxC7epke8
	x+YdsdAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hr-0000000AFqp-23Ip;
	Wed, 02 Apr 2025 21:06:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] mm: Delete thp_nr_pages()
Date: Wed,  2 Apr 2025 22:06:10 +0100
Message-ID: <20250402210612.2444135-9-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402210612.2444135-1-willy@infradead.org>
References: <20250402210612.2444135-1-willy@infradead.org>
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
index 99e9addec5cf..0481e30f563e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2206,15 +2206,6 @@ static inline long compound_nr(struct page *page)
 	return folio_large_nr_pages(folio);
 }
 
-/**
- * thp_nr_pages - The number of regular pages in this huge page.
- * @page: The head page of a huge page.
- */
-static inline long thp_nr_pages(struct page *page)
-{
-	return folio_nr_pages((struct folio *)page);
-}
-
 /**
  * folio_next - Move to the next physical folio.
  * @folio: The folio we're currently operating on.
-- 
2.47.2


