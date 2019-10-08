Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145ACCFCC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfJHOrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:47:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfJHOq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:46:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ESweN041893;
        Tue, 8 Oct 2019 14:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=m8JpdpN883nHXp3llPnA77MQvWxorCT+C/dtRSJsyW0=;
 b=Oib5jtzMC1e7V1YmYiMWrwW8ndsJKvstlGClzqD2QVsppsYN4NeCCJqwnPBvajBsuCcj
 16pbfoYgYOqGBey44qlNXBEOY4wtjFOAeyDoXIvbxKweU6m+inQMrvDnYvCHPaYTnFYo
 bbQdnN4eLxeNTWvZU0w6CbAg5HUMRJjdhWpBkYobrJgXJ9PHlnRv+0YDh+iQeXEFLUaP
 WdHv1rUaCBDP0KP51F19qaowPfa47+LJtn1/o1QLryRvphzp+Ezm7MmnJ+UHLpki2jIL
 YKuI9LiXTdgiBqd5/qbgF8xtCwRuqqWUCda/BP6CeGnOVDPESTn7pToq8XcXQLGOZZKK CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4qdr7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:46:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ET9Hp070613;
        Tue, 8 Oct 2019 14:44:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vg1yw2r4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:35 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98EiXh2027735;
        Tue, 8 Oct 2019 14:44:33 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:44:33 +0000
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
Subject: [PATCH linux-kselftest-test 1/3] kunit: allow kunit tests to be loaded as a module
Date:   Tue,  8 Oct 2019 15:43:50 +0100
Message-Id: <1570545832-32326-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
References: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=780
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=863 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

as tests are added to kunit, it will become less feasible to execute
all built tests together.  By supporting modular tests we provide
a simple way to do selective execution on a running system; specifying

CONFIG_KUNIT=y
CONFIG_KUNIT_EXAMPLE_TEST=m

...means we can simply "insmod example-test.ko" to run the tests.

To achieve this we need to

o export the required symbols in kunit
o support a new way of declaring test suites.  Because a module cannot
  do multiple late_initcall()s, we provide a kunit_test_suites() macro
  to declare multiple suites within the same module at once.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/test.h       | 36 ++++++++++++++++++++++++++----------
 kernel/sysctl-test.c       |  6 +++++-
 kunit/Kconfig              |  4 ++--
 kunit/assert.c             |  8 ++++++++
 kunit/example-test.c       |  6 +++++-
 kunit/string-stream-test.c |  9 +++++++--
 kunit/string-stream.c      |  7 +++++++
 kunit/test-test.c          |  8 ++++++--
 kunit/test.c               |  8 ++++++++
 kunit/try-catch.c          |  8 ++++++--
 lib/Kconfig.debug          |  4 ++--
 11 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba4830..37a21dd 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -197,31 +198,46 @@ struct kunit {
 int kunit_run_tests(struct kunit_suite *suite);
 
 /**
- * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
+ * kunit_test_suites() - used to register &struct kunit_suite suites with KUnit.
  *
- * @suite: a statically allocated &struct kunit_suite.
+ * @...: a list of statically allocated &struct kunit_suite.
  *
- * Registers @suite with the test framework. See &struct kunit_suite for
+ * Registers @... suites with the test framework. See &struct kunit_suite for
  * more information.
  *
- * NOTE: Currently KUnit tests are all run as late_initcalls; this means
+ * When builtin,  KUnit tests are all run as late_initcalls; this means
  * that they cannot test anything where tests must run at a different init
  * phase. One significant restriction resulting from this is that KUnit
  * cannot reliably test anything that is initialize in the late_init phase;
  * another is that KUnit is useless to test things that need to be run in
  * an earlier init phase.
  *
+ * An alternative is to build the tests as a module.  Because modules
+ * do not support multiple late_initcall()s, we need to initialize an
+ * array of suites for a module.
+ *
  * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
  * late_initcalls.  I have some future work planned to dispatch all KUnit
  * tests from the same place, and at the very least to do so after
  * everything else is definitely initialized.
  */
-#define kunit_test_suite(suite)						       \
-	static int kunit_suite_init##suite(void)			       \
-	{								       \
-		return kunit_run_tests(&suite);				       \
-	}								       \
-	late_initcall(kunit_suite_init##suite)
+#define kunit_test_suites(...)						\
+	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
+	static int kunit_test_suites_init(void)				\
+	{								\
+		unsigned int i;						\
+		for (i = 0; suites[i] != NULL; i++)			\
+			kunit_run_tests(suites[i]);			\
+		return 0;						\
+	}								\
+	late_initcall(kunit_test_suites_init);				\
+	static void __exit kunit_test_suites_exit(void)			\
+	{								\
+		return;							\
+	}								\
+	module_exit(kunit_test_suites_exit)
+
+#define	kunit_test_suite(suite)	kunit_test_suites(suite)
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 2a63241..15161c5 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -389,4 +389,8 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	.test_cases = sysctl_test_cases,
 };
 
-kunit_test_suite(sysctl_test_suite);
+kunit_test_suite(&sysctl_test_suite);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
diff --git a/kunit/Kconfig b/kunit/Kconfig
index 8541ef9..f28bf086 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -15,7 +15,7 @@ config KUNIT
 	  Documentation/dev-tools/kunit/.
 
 config KUNIT_TEST
-	bool "KUnit test for KUnit"
+	tristate "KUnit test for KUnit"
 	depends on KUNIT
 	help
 	  Enables the unit tests for the KUnit test framework. These tests test
@@ -25,7 +25,7 @@ config KUNIT_TEST
 	  expected.
 
 config KUNIT_EXAMPLE_TEST
-	bool "Example test for KUnit"
+	tristate "Example test for KUnit"
 	depends on KUNIT
 	help
 	  Enables an example unit test that illustrates some of the basic
diff --git a/kunit/assert.c b/kunit/assert.c
index 86013d4..92eba2a 100644
--- a/kunit/assert.c
+++ b/kunit/assert.c
@@ -24,6 +24,7 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
 			 expect_or_assert, assert->file, assert->line);
 }
+EXPORT_SYMBOL_GPL(kunit_base_assert_format);
 
 void kunit_assert_print_msg(const struct kunit_assert *assert,
 			    struct string_stream *stream)
@@ -31,6 +32,7 @@ void kunit_assert_print_msg(const struct kunit_assert *assert,
 	if (assert->message.fmt)
 		string_stream_add(stream, "\n%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
@@ -38,6 +40,7 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       struct string_stream *stream)
@@ -56,6 +59,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 				 unary_assert->condition);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     struct string_stream *stream)
@@ -76,6 +80,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	}
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
@@ -97,6 +102,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -118,6 +124,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -139,3 +146,4 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/kunit/example-test.c b/kunit/example-test.c
index f64a829..6c6a408 100644
--- a/kunit/example-test.c
+++ b/kunit/example-test.c
@@ -85,4 +85,8 @@ static int example_test_init(struct kunit *test)
  * This registers the above test suite telling KUnit that this is a suite of
  * tests that need to be run.
  */
-kunit_test_suite(example_test_suite);
+kunit_test_suite(&example_test_suite);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
index 76cc05e..7a3e7a0 100644
--- a/kunit/string-stream-test.c
+++ b/kunit/string-stream-test.c
@@ -45,8 +45,13 @@ static void string_stream_test_get_string(struct kunit *test)
 	{}
 };
 
-static struct kunit_suite string_stream_test_suite = {
+struct kunit_suite string_stream_test_suite = {
 	.name = "string-stream-test",
 	.test_cases = string_stream_test_cases
 };
-kunit_test_suite(string_stream_test_suite);
+
+kunit_test_suite(&string_stream_test_suite);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
diff --git a/kunit/string-stream.c b/kunit/string-stream.c
index e6d17aa..e4f3a97 100644
--- a/kunit/string-stream.c
+++ b/kunit/string-stream.c
@@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(string_stream_vadd);
 
 int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 {
@@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(string_stream_add);
 
 static void string_stream_clear(struct string_stream *stream)
 {
@@ -145,6 +147,7 @@ char *string_stream_get_string(struct string_stream *stream)
 
 	return buf;
 }
+EXPORT_SYMBOL_GPL(string_stream_get_string);
 
 int string_stream_append(struct string_stream *stream,
 			 struct string_stream *other)
@@ -158,11 +161,13 @@ int string_stream_append(struct string_stream *stream,
 
 	return string_stream_add(stream, other_content);
 }
+EXPORT_SYMBOL_GPL(string_stream_append);
 
 bool string_stream_is_empty(struct string_stream *stream)
 {
 	return list_empty(&stream->fragments);
 }
+EXPORT_SYMBOL_GPL(string_stream_is_empty);
 
 struct string_stream_alloc_context {
 	struct kunit *test;
@@ -207,6 +212,7 @@ struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 				    gfp,
 				    &context);
 }
+EXPORT_SYMBOL_GPL(alloc_string_stream);
 
 int string_stream_destroy(struct string_stream *stream)
 {
@@ -215,3 +221,4 @@ int string_stream_destroy(struct string_stream *stream)
 				      string_stream_free,
 				      stream);
 }
+EXPORT_SYMBOL_GPL(string_stream_destroy);
diff --git a/kunit/test-test.c b/kunit/test-test.c
index 5ebe059..b5fdbe3 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -100,7 +100,6 @@ static int kunit_try_catch_test_init(struct kunit *test)
 	.init = kunit_try_catch_test_init,
 	.test_cases = kunit_try_catch_test_cases,
 };
-kunit_test_suite(kunit_try_catch_test_suite);
 
 /*
  * Context for testing test managed resources
@@ -328,4 +327,9 @@ static void kunit_resource_test_exit(struct kunit *test)
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suite(kunit_resource_test_suite);
+kunit_test_suites(&kunit_resource_test_suite,
+		  &kunit_try_catch_test_suite);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
diff --git a/kunit/test.c b/kunit/test.c
index c83c0fa..e7896f1 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -171,6 +171,7 @@ void kunit_do_assertion(struct kunit *test,
 	if (assert->type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
+EXPORT_SYMBOL_GPL(kunit_do_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
@@ -179,6 +180,7 @@ void kunit_init_test(struct kunit *test, const char *name)
 	test->name = name;
 	test->success = true;
 }
+EXPORT_SYMBOL_GPL(kunit_init_test);
 
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
@@ -317,6 +319,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_run_tests);
 
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
@@ -342,6 +345,7 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
 static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
 {
@@ -400,6 +404,7 @@ int kunit_resource_destroy(struct kunit *test,
 	kunit_resource_free(test, resource);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_resource_destroy);
 
 struct kunit_kmalloc_params {
 	size_t size;
@@ -435,6 +440,7 @@ void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 				    gfp,
 				    &params);
 }
+EXPORT_SYMBOL_GPL(kunit_kmalloc);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
@@ -447,6 +453,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 
 	WARN_ON(rc);
 }
+EXPORT_SYMBOL_GPL(kunit_kfree);
 
 void kunit_cleanup(struct kunit *test)
 {
@@ -476,3 +483,4 @@ void kunit_cleanup(struct kunit *test)
 		kunit_resource_free(test, resource);
 	}
 }
+EXPORT_SYMBOL_GPL(kunit_cleanup);
diff --git a/kunit/try-catch.c b/kunit/try-catch.c
index 55686839..a288012 100644
--- a/kunit/try-catch.c
+++ b/kunit/try-catch.c
@@ -19,6 +19,7 @@ void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 	try_catch->try_result = -EFAULT;
 	complete_and_exit(try_catch->try_completion, -EFAULT);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
@@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
 	 * For more background on this topic, see:
 	 * https://mike-bland.com/2011/11/01/small-medium-large.html
 	 */
+#ifndef MODULE
 	if (sysctl_hung_task_timeout_secs) {
 		/*
 		 * If sysctl_hung_task is active, just set the timeout to some
@@ -60,9 +62,9 @@ static unsigned long kunit_test_timeout(void)
 		 */
 		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
 				MSEC_PER_SEC;
-	} else {
+	} else
+#endif
 		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
-	}
 
 	return timeout_msecs;
 }
@@ -106,6 +108,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	try_catch->catch(try_catch->context);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_run);
 
 void kunit_try_catch_init(struct kunit_try_catch *try_catch,
 			  struct kunit *test,
@@ -116,3 +119,4 @@ void kunit_try_catch_init(struct kunit_try_catch *try_catch,
 	try_catch->try = try;
 	try_catch->catch = catch;
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_init);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a425741..1d1e38d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1966,10 +1966,10 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	bool "KUnit test for sysctl"
+	tristate "KUnit test for sysctl"
 	depends on KUNIT
 	help
-	  This builds the proc sysctl unit test, which runs on boot.
+	  This builds the proc sysctl unit test, which runs on boot/module load.
 	  Tests the API contract and implementation correctness of sysctl.
 	  For more information on KUnit and unit tests in general please refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
-- 
1.8.3.1

