Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1491E4F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfENWTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:19:23 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:50289 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfENWTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:22 -0400
Received: by mail-ua1-f74.google.com with SMTP id t8so267001uaj.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AF/X8kcACMWJnbuDnmgRNv7b9D+v3mQnlvpAU165Bwk=;
        b=r21t6aRT31vNmpHaVPznC01sm7g+B5zt/jTVYWwmuo0cnbatwvGtXsLMEJPXX6zEoP
         FG3OW9ubxqr6YCydWl32PTlnIP7SYUwByExlaXM73wCCQ3+2tkORRsltrNpqpbXQAKQg
         ku0N9dvnOgGjgRfcIXdfuvX2dM54j/nmqegoGcJfCjZDaf+BMlJLXI3iiPCpya8XU7JY
         LFx44FuKPcAW8WiTPQ77zyWJaQZ0s7aW4VktCc8mNlE+0W32KYe3nQSnwjK1QUMtqM++
         KyJhT61S+DwD9fzuSDjvEkFIs3xDUSokTOYs4rKLJCr+FihvewVZ18EwM5Kjq9T6C4GP
         S+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AF/X8kcACMWJnbuDnmgRNv7b9D+v3mQnlvpAU165Bwk=;
        b=WmSYJlA7J/wxk/neVd8fTVQDDlaLpfD6O0Y5kx7fdyamsYBG54zpNQy3NBfMqcCVRA
         rnS8ppsn5tl+Rn7x8hogW8fdslbheL/A1gK5TZdLYjA/dpxfgVTDM+3drpk3TZ4tN+GJ
         XWw3kF7N4M/Sk/X6K8nocHp8k1VXfUZi24pm1pwn/GsXuE0liN0FaTD/PBdOxkHMWDw8
         Usd8ck6dkwD3m+perA7lw7AcEuatXKSM4cRU8M6z0WlC5igfndpFTTlC86yfgloLILtn
         GUvGxwZ8XZEOaxhpY0AnqD5TuvNfJEbyV8uEJCrLqQ0sv5mw/kW0clItHZq9IAKvVJ5w
         y/7A==
X-Gm-Message-State: APjAAAVaOIBOlnA0dm99ydJ7jRb3avbnAGYjisI6EI6uVxdfNcOaQCD5
        sa/KjJiBz20AH3EUHvfCpTBwun12GEEMtm56xpLpxg==
X-Google-Smtp-Source: APXvYqwzDzsNPOfRnQOJWWw03pWCA5Fjhb1qGAZ4OtAQmohRvasBoIqNe/10w5aP2fIkCU3ca5rLrh+9ahCG9LjIfitkeg==
X-Received: by 2002:a67:c508:: with SMTP id e8mr3376906vsk.18.1557872360849;
 Tue, 14 May 2019 15:19:20 -0700 (PDT)
Date:   Tue, 14 May 2019 15:17:05 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 12/18] kunit: test: add tests for KUnit managed resources
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
        wfg@linux.intel.com, Avinash Kondareddy <akndr41@gmail.com>,
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
---
 kunit/test-test.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/kunit/test-test.c b/kunit/test-test.c
index 7afc9bb52f7be..ee926f798b266 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -101,3 +101,126 @@ static struct kunit_module kunit_try_catch_test_module = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 module_test(kunit_try_catch_test_module);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
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
+	res = kunit_alloc_resource(&ctx->test,
+				   fake_resource_init,
+				   fake_resource_free,
+				   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized, res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_free_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_resource(&ctx->test,
+							  fake_resource_init,
+							  fake_resource_free,
+							  ctx);
+
+	kunit_free_resource(&ctx->test, res);
+
+	KUNIT_EXPECT_EQ(test, false, ctx->is_resource_initialized);
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
+		resources[i] = kunit_alloc_resource(&ctx->test,
+						    fake_resource_init,
+						    fake_resource_free,
+						    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
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
+	KUNIT_CASE(kunit_resource_test_free_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	{},
+};
+
+static struct kunit_module kunit_resource_test_module = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+module_test(kunit_resource_test_module);
-- 
2.21.0.1020.gf2820cf01a-goog

