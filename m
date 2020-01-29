Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF27D14C4E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 04:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgA2DYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 22:24:36 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17868 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgA2DYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:24:25 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e30fad50002>; Tue, 28 Jan 2020 19:24:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 19:24:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Jan 2020 19:24:19 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 03:24:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 Jan 2020 03:24:19 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e30fae30004>; Tue, 28 Jan 2020 19:24:19 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 5/8] mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages
Date:   Tue, 28 Jan 2020 19:24:14 -0800
Message-ID: <20200129032417.3085670-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129032417.3085670-1-jhubbard@nvidia.com>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580268245; bh=YdqHmkFj3hkoFbCtYAkVdweMrSRxQYaFII5j1rZv/XY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=PnpNviMWIa8lR+9kqlrxIfEihH5qGSeXIpJTVTvezb4mWqCsBFuvKvhbIstWgqYfs
         dg5MOLXOGTrbzVCAqlKrO5rcKQSGQX+6UA7p+LW7kZNpvEZqbcXhN/H3jOSUBmUoNW
         breHH/h1PnIW8N/98uPQ9j4VOSEdJm0UW0k2U6mH+4mhDP1Lhjc2qSjC3jp9yFXNiy
         tS+KzYLouqOpk1+glmwZ/Rp4C0cWRReO9FTs956/9L4bTdj+QasVe5FE2J3ub9vnZl
         p9w70Oq8rA6RireZqZIybY3XnoM6332Q+JL/xVGHAEf36aCXFi9ooMmZH+fxc2fFd0
         1xa3UTtKfw2jw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For huge pages (and in fact, any compound page), the
GUP_PIN_COUNTING_BIAS scheme tends to overflow too easily, each tail
page increments the head page->_refcount by GUP_PIN_COUNTING_BIAS
(1024). That limits the number of huge pages that can be pinned.

This patch removes that limitation, by using an exact form of pin
counting for compound pages of order > 1. The "order > 1" is required
because this approach uses the 3rd struct page in the compound page, and
order 1 compound pages only have two pages, so that won't work there.

A new struct page field, hpage_pinned_refcount, has been added,
replacing a padding field in the union (so no new space is used).

This enhancement also has a useful side effect: huge pages and compound
pages (of order > 1) do not suffer from the "potential false positives"
problem that is discussed in the page_dma_pinned() comment block. That
is because these compound pages have extra space for tracking things, so
they get exact pin counts instead of overloading page->_refcount.

dump_page() has also been enhanced slightly, to handle the new counting
field: for compound pages with order > 1, the exact pincount is
reported: page->hpage_pinned_refcount.

Documentation/core-api/pin_user_pages.rst is updated accordingly.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst | 47 +++++++-------
 include/linux/mm.h                        | 26 ++++++++
 include/linux/mm_types.h                  |  7 +-
 mm/debug.c                                | 24 +++++--
 mm/gup.c                                  | 78 ++++++++++++++++++++---
 mm/hugetlb.c                              |  6 ++
 mm/page_alloc.c                           |  2 +
 mm/rmap.c                                 |  6 ++
 8 files changed, 157 insertions(+), 39 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 1d490155ecd7..55a30d260d39 100644
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
@@ -222,11 +215,19 @@ Those are both going to show zero, unless CONFIG_DEBU=
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
pages
+with order > 1, the exact (hpage_pinned_refcount) pincount is reported.
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
index c5d0f4a66788..a8ad5612bbcb 100644
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
@@ -1084,6 +1102,11 @@ void unpin_user_pages(struct page **pages, unsigned =
long npages);
  * refcounts, and b) all the callers of this routine are expected to be ab=
le to
  * deal gracefully with a false positive.
  *
+ * For huge pages, the result will be exactly correct. That's because we h=
ave
+ * more tracking data available: the 3rd struct page in the compound page =
is
+ * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
+ * scheme).
+ *
  * For more information, please see Documentation/vm/pin_user_pages.rst.
  *
  * @page:	pointer to page to be queried.
@@ -1092,6 +1115,9 @@ void unpin_user_pages(struct page **pages, unsigned l=
ong npages);
  */
 static inline bool page_dma_pinned(struct page *page)
 {
+	if (hpage_pincount_available(page))
+		return compound_pincount(page) > 0;
+
 	/*
 	 * page_ref_count() is signed. If that refcount overflows, then
 	 * page_ref_count() returns a negative value, and callers will avoid
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
diff --git a/mm/debug.c b/mm/debug.c
index 4cc6cad8385d..8db7f36c7bc6 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -76,13 +76,23 @@ void __dump_page(struct page *page, const char *reason)
 	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
=20
 	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d head refcount:%d "
-			"mapcount:%d mapping:%px index:%#lx "
-			"compound_mapcount:%d\n",
-			page, page_ref_count(page),
-			page_ref_count(compound_head(page)), mapcount,
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
index 7a96490dcc54..03e7a5cfa6a9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,6 +29,22 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
=20
+static void hpage_pincount_add(struct page *page, int refs)
+{
+	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	VM_BUG_ON_PAGE(page !=3D compound_head(page), page);
+
+	atomic_add(refs, compound_pincount_ptr(page));
+}
+
+static void hpage_pincount_sub(struct page *page, int refs)
+{
+	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	VM_BUG_ON_PAGE(page !=3D compound_head(page), page);
+
+	atomic_sub(refs, compound_pincount_ptr(page));
+}
+
 /*
  * Return the compound head page with ref appropriately incremented,
  * or NULL if that failed.
@@ -70,8 +86,25 @@ static __maybe_unused struct page *try_grab_compound_hea=
d(struct page *page,
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
 	else if (flags & FOLL_PIN) {
-		refs *=3D GUP_PIN_COUNTING_BIAS;
-		return try_get_compound_head(page, refs);
+		/*
+		 * When pinning a compound page of order > 1 (which is what
+		 * hpage_pincount_available() checks for), use an exact count to
+		 * track it, via hpage_pincount_add/_sub().
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
+			hpage_pincount_add(page, refs);
+
+		return page;
 	}
=20
 	WARN_ON_ONCE(1);
@@ -104,6 +137,8 @@ bool __must_check try_grab_page(struct page *page, unsi=
gned int flags)
 	if (flags & FOLL_GET)
 		return try_get_page(page);
 	else if (flags & FOLL_PIN) {
+		int refs =3D 1;
+
 		page =3D compound_head(page);
=20
 		if (WARN_ON_ONCE(flags & FOLL_GET))
@@ -112,7 +147,18 @@ bool __must_check try_grab_page(struct page *page, uns=
igned int flags)
 		if (WARN_ON_ONCE(page_ref_count(page) <=3D 0))
 			return false;
=20
-		page_ref_add(page, GUP_PIN_COUNTING_BIAS);
+		if (hpage_pincount_available(page))
+			hpage_pincount_add(page, 1);
+		else
+			refs =3D GUP_PIN_COUNTING_BIAS;
+
+		/*
+		 * Similar to try_grab_compound_head(): even if using the
+		 * hpage_pincount_add/_sub() routines, be sure to
+		 * *also* increment the normal page refcount field at least
+		 * once, so that the page really is pinned.
+		 */
+		page_ref_add(page, refs);
 	}
=20
 	return true;
@@ -121,12 +167,17 @@ bool __must_check try_grab_page(struct page *page, un=
signed int flags)
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 static bool __unpin_devmap_managed_user_page(struct page *page)
 {
-	int count;
+	int count, refs =3D 1;
=20
 	if (!page_is_devmap_managed(page))
 		return false;
=20
-	count =3D page_ref_sub_return(page, GUP_PIN_COUNTING_BIAS);
+	if (hpage_pincount_available(page))
+		hpage_pincount_sub(page, 1);
+	else
+		refs =3D GUP_PIN_COUNTING_BIAS;
+
+	count =3D page_ref_sub_return(page, refs);
=20
 	/*
 	 * devmap page refcounts are 1-based, rather than 0-based: if
@@ -158,6 +209,8 @@ static bool __unpin_devmap_managed_user_page(struct pag=
e *page)
  */
 void unpin_user_page(struct page *page)
 {
+	int refs =3D 1;
+
 	page =3D compound_head(page);
=20
 	/*
@@ -169,7 +222,12 @@ void unpin_user_page(struct page *page)
 	if (__unpin_devmap_managed_user_page(page))
 		return;
=20
-	if (page_ref_sub_and_test(page, GUP_PIN_COUNTING_BIAS))
+	if (hpage_pincount_available(page))
+		hpage_pincount_sub(page, 1);
+	else
+		refs =3D GUP_PIN_COUNTING_BIAS;
+
+	if (page_ref_sub_and_test(page, refs))
 		__put_page(page);
 }
 EXPORT_SYMBOL(unpin_user_page);
@@ -2201,8 +2259,12 @@ static int record_subpages(struct page *page, unsign=
ed long addr,
=20
 static void put_compound_head(struct page *page, int refs, unsigned int fl=
ags)
 {
-	if (flags & FOLL_PIN)
-		refs *=3D GUP_PIN_COUNTING_BIAS;
+	if (flags & FOLL_PIN) {
+		if (hpage_pincount_available(page))
+			hpage_pincount_sub(page, refs);
+		else
+			refs *=3D GUP_PIN_COUNTING_BIAS;
+	}
=20
 	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 487e998fd38e..07059d936f7b 100644
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
--=20
2.25.0

