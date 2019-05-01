Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6810FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEAXEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:04:09 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35503 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEAXEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:04:04 -0400
Received: by mail-pl1-f202.google.com with SMTP id x5so283568pll.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YVYGoozNW1oK9Pxwi3Zx9NUDVKcfq/grXAlQifS5URw=;
        b=Y76ssic07itjfGQGNmhyQDrNY8QfCH3OQJnoZ4EHlZJNTyDHQngPbslrv77bRVVLFP
         sxhk+RkJD/vUt5kRfSM6dnO2k2nS0Kod7Zj0hFLTHMTpYsYYQQA/tkKhHsLWZi7UGz/p
         tYo2XDEIMrLR/VCrz9CHcrpgw/r869mlrnUe26NvGWeRyFB8Enq803huKjFYif7mt55S
         E8dBCmIcUh+tP1SY1Wpa9WauGKmW5iCRlqTcCmSsjg7fbFS7InS2z/bzhImoGZG2syiY
         Ns6xxC6GWORAcnzIajB2tHbXjXcQkVrmMyQCTN6fpi+FkyTeINPuo3yoBwuXBwPAHtp9
         MzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YVYGoozNW1oK9Pxwi3Zx9NUDVKcfq/grXAlQifS5URw=;
        b=Vt8PtFGK2SRe/b9Ca0kyb4NAzrGR+q1+247IEZFVFpfDBYzUahwYgbj2FOTp4z3bqP
         sWlqeUXN0uR2ixSJn0Z/8YEn0UTTz7czSUlZ3aHEVg1xm6NHR20oJwKy0x91TiaacVfB
         CANz41QsTXQNMh8AnLL4XWgwYJ2+GSP1fBkcaKJFftGYME13nUeJAjDHvsf4MDUsyxWd
         L0PCmehANkpJiQPxvAbm6rad0dBvjxBwAKkZnULLJZz7la/PLESXJ+Ys3CwNrBFRlo0z
         +x8wrjiXDmSFRDjVF19sArx4zkx8r0SUB3Pt9dkv6QSCJaUubFsNtE7rfOZRD3dEYGKC
         IKVw==
X-Gm-Message-State: APjAAAUUIZxzjSD0HiPRIBnMIGEntk1RtD6LdKuMuvFOcPHYmwbkLnN2
        sRGgj8AUNV1lfRg02zcZH2G+yF2yECwXjJN6ajkzPA==
X-Google-Smtp-Source: APXvYqz0pkYBiPKRV7XwFRATidRGmRCE3DcxKYOa52o7H0pWOF808PMJU5QfSstPko0tY1TZPeStQAi1xmx7bMzlEyJ9DQ==
X-Received: by 2002:a65:5286:: with SMTP id y6mr557437pgp.79.1556751842420;
 Wed, 01 May 2019 16:04:02 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:16 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 07/17] kunit: test: add initial tests
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

Add a test for string stream along with a simpler example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/Kconfig              | 12 ++++++
 kunit/Makefile             |  4 ++
 kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
 kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 kunit/example-test.c
 create mode 100644 kunit/string-stream-test.c

diff --git a/kunit/Kconfig b/kunit/Kconfig
index 64480092b2c24..5cb500355c873 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -13,4 +13,16 @@ config KUNIT
 	  special hardware. For more information, please see
 	  Documentation/kunit/
 
+config KUNIT_TEST
+	bool "KUnit test for KUnit"
+	depends on KUNIT
+	help
+	  Enables KUnit test to test KUnit.
+
+config KUNIT_EXAMPLE_TEST
+	bool "Example test for KUnit"
+	depends on KUNIT
+	help
+	  Enables example KUnit test to demo features of KUnit.
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
index 0000000000000..3947dd7c8f922
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
+ * example_test_module for more information.
+ */
+static int example_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing\n");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test module
+ * below.
+ */
+static struct kunit_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test module.
+	 */
+	KUNIT_CASE(example_simple_test),
+	{},
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
+ * cleanup. For clarity, running tests in a test module would behave as follows:
+ *
+ * module.init(test);
+ * module.test_case[0](test);
+ * module.exit(test);
+ * module.init(test);
+ * module.test_case[1](test);
+ * module.exit(test);
+ * ...;
+ */
+static struct kunit_module example_test_module = {
+	.name = "example",
+	.init = example_test_init,
+	.test_cases = example_test_cases,
+};
+
+/*
+ * This registers the above test module telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+module_test(example_test_module);
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
new file mode 100644
index 0000000000000..b2a98576797c9
--- /dev/null
+++ b/kunit/string-stream-test.c
@@ -0,0 +1,61 @@
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
+static void string_stream_test_get_string(struct kunit *test)
+{
+	struct string_stream *stream = new_string_stream();
+	char *output;
+
+	string_stream_add(stream, "Foo");
+	string_stream_add(stream, " %s", "bar");
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	kfree(output);
+	destroy_string_stream(stream);
+}
+
+static void string_stream_test_add_and_clear(struct kunit *test)
+{
+	struct string_stream *stream = new_string_stream();
+	char *output;
+	int i;
+
+	for (i = 0; i < 10; i++)
+		string_stream_add(stream, "A");
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
+	KUNIT_EXPECT_EQ(test, stream->length, 10);
+	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	kfree(output);
+
+	string_stream_clear(stream);
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "");
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+	destroy_string_stream(stream);
+}
+
+static struct kunit_case string_stream_test_cases[] = {
+	KUNIT_CASE(string_stream_test_get_string),
+	KUNIT_CASE(string_stream_test_add_and_clear),
+	{}
+};
+
+static struct kunit_module string_stream_test_module = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+module_test(string_stream_test_module);
+
-- 
2.21.0.593.g511ec345e18-goog

