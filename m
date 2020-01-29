Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7803414C4FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 04:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgA2DYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 22:24:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17856 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgA2DYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:24:20 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e30fad50001>; Tue, 28 Jan 2020 19:24:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 19:24:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Jan 2020 19:24:19 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 03:24:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 Jan 2020 03:24:19 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e30fae30000>; Tue, 28 Jan 2020 19:24:19 -0800
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
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 3/8] mm/gup: pass a flags arg to __gup_device_* functions
Date:   Tue, 28 Jan 2020 19:24:12 -0800
Message-ID: <20200129032417.3085670-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129032417.3085670-1-jhubbard@nvidia.com>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580268245; bh=4jp0QhymG3IBZ2UdWKCHIHfGSO5gi4QtwHm0dzK8Ubk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=dIdd/4I37fBknkQablXBtLM78TVO5M8tfksUiIeJqh6sECEvBwy9g/If56u8KHnoR
         5S6VIticwZFAPD0MMSWWOnyKvxqPE0A3Nkxv46D8zTNZ6hf7msHPDvgoxfFGaCRITn
         fsO9EdWCjJfUjP53JSRwcQN939LyT92HSwtBJjnjB57jjOMo17+6u/fJOYKpb03bYd
         Qx+nTX9YZewOqUl5B2Ra8zhcgq21pvEbsQ0rInKRqnytB1ZO78PPoHC2PaPGm5u8f8
         NcKggXL1i1ymyTtnsTJrBbk6yHLeEZQoWRtU9WaoUpkX/FAufJgmyv7T3Dlrpm3Wk/
         kMIG/Vf9QZkxA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A subsequent patch requires access to gup flags, so pass the flags
argument through to the __gup_device_* functions.

Also placate checkpatch.pl by shortening a nearby line.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b699500da077..9e117998274c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1963,7 +1963,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long add=
r, unsigned long end,
=20
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGE=
PAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+			     unsigned long end, unsigned int flags,
+			     struct page **pages, int *nr)
 {
 	int nr_start =3D *nr;
 	struct dev_pagemap *pgmap =3D NULL;
@@ -1989,13 +1990,14 @@ static int __gup_device_huge(unsigned long pfn, uns=
igned long addr,
 }
=20
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long ad=
dr,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
 	int nr_start =3D *nr;
=20
 	fault_pfn =3D pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
=20
 	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
@@ -2006,13 +2008,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t =
*pmdp, unsigned long addr,
 }
=20
 static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long ad=
dr,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
 	int nr_start =3D *nr;
=20
 	fault_pfn =3D pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
=20
 	if (unlikely(pud_val(orig) !=3D pud_val(*pudp))) {
@@ -2023,14 +2026,16 @@ static int __gup_device_huge_pud(pud_t orig, pud_t =
*pudp, unsigned long addr,
 }
 #else
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long ad=
dr,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	BUILD_BUG();
 	return 0;
 }
=20
 static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long add=
r,
-		unsigned long end, struct page **pages, int *nr)
+				 unsigned long end, unsigned int flags,
+				 struct page **pages, int *nr)
 {
 	BUILD_BUG();
 	return 0;
@@ -2146,7 +2151,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsi=
gned long addr,
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
+		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
+					     pages, nr);
 	}
=20
 	page =3D pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -2167,7 +2173,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsi=
gned long addr,
 }
=20
 static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages, int *nr)
+			unsigned long end, unsigned int flags,
+			struct page **pages, int *nr)
 {
 	struct page *head, *page;
 	int refs;
@@ -2178,7 +2185,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsi=
gned long addr,
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
+		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
+					     pages, nr);
 	}
=20
 	page =3D pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
--=20
2.25.0

