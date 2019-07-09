Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01D63086
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 08:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfGIGdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 02:33:03 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45966 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIGdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:33:03 -0400
Received: by mail-pg1-f202.google.com with SMTP id n7so12067225pgr.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ic3smNwcHiaf2+e332OcS9f4hkMErHF1/7OHIGEcmHI=;
        b=fy9pkOZwj7UVsBTuEV3e1Y8jTWD/Ef50zM3WIjs57wHrH0SAslFTmQzqZaMWRk3J0d
         OtUWHFjtLHJxBsWbSmq+tk1UVxu0Vf2bA8GTrnh2SUor/KsUvIm07YaBmFMhkQF5s3+o
         lcO8EfaFp5WGzVrKamWXj+LwxFZbiqoQhhzOn9s/DnFS8TZot1U7bGr87Q5R/SExqY3b
         qIVNIw5Z4ZDfPg6ejrNS8unyGxe6mQbQ+At54/o+Fv48j+E+9/bZtGwq3EjIJhdrNtlO
         X1Q0Uy8y0qaRAwPQbbw/2DgVdwUiV0pNyIkZauq4CuZUECDAr3sDRgZI2RFEjLhB53my
         q6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ic3smNwcHiaf2+e332OcS9f4hkMErHF1/7OHIGEcmHI=;
        b=JMlfvgOM5zBFrKd5vlIahY74Yi1/8byCTMqTe4uvMj5+ObmC9R6tjEwXfG76jSIS/0
         iLECDawwQs/GJgjH7ly9JcTtf1U1lpkLoksoGP0Dcly76COAh0w42QfssdIYH2Pjuag7
         zaxsUU2G+u0Q21ILKYJjvrQaEUsckXPn6Y7ZaL9WeHyS3mCTRbzJ3QW/DGO1IQdtWn3B
         kRq+De6Vq2bPhnDKwwcBMBhvKtmRDIpjfEp77CrWchP55hK+0XrSuTjemdCvdCxPZqSL
         fjjc0XyJ8ud+k2S8lULKTEmezqZCkRp8luP2eB9WAcLMJL6nxEzD+Piu/+1XkOSu7FWL
         c1Sw==
X-Gm-Message-State: APjAAAXXwttdJC/SXuwrV8teY3Gdv71pgq4fzUu9HWQB7rEzIfQ7o8ru
        qj7gFeAV+RCVwfogll4ykgAlKVTHOj9y5UTFR/cXWQ==
X-Google-Smtp-Source: APXvYqySg7uvIFF3a1nVlJf8kZvvQTv4WJjYnjMp3jaZer3I39OEkk56iyIVupnXV0sHczMI23H94jI1fh5SWUz35wHjkg==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr28317812pgc.20.1562653982165;
 Mon, 08 Jul 2019 23:33:02 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:07 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 02/18] kunit: test: add test resource management API
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
 include/kunit/test.h | 116 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  94 +++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e0b34acb9ee4e..bdf41d31c343c 100644
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
 
@@ -109,6 +173,13 @@ struct kunit {
 	 * have terminated.
 	 */
 	bool success; /* Read only after test_case finishes! */
+	struct mutex lock; /* Gaurds all mutable test state. */
+	/*
+	 * Because resources is a list that may be updated multiple times (with
+	 * new resources) from any thread associated with a test case, we must
+	 * protect it with some type of lock.
+	 */
+	struct list_head resources; /* Protected by lock. */
 };
 
 void kunit_init_test(struct kunit *test, const char *name);
@@ -141,6 +212,51 @@ int kunit_run_tests(struct kunit_suite *suite);
 		}							       \
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
index 571e4c65deb5c..f165c9d8e10b0 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -122,6 +122,8 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
+	mutex_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->success = true;
 }
@@ -151,6 +153,8 @@ static void kunit_run_case(struct kunit_suite *suite,
 	if (suite->exit)
 		suite->exit(&test);
 
+	kunit_cleanup(&test);
+
 	test_case->success = test.success;
 }
 
@@ -171,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
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

