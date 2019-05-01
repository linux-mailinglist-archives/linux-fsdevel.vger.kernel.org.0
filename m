Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2E10F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEAXDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:03:02 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50917 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfEAXDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:03:01 -0400
Received: by mail-qt1-f201.google.com with SMTP id f48so324800qtk.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WBzJ19nC8IuqkBcKxxV42TfRISABudjBoJLmYR5hSKo=;
        b=ilaIbocGv7xrPb0aAy+7Bg6GwWLHnZUp6L6/cNcZkqEinCfdGZ0etp24jSVtgAG2Sb
         6rIAt3IUgY//P5EioZajVMSt7mN3cYTiLSEuUVozB+uL0TBjCOi6Mt5F43FCZmvvPE7O
         h5K8qrSuPXRVkv8Jm4XJMjOmzMEx27gHboiyI44vk7ObllgE331cHf/Ru0GbHK4lXRwq
         7f3z9b0NyF3ZOgdTXzhgeaFJ6SVHyYLpP44s8SF0fx2GUqkHKCOmgB+xlIE80la5yxvr
         AG9U4wBIQ1P5AyHP6iBYGk7vcBp3mYFRV2q7rG0g9LGwQ0My+FCju1odtsjf0t/oq1iM
         7D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WBzJ19nC8IuqkBcKxxV42TfRISABudjBoJLmYR5hSKo=;
        b=ZUUzaH1scsdFeYEpFu2gudIfECukWtSfpCYyh3vYcOfPE1pCvfOtt6wU2U4eYJSsma
         WpjxVNNnuBxQwaeR2GCDyA9D8DfSCDC68pM4yQiExjocptukNRtS81Zmh9sXKQmPamk/
         lKMk7mREHQ2orL7Q2othx7YFzNL/eC/hypmI9nTiBUgHUK9UC1j1MZSFPvWZrSmGQ0yB
         MaLXUiSk6gePFy9zcgCi8VzwKp/Md/L9Flr/IhKNF7rWFxEi2OPwE5qLD/oy8g0bHS1b
         WNZQRkbhG9V3ld13UzB1zFJE2bsztqa0Uc7/jne+hVPbD6YU2hF/AlIxXCq6ubDe7Tzt
         1Lcw==
X-Gm-Message-State: APjAAAVx8B34CX/3q1Yyg0A/Y6F2KVgVjdOfEFSjcrWL8MFM6IjciKHa
        djV50megEpNo0Baa3dPyntYQvUYyCn7riImt5T9IaA==
X-Google-Smtp-Source: APXvYqwYxsnAxJym2b9e5x/7Qaxf348dkQ4h5lFxzEuYKroNsf/GILXwwBIlSIdJCXhACkbYLcwEi9jYbbIFVj8HtFw+Vw==
X-Received: by 2002:ac8:26e1:: with SMTP id 30mr559535qtp.305.1556751780638;
 Wed, 01 May 2019 16:03:00 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:11 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 02/17] kunit: test: add test resource management API
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

Create a common API for test managed resources like memory and test
objects. A lot of times a test will want to set up infrastructure to be
used in test cases; this could be anything from just wanting to allocate
some memory to setting up a driver stack; this defines facilities for
creating "test resources" which are managed by the test infrastructure
and are automatically cleaned up at the conclusion of the test.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 109 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  95 +++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 23c2ebedd6dd9..819edd8db4e81 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,69 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
+struct kunit_resource;
+
+typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
+typedef void (*kunit_resource_free_t)(struct kunit_resource *);
+
+/**
+ * struct kunit_resource - represents a *test managed resource*
+ * @allocation: for the user to store arbitrary data.
+ * @free: a user supplied function to free the resource. Populated by
+ * kunit_alloc_resource().
+ *
+ * Represents a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	struct kunit_kmalloc_params {
+ *		size_t size;
+ *		gfp_t gfp;
+ *	};
+ *
+ *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+ *	{
+ *		struct kunit_kmalloc_params *params = context;
+ *		res->allocation = kmalloc(params->size, params->gfp);
+ *
+ *		if (!res->allocation)
+ *			return -ENOMEM;
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void kunit_kmalloc_free(struct kunit_resource *res)
+ *	{
+ *		kfree(res->allocation);
+ *	}
+ *
+ *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+ *	{
+ *		struct kunit_kmalloc_params params;
+ *		struct kunit_resource *res;
+ *
+ *		params.size = size;
+ *		params.gfp = gfp;
+ *
+ *		res = kunit_alloc_resource(test, kunit_kmalloc_init,
+ *			kunit_kmalloc_free, &params);
+ *		if (res)
+ *			return res->allocation;
+ *		else
+ *			return NULL;
+ *	}
+ */
+struct kunit_resource {
+	void *allocation;
+	kunit_resource_free_t free;
+
+	/* private: internal use only. */
+	struct list_head node;
+};
+
 struct kunit;
 
 /**
@@ -104,6 +167,7 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	spinlock_t lock; /* Gaurds all mutable test state. */
 	bool success; /* Protected by lock. */
+	struct list_head resources; /* Protected by lock. */
 	void (*vprintk)(const struct kunit *test,
 			const char *level,
 			struct va_format *vaf);
@@ -127,6 +191,51 @@ int kunit_run_tests(struct kunit_module *module);
 		} \
 		late_initcall(module_kunit_init##module)
 
+/**
+ * kunit_alloc_resource() - Allocates a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource.
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ */
+struct kunit_resource *kunit_alloc_resource(struct kunit *test,
+					    kunit_resource_init_t init,
+					    kunit_resource_free_t free,
+					    void *context);
+
+void kunit_free_resource(struct kunit *test, struct kunit_resource *res);
+
+/**
+ * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * Just like `kmalloc(...)`, except the allocation is managed by the test case
+ * and is automatically cleaned up after the test case concludes. See &struct
+ * kunit_resource for more information.
+ */
+void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp);
+
+/**
+ * kunit_kzalloc() - Just like kunit_kmalloc(), but zeroes the allocation.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kzalloc() and kunit_kmalloc() for more information.
+ */
+static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
+{
+	return kunit_kmalloc(test, size, gfp | __GFP_ZERO);
+}
+
+void kunit_cleanup(struct kunit *test);
+
 void __printf(3, 4) kunit_printk(const char *level,
 				 const struct kunit *test,
 				 const char *fmt, ...);
diff --git a/kunit/test.c b/kunit/test.c
index 5bf97e2935579..541f9adb1608c 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -66,6 +66,7 @@ static void kunit_vprintk(const struct kunit *test,
 int kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->vprintk = kunit_vprintk;
 
@@ -93,6 +94,11 @@ static void kunit_run_case_internal(struct kunit *test,
 	test_case->run_case(test);
 }
 
+static void kunit_case_internal_cleanup(struct kunit *test)
+{
+	kunit_cleanup(test);
+}
+
 /*
  * Performs post validations and cleanup after a test case was run.
  * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
@@ -103,6 +109,8 @@ static void kunit_run_case_cleanup(struct kunit *test,
 {
 	if (module->exit)
 		module->exit(test);
+
+	kunit_case_internal_cleanup(test);
 }
 
 /*
@@ -150,6 +158,93 @@ int kunit_run_tests(struct kunit_module *module)
 	return 0;
 }
 
+struct kunit_resource *kunit_alloc_resource(struct kunit *test,
+					    kunit_resource_init_t init,
+					    kunit_resource_free_t free,
+					    void *context)
+{
+	struct kunit_resource *res;
+	unsigned long flags;
+	int ret;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	ret = init(res, context);
+	if (ret)
+		return NULL;
+
+	res->free = free;
+	spin_lock_irqsave(&test->lock, flags);
+	list_add_tail(&res->node, &test->resources);
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return res;
+}
+
+void kunit_free_resource(struct kunit *test, struct kunit_resource *res)
+{
+	res->free(res);
+	list_del(&res->node);
+	kfree(res);
+}
+
+struct kunit_kmalloc_params {
+	size_t size;
+	gfp_t gfp;
+};
+
+static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_kmalloc_params *params = context;
+
+	res->allocation = kmalloc(params->size, params->gfp);
+	if (!res->allocation)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void kunit_kmalloc_free(struct kunit_resource *res)
+{
+	kfree(res->allocation);
+}
+
+void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+{
+	struct kunit_kmalloc_params params;
+	struct kunit_resource *res;
+
+	params.size = size;
+	params.gfp = gfp;
+
+	res = kunit_alloc_resource(test,
+				   kunit_kmalloc_init,
+				   kunit_kmalloc_free,
+				   &params);
+
+	if (res)
+		return res->allocation;
+	else
+		return NULL;
+}
+
+void kunit_cleanup(struct kunit *test)
+{
+	struct kunit_resource *resource, *resource_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_for_each_entry_safe(resource,
+				 resource_safe,
+				 &test->resources,
+				 node) {
+		kunit_free_resource(test, resource);
+	}
+	spin_unlock_irqrestore(&test->lock, flags);
+}
+
 void kunit_printk(const char *level,
 		  const struct kunit *test,
 		  const char *fmt, ...)
-- 
2.21.0.593.g511ec345e18-goog

