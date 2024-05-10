Return-Path: <linux-fsdevel+bounces-19282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED218C23FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07A61F20CAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43A173337;
	Fri, 10 May 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evlz2X70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F717332F;
	Fri, 10 May 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341840; cv=none; b=A0AmsaIxQBzmHGuzdEtb/Z9JyyAWSfE0baPTa0/BanCRxodjR94CECL+y1Dmm3O6+AR2nfRCSMp1FZPx1CsweN1LuCWmsRRnlpz+epJgW+ie4nAg0fA2LT267Qi76a8KuM5defRMCaJKmalRL8a4hUVLiVaZXgaV9zJ25in4Vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341840; c=relaxed/simple;
	bh=cQxK5RuRCLtqyLVJVvZvaYYBIKRw42XwWucH8wgPCGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaXRUdcFmkbuUnPVqonOkCilpy9+i13achDSA77NX8A67IwSuIKVuBL/LfyPejx4JP9ZVz2BTPUIyPYZnA7SHz6Qr5o8+sIi7M+r6pzXIyVitx/Fad1eRNcye97Hlr4Zt4rGvx0BJdivaQnJsUtdmaX25/s1g2lHzKGPiLX1yDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evlz2X70; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec92e355bfso17200705ad.3;
        Fri, 10 May 2024 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341838; x=1715946638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=on6kE/iT1Lkf0hlBPN696BIDabVjdoSu5WvxX7mut44=;
        b=Evlz2X70ozKPn+IPIHEJIFptFPuhTlGo4ocxQ3BRC4LswW6gsSjjnTU8ofIgYqrkKr
         e/twaafrzFWVKGqIJF34mzr6HSXTzzKOd7soIdmVfsNZZ8PacB+pI+BP1rUjsPvSG9+G
         KgpEo6mf+aOsCp+5J5IJBBfNANt/rNleeq1v266YbhMxHztYeryCwe/SKiACjWDWlitT
         hcv9ViNxfov+lJ1vrlbcoYzYpDVeH9ef6B95a/EykPXtBOcTGcjKnVPTbV+zsuRU507r
         NNhTv3z/Z0CspPig/ns33xvjhqA1hucyXKpRwVpfeqCbKzePlMsdE7Bu4DEYLwuKNgm+
         EVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341838; x=1715946638;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=on6kE/iT1Lkf0hlBPN696BIDabVjdoSu5WvxX7mut44=;
        b=kl4KM9j3Wrp36guAvZbfirrdUeKKFNUWS6p6aiQ1jUnZ/j+8bIqY0LMRy9h4InguxU
         rgqBMn4YHdSv4U2pFuoI6+BA60XIMvs9BYnfjhiyN+uCesmP2Ldp+jqZFy51DvzCFpxk
         ORw9NrRgLoDOH2ZTcd2Cv8WU7XmAyM2b68fOorHaf1YKMGC7Qu9CKsD44z5yarLH5hGV
         xoB5CFnyy4KNOS5Ndk/3yJiIsV2xMbnKSttQSFEJc4ZmGgrLNSPfE+Ym9t0gH9NN/abV
         WvUCuGFknnqB9JEVUU+4PBr14NfNhuopS22Z9BRBHHFkqfsLxjTrk1HOF2xm1sabNASb
         n/8g==
X-Forwarded-Encrypted: i=1; AJvYcCVsnfjUgKq9QfZSzp2FP0ddsD3PtzSQWTkLCYKcTsuvEIMyq9XNLCGLN+sbC1bEnz41E+mHm/QRWKvxziXoOdzjFasfxzHcVft6iZ8+cwbHH1YZVFrfQmDxX3qQJ8a0ox5DnuAVEk1qWs6s2g==
X-Gm-Message-State: AOJu0YzpBiA+XSXXVjkaRtRhRQYSmCjFtBFh+hP+lf1TZSeA+RiobUA7
	pRNZBqKnAuwkiADBCAYx/v5/xTR60AoDEJ1F3J6ciTJuYyV1iNTR
X-Google-Smtp-Source: AGHT+IF1A9PqpbJrq3X5IQGwkaZ9z75WJ/x5Qis3xG1g8x4Md20mqXmUkOulbCkRZ+eLmOE6iEf86w==
X-Received: by 2002:a17:902:d4c8:b0:1e4:d548:818f with SMTP id d9443c01a7336-1ef4404fb62mr28624285ad.58.1715341838600;
        Fri, 10 May 2024 04:50:38 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:38 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 11/12] mm: drop page_index and simplify folio_index
Date: Fri, 10 May 2024 19:47:46 +0800
Message-ID: <20240510114747.21548-12-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
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
- folio_index

This commit drops page_index, as we have eliminated all users, and
converts folio_index's helper __page_file_index to use folio to avoid
the page convertion.

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
2.45.0


