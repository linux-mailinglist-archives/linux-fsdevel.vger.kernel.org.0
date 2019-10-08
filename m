Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C44CFCAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfJHOpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:45:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47744 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJHOpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:45:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ESoIa070047;
        Tue, 8 Oct 2019 14:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=U4VtvuLB3aYk5ZgR5h8+CG5g0FuYIAGPLR8vmXrn0Ak=;
 b=B8EZSZjXBIQQ53kbrwnRyn5IvQbvQ7pVFlMijjjoVuU9HhUzhEyroMS/Ecem1HBuSNpO
 WpsQCnPtUAuGlhfu1vnogwbHyDz0Pw4aGEEtjjyEmDueymwqwvWW605Sit9/ZO0Tk9s8
 ky6n15XbzcVo6tXMcMw6esnxVa8od2YQUqyDIfODtgM8KXotuYSe0Dj1MY5GoJ+dP1TA
 JoZO2vuL7Om3zCmSmSeTG/Gbp8q5b/GvUeTapCKy/0mh0l7ErF3iYKr27Y84i5V8jCzb
 yUUowK6fcg3HoG/2Wa44JN9OFDc4QLeA0RbsmDLWV5GLdrfKpazB7+H+rBvS+8//Wh2M Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektrdhuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ET7jk070488;
        Tue, 8 Oct 2019 14:44:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vg1yw2r9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98EieXq023243;
        Tue, 8 Oct 2019 14:44:40 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:44:39 +0000
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
Subject: [PATCH linux-kselftest-test 2/3] kunit: allow kunit to be loaded as a module
Date:   Tue,  8 Oct 2019 15:43:51 +0100
Message-Id: <1570545832-32326-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
References: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=38 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080133
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

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kunit/Kconfig  | 2 +-
 kunit/Makefile | 9 +++++++++
 kunit/test.c   | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kunit/Kconfig b/kunit/Kconfig
index f28bf086..d84f480 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -5,7 +5,7 @@
 menu "KUnit support"
 
 config KUNIT
-	bool "Enable support for unit tests (KUnit)"
+	tristate "Enable support for unit tests (KUnit)"
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
diff --git a/kunit/Makefile b/kunit/Makefile
index 769d940..932a3f2 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,7 +1,16 @@
+ifeq ($(CONFIG_KUNIT),m)
+obj-$(CONFIG_KUNIT) +=			kunit.o
+
+kunit-objs +=				test.o \
+					string-stream.o \
+					assert.o \
+					try-catch.o
+else
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o
+endif
 
 obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
 					string-stream-test.o
diff --git a/kunit/test.c b/kunit/test.c
index e7896f1..6024627 100644
--- a/kunit/test.c
+++ b/kunit/test.c
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

