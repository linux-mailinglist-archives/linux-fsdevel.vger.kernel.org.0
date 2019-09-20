Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC02B9A70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437072AbfITXUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:20:18 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33737 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437047AbfITXUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:20:13 -0400
Received: by mail-yw1-f73.google.com with SMTP id p185so6810419ywb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aABf1eQBMP6/WvpZsyoq3EyRjH0cX7yhFaKM6+EkpH4=;
        b=C8CTpH7hjt5YzOI8L3ZXZdx+UjDYARIDHHjQ/7OtEDOsGIfUTly+gb2r4DffPT2x7P
         4vRLIiK1XK9TvUnkfkNU1Iv9kUN8urfJiAOsHRGh0rwJ8k9Ny1vyB/ixjD51NAsOwCbO
         FRInTaqsz/Bd8gz2nilcPiISmipuNqdZi9TZdJaanGF6Re0R4bHhbmbZDoOTAg98B5vF
         D2QLWdOrGKPy9B47ek5ANwRKVa8jMt08wD6F/S/feLXmidmt6srqGWOW5ZgWIW0/Rm+Q
         OQaWqX+oD7QR9eH/jyHsv+MYWnflZtQKzkZaXkmsA21SGpVoFzW6o3ApmTnQrTzRApNP
         OQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aABf1eQBMP6/WvpZsyoq3EyRjH0cX7yhFaKM6+EkpH4=;
        b=FPdTkIeFoGVMtuv9vVsLQmGPf3jG1/im+NVdQ7PZrs9GxfaRssjZ9PgB2jqzFt2552
         yLlMypAYRliin+FSHi0rQBEvNCfHhoRlr7Dz9S11jMhN7kDoJg/ohNMFNGXN8vIP3umC
         Nz2qklp3jXYXf/uuaCLjjykvf48bNEN5XVTfd4u1cO5YGXIuY8om5ergvpgLDZrYsfTr
         sZQb3TdEEIo8zxa/au4Iq4bTUdqHna7QBawuwFCfbFjEHPWWrrwn09T11Pu2D2qJqmDs
         10UzXNbu8vWxdBeww1xoGq2tcNkBmqpLB8qI78s0UEqQzK+8oDqVl4yS26gc7rxw8ebl
         YwkQ==
X-Gm-Message-State: APjAAAU6xTzr5ilIIU4AnWdDRRdnjDUqIxwPuE7uuVqJFA5BRcKUgtrb
        Stj1jxWVYkokY/QoHRI73RPdRy5nZIAVKfMMw5QvGw==
X-Google-Smtp-Source: APXvYqweqI84X6kIFXp//UjYY7BAsyfmpZhSb5WrEB7msV1QvcEohsykXXMYy3EnpAxoYkj0k9lpHjzJ8iclAUJ1C+DKlg==
X-Received: by 2002:a81:a24f:: with SMTP id z15mr14509682ywg.55.1569021612142;
 Fri, 20 Sep 2019 16:20:12 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:16 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 12/19] kunit: test: add tests for KUnit managed resources
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
        Avinash Kondareddy <akndr41@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Avinash Kondareddy <akndr41@gmail.com>

Add unit tests for KUnit managed resources. KUnit managed resources
(struct kunit_resource) are resources that are automatically cleaned up
at the end of a KUnit test, similar to the concept of devm_* managed
resources.

Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/test-test.c | 228 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
index e0ab4bd546ea..5ebe059d16e2 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/test-test.c
@@ -101,3 +101,231 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 kunit_test_suite(kunit_try_catch_test_suite);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+	int allocate_order[2];
+	int free_order[2];
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_and_get_resource(&ctx->test,
+					   fake_resource_init,
+					   fake_resource_free,
+					   GFP_KERNEL,
+					   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized,
+			    (bool *) res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_destroy_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	KUNIT_ASSERT_FALSE(test,
+			   kunit_resource_destroy(&ctx->test,
+						  kunit_resource_instance_match,
+						  res->free,
+						  res->allocation));
+
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[5];
+
+	for (i = 0; i < ARRAY_SIZE(resources); i++) {
+		resources[i] = kunit_alloc_and_get_resource(&ctx->test,
+							    fake_resource_init,
+							    fake_resource_free,
+							    GFP_KERNEL,
+							    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_mark_order(int order_array[],
+					   size_t order_size,
+					   int key)
+{
+	int i;
+
+	for (i = 0; i < order_size && order_array[i]; i++)
+		;
+
+	order_array[i] = key;
+}
+
+#define KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, order_field, key)		       \
+		kunit_resource_test_mark_order(ctx->order_field,	       \
+					       ARRAY_SIZE(ctx->order_field),   \
+					       key)
+
+static int fake_resource_2_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_2_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
+}
+
+static int fake_resource_1_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_2_init,
+				     fake_resource_2_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_1_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
+}
+
+/*
+ * TODO(brendanhiggins@google.com): replace the arrays that keep track of the
+ * order of allocation and freeing with strict mocks using the IN_SEQUENCE macro
+ * to assert allocation and freeing order when the feature becomes available.
+ */
+static void kunit_resource_test_proper_free_ordering(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	/* fake_resource_1 allocates a fake_resource_2 in its init. */
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_1_init,
+				     fake_resource_1_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	/*
+	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
+	 * before returning to fake_resource_1_init, it should be the first to
+	 * put its key in the allocate_order array.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
+
+	kunit_cleanup(&ctx->test);
+
+	/*
+	 * Because fake_resource_2 finishes allocation before fake_resource_1,
+	 * fake_resource_1 should be freed first since it could depend on
+	 * fake_resource_2.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 1);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
+	{}
+};
+
+static struct kunit_suite kunit_resource_test_suite = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+kunit_test_suite(kunit_resource_test_suite);
-- 
2.23.0.351.gc4317032e6-goog

