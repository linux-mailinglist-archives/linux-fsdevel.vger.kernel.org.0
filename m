Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD58CB3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfHNFwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 01:52:36 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46034 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfHNFwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:52:35 -0400
Received: by mail-qt1-f202.google.com with SMTP id l9so101893405qtu.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 22:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rsrYRcQx/K8X9YGPWtjlT8srwhyLecLc+83e4Ejl3i8=;
        b=lARC9aKIq+sQswpBPars7D7uiLJgUo+pnwVp/yeuU3JvBq1Axi7bFfXBQ0ZGAmK5vj
         hGqDrH6457gnHTrVNvo8p0jwCskWBsHJiBtPLsP7AObgQHUje4Ft9gGLW11CeWWeCvw7
         A084AFz68mM+9swCKzXbzpC8Dba8itClFC5nbXoTuZ3XIGPZR0YZDeNhstzhberLZzk7
         LqVncK/Kss8uppdIxT/NfN6CzhVtdwl6F10sUVOuqIYQFp+cOh1jTjLRwoLbynJexBn2
         SAhhoFK7X29836i7VMmCTHwQokxsAO8fhyW2+8dkWNdFyW9mSG0jKE1/aFp9vpWwBSXG
         dIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rsrYRcQx/K8X9YGPWtjlT8srwhyLecLc+83e4Ejl3i8=;
        b=X1mFWVpCWl5ae0fXnod1NJ5J2z+walBTvR6FnYErWOTOa7zQA8zdc7epb7rBff4n47
         WAWfMaTB2vuOe/81yQgxTR7akZoIsBt8gLSoOqVQVJrDvi0j61DQ6fFxP/uV2y5QsEtR
         gt7szsRU6XU9b+pWvQn8rDu+xRFD/GRlpv4Hlw1kE9tEZ6X8u5Vs3nxvGSFGjCuDuW//
         s8O2PhwZY0tiNPKmwwMG5r4fQl8MbLqMFMWYD4gUTlYjoBjnYzIxgdfxa9E7A6a0WSwc
         COOUyzvpcMT2RdGfTG9daRdmE/JJyk2hF08IfZgeFIqddRyvScWfgMt3WpJQ0TpIbZg/
         pCuA==
X-Gm-Message-State: APjAAAWZzzpJX37UgyafoqSZxVKhlMr4DMQAE7hYxYFvKm8ZCPSs+MCz
        R3SdK4QjiHKaOpLIwPqzX9tpMD2yS74EkOglFzlzHw==
X-Google-Smtp-Source: APXvYqxfDEY77WQ0Gx9Lw3q6/CT9YpVmW6ghz55pEk6kNueZ2vS8W3cCZmBnFTQgfSnBkArI46fAJb/bFO9GfLzMqBKzjQ==
X-Received: by 2002:a37:a603:: with SMTP id p3mr36972417qke.297.1565761953810;
 Tue, 13 Aug 2019 22:52:33 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:50:59 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-10-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 09/18] kunit: test: add support for test abort
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for aborting/bailing out of test cases, which is needed for
implementing assertions.

An assertion is like an expectation, but bails out of the test case
early if the assertion is not met. The idea with assertions is that you
use them to state all the preconditions for your test. Logically
speaking, these are the premises of the test case, so if a premise isn't
true, there is no point in continuing the test case because there are no
conclusions that can be drawn without the premises. Whereas, the
expectation is the thing you are trying to prove.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/test.h      |   2 +
 include/kunit/try-catch.h |  75 +++++++++++++++++++++
 kunit/Makefile            |   3 +-
 kunit/test.c              | 137 +++++++++++++++++++++++++++++++++-----
 kunit/try-catch.c         | 118 ++++++++++++++++++++++++++++++++
 5 files changed, 319 insertions(+), 16 deletions(-)
 create mode 100644 include/kunit/try-catch.h
 create mode 100644 kunit/try-catch.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 4c41e6bde1588..f52c7c65ef651 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -10,6 +10,7 @@
 #define _KUNIT_TEST_H
 
 #include <kunit/assert.h>
+#include <kunit/try-catch.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -167,6 +168,7 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
+	struct kunit_try_catch try_catch;
 	/*
 	 * success starts as true, and may only be set to false during a test
 	 * case; thus, it is safe to update this across multiple threads using
diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
new file mode 100644
index 0000000000000..404f336cbdc85
--- /dev/null
+++ b/include/kunit/try-catch.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TRY_CATCH_H
+#define _KUNIT_TRY_CATCH_H
+
+#include <linux/types.h>
+
+typedef void (*kunit_try_catch_func_t)(void *);
+
+struct completion;
+struct kunit;
+
+/**
+ * struct kunit_try_catch - provides a generic way to run code which might fail.
+ * @test: The test case that is currently being executed.
+ * @try_completion: Completion that the control thread waits on while test runs.
+ * @try_result: Contains any errno obtained while running test case.
+ * @try: The function, the test case, to attempt to run.
+ * @catch: The function called if @try bails out.
+ * @context: used to pass user data to the try and catch functions.
+ *
+ * kunit_try_catch provides a generic, architecture independent way to execute
+ * an arbitrary function of type kunit_try_catch_func_t which may bail out by
+ * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
+ * is stopped at the site of invocation and @catch is called.
+ *
+ * struct kunit_try_catch provides a generic interface for the functionality
+ * needed to implement kunit->abort() which in turn is needed for implementing
+ * assertions. Assertions allow stating a precondition for a test simplifying
+ * how test cases are written and presented.
+ *
+ * Assertions are like expectations, except they abort (call
+ * kunit_try_catch_throw()) when the specified condition is not met. This is
+ * useful when you look at a test case as a logical statement about some piece
+ * of code, where assertions are the premises for the test case, and the
+ * conclusion is a set of predicates, rather expectations, that must all be
+ * true. If your premises are violated, it does not makes sense to continue.
+ */
+struct kunit_try_catch {
+	/* private: internal use only. */
+	struct kunit *test;
+	struct completion *try_completion;
+	int try_result;
+	kunit_try_catch_func_t try;
+	kunit_try_catch_func_t catch;
+	void *context;
+};
+
+void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+			  struct kunit *test,
+			  kunit_try_catch_func_t try,
+			  kunit_try_catch_func_t catch);
+
+void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
+
+void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
+
+static inline int kunit_try_catch_get_result(struct kunit_try_catch *try_catch)
+{
+	return try_catch->try_result;
+}
+
+/*
+ * Exposed for testing only.
+ */
+void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
+
+#endif /* _KUNIT_TRY_CATCH_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 4e46450bcb3a8..c9176c9c578c6 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
-					assert.o
+					assert.o \
+					try-catch.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 
diff --git a/kunit/test.c b/kunit/test.c
index 3cbceb34b3b36..ded9895143209 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -7,7 +7,9 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/sched/debug.h>
 
 static void kunit_set_failure(struct kunit *test)
 {
@@ -162,6 +164,19 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 	WARN_ON(string_stream_destroy(stream));
 }
 
+static void __noreturn kunit_abort(struct kunit *test)
+{
+	kunit_try_catch_throw(&test->try_catch); /* Does not return. */
+
+	/*
+	 * Throw could not abort from test.
+	 *
+	 * XXX: we should never reach this line! As kunit_try_catch_throw is
+	 * marked __noreturn.
+	 */
+	BUG();
+}
+
 void kunit_do_assertion(struct kunit *test,
 			struct kunit_assert *assert,
 			bool pass,
@@ -180,6 +195,9 @@ void kunit_do_assertion(struct kunit *test,
 	kunit_fail(test, assert);
 
 	va_end(args);
+
+	if (assert->type == KUNIT_ASSERTION)
+		kunit_abort(test);
 }
 
 void kunit_init_test(struct kunit *test, const char *name)
@@ -191,33 +209,122 @@ void kunit_init_test(struct kunit *test, const char *name)
 }
 
 /*
- * Performs all logic to run a test case.
+ * Initializes and runs test case. Does not clean up or do post validations.
  */
-static void kunit_run_case(struct kunit_suite *suite,
-			   struct kunit_case *test_case)
+static void kunit_run_case_internal(struct kunit *test,
+				    struct kunit_suite *suite,
+				    struct kunit_case *test_case)
 {
-	struct kunit test;
-
-	kunit_init_test(&test, test_case->name);
-
 	if (suite->init) {
 		int ret;
 
-		ret = suite->init(&test);
+		ret = suite->init(test);
 		if (ret) {
-			kunit_err(&test, "failed to initialize: %d\n", ret);
-			kunit_set_failure(&test);
-			test_case->success = test.success;
+			kunit_err(test, "failed to initialize: %d\n", ret);
+			kunit_set_failure(test);
 			return;
 		}
 	}
 
-	test_case->run_case(&test);
+	test_case->run_case(test);
+}
 
+static void kunit_case_internal_cleanup(struct kunit *test)
+{
+	kunit_cleanup(test);
+}
+
+/*
+ * Performs post validations and cleanup after a test case was run.
+ * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
+ */
+static void kunit_run_case_cleanup(struct kunit *test,
+				   struct kunit_suite *suite)
+{
 	if (suite->exit)
-		suite->exit(&test);
+		suite->exit(test);
+
+	kunit_case_internal_cleanup(test);
+}
+
+struct kunit_try_catch_context {
+	struct kunit *test;
+	struct kunit_suite *suite;
+	struct kunit_case *test_case;
+};
+
+static void kunit_try_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+	struct kunit_case *test_case = ctx->test_case;
+
+	/*
+	 * kunit_run_case_internal may encounter a fatal error; if it does,
+	 * abort will be called, this thread will exit, and finally the parent
+	 * thread will resume control and handle any necessary clean up.
+	 */
+	kunit_run_case_internal(test, suite, test_case);
+	/* This line may never be reached. */
+	kunit_run_case_cleanup(test, suite);
+}
+
+static void kunit_catch_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
+
+	if (try_exit_code) {
+		kunit_set_failure(test);
+		/*
+		 * Test case could not finish, we have no idea what state it is
+		 * in, so don't do clean up.
+		 */
+		if (try_exit_code == -ETIMEDOUT) {
+			kunit_err(test, "test case timed out\n");
+		/*
+		 * Unknown internal error occurred preventing test case from
+		 * running, so there is nothing to clean up.
+		 */
+		} else {
+			kunit_err(test, "internal error occurred preventing test case from running: %d\n",
+				  try_exit_code);
+		}
+		return;
+	}
+
+	/*
+	 * Test case was run, but aborted. It is the test case's business as to
+	 * whether it failed or not, we just need to clean up.
+	 */
+	kunit_run_case_cleanup(test, suite);
+}
+
+/*
+ * Performs all logic to run a test case. It also catches most errors that
+ * occur in a test case and reports them as failures.
+ */
+static void kunit_run_case_catch_errors(struct kunit_suite *suite,
+					struct kunit_case *test_case)
+{
+	struct kunit_try_catch_context context;
+	struct kunit_try_catch *try_catch;
+	struct kunit test;
+
+	kunit_init_test(&test, test_case->name);
+	try_catch = &test.try_catch;
 
-	kunit_cleanup(&test);
+	kunit_try_catch_init(try_catch,
+			     &test,
+			     kunit_try_run_case,
+			     kunit_catch_run_case);
+	context.test = &test;
+	context.suite = suite;
+	context.test_case = test_case;
+	kunit_try_catch_run(try_catch, &context);
 
 	test_case->success = test.success;
 }
@@ -230,7 +337,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_print_subtest_start(suite);
 
 	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
-		kunit_run_case(suite, test_case);
+		kunit_run_case_catch_errors(suite, test_case);
 		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
 	}
 
diff --git a/kunit/try-catch.c b/kunit/try-catch.c
new file mode 100644
index 0000000000000..55686839eb619
--- /dev/null
+++ b/kunit/try-catch.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/try-catch.h>
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/sched/sysctl.h>
+
+void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
+{
+	try_catch->try_result = -EFAULT;
+	complete_and_exit(try_catch->try_completion, -EFAULT);
+}
+
+static int kunit_generic_run_threadfn_adapter(void *data)
+{
+	struct kunit_try_catch *try_catch = data;
+
+	try_catch->try(try_catch->context);
+
+	complete_and_exit(try_catch->try_completion, 0);
+}
+
+static unsigned long kunit_test_timeout(void)
+{
+	unsigned long timeout_msecs;
+
+	/*
+	 * TODO(brendanhiggins@google.com): We should probably have some type of
+	 * variable timeout here. The only question is what that timeout value
+	 * should be.
+	 *
+	 * The intention has always been, at some point, to be able to label
+	 * tests with some type of size bucket (unit/small, integration/medium,
+	 * large/system/end-to-end, etc), where each size bucket would get a
+	 * default timeout value kind of like what Bazel does:
+	 * https://docs.bazel.build/versions/master/be/common-definitions.html#test.size
+	 * There is still some debate to be had on exactly how we do this. (For
+	 * one, we probably want to have some sort of test runner level
+	 * timeout.)
+	 *
+	 * For more background on this topic, see:
+	 * https://mike-bland.com/2011/11/01/small-medium-large.html
+	 */
+	if (sysctl_hung_task_timeout_secs) {
+		/*
+		 * If sysctl_hung_task is active, just set the timeout to some
+		 * value less than that.
+		 *
+		 * In regards to the above TODO, if we decide on variable
+		 * timeouts, this logic will likely need to change.
+		 */
+		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
+				MSEC_PER_SEC;
+	} else {
+		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
+	}
+
+	return timeout_msecs;
+}
+
+void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
+{
+	DECLARE_COMPLETION_ONSTACK(try_completion);
+	struct kunit *test = try_catch->test;
+	struct task_struct *task_struct;
+	int exit_code, time_remaining;
+
+	try_catch->context = context;
+	try_catch->try_completion = &try_completion;
+	try_catch->try_result = 0;
+	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
+				  try_catch,
+				  "kunit_try_catch_thread");
+	if (IS_ERR(task_struct)) {
+		try_catch->catch(try_catch->context);
+		return;
+	}
+
+	time_remaining = wait_for_completion_timeout(&try_completion,
+						     kunit_test_timeout());
+	if (time_remaining == 0) {
+		kunit_err(test, "try timed out\n");
+		try_catch->try_result = -ETIMEDOUT;
+	}
+
+	exit_code = try_catch->try_result;
+
+	if (!exit_code)
+		return;
+
+	if (exit_code == -EFAULT)
+		try_catch->try_result = 0;
+	else if (exit_code == -EINTR)
+		kunit_err(test, "wake_up_process() was never called\n");
+	else if (exit_code)
+		kunit_err(test, "Unknown error: %d\n", exit_code);
+
+	try_catch->catch(try_catch->context);
+}
+
+void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+			  struct kunit *test,
+			  kunit_try_catch_func_t try,
+			  kunit_try_catch_func_t catch)
+{
+	try_catch->test = test;
+	try_catch->try = try;
+	try_catch->catch = catch;
+}
-- 
2.23.0.rc1.153.gdeed80330f-goog

