Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434B9152322
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 00:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgBDXlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 18:41:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8895 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBDXlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:41:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3a00e80001>; Tue, 04 Feb 2020 15:40:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 15:41:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Feb 2020 15:41:21 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 23:41:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 23:41:21 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3a01200004>; Tue, 04 Feb 2020 15:41:20 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting
Date:   Tue, 4 Feb 2020 15:41:15 -0800
Message-ID: <20200204234117.2974687-11-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204234117.2974687-1-jhubbard@nvidia.com>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580859624; bh=+TDtnQkg7uwnmoIUAqlG+zsniSYAJC69/2Ds4cqxYaA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=rna/Xq/RB1uYHshiNFGeAlApzeanRpSAUCL0efopTkG6RYVIBGjflS/gchc2b2+h8
         m7YQBlgPnpkgQRCT0imNMb8fWonS57dfyryHq6U/hxUgpEKlyw+p9w9yepjgfx/N5h
         rR2EbJUZUtp915gxJHV2x99xQwLRwd4dzXnu8sk0S5D830TGAKF/Rz4euMH3B9ssHw
         fLTwtxi/XKQg3rrNiZqZuMgCRMegtlq3p5mq4py1S3bNCOwFboE+9smTsxV4mEBGRi
         xJ7b72q+ld8SVFU77eF/tGnF+mNMCIdP5fyNrbjlfUwqtZMkjqAWcHmSVzc2EFToYU
         gi58YQmPku+6Q==
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

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst |  8 ++------
 include/linux/mmzone.h                    |  2 ++
 mm/gup.c                                  | 10 ++++++++++
 mm/vmstat.c                               |  2 ++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index dd21ea140ef4..194204d74a50 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -208,12 +208,8 @@ has the following new calls to exercise the new pin*()=
 wrapper functions:
 You can monitor how many total dma-pinned pages have been acquired and rel=
eased
 since the system was booted, via two new /proc/vmstat entries: ::
=20
-    /proc/vmstat/nr_foll_pin_requested
-    /proc/vmstat/nr_foll_pin_requested
-
-Those are both going to show zero, unless CONFIG_DEBUG_VM is set. This is
-because there is a noticeable performance drop in unpin_user_page(), when =
they
-are activated.
+    /proc/vmstat/nr_foll_pin_acquired
+    /proc/vmstat/nr_foll_pin_released
=20
 Other diagnostics
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
index 4d0d94405639..7c543849181b 100644
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

