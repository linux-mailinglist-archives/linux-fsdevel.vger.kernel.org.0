Return-Path: <linux-fsdevel+bounces-53946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D736AAF9078
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55D117ABAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1162FCE3A;
	Fri,  4 Jul 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBPaRS2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2F2FCE15
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624797; cv=none; b=niNmh6DSytC6LFmlTgxTDlOtLPW7SIMIpw7em0+VHAQgAWf7Er4EiLIiMYPwfQfd7TO0tOLgmYrJfBT/GQTbAyHV1F0NMcdsMUMI6Rk5Ndysi0lHCo6E8tRvytn8bxWPiQbj0sD0ukD0c6BA7yWvXMvjCRNuDn9HrDUOPhFVTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624797; c=relaxed/simple;
	bh=g8pdy1DKrW7JXLanGhBhAjfwcy+F0V2q4a+pmUjqPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqBXG+BEVC5TijWN6e4Xzlr2a+Vi0EsV2kRRC5CLpfwukQly7J7QcMQRjUquJXShP0p28v7Eu+XV4//3SeviA7pVSCZpRPosSe3oiNy7hvQa1xQ90hxm7gQXvtjg9vwuVAaC1NJg5uAo4MHab8pmtFbANVy0Q28DEMPgDa9cEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBPaRS2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV5TxHJVxkcIeudKWCbk5OXSzT/72+A13Qm9FGClEWo=;
	b=KBPaRS2tUiW25YrUkEdXAwZjvQi0eNdUNEXxl1DuSGLEK4OJxfubRE6QqVHbSPvyqzawFs
	yNr0+Ne60W/4uFun3EbGO0LQ2G1W95RNVuSNvEI6gK8ozLhFl4TisFB/w4Q0VsfVpcmbrt
	nQeuprWlQiY1uvLRaniIHvZvWBJtuFM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-muTxdLM0PSeIukFMZ58x2A-1; Fri, 04 Jul 2025 06:26:27 -0400
X-MC-Unique: muTxdLM0PSeIukFMZ58x2A-1
X-Mimecast-MFC-AGG-ID: muTxdLM0PSeIukFMZ58x2A_1751624786
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so461304f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624786; x=1752229586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV5TxHJVxkcIeudKWCbk5OXSzT/72+A13Qm9FGClEWo=;
        b=u+DswMNdcvxK0zl5qG2e0TYuhJbPM3GJoJGJYOZYP/HS0Y29t+yRoaq7ZReDI3nfQs
         N+UrpIhaXj1hne4HGJvBc2CyQ4SNMPQuoGLTNrogRHKzktvoas5BytQilFymVfk9HKrv
         gK6oOUvkatX6N8Pz2X2VwlpmFSKdmBTFoGDmEK2dkCc+ibMJSngSvnDS3ByCcEc9nvA6
         HLV/CCJtn+zXe6rGwdmVRUQrkw30u16DxEPTHz3prbSQ4ihvdz/XszDRns+mDI0F7qgJ
         2vq07nkzMklXTga8gxNXdxS0CEefr0hVSdkQRCMJzhJxXEYj33tmIEc4HtnbEbOQsAxJ
         3g9w==
X-Forwarded-Encrypted: i=1; AJvYcCU404Kv3x3Xwr5g0lgFtQ+AlzqQe0t/z/GCQkojVD1ItafH0/MT7AhqGNshRKD2oTIN16xzkABN+2gdfikI@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4EeQRSeN6obO9bYReyGSzlF2093Zk6yYu9Dif5dvAl3l3KJN
	Zs1U32DraDQhJxBy0YyZg31D0qSUisNeK2PbJqTe3BMSXMSeXHe3AoPY4PSXir9qBZuaBFSkcKX
	ioy512hk4XwEDswOiYlh8OI7dpu3Oa1VMcSt1gB6iMcfQwPVn0S3FvIAI9DFl5L49F18=
X-Gm-Gg: ASbGnctncwlq4oDMCbVOqCDY0TX4aXLWT2ngluzOIOdD6VgHN7Kbj1ub1JnCd7/X6H/
	R+BykiKlrqodh4LYuw9UGX4Z2jtJIK+W+Ue4/RwtlEQL8cLsMQbS13epTLhry/URdIv9qzPnRv0
	yehmveuKlulFaKSJRhgj/jshd2qWGNLPhTkheqEmZ+VdYlRguFaq8ojZn3lW78KHwLE7CBWugow
	pRUoEC6cjRTYLc+bM1KVN/MM17HB6IBG8uRPSLThL/l9nIUqxGg+Ar0ORPrBmvZ4caxzkXJtedd
	LTxfdRaTTYIKXWJe8pa4Fb5JHUAwZo+oED2jpJXHE5zmvSWNJ0LG1wNRwYzwNVRID1CEAZ71xNm
	ipdNBPA==
X-Received: by 2002:a05:6000:250f:b0:3a4:ebc2:d6ec with SMTP id ffacd0b85a97d-3b4964f8b3cmr1912163f8f.14.1751624786324;
        Fri, 04 Jul 2025 03:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYzN00fFm73NixytzJyssEXPIKOjCSlRb2NM6DBPHsu+yzHnAEmiJul0LvFdC9y1xbNexZhg==
X-Received: by 2002:a05:6000:250f:b0:3a4:ebc2:d6ec with SMTP id ffacd0b85a97d-3b4964f8b3cmr1912120f8f.14.1751624785787;
        Fri, 04 Jul 2025 03:26:25 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d0aebsm2166371f8f.37.2025.07.04.03.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:25 -0700 (PDT)
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
Subject: [PATCH v2 20/29] mm: convert "movable" flag in page->mapping to a page flag
Date: Fri,  4 Jul 2025 12:25:14 +0200
Message-ID: <20250704102524.326966-21-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead, let's use a page flag. As the page flag can result in
false-positives, glue it to the page types for which we
support/implement movable_ops page migration.

We are reusing PG_uptodate, that is for example used to track file
system state and does not apply to movable_ops pages. So
warning in case it is set in page_has_movable_ops() on other page types
could result in false-positive warnings.

Likely we could set the bit using a non-atomic update: in contrast to
page->mapping, we could have others trying to update the flags
concurrently when trying to lock the folio. In
isolate_movable_ops_page(), we already take care of that by checking if
the page has movable_ops before locking it. Let's start with the atomic
variant, we could later switch to the non-atomic variant once we are
sure other cases are similarly fine. Once we perform the switch, we'll
have to introduce __SETPAGEFLAG_NOOP().

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  2 +-
 include/linux/migrate.h            |  8 -----
 include/linux/page-flags.h         | 54 ++++++++++++++++++++++++------
 mm/compaction.c                    |  6 ----
 mm/zpdesc.h                        |  2 +-
 5 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index a8a1706cc56f3..b222b0737c466 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page);
+	SetPageMovableOps(page);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6aece3f3c8be8..acadd41e0b5cf 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -103,14 +103,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 #endif /* CONFIG_MIGRATION */
 
-#ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page);
-#else
-static inline void __SetPageMovable(struct page *page)
-{
-}
-#endif
-
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4c27ebb689e3c..5f2b570735852 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -170,6 +170,11 @@ enum pageflags {
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
 
+#ifdef CONFIG_MIGRATION
+	/* this is a movable_ops page (for selected typed pages only) */
+	PG_movable_ops = PG_uptodate,
+#endif
+
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
 
@@ -698,9 +703,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
  * structure which KSM associates with that merged page.  See ksm.h.
  *
- * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
- * page and then folio->mapping points to a struct movable_operations.
- *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
  * refers to user virtual address space into which the folio is mapped.
@@ -743,13 +745,6 @@ static __always_inline bool PageAnon(const struct page *page)
 {
 	return folio_test_anon(page_folio(page));
 }
-
-static __always_inline bool page_has_movable_ops(const struct page *page)
-{
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
-				PAGE_MAPPING_MOVABLE;
-}
-
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
@@ -1133,6 +1128,45 @@ bool is_free_buddy_page(const struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
 
+#ifdef CONFIG_MIGRATION
+/*
+ * This page is migratable through movable_ops (for selected typed pages
+ * only).
+ *
+ * Page migration of such pages might fail, for example, if the page is
+ * already isolated by somebody else, or if the page is about to get freed.
+ *
+ * While a subsystem might set selected typed pages that support page migration
+ * as being movable through movable_ops, it must never clear this flag.
+ *
+ * This flag is only cleared when the page is freed back to the buddy.
+ *
+ * Only selected page types support this flag (see page_movable_ops()) and
+ * the flag might be used in other context for other pages. Always use
+ * page_has_movable_ops() instead.
+ */
+TESTPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+SETPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+#else /* !CONFIG_MIGRATION */
+TESTPAGEFLAG_FALSE(MovableOps, movable_ops);
+SETPAGEFLAG_NOOP(MovableOps, movable_ops);
+#endif /* CONFIG_MIGRATION */
+
+/**
+ * page_has_movable_ops - test for a movable_ops page
+ * @page The page to test.
+ *
+ * Test whether this is a movable_ops page. Such pages will stay that
+ * way until freed.
+ *
+ * Returns true if this is a movable_ops page, otherwise false.
+ */
+static inline bool page_has_movable_ops(const struct page *page)
+{
+	return PageMovableOps(page) &&
+	       (PageOffline(page) || PageZsmalloc(page));
+}
+
 static __always_inline int PageAnonExclusive(const struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 348eb754cb227..349f4ea0ec3e5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,12 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
-}
-EXPORT_SYMBOL(__SetPageMovable);
 
 /* Do not skip compaction more than 64 times */
 #define COMPACT_MAX_DEFER_SHIFT 6
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 6855d9e2732d8..25bf5ea0beb83 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -154,7 +154,7 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
 
 static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
 {
-	__SetPageMovable(zpdesc_page(zpdesc));
+	SetPageMovableOps(zpdesc_page(zpdesc));
 }
 
 static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
-- 
2.49.0


