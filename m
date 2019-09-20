Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6CFB9AA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407089AbfITXVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:21:48 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51955 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394057AbfITXTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:19:47 -0400
Received: by mail-pl1-f202.google.com with SMTP id q13so3986731pls.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y0xYR4PS86ooH7AKhBWD3EqeH7toUpR236CnccW5V4s=;
        b=cGgtdOzzxccHP4HO2P0fyy/IBVjc/aM/KrWoEEG2kM2X/HfOu0oKt1ZjOwVueH9svC
         7CBUaUqTLbSd2flZaUvvZ0xlv/MUJV9Ax9MNzwrbAZEealchV6ybPkd39NJh1ol2ShMw
         gNcLl5u1rS/tzbIA08ASCiaYAL+xGJgPY1hh//IzJkhfIjEk7yyge9MbussmWM4gs/C6
         xM/5b4VpevMVUxWfBjWrV34TKEdEBrmojl/xzbbZJ2fVgUKgpYZfYktAUzGGPSdC+/S/
         OBXFa7SZF0R2Dkf0ONxTVig8DSAXX6y5l2tbGwn3wBExzk7zHftrswHl4MfdgKLo+O2g
         +Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y0xYR4PS86ooH7AKhBWD3EqeH7toUpR236CnccW5V4s=;
        b=j+g5Gk7FqU6VULrviEoGE6JYimNvCWUMVqCmcktO5Q+9IkUSjAvT+vc45z1PNwGP3j
         yRkwQSftWUf/xu7JArOwuaXyIG+S+jT4J3y3uhV+9q1q7vx1IGZRwhFa66NZc4DJSyxx
         /LiwgLsK4OmEg3JVlo57QWfnw4fiXRXeLxFK/4uJj5SNxfxWSOOdcIcmMkNO5yhxB2Jp
         jwzKjqKhK6y7O7hrvlhC7YCN5trUx712aNSfzdygtzkIh4eDxaWbAiPbUEhPy0oj68mc
         j49h7PohfE0DibEwkjdpyQQP4joe8+cGehFPCazCCeoVmY6uswTnqK5rC1GoG2Y6P3YX
         7njA==
X-Gm-Message-State: APjAAAU59ievKqRTmEiY797Iu2ALzwT38b2RpnP54NtucijRCW/sJUz+
        GSZVH6g4niNFigXvi2qsua1QhqJJBkEbHwyv5wzXPA==
X-Google-Smtp-Source: APXvYqzk9PPAlQcfR7BQ5fHtHQPcShYKNOzmMDVDjY1njMOiG1Qe3n+8nYrgE8+PpZuwhdiW+2ENFCaGkhJyqZCiD/CZHw==
X-Received: by 2002:a65:4786:: with SMTP id e6mr17354202pgs.448.1569021584212;
 Fri, 20 Sep 2019 16:19:44 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:06 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 02/19] kunit: test: add test resource management API
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

Create a common API for test managed resources like memory and test
objects. A lot of times a test will want to set up infrastructure to be
used in test cases; this could be anything from just wanting to allocate
some memory to setting up a driver stack; this defines facilities for
creating "test resources" which are managed by the test infrastructure
and are automatically cleaned up at the conclusion of the test.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 187 +++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 163 +++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e30d1bf2fb68..6781c756f11b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -9,8 +9,72 @@
 #ifndef _KUNIT_TEST_H
 #define _KUNIT_TEST_H
 
+#include <linux/slab.h>
 #include <linux/types.h>
 
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
+
 struct kunit;
 
 /**
@@ -114,6 +178,13 @@ struct kunit {
 	 * with the test case have terminated.
 	 */
 	bool success; /* Read only after test_case finishes! */
+	spinlock_t lock; /* Guards all mutable test state. */
+	/*
+	 * Because resources is a list that may be updated multiple times (with
+	 * new resources) from any thread associated with a test case, we must
+	 * protect it with some type of lock.
+	 */
+	struct list_head resources; /* Protected by lock. */
 };
 
 void kunit_init_test(struct kunit *test, const char *name);
@@ -147,6 +218,122 @@ int kunit_run_tests(struct kunit_suite *suite);
 	}								       \
 	late_initcall(kunit_suite_init##suite)
 
+/*
+ * Like kunit_alloc_resource() below, but returns the struct kunit_resource
+ * object that contains the allocation. This is mostly for testing purposes.
+ */
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *context);
+
+/**
+ * kunit_alloc_resource() - Allocates a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource.
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ *
+ * NOTE: KUnit needs to allocate memory for each kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the use context of your
+ * resource.
+ */
+static inline void *kunit_alloc_resource(struct kunit *test,
+					 kunit_resource_init_t init,
+					 kunit_resource_free_t free,
+					 gfp_t internal_gfp,
+					 void *context)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_and_get_resource(test, init, free, internal_gfp,
+					   context);
+
+	if (res)
+		return res->allocation;
+
+	return NULL;
+}
+
+typedef bool (*kunit_resource_match_t)(struct kunit *test,
+				       const void *res,
+				       void *match_data);
+
+/**
+ * kunit_resource_instance_match() - Match a resource with the same instance.
+ * @test: Test case to which the resource belongs.
+ * @res: The data stored in kunit_resource->allocation.
+ * @match_data: The resource pointer to match against.
+ *
+ * An instance of kunit_resource_match_t that matches a resource whose
+ * allocation matches @match_data.
+ */
+static inline bool kunit_resource_instance_match(struct kunit *test,
+						 const void *res,
+						 void *match_data)
+{
+	return res == match_data;
+}
+
+/**
+ * kunit_resource_destroy() - Find a kunit_resource and destroy it.
+ * @test: Test case to which the resource belongs.
+ * @match: Match function. Returns whether a given resource matches @match_data.
+ * @free: Must match free on the kunit_resource to free.
+ * @match_data: Data passed into @match.
+ *
+ * Free the latest kunit_resource of @test for which @free matches the
+ * kunit_resource_free_t associated with the resource and for which @match
+ * returns true.
+ *
+ * RETURNS:
+ * 0 if kunit_resource is found and freed, -ENOENT if not found.
+ */
+int kunit_resource_destroy(struct kunit *test,
+			   kunit_resource_match_t match,
+			   kunit_resource_free_t free,
+			   void *match_data);
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
+ * kunit_kfree() - Like kfree except for allocations managed by KUnit.
+ * @test: The test case to which the resource belongs.
+ * @ptr: The memory allocation to free.
+ */
+void kunit_kfree(struct kunit *test, const void *ptr);
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
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d3dda359f99b..68b1037ab74d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -122,6 +122,8 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
+	spin_lock_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->success = true;
 }
@@ -153,6 +155,8 @@ static void kunit_run_case(struct kunit_suite *suite,
 	if (suite->exit)
 		suite->exit(&test);
 
+	kunit_cleanup(&test);
+
 	test_case->success = test.success;
 }
 
@@ -173,6 +177,165 @@ int kunit_run_tests(struct kunit_suite *suite)
 	return 0;
 }
 
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *context)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	ret = init(res, context);
+	if (ret)
+		return NULL;
+
+	res->free = free;
+	spin_lock(&test->lock);
+	list_add_tail(&res->node, &test->resources);
+	spin_unlock(&test->lock);
+
+	return res;
+}
+
+static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
+{
+	res->free(res);
+	kfree(res);
+}
+
+static struct kunit_resource *kunit_resource_find(struct kunit *test,
+						  kunit_resource_match_t match,
+						  kunit_resource_free_t free,
+						  void *match_data)
+{
+	struct kunit_resource *resource;
+
+	lockdep_assert_held(&test->lock);
+
+	list_for_each_entry_reverse(resource, &test->resources, node) {
+		if (resource->free != free)
+			continue;
+		if (match(test, resource->allocation, match_data))
+			return resource;
+	}
+
+	return NULL;
+}
+
+static struct kunit_resource *kunit_resource_remove(
+		struct kunit *test,
+		kunit_resource_match_t match,
+		kunit_resource_free_t free,
+		void *match_data)
+{
+	struct kunit_resource *resource;
+
+	spin_lock(&test->lock);
+	resource = kunit_resource_find(test, match, free, match_data);
+	if (resource)
+		list_del(&resource->node);
+	spin_unlock(&test->lock);
+
+	return resource;
+}
+
+int kunit_resource_destroy(struct kunit *test,
+			   kunit_resource_match_t match,
+			   kunit_resource_free_t free,
+			   void *match_data)
+{
+	struct kunit_resource *resource;
+
+	resource = kunit_resource_remove(test, match, free, match_data);
+
+	if (!resource)
+		return -ENOENT;
+
+	kunit_resource_free(test, resource);
+	return 0;
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
+	struct kunit_kmalloc_params params = {
+		.size = size,
+		.gfp = gfp
+	};
+
+	return kunit_alloc_resource(test,
+				    kunit_kmalloc_init,
+				    kunit_kmalloc_free,
+				    gfp,
+				    &params);
+}
+
+void kunit_kfree(struct kunit *test, const void *ptr)
+{
+	int rc;
+
+	rc = kunit_resource_destroy(test,
+				    kunit_resource_instance_match,
+				    kunit_kmalloc_free,
+				    (void *)ptr);
+
+	WARN_ON(rc);
+}
+
+void kunit_cleanup(struct kunit *test)
+{
+	struct kunit_resource *resource;
+
+	/*
+	 * test->resources is a stack - each allocation must be freed in the
+	 * reverse order from which it was added since one resource may depend
+	 * on another for its entire lifetime.
+	 * Also, we cannot use the normal list_for_each constructs, even the
+	 * safe ones because *arbitrary* nodes may be deleted when
+	 * kunit_resource_free is called; the list_for_each_safe variants only
+	 * protect against the current node being deleted, not the next.
+	 */
+	while (true) {
+		spin_lock(&test->lock);
+		if (list_empty(&test->resources)) {
+			spin_unlock(&test->lock);
+			break;
+		}
+		resource = list_last_entry(&test->resources,
+					   struct kunit_resource,
+					   node);
+		list_del(&resource->node);
+		spin_unlock(&test->lock);
+
+		kunit_resource_free(test, resource);
+	}
+}
+
 void kunit_printk(const char *level,
 		  const struct kunit *test,
 		  const char *fmt, ...)
-- 
2.23.0.351.gc4317032e6-goog

