Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FE7A1B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjIOJzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjIOJyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5213C3C16
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:53:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095134euoutp0256ed30e8c7acb5a04c42f652d32c8530~FCbHVdW7p1230712307euoutp02O
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230915095134euoutp0256ed30e8c7acb5a04c42f652d32c8530~FCbHVdW7p1230712307euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771494;
        bh=nTKXGiIiML3QQW/w2E+mOtcZhHyvpI4/kPyFKr8+glQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KI2kOdoS2yg7Vh86md6sPK4vwrtx1rr8lkcPGelzTYN+V1wDwjhXbTPHfi1ayADmq
         SnuX6aSN1YRX5kU7TmhzwLcmfDlEAs/J/VhdqKM/lMU1vn2PXUcHsE0QM7qAuv739c
         MwIfQURAnIrUaVFqn6+icPbpvOOlVSZ/rhM39T1M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230915095133eucas1p1fc05405567bd735c07ff213d3dff3c85~FCbG_4jQF2007620076eucas1p1T;
        Fri, 15 Sep 2023 09:51:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 63.AA.42423.52924056; Fri, 15
        Sep 2023 10:51:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f~FCbGdpbh00862308623eucas1p2c;
        Fri, 15 Sep 2023 09:51:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230915095133eusmtrp2540609b9602d103cb0a1998aeeb2d1b1~FCbGc8gqX1712217122eusmtrp2_;
        Fri, 15 Sep 2023 09:51:33 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-26-65042925ea5e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.3B.10549.52924056; Fri, 15
        Sep 2023 10:51:33 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230915095133eusmtip145b39d48e2d4c2b2f0f476f141a1971f~FCbGQl2U92594625946eusmtip1i;
        Fri, 15 Sep 2023 09:51:33 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:32 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:32 +0100
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
Subject: [PATCH 6/6] shmem: add large folios support to the write path
Thread-Topic: [PATCH 6/6] shmem: add large folios support to the write path
Thread-Index: AQHZ57o0gOj42/h7V0WVSDdaHJaWqA==
Date:   Fri, 15 Sep 2023 09:51:31 +0000
Message-ID: <20230915095042.1320180-7-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87qqmiypBpfmq1vMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6M/d1mBbuEKv5se8bWwHiar4uRg0NCwETia5tOFyMXh5DACkaJncsWMkM4Xxgl9t9b
        xgLhfGaUeNZ6mxWmY94rFYj4ckaJoy1b2eCKfmyeDeWcYZRY8vYn1KyVjBLbZr0EmsXJwSag
        KbHv5CZ2kISIwGxWicOLOxhBEswCdRJrns0CKmLnEBZwk1ijDxIVEfCWeLFzCRuErSfx/tAb
        sGoWAVWJz7t+soNcxCtgLbH+VjaIySlgI/H+RzlIBaOArMSjlb/YIWaLS9x6Mp8JxJYQEJRY
        NHsPM4QtJvFv10M2CFtH4uz1J4wQtoHE1qX7WCBsJYk/HQuhbtSTuDF1ChuErS2xbOFrsDm8
        QDNPznwCDiwJgSYuicZ7nawQzS4SvXtPQA0Vlnh1fAs7hC0j8X/nfKYJjNqzkNw3C8mOWUh2
        zEKyYwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAlHb63/FPOxjnvvqod4iRiYPx
        EKMEB7OSCC+bLVOqEG9KYmVValF+fFFpTmrxIUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkm
        Dk6pBqaWRM5Pj4tPdNV4Tzrws1rjd/3C9dXPnLiL7z9YHLMk/25guu/P9V+Lpdj4Z2jzRDL9
        l1n0MeamnZfEdI3PdaVHPr6/flR/4rROu4AjFyYG3lsqODM4gm3BhvUcbW9kdZkqJP++jO10
        +TF3ofZvNbvbTXvvJSoXmcvaT9tXu1LT1zBiW03Dzis/1tsU297Ilzn5vvTou6anmTPCN1rK
        P1Nlets6Y5X0mUNc6/9nzXUwkfJ11t66P5G16WNq9pEzTc95wi/PNT3UxG786OrEkF3qgR8f
        b/Xfc2ZyZ7XDBLuIVTWL1wp/NF1wlt1HU1nSzTK1sWNiTcP7ne8S7FfxKm+enyh5R97rdfMO
        xZ+fHLmUWIozEg21mIuKEwGrauQe2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsVy+t/xu7qqmiypBlf+cVjMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M/d1mBbuEKv5se8bW
        wHiar4uRg0NCwERi3iuVLkYuDiGBpYwSRx/fZOti5ASKy0hs/HKVFcIWlvhzrYsNougjo8S3
        ta9ZQBJCAmcYJfo+VkMkVjJKHGvcBZZgE9CU2HdyEztIQkRgNqvE4cUdjCAJZoE6iTXPZgEV
        sXMIC7hJrNEHiYoIeEu82LmEDcLWk3h/6A1YNYuAqsTnXT/ZQQ7lFbCWWH8rG8QUAjJnTfcC
        MTkFbCTe/ygHKWYUkJV4tPIXO8QacYlbT+YzQVwvILFkz3lmCFtU4uXjf1Bf6Uicvf6EEcI2
        kNi6dB8LhK0k8adjIdS5ehI3pk5hg7C1JZYtfA02h1dAUOLkzCcsExilZyFZNwtJyywkLbOQ
        tCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRmJK2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBW
        EuFls2VKFeJNSaysSi3Kjy8qzUktPsRoCgygicxSosn5wKSYVxJvaGZgamhiZmlgamlmrCTO
        61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAFGb97Euc/wHZOwe2H2d42C6wT9inRO7LFrv2jz5P
        F+jw6Pd+rmiR+vWiN6yJcdZj/UWebt99mZZpm3FUc8u9iHs94eG6jMblr2Q0rq9tOuBysvnq
        HqNDv/XmeUz9sMmm9fl6u4v7WCZt+nauo1l/yR1BpU1qlornQqTCTdjnZiWU1r2rlODnvbzW
        y/y5mNgqoQcvG6a8O3E48N3Ed//ZoxIdvsRvEP6t4OX9WH7C2uygo9XeTnlK3J69P5QXenPc
        YjKPy5Hg+z9xZ/CXbD2xu1ucfZzSnzWK+9ucKK07vLfk5Url5KaYKNUCptfdS40XvdXc07yx
        feHuG8fPJVYcFP399u7Tmcvfdkzx73g/VYmlOCPRUIu5qDgRACdVhs7SAwAA
X-CMS-MailID: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
X-Msg-Generator: CA
X-RootMTR: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
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
__filemap_get_folio().

Use the __folio_get_max_order to get a hint for the order of the folio
based on file size which takes care of the mapping requirements.

Swap does not support high order folios for now, so make it order 0 in
case swap is enabled.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index adff74751065..26ca555b1669 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1683,13 +1683,19 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
 }
=20
 static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *i=
node,
-		pgoff_t index, bool huge, unsigned int *order)
+		pgoff_t index, bool huge, unsigned int *order,
+		struct shmem_sb_info *sbinfo)
 {
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
 	struct folio *folio;
 	int nr;
 	int err;
=20
+	if (!sbinfo->noswap)
+		*order =3D 0;
+	else
+		*order =3D (*order =3D=3D 1) ? 0 : *order;
+
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge =3D false;
 	nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
@@ -2032,6 +2038,8 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		return 0;
 	}
=20
+	order =3D mapping_size_order(inode->i_mapping, index, len);
+
 	if (!shmem_is_huge(inode, index, false,
 			   vma ? vma->vm_mm : NULL, vma ? vma->vm_flags : 0))
 		goto alloc_nohuge;
@@ -2039,11 +2047,11 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
 	huge_gfp =3D vma_thp_gfp_mask(vma);
 	huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
 	folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, true,
-					   &order);
+					   &order, sbinfo);
 	if (IS_ERR(folio)) {
 alloc_nohuge:
 		folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, false,
-						   &order);
+						   &order, sbinfo);
 	}
 	if (IS_ERR(folio)) {
 		int retry =3D 5;
@@ -2147,6 +2155,8 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 	if (folio_test_large(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
+		if (order > 0)
+			order--;
 		goto alloc_nohuge;
 	}
 unlock:
--=20
2.39.2
