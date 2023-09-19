Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414CE7A65D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjISN4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjISNz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:55:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2699E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:49 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135547euoutp01023f9304419c91058c0e3f33a03be739~GUVf2eH5U0107701077euoutp01y
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230919135547euoutp01023f9304419c91058c0e3f33a03be739~GUVf2eH5U0107701077euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131748;
        bh=FJQ8bvj/9Vs0utzuzFMcJ8GvK3wVEgVmfOOT/zQHcR0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=l9ajOekSgv9RJzUXI0V8msKFF5QnkT/CJnUhsjgVD4NdUPFXlfLckYb/3xjPj1PMZ
         qDkcM4L8ZFiYKUzR1tsXO5xr2fKk9prRBIhzl2ifkSItG4oZc34Lv7GRHghtd+6W+W
         3C31ybcUB+q8s1eGeGnseu+HDZ7Gakffjb4/dqH4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919135547eucas1p2511a5d8752168f2baa949be8ea4c10a6~GUVfeg3WY1636016360eucas1p2j;
        Tue, 19 Sep 2023 13:55:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3F.7E.11320.368A9056; Tue, 19
        Sep 2023 14:55:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230919135547eucas1p2777d9fde904adf4c2d0ac665d78880c1~GUVfBq4u22317523175eucas1p27;
        Tue, 19 Sep 2023 13:55:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919135547eusmtrp11e24cd154302622eacc81ec4f96cfcad~GUVe-9IqC2584925849eusmtrp1G;
        Tue, 19 Sep 2023 13:55:47 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-b6-6509a863472c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A5.C9.10549.268A9056; Tue, 19
        Sep 2023 14:55:46 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135546eusmtip1c60ef7b891afff594b8a2c51fcc57d87~GUVewBDRA1313713137eusmtip18;
        Tue, 19 Sep 2023 13:55:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:55:46 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:46 +0100
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
Subject: [PATCH v2 1/6] shmem: drop BLOCKS_PER_PAGE macro
Thread-Topic: [PATCH v2 1/6] shmem: drop BLOCKS_PER_PAGE macro
Thread-Index: AQHZ6wD8QPBGKC1ahkW+sk1T2Ar7wQ==
Date:   Tue, 19 Sep 2023 13:55:45 +0000
Message-ID: <20230919135536.2165715-2-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djPc7rJKzhTDY73y1rMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6MrZM2MBe8ZK2YvrmRpYHxOUsXIyeHhICJxJW+r2xdjFwcQgIrGCWOrDnMCuF8YZS4
        tXQlI4TzmVFic+Nx5i5GDrCWiW+YIOLLGSV6jjcwgowCK9p0SgkicYZR4triA1DdKxklXlze
        zgxSxSagKbHv5CZ2kISIwGxWicOLO8DamQXqJNY8mwV2lbCApcTnzW/BbBEBO4k3d9YwQth6
        Env23wezWQRUJY6f+cQEYvMKWEs83PIArJ5TwEbixtwmNhCbUUBW4tHKX+wQ88Ulbj2ZzwTx
        taDEotl7mCFsMYl/ux6yQdg6EmevP2GEsA0kti7dBw0lJYk/HQuh7tSTuDF1ChuErS2xbOFr
        ZogbBCVOznzCAvKYhEATl8TZu09ZIZpdJFYsu8YOYQtLvDq+BcqWkTg9uYdlAqP2LCT3zUKy
        YxaSHbOQ7FjAyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMLmd/nf8yw7G5a8+6h1i
        ZOJgPMQowcGsJMI705AtVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILU
        IpgsEwenVANTldV+y387X4Q/k5g44eSeaR/vvbgmJfzmx6rzz7bp6Ul8ejrZW5V9hZdWwy3F
        ypNlImxV75m+tGawr7P20L1/54HKRg+5lqmd55m42sLeMCxZVfh0y7bT62ZoTJjaaZ2a4F48
        I6Fx2W29o9Y6T657Nqvru7m/nNQ6U9L0zN5Nn5U/336VIXFa5+SyYwutetQ//PCQ+pggcPYd
        B39U97LmSx0rnRfbn+vRZnd04Jn25Xf4hLSYltQ1zF8vfIv0fGKkv2PlpA/qc9qtZGczTWY4
        wsu60T+QrVOzmJn1kq5HkKZ9MfOXLzz7T1Voqd//3xDbLj57aZ/4pA/OCm95jH/snrecu1VR
        e4nczjo7gc0XlViKMxINtZiLihMBGPzOg90DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsVy+t/xu7pJKzhTDbavtrGYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZWydtYC54yVoxfXMj
        SwPjc5YuRg4OCQETiYlvmLoYuTiEBJYySqzZ9outi5ETKC4jsfHLVVYIW1jiz7UuNoiij4wS
        O7Y8ZYFwzjBKzFvxgh3CWcko0fXjORNIC5uApsS+k5vAEiICs1klDi/uYARJMAvUSax5NosF
        xBYWsJT4vPktmC0iYCfx5s4aRghbT2LP/vtgNouAqsTxM5/AhvIKWEs83PIArF4IyH61cDXY
        fZwCNhI35jaB3c0oICvxaOUvdohd4hK3nsxngvhBQGLJnvPMELaoxMvH/6B+05E4e/0JI4Rt
        ILF16T4WCFtJ4k/HQqib9SRuTJ3CBmFrSyxb+JoZ4h5BiZMzn7BMYJSehWTdLCQts5C0zELS
        soCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZggtp27OfmHYzzXn3UO8TIxMF4iFGCg1lJ
        hHemIVuqEG9KYmVValF+fFFpTmrxIUZTYBhNZJYSTc4Hpsi8knhDMwNTQxMzSwNTSzNjJXFe
        z4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamkNvNi/evPzFhr84ORrf1G8RahI1/PjyRul/T8cqi
        z+uuitZX8sQHtOwKr0q7lPyhQL2BPbcx/luZo8LJYiUpn42TubfySTXnFgn2fzh3Po/b787E
        mthXT3j2Cnc83vZo8VSv1hPl77jYJ/Hnv4prmbR26RyN+Ip67hC+8JfnSv9k+JRP6D5x2GGD
        p+jmn8/Tkj7N1VCeW2urzGo2oe1G54rlFXed2+a2CvnLKlpW31Xjv+Zs+t3dv+Wl/M6wNSur
        njnOzw1fPu8bi9TXZLv/SbLHPxe9fxPuL8mz7pNUlkZCqFR5krL2/6uuKwxSNdLmnojPNz+s
        n80imsDqYvtcTVWw6t7Owi2NJ++sUlBiKc5INNRiLipOBACISM272QMAAA==
X-CMS-MailID: 20230919135547eucas1p2777d9fde904adf4c2d0ac665d78880c1
X-Msg-Generator: CA
X-RootMTR: 20230919135547eucas1p2777d9fde904adf4c2d0ac665d78880c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135547eucas1p2777d9fde904adf4c2d0ac665d78880c1
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135547eucas1p2777d9fde904adf4c2d0ac665d78880c1@eucas1p2.samsung.com>
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

The commit [1] replaced all BLOCKS_PER_PAGE in favor of the
generic PAGE_SECTORS but definition was not removed. Drop it
as unused macro.

[1] e09764cff44b5 ("shmem: quota support").

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index be050efe18cb..de0d0fa0349e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -84,7 +84,6 @@ static struct vfsmount *shm_mnt;
=20
 #include "internal.h"
=20
-#define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
 #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
=20
 /* Pretend that each entry is of this size in directory's i_size */
--=20
2.39.2
