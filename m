Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4079428D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjIFR5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjIFR5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:57:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5090B1BF0
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:56:17 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230906175450epoutp03439f73b58b80228a3ff84242af5a1c4d~CYNgIu0R_1073410734epoutp03u
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230906175450epoutp03439f73b58b80228a3ff84242af5a1c4d~CYNgIu0R_1073410734epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022890;
        bh=cp2ikyfpBdIhGRYkH19yhVPh/sP+Xdj/kjqikt163DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bV2ir3gQOe1fpgr4f2YzwAWqThcrcGdO/vzCQ6cwIIwhUw0iMe0bcbKQiGmhjxXlk
         CjR9dZQF/hsELxhM/ZXHQ4GukJJyQ0F4B/Tl7nawAVD6jDMeE8V4D933lu/nSr9BRC
         MZEHcEPgBUsVPkT+0hk+WrpPGZzSO742Wmq24FhI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230906175449epcas5p3a03142c635347310a21db04630b793c7~CYNfUYMVQ0403304033epcas5p3t;
        Wed,  6 Sep 2023 17:54:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RgqlD1Hltz4x9Pq; Wed,  6 Sep
        2023 17:54:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.13.09949.8ECB8F46; Thu,  7 Sep 2023 02:54:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230906164416epcas5p307df0f4ab0a6a6a670fb50f6a8420a2a~CXP4zlm2w1472314723epcas5p3z;
        Wed,  6 Sep 2023 16:44:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164416epsmtrp2a5f2722840cb3de7f54043bc47d8302f~CXP4ypflQ1133211332epsmtrp23;
        Wed,  6 Sep 2023 16:44:16 +0000 (GMT)
X-AuditID: b6c32a49-bd9f8700000026dd-0b-64f8bce8f1f8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.D9.18916.06CA8F46; Thu,  7 Sep 2023 01:44:16 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164413epsmtip2055169562ca828d92df5bb5649e38570~CXP2SHi2N0470904709epsmtip2E;
        Wed,  6 Sep 2023 16:44:13 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 10/12] dm: Enable copy offload for dm-linear target
Date:   Wed,  6 Sep 2023 22:08:35 +0530
Message-Id: <20230906163844.18754-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeuff2ciHrdqkwjjiVdJkR5NWt1MsmbJkwrtNMErKYMSIr9Kaw
        Qtv0Fp3GhCIPEcOrCkJFW4Q4qK48ZIyHOAcbDBjDjcEEw1SkBEUBLbI5Aqzthc3/vt93vu/3
        OucQqGAO9yaSlVpGo5SmCHE3rLnLd3vA9LW/ZcGVYxhV19eNUpfHC3FqpuspoCZvnABUx+w5
        HjV6oxWhai//iFD6zhFAWYcNCNUxtoOqzKnGqGsdvRg11FaBU8ZLVhfqq54VhLpVZAVU85IR
        pSwzcxj109gmanC5h/e+Bz34ZwNGDw2k0Y3mkzh9tTqdbh/V4XRVwWkenZ85i9NPrGMYPXd9
        GKcLmsyAtjVuoRsnHyPRL8cqdiUxUhmj8WGUiSpZslIeJtwbE787PkQSLAoQhVI7hT5KaSoT
        JozYFx3wYXKKfUyhzyFpSpqdipayrDAofJdGlaZlfJJUrDZMyKhlKWqxOpCVprJpSnmgktG+
        IwoOfivELvxckXTWfJanzuB9ObX8Pa4DZVgecCUgKYZXjI/wPOBGCMh2AM3GUsAFTwG06Fd4
        DpUzuJ9xcN1x+odanONbASxq5XGGbAQW59bb3QSBkztg/yrh4D1IHQrr26ucWVHyJAL7l/qd
        7g1kFFz9Jxc4MEa+CQee5SMOM598F1ptcQ4IySBYeMfdoXC1s8czfnWq+aQ77C2fdE6Aklth
        5jfnUEd6SC4Q8LnFhnONRsC7+u94HN4AH/Y0uXDYG9pmO9Y0h2HtmRqcM2cBaPjDALiD92B2
        XyHqaAIlfWFdWxBHb4YlfRaEK/wKzF+aRDieD1surOM34JU601r+jXDkr4w1TMPKkYm17RYA
        aDLluBQBH8MLAxleGMjwf2kTQM1gI6NmU+UMG6IWKZnD/11yoiq1EThfvt+eFjB+dz6wEyAE
        6ASQQIUe/NmtizIBXyY9cpTRqOI1aSkM2wlC7PsuRr09E1X2r6PUxovEocFiiUQiDn1bIhJ6
        8Weyz8sEpFyqZRQMo2Y06z6EcPXWIZ8M9Clk3Y96jCsVOSOqFjJmrxz4xjb0RuyvfLL90r6j
        vQ+yEuRhS0Tb6vR5xTiJuIh2xj10/8zvIps5Ii7PWlm8PXFnU/1CqdhL7lc9GinpvDjeNSF6
        vvxLeq6n5xf5JteoZ6aaCnnxq1djkAOnrB+dmPzga3VeVaC42oY9OBan+H1622vNZVOeC0cs
        e24O049DEoea6d8Mx66Hfyoyv1Tonh+hTzhwwS/qY33k5vLFW1MGr6b9ZYO+2+77ixO39E7d
        u1fDdFvkitj5zNKlhtL6eot/ZM1NY1D78d20oD28QVf7evpt8UGspKukgUkt9dcsyk8JvBPm
        03/+1q3SFnlIJ8TYJKnID9Ww0n8BmvMluIIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvG7Cmh8pBveWqVqsP3WM2WL13X42
        i9eHPzFaPDnQzmix991sVoubB3YyWaxcfZTJYtKha4wWT6/OYrLYe0vbYmHbEhaLPXtPslhc
        3jWHzWL+sqfsFsuP/2OyuDHhKaPFtt/zmS3WvX7PYnHilrTF+b/HWR1EPM7f28jicflsqcem
        VZ1sHpuX1HvsvtnA5rG4bzKrR2/zOzaPj09vsXi833eVzaNvyypGj8+b5Dw2PXnLFMATxWWT
        kpqTWZZapG+XwJUxfdV01oJG1opnfw+yNTDOYOli5OSQEDCRmHxkJVsXIxeHkMB2RokNq/dC
        JSQllv09wgxhC0us/PecHaKomUnix7EHQEUcHGwC2hKn/3OAxEUEupglOne+YwFxmAUmM0ms
        Or8UbJKwgLvE/18djCA2i4CqxNmvvUwgzbwC1hJPP8eAmBIC+hL99wVBKjiBok2NF8GqhQSs
        JO6seg1m8woISpyc+QRsIrOAvETz1tnMExgFZiFJzUKSWsDItIpRNLWgODc9N7nAUK84Mbe4
        NC9dLzk/dxMjOBq1gnYwLlv/V+8QIxMH4yFGCQ5mJRHed/LfUoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYglsTrvFsaZQVWtl7dNnHnQ0qKetcd058
        xPnmh5OEeABrZLfuibD9j7jClc6x35lruKP4/bF1onKT5dQ+6F2aeNFIonLLOofvTr+UeE4X
        zF5dp9DZ0Xr79Rt/PWuraianOoVSD7aFO7/9sM84v9zMb0NFzrYtHtHPorKO/X9i4XaM6fVt
        E5Zci9+Wfx+2pJ+3i9jGNOf6+WV/jS7W5tkHNtfXXtf4P+WiqM26SU+8NmTM+e3DJ3b7ROX2
        zOCDXB062ZKWgmZr6x539xnrGqnsir7NueTXcwfVH10v71esu215RVvSO91m444XHNLlB9ty
        r6m4MnxN43W9sIm5+WJa7MSVeTrzPzQFzL+n+EBeiaU4I9FQi7moOBEAhMsC/zUDAAA=
X-CMS-MailID: 20230906164416epcas5p307df0f4ab0a6a6a670fb50f6a8420a2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164416epcas5p307df0f4ab0a6a6a670fb50f6a8420a2a
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164416epcas5p307df0f4ab0a6a6a670fb50f6a8420a2a@epcas5p3.samsung.com>
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

Setting copy_offload_supported flag to enable offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index f4448d520ee9..1d1ee30bbefb 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2

