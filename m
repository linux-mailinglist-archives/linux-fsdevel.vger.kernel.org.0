Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B210B9B28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407367AbfIUAT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 20:19:26 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42090 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407368AbfIUATZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id d3so1818906pgv.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HUig3O/TcISsFITrNK1jfa3MiZCemlEwRwNLdW9+MBA=;
        b=bXhlCrQbOYlLwsh2RvftzRIh23Jl9nh9scdsLl9WgWP6lalPe8eEkD6o+unjnTY4QX
         hKEBphnraOXtLfjCiiS9R8zDls4TqdEUH/YgLb+45J6Uit4NDCpUgKfDQaNWmuq43Apo
         xRZaI7/HBm+X7O8MVIj7248LsMH4nnbp+jnTRf3Ju91hPYI2/LxME7JRgKlTSxWc5Lgv
         O6xqS6u2ki5/EHt4F+CBMU38Qr3ivXEa7NVQlemgq9PvHDijn72TqYXTkx0n3B2VAv+g
         XVIWOV8Y3uTZkT1FI+OtOS55/ZXz69jPb8090aspbrg0tbhfw3kS7Gf8Mipp/i/tYzvB
         2rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HUig3O/TcISsFITrNK1jfa3MiZCemlEwRwNLdW9+MBA=;
        b=Xr7/y2dPhIxokn1mp2MLYu6B/oMpIe16HnlJgdnYZoklc4NFhj6fEXNrAcQ4qZFsgP
         6gNID0f8N50qTLX6A18AzRL1kRCJz+/hfF0OTsIImZn72XvUIdpfIKxdVEyvWgRVuLv8
         7tx+enR2rE2KbXFH5V/ezKMmd0/OSjfN7Do94s5xVou7npFNsJdF1jzxr+rvp6g8vwbF
         Ek4SbgBlZ6CKISJavUuaYwA5jkvOkTlYn5v2F4lxffiAG+kYdqgc/tErjZHdoLCnBKwr
         cvVZYy4zn4nU19T6NeoQb+H0ikv8YJTauJS1ZDittk+ZRdb3xYltxriUmIChl1aDAJ+e
         9lWg==
X-Gm-Message-State: APjAAAUOKxNsRITZcD62xD9MHqNzbeS943gf8EskxPr3hd0LSFkjhnlb
        UJ9CvjdWOmT944DNOcHxFcTSeqoc/e5699IUWPzYJA==
X-Google-Smtp-Source: APXvYqyXnnjiwjZHHbUIqJ3PyOl/Lbl6F7f5nYwBpu5YxWWvg9AuxdDHLi/bNjIdfvEzKNXDkVxOWAy19HA7e1bwTVU8mA==
X-Received: by 2002:a63:f745:: with SMTP id f5mr3312171pgk.175.1569025163763;
 Fri, 20 Sep 2019 17:19:23 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:43 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 07/19] kunit: test: add initial tests
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
 lib/kunit/Kconfig              | 25 ++++++++++
 lib/kunit/Makefile             |  4 ++
 lib/kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++
 lib/kunit/string-stream-test.c | 52 ++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 lib/kunit/example-test.c
 create mode 100644 lib/kunit/string-stream-test.c

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 666b9cb67a74..3868c226cf31 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -11,3 +11,28 @@ menuconfig KUNIT
 	  special hardware when using UML. Can also be used on most other
 	  architectures. For more information, please see
 	  Documentation/dev-tools/kunit/.
+
+if KUNIT
+
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
+endif # KUNIT
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

