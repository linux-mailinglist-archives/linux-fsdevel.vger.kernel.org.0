Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764F6154FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 02:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGBTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 20:19:21 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45099 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGBTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:19:21 -0500
Received: by mail-pl1-f202.google.com with SMTP id 36so326617plc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 17:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WSkTYH/qWT84XO53laYF287sh7f0PYdSrVtYs695/ME=;
        b=etGfFsZrvuqCxQnAz1itlu2gz2ehbdu7fwB1coNIVcbc603NXZsN7NFQXBV6PRCP8Q
         qJwZUYazi0JLROBp2P5zWwINPrkHYIOvdjA0qZTR7wx0AgERZR3/XParuSrfUDbazpLw
         fS9M2X2T1emOAqBnyZqo+xaryOOxiZrOOqqtpRXORDbkcAMHwaQ5RxoderLBD+9ST4TY
         k5/ZxuEnv0Nd5QhZLGsj0O9DN9HOe/QW/rtN1eFJDTOdKhiJa+9HASwZpWnfYDC3frra
         ta8nHalglieIMSOau0VlAV1Z/qSZHfMco/RWIyPxarwA3gNbG2+4Fu7TuDpsS5zNTKCX
         Onbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WSkTYH/qWT84XO53laYF287sh7f0PYdSrVtYs695/ME=;
        b=RE8dqDMNuLkW7Ay1pnooi0jYjLn62eVry4dnMCPuQ61IAjvr2H6jYC2/Ce4WNDmobN
         MYxwW9AGUmpf6JyC9er52itE1c98g2ZOWR+l9yQ8CcRc7iSNQnSobEsRwQhz7bVhCpaV
         iX71Vl74/VABCtyi0BUWUv/K8ZvlRHi2h7SoJietNmcDwcHaveLspG4Af/cNo+883GEV
         2MdTB9WKwgTs5r8fPDFdsGgdbaKfortHwhcikEdvDmLKYAvc2fBEiSuhX4m1MvajIVsG
         b0WGxR8hhIw4JLkRVUE4CzDo/gyKZPsk+yOMVVMVL+8QZn05fbnprdvzpfyQhLnRYTxF
         SR6w==
X-Gm-Message-State: APjAAAUz3/JpRc43xwrIxw2OacRb2UPh7TjDMbt1Za1yr6b9IClfGEZD
        PwWNmnbrTj0OnnkgU4HUxy9DQ4BboYY0NIYjNzjq5Q==
X-Google-Smtp-Source: APXvYqwtImr8MdT8saaXuSX7c2cO9wEubjILO4l5rzl00050MheUos92Nhz5Dt7P2BgYzfEDb5nz2zqbfbeMF/daOQtFSA==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr6662737pgj.53.1581038359537;
 Thu, 06 Feb 2020 17:19:19 -0800 (PST)
Date:   Thu,  6 Feb 2020 17:18:17 -0800
Message-Id: <20200207011817.241830-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [RFC v1] xarray: start converting test_xarray to KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     willy@infradead.org, akpm@linux-foundation.org,
        changbin.du@intel.com, yamada.masahiro@socionext.com,
        rdunlap@infradead.org, skhan@linuxfoundation.org,
        davidgow@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xarray predates KUnit; however, it would be good to get all unit tests
in the kernel implemented using the same framework.

This initial conversion is a bit hacky as it doesn't switch everything
over to the KUnit semantics; however, it does break out the test cases
as KUnit test cases, and calls KUNIT_FAIL() when XA_BUG_ON() fails. So
the test does now take advantage of now reporting using the TAP format.

The reason I didn't convert everything over the KUnit semantics is that
I didn't want to get too far into this before getting some feedback from
Willy. I don't think there is anything I have made worse with the
changes I have made so far; this also at least serves as a starting
point.

TODO:
 - Convert tests to use KUnit semantics.
 - Figured out what to do with tools/testing/radix-tree/ xarray stuff.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/linux/xarray.h |    2 +-
 lib/Kconfig.debug      |    1 +
 lib/test_xarray.c      | 1228 +++++++++++++++++++++-------------------
 lib/xarray.c           |    4 +-
 4 files changed, 658 insertions(+), 577 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index f73e1775ded01..85cded5fd7917 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1140,7 +1140,7 @@ struct xa_node {
 void xa_dump(const struct xarray *);
 void xa_dump_node(const struct xa_node *);
 
-#ifdef XA_DEBUG
+#ifdef CONFIG_TEST_XARRAY
 #define XA_BUG_ON(xa, x) do {					\
 		if (x) {					\
 			xa_dump(xa);				\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df009..aa51269fb34f3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1893,6 +1893,7 @@ config TEST_UUID
 
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
+	depends on KUNIT
 
 config TEST_OVERFLOW
 	tristate "Test check_*_overflow() functions at runtime"
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 55c14e8c88591..6c4c545f7858d 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -8,26 +8,16 @@
 
 #include <linux/xarray.h>
 #include <linux/module.h>
+#include <kunit/test.h>
 
-static unsigned int tests_run;
-static unsigned int tests_passed;
-
-#ifndef XA_DEBUG
-# ifdef __KERNEL__
-void xa_dump(const struct xarray *xa) { }
-# endif
 #undef XA_BUG_ON
-#define XA_BUG_ON(xa, x) do {					\
-	tests_run++;						\
+#define XA_BUG_ON(test, xa, x) do {				\
 	if (x) {						\
-		printk("BUG at %s:%d\n", __func__, __LINE__);	\
+		KUNIT_FAIL(test, "");				\
 		xa_dump(xa);					\
 		dump_stack();					\
-	} else {						\
-		tests_passed++;					\
 	}							\
 } while (0)
-#endif
 
 static void *xa_mk_index(unsigned long index)
 {
@@ -39,25 +29,32 @@ static void *xa_store_index(struct xarray *xa, unsigned long index, gfp_t gfp)
 	return xa_store(xa, index, xa_mk_index(index), gfp);
 }
 
-static void xa_insert_index(struct xarray *xa, unsigned long index)
+static void xa_insert_index(struct kunit *test,
+			    struct xarray *xa,
+			    unsigned long index)
 {
-	XA_BUG_ON(xa, xa_insert(xa, index, xa_mk_index(index),
+	XA_BUG_ON(test, xa, xa_insert(xa, index, xa_mk_index(index),
 				GFP_KERNEL) != 0);
 }
 
-static void xa_alloc_index(struct xarray *xa, unsigned long index, gfp_t gfp)
+static void xa_alloc_index(struct kunit *test,
+			   struct xarray *xa,
+			   unsigned long index,
+			   gfp_t gfp)
 {
 	u32 id;
 
-	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(index), xa_limit_32b,
+	XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_index(index), xa_limit_32b,
 				gfp) != 0);
-	XA_BUG_ON(xa, id != index);
+	XA_BUG_ON(test, xa, id != index);
 }
 
-static void xa_erase_index(struct xarray *xa, unsigned long index)
+static void xa_erase_index(struct kunit *test,
+			   struct xarray *xa,
+			   unsigned long index)
 {
-	XA_BUG_ON(xa, xa_erase(xa, index) != xa_mk_index(index));
-	XA_BUG_ON(xa, xa_load(xa, index) != NULL);
+	XA_BUG_ON(test, xa, xa_erase(xa, index) != xa_mk_index(index));
+	XA_BUG_ON(test, xa, xa_load(xa, index) != NULL);
 }
 
 /*
@@ -80,24 +77,31 @@ static void *xa_store_order(struct xarray *xa, unsigned long index,
 	return curr;
 }
 
-static noinline void check_xa_err(struct xarray *xa)
+static noinline void check_xa_err(struct kunit *test)
 {
-	XA_BUG_ON(xa, xa_err(xa_store_index(xa, 0, GFP_NOWAIT)) != 0);
-	XA_BUG_ON(xa, xa_err(xa_erase(xa, 0)) != 0);
+	struct xarray *xa = test->priv;
+
+	XA_BUG_ON(test, xa, xa_err(xa_store_index(xa, 0, GFP_NOWAIT)) != 0);
+	XA_BUG_ON(test, xa, xa_err(xa_erase(xa, 0)) != 0);
 #ifndef __KERNEL__
 	/* The kernel does not fail GFP_NOWAIT allocations */
-	XA_BUG_ON(xa, xa_err(xa_store_index(xa, 1, GFP_NOWAIT)) != -ENOMEM);
-	XA_BUG_ON(xa, xa_err(xa_store_index(xa, 1, GFP_NOWAIT)) != -ENOMEM);
+	XA_BUG_ON(test, xa,
+		  xa_err(xa_store_index(xa, 1, GFP_NOWAIT)) != -ENOMEM);
+	XA_BUG_ON(test,
+		  xa, xa_err(xa_store_index(xa, 1, GFP_NOWAIT)) != -ENOMEM);
 #endif
-	XA_BUG_ON(xa, xa_err(xa_store_index(xa, 1, GFP_KERNEL)) != 0);
-	XA_BUG_ON(xa, xa_err(xa_store(xa, 1, xa_mk_value(0), GFP_KERNEL)) != 0);
-	XA_BUG_ON(xa, xa_err(xa_erase(xa, 1)) != 0);
+	XA_BUG_ON(test, xa, xa_err(xa_store_index(xa, 1, GFP_KERNEL)) != 0);
+	XA_BUG_ON(test, xa,
+		  xa_err(xa_store(xa, 1, xa_mk_value(0), GFP_KERNEL)) != 0);
+	XA_BUG_ON(test, xa, xa_err(xa_erase(xa, 1)) != 0);
 // kills the test-suite :-(
-//	XA_BUG_ON(xa, xa_err(xa_store(xa, 0, xa_mk_internal(0), 0)) != -EINVAL);
+//	XA_BUG_ON(test, xa,
+//		  xa_err(xa_store(xa, 0, xa_mk_internal(0), 0)) != -EINVAL);
 }
 
-static noinline void check_xas_retry(struct xarray *xa)
+static noinline void check_xas_retry(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	XA_STATE(xas, xa, 0);
 	void *entry;
 
@@ -105,23 +109,23 @@ static noinline void check_xas_retry(struct xarray *xa)
 	xa_store_index(xa, 1, GFP_KERNEL);
 
 	rcu_read_lock();
-	XA_BUG_ON(xa, xas_find(&xas, ULONG_MAX) != xa_mk_value(0));
-	xa_erase_index(xa, 1);
-	XA_BUG_ON(xa, !xa_is_retry(xas_reload(&xas)));
-	XA_BUG_ON(xa, xas_retry(&xas, NULL));
-	XA_BUG_ON(xa, xas_retry(&xas, xa_mk_value(0)));
+	XA_BUG_ON(test, xa, xas_find(&xas, ULONG_MAX) != xa_mk_value(0));
+	xa_erase_index(test, xa, 1);
+	XA_BUG_ON(test, xa, !xa_is_retry(xas_reload(&xas)));
+	XA_BUG_ON(test, xa, xas_retry(&xas, NULL));
+	XA_BUG_ON(test, xa, xas_retry(&xas, xa_mk_value(0)));
 	xas_reset(&xas);
-	XA_BUG_ON(xa, xas.xa_node != XAS_RESTART);
-	XA_BUG_ON(xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
-	XA_BUG_ON(xa, xas.xa_node != NULL);
+	XA_BUG_ON(test, xa, xas.xa_node != XAS_RESTART);
+	XA_BUG_ON(test, xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xas.xa_node != NULL);
 	rcu_read_unlock();
 
-	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
 
 	rcu_read_lock();
-	XA_BUG_ON(xa, !xa_is_internal(xas_reload(&xas)));
+	XA_BUG_ON(test, xa, !xa_is_internal(xas_reload(&xas)));
 	xas.xa_node = XAS_RESTART;
-	XA_BUG_ON(xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
 	rcu_read_unlock();
 
 	/* Make sure we can iterate through retry entries */
@@ -137,64 +141,67 @@ static noinline void check_xas_retry(struct xarray *xa)
 	}
 	xas_unlock(&xas);
 
-	xa_erase_index(xa, 0);
-	xa_erase_index(xa, 1);
+	xa_erase_index(test, xa, 0);
+	xa_erase_index(test, xa, 1);
 }
 
-static noinline void check_xa_load(struct xarray *xa)
+static noinline void check_xa_load(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned long i, j;
 
 	for (i = 0; i < 1024; i++) {
 		for (j = 0; j < 1024; j++) {
 			void *entry = xa_load(xa, j);
 			if (j < i)
-				XA_BUG_ON(xa, xa_to_value(entry) != j);
+				XA_BUG_ON(test, xa, xa_to_value(entry) != j);
 			else
-				XA_BUG_ON(xa, entry);
+				XA_BUG_ON(test, xa, entry);
 		}
-		XA_BUG_ON(xa, xa_store_index(xa, i, GFP_KERNEL) != NULL);
+		XA_BUG_ON(test, xa, xa_store_index(xa, i, GFP_KERNEL) != NULL);
 	}
 
 	for (i = 0; i < 1024; i++) {
 		for (j = 0; j < 1024; j++) {
 			void *entry = xa_load(xa, j);
 			if (j >= i)
-				XA_BUG_ON(xa, xa_to_value(entry) != j);
+				XA_BUG_ON(test, xa, xa_to_value(entry) != j);
 			else
-				XA_BUG_ON(xa, entry);
+				XA_BUG_ON(test, xa, entry);
 		}
-		xa_erase_index(xa, i);
+		xa_erase_index(test, xa, i);
 	}
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_xa_mark_1(struct xarray *xa, unsigned long index)
+static noinline void check_xa_mark_1(struct kunit *test,
+				     struct xarray *xa,
+				     unsigned long index)
 {
 	unsigned int order;
 	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 8 : 1;
 
 	/* NULL elements have no marks set */
-	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_0));
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index, XA_MARK_0));
 	xa_set_mark(xa, index, XA_MARK_0);
-	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_0));
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index, XA_MARK_0));
 
 	/* Storing a pointer will not make a mark appear */
-	XA_BUG_ON(xa, xa_store_index(xa, index, GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_0));
+	XA_BUG_ON(test, xa, xa_store_index(xa, index, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index, XA_MARK_0));
 	xa_set_mark(xa, index, XA_MARK_0);
-	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
+	XA_BUG_ON(test, xa, !xa_get_mark(xa, index, XA_MARK_0));
 
 	/* Setting one mark will not set another mark */
-	XA_BUG_ON(xa, xa_get_mark(xa, index + 1, XA_MARK_0));
-	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_1));
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index + 1, XA_MARK_0));
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index, XA_MARK_1));
 
 	/* Storing NULL clears marks, and they can't be set again */
-	xa_erase_index(xa, index);
-	XA_BUG_ON(xa, !xa_empty(xa));
-	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_0));
+	xa_erase_index(test, xa, index);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index, XA_MARK_0));
 	xa_set_mark(xa, index, XA_MARK_0);
-	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_0));
+	XA_BUG_ON(test, xa, xa_get_mark(xa, index, XA_MARK_0));
 
 	/*
 	 * Storing a multi-index entry over entries with marks gives the
@@ -206,11 +213,11 @@ static noinline void check_xa_mark_1(struct xarray *xa, unsigned long index)
 		unsigned long next = base + (1UL << order);
 		unsigned long i;
 
-		XA_BUG_ON(xa, xa_store_index(xa, index + 1, GFP_KERNEL));
+		XA_BUG_ON(test, xa, xa_store_index(xa, index + 1, GFP_KERNEL));
 		xa_set_mark(xa, index + 1, XA_MARK_0);
-		XA_BUG_ON(xa, xa_store_index(xa, index + 2, GFP_KERNEL));
+		XA_BUG_ON(test, xa, xa_store_index(xa, index + 2, GFP_KERNEL));
 		xa_set_mark(xa, index + 2, XA_MARK_2);
-		XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL));
+		XA_BUG_ON(test, xa, xa_store_index(xa, next, GFP_KERNEL));
 		xa_store_order(xa, index, order, xa_mk_index(index),
 				GFP_KERNEL);
 		for (i = base; i < next; i++) {
@@ -218,16 +225,16 @@ static noinline void check_xa_mark_1(struct xarray *xa, unsigned long index)
 			unsigned int seen = 0;
 			void *entry;
 
-			XA_BUG_ON(xa, !xa_get_mark(xa, i, XA_MARK_0));
-			XA_BUG_ON(xa, xa_get_mark(xa, i, XA_MARK_1));
-			XA_BUG_ON(xa, !xa_get_mark(xa, i, XA_MARK_2));
+			XA_BUG_ON(test, xa, !xa_get_mark(xa, i, XA_MARK_0));
+			XA_BUG_ON(test, xa, xa_get_mark(xa, i, XA_MARK_1));
+			XA_BUG_ON(test, xa, !xa_get_mark(xa, i, XA_MARK_2));
 
 			/* We should see two elements in the array */
 			rcu_read_lock();
 			xas_for_each(&xas, entry, ULONG_MAX)
 				seen++;
 			rcu_read_unlock();
-			XA_BUG_ON(xa, seen != 2);
+			XA_BUG_ON(test, xa, seen != 2);
 
 			/* One of which is marked */
 			xas_set(&xas, 0);
@@ -236,19 +243,19 @@ static noinline void check_xa_mark_1(struct xarray *xa, unsigned long index)
 			xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_0)
 				seen++;
 			rcu_read_unlock();
-			XA_BUG_ON(xa, seen != 1);
+			XA_BUG_ON(test, xa, seen != 1);
 		}
-		XA_BUG_ON(xa, xa_get_mark(xa, next, XA_MARK_0));
-		XA_BUG_ON(xa, xa_get_mark(xa, next, XA_MARK_1));
-		XA_BUG_ON(xa, xa_get_mark(xa, next, XA_MARK_2));
-		xa_erase_index(xa, index);
-		xa_erase_index(xa, next);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		XA_BUG_ON(test, xa, xa_get_mark(xa, next, XA_MARK_0));
+		XA_BUG_ON(test, xa, xa_get_mark(xa, next, XA_MARK_1));
+		XA_BUG_ON(test, xa, xa_get_mark(xa, next, XA_MARK_2));
+		xa_erase_index(test, xa, index);
+		xa_erase_index(test, xa, next);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 	}
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_xa_mark_2(struct xarray *xa)
+static noinline void check_xa_mark_2(struct kunit *test, struct xarray *xa)
 {
 	XA_STATE(xas, xa, 0);
 	unsigned long index;
@@ -261,7 +268,7 @@ static noinline void check_xa_mark_2(struct xarray *xa)
 	xas_load(&xas);
 	xas_init_marks(&xas);
 	xas_unlock(&xas);
-	XA_BUG_ON(xa, !xa_get_mark(xa, 0, XA_MARK_0) == 0);
+	XA_BUG_ON(test, xa, !xa_get_mark(xa, 0, XA_MARK_0) == 0);
 
 	for (index = 3500; index < 4500; index++) {
 		xa_store_index(xa, index, GFP_KERNEL);
@@ -273,196 +280,213 @@ static noinline void check_xa_mark_2(struct xarray *xa)
 	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_0)
 		count++;
 	rcu_read_unlock();
-	XA_BUG_ON(xa, count != 1000);
+	XA_BUG_ON(test, xa, count != 1000);
 
 	xas_lock(&xas);
 	xas_for_each(&xas, entry, ULONG_MAX) {
 		xas_init_marks(&xas);
-		XA_BUG_ON(xa, !xa_get_mark(xa, xas.xa_index, XA_MARK_0));
-		XA_BUG_ON(xa, !xas_get_mark(&xas, XA_MARK_0));
+		XA_BUG_ON(test, xa, !xa_get_mark(xa, xas.xa_index, XA_MARK_0));
+		XA_BUG_ON(test, xa, !xas_get_mark(&xas, XA_MARK_0));
 	}
 	xas_unlock(&xas);
 
 	xa_destroy(xa);
 }
 
-static noinline void check_xa_mark(struct xarray *xa)
+static noinline void check_xa_mark(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned long index;
 
 	for (index = 0; index < 16384; index += 4)
-		check_xa_mark_1(xa, index);
+		check_xa_mark_1(test, xa, index);
 
-	check_xa_mark_2(xa);
+	check_xa_mark_2(test, xa);
 }
 
-static noinline void check_xa_shrink(struct xarray *xa)
+static noinline void check_xa_shrink(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	XA_STATE(xas, xa, 1);
 	struct xa_node *node;
 	unsigned int order;
 	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 15 : 1;
 
-	XA_BUG_ON(xa, !xa_empty(xa));
-	XA_BUG_ON(xa, xa_store_index(xa, 0, GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_store_index(xa, 0, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
 
 	/*
 	 * Check that erasing the entry at 1 shrinks the tree and properly
 	 * marks the node as being deleted.
 	 */
 	xas_lock(&xas);
-	XA_BUG_ON(xa, xas_load(&xas) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xas_load(&xas) != xa_mk_value(1));
 	node = xas.xa_node;
-	XA_BUG_ON(xa, xa_entry_locked(xa, node, 0) != xa_mk_value(0));
-	XA_BUG_ON(xa, xas_store(&xas, NULL) != xa_mk_value(1));
-	XA_BUG_ON(xa, xa_load(xa, 1) != NULL);
-	XA_BUG_ON(xa, xas.xa_node != XAS_BOUNDS);
-	XA_BUG_ON(xa, xa_entry_locked(xa, node, 0) != XA_RETRY_ENTRY);
-	XA_BUG_ON(xa, xas_load(&xas) != NULL);
+	XA_BUG_ON(test, xa, xa_entry_locked(xa, node, 0) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xas_store(&xas, NULL) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xa_load(xa, 1) != NULL);
+	XA_BUG_ON(test, xa, xas.xa_node != XAS_BOUNDS);
+	XA_BUG_ON(test, xa, xa_entry_locked(xa, node, 0) != XA_RETRY_ENTRY);
+	XA_BUG_ON(test, xa, xas_load(&xas) != NULL);
 	xas_unlock(&xas);
-	XA_BUG_ON(xa, xa_load(xa, 0) != xa_mk_value(0));
-	xa_erase_index(xa, 0);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_load(xa, 0) != xa_mk_value(0));
+	xa_erase_index(test, xa, 0);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	for (order = 0; order < max_order; order++) {
 		unsigned long max = (1UL << order) - 1;
 		xa_store_order(xa, 0, order, xa_mk_value(0), GFP_KERNEL);
-		XA_BUG_ON(xa, xa_load(xa, max) != xa_mk_value(0));
-		XA_BUG_ON(xa, xa_load(xa, max + 1) != NULL);
+		XA_BUG_ON(test, xa, xa_load(xa, max) != xa_mk_value(0));
+		XA_BUG_ON(test, xa, xa_load(xa, max + 1) != NULL);
 		rcu_read_lock();
 		node = xa_head(xa);
 		rcu_read_unlock();
-		XA_BUG_ON(xa, xa_store_index(xa, ULONG_MAX, GFP_KERNEL) !=
+		XA_BUG_ON(test, xa, xa_store_index(xa, ULONG_MAX, GFP_KERNEL) !=
 				NULL);
 		rcu_read_lock();
-		XA_BUG_ON(xa, xa_head(xa) == node);
+		XA_BUG_ON(test, xa, xa_head(xa) == node);
 		rcu_read_unlock();
-		XA_BUG_ON(xa, xa_load(xa, max + 1) != NULL);
-		xa_erase_index(xa, ULONG_MAX);
-		XA_BUG_ON(xa, xa->xa_head != node);
-		xa_erase_index(xa, 0);
+		XA_BUG_ON(test, xa, xa_load(xa, max + 1) != NULL);
+		xa_erase_index(test, xa, ULONG_MAX);
+		XA_BUG_ON(test, xa, xa->xa_head != node);
+		xa_erase_index(test, xa, 0);
 	}
 }
 
-static noinline void check_insert(struct xarray *xa)
+static noinline void check_insert(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned long i;
 
 	for (i = 0; i < 1024; i++) {
-		xa_insert_index(xa, i);
-		XA_BUG_ON(xa, xa_load(xa, i - 1) != NULL);
-		XA_BUG_ON(xa, xa_load(xa, i + 1) != NULL);
-		xa_erase_index(xa, i);
+		xa_insert_index(test, xa, i);
+		XA_BUG_ON(test, xa, xa_load(xa, i - 1) != NULL);
+		XA_BUG_ON(test, xa, xa_load(xa, i + 1) != NULL);
+		xa_erase_index(test, xa, i);
 	}
 
 	for (i = 10; i < BITS_PER_LONG; i++) {
-		xa_insert_index(xa, 1UL << i);
-		XA_BUG_ON(xa, xa_load(xa, (1UL << i) - 1) != NULL);
-		XA_BUG_ON(xa, xa_load(xa, (1UL << i) + 1) != NULL);
-		xa_erase_index(xa, 1UL << i);
-
-		xa_insert_index(xa, (1UL << i) - 1);
-		XA_BUG_ON(xa, xa_load(xa, (1UL << i) - 2) != NULL);
-		XA_BUG_ON(xa, xa_load(xa, 1UL << i) != NULL);
-		xa_erase_index(xa, (1UL << i) - 1);
+		xa_insert_index(test, xa, 1UL << i);
+		XA_BUG_ON(test, xa, xa_load(xa, (1UL << i) - 1) != NULL);
+		XA_BUG_ON(test, xa, xa_load(xa, (1UL << i) + 1) != NULL);
+		xa_erase_index(test, xa, 1UL << i);
+
+		xa_insert_index(test, xa, (1UL << i) - 1);
+		XA_BUG_ON(test, xa, xa_load(xa, (1UL << i) - 2) != NULL);
+		XA_BUG_ON(test, xa, xa_load(xa, 1UL << i) != NULL);
+		xa_erase_index(test, xa, (1UL << i) - 1);
 	}
 
-	xa_insert_index(xa, ~0UL);
-	XA_BUG_ON(xa, xa_load(xa, 0UL) != NULL);
-	XA_BUG_ON(xa, xa_load(xa, ~1UL) != NULL);
-	xa_erase_index(xa, ~0UL);
+	xa_insert_index(test, xa, ~0UL);
+	XA_BUG_ON(test, xa, xa_load(xa, 0UL) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, ~1UL) != NULL);
+	xa_erase_index(test, xa, ~0UL);
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_cmpxchg(struct xarray *xa)
+static noinline void check_cmpxchg(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	void *FIVE = xa_mk_value(5);
 	void *SIX = xa_mk_value(6);
 	void *LOTS = xa_mk_value(12345678);
 
-	XA_BUG_ON(xa, !xa_empty(xa));
-	XA_BUG_ON(xa, xa_store_index(xa, 12345678, GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_insert(xa, 12345678, xa, GFP_KERNEL) != -EBUSY);
-	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, SIX, FIVE, GFP_KERNEL) != LOTS);
-	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, LOTS, FIVE, GFP_KERNEL) != LOTS);
-	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, FIVE, LOTS, GFP_KERNEL) != FIVE);
-	XA_BUG_ON(xa, xa_cmpxchg(xa, 5, FIVE, NULL, GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_cmpxchg(xa, 5, NULL, FIVE, GFP_KERNEL) != NULL);
-	xa_erase_index(xa, 12345678);
-	xa_erase_index(xa, 5);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_store_index(xa, 12345678, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_insert(xa, 12345678, xa, GFP_KERNEL) != -EBUSY);
+	XA_BUG_ON(test, xa,
+		  xa_cmpxchg(xa, 12345678, SIX, FIVE, GFP_KERNEL) != LOTS);
+	XA_BUG_ON(test, xa,
+		  xa_cmpxchg(xa, 12345678, LOTS, FIVE, GFP_KERNEL) != LOTS);
+	XA_BUG_ON(test, xa,
+		  xa_cmpxchg(xa, 12345678, FIVE, LOTS, GFP_KERNEL) != FIVE);
+	XA_BUG_ON(test, xa, xa_cmpxchg(xa, 5, FIVE, NULL, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_cmpxchg(xa, 5, NULL, FIVE, GFP_KERNEL) != NULL);
+	xa_erase_index(test, xa, 12345678);
+	xa_erase_index(test, xa, 5);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_reserve(struct xarray *xa)
+static noinline void check_reserve(struct kunit *test, struct xarray *xa)
 {
 	void *entry;
 	unsigned long index;
 	int count;
 
 	/* An array with a reserved entry is not empty */
-	XA_BUG_ON(xa, !xa_empty(xa));
-	XA_BUG_ON(xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, xa_empty(xa));
-	XA_BUG_ON(xa, xa_load(xa, 12345678));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_load(xa, 12345678));
 	xa_release(xa, 12345678);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* Releasing a used entry does nothing */
-	XA_BUG_ON(xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, xa_store_index(xa, 12345678, GFP_NOWAIT) != NULL);
+	XA_BUG_ON(test, xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, xa_store_index(xa, 12345678, GFP_NOWAIT) != NULL);
 	xa_release(xa, 12345678);
-	xa_erase_index(xa, 12345678);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, 12345678);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* cmpxchg sees a reserved entry as ZERO */
-	XA_BUG_ON(xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, XA_ZERO_ENTRY,
+	XA_BUG_ON(test, xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, xa_cmpxchg(xa, 12345678, XA_ZERO_ENTRY,
 				xa_mk_value(12345678), GFP_NOWAIT) != NULL);
 	xa_release(xa, 12345678);
-	xa_erase_index(xa, 12345678);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, 12345678);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* xa_insert treats it as busy */
-	XA_BUG_ON(xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, xa_insert(xa, 12345678, xa_mk_value(12345678), 0) !=
+	XA_BUG_ON(test, xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, xa_insert(xa, 12345678, xa_mk_value(12345678), 0) !=
 			-EBUSY);
-	XA_BUG_ON(xa, xa_empty(xa));
-	XA_BUG_ON(xa, xa_erase(xa, 12345678) != NULL);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_erase(xa, 12345678) != NULL);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* Can iterate through a reserved entry */
 	xa_store_index(xa, 5, GFP_KERNEL);
-	XA_BUG_ON(xa, xa_reserve(xa, 6, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, xa_reserve(xa, 6, GFP_KERNEL) != 0);
 	xa_store_index(xa, 7, GFP_KERNEL);
 
 	count = 0;
 	xa_for_each(xa, index, entry) {
-		XA_BUG_ON(xa, index != 5 && index != 7);
+		XA_BUG_ON(test, xa, index != 5 && index != 7);
 		count++;
 	}
-	XA_BUG_ON(xa, count != 2);
+	XA_BUG_ON(test, xa, count != 2);
 
 	/* If we free a reserved entry, we should be able to allocate it */
 	if (xa->xa_flags & XA_FLAGS_ALLOC) {
 		u32 id;
 
-		XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_value(8),
+		XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_value(8),
 					XA_LIMIT(5, 10), GFP_KERNEL) != 0);
-		XA_BUG_ON(xa, id != 8);
+		XA_BUG_ON(test, xa, id != 8);
 
 		xa_release(xa, 6);
-		XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_value(6),
+		XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_value(6),
 					XA_LIMIT(5, 10), GFP_KERNEL) != 0);
-		XA_BUG_ON(xa, id != 6);
+		XA_BUG_ON(test, xa, id != 6);
 	}
 
 	xa_destroy(xa);
 }
 
-static noinline void check_xas_erase(struct xarray *xa)
+static void check_reserve_all(struct kunit *test)
+{
+	struct xarray *xa = test->priv;
+	DEFINE_XARRAY_ALLOC(xa0);
+
+	check_reserve(test, xa);
+	check_reserve(test, &xa0);
+}
+
+static noinline void check_xas_erase(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	XA_STATE(xas, xa, 0);
 	void *entry;
 	unsigned long i, j;
@@ -490,12 +514,12 @@ static noinline void check_xas_erase(struct xarray *xa)
 		xas_set(&xas, 0);
 		j = i;
 		xas_for_each(&xas, entry, ULONG_MAX) {
-			XA_BUG_ON(xa, entry != xa_mk_index(j));
+			XA_BUG_ON(test, xa, entry != xa_mk_index(j));
 			xas_store(&xas, NULL);
 			j++;
 		}
 		xas_unlock(&xas);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 	}
 }
 
@@ -508,21 +532,22 @@ static noinline void check_multi_store_1(struct xarray *xa, unsigned long index,
 	unsigned long max = min + (1UL << order);
 
 	xa_store_order(xa, index, order, xa_mk_index(index), GFP_KERNEL);
-	XA_BUG_ON(xa, xa_load(xa, min) != xa_mk_index(index));
-	XA_BUG_ON(xa, xa_load(xa, max - 1) != xa_mk_index(index));
-	XA_BUG_ON(xa, xa_load(xa, max) != NULL);
-	XA_BUG_ON(xa, xa_load(xa, min - 1) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, min) != xa_mk_index(index));
+	XA_BUG_ON(test, xa, xa_load(xa, max - 1) != xa_mk_index(index));
+	XA_BUG_ON(test, xa, xa_load(xa, max) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, min - 1) != NULL);
 
 	xas_lock(&xas);
-	XA_BUG_ON(xa, xas_store(&xas, xa_mk_index(min)) != xa_mk_index(index));
+	XA_BUG_ON(test, xa,
+		  xas_store(&xas, xa_mk_index(min)) != xa_mk_index(index));
 	xas_unlock(&xas);
-	XA_BUG_ON(xa, xa_load(xa, min) != xa_mk_index(min));
-	XA_BUG_ON(xa, xa_load(xa, max - 1) != xa_mk_index(min));
-	XA_BUG_ON(xa, xa_load(xa, max) != NULL);
-	XA_BUG_ON(xa, xa_load(xa, min - 1) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, min) != xa_mk_index(min));
+	XA_BUG_ON(test, xa, xa_load(xa, max - 1) != xa_mk_index(min));
+	XA_BUG_ON(test, xa, xa_load(xa, max) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, min - 1) != NULL);
 
-	xa_erase_index(xa, min);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, min);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
 static noinline void check_multi_store_2(struct xarray *xa, unsigned long index,
@@ -532,11 +557,11 @@ static noinline void check_multi_store_2(struct xarray *xa, unsigned long index,
 	xa_store_order(xa, index, order, xa_mk_value(0), GFP_KERNEL);
 
 	xas_lock(&xas);
-	XA_BUG_ON(xa, xas_store(&xas, xa_mk_value(1)) != xa_mk_value(0));
-	XA_BUG_ON(xa, xas.xa_index != index);
-	XA_BUG_ON(xa, xas_store(&xas, NULL) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xas_store(&xas, xa_mk_value(1)) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xas.xa_index != index);
+	XA_BUG_ON(test, xa, xas_store(&xas, NULL) != xa_mk_value(1));
 	xas_unlock(&xas);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
 static noinline void check_multi_store_3(struct xarray *xa, unsigned long index,
@@ -550,69 +575,70 @@ static noinline void check_multi_store_3(struct xarray *xa, unsigned long index,
 
 	xas_lock(&xas);
 	xas_for_each(&xas, entry, ULONG_MAX) {
-		XA_BUG_ON(xa, entry != xa_mk_index(index));
+		XA_BUG_ON(test, xa, entry != xa_mk_index(index));
 		n++;
 	}
-	XA_BUG_ON(xa, n != 1);
+	XA_BUG_ON(test, xa, n != 1);
 	xas_set(&xas, index + 1);
 	xas_for_each(&xas, entry, ULONG_MAX) {
-		XA_BUG_ON(xa, entry != xa_mk_index(index));
+		XA_BUG_ON(test, xa, entry != xa_mk_index(index));
 		n++;
 	}
-	XA_BUG_ON(xa, n != 2);
+	XA_BUG_ON(test, xa, n != 2);
 	xas_unlock(&xas);
 
 	xa_destroy(xa);
 }
 #endif
 
-static noinline void check_multi_store(struct xarray *xa)
+static noinline void check_multi_store(struct kunit *test)
 {
 #ifdef CONFIG_XARRAY_MULTI
+	struct xarray *xa = test->priv;
 	unsigned long i, j, k;
 	unsigned int max_order = (sizeof(long) == 4) ? 30 : 60;
 
 	/* Loading from any position returns the same value */
 	xa_store_order(xa, 0, 1, xa_mk_value(0), GFP_KERNEL);
-	XA_BUG_ON(xa, xa_load(xa, 0) != xa_mk_value(0));
-	XA_BUG_ON(xa, xa_load(xa, 1) != xa_mk_value(0));
-	XA_BUG_ON(xa, xa_load(xa, 2) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, 0) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xa_load(xa, 1) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xa_load(xa, 2) != NULL);
 	rcu_read_lock();
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 2);
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 2);
+	XA_BUG_ON(test, xa, xa_to_node(xa_head(xa))->count != 2);
+	XA_BUG_ON(test, xa, xa_to_node(xa_head(xa))->nr_values != 2);
 	rcu_read_unlock();
 
 	/* Storing adjacent to the value does not alter the value */
 	xa_store(xa, 3, xa, GFP_KERNEL);
-	XA_BUG_ON(xa, xa_load(xa, 0) != xa_mk_value(0));
-	XA_BUG_ON(xa, xa_load(xa, 1) != xa_mk_value(0));
-	XA_BUG_ON(xa, xa_load(xa, 2) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, 0) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xa_load(xa, 1) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xa_load(xa, 2) != NULL);
 	rcu_read_lock();
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 3);
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 2);
+	XA_BUG_ON(test, xa, xa_to_node(xa_head(xa))->count != 3);
+	XA_BUG_ON(test, xa, xa_to_node(xa_head(xa))->nr_values != 2);
 	rcu_read_unlock();
 
 	/* Overwriting multiple indexes works */
 	xa_store_order(xa, 0, 2, xa_mk_value(1), GFP_KERNEL);
-	XA_BUG_ON(xa, xa_load(xa, 0) != xa_mk_value(1));
-	XA_BUG_ON(xa, xa_load(xa, 1) != xa_mk_value(1));
-	XA_BUG_ON(xa, xa_load(xa, 2) != xa_mk_value(1));
-	XA_BUG_ON(xa, xa_load(xa, 3) != xa_mk_value(1));
-	XA_BUG_ON(xa, xa_load(xa, 4) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, 0) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xa_load(xa, 1) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xa_load(xa, 2) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xa_load(xa, 3) != xa_mk_value(1));
+	XA_BUG_ON(test, xa, xa_load(xa, 4) != NULL);
 	rcu_read_lock();
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 4);
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 4);
+	XA_BUG_ON(test, xa, xa_to_node(xa_head(xa))->count != 4);
+	XA_BUG_ON(test, xa, xa_to_node(xa_head(xa))->nr_values != 4);
 	rcu_read_unlock();
 
 	/* We can erase multiple values with a single store */
 	xa_store_order(xa, 0, BITS_PER_LONG - 1, NULL, GFP_KERNEL);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* Even when the first slot is empty but the others aren't */
 	xa_store_index(xa, 1, GFP_KERNEL);
 	xa_store_index(xa, 2, GFP_KERNEL);
 	xa_store_order(xa, 0, 2, NULL, GFP_KERNEL);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	for (i = 0; i < max_order; i++) {
 		for (j = 0; j < max_order; j++) {
@@ -622,13 +648,14 @@ static noinline void check_multi_store(struct xarray *xa)
 			for (k = 0; k < max_order; k++) {
 				void *entry = xa_load(xa, (1UL << k) - 1);
 				if ((i < k) && (j < k))
-					XA_BUG_ON(xa, entry != NULL);
+					XA_BUG_ON(test, xa, entry != NULL);
 				else
-					XA_BUG_ON(xa, entry != xa_mk_index(j));
+					XA_BUG_ON(test,
+						  xa, entry != xa_mk_index(j));
 			}
 
 			xa_erase(xa, 0);
-			XA_BUG_ON(xa, !xa_empty(xa));
+			XA_BUG_ON(test, xa, !xa_empty(xa));
 		}
 	}
 
@@ -646,133 +673,142 @@ static noinline void check_multi_store(struct xarray *xa)
 #endif
 }
 
-static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base)
+static noinline void check_xa_alloc_1(struct kunit *test, struct xarray *xa,
+				      unsigned int base)
 {
 	int i;
 	u32 id;
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 	/* An empty array should assign %base to the first alloc */
-	xa_alloc_index(xa, base, GFP_KERNEL);
+	xa_alloc_index(test, xa, base, GFP_KERNEL);
 
 	/* Erasing it should make the array empty again */
-	xa_erase_index(xa, base);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, base);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* And it should assign %base again */
-	xa_alloc_index(xa, base, GFP_KERNEL);
+	xa_alloc_index(test, xa, base, GFP_KERNEL);
 
 	/* Allocating and then erasing a lot should not lose base */
 	for (i = base + 1; i < 2 * XA_CHUNK_SIZE; i++)
-		xa_alloc_index(xa, i, GFP_KERNEL);
+		xa_alloc_index(test, xa, i, GFP_KERNEL);
 	for (i = base; i < 2 * XA_CHUNK_SIZE; i++)
-		xa_erase_index(xa, i);
-	xa_alloc_index(xa, base, GFP_KERNEL);
+		xa_erase_index(test, xa, i);
+	xa_alloc_index(test, xa, base, GFP_KERNEL);
 
 	/* Destroying the array should do the same as erasing */
 	xa_destroy(xa);
 
 	/* And it should assign %base again */
-	xa_alloc_index(xa, base, GFP_KERNEL);
+	xa_alloc_index(test, xa, base, GFP_KERNEL);
 
 	/* The next assigned ID should be base+1 */
-	xa_alloc_index(xa, base + 1, GFP_KERNEL);
-	xa_erase_index(xa, base + 1);
+	xa_alloc_index(test, xa, base + 1, GFP_KERNEL);
+	xa_erase_index(test, xa, base + 1);
 
 	/* Storing a value should mark it used */
 	xa_store_index(xa, base + 1, GFP_KERNEL);
-	xa_alloc_index(xa, base + 2, GFP_KERNEL);
+	xa_alloc_index(test, xa, base + 2, GFP_KERNEL);
 
 	/* If we then erase base, it should be free */
-	xa_erase_index(xa, base);
-	xa_alloc_index(xa, base, GFP_KERNEL);
+	xa_erase_index(test, xa, base);
+	xa_alloc_index(test, xa, base, GFP_KERNEL);
 
-	xa_erase_index(xa, base + 1);
-	xa_erase_index(xa, base + 2);
+	xa_erase_index(test, xa, base + 1);
+	xa_erase_index(test, xa, base + 2);
 
 	for (i = 1; i < 5000; i++) {
-		xa_alloc_index(xa, base + i, GFP_KERNEL);
+		xa_alloc_index(test, xa, base + i, GFP_KERNEL);
 	}
 
 	xa_destroy(xa);
 
 	/* Check that we fail properly at the limit of allocation */
-	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(UINT_MAX - 1),
+	XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_index(UINT_MAX - 1),
 				XA_LIMIT(UINT_MAX - 1, UINT_MAX),
 				GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != 0xfffffffeU);
-	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(UINT_MAX),
+	XA_BUG_ON(test, xa, id != 0xfffffffeU);
+	XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_index(UINT_MAX),
 				XA_LIMIT(UINT_MAX - 1, UINT_MAX),
 				GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != 0xffffffffU);
+	XA_BUG_ON(test, xa, id != 0xffffffffU);
 	id = 3;
-	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(0),
+	XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_index(0),
 				XA_LIMIT(UINT_MAX - 1, UINT_MAX),
 				GFP_KERNEL) != -EBUSY);
-	XA_BUG_ON(xa, id != 3);
+	XA_BUG_ON(test, xa, id != 3);
 	xa_destroy(xa);
 
-	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
+	XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
-	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
+	XA_BUG_ON(test, xa, xa_store_index(xa, 3, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
-	xa_erase_index(xa, 3);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, 3);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_xa_alloc_2(struct xarray *xa, unsigned int base)
+static noinline void check_xa_alloc_2(struct kunit *test, struct xarray *xa,
+				      unsigned int base)
 {
 	unsigned int i, id;
 	unsigned long index;
 	void *entry;
 
 	/* Allocate and free a NULL and check xa_empty() behaves */
-	XA_BUG_ON(xa, !xa_empty(xa));
-	XA_BUG_ON(xa, xa_alloc(xa, &id, NULL, xa_limit_32b, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != base);
-	XA_BUG_ON(xa, xa_empty(xa));
-	XA_BUG_ON(xa, xa_erase(xa, id) != NULL);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa,
+		  xa_alloc(xa, &id, NULL, xa_limit_32b, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, id != base);
+	XA_BUG_ON(test, xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_erase(xa, id) != NULL);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* Ditto, but check destroy instead of erase */
-	XA_BUG_ON(xa, !xa_empty(xa));
-	XA_BUG_ON(xa, xa_alloc(xa, &id, NULL, xa_limit_32b, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != base);
-	XA_BUG_ON(xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa,
+		  xa_alloc(xa, &id, NULL, xa_limit_32b, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, id != base);
+	XA_BUG_ON(test, xa, xa_empty(xa));
 	xa_destroy(xa);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	for (i = base; i < base + 10; i++) {
-		XA_BUG_ON(xa, xa_alloc(xa, &id, NULL, xa_limit_32b,
+		XA_BUG_ON(test, xa, xa_alloc(xa, &id, NULL, xa_limit_32b,
 					GFP_KERNEL) != 0);
-		XA_BUG_ON(xa, id != i);
+		XA_BUG_ON(test, xa, id != i);
 	}
 
-	XA_BUG_ON(xa, xa_store(xa, 3, xa_mk_index(3), GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_store(xa, 4, xa_mk_index(4), GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_store(xa, 4, NULL, GFP_KERNEL) != xa_mk_index(4));
-	XA_BUG_ON(xa, xa_erase(xa, 5) != NULL);
-	XA_BUG_ON(xa, xa_alloc(xa, &id, NULL, xa_limit_32b, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != 5);
+	XA_BUG_ON(test, xa,
+		  xa_store(xa, 3, xa_mk_index(3), GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa,
+		  xa_store(xa, 4, xa_mk_index(4), GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa,
+		  xa_store(xa, 4, NULL, GFP_KERNEL) != xa_mk_index(4));
+	XA_BUG_ON(test, xa, xa_erase(xa, 5) != NULL);
+	XA_BUG_ON(test, xa,
+		  xa_alloc(xa, &id, NULL, xa_limit_32b, GFP_KERNEL) != 0);
+	XA_BUG_ON(test, xa, id != 5);
 
 	xa_for_each(xa, index, entry) {
-		xa_erase_index(xa, index);
+		xa_erase_index(test, xa, index);
 	}
 
 	for (i = base; i < base + 9; i++) {
-		XA_BUG_ON(xa, xa_erase(xa, i) != NULL);
-		XA_BUG_ON(xa, xa_empty(xa));
+		XA_BUG_ON(test, xa, xa_erase(xa, i) != NULL);
+		XA_BUG_ON(test, xa, xa_empty(xa));
 	}
-	XA_BUG_ON(xa, xa_erase(xa, 8) != NULL);
-	XA_BUG_ON(xa, xa_empty(xa));
-	XA_BUG_ON(xa, xa_erase(xa, base + 9) != NULL);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_erase(xa, 8) != NULL);
+	XA_BUG_ON(test, xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_erase(xa, base + 9) != NULL);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	xa_destroy(xa);
 }
 
-static noinline void check_xa_alloc_3(struct xarray *xa, unsigned int base)
+static noinline void check_xa_alloc_3(struct kunit *test, struct xarray *xa,
+				      unsigned int base)
 {
 	struct xa_limit limit = XA_LIMIT(1, 0x3fff);
 	u32 next = 0;
@@ -780,64 +816,67 @@ static noinline void check_xa_alloc_3(struct xarray *xa, unsigned int base)
 	unsigned long index;
 	void *entry;
 
-	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(1), limit,
+	XA_BUG_ON(test, xa, xa_alloc_cyclic(xa, &id, xa_mk_index(1), limit,
 				&next, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != 1);
+	XA_BUG_ON(test, xa, id != 1);
 
 	next = 0x3ffd;
-	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(0x3ffd), limit,
+	XA_BUG_ON(test, xa, xa_alloc_cyclic(xa, &id, xa_mk_index(0x3ffd), limit,
 				&next, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != 0x3ffd);
-	xa_erase_index(xa, 0x3ffd);
-	xa_erase_index(xa, 1);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, id != 0x3ffd);
+	xa_erase_index(test, xa, 0x3ffd);
+	xa_erase_index(test, xa, 1);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	for (i = 0x3ffe; i < 0x4003; i++) {
 		if (i < 0x4000)
 			entry = xa_mk_index(i);
 		else
 			entry = xa_mk_index(i - 0x3fff);
-		XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, entry, limit,
+		XA_BUG_ON(test, xa, xa_alloc_cyclic(xa, &id, entry, limit,
 					&next, GFP_KERNEL) != (id == 1));
-		XA_BUG_ON(xa, xa_mk_index(id) != entry);
+		XA_BUG_ON(test, xa, xa_mk_index(id) != entry);
 	}
 
 	/* Check wrap-around is handled correctly */
 	if (base != 0)
-		xa_erase_index(xa, base);
-	xa_erase_index(xa, base + 1);
+		xa_erase_index(test, xa, base);
+	xa_erase_index(test, xa, base + 1);
 	next = UINT_MAX;
-	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(UINT_MAX),
+	XA_BUG_ON(test, xa, xa_alloc_cyclic(xa, &id, xa_mk_index(UINT_MAX),
 				xa_limit_32b, &next, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != UINT_MAX);
-	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(base),
+	XA_BUG_ON(test, xa, id != UINT_MAX);
+	XA_BUG_ON(test, xa, xa_alloc_cyclic(xa, &id, xa_mk_index(base),
 				xa_limit_32b, &next, GFP_KERNEL) != 1);
-	XA_BUG_ON(xa, id != base);
-	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(base + 1),
+	XA_BUG_ON(test, xa, id != base);
+	XA_BUG_ON(test, xa, xa_alloc_cyclic(xa, &id, xa_mk_index(base + 1),
 				xa_limit_32b, &next, GFP_KERNEL) != 0);
-	XA_BUG_ON(xa, id != base + 1);
+	XA_BUG_ON(test, xa, id != base + 1);
 
 	xa_for_each(xa, index, entry)
-		xa_erase_index(xa, index);
+		xa_erase_index(test, xa, index);
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static DEFINE_XARRAY_ALLOC(xa0);
-static DEFINE_XARRAY_ALLOC1(xa1);
-
-static noinline void check_xa_alloc(void)
+static noinline void check_xa_alloc(struct kunit *test)
 {
-	check_xa_alloc_1(&xa0, 0);
-	check_xa_alloc_1(&xa1, 1);
-	check_xa_alloc_2(&xa0, 0);
-	check_xa_alloc_2(&xa1, 1);
-	check_xa_alloc_3(&xa0, 0);
-	check_xa_alloc_3(&xa1, 1);
+	DEFINE_XARRAY_ALLOC(xa0);
+	DEFINE_XARRAY_ALLOC1(xa1);
+
+	check_xa_alloc_1(test, &xa0, 0);
+	check_xa_alloc_1(test, &xa1, 1);
+	check_xa_alloc_2(test, &xa0, 0);
+	check_xa_alloc_2(test, &xa1, 1);
+	check_xa_alloc_3(test, &xa0, 0);
+	check_xa_alloc_3(test, &xa1, 1);
 }
 
-static noinline void __check_store_iter(struct xarray *xa, unsigned long start,
-			unsigned int order, unsigned int present)
+static noinline void __check_store_iter(struct kunit *test,
+					struct xarray *xa,
+					unsigned long start,
+					unsigned int order,
+					unsigned int present)
 {
 	XA_STATE_ORDER(xas, xa, start, order);
 	void *entry;
@@ -846,9 +885,10 @@ static noinline void __check_store_iter(struct xarray *xa, unsigned long start,
 retry:
 	xas_lock(&xas);
 	xas_for_each_conflict(&xas, entry) {
-		XA_BUG_ON(xa, !xa_is_value(entry));
-		XA_BUG_ON(xa, entry < xa_mk_index(start));
-		XA_BUG_ON(xa, entry > xa_mk_index(start + (1UL << order) - 1));
+		XA_BUG_ON(test, xa, !xa_is_value(entry));
+		XA_BUG_ON(test, xa, entry < xa_mk_index(start));
+		XA_BUG_ON(test,
+			  xa, entry > xa_mk_index(start + (1UL << order) - 1));
 		count++;
 	}
 	xas_store(&xas, xa_mk_index(start));
@@ -857,53 +897,55 @@ static noinline void __check_store_iter(struct xarray *xa, unsigned long start,
 		count = 0;
 		goto retry;
 	}
-	XA_BUG_ON(xa, xas_error(&xas));
-	XA_BUG_ON(xa, count != present);
-	XA_BUG_ON(xa, xa_load(xa, start) != xa_mk_index(start));
-	XA_BUG_ON(xa, xa_load(xa, start + (1UL << order) - 1) !=
+	XA_BUG_ON(test, xa, xas_error(&xas));
+	XA_BUG_ON(test, xa, count != present);
+	XA_BUG_ON(test, xa, xa_load(xa, start) != xa_mk_index(start));
+	XA_BUG_ON(test, xa, xa_load(xa, start + (1UL << order) - 1) !=
 			xa_mk_index(start));
-	xa_erase_index(xa, start);
+	xa_erase_index(test, xa, start);
 }
 
-static noinline void check_store_iter(struct xarray *xa)
+static noinline void check_store_iter(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned int i, j;
 	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
 
 	for (i = 0; i < max_order; i++) {
 		unsigned int min = 1 << i;
 		unsigned int max = (2 << i) - 1;
-		__check_store_iter(xa, 0, i, 0);
-		XA_BUG_ON(xa, !xa_empty(xa));
-		__check_store_iter(xa, min, i, 0);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		__check_store_iter(test, xa, 0, i, 0);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
+		__check_store_iter(test, xa, min, i, 0);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 
 		xa_store_index(xa, min, GFP_KERNEL);
-		__check_store_iter(xa, min, i, 1);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		__check_store_iter(test, xa, min, i, 1);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 		xa_store_index(xa, max, GFP_KERNEL);
-		__check_store_iter(xa, min, i, 1);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		__check_store_iter(test, xa, min, i, 1);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 
 		for (j = 0; j < min; j++)
 			xa_store_index(xa, j, GFP_KERNEL);
-		__check_store_iter(xa, 0, i, min);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		__check_store_iter(test, xa, 0, i, min);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 		for (j = 0; j < min; j++)
 			xa_store_index(xa, min + j, GFP_KERNEL);
-		__check_store_iter(xa, min, i, min);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		__check_store_iter(test, xa, min, i, min);
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 	}
 #ifdef CONFIG_XARRAY_MULTI
 	xa_store_index(xa, 63, GFP_KERNEL);
 	xa_store_index(xa, 65, GFP_KERNEL);
 	__check_store_iter(xa, 64, 2, 1);
-	xa_erase_index(xa, 63);
+	xa_erase_index(test, xa, 63);
 #endif
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_multi_find_1(struct xarray *xa, unsigned order)
+static noinline void check_multi_find_1(struct kunit *test, struct xarray *xa,
+					unsigned int order)
 {
 #ifdef CONFIG_XARRAY_MULTI
 	unsigned long multi = 3 << order;
@@ -911,31 +953,32 @@ static noinline void check_multi_find_1(struct xarray *xa, unsigned order)
 	unsigned long index;
 
 	xa_store_order(xa, multi, order, xa_mk_value(multi), GFP_KERNEL);
-	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
-	XA_BUG_ON(xa, xa_store_index(xa, next + 1, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+	XA_BUG_ON(test, xa, xa_store_index(xa, next + 1, GFP_KERNEL) != NULL);
 
 	index = 0;
-	XA_BUG_ON(xa, xa_find(xa, &index, ULONG_MAX, XA_PRESENT) !=
+	XA_BUG_ON(test, xa, xa_find(xa, &index, ULONG_MAX, XA_PRESENT) !=
 			xa_mk_value(multi));
-	XA_BUG_ON(xa, index != multi);
+	XA_BUG_ON(test, xa, index != multi);
 	index = multi + 1;
-	XA_BUG_ON(xa, xa_find(xa, &index, ULONG_MAX, XA_PRESENT) !=
+	XA_BUG_ON(test, xa, xa_find(xa, &index, ULONG_MAX, XA_PRESENT) !=
 			xa_mk_value(multi));
-	XA_BUG_ON(xa, (index < multi) || (index >= next));
-	XA_BUG_ON(xa, xa_find_after(xa, &index, ULONG_MAX, XA_PRESENT) !=
+	XA_BUG_ON(test, xa, (index < multi) || (index >= next));
+	XA_BUG_ON(test, xa, xa_find_after(xa, &index, ULONG_MAX, XA_PRESENT) !=
 			xa_mk_value(next));
-	XA_BUG_ON(xa, index != next);
-	XA_BUG_ON(xa, xa_find_after(xa, &index, next, XA_PRESENT) != NULL);
-	XA_BUG_ON(xa, index != next);
-
-	xa_erase_index(xa, multi);
-	xa_erase_index(xa, next);
-	xa_erase_index(xa, next + 1);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, index != next);
+	XA_BUG_ON(test, xa,
+		  xa_find_after(xa, &index, next, XA_PRESENT) != NULL);
+	XA_BUG_ON(test, xa, index != next);
+
+	xa_erase_index(test, xa, multi);
+	xa_erase_index(test, xa, next);
+	xa_erase_index(test, xa, next + 1);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 #endif
 }
 
-static noinline void check_multi_find_2(struct xarray *xa)
+static noinline void check_multi_find_2(struct kunit *test, struct xarray *xa)
 {
 	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 10 : 1;
 	unsigned int i, j;
@@ -950,30 +993,30 @@ static noinline void check_multi_find_2(struct xarray *xa)
 					GFP_KERNEL);
 			rcu_read_lock();
 			xas_for_each(&xas, entry, ULONG_MAX) {
-				xa_erase_index(xa, index);
+				xa_erase_index(test, xa, index);
 			}
 			rcu_read_unlock();
-			xa_erase_index(xa, index - 1);
-			XA_BUG_ON(xa, !xa_empty(xa));
+			xa_erase_index(test, xa, index - 1);
+			XA_BUG_ON(test, xa, !xa_empty(xa));
 		}
 	}
 }
 
-static noinline void check_find_1(struct xarray *xa)
+static noinline void check_find_1(struct kunit *test, struct xarray *xa)
 {
 	unsigned long i, j, k;
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/*
 	 * Check xa_find with all pairs between 0 and 99 inclusive,
 	 * starting at every index between 0 and 99
 	 */
 	for (i = 0; i < 100; i++) {
-		XA_BUG_ON(xa, xa_store_index(xa, i, GFP_KERNEL) != NULL);
+		XA_BUG_ON(test, xa, xa_store_index(xa, i, GFP_KERNEL) != NULL);
 		xa_set_mark(xa, i, XA_MARK_0);
 		for (j = 0; j < i; j++) {
-			XA_BUG_ON(xa, xa_store_index(xa, j, GFP_KERNEL) !=
+			XA_BUG_ON(test, xa, xa_store_index(xa, j, GFP_KERNEL) !=
 					NULL);
 			xa_set_mark(xa, j, XA_MARK_0);
 			for (k = 0; k < 100; k++) {
@@ -981,54 +1024,54 @@ static noinline void check_find_1(struct xarray *xa)
 				void *entry = xa_find(xa, &index, ULONG_MAX,
 								XA_PRESENT);
 				if (k <= j)
-					XA_BUG_ON(xa, index != j);
+					XA_BUG_ON(test, xa, index != j);
 				else if (k <= i)
-					XA_BUG_ON(xa, index != i);
+					XA_BUG_ON(test, xa, index != i);
 				else
-					XA_BUG_ON(xa, entry != NULL);
+					XA_BUG_ON(test, xa, entry != NULL);
 
 				index = k;
 				entry = xa_find(xa, &index, ULONG_MAX,
 								XA_MARK_0);
 				if (k <= j)
-					XA_BUG_ON(xa, index != j);
+					XA_BUG_ON(test, xa, index != j);
 				else if (k <= i)
-					XA_BUG_ON(xa, index != i);
+					XA_BUG_ON(test, xa, index != i);
 				else
-					XA_BUG_ON(xa, entry != NULL);
+					XA_BUG_ON(test, xa, entry != NULL);
 			}
-			xa_erase_index(xa, j);
-			XA_BUG_ON(xa, xa_get_mark(xa, j, XA_MARK_0));
-			XA_BUG_ON(xa, !xa_get_mark(xa, i, XA_MARK_0));
+			xa_erase_index(test, xa, j);
+			XA_BUG_ON(test, xa, xa_get_mark(xa, j, XA_MARK_0));
+			XA_BUG_ON(test, xa, !xa_get_mark(xa, i, XA_MARK_0));
 		}
-		xa_erase_index(xa, i);
-		XA_BUG_ON(xa, xa_get_mark(xa, i, XA_MARK_0));
+		xa_erase_index(test, xa, i);
+		XA_BUG_ON(test, xa, xa_get_mark(xa, i, XA_MARK_0));
 	}
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_find_2(struct xarray *xa)
+static noinline void check_find_2(struct kunit *test, struct xarray *xa)
 {
 	void *entry;
 	unsigned long i, j, index;
 
 	xa_for_each(xa, index, entry) {
-		XA_BUG_ON(xa, true);
+		XA_BUG_ON(test, xa, true);
 	}
 
 	for (i = 0; i < 1024; i++) {
 		xa_store_index(xa, index, GFP_KERNEL);
 		j = 0;
 		xa_for_each(xa, index, entry) {
-			XA_BUG_ON(xa, xa_mk_index(index) != entry);
-			XA_BUG_ON(xa, index != j++);
+			XA_BUG_ON(test, xa, xa_mk_index(index) != entry);
+			XA_BUG_ON(test, xa, index != j++);
 		}
 	}
 
 	xa_destroy(xa);
 }
 
-static noinline void check_find_3(struct xarray *xa)
+static noinline void check_find_3(struct kunit *test, struct xarray *xa)
 {
 	XA_STATE(xas, xa, 0);
 	unsigned long i, j, k;
@@ -1042,7 +1085,7 @@ static noinline void check_find_3(struct xarray *xa)
 				xas_for_each_marked(&xas, entry, k, XA_MARK_0)
 					;
 				if (j > k)
-					XA_BUG_ON(xa,
+					XA_BUG_ON(test, xa,
 						xas.xa_node != XAS_RESTART);
 			}
 			rcu_read_unlock();
@@ -1053,7 +1096,7 @@ static noinline void check_find_3(struct xarray *xa)
 	xa_destroy(xa);
 }
 
-static noinline void check_find_4(struct xarray *xa)
+static noinline void check_find_4(struct kunit *test, struct xarray *xa)
 {
 	unsigned long index = 0;
 	void *entry;
@@ -1061,26 +1104,27 @@ static noinline void check_find_4(struct xarray *xa)
 	xa_store_index(xa, ULONG_MAX, GFP_KERNEL);
 
 	entry = xa_find_after(xa, &index, ULONG_MAX, XA_PRESENT);
-	XA_BUG_ON(xa, entry != xa_mk_index(ULONG_MAX));
+	XA_BUG_ON(test, xa, entry != xa_mk_index(ULONG_MAX));
 
 	entry = xa_find_after(xa, &index, ULONG_MAX, XA_PRESENT);
-	XA_BUG_ON(xa, entry);
+	XA_BUG_ON(test, xa, entry);
 
-	xa_erase_index(xa, ULONG_MAX);
+	xa_erase_index(test, xa, ULONG_MAX);
 }
 
-static noinline void check_find(struct xarray *xa)
+static noinline void check_find(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned i;
 
-	check_find_1(xa);
-	check_find_2(xa);
-	check_find_3(xa);
-	check_find_4(xa);
+	check_find_1(test, xa);
+	check_find_2(test, xa);
+	check_find_3(test, xa);
+	check_find_4(test, xa);
 
 	for (i = 2; i < 10; i++)
-		check_multi_find_1(xa, i);
-	check_multi_find_2(xa);
+		check_multi_find_1(test, xa, i);
+	check_multi_find_2(test, xa);
 }
 
 /* See find_swap_entry() in mm/shmem.c */
@@ -1106,8 +1150,9 @@ static noinline unsigned long xa_find_entry(struct xarray *xa, void *item)
 	return entry ? xas.xa_index : -1;
 }
 
-static noinline void check_find_entry(struct xarray *xa)
+static noinline void check_find_entry(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 #ifdef CONFIG_XARRAY_MULTI
 	unsigned int order;
 	unsigned long offset, index;
@@ -1119,69 +1164,72 @@ static noinline void check_find_entry(struct xarray *xa)
 			     index += (1UL << order)) {
 				xa_store_order(xa, index, order,
 						xa_mk_index(index), GFP_KERNEL);
-				XA_BUG_ON(xa, xa_load(xa, index) !=
+				XA_BUG_ON(test, xa, xa_load(xa, index) !=
 						xa_mk_index(index));
-				XA_BUG_ON(xa, xa_find_entry(xa,
+				XA_BUG_ON(test, xa, xa_find_entry(xa,
 						xa_mk_index(index)) != index);
 			}
-			XA_BUG_ON(xa, xa_find_entry(xa, xa) != -1);
+			XA_BUG_ON(test, xa, xa_find_entry(xa, xa) != -1);
 			xa_destroy(xa);
 		}
 	}
 #endif
 
-	XA_BUG_ON(xa, xa_find_entry(xa, xa) != -1);
+	XA_BUG_ON(test, xa, xa_find_entry(xa, xa) != -1);
 	xa_store_index(xa, ULONG_MAX, GFP_KERNEL);
-	XA_BUG_ON(xa, xa_find_entry(xa, xa) != -1);
-	XA_BUG_ON(xa, xa_find_entry(xa, xa_mk_index(ULONG_MAX)) != -1);
-	xa_erase_index(xa, ULONG_MAX);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_find_entry(xa, xa) != -1);
+	XA_BUG_ON(test, xa, xa_find_entry(xa, xa_mk_index(ULONG_MAX)) != -1);
+	xa_erase_index(test, xa, ULONG_MAX);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_move_tiny(struct xarray *xa)
+static noinline void check_move_tiny(struct kunit *test, struct xarray *xa)
 {
 	XA_STATE(xas, xa, 0);
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 	rcu_read_lock();
-	XA_BUG_ON(xa, xas_next(&xas) != NULL);
-	XA_BUG_ON(xa, xas_next(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas_next(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas_next(&xas) != NULL);
 	rcu_read_unlock();
 	xa_store_index(xa, 0, GFP_KERNEL);
 	rcu_read_lock();
 	xas_set(&xas, 0);
-	XA_BUG_ON(xa, xas_next(&xas) != xa_mk_index(0));
-	XA_BUG_ON(xa, xas_next(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas_next(&xas) != xa_mk_index(0));
+	XA_BUG_ON(test, xa, xas_next(&xas) != NULL);
 	xas_set(&xas, 0);
-	XA_BUG_ON(xa, xas_prev(&xas) != xa_mk_index(0));
-	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas_prev(&xas) != xa_mk_index(0));
+	XA_BUG_ON(test, xa, xas_prev(&xas) != NULL);
 	rcu_read_unlock();
-	xa_erase_index(xa, 0);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, 0);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_move_max(struct xarray *xa)
+static noinline void check_move_max(struct kunit *test, struct xarray *xa)
 {
 	XA_STATE(xas, xa, 0);
 
 	xa_store_index(xa, ULONG_MAX, GFP_KERNEL);
 	rcu_read_lock();
-	XA_BUG_ON(xa, xas_find(&xas, ULONG_MAX) != xa_mk_index(ULONG_MAX));
-	XA_BUG_ON(xa, xas_find(&xas, ULONG_MAX) != NULL);
+	XA_BUG_ON(test, xa,
+		  xas_find(&xas, ULONG_MAX) != xa_mk_index(ULONG_MAX));
+	XA_BUG_ON(test, xa, xas_find(&xas, ULONG_MAX) != NULL);
 	rcu_read_unlock();
 
 	xas_set(&xas, 0);
 	rcu_read_lock();
-	XA_BUG_ON(xa, xas_find(&xas, ULONG_MAX) != xa_mk_index(ULONG_MAX));
+	XA_BUG_ON(test, xa,
+		  xas_find(&xas, ULONG_MAX) != xa_mk_index(ULONG_MAX));
 	xas_pause(&xas);
-	XA_BUG_ON(xa, xas_find(&xas, ULONG_MAX) != NULL);
+	XA_BUG_ON(test, xa, xas_find(&xas, ULONG_MAX) != NULL);
 	rcu_read_unlock();
 
-	xa_erase_index(xa, ULONG_MAX);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, ULONG_MAX);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_move_small(struct xarray *xa, unsigned long idx)
+static noinline void check_move_small(struct kunit *test, struct xarray *xa,
+				      unsigned long idx)
 {
 	XA_STATE(xas, xa, 0);
 	unsigned long i;
@@ -1193,71 +1241,72 @@ static noinline void check_move_small(struct xarray *xa, unsigned long idx)
 	for (i = 0; i < idx * 4; i++) {
 		void *entry = xas_next(&xas);
 		if (i <= idx)
-			XA_BUG_ON(xa, xas.xa_node == XAS_RESTART);
-		XA_BUG_ON(xa, xas.xa_index != i);
+			XA_BUG_ON(test, xa, xas.xa_node == XAS_RESTART);
+		XA_BUG_ON(test, xa, xas.xa_index != i);
 		if (i == 0 || i == idx)
-			XA_BUG_ON(xa, entry != xa_mk_index(i));
+			XA_BUG_ON(test, xa, entry != xa_mk_index(i));
 		else
-			XA_BUG_ON(xa, entry != NULL);
+			XA_BUG_ON(test, xa, entry != NULL);
 	}
 	xas_next(&xas);
-	XA_BUG_ON(xa, xas.xa_index != i);
+	XA_BUG_ON(test, xa, xas.xa_index != i);
 
 	do {
 		void *entry = xas_prev(&xas);
 		i--;
 		if (i <= idx)
-			XA_BUG_ON(xa, xas.xa_node == XAS_RESTART);
-		XA_BUG_ON(xa, xas.xa_index != i);
+			XA_BUG_ON(test, xa, xas.xa_node == XAS_RESTART);
+		XA_BUG_ON(test, xa, xas.xa_index != i);
 		if (i == 0 || i == idx)
-			XA_BUG_ON(xa, entry != xa_mk_index(i));
+			XA_BUG_ON(test, xa, entry != xa_mk_index(i));
 		else
-			XA_BUG_ON(xa, entry != NULL);
+			XA_BUG_ON(test, xa, entry != NULL);
 	} while (i > 0);
 
 	xas_set(&xas, ULONG_MAX);
-	XA_BUG_ON(xa, xas_next(&xas) != NULL);
-	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
-	XA_BUG_ON(xa, xas_next(&xas) != xa_mk_value(0));
-	XA_BUG_ON(xa, xas.xa_index != 0);
-	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
-	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+	XA_BUG_ON(test, xa, xas_next(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas.xa_index != ULONG_MAX);
+	XA_BUG_ON(test, xa, xas_next(&xas) != xa_mk_value(0));
+	XA_BUG_ON(test, xa, xas.xa_index != 0);
+	XA_BUG_ON(test, xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas.xa_index != ULONG_MAX);
 	rcu_read_unlock();
 
-	xa_erase_index(xa, 0);
-	xa_erase_index(xa, idx);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	xa_erase_index(test, xa, 0);
+	xa_erase_index(test, xa, idx);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_move(struct xarray *xa)
+static noinline void check_move(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	XA_STATE(xas, xa, (1 << 16) - 1);
 	unsigned long i;
 
 	for (i = 0; i < (1 << 16); i++)
-		XA_BUG_ON(xa, xa_store_index(xa, i, GFP_KERNEL) != NULL);
+		XA_BUG_ON(test, xa, xa_store_index(xa, i, GFP_KERNEL) != NULL);
 
 	rcu_read_lock();
 	do {
 		void *entry = xas_prev(&xas);
 		i--;
-		XA_BUG_ON(xa, entry != xa_mk_index(i));
-		XA_BUG_ON(xa, i != xas.xa_index);
+		XA_BUG_ON(test, xa, entry != xa_mk_index(i));
+		XA_BUG_ON(test, xa, i != xas.xa_index);
 	} while (i != 0);
 
-	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
-	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+	XA_BUG_ON(test, xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas.xa_index != ULONG_MAX);
 
 	do {
 		void *entry = xas_next(&xas);
-		XA_BUG_ON(xa, entry != xa_mk_index(i));
-		XA_BUG_ON(xa, i != xas.xa_index);
+		XA_BUG_ON(test, xa, entry != xa_mk_index(i));
+		XA_BUG_ON(test, xa, i != xas.xa_index);
 		i++;
 	} while (i < (1 << 16));
 	rcu_read_unlock();
 
 	for (i = (1 << 8); i < (1 << 15); i++)
-		xa_erase_index(xa, i);
+		xa_erase_index(test, xa, i);
 
 	i = xas.xa_index;
 
@@ -1266,39 +1315,39 @@ static noinline void check_move(struct xarray *xa)
 		void *entry = xas_prev(&xas);
 		i--;
 		if ((i < (1 << 8)) || (i >= (1 << 15)))
-			XA_BUG_ON(xa, entry != xa_mk_index(i));
+			XA_BUG_ON(test, xa, entry != xa_mk_index(i));
 		else
-			XA_BUG_ON(xa, entry != NULL);
-		XA_BUG_ON(xa, i != xas.xa_index);
+			XA_BUG_ON(test, xa, entry != NULL);
+		XA_BUG_ON(test, xa, i != xas.xa_index);
 	} while (i != 0);
 
-	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
-	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+	XA_BUG_ON(test, xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(test, xa, xas.xa_index != ULONG_MAX);
 
 	do {
 		void *entry = xas_next(&xas);
 		if ((i < (1 << 8)) || (i >= (1 << 15)))
-			XA_BUG_ON(xa, entry != xa_mk_index(i));
+			XA_BUG_ON(test, xa, entry != xa_mk_index(i));
 		else
-			XA_BUG_ON(xa, entry != NULL);
-		XA_BUG_ON(xa, i != xas.xa_index);
+			XA_BUG_ON(test, xa, entry != NULL);
+		XA_BUG_ON(test, xa, i != xas.xa_index);
 		i++;
 	} while (i < (1 << 16));
 	rcu_read_unlock();
 
 	xa_destroy(xa);
 
-	check_move_tiny(xa);
-	check_move_max(xa);
+	check_move_tiny(test, xa);
+	check_move_max(test, xa);
 
 	for (i = 0; i < 16; i++)
-		check_move_small(xa, 1UL << i);
+		check_move_small(test, xa, 1UL << i);
 
 	for (i = 2; i < 16; i++)
-		check_move_small(xa, (1UL << i) - 1);
+		check_move_small(test, xa, (1UL << i) - 1);
 }
 
-static noinline void xa_store_many_order(struct xarray *xa,
+static noinline void xa_store_many_order(struct kunit *test, struct xarray *xa,
 		unsigned long index, unsigned order)
 {
 	XA_STATE_ORDER(xas, xa, index, order);
@@ -1306,53 +1355,55 @@ static noinline void xa_store_many_order(struct xarray *xa,
 
 	do {
 		xas_lock(&xas);
-		XA_BUG_ON(xa, xas_find_conflict(&xas));
+		XA_BUG_ON(test, xa, xas_find_conflict(&xas));
 		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
 		for (i = 0; i < (1U << order); i++) {
-			XA_BUG_ON(xa, xas_store(&xas, xa_mk_index(index + i)));
+			XA_BUG_ON(test, xa,
+				  xas_store(&xas, xa_mk_index(index + i)));
 			xas_next(&xas);
 		}
 unlock:
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	XA_BUG_ON(xa, xas_error(&xas));
+	XA_BUG_ON(test, xa, xas_error(&xas));
 }
 
-static noinline void check_create_range_1(struct xarray *xa,
+static noinline void check_create_range_1(struct kunit *test, struct xarray *xa,
 		unsigned long index, unsigned order)
 {
 	unsigned long i;
 
-	xa_store_many_order(xa, index, order);
+	xa_store_many_order(test, xa, index, order);
 	for (i = index; i < index + (1UL << order); i++)
-		xa_erase_index(xa, i);
-	XA_BUG_ON(xa, !xa_empty(xa));
+		xa_erase_index(test, xa, i);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_create_range_2(struct xarray *xa, unsigned order)
+static noinline void check_create_range_2(struct kunit *test, struct xarray *xa,
+					  unsigned int order)
 {
 	unsigned long i;
 	unsigned long nr = 1UL << order;
 
 	for (i = 0; i < nr * nr; i += nr)
-		xa_store_many_order(xa, i, order);
+		xa_store_many_order(test, xa, i, order);
 	for (i = 0; i < nr * nr; i++)
-		xa_erase_index(xa, i);
-	XA_BUG_ON(xa, !xa_empty(xa));
+		xa_erase_index(test, xa, i);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_create_range_3(void)
+static noinline void check_create_range_3(struct kunit *test)
 {
 	XA_STATE(xas, NULL, 0);
 	xas_set_err(&xas, -EEXIST);
 	xas_create_range(&xas);
-	XA_BUG_ON(NULL, xas_error(&xas) != -EEXIST);
+	XA_BUG_ON(test, NULL, xas_error(&xas) != -EEXIST);
 }
 
-static noinline void check_create_range_4(struct xarray *xa,
+static noinline void check_create_range_4(struct kunit *test, struct xarray *xa,
 		unsigned long index, unsigned order)
 {
 	XA_STATE_ORDER(xas, xa, index, order);
@@ -1368,88 +1419,94 @@ static noinline void check_create_range_4(struct xarray *xa,
 		for (i = 0; i < (1UL << order); i++) {
 			void *old = xas_store(&xas, xa_mk_index(base + i));
 			if (xas.xa_index == index)
-				XA_BUG_ON(xa, old != xa_mk_index(base + i));
+				XA_BUG_ON(test, xa,
+					  old != xa_mk_index(base + i));
 			else
-				XA_BUG_ON(xa, old != NULL);
+				XA_BUG_ON(test, xa, old != NULL);
 			xas_next(&xas);
 		}
 unlock:
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	XA_BUG_ON(xa, xas_error(&xas));
+	XA_BUG_ON(test, xa, xas_error(&xas));
 
 	for (i = base; i < base + (1UL << order); i++)
-		xa_erase_index(xa, i);
-	XA_BUG_ON(xa, !xa_empty(xa));
+		xa_erase_index(test, xa, i);
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_create_range(struct xarray *xa)
+static noinline void check_create_range(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned int order;
 	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 12 : 1;
 
 	for (order = 0; order < max_order; order++) {
-		check_create_range_1(xa, 0, order);
-		check_create_range_1(xa, 1U << order, order);
-		check_create_range_1(xa, 2U << order, order);
-		check_create_range_1(xa, 3U << order, order);
-		check_create_range_1(xa, 1U << 24, order);
+		check_create_range_1(test, xa, 0, order);
+		check_create_range_1(test, xa, 1U << order, order);
+		check_create_range_1(test, xa, 2U << order, order);
+		check_create_range_1(test, xa, 3U << order, order);
+		check_create_range_1(test, xa, 1U << 24, order);
 		if (order < 10)
-			check_create_range_2(xa, order);
-
-		check_create_range_4(xa, 0, order);
-		check_create_range_4(xa, 1U << order, order);
-		check_create_range_4(xa, 2U << order, order);
-		check_create_range_4(xa, 3U << order, order);
-		check_create_range_4(xa, 1U << 24, order);
-
-		check_create_range_4(xa, 1, order);
-		check_create_range_4(xa, (1U << order) + 1, order);
-		check_create_range_4(xa, (2U << order) + 1, order);
-		check_create_range_4(xa, (2U << order) - 1, order);
-		check_create_range_4(xa, (3U << order) + 1, order);
-		check_create_range_4(xa, (3U << order) - 1, order);
-		check_create_range_4(xa, (1U << 24) + 1, order);
+			check_create_range_2(test, xa, order);
+
+		check_create_range_4(test, xa, 0, order);
+		check_create_range_4(test, xa, 1U << order, order);
+		check_create_range_4(test, xa, 2U << order, order);
+		check_create_range_4(test, xa, 3U << order, order);
+		check_create_range_4(test, xa, 1U << 24, order);
+
+		check_create_range_4(test, xa, 1, order);
+		check_create_range_4(test, xa, (1U << order) + 1, order);
+		check_create_range_4(test, xa, (2U << order) + 1, order);
+		check_create_range_4(test, xa, (2U << order) - 1, order);
+		check_create_range_4(test, xa, (3U << order) + 1, order);
+		check_create_range_4(test, xa, (3U << order) - 1, order);
+		check_create_range_4(test, xa, (1U << 24) + 1, order);
 	}
 
-	check_create_range_3();
+	check_create_range_3(test);
 }
 
-static noinline void __check_store_range(struct xarray *xa, unsigned long first,
-		unsigned long last)
+static noinline void __check_store_range(struct kunit *test,
+					 struct xarray *xa,
+					 unsigned long first,
+					 unsigned long last)
 {
 #ifdef CONFIG_XARRAY_MULTI
 	xa_store_range(xa, first, last, xa_mk_index(first), GFP_KERNEL);
 
-	XA_BUG_ON(xa, xa_load(xa, first) != xa_mk_index(first));
-	XA_BUG_ON(xa, xa_load(xa, last) != xa_mk_index(first));
-	XA_BUG_ON(xa, xa_load(xa, first - 1) != NULL);
-	XA_BUG_ON(xa, xa_load(xa, last + 1) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, first) != xa_mk_index(first));
+	XA_BUG_ON(test, xa, xa_load(xa, last) != xa_mk_index(first));
+	XA_BUG_ON(test, xa, xa_load(xa, first - 1) != NULL);
+	XA_BUG_ON(test, xa, xa_load(xa, last + 1) != NULL);
 
 	xa_store_range(xa, first, last, NULL, GFP_KERNEL);
 #endif
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_store_range(struct xarray *xa)
+static noinline void check_store_range(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned long i, j;
 
 	for (i = 0; i < 128; i++) {
 		for (j = i; j < 128; j++) {
-			__check_store_range(xa, i, j);
-			__check_store_range(xa, 128 + i, 128 + j);
-			__check_store_range(xa, 4095 + i, 4095 + j);
-			__check_store_range(xa, 4096 + i, 4096 + j);
-			__check_store_range(xa, 123456 + i, 123456 + j);
-			__check_store_range(xa, (1 << 24) + i, (1 << 24) + j);
+			__check_store_range(test, xa, i, j);
+			__check_store_range(test, xa, 128 + i, 128 + j);
+			__check_store_range(test, xa, 4095 + i, 4095 + j);
+			__check_store_range(test, xa, 4096 + i, 4096 + j);
+			__check_store_range(test, xa, 123456 + i, 123456 + j);
+			__check_store_range(test, xa,
+					    (1 << 24) + i, (1 << 24) + j);
 		}
 	}
 }
 
-static void check_align_1(struct xarray *xa, char *name)
+static void check_align_1(struct kunit *test, struct xarray *xa, char *name)
 {
 	int i;
 	unsigned int id;
@@ -1457,12 +1514,12 @@ static void check_align_1(struct xarray *xa, char *name)
 	void *entry;
 
 	for (i = 0; i < 8; i++) {
-		XA_BUG_ON(xa, xa_alloc(xa, &id, name + i, xa_limit_32b,
+		XA_BUG_ON(test, xa, xa_alloc(xa, &id, name + i, xa_limit_32b,
 					GFP_KERNEL) != 0);
-		XA_BUG_ON(xa, id != i);
+		XA_BUG_ON(test, xa, id != i);
 	}
 	xa_for_each(xa, index, entry)
-		XA_BUG_ON(xa, xa_is_err(entry));
+		XA_BUG_ON(test, xa, xa_is_err(entry));
 	xa_destroy(xa);
 }
 
@@ -1470,35 +1527,37 @@ static void check_align_1(struct xarray *xa, char *name)
  * We should always be able to store without allocating memory after
  * reserving a slot.
  */
-static void check_align_2(struct xarray *xa, char *name)
+static void check_align_2(struct kunit *test, struct xarray *xa, char *name)
 {
 	int i;
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	for (i = 0; i < 8; i++) {
-		XA_BUG_ON(xa, xa_store(xa, 0, name + i, GFP_KERNEL) != NULL);
+		XA_BUG_ON(test, xa,
+			  xa_store(xa, 0, name + i, GFP_KERNEL) != NULL);
 		xa_erase(xa, 0);
 	}
 
 	for (i = 0; i < 8; i++) {
-		XA_BUG_ON(xa, xa_reserve(xa, 0, GFP_KERNEL) != 0);
-		XA_BUG_ON(xa, xa_store(xa, 0, name + i, 0) != NULL);
+		XA_BUG_ON(test, xa, xa_reserve(xa, 0, GFP_KERNEL) != 0);
+		XA_BUG_ON(test, xa, xa_store(xa, 0, name + i, 0) != NULL);
 		xa_erase(xa, 0);
 	}
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 }
 
-static noinline void check_align(struct xarray *xa)
+static noinline void check_align(struct kunit *test)
 {
 	char name[] = "Motorola 68000";
+	DEFINE_XARRAY_ALLOC(xa);
 
-	check_align_1(xa, name);
-	check_align_1(xa, name + 1);
-	check_align_1(xa, name + 2);
-	check_align_1(xa, name + 3);
-	check_align_2(xa, name);
+	check_align_1(test, &xa, name);
+	check_align_1(test, &xa, name + 1);
+	check_align_1(test, &xa, name + 2);
+	check_align_1(test, &xa, name + 3);
+	check_align_2(test, &xa, name);
 }
 
 static LIST_HEAD(shadow_nodes);
@@ -1514,7 +1573,7 @@ static void test_update_node(struct xa_node *node)
 	}
 }
 
-static noinline void shadow_remove(struct xarray *xa)
+static noinline void shadow_remove(struct kunit *test, struct xarray *xa)
 {
 	struct xa_node *node;
 
@@ -1522,7 +1581,7 @@ static noinline void shadow_remove(struct xarray *xa)
 	while ((node = list_first_entry_or_null(&shadow_nodes,
 					struct xa_node, private_list))) {
 		XA_STATE(xas, node->array, 0);
-		XA_BUG_ON(xa, node->array != xa);
+		XA_BUG_ON(test, xa, node->array != xa);
 		list_del_init(&node->private_list);
 		xas.xa_node = xa_parent_locked(node->array, node);
 		xas.xa_offset = node->offset;
@@ -1533,7 +1592,9 @@ static noinline void shadow_remove(struct xarray *xa)
 	xa_unlock(xa);
 }
 
-static noinline void check_workingset(struct xarray *xa, unsigned long index)
+static noinline void check_workingset(struct kunit *test,
+				      struct xarray *xa,
+				      unsigned long index)
 {
 	XA_STATE(xas, xa, index);
 	xas_set_update(&xas, test_update_node);
@@ -1546,29 +1607,39 @@ static noinline void check_workingset(struct xarray *xa, unsigned long index)
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	XA_BUG_ON(xa, list_empty(&shadow_nodes));
+	XA_BUG_ON(test, xa, list_empty(&shadow_nodes));
 
 	xas_lock(&xas);
 	xas_next(&xas);
 	xas_store(&xas, &xas);
-	XA_BUG_ON(xa, !list_empty(&shadow_nodes));
+	XA_BUG_ON(test, xa, !list_empty(&shadow_nodes));
 
 	xas_store(&xas, xa_mk_value(2));
 	xas_unlock(&xas);
-	XA_BUG_ON(xa, list_empty(&shadow_nodes));
+	XA_BUG_ON(test, xa, list_empty(&shadow_nodes));
 
-	shadow_remove(xa);
-	XA_BUG_ON(xa, !list_empty(&shadow_nodes));
-	XA_BUG_ON(xa, !xa_empty(xa));
+	shadow_remove(test, xa);
+	XA_BUG_ON(test, xa, !list_empty(&shadow_nodes));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
+}
+
+static void check_workingset_all(struct kunit *test)
+{
+	struct xarray *xa = test->priv;
+
+	check_workingset(test, xa, 0);
+	check_workingset(test, xa, 64);
+	check_workingset(test, xa, 4096);
 }
 
 /*
  * Check that the pointer / value / sibling entries are accounted the
  * way we expect them to be.
  */
-static noinline void check_account(struct xarray *xa)
+static noinline void check_account(struct kunit *test)
 {
 #ifdef CONFIG_XARRAY_MULTI
+	struct xarray *xa = test->priv;
 	unsigned int order;
 
 	for (order = 1; order < 12; order++) {
@@ -1577,96 +1648,105 @@ static noinline void check_account(struct xarray *xa)
 		xa_store_order(xa, 0, order, xa, GFP_KERNEL);
 		rcu_read_lock();
 		xas_load(&xas);
-		XA_BUG_ON(xa, xas.xa_node->count == 0);
-		XA_BUG_ON(xa, xas.xa_node->count > (1 << order));
-		XA_BUG_ON(xa, xas.xa_node->nr_values != 0);
+		XA_BUG_ON(test, xa, xas.xa_node->count == 0);
+		XA_BUG_ON(test, xa, xas.xa_node->count > (1 << order));
+		XA_BUG_ON(test, xa, xas.xa_node->nr_values != 0);
 		rcu_read_unlock();
 
 		xa_store_order(xa, 1 << order, order, xa_mk_index(1UL << order),
 				GFP_KERNEL);
-		XA_BUG_ON(xa, xas.xa_node->count != xas.xa_node->nr_values * 2);
+		XA_BUG_ON(test, xa,
+			  xas.xa_node->count != xas.xa_node->nr_values * 2);
 
 		xa_erase(xa, 1 << order);
-		XA_BUG_ON(xa, xas.xa_node->nr_values != 0);
+		XA_BUG_ON(test, xa, xas.xa_node->nr_values != 0);
 
 		xa_erase(xa, 0);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 	}
 #endif
 }
 
-static noinline void check_destroy(struct xarray *xa)
+static noinline void check_destroy(struct kunit *test)
 {
+	struct xarray *xa = test->priv;
 	unsigned long index;
 
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* Destroying an empty array is a no-op */
 	xa_destroy(xa);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 	/* Destroying an array with a single entry */
 	for (index = 0; index < 1000; index++) {
 		xa_store_index(xa, index, GFP_KERNEL);
-		XA_BUG_ON(xa, xa_empty(xa));
+		XA_BUG_ON(test, xa, xa_empty(xa));
 		xa_destroy(xa);
-		XA_BUG_ON(xa, !xa_empty(xa));
+		XA_BUG_ON(test, xa, !xa_empty(xa));
 	}
 
 	/* Destroying an array with a single entry at ULONG_MAX */
 	xa_store(xa, ULONG_MAX, xa, GFP_KERNEL);
-	XA_BUG_ON(xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_empty(xa));
 	xa_destroy(xa);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 
 #ifdef CONFIG_XARRAY_MULTI
 	/* Destroying an array with a multi-index entry */
 	xa_store_order(xa, 1 << 11, 11, xa, GFP_KERNEL);
-	XA_BUG_ON(xa, xa_empty(xa));
+	XA_BUG_ON(test, xa, xa_empty(xa));
 	xa_destroy(xa);
-	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(test, xa, !xa_empty(xa));
 #endif
 }
 
-static DEFINE_XARRAY(array);
-
-static int xarray_checks(void)
+static int xarray_test_init(struct kunit *test)
 {
-	check_xa_err(&array);
-	check_xas_retry(&array);
-	check_xa_load(&array);
-	check_xa_mark(&array);
-	check_xa_shrink(&array);
-	check_xas_erase(&array);
-	check_insert(&array);
-	check_cmpxchg(&array);
-	check_reserve(&array);
-	check_reserve(&xa0);
-	check_multi_store(&array);
-	check_xa_alloc();
-	check_find(&array);
-	check_find_entry(&array);
-	check_account(&array);
-	check_destroy(&array);
-	check_move(&array);
-	check_create_range(&array);
-	check_store_range(&array);
-	check_store_iter(&array);
-	check_align(&xa0);
-
-	check_workingset(&array, 0);
-	check_workingset(&array, 64);
-	check_workingset(&array, 4096);
-
-	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
-	return (tests_run == tests_passed) ? 0 : -EINVAL;
-}
+	struct xarray *array;
 
-static void xarray_exit(void)
-{
+	array = kunit_kzalloc(test, sizeof(*array), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, array);
+
+	xa_init(array);
+
+	test->priv = array;
+
+	return 0;
 }
 
-module_init(xarray_checks);
-module_exit(xarray_exit);
+static struct kunit_case xarray_test_cases[] = {
+	KUNIT_CASE(check_xa_err),
+	KUNIT_CASE(check_xas_retry),
+	KUNIT_CASE(check_xa_load),
+	KUNIT_CASE(check_xa_mark),
+	KUNIT_CASE(check_xa_shrink),
+	KUNIT_CASE(check_xas_erase),
+	KUNIT_CASE(check_insert),
+	KUNIT_CASE(check_cmpxchg),
+	KUNIT_CASE(check_multi_store),
+	KUNIT_CASE(check_find),
+	KUNIT_CASE(check_find_entry),
+	KUNIT_CASE(check_account),
+	KUNIT_CASE(check_destroy),
+	KUNIT_CASE(check_move),
+	KUNIT_CASE(check_create_range),
+	KUNIT_CASE(check_store_range),
+	KUNIT_CASE(check_store_iter),
+	KUNIT_CASE(check_xa_alloc),
+	KUNIT_CASE(check_workingset_all),
+	KUNIT_CASE(check_reserve_all),
+	KUNIT_CASE(check_align),
+	{}
+};
+
+static struct kunit_suite xarray_test_suite = {
+	.name = "xarray",
+	.init = xarray_test_init,
+	.test_cases = xarray_test_cases,
+};
+
+kunit_test_suites(&xarray_test_suite);
+
 MODULE_AUTHOR("Matthew Wilcox <willy@infradead.org>");
 MODULE_LICENSE("GPL");
diff --git a/lib/xarray.c b/lib/xarray.c
index 1d9fab7db8dad..ed221e3936606 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -2000,7 +2000,7 @@ void xa_destroy(struct xarray *xa)
 }
 EXPORT_SYMBOL(xa_destroy);
 
-#ifdef XA_DEBUG
+#ifdef CONFIG_TEST_XARRAY
 void xa_dump_node(const struct xa_node *node)
 {
 	unsigned i, j;
@@ -2078,4 +2078,4 @@ void xa_dump(const struct xarray *xa)
 		shift = xa_to_node(entry)->shift + XA_CHUNK_SHIFT;
 	xa_dump_entry(entry, 0, shift);
 }
-#endif
+#endif // CONFIG_TEST_XARRAY
-- 
2.25.0.341.g760bfbb309-goog

