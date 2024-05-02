Return-Path: <linux-fsdevel+bounces-18489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234558B96DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387E2B21988
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D454BD4;
	Thu,  2 May 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNZ7iUYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC20548E3;
	Thu,  2 May 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639836; cv=none; b=sC/cyN+zUi/igPdhpKulqFxD8ZV+Pork3nby8+yihQmNC0520hMxO0/EnnWTgMWnPwFvxgmMMbztDMjYqIFewFgfkOF8v3gtjstM1/+uIiBJdyuGpl3j+zVc2y1l4wcX2mbTZYPpqN8lu7bGKo9SAlXm0EpLkni1Iwa1WcPElRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639836; c=relaxed/simple;
	bh=2lTtUhy8NY0Kb0Je8lGpuIe60RILdhnqU96HnhHFLoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOj2tKTYjM4Oo/tR15+jb1D2OoONWAJbSXWR5rdFmsjjxb4y76ySoo6Nq+0V2cVjoqpS5yCn++z6kNwBJO5Rbip4EG7iJBJK23Mf1NJRp7p2sQ1u440H2zL5Y1+I6piXgmm0q6050UHH/OlWDVCc9oLSS8EJhZslCKEzEK5HsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNZ7iUYx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so476896a91.3;
        Thu, 02 May 2024 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639835; x=1715244635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yc7f0BGrdGPhDGlU0I7BQHsZ8DqIMKXeboNv+kAHs2g=;
        b=GNZ7iUYx/MScLaN/taj5dbKE1Lf/YojN31fX6e1M6nLIOFM+Do6WuRW/0lbuVQJS28
         XHnguTT+w/LMUt9RM8BmSFKoBDHGlVwX5crWokMYM+QL4GfRL6dcYj2z3LGOIRGdNxj0
         0xyJ7lM/0Hczly2y7RRHmWP/y2/GLzAh5TCrRv8GTjL8D66Rr4GH+ryXkT2BH7OLKi3g
         67gAhA4Gq1eKihJxXttReJ/lajRIdzgChDIAtXY3aFPjMIBmcxnmDfV+HoO8eK17YrBY
         x8Mfx6MJR4PKhuyob9H4LALcRb8TseXTxbhIFdK7mZW7jhFKFGxDroGJeo6NowtDUk3P
         MPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639835; x=1715244635;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yc7f0BGrdGPhDGlU0I7BQHsZ8DqIMKXeboNv+kAHs2g=;
        b=v+eBRrQ2sCWtHsH+LLPg8eyZ51f2QKCMk1ujs0wBEeO/0v3mXyrMAkDLRn1+sjHTs3
         wHALrPqsE+OV0M2b/0aFhyCnT2nfl7Gg9en/mbmAUwZ2518DVuMCB800ybEzepQGHAEC
         ikM4nGgHcDCuyvbCDdubgN2Fi/O9pVIa882Ol5twzVkFjX4wrGvjyI2736MVX42eNz2G
         qTtFkVCqZGhGHS4uZhIn8XiV/FVGefFy9gnirrengkk33UH2vigrMEqb/lGCWwsM7TG4
         J0nmlGAIg8LzCflVxyQfgkumKBIM0K0WibyMYz3prOHmPz8k0KrLzk3ms5lK5uIHqQ+m
         iLPA==
X-Forwarded-Encrypted: i=1; AJvYcCVkeVJHZDc5nijMk46wx5uOL7bxQmmtquOimA3wuGDcWvg2OIz/q09ajVd8PxXGq3+tBHFxKlUVlGigoX5Ee6BpENOYtnSUkh8jUfqPAgTJWidm+DwsQhQoR8ZHf6kgUqGbQtPwgue/le7TTg==
X-Gm-Message-State: AOJu0YxNm5TkK8dFIbMznyboipftUBOUp3YnfiHoamMU5hw+2yJS41hH
	G+EVxLOJvA11uhIaU7swO8QpttZCTPrqbe9vf4s1XYO6onaSZNCS
X-Google-Smtp-Source: AGHT+IF8JauY0lS+CclTlem6YP0P2WISNCLiZMNb+dGq5Yq+NqFjwzPOoTCiT1f3BMH1TlaypNnwnA==
X-Received: by 2002:a17:90a:fd81:b0:2b2:b1c7:74cc with SMTP id cx1-20020a17090afd8100b002b2b1c774ccmr1628463pjb.26.1714639834668;
        Thu, 02 May 2024 01:50:34 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001e43576a7a1sm737712plh.222.2024.05.02.01.50.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:50:33 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 11/12] mm: drop page_index and convert folio_index to use folio
Date: Thu,  2 May 2024 16:49:38 +0800
Message-ID: <20240502084939.30250-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084609.28376-1-ryncsn@gmail.com>
References: <20240502084609.28376-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are two helpers for retrieving the index within address space
for mixed usage of swap cache and page cache:

- page_index
- folio_index (wrapper of page_index)

This commit drops page_index, as we have eliminated all users, and
converts folio_index to use folio internally.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h      | 13 -------------
 include/linux/pagemap.h |  8 ++++----
 mm/swapfile.c           |  7 +++----
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..e2718cac0fda 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2290,19 +2290,6 @@ static inline void *folio_address(const struct folio *folio)
 	return page_address(&folio->page);
 }
 
-extern pgoff_t __page_file_index(struct page *page);
-
-/*
- * Return the pagecache index of the passed page.  Regular pagecache pages
- * use ->index whereas swapcache pages use swp_offset(->private)
- */
-static inline pgoff_t page_index(struct page *page)
-{
-	if (unlikely(PageSwapCache(page)))
-		return __page_file_index(page);
-	return page->index;
-}
-
 /*
  * Return true only if the page has been allocated with
  * ALLOC_NO_WATERMARKS and the low watermark was not
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a324582ea702..0cfa5810cde3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -778,7 +778,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
-#define swapcache_index(folio)	__page_file_index(&(folio)->page)
+extern pgoff_t __folio_swap_cache_index(struct folio *folio);
 
 /**
  * folio_index - File index of a folio.
@@ -793,9 +793,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  */
 static inline pgoff_t folio_index(struct folio *folio)
 {
-        if (unlikely(folio_test_swapcache(folio)))
-                return swapcache_index(folio);
-        return folio->index;
+	if (unlikely(folio_test_swapcache(folio)))
+		return __folio_swap_cache_index(folio);
+	return folio->index;
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f6ca215fb92f..0b0ae6e8c764 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3474,12 +3474,11 @@ struct address_space *swapcache_mapping(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(swapcache_mapping);
 
-pgoff_t __page_file_index(struct page *page)
+pgoff_t __folio_swap_cache_index(struct folio *folio)
 {
-	swp_entry_t swap = page_swap_entry(page);
-	return swp_offset(swap);
+	return swp_offset(folio->swap);
 }
-EXPORT_SYMBOL_GPL(__page_file_index);
+EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
 
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
-- 
2.44.0


