Return-Path: <linux-fsdevel+bounces-17166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E06518A8888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA571F24C40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98A15E5AE;
	Wed, 17 Apr 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCyYBqVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BF14901F;
	Wed, 17 Apr 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370213; cv=none; b=h1n7KJrIQlKoQ7DMlQIlBnux+SyKD0LUP6U8gWmK3YhF8q5WlMXaxirUr8hKG/Diog/7pdEn8Uolesry/K2kSlAF5e+UWmnQR4oGgjtro2RlA75E/atu2Ib1u0MaV2hg2woMUFhoZMapnamoKoEtPisRlKMzy4KNPijOgIIqeEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370213; c=relaxed/simple;
	bh=5jEmnmpH4K1VGhhKveCTQ+ItuA927FSFJoiRaE+xlvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfGj7U6BniefFOuFCVr5WsMTGEx69xjmX3pySP9YfYfNl1eJonGQo6JvTDAiEpf2nV0fn41GFz/uFMLthmcOEMSEzLcDyOyA2ftEdf04v5BzLR/bnhTV7aub1KBSt4FFRnRnGEbO/owEbzYLt6dglIHbcnTCW2J63IvOdGndim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCyYBqVA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so2895501a91.2;
        Wed, 17 Apr 2024 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370211; x=1713975011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWtogKRbykZjVeWYRJzwDv6D8U3YfbstN+EZdpM/Zng=;
        b=WCyYBqVAM45DFZ74CCmCuPWB99FgBK+RwYmeOn8DcD5FEXEFRsxZAAr17nnWSswYGQ
         pLeDa9jAhxTA7LkGiTU2BhNRP5Oeg8RPJs4RPZdJQW3vbDaFmVLQMCGHzuV+ppnXu1xx
         UlQTTVh0/+rL5SssAiTZ4mIirGF3D6KsA0/f7FTgnAGtdNsa3rNZGJyT0M1AauH8N+vZ
         DXWk3JZ7AvHSfvrbcpnaq9drLLrkCaSFqqoDiMRFnI2Ws8Eq1OEFVumrBE0FyJyoomXL
         P/SZpyxnkHvuUQHzP6m5QTRLYR/iMRL+TEWuMOIzxDHrZnNsdlPJecaZ3Ckps44qk3c3
         zI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370211; x=1713975011;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWtogKRbykZjVeWYRJzwDv6D8U3YfbstN+EZdpM/Zng=;
        b=bcBTMtqSiaNcUzSQtICPPqi7rJeSFb59KkwFLOB9Te7NjbsreQhx8VItHGH8nk3+Mw
         jYAjg6pxO4YaRt+wKZZekZlDVL2elEg7CS3x+8T8gXhZBhz6tyFW4JhDF9k+oU2Q0+Bm
         9dK3lSOqhX4dNqN20Fma4+8Yumr7o1f/BLPM+qL6q5411vDU1WeR1XfQVoJl0CE4RuTv
         atuLtmP3BAuxAOQhq9uXcI9bXyg2kfL6qNX3PQujBFrs9nHxr+1NAW3MeBnSe9fKj2da
         0u1nxaI0Rq31XMWUrpvHUNrNVupY86CQNW9is3e7Quab6Wm/WN++KO9n8nC3xg2P1oWA
         4cJg==
X-Forwarded-Encrypted: i=1; AJvYcCXySZdsLEBUoXGz5zn3oPX310kI22t1knfzdgd0J8VnwkmM4qs4Rwd+szxpEVuw/wctwrMSnEfppteKRAGYuG4wL1T47CL1/D8OtZgS6lUWrkjYftYlwpBDX7xt40N2bHPMW+VrymxSVcqBBA==
X-Gm-Message-State: AOJu0YzSlqeiKSYqwTg4c7wrYLL6HIwHtgveC+oygJcdWytlyIOi5GBl
	Rk9n2MynHCSwbJ/3ybv0QIrsV91KT55lkKvx8qTgbHX4ysJgJScH
X-Google-Smtp-Source: AGHT+IG64Mg+h0HLvsWvmsefrKZFQIaXKNBvLrGP2U2HIqBvzsee7fMoaAAuubQ+ziUMJdC/6NC8Ug==
X-Received: by 2002:a17:90a:128d:b0:2a5:492b:847e with SMTP id g13-20020a17090a128d00b002a5492b847emr13549505pja.1.1713370211442;
        Wed, 17 Apr 2024 09:10:11 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.10.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:10:10 -0700 (PDT)
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
Subject: [PATCH 7/8] mm: drop page_index/page_file_offset and convert swap helpers to use folio
Date: Thu, 18 Apr 2024 00:08:41 +0800
Message-ID: <20240417160842.76665-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

When applied on swap cache pages, page_index / page_file_offset was used
to retrieve the swap cache index or swap file offset of a page, and they
have their folio equivalence version: folio_index / folio_file_pos.

We have eliminated all users for page_index / page_file_offset, everything
is using folio_index / folio_file_pos now, so remove the old helpers.

Then convert the implementation of folio_index / folio_file_pos to
to use folio natively.

After this commit, all users that might encounter mixed usage of swap
cache and page cache will only use following two helpers:

folio_index (calls __folio_swap_cache_index)
folio_file_pos (calls __folio_swap_file_pos)

The offset in swap file and index in swap cache is still basically the
same thing at this moment, but will be different in following commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h      | 13 -------------
 include/linux/pagemap.h | 19 +++++++++----------
 mm/swapfile.c           | 13 +++++++++----
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..797480e76c9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2245,19 +2245,6 @@ static inline void *folio_address(const struct folio *folio)
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
index 2df35e65557d..313f3144406e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -780,7 +780,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
-#define swapcache_index(folio)	__page_file_index(&(folio)->page)
+extern pgoff_t __folio_swap_cache_index(struct folio *folio);
 
 /**
  * folio_index - File index of a folio.
@@ -795,9 +795,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
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
@@ -920,11 +920,6 @@ static inline loff_t page_offset(struct page *page)
 	return ((loff_t)page->index) << PAGE_SHIFT;
 }
 
-static inline loff_t page_file_offset(struct page *page)
-{
-	return ((loff_t)page_index(page)) << PAGE_SHIFT;
-}
-
 /**
  * folio_pos - Returns the byte position of this folio in its file.
  * @folio: The folio.
@@ -934,6 +929,8 @@ static inline loff_t folio_pos(struct folio *folio)
 	return page_offset(&folio->page);
 }
 
+extern loff_t __folio_swap_file_pos(struct folio *folio);
+
 /**
  * folio_file_pos - Returns the byte position of this folio in its file.
  * @folio: The folio.
@@ -943,7 +940,9 @@ static inline loff_t folio_pos(struct folio *folio)
  */
 static inline loff_t folio_file_pos(struct folio *folio)
 {
-	return page_file_offset(&folio->page);
+	if (unlikely(folio_test_swapcache(folio)))
+		return __folio_swap_file_pos(folio);
+	return ((loff_t)folio->index << PAGE_SHIFT);
 }
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..0c36a5c2400f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3419,12 +3419,17 @@ struct address_space *swapcache_mapping(struct folio *folio)
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
+
+loff_t __folio_swap_file_pos(struct folio *folio)
+{
+	return swap_file_pos(folio->swap);
+}
+EXPORT_SYMBOL_GPL(__folio_swap_file_pos);
 
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
-- 
2.44.0


