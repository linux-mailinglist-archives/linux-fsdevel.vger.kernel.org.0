Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18C41492EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 03:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgAYCL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 21:11:27 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18994 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbgAYCL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 21:11:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2ba3990000>; Fri, 24 Jan 2020 18:10:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jan 2020 18:11:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Jan 2020 18:11:19 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Jan
 2020 02:11:19 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 25 Jan 2020 02:11:18 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e2ba3c50005>; Fri, 24 Jan 2020 18:11:18 -0800
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
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/3] mm/gup: track FOLL_PIN pages
Date:   Fri, 24 Jan 2020 18:11:13 -0800
Message-ID: <20200125021115.731629-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200125021115.731629-1-jhubbard@nvidia.com>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579918233; bh=1JshG823eqO5zXmwUZYIXdSbpM2Jc4uXWRxYPnnAvKk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=LNKYT9bgWo3yUJEQnm+gZVtyPkwFQZlI+hr8px9TqlcjYFnyyypvHK9Md0r+elgHA
         dXiG83xXTs9tQ6KddaJmKs8MoQ32031/v7WOCNGmfx75J3ahyyU7KrGHzNZnhOZ4JT
         /uxTGxNJf2XOpgnHEJaQB/VfuCcRvPgaySuzF+WO2V/FWkJKqsZcKF3qdKNVfDNAIY
         BoXVHcUTMmZA/wrMqz/nfoUc2Oz7FdYTUOmGUbWDNA7Ec6G95PYFMYL1D/PjXF27rN
         A724YD5KJ8qRHMA0iXnDWYva5MPrHbV5644ighs4uYYYHM+4eK6FEmqYE8UGV2GzdB
         OyW5H1lCuTi9w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tracking of pages that were pinned via FOLL_PIN.

As mentioned in the FOLL_PIN documentation, callers who effectively set
FOLL_PIN are required to ultimately free such pages via unpin_user_page().
The effect is similar to FOLL_GET, and may be thought of as "FOLL_GET
for DIO and/or RDMA use".

Pages that have been pinned via FOLL_PIN are identifiable via a
new function call:

   bool page_dma_pinned(struct page *page);

What to do in response to encountering such a page, is left to later
patchsets. There is discussion about this in [1], [2], and [3].

This also changes a BUG_ON(), to a WARN_ON(), in follow_page_mask().

It also adds a few critical diagnostics to dump_page().

[1] Some slow progress on get_user_pages() (Apr 2, 2019):
    https://lwn.net/Articles/784574/
[2] DMA and get_user_pages() (LPC: Dec 12, 2018):
    https://lwn.net/Articles/774411/
[3] The trouble with get_user_pages() (Apr 30, 2018):
    https://lwn.net/Articles/753027/

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst |  48 +--
 include/linux/mm.h                        | 109 ++++-
 include/linux/mm_types.h                  |   7 +-
 include/linux/mmzone.h                    |   2 +
 include/linux/page_ref.h                  |  10 +
 mm/debug.c                                |  22 +-
 mm/gup.c                                  | 467 +++++++++++++++++-----
 mm/huge_memory.c                          |  29 +-
 mm/hugetlb.c                              |  44 +-
 mm/page_alloc.c                           |   2 +
 mm/rmap.c                                 |   6 +
 mm/vmstat.c                               |   2 +
 12 files changed, 577 insertions(+), 171 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 1d490155ecd7..435269c734f9 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -52,8 +52,22 @@ Which flags are set by each wrapper
=20
 For these pin_user_pages*() functions, FOLL_PIN is OR'd in with whatever g=
up
 flags the caller provides. The caller is required to pass in a non-null st=
ruct
-pages* array, and the function then pin pages by incrementing each by a sp=
ecial
-value. For now, that value is +1, just like get_user_pages*().::
+pages* array, and the function then pins pages by incrementing each by a s=
pecial
+value: GUP_PIN_COUNTING_BIAS.
+
+For huge pages (and in fact, any compound page of more than 2 pages), the
+GUP_PIN_COUNTING_BIAS scheme is not used. Instead, an exact form of pin co=
unting
+is achieved, by using the 3rd struct page in the compound page. A new stru=
ct
+page field, hpage_pinned_refcount, has been added in order to support this=
.
+
+This approach for compound pages avoids the counting upper limit problems =
that
+are discussed below. Those limitations would have been aggravated severely=
 by
+huge pages, because each tail page adds a refcount to the head page. And i=
n
+fact, testing revealed that, without a separate hpage_pinned_refcount fiel=
d,
+page overflows were seen in some huge page stress tests.
+
+This also means that huge pages and compound pages (of order > 1) do not s=
uffer
+from the false positives problem that is mentioned below.::
=20
  Function
  --------
@@ -99,27 +113,6 @@ pages:
 This also leads to limitations: there are only 31-10=3D=3D21 bits availabl=
e for a
 counter that increments 10 bits at a time.
=20
-TODO: for 1GB and larger huge pages, this is cutting it close. That's beca=
use
-when pin_user_pages() follows such pages, it increments the head page by "=
1"
-(where "1" used to mean "+1" for get_user_pages(), but now means "+1024" f=
or
-pin_user_pages()) for each tail page. So if you have a 1GB huge page:
-
-* There are 256K (18 bits) worth of 4 KB tail pages.
-* There are 21 bits available to count up via GUP_PIN_COUNTING_BIAS (that =
is,
-  10 bits at a time)
-* There are 21 - 18 =3D=3D 3 bits available to count. Except that there ar=
en't,
-  because you need to allow for a few normal get_page() calls on the head =
page,
-  as well. Fortunately, the approach of using addition, rather than "hard"
-  bitfields, within page->_refcount, allows for sharing these bits gracefu=
lly.
-  But we're still looking at about 8 references.
-
-This, however, is a missing feature more than anything else, because it's =
easily
-solved by addressing an obvious inefficiency in the original get_user_page=
s()
-approach of retrieving pages: stop treating all the pages as if they were
-PAGE_SIZE. Retrieve huge pages as huge pages. The callers need to be aware=
 of
-this, so some work is required. Once that's in place, this limitation most=
ly
-disappears from view, because there will be ample refcounting range availa=
ble.
-
 * Callers must specifically request "dma-pinned tracking of pages". In oth=
er
   words, just calling get_user_pages() will not suffice; a new set of func=
tions,
   pin_user_page() and related, must be used.
@@ -222,11 +215,20 @@ Those are both going to show zero, unless CONFIG_DEBU=
G_VM is set. This is
 because there is a noticeable performance drop in unpin_user_page(), when =
they
 are activated.
=20
+Other diagnostics
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+dump_page() has been enhanced slightly, to handle these new counting field=
s, and
+to better report on compound pages in general. Specifically, for compound =
pages,
+the head page refcount is reported, and for compound pages with order > 1,=
 the
+exact (hpage_pinned_refcount) pincount is reported.
+
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 * `Some slow progress on get_user_pages() (Apr 2, 2019) <https://lwn.net/A=
rticles/784574/>`_
 * `DMA and get_user_pages() (LPC: Dec 12, 2018) <https://lwn.net/Articles/=
774411/>`_
 * `The trouble with get_user_pages() (Apr 30, 2018) <https://lwn.net/Artic=
les/753027/>`_
+* `LWN kernel index: get_user_pages() <https://lwn.net/Kernel/Index/#Memor=
y_management-get_user_pages>`
=20
 John Hubbard, October, 2019
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 080f8ac8bfb7..a8ad5612bbcb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -770,6 +770,24 @@ static inline unsigned int compound_order(struct page =
*page)
 	return page[1].compound_order;
 }
=20
+static inline bool hpage_pincount_available(struct page *page)
+{
+	/*
+	 * Can the page->hpage_pinned_refcount field be used? That field is in
+	 * the 3rd page of the compound page, so the smallest (2-page) compound
+	 * pages cannot support it.
+	 */
+	page =3D compound_head(page);
+	return PageCompound(page) && compound_order(page) > 1;
+}
+
+static inline int compound_pincount(struct page *page)
+{
+	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	page =3D compound_head(page);
+	return atomic_read(compound_pincount_ptr(page));
+}
+
 static inline void set_compound_order(struct page *page, unsigned int orde=
r)
 {
 	page[1].compound_order =3D order;
@@ -1001,6 +1019,8 @@ static inline void get_page(struct page *page)
 	page_ref_inc(page);
 }
=20
+bool __must_check try_grab_page(struct page *page, unsigned int flags);
+
 static inline __must_check bool try_get_page(struct page *page)
 {
 	page =3D compound_head(page);
@@ -1029,29 +1049,88 @@ static inline void put_page(struct page *page)
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
  *
- * Pages that were pinned via pin_user_pages*() must be released via eithe=
r
- * unpin_user_page(), or one of the unpin_user_pages*() routines. This is =
so
- * that eventually such pages can be separately tracked and uniquely handl=
ed. In
- * particular, interactions with RDMA and filesystems need special handlin=
g.
+ * With this scheme, pin_user_pages() becomes special: such pages are mark=
ed as
+ * distinct from normal pages. As such, the unpin_user_page() call (and it=
s
+ * variants) must be used in order to release gup-pinned pages.
  *
- * unpin_user_page() and put_page() are not interchangeable, despite this =
early
- * implementation that makes them look the same. unpin_user_page() calls m=
ust
- * be perfectly matched up with pin*() calls.
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
+ *
+ * Of course, once the lower bits overflow into the upper bits (and this i=
s
+ * OK, because subtraction recovers the original values), then visual insp=
ection
+ * no longer suffices to directly view the separate counts. However, for n=
ormal
+ * applications that don't have huge page reference counts, this won't be =
an
+ * issue.
+ *
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
+ * page_dma_pinned() - report if a page is pinned for DMA.
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
+ * For huge pages, the result will be exactly correct. That's because we h=
ave
+ * more tracking data available: the 3rd struct page in the compound page =
is
+ * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
+ * scheme).
+ *
+ * For more information, please see Documentation/vm/pin_user_pages.rst.
+ *
+ * @page:	pointer to page to be queried.
+ * @Return:	True, if it is likely that the page has been "dma-pinned".
+ *		False, if the page is definitely not dma-pinned.
+ */
+static inline bool page_dma_pinned(struct page *page)
+{
+	if (hpage_pincount_available(page))
+		return compound_pincount(page) > 0;
+
+	/*
+	 * page_ref_count() is signed. If that refcount overflows, then
+	 * page_ref_count() returns a negative value, and callers will avoid
+	 * further incrementing the refcount.
+	 *
+	 * Here, for that overflow case, use the signed bit to count a little
+	 * bit higher via unsigned math, and thus still get an accurate result
+	 * from page_dma_pinned().
+	 */
+	return ((unsigned int)page_ref_count(compound_head(page))) >=3D
+		GUP_PIN_COUNTING_BIAS;
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 270aa8fd2800..d165275d8929 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -137,7 +137,7 @@ struct page {
 		};
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
-			unsigned long _compound_pad_2;
+			atomic_t hpage_pinned_refcount;
 			/* For both global and memcg */
 			struct list_head deferred_list;
 		};
@@ -226,6 +226,11 @@ static inline atomic_t *compound_mapcount_ptr(struct p=
age *page)
 	return &page[1].compound_mapcount;
 }
=20
+static inline atomic_t *compound_pincount_ptr(struct page *page)
+{
+	return &page[2].hpage_pinned_refcount;
+}
+
 /*
  * Used for sizing the vmemmap region on some architectures
  */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..392868bc4763 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -243,6 +243,8 @@ enum node_stat_item {
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
+	NR_FOLL_PIN_REQUESTED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
+	NR_FOLL_PIN_RETURNED,	/* pages returned via unpin_user_page() */
 	NR_VM_NODE_STAT_ITEMS
 };
=20
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 14d14beb1f7f..b9cbe553d1e7 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -102,6 +102,16 @@ static inline void page_ref_sub(struct page *page, int=
 nr)
 		__page_ref_mod(page, -nr);
 }
=20
+static inline int page_ref_sub_return(struct page *page, int nr)
+{
+	int ret =3D atomic_sub_return(nr, &page->_refcount);
+
+	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
+		__page_ref_mod(page, -nr);
+
+	return ret;
+}
+
 static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_refcount);
diff --git a/mm/debug.c b/mm/debug.c
index a90da5337c14..8db7f36c7bc6 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -76,11 +76,23 @@ void __dump_page(struct page *page, const char *reason)
 	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
=20
 	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page),
-			compound_mapcount(page));
+		if (hpage_pincount_available(page))
+			pr_warn("page:%px refcount:%d head refcount:%d "
+				"mapcount:%d mapping:%px index:%#lx "
+				"compound_mapcount:%d compound_pincount:%d\n",
+				page, page_ref_count(page),
+				page_ref_count(compound_head(page)), mapcount,
+				page->mapping, page_to_pgoff(page),
+				compound_mapcount(page),
+				compound_pincount(page));
+		else
+			pr_warn("page:%px refcount:%d head refcount:%d "
+				"mapcount:%d mapping:%px index:%#lx "
+				"compound_mapcount:%d\n",
+				page, page_ref_count(page),
+				page_ref_count(compound_head(page)), mapcount,
+				page->mapping, page_to_pgoff(page),
+				compound_mapcount(page));
 	else
 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
 			page, page_ref_count(page), mapcount,
diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..a750d15ec7d4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,6 +29,31 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
=20
+#ifdef CONFIG_DEBUG_VM
+static inline void __update_proc_vmstat(struct page *page,
+					enum node_stat_item item, int count)
+{
+	mod_node_page_state(page_pgdat(page), item, count);
+}
+#else
+static inline void __update_proc_vmstat(struct page *page,
+					enum node_stat_item item, int count)
+{
+}
+#endif
+
+static void hpage_pincount_inc(struct page *page)
+{
+	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	atomic_inc(compound_pincount_ptr(page));
+}
+
+static void hpage_pincount_dec(struct page *page)
+{
+	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	atomic_dec(compound_pincount_ptr(page));
+}
+
 /*
  * Return the compound head page with ref appropriately incremented,
  * or NULL if that failed.
@@ -44,6 +69,185 @@ static inline struct page *try_get_compound_head(struct=
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
+		int orig_refs =3D refs;
+
+		/*
+		 * When pinning a compound page of order > 1 (which is what
+		 * hpage_pincount_available() checks for), use an exact count to
+		 * track it, via hpage_pincount_inc/_dec().
+		 *
+		 * However, be sure to *also* increment the normal page refcount
+		 * field at least once, so that the page really is pinned.
+		 */
+		if (!hpage_pincount_available(page))
+			refs *=3D GUP_PIN_COUNTING_BIAS;
+
+		page =3D try_get_compound_head(page, refs);
+		if (!page)
+			return NULL;
+
+		if (hpage_pincount_available(page))
+			hpage_pincount_inc(page);
+
+		__update_proc_vmstat(page, NR_FOLL_PIN_REQUESTED, orig_refs);
+		return page;
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
+	if (flags & FOLL_GET)
+		return try_get_page(page);
+	else if (flags & FOLL_PIN) {
+		int refs =3D 1;
+
+		page =3D compound_head(page);
+
+		WARN_ON_ONCE(flags & FOLL_GET);
+
+		if (WARN_ON_ONCE(page_ref_count(page) <=3D 0))
+			return false;
+
+		if (hpage_pincount_available(page))
+			hpage_pincount_inc(page);
+		else
+			refs =3D GUP_PIN_COUNTING_BIAS;
+
+		/*
+		 * Similar to try_grab_compound_head(): even if using the
+		 * hpage_pincount_inc/_dec() routines, be sure to
+		 * *also* increment the normal page refcount field at least
+		 * once, so that the page really is pinned.
+		 */
+		page_ref_add(page, refs);
+
+		__update_proc_vmstat(page, NR_FOLL_PIN_REQUESTED, 1);
+	}
+
+	return true;
+}
+
+#ifdef CONFIG_DEV_PAGEMAP_OPS
+static bool __unpin_devmap_managed_user_page(struct page *page)
+{
+	int count, refs =3D 1;
+
+	if (!page_is_devmap_managed(page))
+		return false;
+
+	if (hpage_pincount_available(page))
+		hpage_pincount_dec(page);
+	else
+		refs =3D GUP_PIN_COUNTING_BIAS;
+
+	count =3D page_ref_sub_return(page, refs);
+
+	__update_proc_vmstat(page, NR_FOLL_PIN_RETURNED, 1);
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
+	int refs =3D 1;
+
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
+	if (hpage_pincount_available(page))
+		hpage_pincount_dec(page);
+	else
+		refs =3D GUP_PIN_COUNTING_BIAS;
+
+	if (page_ref_sub_and_test(page, refs))
+		__put_page(page);
+
+	__update_proc_vmstat(page, NR_FOLL_PIN_RETURNED, 1);
+}
+EXPORT_SYMBOL(unpin_user_page);
+
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned=
 pages
  * @pages:  array of pages to be maybe marked dirty, and definitely releas=
ed.
@@ -230,10 +434,11 @@ static struct page *follow_page_pte(struct vm_area_st=
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
@@ -271,11 +476,10 @@ static struct page *follow_page_pte(struct vm_area_st=
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
@@ -537,7 +741,7 @@ static struct page *follow_page_mask(struct vm_area_str=
uct *vma,
 	/* make this handle hugepd */
 	page =3D follow_huge_addr(mm, address, flags & FOLL_WRITE);
 	if (!IS_ERR(page)) {
-		BUG_ON(flags & FOLL_GET);
+		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
 		return page;
 	}
=20
@@ -1557,6 +1761,48 @@ static __always_inline long __gup_longterm_locked(st=
ruct task_struct *tsk,
 }
 #endif /* CONFIG_FS_DAX || CONFIG_CMA */
=20
+#ifdef CONFIG_MMU
+static long __get_user_pages_remote(struct task_struct *tsk,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long nr_pages,
+				    unsigned int gup_flags, struct page **pages,
+				    struct vm_area_struct **vmas, int *locked)
+{
+	/*
+	 * Parts of FOLL_LONGTERM behavior are incompatible with
+	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
+	 * vmas. However, this only comes up if locked is set, and there are
+	 * callers that do request FOLL_LONGTERM, but do not set locked. So,
+	 * allow what we can.
+	 */
+	if (gup_flags & FOLL_LONGTERM) {
+		if (WARN_ON_ONCE(locked))
+			return -EINVAL;
+		/*
+		 * This will check the vmas (even if our vmas arg is NULL)
+		 * and return -ENOTSUPP if DAX isn't allowed in this case:
+		 */
+		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
+					     vmas, gup_flags | FOLL_TOUCH |
+					     FOLL_REMOTE);
+	}
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+				       locked,
+				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
+}
+
+#else /* CONFIG_MMU */
+static long __get_user_pages_remote(struct task_struct *tsk,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long nr_pages,
+				    unsigned int gup_flags, struct page **pages,
+				    struct vm_area_struct **vmas, int *locked)
+{
+	return 0;
+}
+#endif /* !CONFIG_MMU */
+
 /*
  * get_user_pages_remote() - pin user pages in memory
  * @tsk:	the task_struct to use for page fault accounting, or
@@ -1619,7 +1865,6 @@ static __always_inline long __gup_longterm_locked(str=
uct task_struct *tsk,
  * should use get_user_pages because it cannot pass
  * FAULT_FLAG_ALLOW_RETRY to handle_mm_fault.
  */
-#ifdef CONFIG_MMU
 long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
@@ -1632,41 +1877,11 @@ long get_user_pages_remote(struct task_struct *tsk,=
 struct mm_struct *mm,
 	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
 		return -EINVAL;
=20
-	/*
-	 * Parts of FOLL_LONGTERM behavior are incompatible with
-	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
-	 * vmas. However, this only comes up if locked is set, and there are
-	 * callers that do request FOLL_LONGTERM, but do not set locked. So,
-	 * allow what we can.
-	 */
-	if (gup_flags & FOLL_LONGTERM) {
-		if (WARN_ON_ONCE(locked))
-			return -EINVAL;
-		/*
-		 * This will check the vmas (even if our vmas arg is NULL)
-		 * and return -ENOTSUPP if DAX isn't allowed in this case:
-		 */
-		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
-					     vmas, gup_flags | FOLL_TOUCH |
-					     FOLL_REMOTE);
-	}
-
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
-				       locked,
-				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
+	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
+				       pages, vmas, locked);
 }
 EXPORT_SYMBOL(get_user_pages_remote);
=20
-#else /* CONFIG_MMU */
-long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
-			   unsigned long start, unsigned long nr_pages,
-			   unsigned int gup_flags, struct page **pages,
-			   struct vm_area_struct **vmas, int *locked)
-{
-	return 0;
-}
-#endif /* !CONFIG_MMU */
-
 /*
  * This is the same as get_user_pages_remote(), just with a
  * less-flexible calling convention where we assume that the task
@@ -1860,13 +2075,17 @@ static inline pte_t gup_get_pte(pte_t *ptep)
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
=20
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
+					    unsigned int flags,
 					    struct page **pages)
 {
 	while ((*nr) - nr_start) {
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
@@ -1899,7 +2118,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long add=
r, unsigned long end,
=20
 			pgmap =3D get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, pages);
+				undo_dev_pagemap(nr, nr_start, flags, pages);
 				goto pte_unmap;
 			}
 		} else if (pte_special(pte))
@@ -1908,7 +2127,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long add=
r, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page =3D pte_page(pte);
=20
-		head =3D try_get_compound_head(page, 1);
+		head =3D try_grab_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
=20
@@ -1953,7 +2172,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long add=
r, unsigned long end,
=20
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGE=
PAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+			     unsigned long end, unsigned int flags,
+			     struct page **pages, int *nr)
 {
 	int nr_start =3D *nr;
 	struct dev_pagemap *pgmap =3D NULL;
@@ -1963,12 +2183,15 @@ static int __gup_device_huge(unsigned long pfn, uns=
igned long addr,
=20
 		pgmap =3D get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, pages);
+			undo_dev_pagemap(nr, nr_start, flags, pages);
 			return 0;
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
@@ -1979,48 +2202,52 @@ static int __gup_device_huge(unsigned long pfn, uns=
igned long addr,
 }
=20
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long ad=
dr,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
 	int nr_start =3D *nr;
=20
 	fault_pfn =3D pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
=20
 	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
-		undo_dev_pagemap(nr, nr_start, pages);
+		undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
 	return 1;
 }
=20
 static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long ad=
dr,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
 	int nr_start =3D *nr;
=20
 	fault_pfn =3D pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
=20
 	if (unlikely(pud_val(orig) !=3D pud_val(*pudp))) {
-		undo_dev_pagemap(nr, nr_start, pages);
+		undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
 	return 1;
 }
 #else
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long ad=
dr,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	BUILD_BUG();
 	return 0;
 }
=20
 static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long add=
r,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	BUILD_BUG();
 	return 0;
@@ -2038,8 +2265,15 @@ static int record_subpages(struct page *page, unsign=
ed long addr,
 	return nr;
 }
=20
-static void put_compound_head(struct page *page, int refs)
+static void put_compound_head(struct page *page, int refs, unsigned int fl=
ags)
 {
+	if (flags & FOLL_PIN) {
+		if (hpage_pincount_available(page))
+			hpage_pincount_dec(page);
+		else
+			refs *=3D GUP_PIN_COUNTING_BIAS;
+	}
+
 	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
 	/*
 	 * Calling put_page() for each ref is unnecessarily slow. Only the last
@@ -2083,12 +2317,12 @@ static int gup_hugepte(pte_t *ptep, unsigned long s=
z, unsigned long addr,
 	page =3D head + ((addr & (sz-1)) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(head, refs);
+	head =3D try_grab_compound_head(head, refs, flags);
 	if (!head)
 		return 0;
=20
 	if (unlikely(pte_val(pte) !=3D pte_val(*ptep))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2136,18 +2370,19 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, un=
signed long addr,
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
+		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
+					     pages, nr);
 	}
=20
 	page =3D pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(pmd_page(orig), refs);
+	head =3D try_grab_compound_head(pmd_page(orig), refs, flags);
 	if (!head)
 		return 0;
=20
 	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2157,7 +2392,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsi=
gned long addr,
 }
=20
 static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages, int *nr)
+			unsigned long end, unsigned int flags,
+			struct page **pages, int *nr)
 {
 	struct page *head, *page;
 	int refs;
@@ -2168,18 +2404,19 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, un=
signed long addr,
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
+		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
+					     pages, nr);
 	}
=20
 	page =3D pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(pud_page(orig), refs);
+	head =3D try_grab_compound_head(pud_page(orig), refs, flags);
 	if (!head)
 		return 0;
=20
 	if (unlikely(pud_val(orig) !=3D pud_val(*pudp))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2203,12 +2440,12 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, un=
signed long addr,
 	page =3D pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs =3D record_subpages(page, addr, end, pages + *nr);
=20
-	head =3D try_get_compound_head(pgd_page(orig), refs);
+	head =3D try_grab_compound_head(pgd_page(orig), refs, flags);
 	if (!head)
 		return 0;
=20
 	if (unlikely(pgd_val(orig) !=3D pgd_val(*pgdp))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2371,6 +2608,14 @@ int __get_user_pages_fast(unsigned long start, int n=
r_pages, int write,
 	unsigned long len, end;
 	unsigned long flags;
 	int nr =3D 0;
+	/*
+	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
+	 * because gup fast is always a "pin with a +1 page refcount" request.
+	 */
+	unsigned int gup_flags =3D FOLL_GET;
+
+	if (write)
+		gup_flags |=3D FOLL_WRITE;
=20
 	start =3D untagged_addr(start) & PAGE_MASK;
 	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
@@ -2396,7 +2641,7 @@ int __get_user_pages_fast(unsigned long start, int nr=
_pages, int write,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_save(flags);
-		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
+		gup_pgd_range(start, end, gup_flags, pages, &nr);
 		local_irq_restore(flags);
 	}
=20
@@ -2435,7 +2680,7 @@ static int internal_get_user_pages_fast(unsigned long=
 start, int nr_pages,
 	int nr =3D 0, ret =3D 0;
=20
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
-				       FOLL_FORCE | FOLL_PIN)))
+				       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
 		return -EINVAL;
=20
 	start =3D untagged_addr(start) & PAGE_MASK;
@@ -2478,11 +2723,11 @@ static int internal_get_user_pages_fast(unsigned lo=
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
@@ -2502,6 +2747,13 @@ int get_user_pages_fast(unsigned long start, int nr_=
pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
 		return -EINVAL;
=20
+	/*
+	 * The caller may or may not have explicitly set FOLL_GET; either way is
+	 * OK. However, internally (within mm/gup.c), gup fast variants must set
+	 * FOLL_GET, because gup fast is always a "pin with a +1 page refcount"
+	 * request.
+	 */
+	gup_flags |=3D FOLL_GET;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_fast);
@@ -2509,9 +2761,12 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
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
@@ -2519,21 +2774,24 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
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
@@ -2543,22 +2801,24 @@ long pin_user_pages_remote(struct task_struct *tsk,=
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
@@ -2567,11 +2827,12 @@ long pin_user_pages(unsigned long start, unsigned l=
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
index fb7ba2a6c401..46be170d13f5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -947,6 +947,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *=
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
@@ -962,7 +967,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *v=
ma, unsigned long addr,
 	 * device mapped pages can only be returned if the
 	 * caller will manage the page reference count.
 	 */
-	if (!(flags & FOLL_GET))
+	if (!(flags & (FOLL_GET | FOLL_PIN)))
 		return ERR_PTR(-EEXIST);
=20
 	pfn +=3D (addr & ~PMD_MASK) >> PAGE_SHIFT;
@@ -970,7 +975,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *v=
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
@@ -1090,6 +1096,11 @@ struct page *follow_devmap_pud(struct vm_area_struct=
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
@@ -1101,8 +1112,10 @@ struct page *follow_devmap_pud(struct vm_area_struct=
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
@@ -1110,7 +1123,8 @@ struct page *follow_devmap_pud(struct vm_area_struct =
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
@@ -1486,8 +1500,13 @@ struct page *follow_trans_huge_pmd(struct vm_area_st=
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
@@ -1524,8 +1543,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_str=
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
index dd8737a94bec..07059d936f7b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1009,6 +1009,9 @@ static void destroy_compound_gigantic_page(struct pag=
e *page,
 	struct page *p =3D page + 1;
=20
 	atomic_set(compound_mapcount_ptr(page), 0);
+	if (hpage_pincount_available(page))
+		atomic_set(compound_pincount_ptr(page), 0);
+
 	for (i =3D 1; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) {
 		clear_compound_head(p);
 		set_page_refcounted(p);
@@ -1287,6 +1290,9 @@ static void prep_compound_gigantic_page(struct page *=
page, unsigned int order)
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
+
+	if (hpage_pincount_available(page))
+		atomic_set(compound_pincount_ptr(page), 0);
 }
=20
 /*
@@ -4375,19 +4381,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struc=
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
@@ -4405,7 +4398,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struc=
t vm_area_struct *vma,
 same_page:
 		if (pages) {
 			pages[i] =3D mem_map_offset(page, pfn_offset);
-			get_page(pages[i]);
+			if (!try_grab_page(pages[i], flags)) {
+				spin_unlock(ptl);
+				remainder =3D 0;
+				err =3D -ENOMEM;
+				WARN_ON_ONCE(1);
+				break;
+			}
 		}
=20
 		if (vmas)
@@ -4965,6 +4964,12 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long =
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
@@ -4977,8 +4982,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long =
address,
 	pte =3D huge_ptep_get((pte_t *)pmd);
 	if (pte_present(pte)) {
 		page =3D pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
-		if (flags & FOLL_GET)
-			get_page(page);
+		if (unlikely(!try_grab_page(page, flags))) {
+			WARN_ON_ONCE(1);
+			page =3D NULL;
+			goto out;
+		}
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
@@ -4999,7 +5007,7 @@ struct page * __weak
 follow_huge_pud(struct mm_struct *mm, unsigned long address,
 		pud_t *pud, int flags)
 {
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return NULL;
=20
 	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
@@ -5008,7 +5016,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long a=
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..b2fe61035b7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -689,6 +689,8 @@ void prep_compound_page(struct page *page, unsigned int=
 order)
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
+	if (hpage_pincount_available(page))
+		atomic_set(compound_pincount_ptr(page), 0);
 }
=20
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..e45b9b991e2f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1178,6 +1178,9 @@ void page_add_new_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(compound_mapcount_ptr(page), 0);
+		if (hpage_pincount_available(page))
+			atomic_set(compound_pincount_ptr(page), 0);
+
 		__inc_node_page_state(page, NR_ANON_THPS);
 	} else {
 		/* Anon THP always mapped first with PMD */
@@ -1974,6 +1977,9 @@ void hugepage_add_new_anon_rmap(struct page *page,
 {
 	BUG_ON(address < vma->vm_start || address >=3D vma->vm_end);
 	atomic_set(compound_mapcount_ptr(page), 0);
+	if (hpage_pincount_available(page))
+		atomic_set(compound_pincount_ptr(page), 0);
+
 	__page_set_anon_rmap(page, vma, address, 1);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..b56808bae1b4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1168,6 +1168,8 @@ const char * const vmstat_text[] =3D {
 	"nr_dirtied",
 	"nr_written",
 	"nr_kernel_misc_reclaimable",
+	"nr_foll_pin_requested",
+	"nr_foll_pin_returned",
=20
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
--=20
2.25.0

