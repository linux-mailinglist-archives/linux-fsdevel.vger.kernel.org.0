Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4DD47C53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfFQI0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 04:26:42 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50048 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFQI0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:26:42 -0400
Received: by mail-pg1-f202.google.com with SMTP id 30so7270490pgk.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c8lNi0PVX+vhUoM2pApH4POTzfRz8BC1BIATthHFevw=;
        b=pxQFw+R+2w7LHRo9fMVDWFvDf6rYji02kvB5++2Rk/Ih7CGQrhRPI/Dw30uflXJXgu
         ne1GpieQWsR96E/ZHJtLBYVKvvqT+WylDFesjIwoWu+cYgy5uDqMIpQ2jEKfHaWo/koO
         tnJaHQuUn2xcTBL58TUYjJgxcMOAehtMuBni9tYFSokj3CUB+XnNEQ3uUR+kva2wNW+C
         ssSK5cM6byo8qkn042m6lId3YzMpCsL43DqBYasQYCn04GF1RS76DFmgfcK80fC0Fcrg
         CIoJqTwArbYo7EwCwu+8MX5ZL4M1lZq5NLjzXgWe0/O5nzzRMfCNqyjBV6krja9GP6s1
         gWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c8lNi0PVX+vhUoM2pApH4POTzfRz8BC1BIATthHFevw=;
        b=VJdt//aAa28REZB6zrf9YSYPNbjlAtOE7JL1QmI7VHvIWJK90Jg8K17VV0H1rtu6b8
         7E3NV9viRzslX7LRpisCp2BThJzmOVMyqH6QBS4K0x0+eqX6BJ9uAa3a3d/dJaiM1+Xn
         fV2VpzRvygWaPi6P1rOMov1aXReFZRpVWEWSdH2NLEONkxaNag5+Fl0DFC1ey5+ImMaC
         nvu5GaJvTNcemC8E9cyCg9iJOAx7w+oVklBM41VQgBkdc2JgsMBEVeBHxFnwpsTHjng/
         iNDs13p6mcuv13wgyz5nLLF9/popuZLMl0lPWIj/fOucqAtKTpBDRl4gyO3xllDxYNU3
         xfaQ==
X-Gm-Message-State: APjAAAWoi3Cvrc7qCIQdmHLhIoVVdOAjzaYu8F08M4OMlYTDgHjccpt8
        1b6eKIfcPWhvzp2Rls0ybBMdvAaJlbs6nz4Ue8EbRA==
X-Google-Smtp-Source: APXvYqzS76Li/e62Ov81F4Ql7E4pNFquk02WLzEZKfWBTbT9jVHGocBenqy78Ve+RiglHzVj5YqtN2uSo5XhTqbsvQsp9A==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr47059108pgq.399.1560760000905;
 Mon, 17 Jun 2019 01:26:40 -0700 (PDT)
Date:   Mon, 17 Jun 2019 01:25:56 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 01/18] kunit: test: add KUnit test runner core
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

Add core facilities for defining unit tests; this provides a common way
to define test cases, functions that execute code which is under test
and determine whether the code under test behaves as expected; this also
provides a way to group together related test cases in test suites (here
we call them test_modules).

Just define test cases and how to execute them for now; setting
expectations on code will be defined later.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes Since Last Revision:
 - Mostly minor fixes suggested by Stephen Boyd
 - Biggest change inlines a bunch of functions in the test case running
   logic to make it more readable as suggested by Stephen Boyd
---
 include/kunit/test.h | 161 +++++++++++++++++++++++++++++++++
 kunit/Kconfig        |  17 ++++
 kunit/Makefile       |   1 +
 kunit/test.c         | 210 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 389 insertions(+)
 create mode 100644 include/kunit/test.h
 create mode 100644 kunit/Kconfig
 create mode 100644 kunit/Makefile
 create mode 100644 kunit/test.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
new file mode 100644
index 0000000000000..8476b3d371cb9
--- /dev/null
+++ b/include/kunit/test.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_H
+#define _KUNIT_TEST_H
+
+#include <linux/types.h>
+
+struct kunit;
+
+/**
+ * struct kunit_case - represents an individual test case.
+ * @run_case: the function representing the actual test case.
+ * @name: the name of the test case.
+ *
+ * A test case is a function with the signature, ``void (*)(struct kunit *)``
+ * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
+ * test case is associated with a &struct kunit_module and will be run after the
+ * module's init function and followed by the module's exit function.
+ *
+ * A test case should be static and should only be created with the KUNIT_CASE()
+ * macro; additionally, every array of test cases should be terminated with an
+ * empty test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	void add_test_basic(struct kunit *test)
+ *	{
+ *		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+ *		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+ *		KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
+ *		KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+ *		KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+ *	}
+ *
+ *	static struct kunit_case example_test_cases[] = {
+ *		KUNIT_CASE(add_test_basic),
+ *		{}
+ *	};
+ *
+ */
+struct kunit_case {
+	void (*run_case)(struct kunit *test);
+	const char *name;
+
+	/* private: internal use only. */
+	bool success;
+};
+
+/**
+ * KUNIT_CASE - A helper for creating a &struct kunit_case
+ * @test_name: a reference to a test case function.
+ *
+ * Takes a symbol for a function representing a test case and creates a
+ * &struct kunit_case object from it. See the documentation for
+ * &struct kunit_case for an example on how to use it.
+ */
+#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+/**
+ * struct kunit_module - describes a related collection of &struct kunit_case s.
+ * @name: the name of the test. Purely informational.
+ * @init: called before every test case.
+ * @exit: called after every test case.
+ * @test_cases: a null terminated array of test cases.
+ *
+ * A kunit_module is a collection of related &struct kunit_case s, such that
+ * @init is called before every test case and @exit is called after every test
+ * case, similar to the notion of a *test fixture* or a *test class* in other
+ * unit testing frameworks like JUnit or Googletest.
+ *
+ * Every &struct kunit_case must be associated with a kunit_module for KUnit to
+ * run it.
+ */
+struct kunit_module {
+	const char name[256];
+	int (*init)(struct kunit *test);
+	void (*exit)(struct kunit *test);
+	struct kunit_case *test_cases;
+};
+
+/**
+ * struct kunit - represents a running instance of a test.
+ * @priv: for user to store arbitrary data. Commonly used to pass data created
+ * in the init function (see &struct kunit_module).
+ *
+ * Used to store information about the current context under which the test is
+ * running. Most of this data is private and should only be accessed indirectly
+ * via public functions; the one exception is @priv which can be used by the
+ * test writer to store arbitrary data.
+ */
+struct kunit {
+	void *priv;
+
+	/* private: internal use only. */
+	const char *name; /* Read only after initialization! */
+	spinlock_t lock; /* Gaurds all mutable test state. */
+	bool success; /* Protected by lock. */
+};
+
+void kunit_init_test(struct kunit *test, const char *name);
+
+int kunit_run_tests(struct kunit_module *module);
+
+/**
+ * module_test() - used to register a &struct kunit_module with KUnit.
+ * @module: a statically allocated &struct kunit_module.
+ *
+ * Registers @module with the test framework. See &struct kunit_module for more
+ * information.
+ */
+#define module_test(module) \
+		static int module_kunit_init##module(void) \
+		{ \
+			return kunit_run_tests(&module); \
+		} \
+		late_initcall(module_kunit_init##module)
+
+void __printf(3, 4) kunit_printk(const char *level,
+				 const struct kunit *test,
+				 const char *fmt, ...);
+
+/**
+ * kunit_info() - Prints an INFO level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * Prints an info level message associated with the test module being run. Takes
+ * a variable number of format parameters just like printk().
+ */
+#define kunit_info(test, fmt, ...) \
+		kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_warn() - Prints a WARN level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * Prints a warning level message.
+ */
+#define kunit_warn(test, fmt, ...) \
+		kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_err() - Prints an ERROR level message associated with the current test.
+ * @test: The test context object.
+ * @fmt: A printk() style format string.
+ *
+ * Prints an error level message.
+ */
+#define kunit_err(test, fmt, ...) \
+		kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+
+#endif /* _KUNIT_TEST_H */
diff --git a/kunit/Kconfig b/kunit/Kconfig
new file mode 100644
index 0000000000000..330ae83527c23
--- /dev/null
+++ b/kunit/Kconfig
@@ -0,0 +1,17 @@
+#
+# KUnit base configuration
+#
+
+menu "KUnit support"
+
+config KUNIT
+	bool "Enable support for unit tests (KUnit)"
+	help
+	  Enables support for kernel unit tests (KUnit), a lightweight unit
+	  testing and mocking framework for the Linux kernel. These tests are
+	  able to be run locally on a developer's workstation without a VM or
+	  special hardware when using UML. Can also be used on most other
+	  architectures. For more information, please see
+	  Documentation/dev-tools/kunit/.
+
+endmenu
diff --git a/kunit/Makefile b/kunit/Makefile
new file mode 100644
index 0000000000000..5efdc4dea2c08
--- /dev/null
+++ b/kunit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KUNIT) +=			test.o
diff --git a/kunit/test.c b/kunit/test.c
new file mode 100644
index 0000000000000..d05d254f1521f
--- /dev/null
+++ b/kunit/test.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/sched/debug.h>
+#include <kunit/test.h>
+
+static bool kunit_get_success(struct kunit *test)
+{
+	unsigned long flags;
+	bool success;
+
+	spin_lock_irqsave(&test->lock, flags);
+	success = test->success;
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return success;
+}
+
+static void kunit_set_success(struct kunit *test, bool success)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	test->success = success;
+	spin_unlock_irqrestore(&test->lock, flags);
+}
+
+static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
+{
+	return vprintk_emit(0, level, NULL, 0, fmt, args);
+}
+
+static int kunit_printk_emit(int level, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = kunit_vprintk_emit(level, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+static void kunit_vprintk(const struct kunit *test,
+			  const char *level,
+			  struct va_format *vaf)
+{
+	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
+}
+
+static bool kunit_has_printed_tap_version;
+
+static void kunit_print_tap_version(void)
+{
+	if (!kunit_has_printed_tap_version) {
+		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
+		kunit_has_printed_tap_version = true;
+	}
+}
+
+static size_t kunit_test_cases_len(struct kunit_case *test_cases)
+{
+	struct kunit_case *test_case;
+	size_t len = 0;
+
+	for (test_case = test_cases; test_case->run_case; test_case++)
+		len++;
+
+	return len;
+}
+
+static void kunit_print_subtest_start(struct kunit_module *module)
+{
+	kunit_print_tap_version();
+	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", module->name);
+	kunit_printk_emit(LOGLEVEL_INFO,
+			  "\t1..%zd\n",
+			  kunit_test_cases_len(module->test_cases));
+}
+
+static void kunit_print_ok_not_ok(bool should_indent,
+				  bool is_ok,
+				  size_t test_number,
+				  const char *description)
+{
+	const char *indent, *ok_not_ok;
+
+	if (should_indent)
+		indent = "\t";
+	else
+		indent = "";
+
+	if (is_ok)
+		ok_not_ok = "ok";
+	else
+		ok_not_ok = "not ok";
+
+	kunit_printk_emit(LOGLEVEL_INFO,
+			  "%s%s %zd - %s\n",
+			  indent, ok_not_ok, test_number, description);
+}
+
+static bool kunit_module_has_succeeded(struct kunit_module *module)
+{
+	const struct kunit_case *test_case;
+	bool success = true;
+
+	for (test_case = module->test_cases; test_case->run_case; test_case++)
+		if (!test_case->success) {
+			success = false;
+			break;
+		}
+
+	return success;
+}
+
+static size_t kunit_module_counter = 1;
+
+static void kunit_print_subtest_end(struct kunit_module *module)
+{
+	kunit_print_ok_not_ok(false,
+			      kunit_module_has_succeeded(module),
+			      kunit_module_counter++,
+			      module->name);
+}
+
+static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
+					    size_t test_number)
+{
+	kunit_print_ok_not_ok(true,
+			      test_case->success,
+			      test_number,
+			      test_case->name);
+}
+
+void kunit_init_test(struct kunit *test, const char *name)
+{
+	spin_lock_init(&test->lock);
+	test->name = name;
+	test->success = true;
+}
+
+/*
+ * Performs all logic to run a test case.
+ */
+static void kunit_run_case(struct kunit_module *module,
+			   struct kunit_case *test_case)
+{
+	struct kunit test;
+	int ret = 0;
+
+	kunit_init_test(&test, test_case->name);
+
+	if (module->init) {
+		ret = module->init(&test);
+		if (ret) {
+			kunit_err(&test, "failed to initialize: %d\n", ret);
+			kunit_set_success(&test, false);
+			return;
+		}
+	}
+
+	if (!ret)
+		test_case->run_case(&test);
+
+	if (module->exit)
+		module->exit(&test);
+
+	test_case->success = kunit_get_success(&test);
+}
+
+int kunit_run_tests(struct kunit_module *module)
+{
+	struct kunit_case *test_case;
+	size_t test_case_count = 1;
+
+	kunit_print_subtest_start(module);
+
+	for (test_case = module->test_cases; test_case->run_case; test_case++) {
+		kunit_run_case(module, test_case);
+		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
+	}
+
+	kunit_print_subtest_end(module);
+
+	return 0;
+}
+
+void kunit_printk(const char *level,
+		  const struct kunit *test,
+		  const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	kunit_vprintk(test, level, &vaf);
+
+	va_end(args);
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

