Return-Path: <linux-fsdevel+bounces-52072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CCADF496
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02CC17F03C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B03301538;
	Wed, 18 Jun 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3DmlBt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAE3009AE
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268469; cv=none; b=NCvflL2wkjunhC4ZpE9bjuM5YyI2ZYBRV2HQ3KvACeLAQ3/880gqRicxxR229Opb2aDkUWc8OsMBfUnSb4nFiVyMD7gCOMxVFK/h1eeQGgm8yolt5msEajMuSD5/xF+kfjZP4U+m+ldDHVBqxK6oUB20gf1w3XrdQf4sHjjSPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268469; c=relaxed/simple;
	bh=9tpdq1o7FbMiiO9x/kYE4cJFXkkL5WNyoS5e4zISHZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sycqb0MVDS9s7oLk7SzpkD+oEVsRtyYTMy99yFA5i8kdXKjuVskeatJJGA9e7XiwA9iBwHFucNfNbn9aqMbbdxxOUpAPH/ky9rRECtuhhKNH5dWrX2dq4Pig6nTuhFlPF7x73c6zW+/whL8Cf9pq+qZNL1kBhAqsH9XMbeNucVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3DmlBt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn7yGSPhSFiXpI5R4Bp6dvC2hmWGRnPce0Bw+h6ULBk=;
	b=C3DmlBt/+ZdxD93QvwO5OBBiYdmz88x3Aj5+7SjTLOI7ECSH3NEi+chkvEEEz5gm7bFza2
	1jr/AMrycfA4XKJTHQbp04AfZEiTdVp1UxLe1SPJ6srw3OIcZizk7CWnZ+WbkKdYdzF9sz
	NC5J6pg+18WRWykAfwC1Whv9SDrvveA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-KZUzeYftOk6_887u6M2mhA-1; Wed, 18 Jun 2025 13:41:01 -0400
X-MC-Unique: KZUzeYftOk6_887u6M2mhA-1
X-Mimecast-MFC-AGG-ID: KZUzeYftOk6_887u6M2mhA_1750268461
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450db029f2aso33240985e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268460; x=1750873260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn7yGSPhSFiXpI5R4Bp6dvC2hmWGRnPce0Bw+h6ULBk=;
        b=PtOtTU1rRRinMHiaGO93VU2Sl3CdrQVln4RuJm6jTKEIRGoRU+Rvtp4F0RND91pi13
         UwvC3/wKqTz9u3+jA9nk/hqSWqezDxxpwPf/LtUSkZc1bb9qB92u3XjcEPNZ/QhWwpx4
         uTaluDImtZ1l9xBvD3hFCbk8mBJdwGesW3L5qS+Ti20XoCFEhY2PdAKXZV8gSLSoXTrf
         ySvPVGfKlmNhXQ3KvqBCb4sCILyNvabJaCMXLtBxjWadrt69ukHVs/wwH0CEgww9nHk2
         RLwtnWxE4x6BgnTelTzQI+nMaFuiKTk+532ClAdpodt7GSlklix4qbFtzxpcbljWIUoP
         IHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUBvv2FgG/sCbYrRk+L+mwW1WRM48H5zfSaQnCUa4qnYN0pKfkC0q3/1p6Jl6e6WDt0Xy+KWLsloAVLQK0@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+Okw007AvfmNyFTsJeMM1a0z4tZdfKubBwm9JP4TtfjiT45X
	ijvNI9fVIZq9iI8uUrEwj2vKaoiPTtpoQhejTHnTTVpsDWOTrgkOwJq+ETBOreIYBVHaI6oWLGs
	OAhe30F0z7txGSGfwcmomgm66n7zEaTK/btPhFhxxIOPyfmr7XqEZvJ7JEraoH5E6uJs=
X-Gm-Gg: ASbGncsaTAW3Xu67ovRXr8AWnt7g0UEvz7DR+il4Jaq0VXuEMwwmyCxGviwBFYGn6f1
	du0/RO3jmO0RlPxUKsjhRr1F+tXkeq7sbxUwj2CGOVaxf4azKsGTw7qu15oywn3cMKg4vsfGpq/
	TZrHUL1hEW7pasgW9wBmiTPi2lPBIFaE6aw1YUp+nlbW1ANkQVEZ7yIdIbEc6qRjoFA7oApLNqu
	9Ew9F2NE1di7wQfwoaGdsO4HXWLW3vLgH3oOA04bvOi2H9Hj5Bl1dTCYPWzikoE+7dmEbn9QHdK
	Wrtdlw1b/eod4rvfdHFsKoZEPQztLJcqfuBJ11mCE6k3oPafPzPjY7PnuLrZaxY0dihfmgs1bvp
	kAOXMQA==
X-Received: by 2002:a05:600c:4e13:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4533ca7a5b4mr172426655e9.6.1750268460535;
        Wed, 18 Jun 2025 10:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPI4qnomtJiihDYZHrEYfWz3Hi6xPZWIy9RNeAMNhrydAHd5Ktr+DvLvfsdyiYBEhOo2Z7gg==
X-Received: by 2002:a05:600c:4e13:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4533ca7a5b4mr172426335e9.6.1750268460017;
        Wed, 18 Jun 2025 10:41:00 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e98b50csm3675535e9.22.2025.06.18.10.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:59 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH RFC 16/29] mm: rename __PageMovable() to page_has_movable_ops()
Date: Wed, 18 Jun 2025 19:39:59 +0200
Message-ID: <20250618174014.1168640-17-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's make it clearer that we are talking about movable_ops pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h    |  2 +-
 include/linux/page-flags.h |  2 +-
 mm/compaction.c            |  7 ++-----
 mm/memory-failure.c        |  4 ++--
 mm/memory_hotplug.c        |  8 +++-----
 mm/migrate.c               |  8 ++++----
 mm/page_alloc.c            |  2 +-
 mm/page_isolation.c        | 10 +++++-----
 8 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 204e89eac998f..c575778456f97 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -115,7 +115,7 @@ static inline void __SetPageMovable(struct page *page,
 static inline
 const struct movable_operations *page_movable_ops(struct page *page)
 {
-	VM_BUG_ON(!__PageMovable(page));
+	VM_BUG_ON(!page_has_movable_ops(page));
 
 	return (const struct movable_operations *)
 		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4fe5ee67535b2..c67163b73c5ec 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -750,7 +750,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
 			PAGE_MAPPING_MOVABLE;
 }
 
-static __always_inline bool __PageMovable(const struct page *page)
+static __always_inline bool page_has_movable_ops(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_MOVABLE;
diff --git a/mm/compaction.c b/mm/compaction.c
index 5c37373017014..f8b7c09e2e48c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1056,11 +1056,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * Skip any other type of page
 		 */
 		if (!PageLRU(page)) {
-			/*
-			 * __PageMovable can return false positive so we need
-			 * to verify it under page_lock.
-			 */
-			if (unlikely(__PageMovable(page)) &&
+			/* Isolation will grab the page lock. */
+			if (unlikely(page_has_movable_ops(page)) &&
 					!PageIsolated(page)) {
 				if (locked) {
 					unlock_page_lruvec_irqrestore(locked, flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b91a33fb6c694..9e2cff1999347 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1388,8 +1388,8 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 	if (PageSlab(page))
 		return false;
 
-	/* Soft offline could migrate non-LRU movable pages */
-	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
+	/* Soft offline could migrate movable_ops pages */
+	if ((flags & MF_SOFT_OFFLINE) && page_has_movable_ops(page))
 		return true;
 
 	return PageLRU(page) || is_free_buddy_page(page);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4d864b4fb8916..1d4d0f093af29 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1739,8 +1739,8 @@ bool mhp_range_allowed(u64 start, u64 size, bool need_mapping)
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
- * Scan pfn range [start,end) to find movable/migratable pages (LRU pages,
- * non-lru movable pages and hugepages). Will skip over most unmovable
+ * Scan pfn range [start,end) to find movable/migratable pages (LRU and
+ * hugetlb folio, movable_ops pages). Will skip over most unmovable
  * pages (esp., pages that can be skipped when offlining), but bail out on
  * definitely unmovable pages.
  *
@@ -1759,9 +1759,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		struct folio *folio;
 
 		page = pfn_to_page(pfn);
-		if (PageLRU(page))
-			goto found;
-		if (__PageMovable(page))
+		if (PageLRU(page) || page_has_movable_ops(page))
 			goto found;
 
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index cf92075108f0c..5f97369eac2f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -94,7 +94,7 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	 * Note that once a page has movable_ops, it will stay that way
 	 * until the page was freed.
 	 */
-	if (unlikely(!__PageMovable(page)))
+	if (unlikely(!page_has_movable_ops(page)))
 		goto out_putfolio;
 
 	/*
@@ -111,7 +111,7 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	if (unlikely(!folio_trylock(folio)))
 		goto out_putfolio;
 
-	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
+	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
 	if (PageIsolated(page))
 		goto out_no_isolated;
 
@@ -153,7 +153,7 @@ static void putback_movable_ops_page(struct page *page)
 	 */
 	struct folio *folio = page_folio(page);
 
-	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
+	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
 	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
 	folio_lock(folio);
 	page_movable_ops(page)->putback_page(page);
@@ -192,7 +192,7 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
 {
 	int rc = MIGRATEPAGE_SUCCESS;
 
-	VM_WARN_ON_ONCE_PAGE(!__PageMovable(src), src);
+	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
 	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
 	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 44e56d31cfeb1..a134b9fa9520e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2005,7 +2005,7 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 			 * migration are movable. But we don't actually try
 			 * isolating, as that would be expensive.
 			 */
-			if (PageLRU(page) || __PageMovable(page))
+			if (PageLRU(page) || page_has_movable_ops(page))
 				(*num_movable)++;
 			pfn++;
 		}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index ece3bfc56bcd5..b97b965b3ed01 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -21,9 +21,9 @@
  * consequently belong to a single zone.
  *
  * PageLRU check without isolation or lru_lock could race so that
- * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
- * check without lock_page also may miss some movable non-lru pages at
- * race condition. So you can't expect this function should be exact.
+ * MIGRATE_MOVABLE block might include unmovable pages. Similarly, pages
+ * with movable_ops can only be identified some time after they were
+ * allocated. So you can't expect this function should be exact.
  *
  * Returns a page without holding a reference. If the caller wants to
  * dereference that page (e.g., dumping), it has to make sure that it
@@ -133,7 +133,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) && PageOffline(page))
 			continue;
 
-		if (__PageMovable(page) || PageLRU(page))
+		if (PageLRU(page) || page_has_movable_ops(page))
 			continue;
 
 		/*
@@ -421,7 +421,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn,
 			 * proper free and split handling for them.
 			 */
 			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
-			VM_WARN_ON_ONCE_PAGE(__PageMovable(page), page);
+			VM_WARN_ON_ONCE_PAGE(page_has_movable_ops(page), page);
 
 			goto failed;
 		}
-- 
2.49.0


