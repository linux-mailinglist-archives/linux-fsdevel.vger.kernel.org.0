Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C27A65E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjISN4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjISN4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB713187
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135553euoutp024c2100f48e825066d800931b4f05a5c9~GUVkzg7zO1711517115euoutp02E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230919135553euoutp024c2100f48e825066d800931b4f05a5c9~GUVkzg7zO1711517115euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131753;
        bh=j5/WuYRozdtOAgqCuDPHuq7YO9f8GU76Eza03ZT/hH0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Nuk+vBjmOh37sbt6+cadKZVS5pDdzpixYn6VfaHIUcxAPCiEoA5HyMHU16U4AXzlS
         uAY13cUs5iF3t9vzP0Wwptp6v7rcHcS1QS4p2z9CuSenJGbi8FP5xvy52tPDOa5C+A
         HquMNJPl6Mp5dXIMgriwdNYppSWors5aDVdkPq2A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919135552eucas1p24dc412b1eadbba23c9d14f70df03b1ac~GUVkXHo8C1636016360eucas1p2s;
        Tue, 19 Sep 2023 13:55:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C5.8E.11320.868A9056; Tue, 19
        Sep 2023 14:55:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135552eucas1p11e19cd339078c2e0b788b52fae46e7c9~GUVj9gkvl1092210922eucas1p1Q;
        Tue, 19 Sep 2023 13:55:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919135552eusmtrp1594d9a0d3fd5111d702d62a93bc6f02d~GUVj8zkSl2614026140eusmtrp1G;
        Tue, 19 Sep 2023 13:55:52 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-ca-6509a868e751
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.C9.10549.868A9056; Tue, 19
        Sep 2023 14:55:52 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135552eusmtip105fc41d27402e30d4f75b71c970cf4f9~GUVjooqQg1607416074eusmtip1K;
        Tue, 19 Sep 2023 13:55:52 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:55:51 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:51 +0100
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
Subject: [PATCH v2 4/6] shmem: add order parameter support to
 shmem_alloc_folio
Thread-Topic: [PATCH v2 4/6] shmem: add order parameter support to
        shmem_alloc_folio
Thread-Index: AQHZ6wD/X9RVQ39BEEGXAtoeSmDJSA==
Date:   Tue, 19 Sep 2023 13:55:50 +0000
Message-ID: <20230919135536.2165715-5-da.gomez@samsung.com>
In-Reply-To: <20230919135536.2165715-1-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7oZKzhTDSZu1rWYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUVw2Kak5mWWp
        Rfp2CVwZW/ecYyrolamYv6GJqYHxgVgXIweHhICJxJ8LHl2MXBxCAisYJe6tuMMM4XxhlPh1
        YDUThPOZUWLD3ZVADidYx/w5KxkhEssZJb6tWc8MkgCrevA0HCJxhlFi4qyl7BCJlYwSS1dy
        g9hsApoS+05uYgcpEhGYzSpxeHEHI0iCWaBOYs2zWSwgtrBAoMTFphVsILaIQJjE1oc/mUCO
        FRHQk9jSGwESZhFQlWjcdBWsnFfAWuLQ4RdgNqeAjcSNuU1grYwCshKPVv5ihxgvLnHryXyo
        DwQlFs3ewwxhi0n82/WQDcLWkTh7/QkjhG0gsXXpPhYIW0niT8dCqDP1JG5MncIGYWtLLFv4
        mhniBkGJkzOfsID8JSHQxCXR8eAbIySAXSR2/CmGmCMs8er4FnYIW0bi9OQelgmM2rOQnDcL
        yYpZSFbMQrJiASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMC0dvrf8S87GJe/+qh3
        iJGJg/EQowQHs5II70xDtlQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1ML
        UotgskwcnFINTNFb3z7tCGWcdyBrtZnAnxI5V8l73bG9ay3swgqrTwYxeYTwP8832zdJo+7b
        Jjtjr12Beo7v9S9937Ugf7u/yNPsiP0fGZdp/StQfLb05CvWQwdPFcyW2JUYnGDcvKJU478H
        e2DuPi6/lNMWCxffLlycIit7PD55mdeJh8ZPZ0REVW9dyrFA4+PF3pitPetvfDpSFPWvpCb6
        Xq/u4SU6N+0ic79kBhrsV/7zNubOe5Nw3bXvo+beu+X56n7wk3lOutN3XnFaZMJyY8HDpoVt
        mzrObnPqWyJ5+G9Mz79Ch+/6X452hlQn1lxofPw4Ne7Vxb1/nCwv+fpVBWjP+Kuqz8Jh1L/o
        faNslc8yGUf5aUosxRmJhlrMRcWJAHwyEabaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsVy+t/xu7oZKzhTDZr/8FnMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MrXvOMRX0ylTM39DE
        1MD4QKyLkZNDQsBEYv6clYxdjFwcQgJLGSXerDzHBpGQkdj45SorhC0s8edaFxtE0UdGicOr
        25ghnDOMEh9fPWSCcFYySjxfcQCshU1AU2LfyU3sIAkRgdmsEocXdzCCJJgF6iTWPJvFAmIL
        CwRKXGxaAbZPRCBM4svthUA2B5CtJ7GlNwIkzCKgKtG46SpYOa+AtcShwy/AbCEg+9XC1WC7
        OAVsJG7MbQIbwyggK/Fo5S92iFXiEreezGeCeEFAYsme88wQtqjEy8f/oF7TkTh7/QkjhG0g
        sXXpPhYIW0niT8dCqJP1JG5MncIGYWtLLFv4mhniHkGJkzOfsExglJ6FZN0sJC2zkLTMQtKy
        gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmCC2nbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE
        d6YhW6oQb0piZVVqUX58UWlOavEhRlNgGE1klhJNzgemyLySeEMzA1NDEzNLA1NLM2MlcV7P
        go5EIYH0xJLU7NTUgtQimD4mDk6pBiYFLuOZt28WrO5KuKGw/6/E0/2FPu8/fnG65j+v43WC
        as2EAyEhqoLV4cdK7upo1S27tYWV71PQ/Uv/vL88n/df7udXwe+FH98ptN1Mqk67694b/utD
        v1NQxtPi/+ZiTzW7BN0n9e4S1srJ+J/fdHra3o5faqFXXPWuhBq8DjzkGjz/hTlP66ND7LNr
        849s5VD1uvlI2UlaqtDLjW95guW039IqP08cUJniq6I2Q3qZ4ifF2ztfiRmeq2G8Wa9ncevQ
        io539UsecJz/cXGacN7nFwe+l5620vh6pMmw1pn19J2tS/OTP5dXTo9vv/Pj2zHL/jfztEKC
        pTOr/XjCIhRMHzHeWNQ2+cEUSY7oXY+UWIozEg21mIuKEwFsJZsF2QMAAA==
X-CMS-MailID: 20230919135552eucas1p11e19cd339078c2e0b788b52fae46e7c9
X-Msg-Generator: CA
X-RootMTR: 20230919135552eucas1p11e19cd339078c2e0b788b52fae46e7c9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135552eucas1p11e19cd339078c2e0b788b52fae46e7c9
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135552eucas1p11e19cd339078c2e0b788b52fae46e7c9@eucas1p1.samsung.com>
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
index d41ee5983fd4..66d94207b40c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1667,20 +1667,21 @@ static struct folio *shmem_alloc_hugefolio(gfp_t gf=
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
@@ -1689,7 +1690,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t=
 gfp, struct inode *inode,
=20
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge =3D false;
-	nr =3D huge ? HPAGE_PMD_NR : 1;
+	nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
=20
 	err =3D shmem_inode_acct_block(inode, nr);
 	if (err)
@@ -1698,7 +1699,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t=
 gfp, struct inode *inode,
 	if (huge)
 		folio =3D shmem_alloc_hugefolio(gfp, info, index);
 	else
-		folio =3D shmem_alloc_folio(gfp, info, index);
+		folio =3D shmem_alloc_folio(gfp, info, index, *order);
 	if (folio) {
 		__folio_set_locked(folio);
 		__folio_set_swapbacked(folio);
@@ -1748,7 +1749,7 @@ static int shmem_replace_folio(struct folio **foliop,=
 gfp_t gfp,
 	 */
 	gfp &=3D ~GFP_CONSTRAINT_MASK;
 	VM_BUG_ON_FOLIO(folio_test_large(old), old);
-	new =3D shmem_alloc_folio(gfp, info, index);
+	new =3D shmem_alloc_folio(gfp, info, index, 0);
 	if (!new)
 		return -ENOMEM;
=20
@@ -1959,6 +1960,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 	int error;
 	int once =3D 0;
 	int alloced =3D 0;
+	unsigned int order =3D 0;
=20
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
@@ -2034,10 +2036,12 @@ static int shmem_get_folio_gfp(struct inode *inode,=
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
@@ -2600,7 +2604,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
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
