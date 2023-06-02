Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4E72000B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjFBLH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFBLHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DBF198
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:06:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110649euoutp01f142d0f3d3d96b6e0e5939c327297d16~k0t2foYJ10043200432euoutp01e
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602110649euoutp01f142d0f3d3d96b6e0e5939c327297d16~k0t2foYJ10043200432euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704009;
        bh=f1HjrLD6njVVPjduaddJfi5+Ds9joRkOIy3esLq1bnY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=k0PEgADhvo9GS/8EziJJ8+YBDRBajjsrbEBycS2y3yquOZqIH/7/yezUD5rIA2oBj
         SkfPi0x0Slsy9VUBzRSI7D0JAaM3EKB6GRXf/qJa81xdmukBg1zs2WNTytDVoaMDsz
         WAyje9wOMKFrKEG2tyyx/rDdC6jghlVqjfzaaEms=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110649eucas1p28840581b7ed263d9183eb206ae73eb8b~k0t2PEHvj3164631646eucas1p2s;
        Fri,  2 Jun 2023 11:06:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F0.77.11320.94DC9746; Fri,  2
        Jun 2023 12:06:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110649eucas1p1fc4db9a31735ed13e14c3142e1edb23b~k0t2AAFU52550025500eucas1p1s;
        Fri,  2 Jun 2023 11:06:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602110649eusmtrp117f0da1caa43f6460c75da86d68d59c4~k0t1-iGSw2194821948eusmtrp1l;
        Fri,  2 Jun 2023 11:06:49 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-85-6479cd49faef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.A9.10549.94DC9746; Fri,  2
        Jun 2023 12:06:49 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110649eusmtip129b8cc86ce1cff9465c3b2643e67ef54~k0t1yIPZj0530205302eusmtip1U;
        Fri,  2 Jun 2023 11:06:49 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:48 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 4/8] test_sysctl: Add an unregister sysctl test
Date:   Fri, 2 Jun 2023 13:06:34 +0200
Message-ID: <20230602110638.789426-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djP87qeZytTDO5uU7DYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKONSyhLHgtEjFqv67LA2M
        bwS6GDk5JARMJPq2v2bqYuTiEBJYwSjxr2cNI4TzhVHi56OtUM5nRom3H1qYYFrWdJ1kgUgs
        Z5R4f+koC1zVx/+rWSGcLYwStyavYQdpYRPQkTj/5g4ziC0iIC5x4vRmsLnMAhMYJfrW/WIB
        SQgL2EvMO3YNbAeLgIrEqRuzWEFsXgEbidnH1rBC7JaXaLs+nRHE5hSwlTh0+gwbRI2gxMmZ
        T8DmMAPVNG+dzQxhS0gcfPGCGaJXWWLCut9Qc2olTm25Bfa2hMARDombT3dAFblIND7+yghh
        C0u8Or6FHcKWkTg9uYcFomEyo8T+fx/YIZzVjBLLGr9Cg8ZaouXKE6gOR4l/57uAbA4gm0/i
        xltBiIv4JCZtm84MEeaV6GgTmsCoMgvJD7OQ/DALyQ8LGJlXMYqnlhbnpqcWG+WllusVJ+YW
        l+al6yXn525iBKaO0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4hcLKU4R4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwWVUy3fw9uf5l+cLXlvFfFJaq7VzE
        YcQufCTiueHBgOeiXgFpXd+WfNkptOXe5NPvhH8828Bvc/rxEmUu/6+1Mzy37bpVsvJky8d5
        GUuOGIjd28P4Z233SvOv6zP0Gw4GrGub867ft3zD/L/3o5j4NjLk/1Q8KSv5mSmRM29CwrzP
        cwJ/7JrDbfBcdf31HfITrhoeql91/WVWnNj0CzY/j2Z9LoteejHL57LK4Qi315oup9e/WFcu
        4nhho4jnmaJT6TqvuJ1bptx2jfA+o+5umS3/ycxijbven/jKT5+03+t2PbvMslSaoSuvd474
        RrU7yZ/svS/Z597Oeuw+YV/e1AtGgdoCC5f8f/X91oIE3ywlluKMREMt5qLiRAAIYHaBjAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7qeZytTDP6e4LbYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLONSyhLHgtEjFqv67LA2MbwS6GDk5JARMJNZ0nWQBsYUE
        ljJKTF/jDBGXkdj45SorhC0s8edaF1sXIxdQzUdGiXN3n0I5WxglWs5OZAOpYhPQkTj/5g4z
        iC0iIC5x4vRmRpAiZoEJjBJ9636BrRAWsJeYd+waE4jNIqAicerGLLAVvAI2ErOPrYFaJy/R
        dn06I4jNKWArcej0GTaI82wk1p+5wA5RLyhxcuYTsJnMQPXNW2czQ9gSEgdfvGCGmKMsMWHd
        b6iZtRKf/z5jnMAoMgtJ+ywk7bOQtC9gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGFPb
        jv3cvINx3quPeocYmTgYDzFKcDArifAKhZWnCPGmJFZWpRblxxeV5qQWH2I0BfpzIrOUaHI+
        MKrzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYVI/r7353sMEn
        d5PRV/ZF0x0WfNm58vqKvtVyrMus9qbErH7V15Zzj/uVEOfaR8cWZ54wMHor0Rn0SurBs3PZ
        pRt6FTg+McUcvT7T8f/6lTGyrzYxiqixT1sfaPsuenXG8oSFC900ptzdp/m22cP47e8/a648
        1pogs1Fq7uUNs8xWn67YmbpKszS3cuLynGcM1ycuX78r70jAw8jLmZfDOh47pof3r9A9yOw5
        cwmzBv+xKzvrEx6xu8xS8+eTnbm0Xujig5O60bYB388s/lB/vmvDPOabu+VmxytYsufzTX5m
        cvXpbJn+qK9la4r1T3ZrXDvW3yr4KOfeUj7zf66uco+l7874p84h9uCtzdwdopuUWIozEg21
        mIuKEwEfEtWDMgMAAA==
X-CMS-MailID: 20230602110649eucas1p1fc4db9a31735ed13e14c3142e1edb23b
X-Msg-Generator: CA
X-RootMTR: 20230602110649eucas1p1fc4db9a31735ed13e14c3142e1edb23b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110649eucas1p1fc4db9a31735ed13e14c3142e1edb23b
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110649eucas1p1fc4db9a31735ed13e14c3142e1edb23b@eucas1p1.samsung.com>
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

