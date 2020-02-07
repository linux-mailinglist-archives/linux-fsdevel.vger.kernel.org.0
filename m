Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013B415514D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBGDhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:37:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2970 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgBGDhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:37:37 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3cdb720000>; Thu, 06 Feb 2020 19:37:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 19:37:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Feb 2020 19:37:37 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 03:37:36 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 03:37:36 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3cdb800001>; Thu, 06 Feb 2020 19:37:36 -0800
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
Subject: [PATCH v5 01/12] mm: dump_page(): better diagnostics for compound pages
Date:   Thu, 6 Feb 2020 19:37:24 -0800
Message-ID: <20200207033735.308000-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207033735.308000-1-jhubbard@nvidia.com>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581046642; bh=JHbFoVlby1O2Fi0YWtwHfwC9UdnPi6RlItOvHznb5y0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ejg6TBDMQadq3V8m4zpmpBWDvyla1Cwb+Pz7xP8Sy2K+XjBjA9AL5+bGG3OlOUGYc
         6vCxNALEG82PF88QxORGXRoa9GKsm+Pv0WCv2l57EGB1Cdf4r4W5ErzwGKvw16H0hj
         JF98EdTNU/tVRevEDqZgBeD0h1Tzz51zyM+zD2+tf+9uSPSEiWjT281tJ21tcZ62xW
         fvBTfsDCics41w6Y8J1oOEJiOGsCSe3spIH8o6LSVtrn5GpI3x9eKgNpVf3azkJzXk
         uCNgz1Pn1Qaz0tLcWL3r0WTWW5ioZi19i7XFLTbVHgSwL1wCR5HLWzBRIYzWd8AwKK
         UpXznRe1xXEzA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A compound page collects the refcount in the head page, while leaving
the refcount of each tail page at zero. Therefore, when debugging a
problem that involves compound pages, it's best to have diagnostics that
reflect that situation. However, dump_page() is oblivious to these
points.

Change dump_page() as follows:

1) For tail pages, print relevant head page information: refcount, in
   particular. But only do this if the page is not corrupted so badly
   that the pointer to the head page is all wrong.

2) Do a separate check to catch any (rare) cases of the tail page's
   refcount being non-zero, and issue a separate, clear pr_warn() if
   that ever happens.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/debug.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index ecccd9f17801..f074077eee11 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,6 +42,33 @@ const struct trace_print_flags vmaflag_names[] =3D {
 	{0, NULL}
 };
=20
+static void __dump_tail_page(struct page *page, int mapcount)
+{
+	struct page *head =3D compound_head(page);
+
+	if ((page < head) || (page >=3D head + MAX_ORDER_NR_PAGES)) {
+		/*
+		 * Page is hopelessly corrupted, so limit any reporting to
+		 * information about the page itself. Do not attempt to look at
+		 * the head page.
+		 */
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
+			"index:%#lx (corrupted tail page case)\n",
+			page, page_ref_count(page), mapcount, page->mapping,
+			page_to_pgoff(page));
+	} else {
+		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
+			"index:%#lx compound_mapcount:%d\n",
+			page, page_ref_count(head), mapcount, head->mapping,
+			page_to_pgoff(head), compound_mapcount(page));
+	}
+
+	if (page_ref_count(page) !=3D 0) {
+		pr_warn("page:%px PROBLEM: non-zero refcount (=3D=3D%d) on this "
+			"tail page\n", page, page_ref_count(page));
+	}
+}
+
 void __dump_page(struct page *page, const char *reason)
 {
 	struct address_space *mapping;
@@ -75,12 +102,8 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
=20
-	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page),
-			compound_mapcount(page));
+	if (PageTail(page))
+		__dump_tail_page(page, mapcount);
 	else
 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
 			page, page_ref_count(page), mapcount,
--=20
2.25.0

