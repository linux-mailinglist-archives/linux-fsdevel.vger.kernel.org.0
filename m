Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141569CB66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjBTMuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjBTMte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:49:34 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F4A1D926
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:57 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220124856epoutp03773f388002b43173f10038a6406cbbec~FiT4yLXrE2510525105epoutp03n
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220124856epoutp03773f388002b43173f10038a6406cbbec~FiT4yLXrE2510525105epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897336;
        bh=5O5uDT9HWnn4Ccadtd7fTCupkIwM/OnWfdBNErBUieg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNHLaOh3lTOgYIzmSQl5ZbwHB/rdw00sfDhX2UqH1bs8saMaLXcYlSB9vyxKdNgYX
         hK2JKmqZ1mbqm1PFrJuGOGJ4DiS15lYjbXESLf/x+iUV9ceiDTWhCs4I3P4s7tokuv
         OQ1T1Wnaqh/NkBGT7oYD89PMyZFsH6DVfaMqraAw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230220124855epcas5p11f6e306337a2a81f22a3588e359c4fb6~FiT4DRVI62749127491epcas5p1C;
        Mon, 20 Feb 2023 12:48:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PL2Kf0Mrnz4x9Px; Mon, 20 Feb
        2023 12:48:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.26.10528.53C63F36; Mon, 20 Feb 2023 21:48:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220105537epcas5p386dd5c28197f055a8c548cca109d913c~Fgw8_Lpoe2700227002epcas5p3E;
        Mon, 20 Feb 2023 10:55:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220105537epsmtrp1985e2196bc7179a54716b408366f4246~Fgw88qAW12386223862epsmtrp1M;
        Mon, 20 Feb 2023 10:55:37 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-b6-63f36c35ca5a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.9C.05839.9A153F36; Mon, 20 Feb 2023 19:55:37 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105534epsmtip21c8292d59ac36a9accd9a5a1b5b20633~Fgw58o2620727007270epsmtip20;
        Mon, 20 Feb 2023 10:55:34 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 8/8] dm: Enable copy offload for dm-linear target
Date:   Mon, 20 Feb 2023 16:23:31 +0530
Message-Id: <20230220105336.3810-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRTvu3df4GxeF4IPnGxbkuSxsGvs+q0jZkF6jYZhZKYBpYFtuQGx
        r9ldAjSV5SFi8dJkYIHwgQZYIIjEwy1nGSRgGTBUUEOowUZRHkYDEtG2y4Xyv9855/f7zjm/
        bw4H533J9uQkqQ2UTi1XCljOjJZOny1CiXJOIRqdlaGG3hs4yixaxtGl0UIWKpldxNFS/wCO
        zNPlTHT3ehuGrp07iaHaS10Y6jj7DENdtikWOmm5A9DD2yYMme/5oWvmHgYaaq9goaqLD9nI
        cioLQ60TRoBalqpwVP9khoF+urcRDSx3M3e5k0O3wkjTWD+LbDONssmBB40Mcqg/hWyqy2OR
        V6qPkh13M1hkfta0nZAzxiRnfrjNIgua6wB5pe8QOde0iWyamMIi1u9P3pFIyeMpHZ9SKzTx
        SeqEYEFYZGxIrEQqEgvFMrRNwFfLVVSwIPSDCOHuJKXdAgH/M7kyxZ6KkOv1gsCdO3SaFAPF
        T9ToDcECShuv1AZpA/RylT5FnRCgpgzbxSLRVomdGJecaCy9AbRGZtr31kpmBihlnABOHEgE
        QVtzM/MEcObwiA4Arb89wejgDwCbTRcAHcwDeDm7krUm+evyjwy6YAZwOO80TgdZGDxeMmXX
        czgswg/22TgOgSvxCwbb+rwcHJwYx2BVZjVwFFyIUPjzqRbMgRnEZmj8xriCuYQMZjwqWHkH
        EoGwcGyDAzoR2+FCdjrN2AB7yiZWVsCJ12DW1fKVESBx3gkutpSx6UFD4dh8G5PGLnCyu3k1
        7wkfFx5bxamw9qsaFi3OBtA0bAJ04W2Y01uIOxrjhA9saA+k06/C0731GN34ZZi/NIHReS5s
        /XoNe8FvG86smuUB7ywYVzEJq5+2smiv8gHMnq5jFwG+6YWFTC8sZPq/9RmA1wEPSqtXJVB6
        iVasplL/+2WFRtUEVs7Cd28rGB2fDbAAjAMsAHJwgSvXxp1T8Ljx8vSDlE4Tq0tRUnoLkNj9
        LsY9X1Fo7HelNsSKg2SiIKlUGiR7SyoWuHPfDO5R8IgEuYFKpigtpVvTYRwnzwys3O33alFy
        PePg53M9f+4Z+YQXLLE9nQ/8h9FOGEMKRsaP3Bfe4ruQUFkZHu5bse1Q9J7a6nWTX8x7uj36
        O+m5ZNNWs/dCacXHNetyFh5EWT8UnGXGXVca3reWukVfzG4cfK9IHcjJS4/pn/Z9HDFcax7c
        7y2s2v3RvsyZzJhBcUdxRV07OOzvfKDvJf/UxrK0q87+pG5frp/l+bm01+M+jdlydH4yzb3+
        u3iPqKiR+wMH0r3FLr/uZat5775zZLj42YWh8+sLpOxOxs3NzeqQkJHU7jB2ZFincHHjzvBd
        A/3RuXxr082uZZXwmKvVxwuNRIZ01xw/LKueLC2xUbo3llStuQKGPlEu9sV1evm//v2hr58E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO7KwM/JBg2P1C3WnzrGbNE04S+z
        xeq7/WwW0z78ZLb4ffY8s8Xed7NZLW4e2MlksWfRJCaLlauPMlnsXviRyeLo/7dsFpMOXWO0
        eHp1FpPF3lvaFnv2nmSxuLxrDpvF/GVP2S0OTW5mstjxpJHRYtvv+cwW616/Z7E4cUva4vzf
        46wO4h6Xr3h7zLp/ls1j56y77B7n721k8bh8ttRj06pONo/NS+o9dt9sYPPobX4HVNB6n9Xj
        /b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KO4bFJSczLLUov07RK4MhpnHGMsaGSt2H5mLmsD
        4wyWLkZODgkBE4lfG/YD2VwcQgK7GSUeP33DDpGQlFj29wgzhC0ssfLfc3aIokYmiR93PrB1
        MXJwsAloS5z+zwESFxF4xiRx9t4jZhCHWeAdk8Sqh8tYQbqFBVwkLk3exgRiswioSjQubwSz
        eQUsJRpe9DGBDJIQ0Jfovy8IYnIKWEl8b6kEqRACqjgxaTMjRLWgxMmZT8COZhaQl2jeOpt5
        AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEezluYOxu2rPugd
        YmTiYDzEKMHBrCTC+5/3c7IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1ML
        UotgskwcnFINTJ6BjLwR/TdntN5RW8RTruO+lTHrdaVca+yt5xvDrVZYHdtxgd/fg7OH6dRa
        l4vF5sJHt6roLYhVOPhTyjHljffq63LrE0WbhVZeefDDIaQs8WZ6zYY412teF1n5PyVbXP92
        fqmHssHada/Zkvb08hw88IfjVohM5iG2jX4rz/w6PaOqjL0wIkOzYrHnM3XH2GtynKaSGWtE
        70dFvF4tNNONLXfK/+MO/amxEZzhejbNn6RzYndyHrzs8s7h+Vz3PwVa8vbHmr22Re1Uvh8s
        yXHnmfRb2WaJugNPa3VSlKefNJfqS07PXJW9Zqv5gXdBEtrfJgos9DnHvPEHY+jUy+df2wTu
        fLAkR2avmpaQEktxRqKhFnNRcSIADQTqTVUDAAA=
X-CMS-MailID: 20230220105537epcas5p386dd5c28197f055a8c548cca109d913c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105537epcas5p386dd5c28197f055a8c548cca109d913c
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105537epcas5p386dd5c28197f055a8c548cca109d913c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 3212ef6aa81b..b4b57bead495 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2

