Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C30158689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBKAPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:15:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18858 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgBKAPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:15:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41f20f0001>; Mon, 10 Feb 2020 16:15:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 16:15:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 16:15:38 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 00:15:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Feb 2020 00:15:38 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41f22a0002>; Mon, 10 Feb 2020 16:15:38 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Date:   Mon, 10 Feb 2020 16:15:30 -0800
Message-ID: <20200211001536.1027652-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211001536.1027652-1-jhubbard@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581380111; bh=aFQ6fQkYEExJvkL+dNFe7/80vge/hald0cxFWFPb8Rw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=MrS7guAGmLHiuV5uG1pD1QGUJK59x0mHoiGuaXusfByGfyU4APrkDmuW18a+pxbzG
         ZzJ9W5k/PUxPQviW3eCBvpgDW0h63L1UkdodxVWP1RaE2+HSGtEZ3cH/eR8PI84+fs
         IDSozmLc7WtV9/q2IuRZvLmPg1xLg7x14uS6Cy+GaZE3glCLNja2zq/dhzo9wp/tN8
         qELk0jkrHeevDHjZnNiIU+HWIzKBMLn1m21byl9oEeJ7SNO4ItLtST0LNkwqKqJqo0
         pSZ3VeKiY28uyXNqTyzn0HKaQoZ/rcElOxlaSJw7VGqxNlY8tdjL0iYEHFqRRRUU60
         j72KE55rBPi+A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tracking of pages that were pinned via FOLL_PIN. This tracking is
implemented via overloading of page->_refcount: pins are added by
adding GUP_PIN_COUNTING_BIAS (1024) to the refcount. This provides a
fuzzy indication of pinning, and it can have false positives (and that's
OK). Please see the pre-existing
Documentation/core-api/pin_user_pages.rst for details.

As mentioned in pin_user_pages.rst, callers who effectively set FOLL_PIN
(typically via pin_user_pages*()) are required to ultimately free such
pages via unpin_user_page().

Please also note the limitation, discussed in pin_user_pages.rst under
the "TODO: for 1GB and larger huge pages" section. (That limitation will
be removed in a following patch.)

The effect of a FOLL_PIN flag is similar to that of FOLL_GET, and may be
thought of as "FOLL_GET for DIO and/or RDMA use".

Pages that have been pinned via FOLL_PIN are identifiable via a
new function call:

   bool page_maybe_dma_pinned(struct page *page);

What to do in response to encountering such a page, is left to later
patchsets. There is discussion about this in [1], [2], [3], and [4].

This also changes a BUG_ON(), to a WARN_ON(), in follow_page_mask().

[1] Some slow progress on get_user_pages() (Apr 2, 2019):
    https://lwn.net/Articles/784574/
[2] DMA and get_user_pages() (LPC: Dec 12, 2018):
    https://lwn.net/Articles/774411/
[3] The trouble with get_user_pages() (Apr 30, 2018):
    https://lwn.net/Articles/753027/
[4] LWN kernel index: get_user_pages():
    https://lwn.net/Kernel/Index/#Memory_management-get_user_pages

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst |   6 +-
 include/linux/mm.h                        |  82 +++++--
 mm/gup.c                                  | 254 +++++++++++++++++-----
 mm/huge_memory.c                          |  29 ++-
 mm/hugetlb.c                              |  54 +++--
 5 files changed, 334 insertions(+), 91 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 1d490155ecd7..9829345428f8 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -173,8 +173,8 @@ CASE 4: Pinning for struct page manipulation only
 -------------------------------------------------
 Here, normal GUP calls are sufficient, so neither flag needs to be set.
=20
-page_dma_pinned(): the whole point of pinning
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+page_maybe_dma_pinned(): the whole point of pinning
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
 The whole point of marking pages as "DMA-pinned" or "gup-pinned" is to be =
able
 to query, "is this page DMA-pinned?" That allows code such as page_mkclean=
()
@@ -186,7 +186,7 @@ and debates (see the References at the end of this docu=
ment). It's a TODO item
 here: fill in the details once that's worked out. Meanwhile, it's safe to =
say
 that having this available: ::
=20
-        static inline bool page_dma_pinned(struct page *page)
+        static inline bool page_maybe_dma_pinned(struct page *page)
=20
 ...is a prerequisite to solving the long-running gup+DMA problem.
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..8d4f9f4094f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1001,6 +1001,8 @@ static inline void get_page(struct page *page)
 	page_ref_inc(page);
 }
=20
+bool __must_check try_grab_page(struct page *page, unsigned int flags);
+
 static inline __must_check bool try_get_page(struct page *page)
 {
 	page =3D compound_head(page);
@@ -1029,29 +1031,79 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
=20
-/**
- * unpin_user_page() - release a gup-pinned page
- * @page:            pointer to page to be released
+/*
+ * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overlo=
ad
+ * the page's refcount so that two separate items are tracked: the origina=
l page
+ * reference count, and also a new count of how many pin_user_pages() call=
s were
+ * made against the page. ("gup-pinned" is another term for the latter).
+ *
+ * With this scheme, pin_user_pages() becomes special: such pages are mark=
ed as
+ * distinct from normal pages. As such, the unpin_user_page() call (and it=
s
+ * variants) must be used in order to release gup-pinned pages.
+ *
+ * Choice of value:
+ *
+ * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page refer=
ence
+ * counts with respect to pin_user_pages() and unpin_user_page() becomes
+ * simpler, due to the fact that adding an even power of two to the page
+ * refcount has the effect of using only the upper N bits, for the code th=
at
+ * counts up using the bias value. This means that the lower bits are left=
 for
+ * the exclusive use of the original code that increments and decrements b=
y one
+ * (or at least, by much smaller values than the bias value).
  *
- * Pages that were pinned via pin_user_pages*() must be released via eithe=
r
- * unpin_user_page(), or one of the unpin_user_pages*() routines. This is =
so
- * that eventually such pages can be separately tracked and uniquely handl=
ed. In
- * particular, interactions with RDMA and filesystems need special handlin=
g.
+ * Of course, once the lower bits overflow into the upper bits (and this i=
s
+ * OK, because subtraction recovers the original values), then visual insp=
ection
+ * no longer suffices to directly view the separate counts. However, for n=
ormal
+ * applications that don't have huge page reference counts, this won't be =
an
+ * issue.
  *
- * unpin_user_page() and put_page() are not interchangeable, despite this =
early
- * implementation that makes them look the same. unpin_user_page() calls m=
ust
- * be perfectly matched up with pin*() calls.
+ * Locking: the lockless algorithm described in page_cache_get_speculative=
()
+ * and page_cache_gup_pin_speculative() provides safe operation for
+ * get_user_pages and page_mkclean and other calls that race to set up pag=
e
+ * table entries.
  */
-static inline void unpin_user_page(struct page *page)
-{
-	put_page(page);
-}
+#define GUP_PIN_COUNTING_BIAS (1U << 10)
=20
+void unpin_user_page(struct page *page);
 void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages=
,
 				 bool make_dirty);
-
 void unpin_user_pages(struct page **pages, unsigned long npages);
=20
+/**
+ * page_maybe_dma_pinned() - report if a page is pinned for DMA.
+ *
+ * This function checks if a page has been pinned via a call to
+ * pin_user_pages*().
+ *
+ * For non-huge pages, the return value is partially fuzzy: false is not f=
uzzy,
+ * because it means "definitely not pinned for DMA", but true means "proba=
bly
+ * pinned for DMA, but possibly a false positive due to having at least
+ * GUP_PIN_COUNTING_BIAS worth of normal page references".
+ *
+ * False positives are OK, because: a) it's unlikely for a page to get tha=
t many
+ * refcounts, and b) all the callers of this routine are expected to be ab=
le to
+ * deal gracefully with a false positive.
+ *
+ * For more information, please see Documentation/vm/pin_user_pages.rst.
+ *
+ * @page:	pointer to page to be queried.
+ * @Return:	True, if it is likely that the page has been "dma-pinned".
+ *		False, if the page is definitely not dma-pinned.
+ */
+static inline bool page_maybe_dma_pinned(struct page *page)
+{
+	/*
+	 * page_ref_count() is signed. If that refcount overflows, then
+	 * page_ref_count() returns a negative value, and callers will avoid
+	 * further incrementing the refcount.
+	 *
+	 * Here, for that overflow case, use the signed bit to count a little
+	 * bit higher via unsigned math, and thus still get an accurate result.
+	 */
+	return ((unsigned int)page_ref_count(compound_head(page))) >=3D
+		GUP_PIN_COUNTING_BIAS;
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
diff --git a/mm/gup.c b/mm/gup.c
index c8affbea2019..a2356482e1ea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -44,6 +44,135 @@ static inline struct page *try_get_compound_head(struct=
 page *page, int refs)
 	return head;
 }
=20
+/*
+ * try_grab_compound_head() - attempt to elevate a page's refcount, by a
+ * flags-dependent amount.
+ *
+ * "grab" names in this file mean, "look at flags to decide whether to use
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
+ *
+ * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at t=
he
+ * same time. (That's true throughout the get_user_pages*() and
+ * pin_user_pages*() APIs.) Cases:
+ *
+ *    FOLL_GET: page's refcount will be incremented by 1.
+ *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BI=
AS.
+ *
+ * Return: head page (with refcount appropriately incremented) for success=
, or
+ * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
+ * considered failure, and furthermore, a likely bug in the caller, so a w=
arning
+ * is also emitted.
+ */
+static __maybe_unused struct page *try_grab_compound_head(struct page *pag=
e,
+							  int refs,
+							  unsigned int flags)
+{
+	if (flags & FOLL_GET)
+		return try_get_compound_head(page, refs);
+	else if (flags & FOLL_PIN) {
+		refs *=3D GUP_PIN_COUNTING_BIAS;
+		return try_get_compound_head(page, refs);
+	}
+
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+/**
+ * try_grab_page() - elevate a page's refcount by a flag-dependent amount
+ *
+ * This might not do anything at all, depending on the flags argument.
+ *
+ * "grab" names in this file mean, "look at flags to decide whether to use
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
+ *
+ * @page:    pointer to page to be grabbed
+ * @flags:   gup flags: these are the FOLL_* flag values.
+ *
+ * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at th=
e same
+ * time. Cases:
+ *
+ *    FOLL_GET: page's refcount will be incremented by 1.
+ *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BI=
AS.
+ *
+ * Return: true for success, or if no action was required (if neither FOLL=
_PIN
+ * nor FOLL_GET was set, nothing is done). False for failure: FOLL_GET or
+ * FOLL_PIN was set, but the page could not be grabbed.
+ */
+bool __must_check try_grab_page(struct page *page, unsigned int flags)
+{
+	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) =3D=3D (FOLL_GET | FOLL_PIN)=
);
+
+	if (flags & FOLL_GET)
+		return try_get_page(page);
+	else if (flags & FOLL_PIN) {
+		page =3D compound_head(page);
+
+		if (WARN_ON_ONCE(page_ref_count(page) <=3D 0))
+			return false;
+
+		page_ref_add(page, GUP_PIN_COUNTING_BIAS);
+	}
+
+	return true;
+}
+
+#ifdef CONFIG_DEV_PAGEMAP_OPS
+static bool __unpin_devmap_managed_user_page(struct page *page)
+{
+	int count;
+
+	if (!page_is_devmap_managed(page))
+		return false;
+
+	count =3D page_ref_sub_return(page, GUP_PIN_COUNTING_BIAS);
+
+	/*
+	 * devmap page refcounts are 1-based, rather than 0-based: if
+	 * refcount is 1, then the page is free and the refcount is
+	 * stable because nobody holds a reference on the page.
+	 */
+	if (count =3D=3D 1)
+		free_devmap_managed_page(page);
+	else if (!count)
+		__put_page(page);
+
+	return true;
+}
+#else
+static bool __unpin_devmap_managed_user_page(struct page *page)
+{
+	return false;
+}
+#endif /* CONFIG_DEV_PAGEMAP_OPS */
+
+/**
+ * unpin_user_page() - release a dma-pinned page
+ * @page:            pointer to page to be released
+ *
+ * Pages that were pinned via pin_user_pages*() must be released via eithe=
r
+ * unpin_user_page(), or one of the unpin_user_pages*() routines. This is =
so
+ * that such pages can be separately tracked and uniquely handled. In
+ * particular, interactions with RDMA and filesystems need special handlin=
g.
+ */
+void unpin_user_page(struct page *page)
+{
+	page =3D compound_head(page);
+
+	/*
+	 * For devmap managed pages we need to catch refcount transition from
+	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
+	 * page is free and we need to inform the device driver through
+	 * callback. See include/linux/memremap.h and HMM for details.
+	 */
+	if (__unpin_devmap_managed_user_page(page))
+		return;
+
+	if (page_ref_sub_and_test(page, GUP_PIN_COUNTING_BIAS))
+		__put_page(page);
+}
+EXPORT_SYMBOL(unpin_user_page);
+
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned=
 pages
  * @pages:  array of pages to be maybe marked dirty, and definitely releas=
ed.
@@ -230,10 +359,11 @@ static struct page *follow_page_pte(struct vm_area_st=
ruct *vma,
 	}
=20
 	page =3D vm_normal_page(vma, address, pte);
-	if (!page && pte_devmap(pte) && (flags & FOLL_GET)) {
+	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
 		/*
-		 * Only return device mapping pages in the FOLL_GET case since
-		 * they are only valid while holding the pgmap reference.
+		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
+		 * case since they are only valid while holding the pgmap
+		 * reference.
 		 */
 		*pgmap =3D get_dev_pagemap(pte_pfn(pte), *pgmap);
 		if (*pgmap)
@@ -271,11 +401,10 @@ static struct page *follow_page_pte(struct vm_area_st=
ruct *vma,
 		goto retry;
 	}
=20
-	if (flags & FOLL_GET) {
-		if (unlikely(!try_get_page(page))) {
-			page =3D ERR_PTR(-ENOMEM);
-			goto out;
-		}
+	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
+	if (unlikely(!try_grab_page(page, flags))) {
+		page =3D ERR_PTR(-ENOMEM);
+		goto out;
 	}
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) &&
@@ -537,7 +666,7 @@ static struct page *follow_page_mask(struct vm_area_str=
uct *vma,
 	/* make this handle hugepd */
 	page =3D follow_huge_addr(mm, address, flags & FOLL_WRITE);
 	if (!IS_ERR(page)) {
-		BUG_ON(flags & FOLL_GET);
+		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
 		return page;
 	}
=20
@@ -1675,6 +1804,15 @@ long get_user_pages_remote(struct task_struct *tsk, =
struct mm_struct *mm,
 {
 	return 0;
 }
+
+static long __get_user_pages_remote(struct task_struct *tsk,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long nr_pages,
+				    unsigned int gup_flags, struct page **pages,
+				    struct vm_area_struct **vmas, int *locked)
+{
+	return 0;
+}
 #endif /* !CONFIG_MMU */
=20
 /*
@@ -1877,7 +2015,10 @@ static void __maybe_unused undo_dev_pagemap(int *nr,=
 int nr_start,
 		struct page *page =3D pages[--(*nr)];
=20
 		ClearPageReferenced(page);
-		put_page(page);
+		if (flags & FOLL_PIN)
+			unpin_user_page(page);
+		else
+			put_page(page);
 	}
 }
=20
@@ -1919,7 +2060,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long add=
r, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page =3D pte_page(pte);
=20
-		head =3D try_get_compound_head(page, 1);
+		head =3D try_grab_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
=20
@@ -1980,7 +2121,10 @@ static int __gup_device_huge(unsigned long pfn, unsi=
gned long addr,
 		}
 		SetPageReferenced(page);
 		pages[*nr] =3D page;
-		get_page(page);
+		if (unlikely(!try_grab_page(page, flags))) {
+			undo_dev_pagemap(nr, nr_start, flags, pages);
+			return 0;
+		}
 		(*nr)++;
 		pfn++;
 	} while (addr +=3D PAGE_SIZE, addr !=3D end);
@@ -2056,6 +2200,9 @@ static int record_subpages(struct page *page, unsigne=
d long addr,
=20
 static void put_compound_head(struct page *page, int refs, unsigned int fl=
ags)
 {
+	if (flags & FOLL_PIN)
+		refs *=3D GUP_PIN_COUNTING_BIAS;
+
 	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
 	/*
 	 * Calling put_page() for each ref is unnecessarily slow. Only the last
@@ -2099,7 +2246,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz,=
 unsigned long addr,
 	page =3D head + ((addr & (sz-1)) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(head, refs);
+	head =3D try_grab_compound_head(head, refs, flags);
 	if (!head)
 		return 0;
=20
@@ -2159,7 +2306,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsi=
gned long addr,
 	page =3D pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(pmd_page(orig), refs);
+	head =3D try_grab_compound_head(pmd_page(orig), refs, flags);
 	if (!head)
 		return 0;
=20
@@ -2193,7 +2340,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsi=
gned long addr,
 	page =3D pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(pud_page(orig), refs);
+	head =3D try_grab_compound_head(pud_page(orig), refs, flags);
 	if (!head)
 		return 0;
=20
@@ -2222,7 +2369,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsi=
gned long addr,
 	page =3D pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(pgd_page(orig), refs);
+	head =3D try_grab_compound_head(pgd_page(orig), refs, flags);
 	if (!head)
 		return 0;
=20
@@ -2505,11 +2652,11 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start, int nr_pages,
=20
 /**
  * get_user_pages_fast() - pin user pages in memory
- * @start:	starting user address
- * @nr_pages:	number of pages from start to pin
- * @gup_flags:	flags modifying pin behaviour
- * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_pages long.
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying pin behaviour
+ * @pages:      array that receives pointers to the pages pinned.
+ *              Should be at least nr_pages long.
  *
  * Attempt to pin user pages in memory without taking mm->mmap_sem.
  * If not successful, it will fall back to taking the lock and
@@ -2543,9 +2690,12 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
 /**
  * pin_user_pages_fast() - pin user pages in memory without taking locks
  *
- * For now, this is a placeholder function, until various call sites are
- * converted to use the correct get_user_pages*() or pin_user_pages*() API=
. So,
- * this is identical to get_user_pages_fast().
+ * Nearly the same as get_user_pages_fast(), except that FOLL_PIN is set. =
See
+ * get_user_pages_fast() for documentation on the function arguments, beca=
use
+ * the arguments here are identical.
+ *
+ * FOLL_PIN means that the pages must be released via unpin_user_page(). P=
lease
+ * see Documentation/vm/pin_user_pages.rst for further details.
  *
  * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rs=
t. It
  * is NOT intended for Case 2 (RDMA: long-term pins).
@@ -2553,21 +2703,24 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
 {
-	/*
-	 * This is a placeholder, until the pin functionality is activated.
-	 * Until then, just behave like the corresponding get_user_pages*()
-	 * routine.
-	 */
-	return get_user_pages_fast(start, nr_pages, gup_flags, pages);
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
+		return -EINVAL;
+
+	gup_flags |=3D FOLL_PIN;
+	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
 EXPORT_SYMBOL_GPL(pin_user_pages_fast);
=20
 /**
  * pin_user_pages_remote() - pin pages of a remote process (task !=3D curr=
ent)
  *
- * For now, this is a placeholder function, until various call sites are
- * converted to use the correct get_user_pages*() or pin_user_pages*() API=
. So,
- * this is identical to get_user_pages_remote().
+ * Nearly the same as get_user_pages_remote(), except that FOLL_PIN is set=
. See
+ * get_user_pages_remote() for documentation on the function arguments, be=
cause
+ * the arguments here are identical.
+ *
+ * FOLL_PIN means that the pages must be released via unpin_user_page(). P=
lease
+ * see Documentation/vm/pin_user_pages.rst for details.
  *
  * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rs=
t. It
  * is NOT intended for Case 2 (RDMA: long-term pins).
@@ -2577,22 +2730,24 @@ long pin_user_pages_remote(struct task_struct *tsk,=
 struct mm_struct *mm,
 			   unsigned int gup_flags, struct page **pages,
 			   struct vm_area_struct **vmas, int *locked)
 {
-	/*
-	 * This is a placeholder, until the pin functionality is activated.
-	 * Until then, just behave like the corresponding get_user_pages*()
-	 * routine.
-	 */
-	return get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags, pages,
-				     vmas, locked);
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
+		return -EINVAL;
+
+	gup_flags |=3D FOLL_PIN;
+	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
+				       pages, vmas, locked);
 }
 EXPORT_SYMBOL(pin_user_pages_remote);
=20
 /**
  * pin_user_pages() - pin user pages in memory for use by other devices
  *
- * For now, this is a placeholder function, until various call sites are
- * converted to use the correct get_user_pages*() or pin_user_pages*() API=
. So,
- * this is identical to get_user_pages().
+ * Nearly the same as get_user_pages(), except that FOLL_TOUCH is not set,=
 and
+ * FOLL_PIN is set.
+ *
+ * FOLL_PIN means that the pages must be released via unpin_user_page(). P=
lease
+ * see Documentation/vm/pin_user_pages.rst for details.
  *
  * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rs=
t. It
  * is NOT intended for Case 2 (RDMA: long-term pins).
@@ -2601,11 +2756,12 @@ long pin_user_pages(unsigned long start, unsigned l=
ong nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas)
 {
-	/*
-	 * This is a placeholder, until the pin functionality is activated.
-	 * Until then, just behave like the corresponding get_user_pages*()
-	 * routine.
-	 */
-	return get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
+		return -EINVAL;
+
+	gup_flags |=3D FOLL_PIN;
+	return __gup_longterm_locked(current, current->mm, start, nr_pages,
+				     pages, vmas, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..580098e115bd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -958,6 +958,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *=
vma, unsigned long addr,
 	 */
 	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set")=
;
=20
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) =3D=3D
+			 (FOLL_PIN | FOLL_GET)))
+		return NULL;
+
 	if (flags & FOLL_WRITE && !pmd_write(*pmd))
 		return NULL;
=20
@@ -973,7 +978,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *v=
ma, unsigned long addr,
 	 * device mapped pages can only be returned if the
 	 * caller will manage the page reference count.
 	 */
-	if (!(flags & FOLL_GET))
+	if (!(flags & (FOLL_GET | FOLL_PIN)))
 		return ERR_PTR(-EEXIST);
=20
 	pfn +=3D (addr & ~PMD_MASK) >> PAGE_SHIFT;
@@ -981,7 +986,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *v=
ma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page =3D pfn_to_page(pfn);
-	get_page(page);
+	if (!try_grab_page(page, flags))
+		page =3D ERR_PTR(-ENOMEM);
=20
 	return page;
 }
@@ -1101,6 +1107,11 @@ struct page *follow_devmap_pud(struct vm_area_struct=
 *vma, unsigned long addr,
 	if (flags & FOLL_WRITE && !pud_write(*pud))
 		return NULL;
=20
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) =3D=3D
+			 (FOLL_PIN | FOLL_GET)))
+		return NULL;
+
 	if (pud_present(*pud) && pud_devmap(*pud))
 		/* pass */;
 	else
@@ -1112,8 +1123,10 @@ struct page *follow_devmap_pud(struct vm_area_struct=
 *vma, unsigned long addr,
 	/*
 	 * device mapped pages can only be returned if the
 	 * caller will manage the page reference count.
+	 *
+	 * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
 	 */
-	if (!(flags & FOLL_GET))
+	if (!(flags & (FOLL_GET | FOLL_PIN)))
 		return ERR_PTR(-EEXIST);
=20
 	pfn +=3D (addr & ~PUD_MASK) >> PAGE_SHIFT;
@@ -1121,7 +1134,8 @@ struct page *follow_devmap_pud(struct vm_area_struct =
*vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page =3D pfn_to_page(pfn);
-	get_page(page);
+	if (!try_grab_page(page, flags))
+		page =3D ERR_PTR(-ENOMEM);
=20
 	return page;
 }
@@ -1497,8 +1511,13 @@ struct page *follow_trans_huge_pmd(struct vm_area_st=
ruct *vma,
=20
 	page =3D pmd_page(*pmd);
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+
+	if (!try_grab_page(page, flags))
+		return ERR_PTR(-ENOMEM);
+
 	if (flags & FOLL_TOUCH)
 		touch_pmd(vma, addr, pmd, flags);
+
 	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
 		/*
 		 * We don't mlock() pte-mapped THPs. This way we can avoid
@@ -1535,8 +1554,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_str=
uct *vma,
 skip_mlock:
 	page +=3D (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
 	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
-	if (flags & FOLL_GET)
-		get_page(page);
=20
 out:
 	return page;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec..ba1de6bc1402 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4375,19 +4375,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struc=
t vm_area_struct *vma,
 		pfn_offset =3D (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
 		page =3D pte_page(huge_ptep_get(pte));
=20
-		/*
-		 * Instead of doing 'try_get_page()' below in the same_page
-		 * loop, just check the count once here.
-		 */
-		if (unlikely(page_count(page) <=3D 0)) {
-			if (pages) {
-				spin_unlock(ptl);
-				remainder =3D 0;
-				err =3D -ENOMEM;
-				break;
-			}
-		}
-
 		/*
 		 * If subpage information not requested, update counters
 		 * and skip the same_page loop below.
@@ -4405,7 +4392,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struc=
t vm_area_struct *vma,
 same_page:
 		if (pages) {
 			pages[i] =3D mem_map_offset(page, pfn_offset);
-			get_page(pages[i]);
+			/*
+			 * try_grab_page() should always succeed here, because:
+			 * a) we hold the ptl lock, and b) we've just checked
+			 * that the huge page is present in the page tables. If
+			 * the huge page is present, then the tail pages must
+			 * also be present. The ptl prevents the head page and
+			 * tail pages from being rearranged in any way. So this
+			 * page must be available at this point, unless the page
+			 * refcount overflowed:
+			 */
+			if (WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
+				spin_unlock(ptl);
+				remainder =3D 0;
+				err =3D -ENOMEM;
+				break;
+			}
 		}
=20
 		if (vmas)
@@ -4965,6 +4967,12 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long =
address,
 	struct page *page =3D NULL;
 	spinlock_t *ptl;
 	pte_t pte;
+
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) =3D=3D
+			 (FOLL_PIN | FOLL_GET)))
+		return NULL;
+
 retry:
 	ptl =3D pmd_lockptr(mm, pmd);
 	spin_lock(ptl);
@@ -4977,8 +4985,18 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long =
address,
 	pte =3D huge_ptep_get((pte_t *)pmd);
 	if (pte_present(pte)) {
 		page =3D pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
-		if (flags & FOLL_GET)
-			get_page(page);
+		/*
+		 * try_grab_page() should always succeed here, because: a) we
+		 * hold the pmd (ptl) lock, and b) we've just checked that the
+		 * huge pmd (head) page is present in the page tables. The ptl
+		 * prevents the head page and tail pages from being rearranged
+		 * in any way. So this page must be available at this point,
+		 * unless the page refcount overflowed:
+		 */
+		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
+			page =3D NULL;
+			goto out;
+		}
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
@@ -4999,7 +5017,7 @@ struct page * __weak
 follow_huge_pud(struct mm_struct *mm, unsigned long address,
 		pud_t *pud, int flags)
 {
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return NULL;
=20
 	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
@@ -5008,7 +5026,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long a=
ddress,
 struct page * __weak
 follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, i=
nt flags)
 {
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return NULL;
=20
 	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
--=20
2.25.0

