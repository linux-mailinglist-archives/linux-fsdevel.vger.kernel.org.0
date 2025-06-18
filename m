Return-Path: <linux-fsdevel+bounces-52075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E674AADF4A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48813A7D04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2D30207D;
	Wed, 18 Jun 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx1Web6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999312F548B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268473; cv=none; b=bIsGNL0R32knl36CkKWWBKbPzbE7Q9lLZpGiY0mf48OQN47X9AUEy+VvwsfnQkNB24cAF8Qfyt22m2kyob50F5W6EUIJhUDwtszDwkpdWZJhFedNFzj70Utv9y4Fzc+MyMoW6Hrgc3Mh//yqDBS36bZsoNSUItint9BshaTzvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268473; c=relaxed/simple;
	bh=mz892AAXYlO5CKl8RE5EQFbQoV+Cb7/Iv0Y/vIRyypU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6cxq1mvGU6hv6KdB5N/ZCl72Y6Frm+WXgB2ywrxuBaLJa3EdnniTM/qAKflgn7IEMzyntEiWPS8+W8Jmv+kdR9gA2BsBiWompeDEtuuZ9daVp7pxEeYfyu7S845lWar5G7/b6aEFXn5dyztXIvjVeGcbmEuv6DZvh/rPjqQF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lx1Web6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzfM28AXUPw/AfYpLS1hZTUERIY8AF/rsj6KIsT8/ZY=;
	b=Lx1Web6nwsfjq7L8yI7HvfwjesxKynK7mH8w6XNuBIGTaKGmTrKyabsxzLRUaJgV489gvW
	mf/TA0ETylGPKiIvxPrLSLkLRadFTOQMjJo91hhWHSrLjJrg7dPJBgTwFEldosWAKvsewB
	SvMRk9E94XF5+6KWwu+QZrHQB3wJWpQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-504VXkFIN6mFy3b6u1XWLg-1; Wed, 18 Jun 2025 13:41:09 -0400
X-MC-Unique: 504VXkFIN6mFy3b6u1XWLg-1
X-Mimecast-MFC-AGG-ID: 504VXkFIN6mFy3b6u1XWLg_1750268468
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso37583655e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268468; x=1750873268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzfM28AXUPw/AfYpLS1hZTUERIY8AF/rsj6KIsT8/ZY=;
        b=io4+kYEEOls9udrlDH4B9gGrdLR8pSmNTEIeXajNOBplVSbVC68ysnkaAyZ9jpGcWj
         JgeJvZ8vWf0yhPRw5R4BwlegzGQASqMO2ehVYqx/D3Y0evCnz2RA6I8vGrYviXNrKeN8
         PInGL5BR+H2uaE5ItyHuKF+Jk7DCOL0R1RnqkMEHiT+6q+jz/rOh30KW8/JfIOwiAZmo
         uhxqIN855QALEo4hScEgbG+Cft9St4T9TsEHdEi460FcAeBzq6HfT05ZJNgRZSGQwCs6
         pRgE4UdC+UoXV2l5Y+W2qFdRKgR1wCKD5C8A+cvnxikzdQndXgFc82CcQXDrVOGdkyfJ
         Qi5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwKNP7SoSOEIO6qYbTPjmsXrbLHMpAQotti/bVeC5/R2xio5+V23enqhTJWBqs1sgvvuNLN/HSi92Y+ErC@vger.kernel.org
X-Gm-Message-State: AOJu0YymFScZZTHqAeliHztB8OV8op9GajJY/7jLRMBZW47NowzYHn4A
	E85VR4UA5nL1nlmVcAFpFlkg5CbfB3LVNImjshQzgqVdRwzAm5SckHMyVTsV6Wq3TljLGDLV9Y0
	V0iHjKuN3YT5zcX9QqhoH9WgEw6Y+pcq/063T19Wu32sBMIhdo3WGyLgP8dYqOmRnvpY=
X-Gm-Gg: ASbGncvCcoTyyHD82RDyQi4p7B215M9WaYSJjMqD26pbBo6nEf7V1wEj7gnjQk3/OHL
	o4LequmY1tZVzZiQdJx95i+NcD7tKn9cVwNpLL0S+tPG+1Ltf7YDBSvVTXI3m/cIh2sj2T+8IMU
	uYHoC02QyBH+eLE1tUfBxr74qQa6CD8TYLgQYer+/ZrMbXjirD67RhF2QYj1MR5uhuQk/HOP5Wl
	1FhiWcUz20hqouD8qO9TG4Jae1BNXWsPgtdUXUaB8swbeB4Wy73pHAcQ7JM+t1ZUY7q2kBTPXwC
	/fYfcA1i/QH3cdEhpew9uolnCKU8NPUXn/AQXG3oBVxF3juSKIqm1n8FWiAbgl33B8LluKiDRui
	E2BQgsg==
X-Received: by 2002:a05:600c:820c:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-4533caa2186mr184242855e9.17.1750268468355;
        Wed, 18 Jun 2025 10:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKEjDqAoZjEM/lQyE0UXotydmkpa81gpxxIPt+zLIqzN6Ot9NSYzqnSxIiiN03uF8vCn5Ghw==
X-Received: by 2002:a05:600c:820c:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-4533caa2186mr184242395e9.17.1750268467893;
        Wed, 18 Jun 2025 10:41:07 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b087b4sm17884528f8f.51.2025.06.18.10.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:07 -0700 (PDT)
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
Subject: [PATCH RFC 19/29] mm: stop storing migration_ops in page->mapping
Date: Wed, 18 Jun 2025 19:40:02 +0200
Message-ID: <20250618174014.1168640-20-david@redhat.com>
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

... instead, look them up statically based on the page type. Maybe in the
future we want a registration interface? At least for now, it can be
easily handled using the two page types that actually support page
migration.

The remaining usage of page->mapping is to flag such pages as actually
being movable (having movable_ops), which we will change next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  2 +-
 include/linux/migrate.h            | 14 ++------------
 include/linux/zsmalloc.h           |  2 ++
 mm/balloon_compaction.c            |  1 -
 mm/compaction.c                    |  5 ++---
 mm/migrate.c                       | 23 +++++++++++++++++++++++
 mm/zpdesc.h                        |  5 ++---
 mm/zsmalloc.c                      |  8 +++-----
 8 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 9bce8e9f5018c..a8a1706cc56f3 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page, &balloon_mops);
+	__SetPageMovable(page);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c575778456f97..64639dab92b91 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -104,23 +104,13 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page, const struct movable_operations *ops);
+void __SetPageMovable(struct page *page);
 #else
-static inline void __SetPageMovable(struct page *page,
-		const struct movable_operations *ops)
+static inline void __SetPageMovable(struct page *page)
 {
 }
 #endif
 
-static inline
-const struct movable_operations *page_movable_ops(struct page *page)
-{
-	VM_BUG_ON(!page_has_movable_ops(page));
-
-	return (const struct movable_operations *)
-		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
-}
-
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 13e9cc5490f71..f3ccff2d966cd 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -46,4 +46,6 @@ void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 		  void *handle_mem, size_t mem_len);
 
+extern const struct movable_operations zsmalloc_mops;
+
 #endif
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index e4f1a122d786b..2a4a649805c11 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -253,6 +253,5 @@ const struct movable_operations balloon_mops = {
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
 };
-EXPORT_SYMBOL_GPL(balloon_mops);
 
 #endif /* CONFIG_BALLOON_COMPACTION */
diff --git a/mm/compaction.c b/mm/compaction.c
index f8b7c09e2e48c..a10f23df9396e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,11 +114,10 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page, const struct movable_operations *mops)
+void __SetPageMovable(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE((unsigned long)mops & PAGE_MAPPING_MOVABLE, page);
-	page->mapping = (void *)((unsigned long)mops | PAGE_MAPPING_MOVABLE);
+	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 37e722fbfee70..a36030de94f30 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -43,6 +43,8 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/balloon_compaction.h>
+#include <linux/zsmalloc.h>
 
 #include <asm/tlbflush.h>
 
@@ -51,6 +53,27 @@
 #include "internal.h"
 #include "swap.h"
 
+static const struct movable_operations *page_movable_ops(struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
+
+	/*
+	 * If we enable page migration for a page of a certain type by marking
+	 * it as movable, the page type must be sticky until the page gets freed
+	 * back to the buddy.
+	 */
+#ifdef CONFIG_BALLOON_COMPACTION
+	if (PageOffline(page))
+		/* Only balloon compaction sets PageOffline pages movable. */
+		return &balloon_mops;
+#endif /* CONFIG_BALLOON_COMPACTION */
+#ifdef CONFIG_ZSMALLOC
+	if (PageZsmalloc(page))
+		return &zsmalloc_mops;
+#endif /* CONFIG_ZSMALLOC */
+	return NULL;
+}
+
 /**
  * isolate_movable_ops_page - isolate a movable_ops page for migration
  * @page: The page.
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 5763f36039736..6855d9e2732d8 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -152,10 +152,9 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
 	return page_zpdesc(pfn_to_page(pfn));
 }
 
-static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
-					const struct movable_operations *mops)
+static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
 {
-	__SetPageMovable(zpdesc_page(zpdesc), mops);
+	__SetPageMovable(zpdesc_page(zpdesc));
 }
 
 static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 72c2b7562c511..7192196b9421d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1684,8 +1684,6 @@ static void lock_zspage(struct zspage *zspage)
 
 #ifdef CONFIG_COMPACTION
 
-static const struct movable_operations zsmalloc_mops;
-
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *newzpdesc, struct zpdesc *oldzpdesc)
 {
@@ -1708,7 +1706,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
-	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
+	__zpdesc_set_movable(newzpdesc);
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
@@ -1815,7 +1813,7 @@ static void zs_page_putback(struct page *page)
 {
 }
 
-static const struct movable_operations zsmalloc_mops = {
+const struct movable_operations zsmalloc_mops = {
 	.isolate_page = zs_page_isolate,
 	.migrate_page = zs_page_migrate,
 	.putback_page = zs_page_putback,
@@ -1878,7 +1876,7 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 
 	do {
 		WARN_ON(!zpdesc_trylock(zpdesc));
-		__zpdesc_set_movable(zpdesc, &zsmalloc_mops);
+		__zpdesc_set_movable(zpdesc);
 		zpdesc_unlock(zpdesc);
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 }
-- 
2.49.0


