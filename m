Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA770DC73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbjEWMWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjEWMWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD0119
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122232euoutp026b022286d8e5be26949eebac23d8f8fe~hxTGq1Mcu1935319353euoutp02K
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523122232euoutp026b022286d8e5be26949eebac23d8f8fe~hxTGq1Mcu1935319353euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844552;
        bh=8kGTrxkZCntknLjLjsK0zeP1J+VQ51ivte2ou+FOZlA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FK/UdKF1OaIEsOXkW6FoS+xt08om+EVf4h3E8VqTyRY60p/DB6mpIVkTvxemDln0A
         lge8QYTUC7knJ+UV82bR2OOtj09JEHVW8oQYGN6Lh2Ag14CfBHuvlUS5Q4GzoAxpkE
         TNee+tRV/UhJjiVNf58EmKlhoP/wO3BdNjOmPKpg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122232eucas1p173d4fa60efdbb3c391379bdb6d0ff71c~hxTGXd6JT2763627636eucas1p16;
        Tue, 23 May 2023 12:22:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.C8.42423.800BC646; Tue, 23
        May 2023 13:22:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122231eucas1p25c90d2764372faba72095f5c43715ffb~hxTF9E9dC3085530855eucas1p2i;
        Tue, 23 May 2023 12:22:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122231eusmtrp236193b3b4609bcfc19a39755bdc6d544~hxTF8Qiry0682206822eusmtrp2O;
        Tue, 23 May 2023 12:22:31 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-f6-646cb008d548
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.BF.10549.700BC646; Tue, 23
        May 2023 13:22:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122231eusmtip224feb914c22ef14a02b814f5059c99a3~hxTFydkTX2166421664eusmtip2d;
        Tue, 23 May 2023 12:22:31 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:31 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 4/8] parport: Remove register_sysctl_table from
 parport_default_proc_register
Date:   Tue, 23 May 2023 14:22:16 +0200
Message-ID: <20230523122220.1610825-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7ocG3JSDGafFLR4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxozbx1kKFvFWnO6/w9jA2MrdxcjJISFgIvFp4VaW
        LkYuDiGBFYwS0xeugHK+MEqcejabDcL5zCjRdHYOkMMB1jL5tDNEfDmjxO4pfxGK/i3+wwIy
        V0hgC6NES6M2iM0moCNx/s0dZhBbREBc4sTpzYwgDcwCO5kk+jtvsYEkhAWSJM6duQhmswio
        Slx58h/M5hWwlfj47iAbxLHyEm3XpzOC2JwCdhKHnu1jhagRlDg58wnYYmagmuats5khbAmJ
        gy9eMEP0Kkms7voDNadW4tSWW0wgR0gI/OCQWHfwI1SRi8SDj/OZIGxhiVfHt7BD2DIS/3fO
        h2qYzCix/98HdghnNaPEssavUB3WEi1XnkB1OEq0Np9mhgQYn8SNt4IQF/FJTNo2HSrMK9HR
        JjSBUWUWkh9mIflhFpIfFjAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMQKf/Hf+0
        g3Huq496hxiZOBgPMUpwMCuJ8J4oz04R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9
        sSQ1OzW1ILUIJsvEwSnVwGTr1H1xlZtv/0yLJLVDcxxkLq/eeCBVcJNSwL01qbzbTefUvrkZ
        r6ZwJ/0jy99aDfXjcV/Dk1/HzzQOUjC7XaO5kse913277MEdwrv1ltV/rrzsyvjfNFYm7OI/
        /WNGib928yo3VJY9mpVm+tnUgtdcJVox58lH86ms8REf17SxZxbtnvsxz7n+Utbm9aI9r9sf
        nbx88tvEp1Vv06MfLP67d/8Dz9bD1vtOLr2xLqM+2HuN4cLcqaWMC9+09UxbLL90nkLA3cD1
        udOeOf1+5HNF6HjdOnX2rAVTMi8kRzI0X97DfsP20PNrT+6ZWNvx3bK55D+vYePCpc3HT8l3
        38jSOL7B7Fp420uLxOnu/x8osRRnJBpqMRcVJwIAp0Pph68DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7rsG3JSDLrXm1m8PvyJ0eJMd67F
        nr0nWSwu75rDZnFjwlNGiwOnpzBbnP97nNVi2U4/Bw6P2Q0XWTx2zrrL7rFgU6nHplWdbB6f
        N8l5bHrylimALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvY8bt4ywFi3grTvffYWxgbOXuYuTgkBAwkZh82rmLkYtDSGApo8Ta/nmMXYycQHEZ
        iY1frrJC2MISf651sUEUfWSU+HhtLZSzhVFi8aM2dpAqNgEdifNv7jCD2CIC4hInTm9mBCli
        FtjOJDHh7y42kISwQILEm/ObwMayCKhKXHnyHyzOK2Ar8fHdQTaIdfISbdeng53BKWAncejZ
        PrB6IaCa1lcQvbwCghInZz5hAbGZgeqbt85mhrAlJA6+eMEMMUdJYnXXH6iZtRKf/z5jnMAo
        MgtJ+ywk7bOQtC9gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJ3bjv3cvINx3quPeocY
        mTgYDzFKcDArifCeKM9OEeJNSaysSi3Kjy8qzUktPsRoCvTnRGYp0eR8YHrIK4k3NDMwNTQx
        szQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgWnX22KmJIiZ+XP9r35Rf0Wz+9ffh
        hvC9E17kNN3Ynbpl+4Qg/wiNwlldk9Ze86mQqZw0y7OeM/CHU7qz358Pipp6sWdYfmr+nR/q
        cpwjeVtZ4cNsN01D9b7LGiXp0Zm/mOMO1UaLzO9s5yxuCvsgGyonGbKjplQ81imH1zBaRM7K
        LfbfVcn/28UlzVbUxp1f5njW8NeJvlanuVN1mzrvluxYXL9I7H7XCzvXtHdR+vuk9mc/mTfh
        9R72t3d/6dr5h85+OOOmovBtyX3n9L22ryj1XLa0ymDl8cr4zsK0qkU/W9eeDhF989bxysbl
        TXVbvZfrf+5gstqffWvS7n2r77y35VsSeOwD7+rpsy+HKrEUZyQaajEXFScCAHcZCflXAwAA
X-CMS-MailID: 20230523122231eucas1p25c90d2764372faba72095f5c43715ffb
X-Msg-Generator: CA
X-RootMTR: 20230523122231eucas1p25c90d2764372faba72095f5c43715ffb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122231eucas1p25c90d2764372faba72095f5c43715ffb
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122231eucas1p25c90d2764372faba72095f5c43715ffb@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. Simply change the full path "dev/parport/default"
to point to an already existing set of table entries (vars). We also
remove the unused elements from parport_default_table.

To make sure the resulting directory structure did not change we
made sure that `find /proc/sys/dev/ | sha1sum` was the same before and
after the change.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/procfs.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 22d211c95168..1a26918d2cc8 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -430,22 +430,6 @@ parport_default_sysctl_table = {
 			.extra2		= (void*) &parport_max_spintime_value
 		},
 		{}
-	},
-	{
-		{
-			.procname	= "default",
-			.mode		= 0555,
-			.child		= parport_default_sysctl_table.vars
-		},
-		{}
-	},
-	{
-		PARPORT_PARPORT_DIR(parport_default_sysctl_table.default_dir),
-		{}
-	},
-	{
-		PARPORT_DEV_DIR(parport_default_sysctl_table.parport_dir),
-		{}
 	}
 };
 
@@ -601,7 +585,7 @@ static int __init parport_default_proc_register(void)
 	int ret;
 
 	parport_default_sysctl_table.sysctl_header =
-		register_sysctl_table(parport_default_sysctl_table.dev_dir);
+		register_sysctl("dev/parport/default", parport_default_sysctl_table.vars);
 	if (!parport_default_sysctl_table.sysctl_header)
 		return -ENOMEM;
 	ret = parport_bus_init();
-- 
2.30.2

