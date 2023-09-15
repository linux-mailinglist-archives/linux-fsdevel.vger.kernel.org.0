Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC77A1B4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjIOJyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjIOJyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:12 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AA430C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:52:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095130euoutp02b86978f3821052c089a99bece6e4690b~FCbDj0xF91204812048euoutp02I
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230915095130euoutp02b86978f3821052c089a99bece6e4690b~FCbDj0xF91204812048euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771490;
        bh=N6Xp9rRcJyqLlmISFymB45Rbo8znf7lO4hyxQ746apU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=J2oiuKF9izy/Cw4x6EnydyqbwSzsnCF2Y0XFOnQ8IlWbu28IVYZHWP6sXeY3XHfUG
         193Msihdm4oTg6/gkV33eD2KXYpN7XwTFksMmuEQWDUGFpWSGXCnEyBLb6rHhGaAJB
         IPHcHFtFpDvNNNWfqxWRKhZ64MxGq4FRAnOOVXYc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230915095129eucas1p185187ba8793eb2c506b0e568c0f6f608~FCbDBzwkA1980119801eucas1p1L;
        Fri, 15 Sep 2023 09:51:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.BC.37758.12924056; Fri, 15
        Sep 2023 10:51:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230915095129eucas1p1383d75c6d62056afbb20b78a3ec15234~FCbCnzYvG2007620076eucas1p1P;
        Fri, 15 Sep 2023 09:51:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230915095129eusmtrp2e690b2af500d4bb298bad715c8e8eb8f~FCbCmH9Ln1712217122eusmtrp24;
        Fri, 15 Sep 2023 09:51:29 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-7b-650429212abc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 65.3B.10549.02924056; Fri, 15
        Sep 2023 10:51:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230915095128eusmtip1ea983b58b5ef15df525d8a7f9a3c571b~FCbCaAFBw2687926879eusmtip19;
        Fri, 15 Sep 2023 09:51:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:28 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:28 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 4/6] shmem: add order parameter support to shmem_alloc_folio
Thread-Topic: [PATCH 4/6] shmem: add order parameter support to
        shmem_alloc_folio
Thread-Index: AQHZ57oyL8hoyYlY0kqz+yQTJH6NwQ==
Date:   Fri, 15 Sep 2023 09:51:28 +0000
Message-ID: <20230915095042.1320180-5-da.gomez@samsung.com>
In-Reply-To: <20230915095042.1320180-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7qKmiypBi87ZS3mrF/DZrH6bj+b
        xeUnfBZPP/WxWOy9pW2xZ+9JFovLu+awWdxb85/VYtefHewWNyY8ZbRY9vU9u8XujYvYLH7/
        mMPmwOsxu+Eii8eCTaUem1doeVw+W+qxaVUnm8emT5PYPU7M+M3i8XmTXABHFJdNSmpOZllq
        kb5dAlfGkdfvGQt6ZSqmnJ3G3MD4QKyLkZNDQsBEoudyA2sXIxeHkMAKRonGjxuhnC+MEntX
        3IZyPjNKvGw/xNLFyAHWsvahF0i3kMByRonVG9XgalZvu8AO4ZxhlHh9/ysjhLOSUeLUhtnM
        IC1sApoS+05uAqsSEZjNKnF4cQcjSIJZoE5izbNZLCC2sICPxNQ5W8HiIgLBEqd/zmCHsPUk
        3u3vBBvEIqAq8XzSCzYQm1fAWuLKzfOsIOdxCthIvP9RDhJmFJCVeLTyFzvEeHGJW0/mM0E8
        LSixaPYeZghbTOLfrodsELaOxNnrTxghbAOJrUv3sUDYShJ/OhZCnakncWPqFDYIW1ti2cLX
        zBAnCEqcnPmEBeQvCYEmLomWJyegweUiseZbBcQcYYlXx7ewQ9gyEv93zmeawKg9C8l5s5Cs
        mIVkxSwkKxYwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGyn/x3/uoNxxauPeocY
        mTgYDzFKcDArifCy2TKlCvGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBa
        BJNl4uCUamBqvxLYGpBlG/8n+jf31Y0v/oWkfVHb+1zWLix+zt9awaJza5IunrfRa2MxOrIu
        NCbshnVIcopW05Mwk/ULxN8c9eaXL5/PfTG+dy8bZ+xjpqfzHq3xOcoxz8NBNGjy+ROrlYKj
        N3N+mPxP29BHcLd0t9nXGSdy181rnOP+9MfJjyt0hZI83h4M07qtZqvHdeMsY/Cvrl8fPDfZ
        7b6+9FIoz1lXnVtl/3arp/EZrudZ92y6nY6bifXy2bfSiuc46iy8oOvH/2znfL6EGpbJvz9G
        Z6fyd0W+vnnGmWchf53ZGrU7Gxi+fDuxu+0RS/DX+eHawR63jlic0/2aM+X0mutr+0NeTnky
        LcpV9RE3t1ylEktxRqKhFnNRcSIAXVcr29sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsVy+t/xu7oKmiypBgd32FjMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MI6/fMxb0ylRMOTuN
        uYHxgVgXIweHhICJxNqHXl2MnBxCAksZJc5c8wOxJQRkJDZ+ucoKYQtL/LnWxdbFyAVU85FR
        4tHsqawQDWcYJd7tF4VIrGSUONg/kRkkwSagKbHv5CZ2kISIwGxWicOLOxhBEswCdRJrns1i
        AbGFBXwkps7ZChYXEQiWOHH2BRuErQc0tBNsEIuAqsTzSRBxXgFriSs3z7OCXC0EZM+a7gVi
        cgrYSLz/UQ5SwSggK/Fo5S92iE3iEreezGeCeEBAYsme88wQtqjEy8f/oB7TkTh7/QkjhG0g
        sXXpPhYIW0niT8dCqIv1JG5MncIGYWtLLFv4mhniGkGJkzOfsExglJ6FZN0sJC2zkLTMQtKy
        gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBi2nbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE
        l82WKVWINyWxsiq1KD++qDQntfgQoykwhCYyS4km5wNTY15JvKGZgamhiZmlgamlmbGSOK9n
        QUeikEB6YklqdmpqQWoRTB8TB6dUA1PKbM6D9f0BZ1tvlSc+uKf93eREg1OWxM9HLfd2ff5X
        692x+1zQs4gbIkV35iSpRl58e6ZuZqRhy7dNr4I8sw/ElVd9un059l1IQF390itNZq47tnxX
        Uv0jM2HLD+svel6GX+9VuzbbHWwWElVjsLXgeO16PUZsl+7ZiOILsb9ur0qxsDAWqFx1Ls/D
        2/pxS+HH8mMOl31dOkpX+f57b1+7pmrvZ+2TIVNVrFwfKIo8+8Vaoxu1c4Pjp2ClHae1uz2n
        +1XdP+KZy1scpHv5UeCeoIvBM3/t2Dbnpq7R9oOTfAUeLHe/uYbVfPoXqxObOedtv7Vi5q63
        q236YpeeYLm98UbPTJUwkZ/+b8xvnJ+vxFKckWioxVxUnAgAlvTUeNUDAAA=
X-CMS-MailID: 20230915095129eucas1p1383d75c6d62056afbb20b78a3ec15234
X-Msg-Generator: CA
X-RootMTR: 20230915095129eucas1p1383d75c6d62056afbb20b78a3ec15234
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095129eucas1p1383d75c6d62056afbb20b78a3ec15234
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095129eucas1p1383d75c6d62056afbb20b78a3ec15234@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for high order folio support for the write path, add
order parameter when allocating a folio. This is on the write path
when huge support is not enabled or when it is but the huge page
allocation fails, the fallback will take advantage of this too.

Use order 0 for the non write paths such as reads or swap in as these
currently lack high order folios support.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 836d44584796..ee297d8874d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1669,20 +1669,21 @@ static struct folio *shmem_alloc_hugefolio(gfp_t gf=
p,
 }
=20
 static struct folio *shmem_alloc_folio(gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
+			struct shmem_inode_info *info, pgoff_t index,
+			unsigned int order)
 {
 	struct vm_area_struct pvma;
 	struct folio *folio;
=20
 	shmem_pseudo_vma_init(&pvma, info, index);
-	folio =3D vma_alloc_folio(gfp, 0, &pvma, 0, false);
+	folio =3D vma_alloc_folio(gfp, order, &pvma, 0, false);
 	shmem_pseudo_vma_destroy(&pvma);
=20
 	return folio;
 }
=20
 static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *i=
node,
-		pgoff_t index, bool huge)
+		pgoff_t index, bool huge, unsigned int *order)
 {
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
 	struct folio *folio;
@@ -1691,7 +1692,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t=
 gfp, struct inode *inode,
=20
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge =3D false;
-	nr =3D huge ? HPAGE_PMD_NR : 1;
+	nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
=20
 	err =3D shmem_inode_acct_block(inode, nr);
 	if (err)
@@ -1700,7 +1701,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t=
 gfp, struct inode *inode,
 	if (huge)
 		folio =3D shmem_alloc_hugefolio(gfp, info, index);
 	else
-		folio =3D shmem_alloc_folio(gfp, info, index);
+		folio =3D shmem_alloc_folio(gfp, info, index, *order);
 	if (folio) {
 		__folio_set_locked(folio);
 		__folio_set_swapbacked(folio);
@@ -1750,7 +1751,7 @@ static int shmem_replace_folio(struct folio **foliop,=
 gfp_t gfp,
 	 */
 	gfp &=3D ~GFP_CONSTRAINT_MASK;
 	VM_BUG_ON_FOLIO(folio_test_large(old), old);
-	new =3D shmem_alloc_folio(gfp, info, index);
+	new =3D shmem_alloc_folio(gfp, info, index, 0);
 	if (!new)
 		return -ENOMEM;
=20
@@ -1961,6 +1962,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 	int error;
 	int once =3D 0;
 	int alloced =3D 0;
+	unsigned int order =3D 0;
=20
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
@@ -2036,10 +2038,12 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
=20
 	huge_gfp =3D vma_thp_gfp_mask(vma);
 	huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
-	folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, true);
+	folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, true,
+					   &order);
 	if (IS_ERR(folio)) {
 alloc_nohuge:
-		folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, false);
+		folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, false,
+						   &order);
 	}
 	if (IS_ERR(folio)) {
 		int retry =3D 5;
@@ -2602,7 +2606,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
=20
 	if (!*foliop) {
 		ret =3D -ENOMEM;
-		folio =3D shmem_alloc_folio(gfp, info, pgoff);
+		folio =3D shmem_alloc_folio(gfp, info, pgoff, 0);
 		if (!folio)
 			goto out_unacct_blocks;
=20
--=20
2.39.2
