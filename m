Return-Path: <linux-fsdevel+bounces-27909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE6964C58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B232809D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11D1B8E93;
	Thu, 29 Aug 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MA94pUop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F71B5EBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950692; cv=none; b=j360Prq9Tuty8VH3oD0pSuPkvgVtpTVeYPpCTH4o+fL8JVqnrzs11T6yDRIaxtNIrMaCPDBcXLbo/eIixrA9CXLuFrNFYm5YKbTYrpbVU86CZkGrHoBBIsT7yihprEUTwbhRqwc3YsezGfGuKwn8R2NIZlilEWDS1GQQ1aEcpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950692; c=relaxed/simple;
	bh=h3qLuDXwVIZz3/rCeEo8yr9v7u0QsQGiXf+MrwgchWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC2EQXiD+kizFNxLSVfn0yHPPcz9SK/LQlKABenSA1dL23yRw8fIXt7wOrDbnKICLmIwLxreOhHOsZeG2k5WwpmWTJcgrjmiTdfKTzBZ2rtM3sO31vqeVVB9eAZME4DJGgMTknjhBIR8nDcJsBEHXYxsBGQhcVGWaCnsu9zgLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MA94pUop; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJ36TGls6X+NLaUI9I8k1fO0354o+pno0obx3qgSgO4=;
	b=MA94pUopSeod8x7/mua90Ziaw/8PFOBBXXCkpsyMQvBN2Ay8QbFzkzP0rpD2haghVuY+oa
	wL8+PaWLB24Ihya4x3nAant6y6Ed812rWsplUPt9QDgqWd2K9UT7ZWSp0nG9OWfw2wl8Jr
	kdPExGj1olDSSfbbxa+ltpMTOY4hL4M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-MTIkZoMGPJK2qRqMLQImJQ-1; Thu,
 29 Aug 2024 12:58:06 -0400
X-MC-Unique: MTIkZoMGPJK2qRqMLQImJQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B18C7190ECCE;
	Thu, 29 Aug 2024 16:58:03 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45D921955F66;
	Thu, 29 Aug 2024 16:57:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 08/17] mm/rmap: initial MM owner tracking for large folios (!hugetlb)
Date: Thu, 29 Aug 2024 18:56:11 +0200
Message-ID: <20240829165627.2256514-9-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's track for each large folio (excluding hugetlb for now) whether it is
certainly mapped exclusively (mapped by a single MM), or whether it may be
mapped shared (mapped by multiple MMs).

In an ideal world, we'd have a more precise "mapped exclusively" vs.
"mapped shared" tracking -- avoiding the "maybe" part -- but the
approaches to achieve that are a bit more involve, and we are going to
start with something simple so we can also make progress on per-page
mapcount removal. We can later easily exchange the tracking mechanism.

We'll use this information next to optimize COW reuse for PTE-mapped
anonymous THP, and implement folio_likely_mapped_shared() in kernel
configuration where the per-page mapcounts in large folios are no longer
maintained. We could start doing the MM owner tracking for anonymous
folios initially (COW reuse only applies to anon folios), but we'll keep
it simple and just do it also for pagecache folios: the new tracking
must be manually enabled via a kconfig option for now.

64bit only, because we cannot easily squeeze more stuff into the "struct
folio" of order-1 folios. 32bit might be possible in the future, for
example when limiting order-1 folios to 64bit only.

We'll remember for each large folio for two MMs that currently map this
folio, how often they are mapping folio pages (mapcount). As long as
a folio is unmapped or exclusively mapped, another MM can take a free
spot. We won't allow to take a free spot if the folio is not mapped
exclusively: primarily to avoid some corner cases where some mappings of
a MM are tracked via the slot, and others not (identified while working
on this).

In addition, we'll remember the current state (exclusive/shared) and use a
bit spinlock to sync on updates, and to require only a single atomic
operation for our updates. Using a bit spinlock is not ideal, but there
are not that many easy alternatives. We might be able to squeeze an
arch_spin_lock into the "struct folio" later, for now keep it simple. RT is
out of the picture with THP, and we can always optimize this later.

As we have to squeeze this information into the "struct folio" of even
folios of order-1 (2 pages), and we generally want to reduce the required
metadata, we'll assign each MM a unique ID that consumes less than 32 bit.
We'll limit the IDs to 20bit / 1M for now: we could allow for up to 30bit,
but getting even 1M IDs is unlikely in practice. If required, we could
raise the limit later, and the 1M limit might come in handy in the
future with other tracking approaches.

There won't be any false "mapped shared" detection as long as only two MMs
map pages of a folio at one point in time -- for example with fork() and
short-lived child processes, or with apps that hand over state from one
instance to another, like live-migrating VMs on the same host, effectively
migrating guest RAM via a mmap'ed files.

As soon as three MMs are involved at the same time, we might detect
"mapped shared" although the folio is now "mapped exclusively". Example:
(1) App1 faults in a (shmem/file-backed) folio -> Tracked as MM0
(2) App2 faults in the same folio -> Tracked as MM1
(3) App3 faults in the same folio -> Cannot be tracked separately
(4) App1 and App2 unmap the folio.
(5) We'll still detect "shared" even though only App3 maps the folio.

With multiple processes, this might have the potential to result in
unexpected owner changes, when migrating pages or when faulting them in:
assume a parent process fork()'s two short-lived child processes. We would
expect that the parent always remains tracked under MM0, but it could be
that at some point both child processes are tracked instead. For
file-backed memory, reclaim+refault can trigger something similar.

Keep compilation for the vdso32 hack working by un-defining CONFIG_MM_ID
like we for CONFIG_64BIT.

Make use of __always_inline to keep possible performance degradation
when (un)mapping large folios to a minimum.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst                |   8 ++
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   1 +
 include/linux/mm_types.h                      |  23 ++++
 include/linux/page-flags.h                    |  41 ++++++
 include/linux/rmap.h                          | 126 ++++++++++++++++++
 kernel/fork.c                                 |  36 +++++
 mm/Kconfig                                    |  11 ++
 mm/huge_memory.c                              |   6 +
 mm/internal.h                                 |   6 +
 mm/page_alloc.c                               |  10 ++
 10 files changed, 268 insertions(+)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index a2cd8800d5279..0ee58108a4d14 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -120,11 +120,19 @@ pages:
     and also increment/decrement folio->_nr_pages_mapped by ENTIRELY_MAPPED
     when _entire_mapcount goes from -1 to 0 or 0 to -1.
 
+    With CONFIG_MM_ID, we also maintain the two slots for tracking MM
+    owners (MM ID and corresponding mapcount), and the current status
+    ("mapped shared" vs. "mapped exclusively").
+
   - map/unmap of individual pages with PTE entry increment/decrement
     page->_mapcount, increment/decrement folio->_large_mapcount and also
     increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
     from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
 
+    With CONFIG_MM_ID, we also maintain the two slots for tracking MM
+    owners (MM ID and corresponding mapcount), and the current status
+    ("mapped shared" vs. "mapped exclusively").
+
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
 structures. It can be done easily for refcounts taken by page table
diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
index db1b15f686e32..93d2bf13a6280 100644
--- a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
+++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
@@ -13,6 +13,7 @@
 #undef CONFIG_SPARSEMEM_VMEMMAP
 #undef CONFIG_NR_CPUS
 #undef CONFIG_PARAVIRT_XXL
+#undef CONFIG_MM_ID
 
 #define CONFIG_X86_32 1
 #define CONFIG_PGTABLE_LEVELS 2
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 480548552ea54..6d27856686439 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -311,6 +311,9 @@ typedef struct {
  * @_nr_pages_mapped: Do not use outside of rmap and debug code.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_mm0_mapcount: Do not use outside of rmap code.
+ * @_mm1_mapcount: Do not use outside of rmap code.
+ * @_mm_ids: Do not use outside of rmap code.
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
@@ -377,6 +380,11 @@ struct folio {
 					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
 					atomic_t _pincount;
+#ifdef CONFIG_MM_ID
+					int _mm0_mapcount;
+					int _mm1_mapcount;
+					unsigned long _mm_ids;
+#endif /* CONFIG_MM_ID */
 				};
 				unsigned long _usable_1[4];
 			};
@@ -1044,6 +1052,9 @@ struct mm_struct {
 #endif
 		} lru_gen;
 #endif /* CONFIG_LRU_GEN_WALKS_MMU */
+#ifdef CONFIG_MM_ID
+		unsigned int mm_id;
+#endif
 	} __randomize_layout;
 
 	/*
@@ -1053,6 +1064,18 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
 
+#ifdef CONFIG_MM_ID
+/*
+ * For init_mm and friends, we don't allocate an ID and use the dummy value
+ * instead. Limit ourselves to 1M MMs for now: even though we might support
+ * up to 4M PIDs, having more than 1M MM instances is highly unlikely.
+ */
+#define MM_ID_DUMMY		0
+#define MM_ID_NR_BITS		20
+#define MM_ID_MIN		(MM_ID_DUMMY + 1)
+#define MM_ID_MAX		((1U << MM_ID_NR_BITS) - 1)
+#endif /* CONFIG_MM_ID */
+
 #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
 			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2175ebceb41cb..140de182811f2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -11,6 +11,7 @@
 #include <linux/mmdebug.h>
 #ifndef __GENERATING_BOUNDS_H
 #include <linux/mm_types.h>
+#include <linux/bit_spinlock.h>
 #include <generated/bounds.h>
 #endif /* !__GENERATING_BOUNDS_H */
 
@@ -1187,6 +1188,46 @@ static inline int folio_has_private(const struct folio *folio)
 	return !!(folio->flags & PAGE_FLAGS_PRIVATE);
 }
 
+#ifdef CONFIG_MM_ID
+/*
+ * We store two flags (including the bit spinlock) in the upper bits of
+ * folio->_mm_ids, whereby that whole value is protected by the bit spinlock.
+ * This allows for only using an atomic op for acquiring the lock.
+ */
+#define FOLIO_MM_IDS_EXCLUSIVE_BITNUM		62
+#define FOLIO_MM_IDS_LOCK_BITNUM		63
+
+static __always_inline void folio_lock_large_mapcount_data(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	bit_spin_lock(FOLIO_MM_IDS_LOCK_BITNUM, &folio->_mm_ids);
+}
+
+static __always_inline void folio_unlock_large_mapcount_data(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	__bit_spin_unlock(FOLIO_MM_IDS_LOCK_BITNUM, &folio->_mm_ids);
+}
+
+static inline void folio_set_large_mapped_exclusively(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	__set_bit(FOLIO_MM_IDS_EXCLUSIVE_BITNUM, &folio->_mm_ids);
+}
+
+static inline void folio_clear_large_mapped_exclusively(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	__clear_bit(FOLIO_MM_IDS_EXCLUSIVE_BITNUM, &folio->_mm_ids);
+}
+
+static inline bool folio_test_large_mapped_exclusively(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	return test_bit(FOLIO_MM_IDS_EXCLUSIVE_BITNUM, &folio->_mm_ids);
+}
+#endif /* CONFIG_MM_ID */
+
 #undef PF_ANY
 #undef PF_HEAD
 #undef PF_NO_TAIL
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e3b82a04b4acb..ff2a16864deed 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -173,6 +173,131 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(struct folio *folio);
 
+#ifdef CONFIG_MM_ID
+
+/*
+ * We don't restrict ID0 to less bit, so we can get a slightly more efficient
+ * implementation when reading/writing ID0. The high bits are used for flags,
+ * see FOLIO_MM_IDS_*_BITNUM.
+ */
+#define FOLIO_MM_IDS_ID0_MASK			0x00000000fffffffful
+#define FOLIO_MM_IDS_ID1_SHIFT			32
+#define FOLIO_MM_IDS_ID1_MASK			0x00ffffff00000000ul
+
+static inline unsigned int folio_mm0_id(struct folio *folio)
+{
+	return folio->_mm_ids & FOLIO_MM_IDS_ID0_MASK;
+}
+
+static inline void folio_set_mm0_id(struct folio *folio, unsigned int id)
+{
+	folio->_mm_ids &= ~FOLIO_MM_IDS_ID0_MASK;
+	folio->_mm_ids |= id;
+}
+
+static inline unsigned int folio_mm1_id(struct folio *folio)
+{
+	return (folio->_mm_ids & FOLIO_MM_IDS_ID1_MASK) >> FOLIO_MM_IDS_ID1_SHIFT;
+}
+
+static inline void folio_set_mm1_id(struct folio *folio, unsigned int id)
+{
+	folio->_mm_ids &= ~FOLIO_MM_IDS_ID1_MASK;
+	folio->_mm_ids |= (unsigned long)id << FOLIO_MM_IDS_ID1_SHIFT;
+}
+
+static __always_inline void folio_set_large_mapcount(struct folio *folio,
+		int mapcount, struct vm_area_struct *vma)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+
+	/* Note: mapcounts start at -1. */
+	atomic_set(&folio->_large_mapcount, mapcount - 1);
+	folio->_mm0_mapcount = mapcount - 1;
+	folio_set_mm0_id(folio, vma->vm_mm->mm_id);
+	VM_WARN_ON_ONCE(!folio_test_large_mapped_exclusively(folio));
+	VM_WARN_ON_ONCE(folio->_mm1_mapcount >= 0);
+}
+
+static __always_inline void folio_add_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	const unsigned int mm_id = vma->vm_mm->mm_id;
+	int mapcount_val;
+
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	VM_WARN_ON_ONCE(diff <= 0 || mm_id < MM_ID_MIN || mm_id > MM_ID_MAX);
+
+	folio_lock_large_mapcount_data(folio);
+	/*
+	 * We expect that unmapped folios always have the "mapped exclusively"
+	 * flag set for simplicity.
+	 */
+	VM_WARN_ON_ONCE(atomic_read(&folio->_large_mapcount) < 0 &&
+			!folio_test_large_mapped_exclusively(folio));
+
+	mapcount_val = atomic_read(&folio->_large_mapcount) + diff;
+	atomic_set(&folio->_large_mapcount, mapcount_val);
+
+	if (folio_mm0_id(folio) == mm_id) {
+		folio->_mm0_mapcount += diff;
+		if (folio->_mm0_mapcount != mapcount_val)
+			folio_clear_large_mapped_exclusively(folio);
+	} else if (folio_mm1_id(folio) == mm_id) {
+		folio->_mm1_mapcount += diff;
+		if (folio->_mm1_mapcount != mapcount_val)
+			folio_clear_large_mapped_exclusively(folio);
+	} else if (folio_test_large_mapped_exclusively(folio)) {
+		/*
+		 * We only allow taking over a tracking slot if the folio is
+		 * exclusive, meaning that any mappings belong to exactly one
+		 * tracked MM (which cannot be this MM).
+		 */
+		if (folio->_mm0_mapcount < 0) {
+			folio_set_mm0_id(folio, mm_id);
+			folio->_mm0_mapcount = diff - 1;
+		} else {
+			VM_WARN_ON_ONCE(folio->_mm1_mapcount >= 0);
+			folio_set_mm1_id(folio, mm_id);
+			folio->_mm1_mapcount = diff - 1;
+		}
+		folio_clear_large_mapped_exclusively(folio);
+	}
+	folio_unlock_large_mapcount_data(folio);
+}
+#define folio_inc_large_mapcount(folio, vma) \
+	folio_add_large_mapcount(folio, 1, vma)
+
+static __always_inline void folio_sub_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	const unsigned int mm_id = vma->vm_mm->mm_id;
+	int mapcount_val;
+
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	VM_WARN_ON_ONCE(diff <= 0 || mm_id < MM_ID_MIN || mm_id > MM_ID_MAX);
+
+	folio_lock_large_mapcount_data(folio);
+	mapcount_val = atomic_read(&folio->_large_mapcount) - diff;
+	atomic_set(&folio->_large_mapcount, mapcount_val);
+
+	if (folio_mm0_id(folio) == mm_id)
+		folio->_mm0_mapcount -= diff;
+	else if (folio_mm1_id(folio) == mm_id)
+		folio->_mm1_mapcount -= diff;
+
+	/*
+	 * We only consider folios exclusive if there are no mappings or if
+	 * one tracked MM owns all mappings.
+	 */
+	if (folio->_mm0_mapcount == mapcount_val ||
+	    folio->_mm1_mapcount == mapcount_val)
+		folio_set_large_mapped_exclusively(folio);
+	folio_unlock_large_mapcount_data(folio);
+}
+#define folio_dec_large_mapcount(folio, vma) \
+	folio_sub_large_mapcount(folio, 1, vma)
+#else /* !CONFIG_MM_ID */
 static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
 		struct vm_area_struct *vma)
 {
@@ -203,6 +328,7 @@ static inline void folio_dec_large_mapcount(struct folio *folio,
 {
 	atomic_dec(&folio->_large_mapcount);
 }
+#endif /* !CONFIG_MM_ID */
 
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
diff --git a/kernel/fork.c b/kernel/fork.c
index ebc9132840872..7b9df4c881387 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -813,6 +813,36 @@ static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
 
+#ifdef CONFIG_MM_ID
+static DEFINE_IDA(mm_ida);
+
+static inline int mm_alloc_id(struct mm_struct *mm)
+{
+	int ret;
+
+	ret = ida_alloc_range(&mm_ida, MM_ID_MIN, MM_ID_MAX, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	mm->mm_id = ret;
+	return 0;
+}
+
+static inline void mm_free_id(struct mm_struct *mm)
+{
+	const int id = mm->mm_id;
+
+	mm->mm_id = MM_ID_DUMMY;
+	if (id == MM_ID_DUMMY)
+		return;
+	if (WARN_ON_ONCE(id < MM_ID_MIN || id > MM_ID_MAX))
+		return;
+	ida_free(&mm_ida, id);
+}
+#else
+static inline int mm_alloc_id(struct mm_struct *mm) { return 0; }
+static inline void mm_free_id(struct mm_struct *mm) {}
+#endif
+
 static void check_mm(struct mm_struct *mm)
 {
 	int i;
@@ -916,6 +946,7 @@ void __mmdrop(struct mm_struct *mm)
 
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
+	mm_free_id(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
@@ -1293,6 +1324,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
+	if (mm_alloc_id(mm))
+		goto fail_noid;
+
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
@@ -1312,6 +1346,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 fail_cid:
 	destroy_context(mm);
 fail_nocontext:
+	mm_free_id(mm);
+fail_noid:
 	mm_free_pgd(mm);
 fail_nopgd:
 	free_mm(mm);
diff --git a/mm/Kconfig b/mm/Kconfig
index b23913d4e47e2..0877be8c50b6c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -846,6 +846,17 @@ choice
 	  enabled at runtime via sysfs.
 endchoice
 
+config MM_ID
+	bool "MM ID tracking"
+	depends on TRANSPARENT_HUGEPAGE && 64BIT
+	help
+	  Use unique per-MM IDs to track whether large allocations, such
+	  as transparent huge pages, that span multiple physical pages
+	  are "mapped shared" or "mapped exclusively" into user page tables.
+	  This information is useful to determine the current owner of such a
+	  large allocation, for example, helpful for the Copy-On-Write reuse
+	  optimization.
+
 config THP_SWAP
 	def_bool y
 	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP && 64BIT
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6de84377e8e77..7fa84ba506563 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3193,6 +3193,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	ClearPageHasHWPoisoned(head);
 
+#ifdef CONFIG_MM_ID
+	if (!new_order)
+		/* Make sure page->private on the second page is 0. */
+		folio->_mm_ids = 0;
+#endif
+
 	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
 		__split_huge_page_tail(folio, i, lruvec, list, new_order);
 		/* Some pages can be beyond EOF: drop them from page cache */
diff --git a/mm/internal.h b/mm/internal.h
index f627fd2200464..da38c747c73d4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -665,6 +665,12 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
+#ifdef CONFIG_MM_ID
+	folio->_mm0_mapcount = -1;
+	folio->_mm1_mapcount = -1;
+	folio->_mm_ids = 0;
+	folio_set_large_mapped_exclusively(folio);
+#endif
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e276cbaf97054..c81f29e29b82d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -959,6 +959,16 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero pincount");
 			goto out;
 		}
+#ifdef CONFIG_MM_ID
+		if (unlikely(folio->_mm0_mapcount + 1)) {
+			bad_page(page, "nonzero _mm0_mapcount");
+			goto out;
+		}
+		if (unlikely(folio->_mm1_mapcount + 1)) {
+			bad_page(page, "nonzero _mm1_mapcount");
+			goto out;
+		}
+#endif
 		break;
 	case 2:
 		/* the second tail page: deferred_list overlaps ->mapping */
-- 
2.46.0


