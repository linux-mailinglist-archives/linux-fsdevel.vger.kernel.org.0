Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8537A65D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjISN4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjISN4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127BBF1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:51 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135549euoutp02472cc63f88cbe9fa8e1c4555b10ff9ec~GUVhqbVBv1619216192euoutp028
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230919135549euoutp02472cc63f88cbe9fa8e1c4555b10ff9ec~GUVhqbVBv1619216192euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131749;
        bh=LMHYH9ZTyrJA3zeIZ8Cw61+9DcuHoaxdnpNBuheefF0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=S/I8tzNocRjVASDHLDVbZG1o0m5ySXDg7TpgNah3igHxxkIwUNZaIoedmh5F0HTBW
         dQo39hU3zNUXeSOhpV4FI2QiTwztjIioq1rd7Fsu8ItAWEjIVj4OLU9qcBike/4XPs
         KUXaM379aAsK8wBVtRcwGb7tZ3MbF+HOcWNmVaPI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919135549eucas1p214bb8ae09e148c563a02f19655c58a3a~GUVhZ4Z1R1835818358eucas1p2Q;
        Tue, 19 Sep 2023 13:55:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.D1.42423.568A9056; Tue, 19
        Sep 2023 14:55:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135549eucas1p1f67e7879a14a87724a9462fb8dd635bf~GUVg-ov7A0405704057eucas1p1k;
        Tue, 19 Sep 2023 13:55:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230919135549eusmtrp2a092f04f72f32deca907d314cdbdbe2a~GUVg_3kxB2320823208eusmtrp2r;
        Tue, 19 Sep 2023 13:55:49 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-68-6509a8655322
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 00.55.14344.568A9056; Tue, 19
        Sep 2023 14:55:49 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135548eusmtip10e8f5eaa57c7ececc0fd70ba9f61c00f~GUVgvl2li1382813828eusmtip1a;
        Tue, 19 Sep 2023 13:55:48 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:55:48 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:48 +0100
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
Subject: [PATCH v2 2/6] shmem: return freed pages in shmem_free_swap
Thread-Topic: [PATCH v2 2/6] shmem: return freed pages in shmem_free_swap
Thread-Index: AQHZ6wD9pblMkq2/yUu1kd4yGg7G6w==
Date:   Tue, 19 Sep 2023 13:55:47 +0000
Message-ID: <20230919135536.2165715-3-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH973nueeeO07PXakvkjk/NsXphD1NrE3y+JU2P4fFqa/OXCd3
        Hfm5hriaYSrc0+knSYXdlTqnQkwlJ2lomSy7s2Q0ISoV3XNZ/70+e38+n/f7s31ITFrHn0ju
        1iQgrUaplhEivPxJ7/M5qFCIAiseTKVNt0sIuvjdOYJudoyjnd1ncbqqNYCurKrH6WabiaDb
        Sob4tO2PVUC3nHcCuuBnl4C+Z84j6P7fJiJUzGQmNeFMjkXPlBb6M812PWMpSiEYS/cFAVN3
        uR9nvlv8IsktopAYpN69H2nnLtkhUhWYF8Z3eSQabj3Bk8DjsalASEJqPmz4XANSgYiUUoUA
        /mIbsWFBSv0AsONUECd8B/DNp1fYyESuPYPgmq4D2Nc05X9Tzi0TxhXPALx420xwxQ0A29p7
        XOMENQtW11sEw4IXlcmHj/INYFjAqGOw5COLD7MnFQYNvXaXhxe1AjqbTgOO5fD+O6uLcWoG
        NL/Kdy0VU4vgi4osFwupENhy5bhrFlCT4YcbfQJuvw9sdWTzuBskMC+z0n2PNxy0tRMcz4b2
        Nw7AcSC8c60a51gG/xhy3TnlsCUjneA4ABbkfnZnkMB6o8Pd3yeEaUOLOA6DyaZzbi9P2Flb
        JuDYFw7dzeadBwHsqHjsKAt2lAU7yiIH4EXAB+l1cbFIp9CgA3KdMk6n18TKo/fGWcC/Z2sY
        rO22giud3+Q1gEeCGgBJTOYlNioIJBXHKA8eQtq927V6NdLVgEkkLvMRByyuj5ZSscoEtAeh
        eKQdUXmkcGIST3FyRfnhhKXq0Bco0cROUonqqjaaaxudL7MsANsqKmXa0aYWMt1DctU//URM
        RGuw3VtT/nZwjON1ePLKpOL37MaZ6FL7/jtyrDiwR1pabT+zaaU08eCS7Ghzx7zZ24wV6ulR
        Z/ubJEUDR6+drLZf/src25y2YA0vOD+mrOvtEQ+VIKuk098wX/Ywmep6dqQh96Zx+a70Xv74
        uFr1Molf25zHptZtqoEwPZjWU5nhVKz2nXYodd+6cJvYlHIiLG1eg7zNe4F1w3pE+wZvduwM
        Ck+tEh84mqU97eVbNOTJfmiMf3om0roran0EP++CIWTVAOiIWjfLO+iLca2tcUJZmQzXqZQK
        f0yrU/4FbUoWZ9sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsVy+t/xu7qpKzhTDVbsZLOYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZyzaaFbznr+hYd4yl
        gfEITxcjJ4eEgInEwrNT2boYuTiEBJYySrQsOssOkZCR2PjlKiuELSzx51oXVNFHRomrs6ZD
        OWcYJf6e7YRyVjJKHHq0mBGkhU1AU2LfyU3sIAkRgdmsEocXd4AlmAXqJNY8m8UCYgsLuEh0
        /DzLBmKLCHhKPL3Yzghh60nsv7sDzGYRUJXYeHUxM4jNK2AtcWH7PDBbCMh+tXA12H2cAjYS
        N+Y2gc1hFJCVeLTyFzvELnGJW0/mM0H8ICCxZM95ZghbVOLl439Qv+lInL3+hBHCNpDYunQf
        C4StJPGnYyHUzXoSN6ZOYYOwtSWWLXwNdY+gxMmZT1gmMErPQrJuFpKWWUhaZiFpWcDIsopR
        JLW0ODc9t9hIrzgxt7g0L10vOT93EyMwQW079nPLDsaVrz7qHWJk4mA8xCjBwawkwjvTkC1V
        iDclsbIqtSg/vqg0J7X4EKMpMIwmMkuJJucDU2ReSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
        emJJanZqakFqEUwfEwenVANTff6bezpsIlK1Bit5+ZkjHVpFf25Qnso4wWcXn+DcHfeeBWyf
        KXo1/M/Vq47HbfZqtVqGiVl9994+6VTqvj/hJh+Pzdh2zuaQrKlArATX0ld750upf3kTkpB2
        WPX++bgJz8wK/vYVJ9WLak8/tsHjieDTHatTV2vnGP5fau71YHZK0OkVWR1Xr1+XsI++adX0
        lXdHQPWBxR+/GK0OUpfRaz9r77hZ4VpGU1RgrdmjL6EcS9MPHH4mfuj9o5hmhZtPA7fu9W/w
        /vOtVff2/b0X3rh94TL9YGtbuXjfvX8NG+SNa/6F6v9/2dwiv8A5fXbVnpcHvv+fXcFeVH+o
        QHBRflZMl3bQ7HVaBfr+KyxMlFiKMxINtZiLihMBgbk09dkDAAA=
X-CMS-MailID: 20230919135549eucas1p1f67e7879a14a87724a9462fb8dd635bf
X-Msg-Generator: CA
X-RootMTR: 20230919135549eucas1p1f67e7879a14a87724a9462fb8dd635bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135549eucas1p1f67e7879a14a87724a9462fb8dd635bf
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135549eucas1p1f67e7879a14a87724a9462fb8dd635bf@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both shmem_free_swap callers require to get the number of pages in the
folio after calling shmem_free_swap. Make shmem_free_swap return the
expected value directly and return 0 number of pages being freed
to avoid error handling in the external accounting.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index de0d0fa0349e..5c9e80207cbf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -846,16 +846,18 @@ static void shmem_delete_from_page_cache(struct folio=
 *folio, void *radswap)
 /*
  * Remove swap entry from page cache, free the swap and its page cache.
  */
-static int shmem_free_swap(struct address_space *mapping,
+static long shmem_free_swap(struct address_space *mapping,
 			   pgoff_t index, void *radswap)
 {
 	void *old;
=20
 	old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old !=3D radswap)
-		return -ENOENT;
+		return 0;
+
 	free_swap_and_cache(radix_to_swp_entry(radswap));
-	return 0;
+
+	return folio_nr_pages((struct folio *)radswap);
 }
=20
 /*
@@ -1008,7 +1010,7 @@ static void shmem_undo_range(struct inode *inode, lof=
f_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed +=3D !shmem_free_swap(mapping,
+				nr_swaps_freed +=3D shmem_free_swap(mapping,
 							indices[i], folio);
 				continue;
 			}
@@ -1077,12 +1079,12 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, indices[i], folio)) {
+				nr_swaps_freed +=3D shmem_free_swap(mapping, indices[i], folio);
+				if (!nr_swaps_freed) {
 					/* Swap was replaced by page: retry */
 					index =3D indices[i];
 					break;
 				}
-				nr_swaps_freed++;
 				continue;
 			}
=20
--=20
2.39.2
