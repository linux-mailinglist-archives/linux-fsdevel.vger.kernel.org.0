Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF8CFCEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfJHO5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:57:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56306 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHO5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:57:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98EnGuv060978;
        Tue, 8 Oct 2019 14:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=0fdKhmSBg5zGMW+tC9KyIRxKr/NhTFbkuK5fvyAJTYM=;
 b=FVGbr4h9vWyvYagF1gJBAUPaSUs6Efsk304fXHOw/+vP1ulsVIz4SmF+03542O6Hc7Xg
 93EYL2f7V4wZ2fT9yWUzr6Pyte8sTxNI0oTsYJnjq3oABZKX3tPyFR/29ksQ+29cRSPj
 SU5GHeHxV+jv7xAovzQmjeX4RPYp8cJMJZY4xl7zrcdp68HwdrodXKygXKSKGRUnmP/m
 8vVR+zfXyWaiTGimDiNYD9nOVciwcG65l5W5lWYBFGZlWM/U0HMvi7GnalzZXZ6uMgvR
 EYc5F5LIQTQxn8IucHIWvPCvc78nyPv3sDaFY+XOlTxrQR141nALCrHh+wR8rOeFcMPK 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4qdter-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:56:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98EnSEp067027;
        Tue, 8 Oct 2019 14:56:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vg206g0hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:56:46 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98EuicV026737;
        Tue, 8 Oct 2019 14:56:44 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:56:44 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v2 linux-kselftest-test 2/3] kunit: allow kunit to be loaded as a module
Date:   Tue,  8 Oct 2019 15:55:45 +0100
Message-Id: <1570546546-549-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=38 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Making kunit itself buildable as a module allows for "always-on"
kunit configuration; specifying CONFIG_KUNIT=m means the module
is built but only used when loaded.  Kunit test modules will load
kunit.ko as an implicit dependency, so simply running
"modprobe my-kunit-tests" will load the tests along with the kunit
module and run them.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>

---
 lib/kunit/Kconfig  | 2 +-
 lib/kunit/Makefile | 4 +++-
 lib/kunit/test.c   | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 9ebd5e6..065aa16 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig KUNIT
-	bool "KUnit - Enable support for unit tests"
+	tristate "KUnit - Enable support for unit tests"
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 769d940..8e2635a 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,4 +1,6 @@
-obj-$(CONFIG_KUNIT) +=			test.o \
+obj-$(CONFIG_KUNIT) +=			kunit.o
+
+kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e7896f1..6024627 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -484,3 +484,7 @@ void kunit_cleanup(struct kunit *test)
 	}
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
-- 
1.8.3.1

