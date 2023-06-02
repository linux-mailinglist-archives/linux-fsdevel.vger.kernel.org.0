Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E571FE97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjFBKI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjFBKIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:08:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FB1A6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 03:08:18 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602100817euoutp01c8bd376c59ec6aee312b80f28124daf9~kz6vKX7P40428904289euoutp01g
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:08:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602100817euoutp01c8bd376c59ec6aee312b80f28124daf9~kz6vKX7P40428904289euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685700497;
        bh=f1HjrLD6njVVPjduaddJfi5+Ds9joRkOIy3esLq1bnY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZpZ8dW85nTYstRrklw7jGepnTiGBveS5HeGJPFdQ2cdTyjfCrydvKtCVD8AaS40hm
         +cMvD7ssylGvBGm7rzHBkH5ANmlLZtNYJRH021nPz1PPu+LzDuAEbV5w6zTQHGGq+8
         MzWlo+UULNbe3B+64ZUKHH5gMa3GJ+Swv1lK0Sd4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602100817eucas1p2a857bad455aa25270c84dfb1ff6ee0a5~kz6vDIJOP1995219952eucas1p2x;
        Fri,  2 Jun 2023 10:08:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F1.30.42423.19FB9746; Fri,  2
        Jun 2023 11:08:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230602100816eucas1p2c945884b8fd81603dbb39f65f1189f42~kz6uvPKLb1573615736eucas1p29;
        Fri,  2 Jun 2023 10:08:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602100816eusmtrp13ae771f8a5597a66fa213d5326d501b4~kz6usXowp1803818038eusmtrp1U;
        Fri,  2 Jun 2023 10:08:16 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-bc-6479bf914b3b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.34.14344.09FB9746; Fri,  2
        Jun 2023 11:08:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100816eusmtip19e65f13776df3900286781284b8272be~kz6uf3oq-0246202462eusmtip1I;
        Fri,  2 Jun 2023 10:08:16 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 11:08:15 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 4/8] test_sysctl: Add an unregister sysctl test
Date:   Fri, 2 Jun 2023 12:08:01 +0200
Message-ID: <20230602100805.777917-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602100805.777917-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7oT91emGLxpYLHYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKONSyhLHgtEjFqv67LA2M
        bwS6GDk5JARMJE5daWTpYuTiEBJYwSgx781FZgjnC6PEiT1v2SGcz4wS/2dPZ4RpaV4zGapq
        OaPEs8enGeGqju18D5XZwijx4eFHVpAWNgEdifNv7jCD2CIC4hInTm8GG8UsMIFRYtYhDhBb
        WMBeYt6xa0wgNouAisSKX+/ZQGxeARuJtzf3s0Oslpdouw5xBqeArcSyGU+ZIGoEJU7OfMIC
        MVNeonnrbGYIW0Li4IsXzBC9yhIT1v1mhbBrJU5tucUEcqiEwB4OiSW7VkMVuUjsnfUDqkhY
        4tXxLVCLZSROT+5hgWiYzCix/98HdghnNaPEssavTBBV1hItV55AdThK/J71FuhUDiCbT+LG
        W0GIi/gkJm2bzgwR5pXoaBOawKgyC8kPs5D8MAvJDwsYmVcxiqeWFuempxYb5qWW6xUn5haX
        5qXrJefnbmIEJo7T/45/2sE499VHvUOMTByMhxglOJiVRHiFwspThHhTEiurUovy44tKc1KL
        DzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTCllCYxfN0W415uU8gR++7KpbLXcVP+
        Om2ZKCW+6Vfv/riI2+Y6Bz3Wr0yf4KB16+C+XzYf19fqPz8SISkuYDpZ5iObaYvG/gTb689F
        Lu2VqfwX94/HqmFDh8aZqCyx9p+3jrzbu3z+7Ve/X962P/gm32rKXla1rmbbjvW/hQuMnLj3
        xuRc1eHoC10WncPnW/5E8L32on0Nhc+KPnvOiWLvY9NzykhJWqfemvZy/ebT8qLboiSVJ216
        9n9+lJWb8o0Dh3NSW4+ocvpvW5lpYzIv0Sh5qoNo9OLiLaG7fHtCOOLYza5MYVZ4YPbtgfi/
        hNsr502ZN2mb9H2Fs71Hw25eVj3jbHzJU4m1++sxXSklluKMREMt5qLiRACa29ZmiwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7oT9lemGPzu1rTYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLONSyhLHgtEjFqv67LA2MbwS6GDk5JARMJJrXTGbuYuTi
        EBJYyihx8sFVNoiEjMTGL1dZIWxhiT/Xutggij4ySkzZehHK2cIo0bl1IVgVm4COxPk3d5hB
        bBEBcYkTpzczgtjMAhMYJWYd4gCxhQXsJeYdu8YEYrMIqEis+PUebBuvgI3E25v72SG2yUu0
        XZ8O1sspYCuxbMZTsHohoJrzjyYxQ9QLSpyc+YQFYr68RPPW2cwQtoTEwRcvmCHmKEtMWPcb
        6oNaic9/nzFOYBSZhaR9FpL2WUjaFzAyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMqW3H
        fm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeIXCylOEeFMSK6tSi/Lji0pzUosPMZoC/TmRWUo0OR8Y
        1Xkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUyl8nIHRKRnxDqs
        nRudve7986SADffllJ6Hz9/+fTvLLMlDIRfSPBv4zppMa9m1bOmtx59WezcGJdue0WLoKZtr
        kMq4yymKw0CM3XnvK/X5/44nFeUelrvP8FQsfj7nARefMq/1LC86wn1tFoSEGs3bclTlNm/9
        z0LlqSwJRbu4Si76+bLo5DBXsSkslf236E+TxWrt9zv7LIJbDzql9s74ePnOovup3ftf3p83
        v07rAZ9jhB/nDve2Uo0nu4Uzk298MX3VcOAUq8CsstCGb0biXf7hS32lnDIvWiq1HQ3RSBVZ
        9JyZy1clvXJij/Gj0IutpbNal206Erd/C9/HDfG8vkWLmOfzXnpc4MpqpMRSnJFoqMVcVJwI
        AKZM7RIyAwAA
X-CMS-MailID: 20230602100816eucas1p2c945884b8fd81603dbb39f65f1189f42
X-Msg-Generator: CA
X-RootMTR: 20230602100816eucas1p2c945884b8fd81603dbb39f65f1189f42
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602100816eucas1p2c945884b8fd81603dbb39f65f1189f42
References: <20230602100805.777917-1-j.granados@samsung.com>
        <CGME20230602100816eucas1p2c945884b8fd81603dbb39f65f1189f42@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a test that checks that the unregistered directory is removed from
/proc/sys/debug

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/test_sysctl.c                        | 30 ++++++++++++++++++++++++
 tools/testing/selftests/sysctl/sysctl.sh | 16 +++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 0cf7c547d61a..555244687443 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -170,12 +170,42 @@ static int test_sysctl_setup_node_tests(void)
 	return 0;
 }
 
+/* Used to test that unregister actually removes the directory */
+static struct ctl_table test_table_unregister[] = {
+	{
+		.procname	= "unregister_error",
+		.data		= &test_data.int_0001,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+	},
+	{}
+};
+
+static int test_sysctl_run_unregister_nested(void)
+{
+	struct ctl_table_header *unregister;
+
+	unregister = register_sysctl("debug/test_sysctl/unregister_error",
+				   test_table_unregister);
+	if (!unregister)
+		return -ENOMEM;
+
+	unregister_sysctl_table(unregister);
+	return 0;
+}
+
 static int __init test_sysctl_init(void)
 {
 	int err;
 
 	err = test_sysctl_setup_node_tests();
+	if (err)
+		goto out;
 
+	err = test_sysctl_run_unregister_nested();
+
+out:
 	return err;
 }
 module_init(test_sysctl_init);
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index cb8f83dfe16b..a6d79d7a36e4 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -31,6 +31,7 @@ ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
 ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
 ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int"
 ALL_TESTS="$ALL_TESTS 0008:1:1:match_int"
+ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error"
 
 function allow_user_defaults()
 {
@@ -797,6 +798,20 @@ sysctl_test_0008()
 	return 0
 }
 
+sysctl_test_0009()
+{
+	TARGET="${SYSCTL}/$(get_test_target 0009)"
+	echo -n "Testing if $TARGET unregistered correctly ..."
+	if [ -d $TARGET ]; then
+		echo "TEST FAILED"
+		rc=1
+		test_rc
+	fi
+
+	echo "ok"
+	return 0
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -813,6 +828,7 @@ list_tests()
 	echo "0006 x $(get_test_count 0006) - tests proc_do_large_bitmap()"
 	echo "0007 x $(get_test_count 0007) - tests setting sysctl from kernel boot param"
 	echo "0008 x $(get_test_count 0008) - tests sysctl macro values match"
+	echo "0009 x $(get_test_count 0009) - tests sysct unregister"
 }
 
 usage()
-- 
2.30.2

