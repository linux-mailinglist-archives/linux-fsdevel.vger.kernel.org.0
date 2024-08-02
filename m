Return-Path: <linux-fsdevel+bounces-24880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830BF9460F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050181F21D64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116B166F1E;
	Fri,  2 Aug 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSl5wOHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D791537C1
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614155; cv=none; b=EgqyfriR4XYgHQjms/mTKX8+3rPA5HjbUwyPMDqWp+FtMAK2vmE7KS/zpSlbWDDWfSoVXbEyZtIxn4hfLGsGOOQa44qRNNZkzT2pourUyru1hTsrgcBzR8RK/bjzXeDMe0/4EV47w+XdbYPnlCQGm2ypitNIL92fCBmb+aSNj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614155; c=relaxed/simple;
	bh=+2mciwQZhQgiba+/ptMKy+LVt5h9+laF7gW8HKD2Vew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPLYTAPz4bz/1u44n5bc5dViE/g7XHezSh+hqMz156e2iJhO6PzlAkLemcRkayLjxvMLLJcgRU2xzYlg+WYbzpJhD1zVvxuzEZTYoiaFIfIFU+fAzW0fVgWnow2PQSFEsMeFR0AEeq3Af1zrWe+zvTkEM4Zj4YVrZpIXVNG0mas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSl5wOHe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsiWiNzwiDquKdRCTf6m6XAEYG/mEcIY3V2xwGU3/s4=;
	b=hSl5wOHeFlC8wjG5H/05lYM3u/qrfqI0Lpn+sKX8vkBbC8bXnlmuV5bcIM0mupwj35tk0E
	7AyOKu3d4si6/7DdjzZjq1z+AStlUG8FyQTvrk1dIKlHPZSMNka8HOC/al02667WylxsJh
	O0c7Ti3EYPKsXdpQPkJRoNllzOnh/34=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-BK2N-7WpOw6In_X1MJIYww-1; Fri,
 02 Aug 2024 11:55:48 -0400
X-MC-Unique: BK2N-7WpOw6In_X1MJIYww-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D131944AAF;
	Fri,  2 Aug 2024 15:55:46 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F05D300018D;
	Fri,  2 Aug 2024 15:55:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 02/11] mm/pagewalk: introduce folio_walk_start() + folio_walk_end()
Date: Fri,  2 Aug 2024 17:55:15 +0200
Message-ID: <20240802155524.517137-3-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We want to get rid of follow_page(), and have a more reasonable way to
just lookup a folio mapped at a certain address, perform some checks while
still under PTL, and then only conditionally grab a folio reference if
really required.

Further, we might want to get rid of some walk_page_range*() users that
really only want to temporarily lookup a single folio at a single address.

So let's add a new page table walker that does exactly that, similarly
to GUP also being able to walk hugetlb VMAs.

Add folio_walk_end() as a macro for now: the compiler is not easy to
please with the pte_unmap()->kunmap_local().

Note that one difference between follow_page() and get_user_pages(1) is
that follow_page() will not trigger faults to get something mapped. So
folio_walk is at least currently not a replacement for get_user_pages(1),
but could likely be extended/reused to achieve something similar in the
future.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pagewalk.h |  58 +++++++++++
 mm/pagewalk.c            | 202 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27cd1e59ccf7..f5eb5a32aeed 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -130,4 +130,62 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 		      pgoff_t nr, const struct mm_walk_ops *ops,
 		      void *private);
 
+typedef int __bitwise folio_walk_flags_t;
+
+/*
+ * Walk migration entries as well. Careful: a large folio might get split
+ * concurrently.
+ */
+#define FW_MIGRATION			((__force folio_walk_flags_t)BIT(0))
+
+/* Walk shared zeropages (small + huge) as well. */
+#define FW_ZEROPAGE			((__force folio_walk_flags_t)BIT(1))
+
+enum folio_walk_level {
+	FW_LEVEL_PTE,
+	FW_LEVEL_PMD,
+	FW_LEVEL_PUD,
+};
+
+/**
+ * struct folio_walk - folio_walk_start() / folio_walk_end() data
+ * @page:	exact folio page referenced (if applicable)
+ * @level:	page table level identifying the entry type
+ * @pte:	pointer to the page table entry (FW_LEVEL_PTE).
+ * @pmd:	pointer to the page table entry (FW_LEVEL_PMD).
+ * @pud:	pointer to the page table entry (FW_LEVEL_PUD).
+ * @ptl:	pointer to the page table lock.
+ *
+ * (see folio_walk_start() documentation for more details)
+ */
+struct folio_walk {
+	/* public */
+	struct page *page;
+	enum folio_walk_level level;
+	union {
+		pte_t *ptep;
+		pud_t *pudp;
+		pmd_t *pmdp;
+	};
+	union {
+		pte_t pte;
+		pud_t pud;
+		pmd_t pmd;
+	};
+	/* private */
+	struct vm_area_struct *vma;
+	spinlock_t *ptl;
+};
+
+struct folio *folio_walk_start(struct folio_walk *fw,
+		struct vm_area_struct *vma, unsigned long addr,
+		folio_walk_flags_t flags);
+
+#define folio_walk_end(__fw, __vma) do { \
+	spin_unlock((__fw)->ptl); \
+	if (likely((__fw)->level == FW_LEVEL_PTE)) \
+		pte_unmap((__fw)->ptep); \
+	vma_pgtable_walk_end(__vma); \
+} while (0)
+
 #endif /* _LINUX_PAGEWALK_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index ae2f08ce991b..cd79fb3b89e5 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,8 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -654,3 +656,203 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 
 	return err;
 }
+
+/**
+ * folio_walk_start - walk the page tables to a folio
+ * @fw: filled with information on success.
+ * @vma: the VMA.
+ * @addr: the virtual address to use for the page table walk.
+ * @flags: flags modifying which folios to walk to.
+ *
+ * Walk the page tables using @addr in a given @vma to a mapped folio and
+ * return the folio, making sure that the page table entry referenced by
+ * @addr cannot change until folio_walk_end() was called.
+ *
+ * As default, this function returns only folios that are not special (e.g., not
+ * the zeropage) and never returns folios that are supposed to be ignored by the
+ * VM as documented by vm_normal_page(). If requested, zeropages will be
+ * returned as well.
+ *
+ * As default, this function only considers present page table entries.
+ * If requested, it will also consider migration entries.
+ *
+ * If this function returns NULL it might either indicate "there is nothing" or
+ * "there is nothing suitable".
+ *
+ * On success, @fw is filled and the function returns the folio while the PTL
+ * is still held and folio_walk_end() must be called to clean up,
+ * releasing any held locks. The returned folio must *not* be used after the
+ * call to folio_walk_end(), unless a short-term folio reference is taken before
+ * that call.
+ *
+ * @fw->page will correspond to the page that is effectively referenced by
+ * @addr. However, for migration entries and shared zeropages @fw->page is
+ * set to NULL. Note that large folios might be mapped by multiple page table
+ * entries, and this function will always only lookup a single entry as
+ * specified by @addr, which might or might not cover more than a single page of
+ * the returned folio.
+ *
+ * This function must *not* be used as a naive replacement for
+ * get_user_pages() / pin_user_pages(), especially not to perform DMA or
+ * to carelessly modify page content. This function may *only* be used to grab
+ * short-term folio references, never to grab long-term folio references.
+ *
+ * Using the page table entry pointers in @fw for reading or modifying the
+ * entry should be avoided where possible: however, there might be valid
+ * use cases.
+ *
+ * WARNING: Modifying page table entries in hugetlb VMAs requires a lot of care.
+ * For example, PMD page table sharing might require prior unsharing. Also,
+ * logical hugetlb entries might span multiple physical page table entries,
+ * which *must* be modified in a single operation (set_huge_pte_at(),
+ * huge_ptep_set_*, ...). Note that the page table entry stored in @fw might
+ * not correspond to the first physical entry of a logical hugetlb entry.
+ *
+ * The mmap lock must be held in read mode.
+ *
+ * Return: folio pointer on success, otherwise NULL.
+ */
+struct folio *folio_walk_start(struct folio_walk *fw,
+		struct vm_area_struct *vma, unsigned long addr,
+		folio_walk_flags_t flags)
+{
+	unsigned long entry_size;
+	bool expose_page = true;
+	struct page *page;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+	spinlock_t *ptl;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+
+	mmap_assert_locked(vma->vm_mm);
+	vma_pgtable_walk_begin(vma);
+
+	if (WARN_ON_ONCE(addr < vma->vm_start || addr >= vma->vm_end))
+		goto not_found;
+
+	pgdp = pgd_offset(vma->vm_mm, addr);
+	if (pgd_none_or_clear_bad(pgdp))
+		goto not_found;
+
+	p4dp = p4d_offset(pgdp, addr);
+	if (p4d_none_or_clear_bad(p4dp))
+		goto not_found;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = pudp_get(pudp);
+	if (pud_none(pud))
+		goto not_found;
+	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) && pud_leaf(pud)) {
+		ptl = pud_lock(vma->vm_mm, pudp);
+		pud = pudp_get(pudp);
+
+		entry_size = PUD_SIZE;
+		fw->level = FW_LEVEL_PUD;
+		fw->pudp = pudp;
+		fw->pud = pud;
+
+		if (!pud_present(pud) || pud_devmap(pud)) {
+			spin_unlock(ptl);
+			goto not_found;
+		} else if (!pud_leaf(pud)) {
+			spin_unlock(ptl);
+			goto pmd_table;
+		}
+		/*
+		 * TODO: vm_normal_page_pud() will be handy once we want to
+		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
+		 */
+		page = pud_page(pud);
+		goto found;
+	}
+
+pmd_table:
+	VM_WARN_ON_ONCE(pud_leaf(*pudp));
+	pmdp = pmd_offset(pudp, addr);
+	pmd = pmdp_get_lockless(pmdp);
+	if (pmd_none(pmd))
+		goto not_found;
+	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) && pmd_leaf(pmd)) {
+		ptl = pmd_lock(vma->vm_mm, pmdp);
+		pmd = pmdp_get(pmdp);
+
+		entry_size = PMD_SIZE;
+		fw->level = FW_LEVEL_PMD;
+		fw->pmdp = pmdp;
+		fw->pmd = pmd;
+
+		if (pmd_none(pmd)) {
+			spin_unlock(ptl);
+			goto not_found;
+		} else if (!pmd_leaf(pmd)) {
+			spin_unlock(ptl);
+			goto pte_table;
+		} else if (pmd_present(pmd)) {
+			page = vm_normal_page_pmd(vma, addr, pmd);
+			if (page) {
+				goto found;
+			} else if ((flags & FW_ZEROPAGE) &&
+				    is_huge_zero_pmd(pmd)) {
+				page = pfn_to_page(pmd_pfn(pmd));
+				expose_page = false;
+				goto found;
+			}
+		} else if ((flags & FW_MIGRATION) &&
+			   is_pmd_migration_entry(pmd)) {
+			swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+			page = pfn_swap_entry_to_page(entry);
+			expose_page = false;
+			goto found;
+		}
+		spin_unlock(ptl);
+		goto not_found;
+	}
+
+pte_table:
+	VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));
+	ptep = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto not_found;
+	pte = ptep_get(ptep);
+
+	entry_size = PAGE_SIZE;
+	fw->level = FW_LEVEL_PTE;
+	fw->ptep = ptep;
+	fw->pte = pte;
+
+	if (pte_present(pte)) {
+		page = vm_normal_page(vma, addr, pte);
+		if (page)
+			goto found;
+		if ((flags & FW_ZEROPAGE) &&
+		    is_zero_pfn(pte_pfn(pte))) {
+			page = pfn_to_page(pte_pfn(pte));
+			expose_page = false;
+			goto found;
+		}
+	} else if (!pte_none(pte)) {
+		swp_entry_t entry = pte_to_swp_entry(pte);
+
+		if ((flags & FW_MIGRATION) &&
+		    is_migration_entry(entry)) {
+			page = pfn_swap_entry_to_page(entry);
+			expose_page = false;
+			goto found;
+		}
+	}
+	pte_unmap_unlock(ptep, ptl);
+not_found:
+	vma_pgtable_walk_end(vma);
+	return NULL;
+found:
+	if (expose_page)
+		/* Note: Offset from the mapped page, not the folio start. */
+		fw->page = nth_page(page, (addr & (entry_size - 1)) >> PAGE_SHIFT);
+	else
+		fw->page = NULL;
+	fw->ptl = ptl;
+	return page_folio(page);
+}
-- 
2.45.2


