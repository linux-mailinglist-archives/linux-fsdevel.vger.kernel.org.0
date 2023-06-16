Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E55732AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjFPJAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 05:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343595AbjFPI7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:38 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9210F6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085935euoutp02611d50a5fbac8bb279bb3a9c470adc8d~pGAwm-1OY3175731757euoutp02a
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230616085935euoutp02611d50a5fbac8bb279bb3a9c470adc8d~pGAwm-1OY3175731757euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905975;
        bh=f1HjrLD6njVVPjduaddJfi5+Ds9joRkOIy3esLq1bnY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KoXZXarVSr/tD/cq7Yr116Qpv0UTVbKgzPKO47hFfs5Ou7v5oY2VR2r1o77XmxHl+
         l996+etLl/hWWokJ0qKPX5rdIbEX+hVlBb1QRWaSSoX44e6vyYrFrj1ck2pNDbNbFZ
         Beje4hzUUapjgY0PMNBPSVe7UTXhO14VGhqp6p/c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230616085935eucas1p1171b73897e1cd825a5d5ab373ed4c9c9~pGAwaB_uZ1146911469eucas1p1m;
        Fri, 16 Jun 2023 08:59:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.45.42423.7742C846; Fri, 16
        Jun 2023 09:59:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085935eucas1p2439375978f0ee33afd6310a9f8c5d07a~pGAwHTLq61755217552eucas1p2_;
        Fri, 16 Jun 2023 08:59:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085935eusmtrp1c68c5c817c528c9d8849b36ad7e6f2d5~pGAwGsbAm0890108901eusmtrp1a;
        Fri, 16 Jun 2023 08:59:35 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-4d-648c24771e35
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.9E.14344.7742C846; Fri, 16
        Jun 2023 09:59:35 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085935eusmtip252b10b84713a96d7276b9661b401440f~pGAv_AsVC1986719867eusmtip25;
        Fri, 16 Jun 2023 08:59:35 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:34 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 4/8] test_sysctl: Add an unregister sysctl test
Date:   Fri, 16 Jun 2023 10:59:18 +0200
Message-ID: <20230616085922.3066990-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djPc7rlKj0pBpuuqFjs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlHGpZwlhwWqRiVf9dlgbG
        NwJdjJwcEgImEj2v7zKC2EICKxglph/N7mLkArK/MEosa7zEAuF8ZpTYvGMqO0zHz+6z7BAd
        yxklFvdawRXd+nSCCcLZyijRvOEAE0gVm4COxPk3d5hBbBEBcYkTpzeD7WMWmMAoMesQB4gt
        LOAkcejsMhYQm0VAVWL+ri9g9bwCthKP73ZDbZaXaLs+HayXU8BO4vGkBnaIGkGJkzOfsEDM
        lJdo3jqbGcKWkDj44gWQzQHUqyzx6XkCxJhaiVNbboHdKSFwgEPiR9dNNoiEi8SPKXtYIWxh
        iVfHt0DtlZE4PbmHBaJhMqPE/n8f2CGc1aBA+soEUWUt0XLlCVSHo8TNd6dZIDbzSdx4Kwhx
        EJ/EpG3ToQ7ilehoE5rAqDILyQuzkLwwC8kLCxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl
        5+duYgSmjNP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeJed6EoR4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwKTokj6h6puZyRH3aW/eZW452WR1+ov/1bDF
        030OHp9QP2+l7q39P2bcPdZRvLjrzpkd/zz7+ics+KOsu3unZO6SsOzUWXtTf/2YOdX7XrmT
        oGPcf9GmprLAXd3fZxYIFjZ+FmcT36t+eNXeFTq3vlznjzX2D4zJ739quWHz499nwmw1exdO
        uPhMLEjwGeO9o7PdQiT0nwhfi9pz7Jx0o6hxbAq7xmnOSee2BCnPfW279uyMT/YKs6Rq+fOF
        5S+rPRffG+2/7B5X2HL9TcqzLGdXJBnsvHXpzwGmwzXRrtmLGtqC+9c8l5d9smWhwha/H4um
        TMo54K4oUDS5vpDraeKl4JkTPtYHhUvW8C1y3bVHiaU4I9FQi7moOBEAYYU3+ogDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7rlKj0pBve+CFns2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlHGpZwlhwWqRiVf9dlgbGNwJdjJwcEgImEj+7z7J3MXJx
        CAksZZS48LCTCSIhI7Hxy1VWCFtY4s+1LjaIoo+MEu2ft7JCOFsZJf48mQhWxSagI3H+zR1m
        EFtEQFzixOnNjCA2s8AERolZhzhAbGEBJ4lDZ5exgNgsAqoS83d9AavnFbCVeHy3mx1im7xE
        2/XpYL2cAnYSjyc1gMWFgGoab/ezQ9QLSpyc+YQFYr68RPPW2cwQtoTEwRcvgGwOoDnKEp+e
        J0CMrJX4/PcZ4wRGkVlIumch6Z6FpHsBI/MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwIja
        duznlh2MK1991DvEyMTBeIhRgoNZSYR32YmuFCHelMTKqtSi/Pii0pzU4kOMpkBvTmSWEk3O
        B8Z0Xkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk+Nt5qjca9Z8
        Z+dZpWZ9ucwto9dkp+6jwGTmXdBh4M4ZOXWuxhy9mLPsCwPSDziuj5sh8SmXP/Vj8oRtDyT+
        v7V7p29y51SZ17ZNB5dVTMi/pqzxVN4wt3bVu4mbztktNZ5/f/uOYhf5vjNlSbbLJSINq1Td
        j8TOOvC08muqcJvewrNsrlaa6gfXH3y39uT6bG6DpTt6s6XCLVd2/qj4E18tqXdlzsa9TT/3
        Hrw78fhBBxN7yUvbeW7GVct2HFXe4L7qWqb0osfbKu9NfDiPP87t8R/BXy2ZHZkyKu4/VZed
        sHZSkvR7Jf1s1nbR9CWurVs1I/Vu7vlblhEbeiOBia2zYtfrLNtal00rJJ8mKLEUZyQaajEX
        FScCAI0Gvi0xAwAA
X-CMS-MailID: 20230616085935eucas1p2439375978f0ee33afd6310a9f8c5d07a
X-Msg-Generator: CA
X-RootMTR: 20230616085935eucas1p2439375978f0ee33afd6310a9f8c5d07a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085935eucas1p2439375978f0ee33afd6310a9f8c5d07a
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085935eucas1p2439375978f0ee33afd6310a9f8c5d07a@eucas1p2.samsung.com>
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

