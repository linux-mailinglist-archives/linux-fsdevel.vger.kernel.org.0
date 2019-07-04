Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3FD5F02E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 02:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfGDAh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 20:37:28 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47250 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfGDAh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 20:37:28 -0400
Received: by mail-pg1-f202.google.com with SMTP id o19so2566600pgl.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2019 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9mi9rnjiKWt/gcB9WB4BU+tHmgUe8stLBx1sdCfTiK0=;
        b=irHxq4kwJDSptPuaesui/z88F3y4LQ7Lj1+tkZkPgA05NDRdTMcdzGgOJTHakPzRuz
         JeTvJP4+OVLC23xEb1+tIqY3zoMRjLg/rZ+d5y/I4qrmoJfpPERQarLH9LIsrGZvavts
         CNbh8lyLJYtbADBFsBN4pWxOXDVxC9o3ugaoRBVGvyznnfeDVcQHFdsH47o8LvPJHxZg
         tTQMSR60Jo2cWeKZJVJKD2CJitxOAc6EsokLLRxzKGCRntXep2WM+cUQOgTRenpzdF2U
         pWWrxdSTxM+vki6VcEtNNEpyro+EbPTgDjw3vj0jr2TVEhvUnVhozJDkr6UG5e6o7T48
         fNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9mi9rnjiKWt/gcB9WB4BU+tHmgUe8stLBx1sdCfTiK0=;
        b=Cnj+iTaQZJR1m1a0CM0d9zTlQX4Orjh4Sari3p8DXlna1Vhn/wDAIo7EAqHz1aBTxn
         xoJN7/xDiDukJ79or6nE8g75mAra5NCaJlzFqMcFEyKhMbzZlG8bBzCg34QC0+gaA9jP
         K6thDnNvv+IN8lpNR7bha0JidW5OIP/+sulDywtQ7M5CCseckaKcGqUaFKPPnaXJvR7k
         OQ518/s+ko8lByweya3qOriB1ZUE9CWjP7+8HYxYIs1cDbZ/dhpLTveHOQFNXgi/UpVc
         QfDqjYS2TZGTjUBDIOgaWzLeAIneB6FF6S0WMqgGAGcvoC5silOieeBcbRJBUtj4m44u
         w7rw==
X-Gm-Message-State: APjAAAWGII7Mi/DKPpTTYd7rBbofD3lij12aNyjuzWCA708HZMJWM/n/
        6KAlHbv2IecjKgaHfqvnRUajZm3qb88tcJADx9LwtA==
X-Google-Smtp-Source: APXvYqz1GC1OMVVZwuTvVyWR3g3Mxr9/kFNt2G9WovTMR/KJAbAkLGgArL+inrZuc2wpe/eO6f403QolVXgcelUu3ZuEyw==
X-Received: by 2002:a63:6ec6:: with SMTP id j189mr24972890pgc.168.1562200646657;
 Wed, 03 Jul 2019 17:37:26 -0700 (PDT)
Date:   Wed,  3 Jul 2019 17:35:59 -0700
In-Reply-To: <20190704003615.204860-1-brendanhiggins@google.com>
Message-Id: <20190704003615.204860-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 02/18] kunit: test: add test resource management API
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
Changes Since Last Revision:
- Replaced spinlock with a mutex. - Suggested by Luis and Stephen
  (Sorry guys, I still need some kind of locking for the resource list
  and the death test field (introduced later) that gets written to and
  read from multiple times).
---
 include/kunit/test.h | 111 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  95 +++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b34d9f2ac6f9c..d9973ee5d7f82 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -10,6 +10,70 @@
 #define _KUNIT_TEST_H
 
 #include <linux/types.h>
+#include <linux/slab.h>
+
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
+ *
+ *		return NULL;
+ *	}
+ */
+struct kunit_resource {
+	void *allocation;
+	kunit_resource_free_t free;
+
+	/* private: internal use only. */
+	struct list_head node;
+};
 
 struct kunit;
 
@@ -114,6 +178,8 @@ struct kunit {
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
 	bool success; /* Read only after test_case finishes! */
+	struct mutex lock; /* Gaurds all mutable test state. */
+	struct list_head resources; /* Protected by lock. */
 };
 
 void kunit_init_test(struct kunit *test, const char *name);
@@ -144,6 +210,51 @@ int kunit_run_tests(struct kunit_suite *suite);
 		} \
 		late_initcall(kunit_suite_init##suite)
 
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
index c030ba5a43e40..a70fbe449e922 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -122,7 +122,8 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
-	spin_lock_init(&test->lock);
+	mutex_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->success = true;
 }
@@ -152,6 +153,8 @@ static void kunit_run_case(struct kunit_suite *suite,
 	if (suite->exit)
 		suite->exit(&test);
 
+	kunit_cleanup(&test);
+
 	test_case->success = test.success;
 }
 
@@ -172,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
 	return 0;
 }
 
+struct kunit_resource *kunit_alloc_resource(struct kunit *test,
+					    kunit_resource_init_t init,
+					    kunit_resource_free_t free,
+					    void *context)
+{
+	struct kunit_resource *res;
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
+	mutex_lock(&test->lock);
+	list_add_tail(&res->node, &test->resources);
+	mutex_unlock(&test->lock);
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
+
+	return NULL;
+}
+
+void kunit_cleanup(struct kunit *test)
+{
+	struct kunit_resource *resource, *resource_safe;
+
+	mutex_lock(&test->lock);
+	/*
+	 * test->resources is a stack - each allocation must be freed in the
+	 * reverse order from which it was added since one resource may depend
+	 * on another for its entire lifetime.
+	 */
+	list_for_each_entry_safe_reverse(resource,
+					 resource_safe,
+					 &test->resources,
+					 node) {
+		kunit_free_resource(test, resource);
+	}
+	mutex_unlock(&test->lock);
+}
+
 void kunit_printk(const char *level,
 		  const struct kunit *test,
 		  const char *fmt, ...)
-- 
2.22.0.410.gd8fdbe21b5-goog

