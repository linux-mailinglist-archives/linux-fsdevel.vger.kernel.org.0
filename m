Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529707A1B6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjIOJz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjIOJzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:55:10 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C18F30D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:52:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095127euoutp01595bc3e497149704ed5bd1f63e2b049e~FCbAsmE9a0810408104euoutp01W
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230915095127euoutp01595bc3e497149704ed5bd1f63e2b049e~FCbAsmE9a0810408104euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771487;
        bh=pQ5HIMyPnnwhcYJ76rc1mPPc+k+o81B2sKXtPyg4zdw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dRnQE4X3b17aD2oqDXZH5BTfLC+mfYSYB3NR2dMRflrnrl1BtrmPzKFgseY6oQpbQ
         ZzkRwa4nIp88Qnirv0XY2Ve9K2j2PL4EIuwJZYmEoBYkHzlKcZliBSpnqcK4cO017M
         XzHLOtBtiZ3MG74YPPkZIIJXV1cCDwNNHE5/9D/o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230915095126eucas1p2632b3b07d57634dee3bc87e2526e1769~FCbAZwO811725217252eucas1p2z;
        Fri, 15 Sep 2023 09:51:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.9A.42423.E1924056; Fri, 15
        Sep 2023 10:51:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095126eucas1p2cf75674dab8a81228f493a7200f4a1ba~FCbACyp_W0866108661eucas1p2R;
        Fri, 15 Sep 2023 09:51:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230915095126eusmtrp29f2fa2307f1978fafd648c484cebcafa~FCa-9WV9v1712217122eusmtrp2z;
        Fri, 15 Sep 2023 09:51:26 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-f4-6504291e5557
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.3B.10549.E1924056; Fri, 15
        Sep 2023 10:51:26 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095126eusmtip299bf0302eaf2d7781e72b80611f92e41~FCa-x_3a21112711127eusmtip21;
        Fri, 15 Sep 2023 09:51:26 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:25 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:25 +0100
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
Subject: [PATCH 2/6] shmem: drop BLOCKS_PER_PAGE macro
Thread-Topic: [PATCH 2/6] shmem: drop BLOCKS_PER_PAGE macro
Thread-Index: AQHZ57owSgjKzHCSYUqzwv9vQRCtyw==
Date:   Fri, 15 Sep 2023 09:51:24 +0000
Message-ID: <20230915095042.1320180-3-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCLcRzvtz179pSbe1rRj2a0K9S06s65B7WrcPfQddd5u0OHnZ6rWMvt
        afJ+ORzlpLxdrVLpZSuFJpNUunV6QURRhN7GqFxEE8toPXP67/Pyffl8f/fD2PxmzlwsVpFA
        KRUyuQh1QvSNP5/6Cr0Ryv/ag8VE9o0ylLj29hxKtBtnEu9HUxGi9rWYqKltQYj26myUeFf2
        h0NUT1Rxia6094AoHhvhEvcqrqKEZTwbDeaRWUnPEDJPpyJvaX3I9lYVqStNRknd6Hku2Zxh
        QchvOmEEttUpMIqSx+6jlH7SnU4xZj2y9xNnv+VYOicJmJAU4IhBfCnUlkyAFOCE8XEtgHWf
        h1kM+Q6gxvwKYci3SZJhQv+15DZa7YYGwOTC7v9VDfphO3kMoF7fZyclAFb3lnJs/SjuDeta
        dFyb4YpncWBDwWlgM9j4UVj2QT2VywVfBvXPU1g27IqvhL0VL9gMlsB3D/sndQxDcC944g5l
        k3mTJT/SLkzJjnggHBlPtMkAnwf7S35xmelu8LUxl8Wc4AyvZtWwGTwbWqv77Kctga2dRsBg
        f3i7qM7+SiI4cTrfnlICuy5dRBkshsX5Q2wmgjNsyTRO3QtxqyPUm56xbXkgvhoammOZOS5w
        sKmSy2AB/HM3l5UGxOpp8dTTVqinrVBPW5EHkFLgRqnouGiKDlBQiRJaFkerFNGSXfFxOjD5
        2R5Zm0arQM7gV4kBsDBgABBji1x5aBCL4vOiZAcOUsr4HUqVnKINwB1DRG48cVDLLj4eLUug
        9lDUXkr5z2VhjnOTWH6CHp+siDeCSBfKsqFyvYPWvL08vujKj4Qkl6/ybto3RhTu/URrXm3x
        MvV4hhVIIxVyaU5ZQLRoFurhcXZNyMuh39LL9aH9Bq/kAjJg6UbfA7maRN9mzwvPTSiiOeI1
        Z+zLTYct/ML4PfXrb3R4NqYWcMW7NXXCorYxrPejx/U3QYuGQv1Uiu5TrsMh6e73vhjn+1ee
        WRiydaBWePikoONhz6oRE2dtmCD96KLRF8sHex3U1szC47+s5s4a6chAeWx98ZmhVYdTEsL8
        Q7fRL+dcDOa1GTZ3BgrT162IWD7WMMN90wJtt1E+0GG9H9FVrikUp/4WV433fTYEhwPdIb0I
        oWNkAT5sJS37C3e+/ZnbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsVy+t/xe7pymiypBjs6uSzmrF/DZrH6bj+b
        xeUnfBZPP/WxWOy9pW2xZ+9JFovLu+awWdxb85/VYtefHewWNyY8ZbRY9vU9u8XujYvYLH7/
        mMPmwOsxu+Eii8eCTaUem1doeVw+W+qxaVUnm8emT5PYPU7M+M3i8XmTXABHlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gt20sBS9ZK343TmRt
        YHzO0sXIySEhYCIx/9g/MFtIYCmjROcrX4i4jMTGL1dZIWxhiT/Xuti6GLmAaj4ySqw8sh/K
        OcMo8eHFLhYIZyWjxIY/n5hBWtgENCX2ndzEDpIQEZjNKnF4cQcjSIJZoE5izbNZYPuEBcwk
        tl3qYgKxRQSsJR5svMoMYetJ3Dv1CCjOwcEioCrRsj0VJMwLVPJ9wmSwsBCQPWu6F4jJKWAj
        8f5HOUgFo4CsxKOVv9ghFolL3HoynwniAQGJJXvOM0PYohIvH/+DekxH4uz1J4wQtoHE1qX7
        oIGiJPGnYyHUwXoSN6ZOYYOwtSWWLXzNDHGNoMTJmU9YJjBKz0KybhaSlllIWmYhaVnAyLKK
        USS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMDFtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMLLZsuU
        KsSbklhZlVqUH19UmpNafIjRFBhAE5mlRJPzgakxryTe0MzA1NDEzNLA1NLMWEmc17OgI1FI
        ID2xJDU7NbUgtQimj4mDU6qBqbB6f//C1Zwhr5xnrz01bdr361KegsJSb2a9fxgxwfbigj8B
        k5g/cLGX8vz/cWXK7O8lYdPO77n5KOTx5AIFvp816suWr1D3YtgfEq3tLHg9wXTK9CdbAqSq
        o/bF2Vkyvd++v22h3qve/pKSsjdmuybrrjvQ8+Oo2dZJ2kvXC888rbH6TERFjc38gP7Qp/6z
        zzv1Cfq8E9vmJr8qw2HJ0gnJSSkR3HdKbXoX+XzZZ3+h+/UE1bwOzR1K/XPN/15KeRpWvcXk
        Wlm7tf+TD7vfnVinP/U6j+Yk8/XzHTIVnu2WU1qrmr4v8Is3++FW5VNp3a6zRepbRO/Eaa24
        dPW/wVybc3lSVY65Tptmrf776qESS3FGoqEWc1FxIgB/H/s+1QMAAA==
X-CMS-MailID: 20230915095126eucas1p2cf75674dab8a81228f493a7200f4a1ba
X-Msg-Generator: CA
X-RootMTR: 20230915095126eucas1p2cf75674dab8a81228f493a7200f4a1ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095126eucas1p2cf75674dab8a81228f493a7200f4a1ba
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095126eucas1p2cf75674dab8a81228f493a7200f4a1ba@eucas1p2.samsung.com>
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
index 13c27c343820..8b3823e4d344 100644
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
