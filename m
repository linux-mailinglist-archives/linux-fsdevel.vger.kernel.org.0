Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5071710FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEAXEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:04:12 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50083 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEAXEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:04:12 -0400
Received: by mail-qt1-f202.google.com with SMTP id w34so332061qtc.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VK9HINDKe1ly4ZzA9popLYLUhn/WyGwpic6aL5MWTO0=;
        b=jDzODj1qOqjPXNLY9SVJEw5Z0OL/0dGHwL3ylc6JfNaDy0fvD1/ek5QldXoMtT+Wii
         gZN8qdXAofPpnVzgPYSBP2tpuJl/33rX41ety9coai/kBRfaomAudXxcuqd/B+pMTQM4
         nuvD74OodxNqb+puJnuKFxtGoGtQ8Jb8YOcneWgLvqMNcLWOR/JRY9EEXH29vEXPAY9F
         WM7FBucz36tyOAodIwtDlAy6eteYxtsnUPf67zap2Ens8+2BUGDRijlfBit6ckvICDQF
         7jFcaxQCG0Y1WF3Jug5mZ7Hq2Arz5NtYi1IUx8xpdBh+nqkeSPd22OXr8VTCQofgU42T
         NUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VK9HINDKe1ly4ZzA9popLYLUhn/WyGwpic6aL5MWTO0=;
        b=Z10r34VHnTyrrlobUfMaeYU6TIudoqg+5/Ylz87ANUGMvGgn66JJJDpzjXEw7A+5s4
         qp2Vmoa43UzHFmJ31M5f16EkLuDeJ4iuBYr3BUN5EIxk9q5HGa5ImpjFLJfvRrzAi+yC
         HT+5JlnzXFCv8O5pIwwWx23N6jATRmLPq5SpomK6gvevSns0J7rXVbkZcn13w0Cs57sP
         jhV6izAusHoquBJwIJKLe+CGjp/d4ybrAW5TUSK195OebwN3bQf4RjwWfERuH+hcosSe
         Jyk+DN5aGdNJf6D2sC9H1mauzVM6oIr9I/R6JkKfvV3/h2g+z83LhjpXYLFcbNTQRSUt
         RfTA==
X-Gm-Message-State: APjAAAXQKiUcHYa5Gg4mEMFYTwvwJrcgvGfZff2t/i223UDVlwzhEUwL
        R0wWlpuXiLiBQvj8sG32r8XcvrzbdKTTs/Bi2g63GA==
X-Google-Smtp-Source: APXvYqyncJUl34uJdfoIKmQZCNZHzvln1ZZjvyIJpHC8YcbxXcKTFTZ+XKDcvReciymhjzaPtz7JOzt9WvEWM/epLxeiRw==
X-Received: by 2002:ac8:1082:: with SMTP id a2mr561124qtj.231.1556751850877;
 Wed, 01 May 2019 16:04:10 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:17 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 08/17] kunit: test: add support for test abort
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
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
---
 include/kunit/test.h      |  13 ++++
 include/kunit/try-catch.h |  91 +++++++++++++++++++++++++
 kunit/Makefile            |   3 +-
 kunit/test.c              | 138 +++++++++++++++++++++++++++++++++++---
 kunit/try-catch.c         |  96 ++++++++++++++++++++++++++
 5 files changed, 332 insertions(+), 9 deletions(-)
 create mode 100644 include/kunit/try-catch.h
 create mode 100644 kunit/try-catch.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e441270561ece..1b77caeb5d51f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <kunit/kunit-stream.h>
+#include <kunit/try-catch.h>
 
 struct kunit_resource;
 
@@ -166,15 +167,27 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
+	struct kunit_try_catch try_catch;
 	spinlock_t lock; /* Gaurds all mutable test state. */
 	bool success; /* Protected by lock. */
+	bool death_test; /* Protected by lock. */
 	struct list_head resources; /* Protected by lock. */
 	void (*vprintk)(const struct kunit *test,
 			const char *level,
 			struct va_format *vaf);
 	void (*fail)(struct kunit *test, struct kunit_stream *stream);
+	void (*abort)(struct kunit *test);
 };
 
+static inline void kunit_set_death_test(struct kunit *test, bool death_test)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	test->death_test = death_test;
+	spin_unlock_irqrestore(&test->lock, flags);
+}
+
 int kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_module *module);
diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
new file mode 100644
index 0000000000000..e85abe044b6b5
--- /dev/null
+++ b/include/kunit/try-catch.h
@@ -0,0 +1,91 @@
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
+struct kunit;
+
+/*
+ * struct kunit_try_catch - provides a generic way to run code which might fail.
+ * @context: used to pass user data to the try and catch functions.
+ *
+ * kunit_try_catch provides a generic, architecture independent way to execute
+ * an arbitrary function of type kunit_try_catch_func_t which may bail out by
+ * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
+ * is stopped at the site of invocation and @catch is catch is called.
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
+	void (*run)(struct kunit_try_catch *try_catch);
+	void __noreturn (*throw)(struct kunit_try_catch *try_catch);
+	struct kunit *test;
+	struct completion *try_completion;
+	int try_result;
+	kunit_try_catch_func_t try;
+	kunit_try_catch_func_t catch;
+	void *context;
+};
+
+/*
+ * Exposed to be overridden for other architectures.
+ */
+void kunit_try_catch_init_internal(struct kunit_try_catch *try_catch);
+
+static inline void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+					struct kunit *test,
+					kunit_try_catch_func_t try,
+					kunit_try_catch_func_t catch)
+{
+	try_catch->test = test;
+	kunit_try_catch_init_internal(try_catch);
+	try_catch->try = try;
+	try_catch->catch = catch;
+}
+
+static inline void kunit_try_catch_run(struct kunit_try_catch *try_catch,
+				       void *context)
+{
+	try_catch->context = context;
+	try_catch->run(try_catch);
+}
+
+static inline void __noreturn kunit_try_catch_throw(
+		struct kunit_try_catch *try_catch)
+{
+	try_catch->throw(try_catch);
+}
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
index 60a9ea6cb4697..1f7680cfa11ad 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
-					kunit-stream.o
+					kunit-stream.o \
+					try-catch.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 
diff --git a/kunit/test.c b/kunit/test.c
index 01e82c18b2fa6..5eace2a527a4e 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -6,10 +6,9 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <linux/sched.h>
 #include <linux/sched/debug.h>
-#include <os.h>
 #include <kunit/test.h>
+#include <kunit/try-catch.h>
 
 static bool kunit_get_success(struct kunit *test)
 {
@@ -32,6 +31,18 @@ static void kunit_set_success(struct kunit *test, bool success)
 	spin_unlock_irqrestore(&test->lock, flags);
 }
 
+static bool kunit_get_death_test(struct kunit *test)
+{
+	unsigned long flags;
+	bool death_test;
+
+	spin_lock_irqsave(&test->lock, flags);
+	death_test = test->death_test;
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return death_test;
+}
+
 static int kunit_vprintk_emit(const struct kunit *test,
 			      int level,
 			      const char *fmt,
@@ -70,6 +81,21 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
 	kunit_stream_commit(stream);
 }
 
+static void __noreturn kunit_abort(struct kunit *test)
+{
+	kunit_set_death_test(test, true);
+
+	kunit_try_catch_throw(&test->try_catch);
+
+	/*
+	 * Throw could not abort from test.
+	 *
+	 * XXX: we should never reach this line! As kunit_try_catch_throw is
+	 * marked __noreturn.
+	 */
+	WARN_ONCE(true, "Throw could not abort from test!\n");
+}
+
 int kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
@@ -77,6 +103,7 @@ int kunit_init_test(struct kunit *test, const char *name)
 	test->name = name;
 	test->vprintk = kunit_vprintk;
 	test->fail = kunit_fail;
+	test->abort = kunit_abort;
 
 	return 0;
 }
@@ -122,16 +149,111 @@ static void kunit_run_case_cleanup(struct kunit *test,
 }
 
 /*
- * Performs all logic to run a test case.
+ * Handles an unexpected crash in a test case.
  */
-static bool kunit_run_case(struct kunit *test,
-			   struct kunit_module *module,
-			   struct kunit_case *test_case)
+static void kunit_handle_test_crash(struct kunit *test,
+				   struct kunit_module *module,
+				   struct kunit_case *test_case)
 {
-	kunit_set_success(test, true);
+	kunit_err(test, "%s crashed", test_case->name);
+	/*
+	 * TODO(brendanhiggins@google.com): This prints the stack trace up
+	 * through this frame, not up to the frame that caused the crash.
+	 */
+	show_stack(NULL, NULL);
+
+	kunit_case_internal_cleanup(test);
+}
 
+struct kunit_try_catch_context {
+	struct kunit *test;
+	struct kunit_module *module;
+	struct kunit_case *test_case;
+};
+
+static void kunit_try_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_module *module = ctx->module;
+	struct kunit_case *test_case = ctx->test_case;
+
+	/*
+	 * kunit_run_case_internal may encounter a fatal error; if it does,
+	 * abort will be called, this thread will exit, and finally the parent
+	 * thread will resume control and handle any necessary clean up.
+	 */
 	kunit_run_case_internal(test, module, test_case);
+	/* This line may never be reached. */
 	kunit_run_case_cleanup(test, module, test_case);
+}
+
+static void kunit_catch_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_module *module = ctx->module;
+	struct kunit_case *test_case = ctx->test_case;
+	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
+
+	if (try_exit_code) {
+		kunit_set_success(test, false);
+		/*
+		 * Test case could not finish, we have no idea what state it is
+		 * in, so don't do clean up.
+		 */
+		if (try_exit_code == -ETIMEDOUT)
+			kunit_err(test, "test case timed out\n");
+		/*
+		 * Unknown internal error occurred preventing test case from
+		 * running, so there is nothing to clean up.
+		 */
+		else
+			kunit_err(test, "internal error occurred preventing test case from running: %d\n",
+				  try_exit_code);
+		return;
+	}
+
+	if (kunit_get_death_test(test)) {
+		/*
+		 * EXPECTED DEATH: kunit_run_case_internal encountered
+		 * anticipated fatal error. Everything should be in a safe
+		 * state.
+		 */
+		kunit_run_case_cleanup(test, module, test_case);
+	} else {
+		/*
+		 * UNEXPECTED DEATH: kunit_run_case_internal encountered an
+		 * unanticipated fatal error. We have no idea what the state of
+		 * the test case is in.
+		 */
+		kunit_handle_test_crash(test, module, test_case);
+		kunit_set_success(test, false);
+	}
+}
+
+/*
+ * Performs all logic to run a test case. It also catches most errors that
+ * occurs in a test case and reports them as failures.
+ */
+static bool kunit_run_case_catch_errors(struct kunit *test,
+				       struct kunit_module *module,
+				       struct kunit_case *test_case)
+{
+	struct kunit_try_catch *try_catch = &test->try_catch;
+	struct kunit_try_catch_context context;
+
+	kunit_set_success(test, true);
+	kunit_set_death_test(test, false);
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_try_run_case,
+			     kunit_catch_run_case);
+	context.test = test;
+	context.module = module;
+	context.test_case = test_case;
+	kunit_try_catch_run(try_catch, &context);
 
 	return kunit_get_success(test);
 }
@@ -148,7 +270,7 @@ int kunit_run_tests(struct kunit_module *module)
 		return ret;
 
 	for (test_case = module->test_cases; test_case->run_case; test_case++) {
-		success = kunit_run_case(&test, module, test_case);
+		success = kunit_run_case_catch_errors(&test, module, test_case);
 		if (!success)
 			all_passed = false;
 
diff --git a/kunit/try-catch.c b/kunit/try-catch.c
new file mode 100644
index 0000000000000..c4cdb30880714
--- /dev/null
+++ b/kunit/try-catch.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/try-catch.h>
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+
+static void __noreturn kunit_generic_throw(struct kunit_try_catch *try_catch)
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
+static void kunit_generic_run_try_catch(struct kunit_try_catch *try_catch)
+{
+	DECLARE_COMPLETION_ONSTACK(try_completion);
+	struct kunit *test = try_catch->test;
+	struct task_struct *task_struct;
+	int exit_code, status;
+
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
+	status = wait_for_completion_timeout(&try_completion,
+					     300 * MSEC_PER_SEC); /* 5 min */
+	if (status < 0) {
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
+void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
+{
+	try_catch->run = kunit_generic_run_try_catch;
+	try_catch->throw = kunit_generic_throw;
+}
+
+void __weak kunit_try_catch_init_internal(struct kunit_try_catch *try_catch)
+{
+	kunit_generic_try_catch_init(try_catch);
+}
+
-- 
2.21.0.593.g511ec345e18-goog

