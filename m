Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2169915869D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBKAQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:16:22 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18843 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgBKAPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:15:42 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41f20f0000>; Mon, 10 Feb 2020 16:15:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 16:15:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 16:15:38 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 00:15:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Feb 2020 00:15:38 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41f22a0000>; Mon, 10 Feb 2020 16:15:38 -0800
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
Subject: [PATCH v6 05/12] mm/gup: require FOLL_GET for get_user_pages_fast()
Date:   Mon, 10 Feb 2020 16:15:29 -0800
Message-ID: <20200211001536.1027652-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211001536.1027652-1-jhubbard@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581380111; bh=zdKJN+80LnhrM42H0YcEzysuucpfBmwOwmXaeST0eWY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Mpur6ZMBupeWC2SNXq0wUmcX9Ko7EQzrTal6Y3ZQ6CehbCxBy+rdIRasw8uKh1QJC
         hfWDmIo+wLyXGIAA3dbh1mXMiSpzTWcpCD6X7gZHmlT3yecwaDbUt3o85rdWfo2vma
         Obp2fsy54SKRby9P08xYsQdg62wp84pVRw+A1YB8PuCIM/+UB1Jbx960KlkVbP+wpN
         pPzpGmpbuIwmijSTxspnTYllJwRqXhXhZtPLbtOa+wPPBIbtBhVcnrZpnPWYj4+MHd
         5NiKrkCK4dzRocdVO5k2GbxS7Kw/SWYMNq4QFTrXuqY1brY3Ab5XZntNosVw1a4sva
         3SHXyL4B9b1Cg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Internal to mm/gup.c, require that get_user_pages_fast()
and __get_user_pages_fast() identify themselves, by setting
FOLL_GET. This is required in order to be able to make decisions
based on "FOLL_PIN, or FOLL_GET, or both or neither are set", in
upcoming patches.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e5f75e886663..c8affbea2019 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2390,6 +2390,14 @@ int __get_user_pages_fast(unsigned long start, int n=
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
@@ -2415,7 +2423,7 @@ int __get_user_pages_fast(unsigned long start, int nr=
_pages, int write,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_save(flags);
-		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
+		gup_pgd_range(start, end, gup_flags, pages, &nr);
 		local_irq_restore(flags);
 	}
=20
@@ -2454,7 +2462,7 @@ static int internal_get_user_pages_fast(unsigned long=
 start, int nr_pages,
 	int nr =3D 0, ret =3D 0;
=20
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
-				       FOLL_FORCE | FOLL_PIN)))
+				       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
 		return -EINVAL;
=20
 	start =3D untagged_addr(start) & PAGE_MASK;
@@ -2521,6 +2529,13 @@ int get_user_pages_fast(unsigned long start, int nr_=
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
--=20
2.25.0

