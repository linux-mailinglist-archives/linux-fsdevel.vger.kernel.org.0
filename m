Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2358815510C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBGDhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:37:40 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13345 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgBGDhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:37:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3cdb680003>; Thu, 06 Feb 2020 19:37:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 19:37:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Feb 2020 19:37:37 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 03:37:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 03:37:37 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3cdb800008>; Thu, 06 Feb 2020 19:37:36 -0800
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
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v5 06/12] mm/gup: require FOLL_GET for get_user_pages_fast()
Date:   Thu, 6 Feb 2020 19:37:29 -0800
Message-ID: <20200207033735.308000-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207033735.308000-1-jhubbard@nvidia.com>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581046633; bh=zdKJN+80LnhrM42H0YcEzysuucpfBmwOwmXaeST0eWY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=BCVsa9Vg/FLx131VkBwVusgApBWD3rXCMU4HwFYgqK+JHpePFTfpxlV7oG9uqvwoD
         eFInmWS/uaWR2xl9VFdCBWhGrmcdqU43SUDY+MjXrnqfaP1+yCtpfUdgqU2hzEGK3j
         OMpaRT/Yiw0G3m/vV1RCf5Xl1oK5n4Q587r5K2jjOC9vErW93juZY6sOFBaqP+MZok
         7EdA7Ui/FblkaCwg16abHqUYqltQJA7CKenmPCbrJteRfvVY/d+b5anez4HgL/09d9
         yLGxVuVVc7GjMkopOFdmOp6vT2zV+F4i1Lx9L2gWpSQfJxkLl+Xmb7ViCvcDclCSnF
         xK8ZrUQ/PlMtQ==
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

