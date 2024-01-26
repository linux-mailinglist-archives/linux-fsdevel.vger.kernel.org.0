Return-Path: <linux-fsdevel+bounces-9116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734783E4B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9891C2336F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB5447F43;
	Fri, 26 Jan 2024 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FTHZZY7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439C3EA86;
	Fri, 26 Jan 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306826; cv=none; b=CqopL3Jw5feMdFU/99Fu9JAmEDPl39iSFVxEONJh+8ug9z/pcJuRREjKKyHtHeVK8GjC2OMxQx+eUUcrcrgJqHHfmTBq68QTpjdbZbm/Ju9/PBh37cWRjOl6qDkw5qby9h+jK3JmhP0yb25fF0PCMJ/DzCJNhWQEz9+61ssEEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306826; c=relaxed/simple;
	bh=XB4fRjTtTylKsY7YTWjFycmOakQ+8VZzbUngR9Y7Qlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2Q+w4uRLrYQBPxbqQWD+7DpdG6d8vX1irwBpdT3IDRDLnT6Oqc52v3YdyruSHdVt1okkov6YKRosE7M2oTA8M2+ao1W7irnGKX3W4LApamFV6K9pTzIg7ta4EmXr4Fz3AjnbIRcbpllk3mDxcr5GxNs8tZqz4q6NraryJ+0bOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FTHZZY7n; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706306822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0uDCQI2J2OdCX4BmaIuAGyUG1leeUjTKY0gYVjTj18U=;
	b=FTHZZY7nMvcAvxX6xS1FLXGkx0hsfKKwXyDXmPmqGDw7kVxMvOHTtXUUdrlLbydUYjkuhm
	Uil/VEkNUoYYyJkVZfAGojNEY5KD0/t+NYanXQde+kvUBrUdmc3/QPQiSLCi6Vc2xFe2E8
	y+wyuRqqhiOi81sWmkl7FYrCiJZK1dc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Daniel Hill <daniel@gluo.nz>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 1/5] mean and variance: Promote to lib/math
Date: Fri, 26 Jan 2024 17:06:51 -0500
Message-ID: <20240126220655.395093-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Small statistics library, for taking in a series of value and computing
mean, weighted mean, standard deviation and weighted deviation.

The main use case is for statistics on latency measurements.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Daniel Hill <daniel@gluo.nz>
Cc: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                                        |  9 +++++++++
 fs/bcachefs/Kconfig                                | 10 +---------
 fs/bcachefs/Makefile                               |  3 ---
 fs/bcachefs/util.c                                 |  2 +-
 fs/bcachefs/util.h                                 |  3 +--
 {fs/bcachefs => include/linux}/mean_and_variance.h |  0
 lib/Kconfig.debug                                  |  9 +++++++++
 lib/math/Kconfig                                   |  3 +++
 lib/math/Makefile                                  |  2 ++
 {fs/bcachefs => lib/math}/mean_and_variance.c      |  3 +--
 {fs/bcachefs => lib/math}/mean_and_variance_test.c |  3 +--
 11 files changed, 28 insertions(+), 19 deletions(-)
 rename {fs/bcachefs => include/linux}/mean_and_variance.h (100%)
 rename {fs/bcachefs => lib/math}/mean_and_variance.c (99%)
 rename {fs/bcachefs => lib/math}/mean_and_variance_test.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..de635cfd354d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13379,6 +13379,15 @@ S:	Maintained
 F:	drivers/net/mdio/mdio-regmap.c
 F:	include/linux/mdio/mdio-regmap.h
 
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
diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index 5cdfef3b551a..72d1179262b3 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -24,6 +24,7 @@ config BCACHEFS_FS
 	select XXHASH
 	select SRCU
 	select SYMBOLIC_ERRNAME
+	select MEAN_AND_VARIANCE
 	help
 	The bcachefs filesystem - a modern, copy on write filesystem, with
 	support for multiple devices, compression, checksumming, etc.
@@ -86,12 +87,3 @@ config BCACHEFS_SIX_OPTIMISTIC_SPIN
 	Instead of immediately sleeping when attempting to take a six lock that
 	is held by another thread, spin for a short while, as long as the
 	thread owning the lock is running.
-
-config MEAN_AND_VARIANCE_UNIT_TEST
-	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	depends on BCACHEFS_FS
-	default KUNIT_ALL_TESTS
-	help
-	  This option enables the kunit tests for mean_and_variance module.
-	  If unsure, say N.
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 1a05cecda7cc..b11ba74b8ad4 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -57,7 +57,6 @@ bcachefs-y		:=	\
 	keylist.o		\
 	logged_ops.o		\
 	lru.o			\
-	mean_and_variance.o	\
 	migrate.o		\
 	move.o			\
 	movinggc.o		\
@@ -88,5 +87,3 @@ bcachefs-y		:=	\
 	util.o			\
 	varint.o		\
 	xattr.o
-
-obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 56b815fd9fc6..d7ea95abb9df 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -22,9 +22,9 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/sched/clock.h>
+#include <linux/mean_and_variance.h>
 
 #include "eytzinger.h"
-#include "mean_and_variance.h"
 #include "util.h"
 
 static const char si_units[] = "?kMGTPEZY";
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index b414736d59a5..0059481995ef 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -17,8 +17,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
-
-#include "mean_and_variance.h"
+#include <linux/mean_and_variance.h>
 
 #include "darray.h"
 
diff --git a/fs/bcachefs/mean_and_variance.h b/include/linux/mean_and_variance.h
similarity index 100%
rename from fs/bcachefs/mean_and_variance.h
rename to include/linux/mean_and_variance.h
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..817ddfe132cd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2191,6 +2191,15 @@ config CPUMASK_KUNIT_TEST
 
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
index 0634b428d0cb..7530ae9a3584 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -15,3 +15,6 @@ config PRIME_NUMBERS
 
 config RATIONAL
 	tristate
+
+config MEAN_AND_VARIANCE
+	tristate
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 91fcdb0c9efe..8cdfa13a67ce 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -4,6 +4,8 @@ obj-y += div64.o gcd.o lcm.o int_log.o int_pow.o int_sqrt.o reciprocal_div.o
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
+obj-$(CONFIG_MEAN_AND_VARIANCE) += mean_and_variance.o
 
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
diff --git a/fs/bcachefs/mean_and_variance.c b/lib/math/mean_and_variance.c
similarity index 99%
rename from fs/bcachefs/mean_and_variance.c
rename to lib/math/mean_and_variance.c
index bf0ef668fd38..ba90293204ba 100644
--- a/fs/bcachefs/mean_and_variance.c
+++ b/lib/math/mean_and_variance.c
@@ -40,10 +40,9 @@
 #include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/math64.h>
+#include <linux/mean_and_variance.h>
 #include <linux/module.h>
 
-#include "mean_and_variance.h"
-
 u128_u u128_div(u128_u n, u64 d)
 {
 	u128_u r;
diff --git a/fs/bcachefs/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
similarity index 99%
rename from fs/bcachefs/mean_and_variance_test.c
rename to lib/math/mean_and_variance_test.c
index 019583c3ca0e..f45591a169d8 100644
--- a/fs/bcachefs/mean_and_variance_test.c
+++ b/lib/math/mean_and_variance_test.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <kunit/test.h>
-
-#include "mean_and_variance.h"
+#include <linux/mean_and_variance.h>
 
 #define MAX_SQR (SQRT_U64_MAX*SQRT_U64_MAX)
 
-- 
2.43.0


