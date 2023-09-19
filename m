Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED37A65DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjISN4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjISN4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:05 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29292123
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135551euoutp02207b9b2248a393237987c2ce5e857a67~GUVjbxb1m1585715857euoutp02M
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230919135551euoutp02207b9b2248a393237987c2ce5e857a67~GUVjbxb1m1585715857euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131751;
        bh=zPiGytBfegEqHRUsVtZKimf8fdUTs88Qyc8YPePHcIk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=tyM4uvQdUR1AS3aYkBsxN32j/P4q2FARUnPi8UjEsUaK/RInj4GTTsgiqt3Abi0EZ
         xPp6E2q79rArO2yh4Pg1Npb2OgCS+RY3naCuqZ/ExDsJ2hMNQOmyGDyPb3/9yCnggt
         2eHzkHBjYlJcVe2tWGleBwTU4JIrtv0QzsVvrREg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230919135551eucas1p1c2f79426cc02c6873649747c6b5ebe77~GUVjFDdBx1658916589eucas1p1F;
        Tue, 19 Sep 2023 13:55:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.8E.11320.768A9056; Tue, 19
        Sep 2023 14:55:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230919135550eucas1p2c19565924daeecf71734ea89d95c84db~GUVilHeug1635116351eucas1p2u;
        Tue, 19 Sep 2023 13:55:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230919135550eusmtrp2e393e76eb8216b24e9888cc400ce0942~GUVikiwv92324623246eusmtrp2F;
        Tue, 19 Sep 2023 13:55:50 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-c7-6509a8674f70
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.55.14344.668A9056; Tue, 19
        Sep 2023 14:55:50 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135550eusmtip17b6283cd8a9ef8f53119b7dcf49ffc0f~GUViY2AR61888818888eusmtip1z;
        Tue, 19 Sep 2023 13:55:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:55:50 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:50 +0100
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
Subject: [PATCH v2 3/6] shmem: account for large order folios
Thread-Topic: [PATCH v2 3/6] shmem: account for large order folios
Thread-Index: AQHZ6wD+Wqd1jPdfPEKUQlAv9fdGJA==
Date:   Tue, 19 Sep 2023 13:55:49 +0000
Message-ID: <20230919135536.2165715-4-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7rpKzhTDb42SVrMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6MaTNfsRS8kai4uvAaUwPjPpEuRk4OCQETibMrJzJ2MXJxCAmsYJTYP7mNGcL5wihx
        fdYtNgjnM6PEkY3/WboYOcBaur+mQMSXM0p0nfvGCjIKrOjUFKjuM4wSc7vXMkE4KxklmrvW
        MIJUsQloSuw7uYkdJCEiMJtV4vDiDrAEs0CdxJpns1hAbGEBW4n3C7+yg9giAk4Sj+dvYoGw
        9SS2zb7DBHIGi4CqxOdTbiBhXgFriVc79zKD2JwCNhI35jaxgdiMArISj1b+YocYLy5x68l8
        JoinBSUWzd7DDGGLSfzb9ZANwtaROHv9CSOEbSCxdek+FghbSeJPx0KoM/UkbkydwgZha0ss
        W/iaGeIGQYmTM5+wgPwlIdDEJfGqYynUUBeJXUtnskPYwhKvjm+BsmUk/u+czzSBUXsWkvtm
        IdkxC8mOWUh2LGBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY2k7/O/5lB+PyVx/1
        DjEycTAeYpTgYFYS4Z1pyJYqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6Yklqdmpq
        QWoRTJaJg1OqgalxedqRkwZRry9ZTG7oi6xyXHZ9kmH4MjbO3+5H1zQvPvbUVM1F56/DiYag
        8M8rhcoKTbTb1y6qU5JnP73b3vvtvoU+yZ/bbjfe7T3xa6/vuont1x9bCgmemrT96UfuBaY3
        2m58OayV2BGRcurS33bNoJ+h2xgEWBZXWS+9Yr2o58S0tie373e/VeqsOu+wNeKUTdyXKWfr
        WCN2su4TnXdxfu+dfTwyR9TeOj0Lf5/KFJX12oz9mt32i4ndSkUXrsT//PT6IbOnrtTvV7yb
        +WftNYmdu36BgUdQidp7q+OTvux4vrmSV/wmO4d4ml3Hw/5ddlJrxE5cOdp95ffBtUm3SmL0
        1Tm9s/pqd31/OPOmEktxRqKhFnNRcSIAbnKTxdwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xu7ppKzhTDd79MraYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ02a+Yil4I1FxdeE1
        pgbGfSJdjBwcEgImEt1fU7oYuTiEBJYySiztXc/axcgJFJeR2PjlKpQtLPHnWhcbiC0k8JFR
        4va1YoiGM4wSbQ8nMkI4K4G6e76yg1SxCWhK7Du5iR0kISIwm1Xi8OIORpAEs0CdxJpns1hA
        bGEBW4n3CyEaRAScJB7P38QCYetJbJt9hwnkPBYBVYnPp9xAwrwC1hKvdu5lhrgCyF64Guw6
        TgEbiRtzm8CuYxSQlXi08hc7xCpxiVtP5jNBfCAgsWTPeWYIW1Ti5eN/UJ/pSJy9/oQRwjaQ
        2Lp0HwuErSTxp2Mh1Ml6EjemTmGDsLUlli18zQxxj6DEyZlPWCYwSs9Csm4WkpZZSFpmIWlZ
        wMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzA5bTv2c8sOxpWvPuodYmTiYDzEKMHBrCTC
        O9OQLVWINyWxsiq1KD++qDQntfgQoykwiCYyS4km5wPTY15JvKGZgamhiZmlgamlmbGSOK9n
        QUeikEB6YklqdmpqQWoRTB8TB6dUA5P5/KOrf+Q5HfRasdX4ybW+kpuybSYvX79bfZg51+ma
        YurLWUFnTh1ek3HpLQOLkHjzr7DurS/YQnNWmqye9EPiRvwBrqV6V9b/bj/y2sZ5Bc82zY2p
        z1lvLBR4u+BrxvMnrA1Xmh46vFSeyvtqrf2NwDrdj+qHzRbdLedcuyVTvJDlt3KleeHRw2r/
        7P5lGS774MfGtjo8XbQshue7561TZ1ZxZKUc9pqWxT7Td8Epg2d8pyZrROQHW6d//CQjeG71
        V+Yzt88wpfxYGPusTSU1/KAst5ldK19A1Mygz7mf5XO9CpW4Zj4QPH/F49XJZqG4u/ZXj8he
        uXbrg+n9Z4xrLzXkuS7f68zpd6lVIn65EktxRqKhFnNRcSIAM2aVQtcDAAA=
X-CMS-MailID: 20230919135550eucas1p2c19565924daeecf71734ea89d95c84db
X-Msg-Generator: CA
X-RootMTR: 20230919135550eucas1p2c19565924daeecf71734ea89d95c84db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135550eucas1p2c19565924daeecf71734ea89d95c84db
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135550eucas1p2c19565924daeecf71734ea89d95c84db@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

shmem uses the shem_info_inode alloced, swapped to account
for allocated pages and swapped pages. In preparation for large
order folios adjust the accounting to use folio_nr_pages().

This should produce no functional changes yet as larger order
folios are not yet used or supported in shmem.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5c9e80207cbf..d41ee5983fd4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -871,16 +871,16 @@ unsigned long shmem_partial_swap_usage(struct address=
_space *mapping,
 						pgoff_t start, pgoff_t end)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
+	struct folio *folio;
 	unsigned long swapped =3D 0;
 	unsigned long max =3D end - 1;
=20
 	rcu_read_lock();
-	xas_for_each(&xas, page, max) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, max) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xa_is_value(page))
-			swapped++;
+		if (xa_is_value(folio))
+			swapped +=3D folio_nr_pages(folio);
 		if (xas.xa_index =3D=3D max)
 			break;
 		if (need_resched()) {
@@ -1530,7 +1530,7 @@ static int shmem_writepage(struct page *page, struct =
writeback_control *wbc)
 	if (add_to_swap_cache(folio, swap,
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) =3D=3D 0) {
-		shmem_recalc_inode(inode, 0, 1);
+		shmem_recalc_inode(inode, 0, folio_nr_pages(folio));
 		swap_shmem_alloc(swap);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
=20
@@ -1803,6 +1803,7 @@ static void shmem_set_folio_swapin_error(struct inode=
 *inode, pgoff_t index,
 	struct address_space *mapping =3D inode->i_mapping;
 	swp_entry_t swapin_error;
 	void *old;
+	long num_swap_pages;
=20
 	swapin_error =3D make_poisoned_swp_entry();
 	old =3D xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1812,13 +1813,14 @@ static void shmem_set_folio_swapin_error(struct ino=
de *inode, pgoff_t index,
 		return;
=20
 	folio_wait_writeback(folio);
+	num_swap_pages =3D folio_nr_pages(folio);
 	delete_from_swap_cache(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
 	 * in shmem_evict_inode().
 	 */
-	shmem_recalc_inode(inode, -1, -1);
+	shmem_recalc_inode(inode, -num_swap_pages, -num_swap_pages);
 	swap_free(swap);
 }
=20
@@ -1905,7 +1907,7 @@ static int shmem_swapin_folio(struct inode *inode, pg=
off_t index,
 	if (error)
 		goto failed;
=20
-	shmem_recalc_inode(inode, 0, -1);
+	shmem_recalc_inode(inode, 0, -folio_nr_pages(folio));
=20
 	if (sgp =3D=3D SGP_WRITE)
 		folio_mark_accessed(folio);
@@ -2665,7 +2667,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	if (ret)
 		goto out_delete_from_cache;
=20
-	shmem_recalc_inode(inode, 1, 0);
+	shmem_recalc_inode(inode, folio_nr_pages(folio), 0);
 	folio_unlock(folio);
 	return 0;
 out_delete_from_cache:
--=20
2.39.2
