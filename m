Return-Path: <linux-fsdevel+bounces-45569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C5A79728
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE683189485F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957B71F4179;
	Wed,  2 Apr 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p++baYfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F319ABB6
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627996; cv=none; b=LpafdbNYRekGmuZXvKAHLevA0j+6ulqERDRFX6d9MEOeQ+joSd9qnKHQw1eotw6iEfBVsNd6Su03jrBFaV6Tjcyv8Fg8uS/6fRgkBNcgHItXzg+/1x2OSaoMNT5B5Ly6wE2sJWQuVmN6eTKStF71o+WbAjsC96Z+8+EqM3W4pkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627996; c=relaxed/simple;
	bh=NBijHAvAdRa0dbPiKBbb43mHodcVJ+lFrTv6NNSQLiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWU2iib5umrwwD4fAsfxTEDzMm636TP95YJxad6+YHcYfYhAD5uAZu0EM/+3GKC+8C/BpSEUuZOgNK1qJVWigv+tJJWTTaQH/8k0U8DTu04+2a4F0i8cOkiBaoUBNXKiP8fb6fGW87OdDdzKlNLPyPr2k+7I0mlmlml2xc/eNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p++baYfz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UL11Ny1HswpINtl0BZS325Krjlkrbh6vmj2yMHlUsgw=; b=p++baYfz9Bv+Q0RIgPo9kTFmHb
	8vrNlEwLKYQangSwCJlWtjtfrT1AIDQf00Uyzf9pPhrb0e5O7++HaAWwxv1fK0zt1lHqU1RQEFGJA
	/AUB3y9q2bqukF63UezfCw6z5Ivhy59ckoIG0x/Qc3LfAygilO8eY5UUQLJ4a5R1iDxNfuHtD0H9n
	49KmZbJDtJIdItnVZ8DDkloo4xQflOb3CQ+kprxRgHLu/KX0i7HJHSWoodsdaIC+dzWJBEgJADkas
	NkDjlalVz6SL4ZdkDApyZCcTu16hay92qCkAJsVFTQpRpaAIM4xDITdyePk53cOFydxBIMfcw6+Lr
	MAu7tkUg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hq-0000000AFqO-3dXI;
	Wed, 02 Apr 2025 21:06:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/8] mm: Remove offset_in_thp()
Date: Wed,  2 Apr 2025 22:06:04 +0100
Message-ID: <20250402210612.2444135-3-willy@infradead.org>
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

All callers have been converted to call offset_in_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d910b6ffcbed..99e9addec5cf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2428,7 +2428,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
-#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
 #define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
 
 /*
-- 
2.47.2


