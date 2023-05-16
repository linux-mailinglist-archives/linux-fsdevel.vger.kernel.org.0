Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C048F7053CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjEPQ3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjEPQ3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E77A93
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162923euoutp02301b72bd5f5ef5ffb0ee46344b849e64~frJodt8lR2992529925euoutp02G
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230516162923euoutp02301b72bd5f5ef5ffb0ee46344b849e64~frJodt8lR2992529925euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254563;
        bh=QM3sFZtH85rPrt7SJ5H3ajJQOzrfaGGNgWXGdQTwHFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JM0wBmoQbaXizCQJTdFgUE/1FIYdjMPrEqkzWSl2hxr3rOSk3daWyQuU8o780RZhb
         LcAEagI5PhK5Ha+0g2C/f+wGCeLQBpdI+bDjMslx4SkUrMBbXh86B10i0PXX6Z2eV3
         nuMo53tcBCdjIESnIK8NDPbRHSfaLfp4Dx8eLL0Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516162923eucas1p2ed66575c00c8648b61e44c055c689f71~frJoUIByf1671116711eucas1p2s;
        Tue, 16 May 2023 16:29:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.FF.35386.36FA3646; Tue, 16
        May 2023 17:29:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162923eucas1p17af1b1f69261818fc7a5b0ccc17ab6d3~frJn-OIbo2072920729eucas1p1x;
        Tue, 16 May 2023 16:29:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516162923eusmtrp1750348386b3201d2f62aa03c79acb38a~frJn_xMCR2056220562eusmtrp1F;
        Tue, 16 May 2023 16:29:23 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-4f-6463af638f02
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.57.10549.26FA3646; Tue, 16
        May 2023 17:29:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162922eusmtip168a2fd7639206b5420e32dd95669193c~frJn2EBNe0589205892eusmtip1y;
        Tue, 16 May 2023 16:29:22 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:22 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 4/6] parport: Remove register_sysctl_table from
 parport_default_proc_register
Date:   Tue, 16 May 2023 18:29:01 +0200
Message-ID: <20230516162903.3208880-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bO5nE5OU5rLxoFKymaziyThbns8seim13sDrm20xrOVTuu
        ZVFYSaYuqdTEzUooVDQo5jS1u6WpsyzNW04LNB1iF1FDxTTnWeF/v/d9nof3e+AjMP41ti+h
        1sZROq1cI+Rw8dLqsYZAxUOFcoVxaL6kPjVW8vRZLS5pqsjhSNquf0OSl7YMTJJXvj2CIzMn
        fMRl5aZON1muRS+zFCZzZEOWhZHsg9y1SkqjPk3pgqTR3OPPu1vwk989zhiffOAkoGZuCnIn
        gAyB7PsOTgriEnyyAEFLnZ3tFPjkMIKRN5GMMITgdeOk279E19RnFiPkI2hv7Mf/u2rNT1yD
        FYG14zVyRjhkADQM2DEn+5ACqLEVI6cJI78h6HpWxHEK3uRRyOxLnwngpD/UJT2cZoLgkeHQ
        OW5gTi+CK61ZMxZ3Ugo/H1hYTuaRXlCb3YM7GZv2XC4xYwwDvHI4MCYrhKQbX9kMn4c6K1MB
        yB4C7HUVLmETpP1JdfX0hv63VhcvAFu6EWcC6QheTP5yY4YiBHkXR1iMKwwSP/W4Eush3zo+
        0wBIT2j77sW8yBNulmZhzJoHV6/wr6MlplkdTLM6mGZ1yEVYIRJQejpWRdErtZRBTMtjab1W
        JVaciLWg6R9jm3w7XIby+wfFlYhFoEoEBCb04e1MUyj5PKU8/iylO3FEp9dQdCXyI3ChgCcK
        r1XwSZU8joqhqJOU7p/KItx9E1h0RYxB1X/VuO/CVIeoROx/LrTcHGbX1o+ldB02CUTqU62r
        Kz3vmFomztBjE3cbuncqXtUbtKmFo/MCHod8+h3v0bxqYa+4LLR41cfG7poBUWdw5r11h6P0
        gmu72b23iOqAxEOLlXFJPjm6LcsDwz1CQzaokw2BVcm5RQVp0SZBqDU4Z+ueZr+aXeYgvy9Z
        UY2Dzcc2I5Q9p0pW7tU0mcErmdtFKr2ljmjDg9uPordZNfc075umpPZ5KaJzyUupUWp8R9vm
        9nT3nxO5TTbN/l9i294fp/ue4w529YL2p2UrOpehA9IvQX3EYIRV/Q4Kq6NUa8LdjMaRjkv1
        G6uwUSFOH5cHL8d0tPwv9pIjqqADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7rJ65NTDJpbmCzOdOda7Nl7ksXi
        8q45bBY3JjxltDhwegqzxbKdfg5sHrMbLrJ47Jx1l91jwaZSj02rOtk8Pm+SC2CN0rMpyi8t
        SVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY9/gaS8Fbnoqe
        3RfYGhivcnUxcnJICJhI3Pt/i6mLkYtDSGApo8S+SSeZIBIyEhu/XGWFsIUl/lzrYoMo+sgo
        cXTlCWYIZwujRPOn/+wgVWwCOhLn39xhBrFFBMQlTpzezAhiMws8ZpSYc1AWxBYWSJC4ceE8
        WJxFQFXiVPt6IJuDg1fAVuLur3KIZfISbdeng5VwCthJvF+zCewgIaCSict7WEBsXgFBiZMz
        n7BAjJeXaN46mxnClpA4+OIFM8QcJYn2iQ+gHqiV+Pz3GeMERpFZSNpnIWmfhaR9ASPzKkaR
        1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDo23bs5+YdjPNefdQ7xMjEwXiIUYKDWUmEN7AvOUWI
        NyWxsiq1KD++qDQntfgQoynQmxOZpUST84Hxn1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCe
        WJKanZpakFoE08fEwSnVwCTzaeWJmrU9n/K/7Dlmc2vmpdIrf3f8N38ms8R4wl4x16BfP1a8
        8Guym606fWZhw+yG26XzizovPQqYuEUifVKRg6Aj35M0jQivraX7lXxeTWVYaVrNePNP6pMw
        +cdy76yvLloQWiSvH7WggP+CxLraE3Zbq9+Izjv953T+Nz32Xxac5x6wX4jN5Kl7y+g95bhu
        g9iR67mavinnXth8KLjoZREtfGpx3h5FJgVu2efG9w11rxvuS9PR3tS7jjWgS1jb8tbFewxW
        Bz8mz7y8TObpn2IuI5Ho5l0dMf22zzj9k3bb3tu9K/FErL9ZF4PUJdfXWQINZddk9P//tZ0a
        IGNz1v3y/SO72NzPfN1/+6oSS3FGoqEWc1FxIgAlHIsNRwMAAA==
X-CMS-MailID: 20230516162923eucas1p17af1b1f69261818fc7a5b0ccc17ab6d3
X-Msg-Generator: CA
X-RootMTR: 20230516162923eucas1p17af1b1f69261818fc7a5b0ccc17ab6d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162923eucas1p17af1b1f69261818fc7a5b0ccc17ab6d3
References: <20230516162903.3208880-1-j.granados@samsung.com>
        <CGME20230516162923eucas1p17af1b1f69261818fc7a5b0ccc17ab6d3@eucas1p1.samsung.com>
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
---
 drivers/parport/procfs.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index a2b58da1fe86..5a58a7852464 100644
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
 
@@ -596,7 +580,7 @@ static int __init parport_default_proc_register(void)
 	int ret;
 
 	parport_default_sysctl_table.sysctl_header =
-		register_sysctl_table(parport_default_sysctl_table.dev_dir);
+		register_sysctl("dev/parport/default", parport_default_sysctl_table.vars);
 	if (!parport_default_sysctl_table.sysctl_header)
 		return -ENOMEM;
 	ret = parport_bus_init();
-- 
2.30.2

