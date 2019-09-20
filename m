Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E3BB9A69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407003AbfITXUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:20:01 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45464 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407121AbfITXT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:19:59 -0400
Received: by mail-pg1-f202.google.com with SMTP id i12so5364931pgm.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=edaAP1Y5TWGPl4n15/X44YeJ589/gy1ST6MOkLKJF6o=;
        b=Oq8rASLZBOeemn1oEOECx2UZsaWh1KG+C93n2TkizHU4ntFPyioh9Kl3zF/P4Xr1oI
         HDoJU8dJnAQ+mcAVAzxHUODvRIbOXJJlDZZ1VsL16wIDSdYXdFNQx9C68+VSrfPYb1Z3
         K137MmZy3RFx/4/AmcfyxN2cM/dodgePyScag8UHu7BVN95joJtkAfjqW3SKy9VCZDyL
         yTcgsGeWW2F3TekBD/wqxsNV1ninkzHJg8aaW8YB40uzK2lTpip9Xak8wYoJJ8GiRBS+
         uGNvthZGsihE72LIulRlQOUKlbdezhbvKyUXpwZ/lKnziGbShRnhMnHu4mP6TqSb5J2L
         PaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=edaAP1Y5TWGPl4n15/X44YeJ589/gy1ST6MOkLKJF6o=;
        b=PuspdMMtlaz94VqEU0Jixj6BBhEXLXaPBYeCFvn7DsohyHr1NilOMo5vXe8iv8pbVQ
         wmOpy6CAPN845vtMwacwCebaAFx/KnzPXTLjmIW2bT1sDgtj/LmtzB1gn2HotGUQvGle
         hCBII2S2CghlC1GqF9RgAm60YSd9TGwMNqtcOGNessoCu9nj/dRtX3xi+gI3o3UfhzKn
         KLBzt1w7Q2rcF8MiYAAYJ7RV/vBvxi0Dzl/FHkioCHYSGZFvNfg4eknwPYBwd2S7NTPB
         MFBEJEqmKs9hv+RbW/b5hEm4EdN/bLfXdxE2RuQ6ZAF0PTKEvWKY6u7fXD+2NOUFzqAN
         0VyA==
X-Gm-Message-State: APjAAAW1mJCNOWbZVvbW9n4pxkyd9ke5J6Ma49iJED7dsiI3gItQ8oK7
        mOHdWWrtj/pSIC0SlylOJsOZfIr+XRIKcI3k8efRwA==
X-Google-Smtp-Source: APXvYqzLK5Wz9nsCbJbCDQqMOjypebgDTYugLJXpVuXvFFtCSero7etbcjCIjGWMrvT1//hm5Za2m/3CiIYsa/JnbzK9dg==
X-Received: by 2002:a63:4612:: with SMTP id t18mr17845727pga.85.1569021598008;
 Fri, 20 Sep 2019 16:19:58 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:11 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 07/19] kunit: test: add initial tests
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a test for string stream along with a simpler example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/Kconfig              | 21 ++++++++
 lib/kunit/Makefile             |  4 ++
 lib/kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++
 lib/kunit/string-stream-test.c | 52 ++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 lib/kunit/example-test.c
 create mode 100644 lib/kunit/string-stream-test.c

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 330ae83527c2..a6092f506b79 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -14,4 +14,25 @@ config KUNIT
 	  architectures. For more information, please see
 	  Documentation/dev-tools/kunit/.
 
+config KUNIT_TEST
+	bool "KUnit test for KUnit"
+	depends on KUNIT
+	help
+	  Enables the unit tests for the KUnit test framework. These tests test
+	  the KUnit test framework itself; the tests are both written using
+	  KUnit and test KUnit. This option should only be enabled for testing
+	  purposes by developers interested in testing that KUnit works as
+	  expected.
+
+config KUNIT_EXAMPLE_TEST
+	bool "Example test for KUnit"
+	depends on KUNIT
+	help
+	  Enables an example unit test that illustrates some of the basic
+	  features of KUnit. This test only exists to help new users understand
+	  what KUnit is and how it is used. Please refer to the example test
+	  itself, lib/kunit/example-test.c, for more information. This option
+	  is intended for curious hackers who would like to understand how to
+	  use KUnit for kernel development.
+
 endmenu
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 6dcbe309036b..4e46450bcb3a 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,3 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					assert.o
+
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/lib/kunit/example-test.c b/lib/kunit/example-test.c
new file mode 100644
index 000000000000..f64a829aa441
--- /dev/null
+++ b/lib/kunit/example-test.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test to show how to use KUnit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+
+/*
+ * This is the most fundamental element of KUnit, the test case. A test case
+ * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
+ * any expectations or assertions are not met, the test fails; otherwise, the
+ * test passes.
+ *
+ * In KUnit, a test case is just a function with the signature
+ * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
+ * information about the current test.
+ */
+static void example_simple_test(struct kunit *test)
+{
+	/*
+	 * This is an EXPECTATION; it is how KUnit tests things. When you want
+	 * to test a piece of code, you set some expectations about what the
+	 * code should do. KUnit then runs the test and verifies that the code's
+	 * behavior matched what was expected.
+	 */
+	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+}
+
+/*
+ * This is run once before each test case, see the comment on
+ * example_test_suite for more information.
+ */
+static int example_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing\n");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test suite
+ * below.
+ */
+static struct kunit_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test suite.
+	 */
+	KUNIT_CASE(example_simple_test),
+	{}
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `kunit_cases`.
+ *
+ * Often it is desirable to run some function which will set up things which
+ * will be used by every test; this is accomplished with an `init` function
+ * which runs before each test case is invoked. Similarly, an `exit` function
+ * may be specified which runs after every test case and can be used to for
+ * cleanup. For clarity, running tests in a test suite would behave as follows:
+ *
+ * suite.init(test);
+ * suite.test_case[0](test);
+ * suite.exit(test);
+ * suite.init(test);
+ * suite.test_case[1](test);
+ * suite.exit(test);
+ * ...;
+ */
+static struct kunit_suite example_test_suite = {
+	.name = "example",
+	.init = example_test_init,
+	.test_cases = example_test_cases,
+};
+
+/*
+ * This registers the above test suite telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+kunit_test_suite(example_test_suite);
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
new file mode 100644
index 000000000000..75229e267c32
--- /dev/null
+++ b/lib/kunit/string-stream-test.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct string_stream.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/string-stream.h>
+#include <kunit/test.h>
+#include <linux/slab.h>
+
+static void string_stream_test_empty_on_creation(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_not_empty_after_add(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+
+	string_stream_add(stream, "Foo");
+
+	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_get_string(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	char *output;
+
+	string_stream_add(stream, "Foo");
+	string_stream_add(stream, " %s", "bar");
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+}
+
+static struct kunit_case string_stream_test_cases[] = {
+	KUNIT_CASE(string_stream_test_empty_on_creation),
+	KUNIT_CASE(string_stream_test_not_empty_after_add),
+	KUNIT_CASE(string_stream_test_get_string),
+	{}
+};
+
+static struct kunit_suite string_stream_test_suite = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+kunit_test_suite(string_stream_test_suite);
-- 
2.23.0.351.gc4317032e6-goog

