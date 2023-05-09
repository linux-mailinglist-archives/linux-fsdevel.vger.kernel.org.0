Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7806FCC3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjEIRBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjEIRAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 13:00:09 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228FC6EB5
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:58:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3IAVGyB/8A3XrcmgOov/HZ/oVTBD4Irg0eSJUzhLg0=;
        b=Hk+jz+6u/vONyMe0EiexHJsx9U/I3cL9tyjBDqO+gXS9IdFRbCNXBolMrC5tfKj+zoQzGF
        Jnb0bwuPUOc4kTRGI33xo/pfeKYkK8QKHshuWvDs1jt2rEdNnnJAwocuqTkcdrREcX+0Dl
        WpTR0b54NqG/KaC1kLnIEnZn6C6GJNI=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Daniel Hill <daniel@gluo.nz>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 31/32] lib: add mean and variance module.
Date:   Tue,  9 May 2023 12:56:56 -0400
Message-Id: <20230509165657.1735798-32-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniel Hill <daniel@gluo.nz>

This module provides a fast 64bit implementation of basic statistics
functions, including mean, variance and standard deviation in both
weighted and unweighted variants, the unweighted variant has a 32bit
limitation per sample to prevent overflow when squaring.

Signed-off-by: Daniel Hill <daniel@gluo.nz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 MAINTAINERS                       |   9 ++
 include/linux/mean_and_variance.h | 219 ++++++++++++++++++++++++++++++
 lib/Kconfig.debug                 |   9 ++
 lib/math/Kconfig                  |   3 +
 lib/math/Makefile                 |   2 +
 lib/math/mean_and_variance.c      | 136 +++++++++++++++++++
 lib/math/mean_and_variance_test.c | 155 +++++++++++++++++++++
 7 files changed, 533 insertions(+)
 create mode 100644 include/linux/mean_and_variance.h
 create mode 100644 lib/math/mean_and_variance.c
 create mode 100644 lib/math/mean_and_variance_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c550f5909e..dbf3c33c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12767,6 +12767,15 @@ F:	Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
 F:	drivers/net/ieee802154/mcr20a.c
 F:	drivers/net/ieee802154/mcr20a.h
 
+MEAN AND VARIANCE LIBRARY
+M:	Daniel B. Hill <daniel@gluo.nz>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+T:	git https://github.com/YellowOnion/linux/
+F:	include/linux/mean_and_variance.h
+F:	lib/math/mean_and_variance.c
+F:	lib/math/mean_and_variance_test.c
+
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
diff --git a/include/linux/mean_and_variance.h b/include/linux/mean_and_variance.h
new file mode 100644
index 0000000000..89540628e8
--- /dev/null
+++ b/include/linux/mean_and_variance.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MEAN_AND_VARIANCE_H_
+#define MEAN_AND_VARIANCE_H_
+
+#include <linux/types.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
+
+#define SQRT_U64_MAX 4294967295ULL
+
+
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
+
+typedef unsigned __int128 u128;
+
+static inline u128 u64_to_u128(u64 a)
+{
+	return (u128)a;
+}
+
+static inline u64 u128_to_u64(u128 a)
+{
+	return (u64)a;
+}
+
+static inline u64 u128_shr64_to_u64(u128 a)
+{
+	return (u64)(a >> 64);
+}
+
+static inline u128 u128_add(u128 a, u128 b)
+{
+	return a + b;
+}
+
+static inline u128 u128_sub(u128 a, u128 b)
+{
+	return a - b;
+}
+
+static inline u128 u128_shl(u128 i, s8 shift)
+{
+	return i << shift;
+}
+
+static inline u128 u128_shl64_add(u64 a, u64 b)
+{
+	return ((u128)a << 64) + b;
+}
+
+static inline u128 u128_square(u64 i)
+{
+	return i*i;
+}
+
+#else
+
+typedef struct {
+	u64 hi, lo;
+} u128;
+
+static inline u128 u64_to_u128(u64 a)
+{
+	return (u128){ .lo = a };
+}
+
+static inline u64 u128_to_u64(u128 a)
+{
+	return a.lo;
+}
+
+static inline u64 u128_shr64_to_u64(u128 a)
+{
+	return a.hi;
+}
+
+static inline u128 u128_add(u128 a, u128 b)
+{
+	u128 c;
+
+	c.lo = a.lo + b.lo;
+	c.hi = a.hi + b.hi + (c.lo < a.lo);
+	return c;
+}
+
+static inline u128 u128_sub(u128 a, u128 b)
+{
+	u128 c;
+
+	c.lo = a.lo - b.lo;
+	c.hi = a.hi - b.hi - (c.lo > a.lo);
+	return c;
+}
+
+static inline u128 u128_shl(u128 i, s8 shift)
+{
+	u128 r;
+
+	r.lo = i.lo << shift;
+	if (shift < 64)
+		r.hi = (i.hi << shift) | (i.lo >> (64 - shift));
+	else {
+		r.hi = i.lo << (shift - 64);
+		r.lo = 0;
+	}
+	return r;
+}
+
+static inline u128 u128_shl64_add(u64 a, u64 b)
+{
+	return u128_add(u128_shl(u64_to_u128(a), 64), u64_to_u128(b));
+}
+
+static inline u128 u128_square(u64 i)
+{
+	u128 r;
+	u64  h = i >> 32, l = i & (u64)U32_MAX;
+
+	r =             u128_shl(u64_to_u128(h*h), 64);
+	r = u128_add(r, u128_shl(u64_to_u128(h*l), 32));
+	r = u128_add(r, u128_shl(u64_to_u128(l*h), 32));
+	r = u128_add(r,          u64_to_u128(l*l));
+	return r;
+}
+
+#endif
+
+static inline u128 u128_div(u128 n, u64 d)
+{
+	u128 r;
+	u64 rem;
+	u64 hi = u128_shr64_to_u64(n);
+	u64 lo = u128_to_u64(n);
+	u64  h =  hi & ((u64)U32_MAX  << 32);
+	u64  l = (hi &  (u64)U32_MAX) << 32;
+
+	r =             u128_shl(u64_to_u128(div64_u64_rem(h,                d, &rem)), 64);
+	r = u128_add(r, u128_shl(u64_to_u128(div64_u64_rem(l  + (rem << 32), d, &rem)), 32));
+	r = u128_add(r,          u64_to_u128(div64_u64_rem(lo + (rem << 32), d, &rem)));
+	return r;
+}
+
+struct mean_and_variance {
+	s64 n;
+	s64 sum;
+	u128 sum_squares;
+};
+
+/* expontentially weighted variant */
+struct mean_and_variance_weighted {
+	bool init;
+	u8 w;
+	s64 mean;
+	u64 variance;
+};
+
+/**
+ * fast_divpow2() - fast approximation for n / (1 << d)
+ * @n: numerator
+ * @d: the power of 2 denominator.
+ *
+ * note: this rounds towards 0.
+ */
+static inline s64 fast_divpow2(s64 n, u8 d)
+{
+	return (n + ((n < 0) ? ((1 << d) - 1) : 0)) >> d;
+}
+
+static inline struct mean_and_variance
+mean_and_variance_update_inlined(struct mean_and_variance s1, s64 v1)
+{
+	struct mean_and_variance s2;
+	u64 v2 = abs(v1);
+
+	s2.n           = s1.n + 1;
+	s2.sum         = s1.sum + v1;
+	s2.sum_squares = u128_add(s1.sum_squares, u128_square(v2));
+	return s2;
+}
+
+static inline struct mean_and_variance_weighted
+mean_and_variance_weighted_update_inlined(struct mean_and_variance_weighted s1, s64 x)
+{
+	struct mean_and_variance_weighted s2;
+	// previous weighted variance.
+	u64 var_w0 = s1.variance;
+	u8 w = s2.w = s1.w;
+	// new value weighted.
+	s64 x_w = x << w;
+	s64 diff_w = x_w - s1.mean;
+	s64 diff = fast_divpow2(diff_w, w);
+	// new mean weighted.
+	s64 u_w1     = s1.mean + diff;
+
+	BUG_ON(w % 2 != 0);
+
+	if (!s1.init) {
+		s2.mean = x_w;
+		s2.variance = 0;
+	} else {
+		s2.mean = u_w1;
+		s2.variance = ((var_w0 << w) - var_w0 + ((diff_w * (x_w - u_w1)) >> w)) >> w;
+	}
+	s2.init = true;
+
+	return s2;
+}
+
+struct mean_and_variance mean_and_variance_update(struct mean_and_variance s1, s64 v1);
+       s64		 mean_and_variance_get_mean(struct mean_and_variance s);
+       u64		 mean_and_variance_get_variance(struct mean_and_variance s1);
+       u32		 mean_and_variance_get_stddev(struct mean_and_variance s);
+
+struct mean_and_variance_weighted mean_and_variance_weighted_update(struct mean_and_variance_weighted s1, s64 v1);
+       s64			  mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s);
+       u64			  mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s);
+       u32			  mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s);
+
+#endif // MEAN_AND_VAIRANCE_H_
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3dba7a9aff..9ca88e0027 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2101,6 +2101,15 @@ config CPUMASK_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MEAN_AND_VARIANCE_UNIT_TEST
+	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select MEAN_AND_VARIANCE
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the kunit tests for mean_and_variance module.
+	  If unsure, say N.
+
 config TEST_LIST_SORT
 	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index 0634b428d0..7530ae9a35 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -15,3 +15,6 @@ config PRIME_NUMBERS
 
 config RATIONAL
 	tristate
+
+config MEAN_AND_VARIANCE
+	tristate
diff --git a/lib/math/Makefile b/lib/math/Makefile
index bfac26ddfc..2ef1487e01 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -4,6 +4,8 @@ obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
+obj-$(CONFIG_MEAN_AND_VARIANCE) += mean_and_variance.o
 
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
diff --git a/lib/math/mean_and_variance.c b/lib/math/mean_and_variance.c
new file mode 100644
index 0000000000..6e315d3a13
--- /dev/null
+++ b/lib/math/mean_and_variance.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions for incremental mean and variance.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * Copyright © 2022 Daniel B. Hill
+ *
+ * Author: Daniel B. Hill <daniel@gluo.nz>
+ *
+ * Description:
+ *
+ * This is includes some incremental algorithms for mean and variance calculation
+ *
+ * Derived from the paper: https://fanf2.user.srcf.net/hermes/doc/antiforgery/stats.pdf
+ *
+ * Create a struct and if it's the weighted variant set the w field (weight = 2^k).
+ *
+ * Use mean_and_variance[_weighted]_update() on the struct to update it's state.
+ *
+ * Use the mean_and_variance[_weighted]_get_* functions to calculate the mean and variance, some computation
+ * is deferred to these functions for performance reasons.
+ *
+ * see lib/math/mean_and_variance_test.c for examples of usage.
+ *
+ * DO NOT access the mean and variance fields of the weighted variants directly.
+ * DO NOT change the weight after calling update.
+ */
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/export.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/mean_and_variance.h>
+#include <linux/module.h>
+
+/**
+ * mean_and_variance_update() - update a mean_and_variance struct @s1 with a new sample @v1
+ * and return it.
+ * @s1: the mean_and_variance to update.
+ * @v1: the new sample.
+ *
+ * see linked pdf equation 12.
+ */
+struct mean_and_variance mean_and_variance_update(struct mean_and_variance s1, s64 v1)
+{
+	return mean_and_variance_update_inlined(s1, v1);
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_update);
+
+/**
+ * mean_and_variance_get_mean() - get mean from @s
+ */
+s64 mean_and_variance_get_mean(struct mean_and_variance s)
+{
+	return div64_u64(s.sum, s.n);
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_get_mean);
+
+/**
+ * mean_and_variance_get_variance() -  get variance from @s1
+ *
+ * see linked pdf equation 12.
+ */
+u64 mean_and_variance_get_variance(struct mean_and_variance s1)
+{
+	u128 s2 = u128_div(s1.sum_squares, s1.n);
+	u64  s3 = abs(mean_and_variance_get_mean(s1));
+
+	return u128_to_u64(u128_sub(s2, u128_square(s3)));
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_get_variance);
+
+/**
+ * mean_and_variance_get_stddev() - get standard deviation from @s
+ */
+u32 mean_and_variance_get_stddev(struct mean_and_variance s)
+{
+	return int_sqrt64(mean_and_variance_get_variance(s));
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_get_stddev);
+
+/**
+ * mean_and_variance_weighted_update() - exponentially weighted variant of mean_and_variance_update()
+ * @s1: ..
+ * @s2: ..
+ *
+ * see linked pdf: function derived from equations 140-143 where alpha = 2^w.
+ * values are stored bitshifted for performance and added precision.
+ */
+struct mean_and_variance_weighted mean_and_variance_weighted_update(struct mean_and_variance_weighted s1,
+								    s64 x)
+{
+	return mean_and_variance_weighted_update_inlined(s1, x);
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_weighted_update);
+
+/**
+ * mean_and_variance_weighted_get_mean() - get mean from @s
+ */
+s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s)
+{
+	return fast_divpow2(s.mean, s.w);
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_mean);
+
+/**
+ * mean_and_variance_weighted_get_variance() -- get variance from @s
+ */
+u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s)
+{
+	// always positive don't need fast divpow2
+	return s.variance >> s.w;
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_variance);
+
+/**
+ * mean_and_variance_weighted_get_stddev() - get standard deviation from @s
+ */
+u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s)
+{
+	return int_sqrt64(mean_and_variance_weighted_get_variance(s));
+}
+EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_stddev);
+
+MODULE_AUTHOR("Daniel B. Hill");
+MODULE_LICENSE("GPL");
diff --git a/lib/math/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
new file mode 100644
index 0000000000..79a96d7307
--- /dev/null
+++ b/lib/math/mean_and_variance_test.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/mean_and_variance.h>
+
+#define MAX_SQR (SQRT_U64_MAX*SQRT_U64_MAX)
+
+static void mean_and_variance_basic_test(struct kunit *test)
+{
+	struct mean_and_variance s = {};
+
+	s = mean_and_variance_update(s, 2);
+	s = mean_and_variance_update(s, 2);
+
+	KUNIT_EXPECT_EQ(test, mean_and_variance_get_mean(s), 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_get_variance(s), 0);
+	KUNIT_EXPECT_EQ(test, s.n, 2);
+
+	s = mean_and_variance_update(s, 4);
+	s = mean_and_variance_update(s, 4);
+
+	KUNIT_EXPECT_EQ(test, mean_and_variance_get_mean(s), 3);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_get_variance(s), 1);
+	KUNIT_EXPECT_EQ(test, s.n, 4);
+}
+
+/*
+ * Test values computed using a spreadsheet from the psuedocode at the bottom:
+ * https://fanf2.user.srcf.net/hermes/doc/antiforgery/stats.pdf
+ */
+
+static void mean_and_variance_weighted_test(struct kunit *test)
+{
+	struct mean_and_variance_weighted s = {};
+
+	s.w = 2;
+
+	s = mean_and_variance_weighted_update(s, 10);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 10);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 0);
+
+	s = mean_and_variance_weighted_update(s, 20);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 12);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 18);
+
+	s = mean_and_variance_weighted_update(s, 30);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 16);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 72);
+
+	s = (struct mean_and_variance_weighted){};
+	s.w = 2;
+
+	s = mean_and_variance_weighted_update(s, -10);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -10);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 0);
+
+	s = mean_and_variance_weighted_update(s, -20);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -12);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 18);
+
+	s = mean_and_variance_weighted_update(s, -30);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -16);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 72);
+
+}
+
+static void mean_and_variance_weighted_advanced_test(struct kunit *test)
+{
+	struct mean_and_variance_weighted s = {};
+	s64 i;
+
+	s.w = 8;
+	for (i = 10; i <= 100; i += 10)
+		s = mean_and_variance_weighted_update(s, i);
+
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 11);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 107);
+
+	s = (struct mean_and_variance_weighted){};
+
+	s.w = 8;
+	for (i = -10; i >= -100; i -= 10)
+		s = mean_and_variance_weighted_update(s, i);
+
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -11);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 107);
+
+}
+
+static void mean_and_variance_fast_divpow2(struct kunit *test)
+{
+	s64 i;
+	u8 d;
+
+	for (i = 0; i < 100; i++) {
+		d = 0;
+		KUNIT_EXPECT_EQ(test, fast_divpow2(i, d), div_u64(i, 1LLU << d));
+		KUNIT_EXPECT_EQ(test, abs(fast_divpow2(-i, d)), div_u64(i, 1LLU << d));
+		for (d = 1; d < 32; d++) {
+			KUNIT_EXPECT_EQ_MSG(test, abs(fast_divpow2(i, d)),
+					    div_u64(i, 1 << d), "%lld %u", i, d);
+			KUNIT_EXPECT_EQ_MSG(test, abs(fast_divpow2(-i, d)),
+					    div_u64(i, 1 << d), "%lld %u", -i, d);
+		}
+	}
+}
+
+static void mean_and_variance_u128_basic_test(struct kunit *test)
+{
+	u128 a = u128_shl64_add(0, U64_MAX);
+	u128 a1 = u128_shl64_add(0, 1);
+	u128 b = u128_shl64_add(1, 0);
+	u128 c = u128_shl64_add(0, 1LLU << 63);
+	u128 c2 = u128_shl64_add(U64_MAX, U64_MAX);
+
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_add(a, a1)), 1);
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_add(a, a1)), 0);
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_add(a1, a)), 1);
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_add(a1, a)), 0);
+
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_sub(b, a1)), U64_MAX);
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_sub(b, a1)), 0);
+
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_shl(c, 1)), 1);
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_shl(c, 1)), 0);
+
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_square(U64_MAX)), U64_MAX - 1);
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_square(U64_MAX)), 1);
+
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_div(b, 2)), 1LLU << 63);
+
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_div(c2, 2)), U64_MAX >> 1);
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_div(c2, 2)), U64_MAX);
+
+	KUNIT_EXPECT_EQ(test, u128_shr64_to_u64(u128_div(u128_shl(u64_to_u128(U64_MAX), 32), 2)), U32_MAX >> 1);
+	KUNIT_EXPECT_EQ(test, u128_to_u64(u128_div(u128_shl(u64_to_u128(U64_MAX), 32), 2)), U64_MAX << 31);
+}
+
+static struct kunit_case mean_and_variance_test_cases[] = {
+	KUNIT_CASE(mean_and_variance_fast_divpow2),
+	KUNIT_CASE(mean_and_variance_u128_basic_test),
+	KUNIT_CASE(mean_and_variance_basic_test),
+	KUNIT_CASE(mean_and_variance_weighted_test),
+	KUNIT_CASE(mean_and_variance_weighted_advanced_test),
+	{}
+};
+
+static struct kunit_suite mean_and_variance_test_suite = {
+.name = "mean and variance tests",
+.test_cases = mean_and_variance_test_cases
+};
+
+kunit_test_suite(mean_and_variance_test_suite);
+
+MODULE_AUTHOR("Daniel B. Hill");
+MODULE_LICENSE("GPL");
-- 
2.40.1

