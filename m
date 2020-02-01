Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870E114F643
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 04:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgBADlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 22:41:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11606 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgBADkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 22:40:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e34f3280000>; Fri, 31 Jan 2020 19:40:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jan 2020 19:40:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 Jan 2020 19:40:38 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 1 Feb
 2020 03:40:38 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 1 Feb 2020 03:40:37 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e34f3340002>; Fri, 31 Jan 2020 19:40:37 -0800
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
Subject: [PATCH v3 09/12] mm: dump_page(): better diagnostics for huge pinned pages
Date:   Fri, 31 Jan 2020 19:40:26 -0800
Message-ID: <20200201034029.4063170-10-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201034029.4063170-1-jhubbard@nvidia.com>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580528424; bh=k4Lbk4kPcODis1gm7X0/Em7BXZ40lVe6B2OXrxTo0YE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=CstSCBtaMdshz751Y+6zyEuqFPOdMiySa25N4tSA2A8xzcSnMUbrSM1nP1k8Jno6b
         r8e60UJQg8pMT+4iEDfYjRC7+J00rG0l9dJwTpeTlpZ40r1UwWubH8tl1rv4qABHxH
         MX81T4f1eAAnsYvG9LSjNSI26z/gcGbWWnmp8ZoVCsihWAUah2U7cRntKLM3ho3ihw
         5wi5y78PFBq5AVMJACBKrrJCl8javfHKonWrtBNqOk1JqVXe+xHcrMmVbLunOMa3SG
         zG04DwYY3PYXgCAhvc21H5mOl5XYeDy51sR0SoySoM6gIGwHlPNhcmxmXlQqI7JzMN
         ZRSB7m9kArOpg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As part of pin_user_pages() and related API calls, pages are
"dma-pinned". For the case of compound pages of order > 1, the per-page
accounting of dma pins is accomplished via the 3rd struct page in the
compound page. In order to support debugging of any pin_user_pages()-
related problems, enhance dump_page() so as to report the pin count
in that case.

Documentation/core-api/pin_user_pages.rst is also updated accordingly.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst |  7 +++++
 mm/debug.c                                | 34 +++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 3f72b1ea1104..dd21ea140ef4 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -215,6 +215,13 @@ Those are both going to show zero, unless CONFIG_DEBUG=
_VM is set. This is
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
diff --git a/mm/debug.c b/mm/debug.c
index beb1c59d784b..db81b11345be 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -57,10 +57,20 @@ static void __dump_tail_page(struct page *page, int map=
count)
 			page, page_ref_count(page), mapcount, page->mapping,
 			page_to_pgoff(page));
 	} else {
-		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount:%d\n",
-			page, page_ref_count(head), mapcount, head->mapping,
-			page_to_pgoff(head), compound_mapcount(page));
+		if (hpage_pincount_available(page))
+			pr_warn("page:%px compound refcount:%d mapcount:%d "
+				"mapping:%px index:%#lx compound_mapcount:%d "
+				"compound_pincount:%d\n",
+				page, page_ref_count(head), mapcount,
+				head->mapping, page_to_pgoff(head),
+				compound_mapcount(page),
+				compound_pincount(page));
+		else
+			pr_warn("page:%px compound refcount:%d mapcount:%d "
+				"mapping:%px index:%#lx compound_mapcount:%d\n",
+				page, page_ref_count(head), mapcount,
+				head->mapping, page_to_pgoff(head),
+				compound_mapcount(page));
 	}
=20
 	if (page_ref_count(page) !=3D 0)
@@ -103,10 +113,18 @@ void __dump_page(struct page *page, const char *reaso=
n)
=20
 	if (PageTail(page))
 		__dump_tail_page(page, mapcount);
-	else
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
-			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page));
+	else {
+		if (hpage_pincount_available(page))
+			pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
+				"index:%#lx compound pincount: %d\n",
+				page, page_ref_count(page), mapcount,
+				page->mapping, page_to_pgoff(page),
+				compound_pincount(page));
+		else
+			pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
+				"index:%#lx\n", page, page_ref_count(page),
+				mapcount, page->mapping, page_to_pgoff(page));
+	}
 	if (PageKsm(page))
 		type =3D "ksm ";
 	else if (PageAnon(page))
--=20
2.25.0

