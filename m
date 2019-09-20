Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9141CB9A93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407005AbfITXTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:19:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56203 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406536AbfITXTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:19:51 -0400
Received: by mail-pg1-f202.google.com with SMTP id k18so5338355pgh.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3L1JoIUH3Yp+Gfseapn5B656SrJdhjuXnbbrrnMLohA=;
        b=V4SscDEBlCmcUO5M7afq34KDZYeyB+S8K5qNEp1wyyRoojyAzC8FpsjZhMaAaO/Nhv
         zT3vHtoOLALej48doFAtMgrI4OSy59/qFc96QZOSljW4j7aBmhX1nkmg6KKCyQOaWFUj
         jeO1pkB28xQqz/c5BSyCAXV/wCl0wkNDXL7FDVdeZf3lHm7SEa7nRJSLJTz+EIVxXmjK
         Aux841cN/8k1e4RyAuprpOj+lQ6u58JR70xr3HPk4MUZagsZdFUAh9TDvApbZgulm8mc
         v5iTnjEq1mDmJBiD1U0xi3MDNPR9l0L1Adkzpzdw0y9N40ystVNnmQjJorGsOFZtryue
         sVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3L1JoIUH3Yp+Gfseapn5B656SrJdhjuXnbbrrnMLohA=;
        b=cIbBXgbe3Q68J9IKjPk6fsLirXKgXULfjcWIQ6E/3lxoLymu3nIEvnPduDmxoYzDlX
         8qfSmWUrcXTvBwTIvz0PRSZcAsnghEXbIv+mSQnLCfFcOptgzPt+sFnloz/+Ub8oh2E+
         qET8ZxQuObSHeAfMgaRAQym3Li/Pj2pjiejgct+l0sFOU63Fv/1VeMoITen2dwAxlHOz
         kGgAWichnTUwW8toS4k7VsVgZRouHBgFmZzDmOqPKPIl50Koupu3YFohHfrDCL0MujJt
         dPrkEzFJnQ7+MgDJR4MalAVTnM07q2IXzZxViuwssRkAz6Q+lWStioZV9O1/DqHzcPhp
         J6Xw==
X-Gm-Message-State: APjAAAWZzPPPl+LZpI1jUgyMWZiosDwxZy2lXZx7v1iZrpeThGqPW/bx
        ssYmlZdTRlNAbTAAPZZu/1uuB0RCvDOzar9f9mGQwg==
X-Google-Smtp-Source: APXvYqzpMW5hB1itLnyqDR6kTupbnGBrJEv2DiTd7M3ot0iM3pnf9z/vSd7WYNzhaz60DAoOuEVEZd0L6okYhwv+JD93NQ==
X-Received: by 2002:a65:5888:: with SMTP id d8mr17251943pgu.394.1569021589743;
 Fri, 20 Sep 2019 16:19:49 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:08 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 04/19] kunit: test: add assertion printing library
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

Add `struct kunit_assert` and friends which provide a structured way to
capture data from an expectation or an assertion (introduced later in
the series) so that it may be printed out in the event of a failure.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/assert.h | 356 +++++++++++++++++++++++++++++++++++++++++
 lib/kunit/Makefile     |   3 +-
 lib/kunit/assert.c     | 141 ++++++++++++++++
 3 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/assert.h
 create mode 100644 lib/kunit/assert.c

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
new file mode 100644
index 000000000000..db6a0fca09b4
--- /dev/null
+++ b/include/kunit/assert.h
@@ -0,0 +1,356 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_ASSERT_H
+#define _KUNIT_ASSERT_H
+
+#include <kunit/string-stream.h>
+#include <linux/err.h>
+
+struct kunit;
+
+/**
+ * enum kunit_assert_type - Type of expectation/assertion.
+ * @KUNIT_ASSERTION: Used to denote that a kunit_assert represents an assertion.
+ * @KUNIT_EXPECTATION: Denotes that a kunit_assert represents an expectation.
+ *
+ * Used in conjunction with a &struct kunit_assert to denote whether it
+ * represents an expectation or an assertion.
+ */
+enum kunit_assert_type {
+	KUNIT_ASSERTION,
+	KUNIT_EXPECTATION,
+};
+
+/**
+ * struct kunit_assert - Data for printing a failed assertion or expectation.
+ * @test: the test case this expectation/assertion is associated with.
+ * @type: the type (either an expectation or an assertion) of this kunit_assert.
+ * @line: the source code line number that the expectation/assertion is at.
+ * @file: the file path of the source file that the expectation/assertion is in.
+ * @message: an optional message to provide additional context.
+ * @format: a function which formats the data in this kunit_assert to a string.
+ *
+ * Represents a failed expectation/assertion. Contains all the data necessary to
+ * format a string to a user reporting the failure.
+ */
+struct kunit_assert {
+	struct kunit *test;
+	enum kunit_assert_type type;
+	int line;
+	const char *file;
+	struct va_format message;
+	void (*format)(const struct kunit_assert *assert,
+		       struct string_stream *stream);
+};
+
+/**
+ * KUNIT_INIT_VA_FMT_NULL - Default initializer for struct va_format.
+ *
+ * Used inside a struct initialization block to initialize struct va_format to
+ * default values where fmt and va are null.
+ */
+#define KUNIT_INIT_VA_FMT_NULL { .fmt = NULL, .va = NULL }
+
+/**
+ * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
+ * @kunit: The test case that this expectation/assertion is associated with.
+ * @assert_type: The type (assertion or expectation) of this kunit_assert.
+ * @fmt: The formatting function which builds a string out of this kunit_assert.
+ *
+ * The base initializer for a &struct kunit_assert.
+ */
+#define KUNIT_INIT_ASSERT_STRUCT(kunit, assert_type, fmt) {		       \
+	.test = kunit,							       \
+	.type = assert_type,						       \
+	.file = __FILE__,						       \
+	.line = __LINE__,						       \
+	.message = KUNIT_INIT_VA_FMT_NULL,				       \
+	.format = fmt							       \
+}
+
+void kunit_base_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream);
+
+void kunit_assert_print_msg(const struct kunit_assert *assert,
+			    struct string_stream *stream);
+
+/**
+ * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
+ * @assert: The parent of this type.
+ *
+ * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
+ */
+struct kunit_fail_assert {
+	struct kunit_assert assert;
+};
+
+void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ *
+ * Initializes a &struct kunit_fail_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_fail_assert_format)	       \
+}
+
+/**
+ * struct kunit_unary_assert - Represents a KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
+ * @assert: The parent of this type.
+ * @condition: A string representation of a conditional expression.
+ * @expected_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
+ *
+ * Represents a simple expectation or assertion that simply asserts something is
+ * true or false. In other words, represents the expectations:
+ * KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
+ */
+struct kunit_unary_assert {
+	struct kunit_assert assert;
+	const char *condition;
+	bool expected_true;
+};
+
+void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @cond: A string representation of the expression asserted true or false.
+ * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
+ *
+ * Initializes a &struct kunit_unary_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_UNARY_ASSERT_STRUCT(test, type, cond, expect_true) {	       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_unary_assert_format),	       \
+	.condition = cond,						       \
+	.expected_true = expect_true					       \
+}
+
+/**
+ * struct kunit_ptr_not_err_assert - An expectation/assertion that a pointer is
+ *	not NULL and not a -errno.
+ * @assert: The parent of this type.
+ * @text: A string representation of the expression passed to the expectation.
+ * @value: The actual evaluated pointer value of the expression.
+ *
+ * Represents an expectation/assertion that a pointer is not null and is does
+ * not contain a -errno. (See IS_ERR_OR_NULL().)
+ */
+struct kunit_ptr_not_err_assert {
+	struct kunit_assert assert;
+	const char *text;
+	const void *value;
+};
+
+void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_ptr_not_err_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @txt: A string representation of the expression passed to the expectation.
+ * @val: The actual evaluated pointer value of the expression.
+ *
+ * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(test, type, txt, val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_ptr_not_err_assert_format),   \
+	.text = txt,							       \
+	.value = val							       \
+}
+
+/**
+ * struct kunit_binary_assert - An expectation/assertion that compares two
+ *	non-pointer values (for example, KUNIT_EXPECT_EQ(test, 1 + 1, 2)).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two non-pointer values. For
+ * example, to expect that 1 + 1 == 2, you can use the expectation
+ * KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+ */
+struct kunit_binary_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	long long left_value;
+	const char *right_text;
+	long long right_value;
+};
+
+void kunit_binary_assert_format(const struct kunit_assert *assert,
+				struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(test,				       \
+					type,				       \
+					op_str,				       \
+					left_str,			       \
+					left_val,			       \
+					right_str,			       \
+					right_val) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_assert_format),	       \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+/**
+ * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
+ *	pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two pointer values. For
+ * example, to expect that foo and bar point to the same thing, you can use the
+ * expectation KUNIT_EXPECT_PTR_EQ(test, foo, bar);
+ */
+struct kunit_binary_ptr_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const void *left_value;
+	const char *right_text;
+	const void *right_value;
+};
+
+void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_ptr_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(test,			       \
+					    type,			       \
+					    op_str,			       \
+					    left_str,			       \
+					    left_val,			       \
+					    right_str,			       \
+					    right_val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_ptr_assert_format),    \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+/**
+ * struct kunit_binary_str_assert - An expectation/assertion that compares two
+ *	string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two string values. For
+ * example, to expect that the string in foo is equal to "bar", you can use the
+ * expectation KUNIT_EXPECT_STREQ(test, foo, "bar");
+ */
+struct kunit_binary_str_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const char *left_value;
+	const char *right_text;
+	const char *right_value;
+};
+
+void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_str_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_str_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,			       \
+					    type,			       \
+					    op_str,			       \
+					    left_str,			       \
+					    left_val,			       \
+					    right_str,			       \
+					    right_val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_str_assert_format),    \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+#endif /*  _KUNIT_ASSERT_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 275b565a0e81..6dcbe309036b 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
-					string-stream.o
+					string-stream.o \
+					assert.o
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
new file mode 100644
index 000000000000..86013d4cf891
--- /dev/null
+++ b/lib/kunit/assert.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/assert.h>
+
+void kunit_base_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream)
+{
+	const char *expect_or_assert = NULL;
+
+	switch (assert->type) {
+	case KUNIT_EXPECTATION:
+		expect_or_assert = "EXPECTATION";
+		break;
+	case KUNIT_ASSERTION:
+		expect_or_assert = "ASSERTION";
+		break;
+	}
+
+	string_stream_add(stream, "%s FAILED at %s:%d\n",
+			 expect_or_assert, assert->file, assert->line);
+}
+
+void kunit_assert_print_msg(const struct kunit_assert *assert,
+			    struct string_stream *stream)
+{
+	if (assert->message.fmt)
+		string_stream_add(stream, "\n%pV", &assert->message);
+}
+
+void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream)
+{
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream, "%pV", &assert->message);
+}
+
+void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       struct string_stream *stream)
+{
+	struct kunit_unary_assert *unary_assert = container_of(
+			assert, struct kunit_unary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (unary_assert->expected_true)
+		string_stream_add(stream,
+				 "\tExpected %s to be true, but is false\n",
+				 unary_assert->condition);
+	else
+		string_stream_add(stream,
+				 "\tExpected %s to be false, but is true\n",
+				 unary_assert->condition);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     struct string_stream *stream)
+{
+	struct kunit_ptr_not_err_assert *ptr_assert = container_of(
+			assert, struct kunit_ptr_not_err_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (!ptr_assert->value) {
+		string_stream_add(stream,
+				 "\tExpected %s is not null, but is\n",
+				 ptr_assert->text);
+	} else if (IS_ERR(ptr_assert->value)) {
+		string_stream_add(stream,
+				 "\tExpected %s is not error, but is: %ld\n",
+				 ptr_assert->text,
+				 PTR_ERR(ptr_assert->value));
+	}
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_assert_format(const struct kunit_assert *assert,
+				struct string_stream *stream)
+{
+	struct kunit_binary_assert *binary_assert = container_of(
+			assert, struct kunit_binary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %lld\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %lld",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream)
+{
+	struct kunit_binary_ptr_assert *binary_assert = container_of(
+			assert, struct kunit_binary_ptr_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %pK\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %pK",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream)
+{
+	struct kunit_binary_str_assert *binary_assert = container_of(
+			assert, struct kunit_binary_str_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %s\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %s",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
-- 
2.23.0.351.gc4317032e6-goog

