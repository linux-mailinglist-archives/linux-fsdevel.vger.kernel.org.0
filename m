Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF39015868E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBKAQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:16:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4306 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBKAPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:15:43 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41f1ec0003>; Mon, 10 Feb 2020 16:14:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 16:15:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 16:15:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 00:15:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Feb 2020 00:15:39 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41f22a000b>; Mon, 10 Feb 2020 16:15:38 -0800
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
Subject: [PATCH v6 12/12] mm: dump_page(): additional diagnostics for huge pinned pages
Date:   Mon, 10 Feb 2020 16:15:36 -0800
Message-ID: <20200211001536.1027652-13-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211001536.1027652-1-jhubbard@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581380076; bh=G6zg3dRvhO6eAf8mbf4UXoagNxuHvI4R2GOif2CoQS4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Cd1yfw1/9CzPbKF6OSrgzdmEliYQ3R0HZd3+GQjeV4c0D3J3OusAurjqoXn7uEWpl
         +LmNHWyGx0F8fXhtaLdXTzZvppVpddmCFnj+rmtLp5kgyxnI/MRZG5guKgEpyIlCqa
         mmaobcG/RqaV4u3zFUiQKpqT8crsGJWtsPE3i/YQoXDv+emdSSOIa9yEjzPQKVbB1e
         ZAtnLutXaqXjnpGVwBAbX7eo+vSKYDKCiDBJFT7/rRfE3V8StQpOM+cz/B00Y7d5vV
         XHlNCGaY8lwO5FkrbQBa+LBxF1OvpglLDXXeV58ipgmai6fx3Q6Poed18DHTkyzAv9
         5Q0c80gnKiDgA==
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

Cc: Jan Kara <jack@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst |  7 +++++++
 mm/debug.c                                | 21 ++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 5c8a5f89756b..2e939ff10b86 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -238,6 +238,13 @@ long-term [R]DMA pins in place, or during pin/unpin tr=
ansitions.
 (...unless it was already out of balance due to a long-term RDMA pin being=
 in
 place.)
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
index f5ffb0784559..2189357f0987 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -85,11 +85,22 @@ void __dump_page(struct page *page, const char *reason)
 	mapcount =3D PageSlab(head) ? 0 : page_mapcount(page);
=20
 	if (compound)
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
-			"index:%#lx head:%px order:%u compound_mapcount:%d\n",
-			page, page_ref_count(head), mapcount,
-			mapping, page_to_pgoff(page), head,
-			compound_order(head), compound_mapcount(page));
+		if (hpage_pincount_available(page)) {
+			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
+				"index:%#lx head:%px order:%u "
+				"compound_mapcount:%d compound_pincount:%d\n",
+				page, page_ref_count(head), mapcount,
+				mapping, page_to_pgoff(page), head,
+				compound_order(head), compound_mapcount(page),
+				compound_pincount(page));
+		} else {
+			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
+				"index:%#lx head:%px order:%u "
+				"compound_mapcount:%d\n",
+				page, page_ref_count(head), mapcount,
+				mapping, page_to_pgoff(page), head,
+				compound_order(head), compound_mapcount(page));
+		}
 	else
 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
 			page, page_ref_count(page), mapcount,
--=20
2.25.0

