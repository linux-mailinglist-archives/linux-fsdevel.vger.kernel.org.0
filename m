Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390A014C4F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 04:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgA2DYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 22:24:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6362 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgA2DYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:24:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e30fab10001>; Tue, 28 Jan 2020 19:23:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 19:24:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Jan 2020 19:24:19 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 03:24:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 Jan 2020 03:24:19 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e30fae20004>; Tue, 28 Jan 2020 19:24:18 -0800
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
Subject: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for compound pages
Date:   Tue, 28 Jan 2020 19:24:10 -0800
Message-ID: <20200129032417.3085670-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129032417.3085670-1-jhubbard@nvidia.com>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580268209; bh=P1TeODLKtRur5z7N4mKfBv38jAYvtdOaySoL8r08WIg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=E3c5QEyGx95NN96IE5SjKIfekR44Kiz+3iLIw4qlBA+LpbSooYT0An9LHX6XD6yl4
         7lXKNT/kQg8YCcnJmYPOse8qK2L5jU8GMbzDsJ5WhQhpVzoarZvejOPeDSNh67wMcQ
         hhPTwYPCvGm+OytsPAfw0evq9Lg0XgniczwV2eLW6M6FblnpHUvbCcwtJzhu2nPfuq
         KZMCTpM8R/TZXtYInxwDY4PQVS0KggBcsXut4esMIK1IpOqrkG0AFWn1oyIHFG6HgV
         oVgZsqQFU53ImQs7VGD18/+8URzEUhFO6Z663+sFH9Q7FNr95JNFeu5iWQeAs6fJV+
         IyukOqyF+pdQg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When debugging a problem that involves compound pages, it is extremely
helpful if dump_page() reports not only the page->_refcount, but also
the refcount of the head page of the compound page. That's because the
head page collects refcounts for the entire compound page.

Therefore, enhance dump_page() so as to print out the refcount of the
head page of a compound page.

This approach (printing information about a struct page that is not the
struct page that was passed into dump_page()) has a precedent:
compound_mapcount is already being printed.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index a90da5337c14..4cc6cad8385d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -76,9 +76,11 @@ void __dump_page(struct page *page, const char *reason)
 	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
=20
 	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
+		pr_warn("page:%px refcount:%d head refcount:%d "
+			"mapcount:%d mapping:%px index:%#lx "
+			"compound_mapcount:%d\n",
+			page, page_ref_count(page),
+			page_ref_count(compound_head(page)), mapcount,
 			page->mapping, page_to_pgoff(page),
 			compound_mapcount(page));
 	else
--=20
2.25.0

