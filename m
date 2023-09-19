Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72907A65E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjISN4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjISN4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950D1A1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:58 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135557euoutp01537e5549a4e6393785476c5a0f8551cf~GUVoYodB20107701077euoutp017
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230919135557euoutp01537e5549a4e6393785476c5a0f8551cf~GUVoYodB20107701077euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131757;
        bh=JKaS2+/EEMvNdZiV+zve2PZ9hmK4b8LE7tpeT3AMyFo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nuctfpPHnSMC7WQhH3HQtlmt0BgRwRmZt8mRpYkEnpagsqTg5Xc3QzV+nXnDwFb6D
         lxURGbKYETqe7oCM8Mgw+BtSPsANdW2I0sC1Kk9USuK7719XgBh986WUD/UyXmzVnP
         2kwtvOkEHXQIb3zoZiL0vNOSS/gXZ178cpLtEY6M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919135556eucas1p25528f9f56de359f45b1e7b88035e664a~GUVn702Uc1835018350eucas1p2T;
        Tue, 19 Sep 2023 13:55:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.D1.42423.C68A9056; Tue, 19
        Sep 2023 14:55:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135556eucas1p19920c52d4af0809499eac6bbf4466117~GUVnbnZpF0405804058eucas1p16;
        Tue, 19 Sep 2023 13:55:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230919135556eusmtrp27b41cacf6044fd9f4708968fe6ddd715~GUVna-NnB2324623246eusmtrp2O;
        Tue, 19 Sep 2023 13:55:56 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-8a-6509a86cdb59
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.55.14344.B68A9056; Tue, 19
        Sep 2023 14:55:55 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135555eusmtip1dc621754b1f2f7018cbadae30e65482e~GUVnMaPw61888818888eusmtip14;
        Tue, 19 Sep 2023 13:55:55 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:55:55 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:55 +0100
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
Subject: [PATCH v2 6/6] shmem: add large folios support to the write path
Thread-Topic: [PATCH v2 6/6] shmem: add large folios support to the write
        path
Thread-Index: AQHZ6wEBFE+DTgi9xUu5khR159FX3A==
Date:   Tue, 19 Sep 2023 13:55:54 +0000
Message-ID: <20230919135536.2165715-7-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87o5KzhTDfZtVLSYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUVw2Kak5mWWp
        Rfp2CVwZk1c8Yyx4pVxx5/YElgbG2zJdjJwcEgImEk8ebmACsYUEVjBKtNzJ6GLkArK/MEr8
        vbWdHcL5zChx5t17dpiOgye+MUEkljNKzLv4nAWuauGkL8wQzhlGic4X06GclYwS1xf9Aetn
        E9CU2HdyE9hgEYHZrBKHF3cwgiSYBeok1jybxQJiCwt4Sqw/ehWsQUQgQKKt/woThK0n8XfZ
        STCbRUBV4t2/hWC9vALWEj8nHgKLcwrYSNyY28QGYjMKyEo8WvmLHWK+uMStJ/OZIJ4QlFg0
        ew8zhC0m8W/XQzYIW0fi7PUnjBC2gcTWpftYIGwliT8dC6Hu1JO4MXUKG4StLbFs4WtmiBsE
        JU7OfAIOCwmBf5wS02auhxrkItE79yHUMmGJV8e3QENSRuL/zvlMExi1ZyG5bxaSHbOQ7JiF
        ZMcCRpZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgent9L/jn3Ywzn31Ue8QIxMH4yFG
        CQ5mJRHemYZsqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4
        pRqYRBJnbv1x2ka78IHfHt81nFbfLUzndT1+Z6woZfPpbRLDtLuPOrPuZLEaKd3a1xn7YNqd
        L9ErLp0Us3GYUbVT7tk1b9WvNzmXcDI/jOvzLJT+dVy+Nm4O/1qXacdW5RgEfOXJXGy18Qer
        70UV/QbRCMVCpgKPRiHR1ITMs1fZJvsdfTTFYm2JfU/a3xJdu/yasPn/559hWxm5Z44y82rL
        p++ktLrKnaR1losyc6r2n/i/2eqgWGrpNCufqpdack35shEx92JeCOduaNzscXPdpLY1N0ob
        79lcXZthatOwoL70oJBdo5DO5amrK9ZN23nsmM4vw8yORUUpuRLN8XNXZlQ3r73lb9N5uCY1
        yV6JpTgj0VCLuag4EQB80Q5y3gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsVy+t/xu7rZKzhTDfZusbGYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZk1c8Yyx4pVxx5/YE
        lgbG2zJdjJwcEgImEgdPfGPqYuTiEBJYyijx8/AHFoiEjMTGL1dZIWxhiT/Xutggij4yShw4
        f4cFwjnDKHFj9X12CGclo8TZvVvAWtgENCX2ndwElhARmM0qcXhxByNIglmgTmLNs1lgO4QF
        PCXWH73KDmKLCPhJ/Hx0kxXC1pP4u+wkE4jNIqAq8e7fQrBeXgFriZ8TD4HFhYDsVwtXg9Vz
        CthI3JjbxAZiMwrISjxa+YsdYpe4xK0n85kgfhCQWLLnPDOELSrx8vE/qN90JM5ef8IIYRtI
        bF26D+p/JYk/HQuhbtaTuDF1ChuErS2xbOFrZoh7BCVOznzCMoFRehaSdbOQtMxC0jILScsC
        RpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgSlq27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHe
        mYZsqUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5gk80riDc0MTA1NzCwNTC3NjJXEeT0L
        OhKFBNITS1KzU1MLUotg+pg4OKUamKY0sD3SbStZePl74E6P/u7P+56FFDDFCxd47pzP/ShM
        Z+nfY7pee44yWPTXM79S5dqiW/k/zsxoj45P6Nvlro1b6+R/bJghk/RNzEM29q31l5kc+X+U
        XZMn/mv72vVL6b2ziQKfqd9uXdHnexZ0GVcc36+56+l8lZ6D+ikM+5WDlPgWWL1alVV+mCPe
        5YLJqw33uqyLNBS0vqxZ2aR0sJWz9f0XPU/H/fJCU/UXRPjWtVWF7Vi19c0nRg/9T6kZF38H
        G97/emt20tnNG+rNZt50C9rokSYts90pS0/c/k1mUL/OYbOVF7TnKPZt1fyVZj9vysTvWzIf
        XtxfUfbmaKl8c/Dygk2Gm/WyowyvKLEUZyQaajEXFScCAEql5LjaAwAA
X-CMS-MailID: 20230919135556eucas1p19920c52d4af0809499eac6bbf4466117
X-Msg-Generator: CA
X-RootMTR: 20230919135556eucas1p19920c52d4af0809499eac6bbf4466117
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135556eucas1p19920c52d4af0809499eac6bbf4466117
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135556eucas1p19920c52d4af0809499eac6bbf4466117@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add large folio support for shmem write path matching the same high
order preference mechanism used for iomap buffered IO path as used in
__filemap_get_folio() with a difference on the max order permitted
(being PMD_ORDER-1) to respect the huge mount option when large folio
is supported.

Use the __folio_get_max_order to get a hint for the order of the folio
based on file size which takes care of the mapping requirements.

Swap does not support high order folios for now, so make it order 0 in
case swap is enabled.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 66 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 38aafa0b0845..96c74c96c0d9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -95,6 +95,9 @@ static struct vfsmount *shm_mnt;
 /* Symlink up to this size is kmalloc'ed instead of using a swappable page=
 */
 #define SHORT_SYMLINK_LEN 128
=20
+/* Like MAX_PAGECACHE_ORDER but respecting huge option */
+#define MAX_SHMEM_ORDER	HPAGE_PMD_ORDER - 1
+
 /*
  * shmem_fallocate communicates with shmem_fault or shmem_writepage via
  * inode->i_private (with i_rwsem making sure that it has only one user at
@@ -1680,26 +1683,58 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
 	return folio;
 }
=20
+/**
+ * shmem_mapping_size_order - Get maximum folio order for the given file s=
ize.
+ * @mapping: Target address_space.
+ * @index: The page index.
+ * @size: The suggested size of the folio to create.
+ *
+ * This returns a high order for folios (when supported) based on the file=
 size
+ * which the mapping currently allows at the given index. The index is rel=
evant
+ * due to alignment considerations the mapping might have. The returned or=
der
+ * may be less than the size passed.
+ *
+ * Like __filemap_get_folio order calculation.
+ *
+ * Return: The order.
+ */
+static inline unsigned int
+shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
+			 size_t size, struct shmem_sb_info *sbinfo)
+{
+	unsigned int order =3D ilog2(size);
+
+	if ((order <=3D PAGE_SHIFT) ||
+	    (!mapping_large_folio_support(mapping) || !sbinfo->noswap))
+		return 0;
+	else
+		order =3D order - PAGE_SHIFT;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order =3D __ffs(index);
+
+	order =3D min_t(size_t, order, MAX_SHMEM_ORDER);
+
+	/* Order-1 not supported due to THP dependency */
+	return (order =3D=3D 1) ? 0 : order;
+}
+
 static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *i=
node,
-		pgoff_t index, bool huge, unsigned int *order)
+		pgoff_t index, unsigned int order)
 {
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
 	struct folio *folio;
-	int nr;
-	int err;
-
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		huge =3D false;
-	nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
+	int nr =3D 1U << order;
+	int err =3D shmem_inode_acct_block(inode, nr);
=20
-	err =3D shmem_inode_acct_block(inode, nr);
 	if (err)
 		goto failed;
=20
-	if (huge)
+	if (order =3D=3D HPAGE_PMD_ORDER)
 		folio =3D shmem_alloc_hugefolio(gfp, info, index);
 	else
-		folio =3D shmem_alloc_folio(gfp, info, index, *order);
+		folio =3D shmem_alloc_folio(gfp, info, index, order);
 	if (folio) {
 		__folio_set_locked(folio);
 		__folio_set_swapbacked(folio);
@@ -2030,18 +2065,19 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
 		return 0;
 	}
=20
+	order =3D shmem_mapping_size_order(inode->i_mapping, index, len, sbinfo);
+
 	if (!shmem_is_huge(inode, index, false,
 			   vma ? vma->vm_mm : NULL, vma ? vma->vm_flags : 0))
 		goto alloc_nohuge;
=20
 	huge_gfp =3D vma_thp_gfp_mask(vma);
 	huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
-	folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, true,
-					   &order);
+	folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index,
+					   HPAGE_PMD_ORDER);
 	if (IS_ERR(folio)) {
 alloc_nohuge:
-		folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, false,
-						   &order);
+		folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, order);
 	}
 	if (IS_ERR(folio)) {
 		int retry =3D 5;
@@ -2145,6 +2181,8 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 	if (folio_test_large(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
+		if (--order =3D=3D 1)
+			order =3D 0;
 		goto alloc_nohuge;
 	}
 unlock:
--=20
2.39.2
