Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD97A1B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjIOJyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjIOJyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:15 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9130D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:53:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095129euoutp010d7d35efacb06852981a7c159bd6659c~FCbChbVMO0839508395euoutp01T
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230915095129euoutp010d7d35efacb06852981a7c159bd6659c~FCbChbVMO0839508395euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771489;
        bh=MPvP7/bW/aMWENbqWzpXNJZ4Wgeps0pePFDrgq86iOg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=uNcOYwD1KXFgn9ho/vmqx/GG2pljZqP4wWUJe/iAOVXSPVAgPm4bqM8VFV5ieV4ru
         CbC7HBFUYykz+VdcN8I3F7MfhS7wQogKmSFNon3fHPgSa+5/m0D690BwJavo6RtfUA
         8Km3tK7Dl/XcLhl1Dqg+eDb/YI31C7YHaTW7Ko5k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230915095128eucas1p1c1a3ec9f583e1c28f521e3e197036d1d~FCbCF227V1980119801eucas1p1J;
        Fri, 15 Sep 2023 09:51:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.BC.37758.02924056; Fri, 15
        Sep 2023 10:51:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281~FCbBm3leg0860408604eucas1p2N;
        Fri, 15 Sep 2023 09:51:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230915095128eusmtrp2d7b39d9dd999d006e785228e6b920fbd~FCbBmNn_X1716917169eusmtrp2j;
        Fri, 15 Sep 2023 09:51:28 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-6d-6504292037c2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.3B.10549.F1924056; Fri, 15
        Sep 2023 10:51:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230915095127eusmtip135d9c0b9a9fdcb2530a0ed2723b2c1c3~FCbBb1Xge2687926879eusmtip18;
        Fri, 15 Sep 2023 09:51:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:27 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:27 +0100
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
Subject: [PATCH 3/6] shmem: account for large order folios
Thread-Topic: [PATCH 3/6] shmem: account for large order folios
Thread-Index: AQHZ57oxkDDTtuHEck+OwDgOe5Q+ig==
Date:   Fri, 15 Sep 2023 09:51:26 +0000
Message-ID: <20230915095042.1320180-4-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87oKmiypBtO/y1jMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6MC+seMRe8Uqj4NHEDewPjdqkuRk4OCQETiZ/rtrN3MXJxCAmsYJQ4u/gdI4TzhVHi
        wp1mNpAqIYHPjBInj5rAdHz4tpMJomg5o0TP1GnMcEVHL4ZCJM4wSlzecJMVwlnJKLHj8Bcm
        kCo2AU2JfSc3gS0UEZjNKnF4cQcjSIJZoE5izbNZLCC2sICVRM+qOWBxEQF7iZ0X3rBB2HoS
        P8/PAarh4GARUJXYdzASJMwrYC2x9e9SsDCngI3E+x/lIGFGAVmJRyt/sUNMF5e49WQ+E8QH
        ghKLZu9hhrDFJP7tesgGYetInL3+hBHCNpDYunQfC4StJPGnYyHUlXoSN6ZOYYOwtSWWLXzN
        DHGCoMTJmU9YQN6SEGjiknh8ci47RLOLRP+6lVALhCVeHd8CFZeR+L9zPtMERu1ZSO6bhWTH
        LCQ7ZiHZsYCRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgYjv97/jXHYwrXn3UO8TI
        xMF4iFGCg1lJhJfNlilViDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQi
        mCwTB6dUA1NjmfW+6GmVZ5mElf59tlg36eiplXFh3g2PP8yOLBCd18a6X8LjTISE5fu+JGuX
        17+S/RJ2PRV+9+mq2KutVT79AdH7//KWe39xmZ4m62Hnyiy0w0y96XFg3ELLw97JItPsZsZ3
        shW/Ptj5+Phf7vysA8ymbHN+xL250jNDppKRidews3/S3SP/n3zhqu62qFYzmJPmll7+ac8C
        IbXts+vnN2UtThZb/TeNX1Y+JsRZfxNXptpZl+W3/piuOu0YsvP2+6D5WdwMzVPXdUwrT7/J
        aPowd8e8DVvlJQLyT+6fuIu3qGvBvyKF5AWsjz3+XgzgmqFTfyfG9UT4JW6Z0C139jxcdFso
        9e8r98WK9UosxRmJhlrMRcWJALONbYvbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xu7rymiypBssvWFrMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MC+seMRe8Uqj4NHED
        ewPjdqkuRk4OCQETiQ/fdjJ1MXJxCAksZZSYeu4PO0RCRmLjl6usELawxJ9rXWwQRR8ZJb6e
        PcYK4ZxhlLg3ZxGUs5JR4sqzD2AtbAKaEvtObmIHSYgIzGaVOLy4gxEkwSxQJ7Hm2SwWEFtY
        wEqiZ9UcsLiIgL3Ezgtv2CBsPYmf5+cA1XBwsAioSuw7GAkS5hWwltj6dylYWAjInjXdC8Tk
        FLCReP+jHKSCUUBW4tHKX+wQi8Qlbj2ZzwTxgIDEkj3nmSFsUYmXj/9BPaYjcfb6E0YI20Bi
        69J9LBC2ksSfjoVQB+tJ3Jg6hQ3C1pZYtvA1M8Q1ghInZz5hmcAoPQvJullIWmYhaZmFpGUB
        I8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwOS07djPzTsY5736qHeIkYmD8RCjBAezkggv
        my1TqhBvSmJlVWpRfnxRaU5q8SFGU2AATWSWEk3OB6bHvJJ4QzMDU0MTM0sDU0szYyVxXs+C
        jkQhgfTEktTs1NSC1CKYPiYOTqkGpsSJaUsr/xavZjmz9+/L4t9mRTwu06YzqaUuv1vRPnvH
        5Jjpy8LEF4i3Va36Ynl1gdnrg+H9fxkNtTRXm76r+D5x48G5Ta1TdG6yvPQ0YKo3z5F1vfxD
        7r/+ns60g113vJPi/jkI/k7fd1t2tux9hQNczlcdvYT9pGqWXfLuOKPlPOla+pVbkcbdIgqf
        lt3Q8Jg8y5crY9r1x0GfnA9Z9WV9N1/BXuZ+dN51K/8di6bKrfv3+MXT3f/X31k7+Y2Bb/4u
        BRnRAolN3x+u7Uhe5HIm/pv4Xr1vJs6CVWLvGD1FGxj/OUQEh3xZc//M4zOX9qzv3jK3x5O/
        6ON1ld1PT//6Vz6J/e91J6kTH1OrvS4rsRRnJBpqMRcVJwIADD2h59cDAAA=
X-CMS-MailID: 20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281
X-Msg-Generator: CA
X-RootMTR: 20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281@eucas1p2.samsung.com>
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
 mm/shmem.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8b3823e4d344..836d44584796 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -869,16 +869,16 @@ unsigned long shmem_partial_swap_usage(struct address=
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
+			swapped +=3D (folio_nr_pages(folio));
 		if (xas.xa_index =3D=3D max)
 			break;
 		if (need_resched()) {
@@ -1006,10 +1006,12 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
 			folio =3D fbatch.folios[i];
=20
 			if (xa_is_value(folio)) {
+				long swaps_freed;
 				if (unfalloc)
 					continue;
-				nr_swaps_freed +=3D !shmem_free_swap(mapping,
-							indices[i], folio);
+				swaps_freed =3D folio_nr_pages(folio);
+				if (!shmem_free_swap(mapping, indices[i], folio))
+					nr_swaps_freed +=3D swaps_freed;
 				continue;
 			}
=20
@@ -1075,14 +1077,16 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
 			folio =3D fbatch.folios[i];
=20
 			if (xa_is_value(folio)) {
+				long swaps_freed;
 				if (unfalloc)
 					continue;
+				swaps_freed =3D folio_nr_pages(folio);
 				if (shmem_free_swap(mapping, indices[i], folio)) {
 					/* Swap was replaced by page: retry */
 					index =3D indices[i];
 					break;
 				}
-				nr_swaps_freed++;
+				nr_swaps_freed +=3D swaps_freed;
 				continue;
 			}
=20
@@ -1528,7 +1532,7 @@ static int shmem_writepage(struct page *page, struct =
writeback_control *wbc)
 	if (add_to_swap_cache(folio, swap,
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) =3D=3D 0) {
-		shmem_recalc_inode(inode, 0, 1);
+		shmem_recalc_inode(inode, 0, folio_nr_pages(folio));
 		swap_shmem_alloc(swap);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
=20
@@ -1801,6 +1805,7 @@ static void shmem_set_folio_swapin_error(struct inode=
 *inode, pgoff_t index,
 	struct address_space *mapping =3D inode->i_mapping;
 	swp_entry_t swapin_error;
 	void *old;
+	long num_swap_pages;
=20
 	swapin_error =3D make_poisoned_swp_entry();
 	old =3D xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1810,13 +1815,14 @@ static void shmem_set_folio_swapin_error(struct ino=
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
+	shmem_recalc_inode(inode, num_swap_pages, num_swap_pages);
 	swap_free(swap);
 }
=20
@@ -1903,7 +1909,7 @@ static int shmem_swapin_folio(struct inode *inode, pg=
off_t index,
 	if (error)
 		goto failed;
=20
-	shmem_recalc_inode(inode, 0, -1);
+	shmem_recalc_inode(inode, 0, folio_nr_pages(folio));
=20
 	if (sgp =3D=3D SGP_WRITE)
 		folio_mark_accessed(folio);
@@ -2663,7 +2669,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
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
