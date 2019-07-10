Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3326164208
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 09:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGJHQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 03:16:21 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38643 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfGJHQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:16:20 -0400
Received: by mail-pg1-f202.google.com with SMTP id w5so924622pgs.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lgb7c0kk4AIlDFKq2h34ExMTr7WoEQbcibudQeY2BwQ=;
        b=c4RHtPIF0b5ybBSUTVa+t/ItgCrVBSahlENH0BzH8Wq2dq2yLVVF35OkxJUV3l1Tn9
         XnL/wG5+blsIq5m6NQrWPg5aU2EP5unLbyFnX3OAi1WfVyKwQO+7e/YwS64Ts27kDKXv
         ghB6Q1x/ZGnDtVTFdBXw3t2yzLoYDY4IT4eNCLen0yjcVk3CGEsIpoBtrpRBfwbVMiTX
         wchTzERSSZ3mW8HnFoKJcahfB12qZzG1sF/TJQTMLaB9zZz9xvzzAKtnn7GDX+oF6Gm5
         GukcqsTpqL0ElANetZfv92J1JzeOD2SPLI8GupmY8XZTaOUM7X3E2gpHTJ5Ji1D/tBKa
         C/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lgb7c0kk4AIlDFKq2h34ExMTr7WoEQbcibudQeY2BwQ=;
        b=rO8dptEcIdAuWha48fuRGW+IbnC/wGvSKSOtLD39Z8WgaYhFd2fhfnY/DSQBBBvhPk
         kMoJcHsgOJYEqvRBZxwqwXUmx0MBktvGk3UTvZSAiZ9dJxrC08n6vyyfK6Z5Mivucd48
         JTaj4TGboIfHXHpxQRnLOyG0X+W1UZrrUHWd1GJrLHvgdsfviNGoupUWPTfel5OPx+Oh
         AHPqB0Leqq7cfqU2KSFoxaxs2cT2WMpjPA0u2jfpvvjOS5cGinPdrm+LM//Ukog0VrrF
         +En9ybyXUMEqn8kZ0MOyFdFWto/VeqS/8peZQXADpxM6lh1Zyp0C96FAIk8sKnNwIPcE
         1txw==
X-Gm-Message-State: APjAAAW3aD87mTxED1XDEi2Q/b0oHGARcG+ncAqrO8qjW2Cj/Oc4Hy6K
        /n3uMTUxIMYq5i1sJAhbfXsfqdN5ojkND8ACahI8Dw==
X-Google-Smtp-Source: APXvYqx2XxcVOzoedzFHIB0Aqmai6Cyvn8fvKsoYYWEG/eB29/Gf76YdynafvVSmpT/z+fEHdfrG9cYHgSRyWvG4xRCnKA==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr26293650pgm.413.1562742979533;
 Wed, 10 Jul 2019 00:16:19 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:14:57 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 07/18] kunit: test: add initial tests
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

Add a test for string stream along with a simpler example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 kunit/Kconfig              | 21 +++++++++
 kunit/Makefile             |  4 ++
 kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
 kunit/string-stream-test.c | 75 ++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 kunit/example-test.c
 create mode 100644 kunit/string-stream-test.c

diff --git a/kunit/Kconfig b/kunit/Kconfig
index 330ae83527c23..8541ef95b65ad 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
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
+	  itself, kunit/example-test.c, for more information. This option is
+	  intended for curious hackers who would like to understand how to use
+	  KUnit for kernel development.
+
 endmenu
diff --git a/kunit/Makefile b/kunit/Makefile
index 6ddc622ee6b1c..60a9ea6cb4697 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,3 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					kunit-stream.o
+
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/kunit/example-test.c b/kunit/example-test.c
new file mode 100644
index 0000000000000..f64a829aa441f
--- /dev/null
+++ b/kunit/example-test.c
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
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
new file mode 100644
index 0000000000000..b5641b078b8f6
--- /dev/null
+++ b/kunit/string-stream-test.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct string_stream.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/slab.h>
+#include <kunit/test.h>
+#include <kunit/string-stream.h>
+
+static void string_stream_test_empty_on_creation(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test);
+
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_not_empty_after_add(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test);
+
+	string_stream_add(stream, "Foo");
+
+	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+}
+static void string_stream_test_get_string(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test);
+	char *output;
+
+	string_stream_add(stream, "Foo");
+	string_stream_add(stream, " %s", "bar");
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	kfree(output);
+}
+
+static void string_stream_test_add_and_clear(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test);
+	char *output;
+	int i;
+
+	for (i = 0; i < 10; i++)
+		string_stream_add(stream, "A");
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
+	KUNIT_EXPECT_EQ(test, stream->length, (size_t)10);
+	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	kfree(output);
+
+	string_stream_clear(stream);
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "");
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static struct kunit_case string_stream_test_cases[] = {
+	KUNIT_CASE(string_stream_test_empty_on_creation),
+	KUNIT_CASE(string_stream_test_not_empty_after_add),
+	KUNIT_CASE(string_stream_test_get_string),
+	KUNIT_CASE(string_stream_test_add_and_clear),
+	{}
+};
+
+static struct kunit_suite string_stream_test_suite = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+kunit_test_suite(string_stream_test_suite);
-- 
2.22.0.410.gd8fdbe21b5-goog

