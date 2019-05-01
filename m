Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA110FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEAXE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:04:26 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:37671 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfEAXEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:04:20 -0400
Received: by mail-oi1-f202.google.com with SMTP id m207so340288oig.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OoB1Q1B1OKTnVM2sKsSTjgsrzyoIYKMiukBZ0PgDZ9o=;
        b=awoM/T0AoqG0wYtJorCPvm2AZEqZUzUs5qq1R8YR0UNkjXyRX24zF53GZ1UD6KiV+8
         WoKSipt9phdWDdeo/zDMvjArUywT8O+1qVccX5uPZnOzbzBfB+8h4jIyjzJGGBdg4n7N
         imrAzBCt4voZvz3O+nOIMytkIln4VOZ1LvzQprZkOv9VhoaC6AXS8ZkpWrt4ZerM7ljw
         vSmK9aGxj4/37leOcxAYhpXvhHLCXqqaZL5x06G9q7/18UfD7rqvqJjZVKB+iD2XROqO
         KzY2suaK26r7WlIWBRrvFuLTnnO37Kovql58dhGKMkYPGEiPzC9D5ieJu5MBGxBF7KnL
         22pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OoB1Q1B1OKTnVM2sKsSTjgsrzyoIYKMiukBZ0PgDZ9o=;
        b=evl40K7FeHF+xjPNPt0iCYpxCetVCdth3CIp00UjScS8ow2Smk7fntOqXG4G5QqbpL
         LJJkVb44KhHN4kGqhxI86r6Ih/v3o898EUdCbDj01Fyv8Jd/JmmzqZIzTDJ441Yshnpr
         Md4wzer8C+JyNGcFHKNbu0VMiVgRkUq/4VgkHOuXqJHwakXWpcuZRLvsJ0vR6zndySL1
         Pfd/7oF1IxHEndajD8YhNTazmfCdR6IUuFf8YDUDf7+i6BsyBSN8leQkfTx7qrRnsXcG
         GbRAHR3w30LrETC87OTacqa1dlgqS5pmF2FCl998iFfyNkTApJoSa7I94tqbrTwE7leY
         tsZA==
X-Gm-Message-State: APjAAAUNln9CvL1NQ158m3nfKzHwfU0jxl+AaGRPDnpjf1Boy3c8839M
        HJHtWyN10yjgXUjAaqN0QZdYpJuTk7OrJ8vLBaRDlw==
X-Google-Smtp-Source: APXvYqxKMbUJy/xMLdXAeTw/fGE6G1FNY/xDT4Lln76o9R+/ouozcRUb5NrhTFvEA3khcNSkJVq0eQ+XTBqWt1COBuiXjg==
X-Received: by 2002:a9d:6b93:: with SMTP id b19mr372226otq.313.1556751859218;
 Wed, 01 May 2019 16:04:19 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:18 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-10-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 09/17] kunit: test: add tests for kunit test abort
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

Add KUnit tests for the KUnit test abort mechanism (see preceding
commit). Add tests both for general try catch mechanism as well as
non-architecture specific mechanism.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/Makefile    |   3 +-
 kunit/test-test.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 kunit/test-test.c

diff --git a/kunit/Makefile b/kunit/Makefile
index 1f7680cfa11ad..533355867abd2 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					kunit-stream.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
+					string-stream-test.o
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/kunit/test-test.c b/kunit/test-test.c
new file mode 100644
index 0000000000000..c81ae6efb959f
--- /dev/null
+++ b/kunit/test-test.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called.\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached.\n");
+}
+
+void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_generic_try_catch_successful_try_no_catch(
+		struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	try_catch->test = test;
+	kunit_generic_try_catch_init(try_catch);
+	try_catch->try = kunit_test_successful_try;
+	try_catch->catch = kunit_test_no_catch;
+
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_generic_try_catch_unsuccessful_try_does_catch(
+		struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	try_catch->test = test;
+	kunit_generic_try_catch_init(try_catch);
+	try_catch->try = kunit_test_unsuccessful_try;
+	try_catch->catch = kunit_test_catch;
+
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	KUNIT_CASE(kunit_test_generic_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_generic_try_catch_unsuccessful_try_does_catch),
+	{},
+};
+
+static struct kunit_module kunit_try_catch_test_module = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+module_test(kunit_try_catch_test_module);
-- 
2.21.0.593.g511ec345e18-goog

