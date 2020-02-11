Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05AB1586AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgBKAQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:16:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18804 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBKAPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:15:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41f20f0003>; Mon, 10 Feb 2020 16:15:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 16:15:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 16:15:38 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 00:15:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Feb 2020 00:15:38 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41f22a0005>; Mon, 10 Feb 2020 16:15:38 -0800
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
Subject: [PATCH v6 08/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting
Date:   Mon, 10 Feb 2020 16:15:32 -0800
Message-ID: <20200211001536.1027652-9-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211001536.1027652-1-jhubbard@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581380111; bh=q6SvncpBlyZGDRETX5xIF7NC8rmMjZO5u/Y0sWHfDx0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=GNIioauGH7U01JbcMJlrEYQhUkarYPtsgwcKcQGwLGUkkjkXoBwxdGMwt44iwRSFa
         Qvye8l1n/lpyE1NvomQz9HfrQ4qL8hgTacND0edBvXh56tSvnzBn/NqqHBr+0OCCDh
         Vdxmbma+At8C7N+Gohqur1EbdGEySic151fMl59mbGM5vc1YlOV8dSwQ/2Edmb6qXj
         CVhAk4796oW/hUHpLlv0HiaEuQ6uJBHy0bIIHn3IB53fTWNcfVyDqv9UOjhr4dbMB8
         9IiasQt1GlwBjTX3T5Ixmw3fu3G4kcFM6OlvftM7j2bFLZnZE4Ol+n8Xa0INr0WgAj
         jNDjbKCKwae+A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that pages are "DMA-pinned" via pin_user_page*(), and unpinned via
unpin_user_pages*(), we need some visibility into whether all of this is
working correctly.

Add two new fields to /proc/vmstat:

    nr_foll_pin_acquired
    nr_foll_pin_released

These are documented in Documentation/core-api/pin_user_pages.rst.
They represent the number of pages (since boot time) that have been
pinned ("nr_foll_pin_acquired") and unpinned ("nr_foll_pin_released"),
via pin_user_pages*() and unpin_user_pages*().

In the absence of long-running DMA or RDMA operations that hold pages
pinned, the above two fields will normally be equal to each other.

Also: update Documentation/core-api/pin_user_pages.rst, to remove an
earlier (now confirmed untrue) claim about a performance problem with
/proc/vmstat.

Also: updated Documentation/core-api/pin_user_pages.rst to rename the
new /proc/vmstat entries, to the names listed here.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst | 33 +++++++++++++++++++----
 include/linux/mmzone.h                    |  2 ++
 mm/gup.c                                  | 13 +++++++++
 mm/vmstat.c                               |  2 ++
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 7e5dd8b1b3f2..5c8a5f89756b 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -208,12 +208,35 @@ has the following new calls to exercise the new pin*(=
) wrapper functions:
 You can monitor how many total dma-pinned pages have been acquired and rel=
eased
 since the system was booted, via two new /proc/vmstat entries: ::
=20
-    /proc/vmstat/nr_foll_pin_requested
-    /proc/vmstat/nr_foll_pin_requested
+    /proc/vmstat/nr_foll_pin_acquired
+    /proc/vmstat/nr_foll_pin_released
=20
-Those are both going to show zero, unless CONFIG_DEBUG_VM is set. This is
-because there is a noticeable performance drop in unpin_user_page(), when =
they
-are activated.
+Under normal conditions, these two values will be equal unless there are a=
ny
+long-term [R]DMA pins in place, or during pin/unpin transitions.
+
+* nr_foll_pin_acquired: This is the number of logical pins that have been
+  acquired since the system was powered on. For huge pages, the head page =
is
+  pinned once for each page (head page and each tail page) within the huge=
 page.
+  This follows the same sort of behavior that get_user_pages() uses for hu=
ge
+  pages: the head page is refcounted once for each tail or head page in th=
e huge
+  page, when get_user_pages() is applied to a huge page.
+
+* nr_foll_pin_released: The number of logical pins that have been released=
 since
+  the system was powered on. Note that pages are released (unpinned) on a
+  PAGE_SIZE granularity, even if the original pin was applied to a huge pa=
ge.
+  Becaused of the pin count behavior described above in "nr_foll_pin_acqui=
red",
+  the accounting balances out, so that after doing this::
+
+    pin_user_pages(huge_page);
+    for (each page in huge_page)
+        unpin_user_page(page);
+
+...the following is expected::
+
+    nr_foll_pin_released =3D=3D nr_foll_pin_acquired
+
+(...unless it was already out of balance due to a long-term RDMA pin being=
 in
+place.)
=20
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..4bca42eeb439 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -243,6 +243,8 @@ enum node_stat_item {
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
+	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
+	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
 	NR_VM_NODE_STAT_ITEMS
 };
=20
diff --git a/mm/gup.c b/mm/gup.c
index 4d0d94405639..441f7a48f370 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -86,6 +86,8 @@ static __maybe_unused struct page *try_grab_compound_head=
(struct page *page,
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
 	else if (flags & FOLL_PIN) {
+		int orig_refs =3D refs;
+
 		/*
 		 * When pinning a compound page of order > 1 (which is what
 		 * hpage_pincount_available() checks for), use an exact count to
@@ -104,6 +106,9 @@ static __maybe_unused struct page *try_grab_compound_he=
ad(struct page *page,
 		if (hpage_pincount_available(page))
 			hpage_pincount_add(page, refs);
=20
+		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
+				    orig_refs);
+
 		return page;
 	}
=20
@@ -158,6 +163,8 @@ bool __must_check try_grab_page(struct page *page, unsi=
gned int flags)
 		 * once, so that the page really is pinned.
 		 */
 		page_ref_add(page, refs);
+
+		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
 	}
=20
 	return true;
@@ -178,6 +185,7 @@ static bool __unpin_devmap_managed_user_page(struct pag=
e *page)
=20
 	count =3D page_ref_sub_return(page, refs);
=20
+	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
 	/*
 	 * devmap page refcounts are 1-based, rather than 0-based: if
 	 * refcount is 1, then the page is free and the refcount is
@@ -228,6 +236,8 @@ void unpin_user_page(struct page *page)
=20
 	if (page_ref_sub_and_test(page, refs))
 		__put_page(page);
+
+	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
 }
 EXPORT_SYMBOL(unpin_user_page);
=20
@@ -2259,6 +2269,9 @@ static int record_subpages(struct page *page, unsigne=
d long addr,
 static void put_compound_head(struct page *page, int refs, unsigned int fl=
ags)
 {
 	if (flags & FOLL_PIN) {
+		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
+				    refs);
+
 		if (hpage_pincount_available(page))
 			hpage_pincount_sub(page, refs);
 		else
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..c9c0d71f917f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1168,6 +1168,8 @@ const char * const vmstat_text[] =3D {
 	"nr_dirtied",
 	"nr_written",
 	"nr_kernel_misc_reclaimable",
+	"nr_foll_pin_acquired",
+	"nr_foll_pin_released",
=20
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
--=20
2.25.0

