Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB672000E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjFBLHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjFBLH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:27 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA453E48
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:07:02 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110651euoutp016afe011a2dd3895f4b86e897ef6071d2~k0t3xucm73253732537euoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602110651euoutp016afe011a2dd3895f4b86e897ef6071d2~k0t3xucm73253732537euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704011;
        bh=bxclUZv9jPrQ5jKcyYEbND/Krq83dxgsRJ8rzENWdE8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nwgMTkPtOstQSgGbGvbFM77EiUqy78EItNzVChb35/ko9FezeXJDwfuzh3zsT9UG5
         GMaQ6JYATiSCwlPEcdUn3xfNCf28D2lWPFNpALNWAPJH6/q0LFXlDD+hxQkpsTECHe
         CM+eAYQSWOfOX/3X4UJIWkE1LlYfuf186vPUzeAI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230602110651eucas1p14e20bc6236c10d4fc8d6e271e60ffb79~k0t3rdCIa0212702127eucas1p1a;
        Fri,  2 Jun 2023 11:06:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 78.6A.42423.B4DC9746; Fri,  2
        Jun 2023 12:06:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110650eucas1p1e04fdac1151ed028d1d081cf30433174~k0t3Ycr2b2548925489eucas1p1m;
        Fri,  2 Jun 2023 11:06:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602110650eusmtrp124d79e1d2067604f7bd0bfd887a8c663~k0t3X77E72194821948eusmtrp1o;
        Fri,  2 Jun 2023 11:06:50 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-44-6479cd4bf821
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.A9.10549.A4DC9746; Fri,  2
        Jun 2023 12:06:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230602110650eusmtip2aef1f882657ce0c13324aa492ba559cd~k0t3NbY5X0430104301eusmtip23;
        Fri,  2 Jun 2023 11:06:50 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:50 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 5/8] test_sysctl: Add an option to prevent test skip
Date:   Fri, 2 Jun 2023 13:06:35 +0200
Message-ID: <20230602110638.789426-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7reZytTDI7+ZLHYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKWHG3m6Xgn2zFuktP2RoY
        70t0MXJySAiYSHRd3cfcxcjFISSwglHiUusGdgjnC6PE1i/fWCCcz4wSU5dOYYdpaTjykQ0i
        sZxRovfWNna4qlmNO1khnC2MEo8+rAJrYRPQkTj/5g4ziC0iIC5x4vRmRpAiZoEJjBJ9636x
        gCSEBVwkelp/MXUxcnCwCKhIHPljAhLmFbCR+L1xFTPEanmJtuvTGUFsTgFbiUOnz7BB1AhK
        nJz5BGwMM1BN89bZzBC2hMTBFy+gepUlJqz7zQph10qc2nKLCeQGCYEDHBLH5nQxQSRcJJr2
        zmGEsIUlXh3fAvWzjMTpyT0sEA2TGSX2//vADuGsZpRY1vgVqttaouXKE6gOR4kPU1rZQL6R
        EOCTuPFWEOIiPolJ26YzQ4R5JTrahCYwqsxC8sMsJD/MQvLDAkbmVYziqaXFuempxYZ5qeV6
        xYm5xaV56XrJ+bmbGIGJ4/S/4592MM599VHvECMTB+MhRgkOZiURXqGw8hQh3pTEyqrUovz4
        otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotgskwcnFINTLM+HwoWFrIwOnY8/Jaawkwv
        3W+lfx8yLxbwsPy7vzP3TeP5s9ksLIWG7kcrj8Re31cu0fyIb+L5GQFrdtjeDhYWnqGwx2mb
        RczPuecWXC2rySyPtv36SOL77sLPLdfTlnxYmeWzPO2xxs9VVxJnPPibyuh6ZCbjbdWd2l8M
        70Q9U109q8JXckX+g675JbszK7qniLY6fnu7O8TfZKbDpPmv0r4dbrOwcsv7+PS8/iSXzG3M
        VQ9v3cq/sO/CZTbO86/Uzaao9SeKrYm0VpNW06j4ud/HSeZEcJfl/GlPlolyLL/Uabz8PEPO
        nC+PFfg5q1mWOq2fwx3y+gDznTzNJ1825YX3tFxddUHY1dXm3zslluKMREMt5qLiRACx43L5
        iwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7peZytTDA4t1rHYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLWHG3m6Xgn2zFuktP2RoY70t0MXJySAiYSDQc+cgGYgsJ
        LGWUuLStBiIuI7Hxy1VWCFtY4s+1LqAaLqCaj4wSPaevs0A4WxglLm/oZwSpYhPQkTj/5g4z
        iC0iIC5x4vRmRpAiZoEJjBJ9636xgCSEBVwkelp/MXUxcnCwCKhIHPljAhLmFbCR+L1xFTPE
        NnmJtuvTwWZyCthKHDp9Buo6G4n1Zy6wQ9QLSpyc+QRsJDNQffPW2cwQtoTEwRcvoOYoS0xY
        9xvqg1qJz3+fMU5gFJmFpH0WkvZZSNoXMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyo
        bcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4hcLKU4R4UxIrq1KL8uOLSnNSiw8xmgK9OZFZSjQ5
        HxjTeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTBZSoqvcHsT/
        XLtnkWSSicn+iwuSO5n4XnuFSl7fFlsR99T+jcv+pdfXl64XyvxtJqgcZzP9YPHCin+Zy29a
        OnCoiW+tvcInJHR1T9SBf8EBVd+nf/pqnRq94X5PgtiH2JPbk3NXCxYYPNta/nqx37Npcckc
        5z5tebIvzvjvj7yuqIYcD6lthy/pW61rdNIOfRwzmdn4yf3V0TJTHC5suT2tcrFrgkLiW7kt
        0spp1bKPNZqmfVBz2LdNSjJY/n3o7H8ftM8tj5fsvGGrl227nsG8jmWmbehxdyapbzvuc6/6
        o+cyfVfYFuY5/UaT38yW50p1scq4HVjN7atyuIPRi/Va4u0jhQu0567YFqVSpMRSnJFoqMVc
        VJwIAMNhuCYxAwAA
X-CMS-MailID: 20230602110650eucas1p1e04fdac1151ed028d1d081cf30433174
X-Msg-Generator: CA
X-RootMTR: 20230602110650eucas1p1e04fdac1151ed028d1d081cf30433174
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110650eucas1p1e04fdac1151ed028d1d081cf30433174
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110650eucas1p1e04fdac1151ed028d1d081cf30433174@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tests were being skipped because the target was not present. Add a flag
that controls whether to skip a test based on the presence of the target.
Actually skip tests in the test_case function with a "return" instead of
a "continue".

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 66 ++++++++++++++++--------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index a6d79d7a36e4..9c0e9711138b 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -14,24 +14,26 @@ TEST_FILE=$(mktemp)
 
 # This represents
 #
-# TEST_ID:TEST_COUNT:ENABLED:TARGET
+# TEST_ID:TEST_COUNT:ENABLED:TARGET:SKIP_NO_TARGET
 #
 # TEST_ID: is the test id number
 # TEST_COUNT: number of times we should run the test
 # ENABLED: 1 if enabled, 0 otherwise
 # TARGET: test target file required on the test_sysctl module
+# SKIP_NO_TARGET: 1 skip if TARGET not there
+#                 0 run eventhough TARGET not there
 #
 # Once these are enabled please leave them as-is. Write your own test,
 # we have tons of space.
-ALL_TESTS="0001:1:1:int_0001"
-ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001"
-ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
-ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
-ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
-ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
-ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int"
-ALL_TESTS="$ALL_TESTS 0008:1:1:match_int"
-ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error"
+ALL_TESTS="0001:1:1:int_0001:1"
+ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001:1"
+ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002:1"
+ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001:1"
+ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003:1"
+ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001:1"
+ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int:1"
+ALL_TESTS="$ALL_TESTS 0008:1:1:match_int:1"
+ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
 
 function allow_user_defaults()
 {
@@ -614,7 +616,6 @@ target_exists()
 	TEST_ID="$2"
 
 	if [ ! -f ${TARGET} ] ; then
-		echo "Target for test $TEST_ID: $TARGET not exist, skipping test ..."
 		return 0
 	fi
 	return 1
@@ -902,16 +903,36 @@ function get_test_target()
 	echo ${TEST_DATA} | awk -F":" '{print $4}'
 }
 
+function get_test_skip_no_target()
+{
+	test_num $1
+	awk_field=$(remove_leading_zeros $1)
+	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$awk_field'}')
+	echo ${TEST_DATA} | awk -F":" '{print $5}'
+}
+
+function skip_test()
+{
+	TEST_ID=$1
+	TEST_TARGET=$2
+	if target_exists $TEST_TARGET $TEST_ID; then
+		TEST_SKIP=$(get_test_skip_no_target $TEST_ID)
+		if [[ $TEST_SKIP -eq "1" ]]; then
+			echo "Target for test $TEST_ID: $TEST_TARGET not exist, skipping test ..."
+			return 0
+		fi
+	fi
+	return 1
+}
+
 function run_all_tests()
 {
 	for i in $ALL_TESTS ; do
-		TEST_ID=${i%:*:*:*}
+		TEST_ID=${i%:*:*:*:*}
 		ENABLED=$(get_test_enabled $TEST_ID)
 		TEST_COUNT=$(get_test_count $TEST_ID)
 		TEST_TARGET=$(get_test_target $TEST_ID)
-		if target_exists $TEST_TARGET $TEST_ID; then
-			continue
-		fi
+
 		if [[ $ENABLED -eq "1" ]]; then
 			test_case $TEST_ID $TEST_COUNT $TEST_TARGET
 		fi
@@ -946,18 +967,19 @@ function watch_case()
 
 function test_case()
 {
+	TEST_ID=$1
 	NUM_TESTS=$2
+	TARGET=$3
 
-	i=0
-
-	if target_exists $3 $1; then
-		continue
+	if skip_test $TEST_ID $TARGET; then
+		return
 	fi
 
+	i=0
 	while [ $i -lt $NUM_TESTS ]; do
-		test_num $1
-		watch_log $i ${TEST_NAME}_test_$1 noclear
-		RUN_TEST=${TEST_NAME}_test_$1
+		test_num $TEST_ID
+		watch_log $i ${TEST_NAME}_test_${TEST_ID} noclear
+		RUN_TEST=${TEST_NAME}_test_${TEST_ID}
 		$RUN_TEST
 		let i=$i+1
 	done
-- 
2.30.2

