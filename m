Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4BBB0B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438763AbfIWJDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 05:03:12 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53216 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438727AbfIWJDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:03:11 -0400
Received: by mail-pg1-f201.google.com with SMTP id e15so8905999pgh.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2019 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/bZoZEZVz8wX45GPttRV01z+eGnuFCzZ/9DmK4u44kE=;
        b=XkE4R6jH3zqyaDI0w8AV8twxFkk2AGWljHeRCmzAWk2EF4R+x4iPWyO//TnLmzeB8O
         utN/KUgEB8R6xAvopYSBk+vqa7ua4EZ9bborMbNBeEhrFi/b1Vd3JGeWgy5f6jZFZrch
         5apW73afMzdrMDLcqoxe7rkqBNwjJr+c+w6q7Qxj+5T6c9XOKnVHiAiNDopYaFxY09gk
         98wg1v9BYVZQ4QET0AybH5u+4CTbMccnZ+EXVpMkuxY3/+gyOAIsciPJ5sayJe95nbj+
         nSjuvqWhQMt97xMoIj3G0/MTYeiWde2ymMtd7NtDLph7sFMPqASc5HSoqDukbwgxsowL
         V2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/bZoZEZVz8wX45GPttRV01z+eGnuFCzZ/9DmK4u44kE=;
        b=siTMzT1KKNGFsUMNTGjSu9mA9+2X5NFTQxFAaQ+LWVs7SKdHdbelHV717oe2cSl4N1
         KSYn+Lc3ssZAgcY4Whym9q95pq4BZUcgTAAXNPxDEbcYWCkU3pJaLDhdQTSPAwxmWcMB
         GCAc65Wie+P23QLE5bsxQmdNS4GTSK5xrruNBaJH+HRhZvqBdyVGZyjI3HlpO6s9fcbU
         +I4yn8dgETsY3LWVb7RGh5SXvw+lO57J/G4KnCkOGkLivyhe88qq2OtdYo8DXEvgY7rY
         ZQr12p3y9nWSg327ma0AC5Jfbp5Ok85eKyi5RHl0G+jfHBMwmLmi4F7jF2r8rofA8Bbu
         P6hw==
X-Gm-Message-State: APjAAAVjTfM8LohxHTaot3MI4K797YqqpJrrLC9gNuRFUbaPUrfb9BnV
        LKqEcUrJ6ci/4RkExADRFznd67+KvWu7bTnBOhNupQ==
X-Google-Smtp-Source: APXvYqyqr04gzw4TcvWXqmikkhYCIHqhxPoxuIntX9SPwdWKsRzoq/cNdrwWXQRYTIcxQ4hI5dlhQECof/26Dvkh8IFKSw==
X-Received: by 2002:a63:1720:: with SMTP id x32mr28130781pgl.289.1569229388640;
 Mon, 23 Sep 2019 02:03:08 -0700 (PDT)
Date:   Mon, 23 Sep 2019 02:02:35 -0700
In-Reply-To: <20190923090249.127984-1-brendanhiggins@google.com>
Message-Id: <20190923090249.127984-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 05/19] kunit: test: add the concept of expectations
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

Add support for expectations, which allow properties to be specified and
then verified in tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 836 +++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     |  62 ++++
 2 files changed, 898 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 6781c756f11b..30a62de16bc9 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -9,6 +9,8 @@
 #ifndef _KUNIT_TEST_H
 #define _KUNIT_TEST_H
 
+#include <kunit/assert.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -372,4 +374,838 @@ void __printf(3, 4) kunit_printk(const char *level,
 #define kunit_err(test, fmt, ...) \
 	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
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
+	KUNIT_ASSERTION(test,						       \
+			false,						       \
+			kunit_fail_assert,				       \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
+			fmt,						       \
+			##__VA_ARGS__)
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
+	KUNIT_FAIL_ASSERTION(test,					       \
+			     KUNIT_EXPECTATION,				       \
+			     fmt,					       \
+			     ##__VA_ARGS__)
+
+#define KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      expected_true,				       \
+			      fmt,					       \
+			      ...)					       \
+	KUNIT_ASSERTION(test,						       \
+			!!(condition) == !!expected_true,		       \
+			kunit_unary_assert,				       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(test,		       \
+						       assert_type,	       \
+						       #condition,	       \
+						       expected_true),	       \
+			fmt,						       \
+			##__VA_ARGS__)
+
+#define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
+	KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      true,					       \
+			      fmt,					       \
+			      ##__VA_ARGS__)
+
+#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
+	KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+#define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
+	KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      false,					       \
+			      fmt,					       \
+			      ##__VA_ARGS__)
+
+#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
+	KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+/*
+ * A factory macro for defining the assertions and expectations for the basic
+ * comparisons defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpreted to figure out the actual
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
+	((void)__typecheck(__left, __right));				       \
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
+#define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, ==, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, !=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, <, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, <=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, >, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, >=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
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
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
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
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						assert_type,		       \
+						ptr,			       \
+						NULL)
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
+	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_TRUE_MSG_ASSERTION(test,					       \
+				 KUNIT_EXPECTATION,			       \
+				 condition,				       \
+				 fmt,					       \
+				 ##__VA_ARGS__)
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
+	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_FALSE_MSG_ASSERTION(test,					       \
+				  KUNIT_EXPECTATION,			       \
+				  condition,				       \
+				  fmt,					       \
+				  ##__VA_ARGS__)
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
+	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right)
+
+#define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right)
+
+#define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+#define KUNIT_EXPECT_STREQ(test, left, right) \
+	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+#define KUNIT_EXPECT_STRNEQ(test, left, right) \
+	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
+	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
+
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						KUNIT_EXPECTATION,	       \
+						ptr,			       \
+						fmt,			       \
+						##__VA_ARGS__)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 68b1037ab74d..3cbceb34b3b3 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -120,6 +120,68 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
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
+		kunit_kfree(test, buf);
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
+		WARN(true,
+		     "Could not allocate stream to print failed assertion in %s:%d\n",
+		     assert->file,
+		     assert->line);
+		return;
+	}
+
+	assert->format(assert, stream);
+
+	kunit_print_string_stream(test, stream);
+
+	WARN_ON(string_stream_destroy(stream));
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
2.23.0.351.gc4317032e6-goog

