Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6B6A5AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbfGPJob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 05:44:31 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40423 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732986AbfGPJni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:43:38 -0400
Received: by mail-qk1-f201.google.com with SMTP id c1so16335114qkl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=63w5YVkHaqg/rHjNEOKiZuF3EQG2b7Qcy+bF7500Y5o=;
        b=gjYzbih+1rL8581Lx4qlzWnF/xmAhUWkdLJBX09JzWv4MitX70oZNLiXds+wfIhnnV
         mrmEAbFLeOry+Sc5+0X/7CExKdZVbotD/vx3wm7kJUO3P7l77Cfli1Jl4Mn+JLST38tF
         U5kP1UcoAVCRYpA7SzhE9Arrx5vuHeTS9bRHk2ZxzQqUlt0Fhj5FcIzWaCfhjo0MJ1CP
         aTcuC7kfha6VlkJADHRqV+jMn+yi+T9RWkMYCDpAV0pDQZkFzjDbCEG+xtRMDWXjba9V
         fQrEouiao3FZdIA6f3Bko0/yYczuV36SFz0skbR2u7uRqPyeuXJsujMQ+juVmF3+iGNm
         J9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=63w5YVkHaqg/rHjNEOKiZuF3EQG2b7Qcy+bF7500Y5o=;
        b=LRmc23E62IWLQLDf8CsJIxChersn9H5RR3bLj3gecRqRVmRczYr6+24HN2NTvkpE3A
         qTQfWaMRnSSwvAYz2Zg0+KijW5NfNwTB+beSLDbm96MXWsrFyQb+0tcfAaZPe2LS71vA
         6DEnUgmbILBIPrn43zt1jPFX5wISJZq4EdwDQ6WHzYZhU2HpxlRTTfoJ+/KCnv86w8OA
         BrXZmbW563PL7d9qHV193Xlb5QogZWHWxA+5WQDLH/UIgi7TD8t4bLC+NU1/z5z+d7C2
         3AVijdmZNBoHZwSBgRBvvmdqaqq0AiwyYPMIgh/czhuzoKeqOoJV9/Ryqg3GCy/R/1h0
         WCzA==
X-Gm-Message-State: APjAAAVdLymk+bi7Q8CidI0gVa9OL4oacI4QZieKLqoTgJxa5+VjJFQM
        GzV4XPCe4dpqVtTQMkDe6dGeTWwyTPBS7m8MzzoDEg==
X-Google-Smtp-Source: APXvYqye3vsVxbg2kD8kBYb7cOJR0bWa6w2gX83q7pW5P0lhmGSUOuzTQE0/SgSt84HCueU43s3/lIB+VdxulFQ0xqphSw==
X-Received: by 2002:a05:620a:685:: with SMTP id f5mr18477515qkh.238.1563270216921;
 Tue, 16 Jul 2019 02:43:36 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:42:54 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 10/18] kunit: test: add tests for kunit test abort
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

Add KUnit tests for the KUnit test abort mechanism (see preceding
commit). Add tests both for general try catch mechanism as well as
non-architecture specific mechanism.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 kunit/Makefile    |   3 +-
 kunit/test-test.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)
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
index 0000000000000..88f4cdf03db2a
--- /dev/null
+++ b/kunit/test-test.c
@@ -0,0 +1,101 @@
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
+	KUNIT_FAIL(test, "Catch should not be called\n");
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
+	KUNIT_FAIL(test, "This line should never be reached\n");
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
+	{}
+};
+
+static struct kunit_suite kunit_try_catch_test_suite = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+kunit_test_suite(kunit_try_catch_test_suite);
-- 
2.22.0.510.g264f2c817a-goog

