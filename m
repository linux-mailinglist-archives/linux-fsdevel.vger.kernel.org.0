Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB62D1E46B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfENWSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:18:13 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:40943 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfENWSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:18:12 -0400
Received: by mail-ot1-f73.google.com with SMTP id h4so248323otl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6qJ62ebxWqgPaWi90RXevyWcrz+KbGI56vPeGK6zAE8=;
        b=YtSnCk12U1+7Nr6H6G+UiHER0HlhJkkOVKYY/VNCWtSd8DNw7R1CuCAAk0G/btp/nn
         NLRqqsqx4k1Kv12HqVhqCyiJ/5o3IMR8OYCLulisVWFK7arG9xv3mfwu2Hhc/J5+0KAU
         AJwqoJ2/zCFcNJOaodEnjMo1OK9NkYe5MOeQdpMgECIgZw1uBpJw1VCHYDU4iKKH3v9h
         yG04wZzy4aCC1J+zpJH4i70zLuQebZFAImsQP7/AhW2aRdWBqVtftZEXL1E0Z8U+Yl6l
         pIi8wSjGgNU9NGzBnHPZWyyEs6MhdfevLUNp0YjlvJPp8HOjETUBfwxMRN5k6JurKzvb
         TqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6qJ62ebxWqgPaWi90RXevyWcrz+KbGI56vPeGK6zAE8=;
        b=HBPprLC/idyQyjc5CAbuWocTIMcdEq5elGlktRIwEEKpJUbr5RFdXrTx3saZEj8xeV
         Zi0CGsuwKbYChIziQJ75GZdyTXfcgoyCs7ekkQycKmv6rZgo4lAJJsnS1qe7qSerg4gm
         WxVQJTN0tFSGm/XpPtD7WuHKXToTzAqnVNWhPs2ptjYr9do2NvCnYPIZBXoJkBr7qs6V
         q+9ZorUmjwOauY7JxeCZ9gBrrrlgoe/aAn9+Mu8Iyw6xscrunm2KVUBdUVBVxTJ6QysU
         fEtEZ0IQhin5BtZfaJtJIGJvg/ZUaFvDwtrhL8wHpDGKiIdVkwg8Nf7qICu1r0Mcresk
         DS5Q==
X-Gm-Message-State: APjAAAVWsujCAAf4uVhQGbYMoJwJiKgCgQtVV/QnnPMae5fVBahnwmUo
        88uaaa7o840abHc3nwbx6nbr/KyFFmLpOLIfLGTwGg==
X-Google-Smtp-Source: APXvYqzwt72M3+5ejrpB/skXqOPhJUFoF6VoDANGzWy0qVIEoJG6SfpaoY6ItndI0msB/9wG+nLIpIzRHcwAnuFz4vLpWA==
X-Received: by 2002:aca:ec89:: with SMTP id k131mr4494558oih.86.1557872292010;
 Tue, 14 May 2019 15:18:12 -0700 (PDT)
Date:   Tue, 14 May 2019 15:16:55 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 02/18] kunit: test: add test resource management API
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

Create a common API for test managed resources like memory and test
objects. A lot of times a test will want to set up infrastructure to be
used in test cases; this could be anything from just wanting to allocate
some memory to setting up a driver stack; this defines facilities for
creating "test resources" which are managed by the test infrastructure
and are automatically cleaned up at the conclusion of the test.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/test.h | 109 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  95 +++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e682ea0e1f9a5..5e86d88cd5305 100644
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
 };
 
 void kunit_init_test(struct kunit *test, const char *name);
@@ -124,6 +188,51 @@ int kunit_run_tests(struct kunit_module *module);
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
index 86f65ba2bcf92..a15e6f8c41582 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -141,6 +141,7 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 void kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 }
 
@@ -165,6 +166,11 @@ static void kunit_run_case_internal(struct kunit *test,
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
@@ -175,6 +181,8 @@ static void kunit_run_case_cleanup(struct kunit *test,
 {
 	if (module->exit)
 		module->exit(test);
+
+	kunit_case_internal_cleanup(test);
 }
 
 /*
@@ -211,6 +219,93 @@ int kunit_run_tests(struct kunit_module *module)
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
2.21.0.1020.gf2820cf01a-goog

