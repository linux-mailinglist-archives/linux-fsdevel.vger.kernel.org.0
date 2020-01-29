Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B066A14C4E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgA2DYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 22:24:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6376 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgA2DYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:24:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e30fab10002>; Tue, 28 Jan 2020 19:23:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 19:24:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jan 2020 19:24:19 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 03:24:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 Jan 2020 03:24:19 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e30fae30005>; Tue, 28 Jan 2020 19:24:19 -0800
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
Subject: [PATCH v2 6/8] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting
Date:   Tue, 28 Jan 2020 19:24:15 -0800
Message-ID: <20200129032417.3085670-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129032417.3085670-1-jhubbard@nvidia.com>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580268209; bh=BR5qP9yDgHwmms8MxoALGGT7QIGUZw1rw8GRkZlTQFY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=nFQ9T3Plvdjga7ESszH/TTmMo2dq9KemHTy4oyIwG8+mvuav1sSzZUU/CsVXO4uqG
         xkK+Vv/udS+xWFaIRVTPRPOgGf9tkLA4daR3jYi+DP2gmM4KMSAbCCoxgtWaRj8SH3
         18WhbdSSVXcEK3zKvhuJ7r7VmmtKXQiwxhH9DLVtq6gWvoywUyWMAZL0+YqPc1aFvS
         P/5XuBVdYY+mtxW1M76o3X94bBDVHmHDP/UDbppjRR3Zhgt/271ttfPSByDWBzvTTb
         HpM82D+sICghg9fJ7ITMwpRDyJYrjdts4MLkUgkFYxUFDTKGSeEXW55Efux6DpldqY
         nBB3Ijr9uKFlw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that pages are "DMA-pinned" via pin_user_page*(), and unpinned via
unpin_user_pages*(), we need some visibility into whether all of this is
working correctly.

Add two new fields to /proc/vmstat:

    nr_foll_pin_requested
    nr_foll_pin_returned

These are documented in Documentation/core-api/pin_user_pages.rst.
They represent the number of pages (since boot time) that have been
pinned ("nr_foll_pin_requested") and unpinned ("nr_foll_pin_returned"),
via pin_user_pages*() and unpin_user_pages*().

In the absence of long-running DMA or RDMA operations that hold pages
pinned, the above two fields will normally be equal to each other.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mmzone.h |  2 ++
 mm/gup.c               | 21 +++++++++++++++++++++
 mm/vmstat.c            |  2 ++
 3 files changed, 25 insertions(+)

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
diff --git a/mm/gup.c b/mm/gup.c
index 03e7a5cfa6a9..d536bda383c4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,6 +29,19 @@ struct follow_page_context {
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
 static void hpage_pincount_add(struct page *page, int refs)
 {
 	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
@@ -86,6 +99,8 @@ static __maybe_unused struct page *try_grab_compound_head=
(struct page *page,
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
 	else if (flags & FOLL_PIN) {
+		int orig_refs =3D refs;
+
 		/*
 		 * When pinning a compound page of order > 1 (which is what
 		 * hpage_pincount_available() checks for), use an exact count to
@@ -104,6 +119,7 @@ static __maybe_unused struct page *try_grab_compound_he=
ad(struct page *page,
 		if (hpage_pincount_available(page))
 			hpage_pincount_add(page, refs);
=20
+		__update_proc_vmstat(page, NR_FOLL_PIN_REQUESTED, orig_refs);
 		return page;
 	}
=20
@@ -159,6 +175,8 @@ bool __must_check try_grab_page(struct page *page, unsi=
gned int flags)
 		 * once, so that the page really is pinned.
 		 */
 		page_ref_add(page, refs);
+
+		__update_proc_vmstat(page, NR_FOLL_PIN_REQUESTED, 1);
 	}
=20
 	return true;
@@ -179,6 +197,7 @@ static bool __unpin_devmap_managed_user_page(struct pag=
e *page)
=20
 	count =3D page_ref_sub_return(page, refs);
=20
+	__update_proc_vmstat(page, NR_FOLL_PIN_RETURNED, 1);
 	/*
 	 * devmap page refcounts are 1-based, rather than 0-based: if
 	 * refcount is 1, then the page is free and the refcount is
@@ -229,6 +248,8 @@ void unpin_user_page(struct page *page)
=20
 	if (page_ref_sub_and_test(page, refs))
 		__put_page(page);
+
+	__update_proc_vmstat(page, NR_FOLL_PIN_RETURNED, 1);
 }
 EXPORT_SYMBOL(unpin_user_page);
=20
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

