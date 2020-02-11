Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3352B158699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBKAQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:16:11 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4287 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgBKAPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:15:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41f1ec0001>; Mon, 10 Feb 2020 16:14:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 16:15:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 16:15:39 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 00:15:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Feb 2020 00:15:38 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41f22a000a>; Mon, 10 Feb 2020 16:15:38 -0800
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
Subject: [PATCH v6 11/12] mm: Improve dump_page() for compound pages
Date:   Mon, 10 Feb 2020 16:15:35 -0800
Message-ID: <20200211001536.1027652-12-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211001536.1027652-1-jhubbard@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581380076; bh=OEd2wPZ0nio0/lMg6Wc3iY7JuP/KkGjSqYpxktig1Bk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=b15JXq87UAwu5VDwVtaVlAZHpsbrY71cOtbd87znRSNsi+QhDasuq+HujoeSnOHil
         sSJtrrq5xr1FhdJtwuTQBJkyOew05X2gqH8Q4FinkFhlZLS+j7Re2uBprDM6UTFy9C
         UuKvN2twgVHCBUXeaEDMg5kKmnj7tm6zznf5uTMTir7KdJf1ynO4MozSrzYrDDvoGn
         qxpyFpXsIINwbk4VYAhIuMRpAx27V8jZkC/114TCHUZo/SJVzsU2bMMW9uwxUs9Afy
         ihfXORlYfsw9/mPfhSM9oBxpxvEXlawNsmlqi6J7gTxIUe/JZWI4U7+nT7q7y38awr
         nxBU8rmxhMKqg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

There was no protection against a corrupted struct page having an
implausible compound_head().  Sanity check that a compound page has
a head within reach of the maximum allocatable page (this will need
to be adjusted if one of the plans to allocate 1GB pages comes to
fruition).  In addition,

 - Print the mapping pointer using %p insted of %px.  The actual value of
   the pointer can be read out of the raw page dump and using %p gives a
   chance to correlate it with an earlier printk of the mapping pointer
 - Print the mapping pointer from the head page, not the tail page
   (the tail ->mapping pointer may be in use for other purposes, eg part
   of a list_head)
 - Print the order of the page for compound pages
 - Dump the raw head page as well as the raw page
 - Print the refcount from the head page, not the tail page

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/debug.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index ecccd9f17801..f5ffb0784559 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -44,8 +44,10 @@ const struct trace_print_flags vmaflag_names[] =3D {
=20
 void __dump_page(struct page *page, const char *reason)
 {
+	struct page *head =3D compound_head(page);
 	struct address_space *mapping;
 	bool page_poisoned =3D PagePoisoned(page);
+	bool compound =3D PageCompound(page);
 	/*
 	 * Accessing the pageblock without the zone lock. It could change to
 	 * "isolate" again in the meantime, but since we are just dumping the
@@ -66,25 +68,32 @@ void __dump_page(struct page *page, const char *reason)
 		goto hex_only;
 	}
=20
-	mapping =3D page_mapping(page);
+	if (page < head || (page >=3D head + MAX_ORDER_NR_PAGES)) {
+		/* Corrupt page, cannot call page_mapping */
+		mapping =3D page->mapping;
+		head =3D page;
+		compound =3D false;
+	} else {
+		mapping =3D page_mapping(page);
+	}
=20
 	/*
 	 * Avoid VM_BUG_ON() in page_mapcount().
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
+	mapcount =3D PageSlab(head) ? 0 : page_mapcount(page);
=20
-	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page),
-			compound_mapcount(page));
+	if (compound)
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
+			"index:%#lx head:%px order:%u compound_mapcount:%d\n",
+			page, page_ref_count(head), mapcount,
+			mapping, page_to_pgoff(page), head,
+			compound_order(head), compound_mapcount(page));
 	else
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
 			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page));
+			mapping, page_to_pgoff(page));
 	if (PageKsm(page))
 		type =3D "ksm ";
 	else if (PageAnon(page))
@@ -106,6 +115,10 @@ void __dump_page(struct page *page, const char *reason=
)
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
+	if (head !=3D page)
+		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
+			sizeof(unsigned long), head,
+			sizeof(struct page), false);
=20
 	if (reason)
 		pr_warn("page dumped because: %s\n", reason);
--=20
2.25.0

