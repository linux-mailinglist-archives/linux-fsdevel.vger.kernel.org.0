Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7100E8A636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfHLSYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:24:55 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51914 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHLSYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:24:54 -0400
Received: by mail-pl1-f201.google.com with SMTP id p9so2590282pls.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QvM52nqi3zkNgabbDdMRrNHzOrV5XtJjnJby+gbqkVc=;
        b=tr8RBKhL+pstfwQNKmpubwjfFQ7QOt/0LYnsoBUgbYBCliriqRpBtMPW3HSWlFk3rS
         MWm6RogQ7jLMNOG8R8b/CEzZBdz0KflrRBFxye8K4loYvP8ln4hEHJ5lpc7TgyBPK4Tv
         HiHHRGQfGlLvVIZ0pkk0wG2CsxCnSKItjQ+eQ6Xx5831hr4Y44soJe8YRelOISIPZZG5
         gbMZidPHjmaOl4pIhYo5dRbAsYXWDt46i3zYP0B5eKM2/lgueIftYAF9DL1qWQrIa5oR
         PMVM5++8CdDp6bnZ9MdvCOHMO5SZntGjsWK+ufSIRTZcydXuFoL0NP8rD1hOuNf2m3VZ
         LcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QvM52nqi3zkNgabbDdMRrNHzOrV5XtJjnJby+gbqkVc=;
        b=FzXgXqyi9dlZo3QvfDubivZ571NlxRzH2I+sRhP+mvWGMuR+Qt8cNPIh7vnkWMdYLj
         c5lYcsdVayAd7qYd0zu49G+Oj/RoN0kVqKbUwFt8wC/zFZpzV2OYCXPzeMUKScYnRerK
         gH53tjVTrxpFclB70ECATkAeK73mAuUsq6SSvYHATNPozhWlzHd5+GDTLbaoKtn/97V+
         W72WkxE8K1oG0q00uzBOrJrJ43OY7SmVovvQoDdPMZ5m2jKHR50AGafibyV0ssHvdsYz
         tFQNNnMX82YGAumVXwX2PKkQFW6NKc7up6Clm5HjZjZcz9tl9wIzl6w2+KCohD3u+yVz
         VnsA==
X-Gm-Message-State: APjAAAW9NrqA4uEfzavw5mdG4IwbzTAG/GtJo0OhdqL9kl2hb69vE5oy
        NAXmz3xv9Mx4MzFLV/o5veUvU6LUax1Jwo7I69lMWw==
X-Google-Smtp-Source: APXvYqxb6GUY2/6u7pcGnLbJDFDMdsL7DCjLn2F9qmz8hscgX64CSnrwQueA5m9KG3SNYDBu8XwlVeC7xstNjBeBMSZNew==
X-Received: by 2002:a63:4522:: with SMTP id s34mr31041690pga.362.1565634292508;
 Mon, 12 Aug 2019 11:24:52 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:08 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 05/18] kunit: test: add the concept of expectations
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

Add support for expectations, which allow properties to be specified and
then verified in tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/test.h | 843 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  58 +++
 2 files changed, 901 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d0bf112910caf..2625bcfeb19ac 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -9,8 +9,10 @@
 #ifndef _KUNIT_TEST_H
 #define _KUNIT_TEST_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <kunit/assert.h>
 
 struct kunit_resource;
 
@@ -319,4 +321,845 @@ void __printf(3, 4) kunit_printk(const char *level,
 #define kunit_err(test, fmt, ...) \
 		kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * Generates a compile-time warning in case of comparing incompatible types.
+ */
+#define __kunit_typecheck(lhs, rhs) \
+	((void) __typecheck(lhs, rhs))
+
+/**
+ * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
+ * @test: The test context object.
+ *
+ * The opposite of KUNIT_FAIL(), it is an expectation that cannot fail. In other
+ * words, it does nothing and only exists for code clarity. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_SUCCEED(test) do {} while (0)
+
+void kunit_do_assertion(struct kunit *test,
+			struct kunit_assert *assert,
+			bool pass,
+			const char *fmt, ...);
+
+#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
+	struct assert_class __assertion = INITIALIZER;			       \
+	kunit_do_assertion(test,					       \
+			   &__assertion.assert,				       \
+			   pass,					       \
+			   fmt,						       \
+			   ##__VA_ARGS__);				       \
+} while (0)
+
+
+#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
+		KUNIT_ASSERTION(test,					       \
+				false,					       \
+				kunit_fail_assert,			       \
+				KUNIT_INIT_FAIL_ASSERT_STRUCT(test,	       \
+							      assert_type),    \
+				fmt,					       \
+				##__VA_ARGS__)
+
+/**
+ * KUNIT_FAIL() - Always causes a test to fail when evaluated.
+ * @test: The test context object.
+ * @fmt: an informational message to be printed when the assertion is made.
+ * @...: string format arguments.
+ *
+ * The opposite of KUNIT_SUCCEED(), it is an expectation that always fails. In
+ * other words, it always results in a failed expectation, and consequently
+ * always causes the test case to fail when evaluated. See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_FAIL(test, fmt, ...)					       \
+		KUNIT_FAIL_ASSERTION(test,				       \
+				     KUNIT_EXPECTATION,			       \
+				     fmt,				       \
+				     ##__VA_ARGS__)
+
+#define KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      expected_true,				       \
+			      fmt,					       \
+			      ...)					       \
+		KUNIT_ASSERTION(test,					       \
+				!!(condition) == !!expected_true,	       \
+				kunit_unary_assert,			       \
+				KUNIT_INIT_UNARY_ASSERT_STRUCT(test,	       \
+							       assert_type,    \
+							       #condition,     \
+							       expected_true), \
+				fmt,					       \
+				##__VA_ARGS__)
+
+#define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
+		KUNIT_UNARY_ASSERTION(test,				       \
+				      assert_type,			       \
+				      condition,			       \
+				      true,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
+		KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+#define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
+		KUNIT_UNARY_ASSERTION(test,				       \
+				      assert_type,			       \
+				      condition,			       \
+				      false,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
+		KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+#define KUNIT_BINARY_CLASS \
+		kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
+#define KUNIT_BINARY_PTR_CLASS \
+		kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
+
+/*
+ * A factory macro for defining the assertions andexpectations for the basic
+ * comparisons defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpretted to figure out the actual
+ * value.
+ */
+#define KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    op,					       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			__left op __right,				       \
+			assert_class,					       \
+			ASSERT_CLASS_INIT(test,				       \
+					  assert_type,			       \
+					  #op,				       \
+					  #left,			       \
+					  __left,			       \
+					  #right,			       \
+					  __right),			       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_BINARY_ASSERTION(test, assert_type, left, op, right, fmt, ...)   \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    kunit_binary_assert,	       \
+					    KUNIT_INIT_BINARY_ASSERT_STRUCT,   \
+					    assert_type,		       \
+					    left,			       \
+					    op,				       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    ASSERT_CLASS,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    ASSERT_CLASS,		       \
+					    assert_type,		       \
+					    left, ==, right,		       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    ASSERT_CLASS,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    ASSERT_CLASS,		       \
+					    assert_type,		       \
+					    left, !=, right,		       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    ASSERT_CLASS,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    ASSERT_CLASS,		       \
+					    assert_type,		       \
+					    left, <, right,		       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    ASSERT_CLASS,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    ASSERT_CLASS,		       \
+					    assert_type,		       \
+					    left, <=, right,		       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    ASSERT_CLASS,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    ASSERT_CLASS,		       \
+					    assert_type,		       \
+					    left, >, right,		       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    ASSERT_CLASS,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+		KUNIT_BASE_BINARY_ASSERTION(test,			       \
+					    ASSERT_CLASS,		       \
+					    assert_type,		       \
+					    left, >=, right,		       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+		KUNIT_BASE_EQ_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_CLASS,		       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_EQ_MSG_ASSERTION(test,			       \
+					      assert_type,		       \
+					      left,			       \
+					      right,			       \
+					      NULL)
+
+#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BASE_EQ_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_PTR_CLASS,	       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+		KUNIT_BASE_NE_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_CLASS,		       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_NE_MSG_ASSERTION(test,			       \
+					      assert_type,		       \
+					      left,			       \
+					      right,			       \
+					      NULL)
+
+#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BASE_NE_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_PTR_CLASS,	       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+		KUNIT_BASE_LT_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_CLASS,		       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_LT_MSG_ASSERTION(test,			       \
+					      assert_type,		       \
+					      left,			       \
+					      right,			       \
+					      NULL)
+
+#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BASE_LT_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_PTR_CLASS,	       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+		KUNIT_BASE_LE_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_CLASS,		       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_LE_MSG_ASSERTION(test,			       \
+					      assert_type,		       \
+					      left,			       \
+					      right,			       \
+					      NULL)
+
+#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BASE_LE_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_PTR_CLASS,	       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+		KUNIT_BASE_GT_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_CLASS,		       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_GT_MSG_ASSERTION(test,			       \
+					      assert_type,		       \
+					      left,			       \
+					      right,			       \
+					      NULL)
+
+#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BASE_GT_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_PTR_CLASS,	       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+		KUNIT_BASE_GE_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_CLASS,		       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_GE_MSG_ASSERTION(test,			       \
+					      assert_type,		       \
+					      left,			       \
+					      right,			       \
+					      NULL)
+
+#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BASE_GE_MSG_ASSERTION(test,			       \
+					    KUNIT_BINARY_PTR_CLASS,	       \
+					    assert_type,		       \
+					    left,			       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
+				   ...)					       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			strcmp(__left, __right) op 0,			       \
+			kunit_binary_str_assert,			       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(test,		       \
+							assert_type,	       \
+							#op,		       \
+							#left,		       \
+							__left,		       \
+							#right,		       \
+							__right),	       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BINARY_STR_ASSERTION(test,			       \
+					   assert_type,			       \
+					   left, ==, right,		       \
+					   fmt,				       \
+					   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+		KUNIT_BINARY_STR_ASSERTION(test,			       \
+					   assert_type,			       \
+					   left, !=, right,		       \
+					   fmt,				       \
+					   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)	       \
+		KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,			       \
+						  assert_type,		       \
+						  left,			       \
+						  right,		       \
+						  NULL)
+
+#define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						assert_type,		       \
+						ptr,			       \
+						fmt,			       \
+						...)			       \
+do {									       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			!IS_ERR_OR_NULL(__ptr),				       \
+			kunit_ptr_not_err_assert,			       \
+			KUNIT_INIT_PTR_NOT_ERR_STRUCT(test,		       \
+						      assert_type,	       \
+						      #ptr,		       \
+						      __ptr),		       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
+		KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,		       \
+							assert_type,	       \
+							ptr,		       \
+							NULL)
+
+/**
+ * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to true.
+ *
+ * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
+ * to fail when the specified condition is not met; however, it will not prevent
+ * the test case from continuing to run; this is otherwise known as an
+ * *expectation failure*.
+ */
+#define KUNIT_EXPECT_TRUE(test, condition) \
+		KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_TRUE_MSG_ASSERTION(test,				       \
+					 KUNIT_EXPECTATION,		       \
+					 condition,			       \
+					 fmt,				       \
+					 ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to false.
+ *
+ * Sets an expectation that @condition evaluates to false. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_FALSE(test, condition) \
+		KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_FALSE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  condition,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_EQ(test, left, right) \
+		KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_EQ_MSG_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
+		KUNIT_BINARY_PTR_EQ_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right)
+
+#define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,			       \
+						  KUNIT_EXPECTATION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NE(test, left, right) \
+		KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_NE_MSG_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
+		KUNIT_BINARY_PTR_NE_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right)
+
+#define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,			       \
+						  KUNIT_EXPECTATION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LT(test, left, right) \
+		KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_LT_MSG_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. Semantically this is equivalent
+ * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LE(test, left, right) \
+		KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_LE_MSG_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GT(test, left, right) \
+		KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_GT_MSG_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GE(test, left, right) \
+		KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_GE_MSG_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STREQ(test, left, right)				       \
+		KUNIT_BINARY_STR_EQ_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right)
+
+#define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,			       \
+						  KUNIT_EXPECTATION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STRNEQ(test, left, right)				       \
+		KUNIT_BINARY_STR_NE_ASSERTION(test,			       \
+					      KUNIT_EXPECTATION,	       \
+					      left,			       \
+					      right)
+
+#define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,			       \
+						  KUNIT_EXPECTATION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr)				       \
+		KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test,		       \
+						    KUNIT_EXPECTATION,	       \
+						    ptr)
+
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+		KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,		       \
+							KUNIT_EXPECTATION,     \
+							ptr,		       \
+							fmt,		       \
+							##__VA_ARGS__)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kunit/test.c b/kunit/test.c
index 4c178a817f2fe..e5080a2c6b29c 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -120,6 +120,64 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 			      test_case->name);
 }
 
+static void kunit_print_string_stream(struct kunit *test,
+				      struct string_stream *stream)
+{
+	struct string_stream_fragment *fragment;
+	char *buf;
+
+	buf = string_stream_get_string(stream);
+	if (!buf) {
+		kunit_err(test,
+			  "Could not allocate buffer, dumping stream:\n");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			kunit_err(test, fragment->fragment);
+		}
+		kunit_err(test, "\n");
+	} else {
+		kunit_err(test, buf);
+	}
+}
+
+static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
+{
+	struct string_stream *stream;
+
+	kunit_set_failure(test);
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	if (!stream) {
+		warn_slowpath_fmt(assert->file,
+				  assert->line,
+				  "Could not allocate stream to print failed assertion.\n");
+		return;
+	}
+
+	assert->format(assert, stream);
+
+	kunit_print_string_stream(test, stream);
+}
+
+void kunit_do_assertion(struct kunit *test,
+			struct kunit_assert *assert,
+			bool pass,
+			const char *fmt, ...)
+{
+	va_list args;
+
+	if (pass)
+		return;
+
+	va_start(args, fmt);
+
+	assert->message.fmt = fmt;
+	assert->message.va = &args;
+
+	kunit_fail(test, assert);
+
+	va_end(args);
+}
+
 void kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
-- 
2.23.0.rc1.153.gdeed80330f-goog

