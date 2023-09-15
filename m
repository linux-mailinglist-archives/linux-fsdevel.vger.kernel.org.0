Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDD7A1B3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjIOJxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjIOJw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:52:58 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE41468B
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:51:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095124euoutp029328828a47a207e0ce169f575aaa9384~FCa_d_RHK1046410464euoutp02k
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230915095124euoutp029328828a47a207e0ce169f575aaa9384~FCa_d_RHK1046410464euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771484;
        bh=9t9ULkMuBq/epaiWHGp5SMiuW3po0qdU7nTNfWyOmvY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RQwu1oOKOP/OHNYx/6DeTA5c7ndiENxNu0XN99GO9cPncv7eY9AC1RxPHE2y/6W35
         tdfnjH8d+Cba1a31UkfrqxlHUNaemIKiqY0oZ75ZnWAYO2Df7GMhEx1jyIjF0sIwam
         b7ZpPMSXL58XOLa1lrWEu1AAJ4/ZP/KrK6BYEbnk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230915095124eucas1p2b20cd2623e776492e070e7d7757fe49b~FCa_N49lA0862308623eucas1p2V;
        Fri, 15 Sep 2023 09:51:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E7.E7.11320.C1924056; Fri, 15
        Sep 2023 10:51:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150~FCa93UCLR2203022030eucas1p1Q;
        Fri, 15 Sep 2023 09:51:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230915095123eusmtrp1c3cce7f6f7a5eb736598ffae8ecc3ca0~FCa92ilDZ1836118361eusmtrp17;
        Fri, 15 Sep 2023 09:51:23 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-1c-6504291cfd59
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.D6.14344.B1924056; Fri, 15
        Sep 2023 10:51:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095123eusmtip267ceaaeebbabd3d66cf4aa80ead14236~FCa9rj4DM0935009350eusmtip2G;
        Fri, 15 Sep 2023 09:51:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:23 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:23 +0100
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
Subject: [PATCH 1/6] filemap: make the folio order calculation shareable
Thread-Topic: [PATCH 1/6] filemap: make the folio order calculation
        shareable
Thread-Index: AQHZ57ovaMdf9q/cjECRh1BbWSoXsQ==
Date:   Fri, 15 Sep 2023 09:51:23 +0000
Message-ID: <20230915095042.1320180-2-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87oymiypBr+OC1vMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6MviXLmArOK1Z8a2hmbGDcLt3FyMkhIWAisfNbA2sXIxeHkMAKRonNO3axQzhfGCWe
        rroD5XxmlNgztZEVpuXmwTNMEInljBKtExqY4aq69r2HajnDKDHp5wQ2CGclo8S1mc2MIP1s
        ApoS+05uAqsSEZjNKnF4cQdYglmgTmLNs1ksILawgIfEsr17mEBsEQF/iVv7tzND2HoSrU1f
        wWwWAVWJqe/us4PYvALWEj37e4DiHBycAjYS73+Ug4QZBWQlHq38xQ4xXlzi1pP5TBA/CEos
        mr2HGcIWk/i36yEbhK0jcfb6E0YI20Bi69J9LBC2ksSfjoVQZ+pJ3Jg6hQ3C1pZYtvA1M8QJ
        ghInZz5hAflLQqCJS+Lsrd/QAHOR6G5/yg5hC0u8Or4FypaROD25h2UCo/YsJPfNQrJjFpId
        s5DsWMDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwvZ3+d/zLDsblrz7qHWJk4mA8
        xCjBwawkwstmy5QqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJ
        g1OqgSno/8LS5s8ZRx32KzrzXJnZszVv8dqLnhoH7iStPqR8O+X5ldSQ3oCkjXzulTqrJmU7
        s+pFO4l4vdLLnr7RQrpSM+Hg6i7pz92nvdstw0REgxcYn3PX4/ff+/nfe93cLHPmrdseJcfu
        jZ07IZXjh+n+GI3aP8sLHXgslb9/8paUuH7oSNi0fO9lTtXT37z7YO96M+HaYr3csxecE5+K
        qj2YkCJuIT3/7BGlOUp/m6y72DtWP7wWfSfPY49Tan/DzifnThwWvis2my3p+4Rv7jUPtCLu
        Bm4/duKTYZdpsa7wVY4u6U2v/4r6+OWXMRs8ncDyY8Ee5z2uKQuyL/Dayu5jbl2k8+sOf6jI
        53uqbUosxRmJhlrMRcWJADmRL4LeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xe7rSmiypBv+2WVjMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MviXLmArOK1Z8a2hm
        bGDcLt3FyMkhIWAicfPgGaYuRi4OIYGljBJH/i5lgkjISGz8cpUVwhaW+HOtiw3EFhL4yCjR
        tqoYouEMo0RT13VGCGclo8SMa4cZQarYBDQl9p3cxA6SEBGYzSpxeHEHWIJZoE5izbNZLCC2
        sICHxLK9e8DWiQj4Smw5sYUNwtaTaG36ygxiswioSkx9d58dxOYVsJbo2d8DFOcA2mYtMWu6
        F4jJKWAj8f5HOUgFo4CsxKOVv9ghNolL3HoyH+oZAYkle84zQ9iiEi8f/4N6TEfi7PUnjBC2
        gcTWpftYIGwliT8dC6Eu1pO4MXUKG4StLbFs4WtmiGsEJU7OfMIygVF6FpJ1s5C0zELSMgtJ
        ywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiByWnbsZ9bdjCufPVR7xAjEwfjIUYJDmYl
        EV42W6ZUId6UxMqq1KL8+KLSnNTiQ4ymwBCayCwlmpwPTI95JfGGZgamhiZmlgamlmbGSuK8
        ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MOgkHnd78zdr97NxpyRXvVsU97kpbOF1j7f/qVz6L
        d9rVr7+wKHxrQ2Cc8zaG75Oa6vqcf29fVn9bVEzRY+d2mytP7yaaC89eu9zRYVa497G7Xdec
        bNK9DnEt0XkuuGrq80O/X39QVk3/dqZpcc/Pnw+27FaKnb8+2pkl91m7uq/3/17DE4EzJ7w4
        aTnre88tzirWnSYW1gtV3oY4XRUVTOZayHGlf//m8DTDdu8PWkEZfYJZ874pMrCqT5VWLlQv
        ntI3s++DK8/i/8Hv47bcm2l3yUlRzptPZbOqRJzpF+dNGl6l5Xe3zspKKXgVotOhdu5Nopzv
        15DUy8m3XZMyX0U1MeYUnC27dKy5cCu3EktxRqKhFnNRcSIANnSnRtcDAAA=
X-CMS-MailID: 20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150
X-Msg-Generator: CA
X-RootMTR: 20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To make the code that clamps the folio order in the __filemap_get_folio
routine reusable to others, move and merge it to the fgf_set_order
new subroutine (mapping_size_order), so when mapping the size at a
given index, the order calculated is already valid and ready to be
used when order is retrieved from fgp_flags with FGF_GET_ORDER.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 fs/iomap/buffered-io.c  |  6 ++++--
 include/linux/pagemap.h | 42 ++++++++++++++++++++++++++++++++++++-----
 mm/filemap.c            |  8 --------
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ae8673ce08b1..bfd9a22a9464 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -546,12 +546,14 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t =
len)
 {
 	fgf_t fgp =3D FGP_WRITEBEGIN | FGP_NOFS;
+	pgoff_t index =3D pos >> PAGE_SHIFT;
+	struct address_space *mapping =3D iter->inode->i_mapping;
=20
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |=3D FGP_NOWAIT;
-	fgp |=3D fgf_set_order(len);
+	fgp |=3D fgf_set_order(mapping, index, len);
=20
-	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
+	return __filemap_get_folio(mapping, index,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
 }
 EXPORT_SYMBOL_GPL(iomap_get_folio);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 351c3b7f93a1..7af5636eb32a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -576,6 +576,39 @@ typedef unsigned int __bitwise fgf_t;
=20
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
=20
+/**
+ * mapping_size_order - Get maximum folio order for the given file size.
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
+ * Return: The order.
+ */
+static inline unsigned int mapping_size_order(struct address_space *mappin=
g,
+						 pgoff_t index, size_t size)
+{
+	unsigned int order =3D ilog2(size);
+
+	if ((order <=3D PAGE_SHIFT) || (!mapping_large_folio_support(mapping)))
+		return 0;
+	else
+		order =3D order - PAGE_SHIFT;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order =3D __ffs(index);
+
+	order =3D min_t(size_t, order, MAX_PAGECACHE_ORDER);
+
+	/* Order-1 not supported due to THP dependency */
+	return (order =3D=3D 1) ? 0 : order;
+}
+
 /**
  * fgf_set_order - Encode a length in the fgf_t flags.
  * @size: The suggested size of the folio to create.
@@ -587,13 +620,12 @@ typedef unsigned int __bitwise fgf_t;
  * due to alignment constraints, memory pressure, or the presence of
  * other folios at nearby indices.
  */
-static inline fgf_t fgf_set_order(size_t size)
+static inline fgf_t fgf_set_order(struct address_space *mapping, pgoff_t i=
ndex,
+				  size_t size)
 {
-	unsigned int shift =3D ilog2(size);
+	unsigned int order =3D mapping_size_order(mapping, index, size);
=20
-	if (shift <=3D PAGE_SHIFT)
-		return 0;
-	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
+	return (__force fgf_t)(order << 26);
 }
=20
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
diff --git a/mm/filemap.c b/mm/filemap.c
index 582f5317ff71..e285fffa9bcf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1917,14 +1917,6 @@ struct folio *__filemap_get_folio(struct address_spa=
ce *mapping, pgoff_t index,
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |=3D FGP_LOCK;
=20
-		if (!mapping_large_folio_support(mapping))
-			order =3D 0;
-		if (order > MAX_PAGECACHE_ORDER)
-			order =3D MAX_PAGECACHE_ORDER;
-		/* If we're not aligned, allocate a smaller folio */
-		if (index & ((1UL << order) - 1))
-			order =3D __ffs(index);
-
 		do {
 			gfp_t alloc_gfp =3D gfp;
=20
--=20
2.39.2
