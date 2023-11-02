Return-Path: <linux-fsdevel+bounces-1844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F767DF68E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9822811F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92D1CF94;
	Thu,  2 Nov 2023 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2fUg4Go"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AF1CF98
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:35:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884A199
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698939329; x=1730475329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HheBhNlmTXpT3TgvoMvzQA0KlR4bM5JG7hAfjNjhNOM=;
  b=P2fUg4GoGJsT5tK3isQJRWCc3zLne6Z7HmUGTN8a1Hh68rmssjRyFZ8U
   FUIsyxhuEdWuYmllwMSvQMIRQDyT1EdJEkpn6TuVHDnx8BvNF9uaunexa
   zTOVcFb23pvYwFJ9voYWurt5S8u9P+bcqOwCxfYlxIr+NxoIdKn0dO4Da
   sspK774oRXtfEXI6OgAObYz18X+1VnEEupJfED1LtSipbeSDnWmCgb3dS
   tlajQa5qC/8JkM98jGTRM7mylTx2oHAoRvnSyGU3q/VMGIV5XEkvNii6k
   gc249yEL/ga/NDYWixCmtup+3uuGRGp6lu9QcRwi5wv3fnbHq9Ru8NoYv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419848045"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="419848045"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="9042494"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:28 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/3] ida: Add kunit based tests for new IDA functions
Date: Thu,  2 Nov 2023 16:34:55 +0100
Message-Id: <20231102153455.1252-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231102153455.1252-1-michal.wajdeczko@intel.com>
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New functionality of the IDA (contiguous IDs allocations) requires
some validation coverage.  Add KUnit tests for simple scenarios:
 - counting single ID at different locations
 - counting different sets of IDs
 - ID allocation start at requested position
 - different contiguous ID allocations are supported

More advanced tests for subtle corner cases may come later.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 lib/Kconfig.debug |  12 ++++
 lib/Makefile      |   1 +
 lib/ida_kunit.c   | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 lib/ida_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fbc89baf7de6..818e788bc359 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2777,6 +2777,18 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config IDA_KUNIT_TEST
+	tristate "Kunit tests for IDA functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the kernel's IDA functions.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 42d307ade225..451dbb373da7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -396,6 +396,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_IDA_KUNIT_TEST) += ida_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/ida_kunit.c b/lib/ida_kunit.c
new file mode 100644
index 000000000000..01dc82c189f9
--- /dev/null
+++ b/lib/ida_kunit.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for IDA functions.
+ */
+
+#include <linux/idr.h>
+#include <kunit/test.h>
+
+#define IDA_STRESS_LIMIT (IDA_BITMAP_BITS * XA_CHUNK_SIZE + 1)
+
+static int ida_test_init(struct kunit *test)
+{
+	static DEFINE_IDA(ida);
+
+	ida_init(&ida);
+	test->priv = &ida;
+	return 0;
+}
+
+static void ida_test_exit(struct kunit *test)
+{
+	struct ida *ida = test->priv;
+
+	ida_destroy(ida);
+	KUNIT_EXPECT_TRUE(test, ida_is_empty(ida));
+}
+
+static const unsigned int ida_params[] = {
+	0,
+	1,
+	BITS_PER_XA_VALUE - 1,
+	BITS_PER_XA_VALUE,
+	BITS_PER_XA_VALUE + 1,
+	IDA_BITMAP_BITS - BITS_PER_XA_VALUE - 1,
+	IDA_BITMAP_BITS - BITS_PER_XA_VALUE,
+	IDA_BITMAP_BITS - BITS_PER_XA_VALUE + 1,
+	IDA_BITMAP_BITS - 1,
+	IDA_BITMAP_BITS,
+	IDA_BITMAP_BITS + 1,
+	IDA_BITMAP_BITS + BITS_PER_XA_VALUE - 1,
+	IDA_BITMAP_BITS + BITS_PER_XA_VALUE,
+	IDA_BITMAP_BITS + BITS_PER_XA_VALUE + 1,
+	IDA_BITMAP_BITS + IDA_BITMAP_BITS + BITS_PER_XA_VALUE - 1,
+	IDA_BITMAP_BITS + IDA_BITMAP_BITS + BITS_PER_XA_VALUE + 1,
+};
+
+static void uint_get_desc(const unsigned int *p, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%u", *p);
+}
+
+KUNIT_ARRAY_PARAM(ida, ida_params, uint_get_desc);
+
+static void test_alloc_one(struct kunit *test)
+{
+	struct ida *ida = test->priv;
+	const unsigned int *p = test->param_value;
+	unsigned int min = *p;
+
+	KUNIT_ASSERT_EQ(test, ida_weight(ida), 0);
+	KUNIT_ASSERT_EQ(test, ida_alloc_min(ida, min, GFP_KERNEL), min);
+	KUNIT_ASSERT_EQ(test, ida_weight(ida), 1);
+	ida_free(ida, min);
+	KUNIT_ASSERT_EQ(test, ida_weight(ida), 0);
+}
+
+static void test_alloc_many(struct kunit *test)
+{
+	struct ida *ida = test->priv;
+	const unsigned int *p = test->param_value;
+	unsigned int n, num = *p;
+
+	KUNIT_ASSERT_EQ(test, ida_weight(ida), 0);
+
+	for (n = 0; n < num; n++) {
+		KUNIT_ASSERT_EQ(test, ida_alloc(ida, GFP_KERNEL), n);
+		KUNIT_ASSERT_EQ(test, ida_weight(ida), n + 1);
+	}
+
+	kunit_info(test, "weight %lu", ida_weight(ida));
+
+	for (n = 0; n < num; n++) {
+		ida_free(ida, n);
+		KUNIT_ASSERT_EQ(test, ida_weight(ida), num - n - 1);
+	}
+
+	KUNIT_ASSERT_EQ(test, 0, ida_weight(ida));
+}
+
+static void test_alloc_min(struct kunit *test)
+{
+	struct ida *ida = test->priv;
+	const unsigned int *p = test->param_value;
+	unsigned int n, min = *p;
+
+	KUNIT_ASSERT_EQ(test, ida_weight(ida), 0);
+	for (n = min; n < IDA_STRESS_LIMIT; n++) {
+		KUNIT_ASSERT_EQ(test, ida_alloc_min(ida, min, GFP_KERNEL), n);
+		KUNIT_ASSERT_EQ(test, ida_weight(ida), n - min + 1);
+	}
+}
+
+static void test_alloc_group(struct kunit *test)
+{
+	struct ida *ida = test->priv;
+	const unsigned int *p = test->param_value;
+	unsigned int n, group = *p;
+	unsigned long w;
+
+	for (n = 0; n < IDA_STRESS_LIMIT; n += (1 + group)) {
+		KUNIT_ASSERT_EQ(test,
+				ida_alloc_group_range(ida, 0, -1, group, GFP_KERNEL),
+				n);
+		KUNIT_ASSERT_EQ(test, ida_weight(ida), n + 1 + group);
+	}
+
+	KUNIT_ASSERT_NE(test, w = ida_weight(ida), 0);
+
+	for (n = 0; n < IDA_STRESS_LIMIT; n += (1 + group)) {
+		ida_free_group(ida, n, group);
+		KUNIT_ASSERT_EQ(test, ida_weight(ida), w - n - 1 - group);
+	}
+}
+
+static struct kunit_case ida_test_cases[] = {
+	KUNIT_CASE_PARAM(test_alloc_one, ida_gen_params),
+	KUNIT_CASE_PARAM(test_alloc_many, ida_gen_params),
+	KUNIT_CASE_PARAM(test_alloc_min, ida_gen_params),
+	KUNIT_CASE_PARAM(test_alloc_group, ida_gen_params),
+	{}
+};
+
+static struct kunit_suite ida_suite = {
+	.name = "ida",
+	.test_cases = ida_test_cases,
+	.init = ida_test_init,
+	.exit = ida_test_exit,
+};
+
+kunit_test_suites(&ida_suite);
-- 
2.25.1


