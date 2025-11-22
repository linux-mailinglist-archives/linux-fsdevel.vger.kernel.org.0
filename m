Return-Path: <linux-fsdevel+bounces-69504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70547C7D957
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CA224E1C4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686D2EE5FE;
	Sat, 22 Nov 2025 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Pmr7olG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CD2E8B9F
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850287; cv=none; b=XVBdWOucP4hh/5xS32Y5kOs6M2IJPYXrM9sa2tCOE83cFWVtseD6seEKUP2dvYcNsQ34bPRCBeabwWm19XJG1IQB29btrHt0OqwzqRXfToQq3eR1zGl4siSCvncfT64nc3YyyaKJogETiJJrsGYhy966OCPtmmR+0gD8pNt7Ox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850287; c=relaxed/simple;
	bh=3l+12XxLZ6L/2oCthGjMqANEYbAQ8n/WfuJEOJeovT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtJnKRidQ0IKAqQs3po39DtlEUjQjf8gT/fLpXnHhytydhRuiUweaWGjvLOkNQUA282ZwojiBKFoBcdswrW5G+l7KgEIkdVPGLq31cdkHz1BxC9pO9wHlK9RqVtdfrVI3AhiTW2FhojMlCrAx/ieihIfhoNWXDtE1YjvHneuvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Pmr7olG8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-789524e6719so41965147b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850280; x=1764455080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLgQGl+Hg4wswsvyxx4Nha11zmSlja8dA+7nO+BHML4=;
        b=Pmr7olG8jFWd0ALOJwnoFdRgugYn7YrovOPiJpahKUsOBBBuuSH+tRy3gEAacufO2D
         nZKUwSzOHUaioVAYHhKHgjkewJ6kB5DMyx0IhS4XPjuluJ9Q9R0qNn/jXS8VkNSgL9yo
         oQ83whIfymvBqzpQsgJKRbL4MVH8m5diyEoLqfotwbhNny9XRkylNFVP/wZZlneb26G5
         857OlgoPBH7u25IssDlA05V4eWU+WmN31svcq4WVqp4xDcqStWfIoW/Q0l1R9HuvQ/Br
         pbRRtu5fs48EAH3Yi5eplLANHAOv0hMB7ZUMy17JWI8fDoyzDBTZcD2uv/mskjzKwJe/
         Paew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850280; x=1764455080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SLgQGl+Hg4wswsvyxx4Nha11zmSlja8dA+7nO+BHML4=;
        b=rc7O+kBUvX4F82E2fhgQneLpRoosam5ZOvmwU+pd99OSxwUtJsSTvPlZQX1aIkJl3U
         6S0Ht9vZcCKkisX4SzT7UaaOMFpajj9sHsKIM25ywIAAxMWqew5EongkBQ/znCW7NpQ2
         WRktdEkC/xA2DBjeIVGNiXmv4zx7qNkvan6gP4beo8zzblaVxDhLG3ooCw1lpjVHICuC
         ZNf0WiqLV9K5f/pz7kUA6PRueOWKd3lXmaRQ/CnBcBUObitAkndNMOjQ10u4Lz8H8Mv7
         Qeni67tOritkF/kgIqumnc0EfDHJ3lDEBRYDoN6wXEYjUGhnne1tQ5gVRtfLYL8+0dsl
         DI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQIonCTmCdKAE3Z+eE1R2OtdMWrcNo/sbYk5iIRIsnmOBKVcdQjoY0LDGppFGJPhkDmP7n0osQmcbRW5bJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4jJegNKZbpxMlXYklXJEPDyfH7FlGdN71mh2z6i3VMUJ18BX
	g+C0J+C9gDInFfhlAtxnAYQMFZgbu0QRL4rtd1N/sqIfLBNGnnYO4c7CnRRpHYNGUcc=
X-Gm-Gg: ASbGnctR40HZrxEXyhCvDmEC9iUI6R9MOc+cKLNaoDRa6Kn5DF9hPaXi0zygt5LkDr0
	HGB2ERZj94ePX7Ab9t7v1UEyOub04jlO+fSf4DQ6CteRtTxD7ewM/6xlBRLXe4U/utHyKO4CKvD
	AS/Z3YqT0RxTEp0OdgW8e/opGHt9H60k/5WmWH9QiUCIYqULU0TNlheWAvcbQsxmTSMJRNrGghs
	OX3g2WdGkLZwgGiqZimFW0oSfm/qeH65KZrzqOIykZCEXZvodFOj6jF8pGVv5Fwn89POfEOF37h
	rAsASR90KyRV3PYKKnPxLSwHsW4kTEIDIsWtPAfa57od4SE4upjplRZmh+tFa9M89GH8Sp7yfvN
	4UoXTQC5RPQKtxISdW2g6GKqxDBvGinXC8laVxKn8cctYpa4lrBQK7AINUvW+IBCFKGrtYDjc7L
	xbhy48FP+4LYNK0RV1gNIxsja7LViJ2tZ9kS4NaxHYbognxXl2EPCFzY2vOZnWMm8yPhiVQqJgP
	28LNmQ=
X-Google-Smtp-Source: AGHT+IFmO7ei26IBOwPIpZvds7E8L4kuDdnTnNInwjnST8wDDHfpSKCkMuKQ93csT8hxrCzaE1kAPQ==
X-Received: by 2002:a05:690c:6e03:b0:786:4949:b18d with SMTP id 00721157ae682-78a7b9ba83cmr88000807b3.4.1763850280347;
        Sat, 22 Nov 2025 14:24:40 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:39 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v7 22/22] tests/liveupdate: Add in-kernel liveupdate test
Date: Sat, 22 Nov 2025 17:23:49 -0500
Message-ID: <20251122222351.1059049-23-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an in-kernel test module to validate the core logic of the
Live Update Orchestrator's File-Lifecycle-Bound feature. This
provides a low-level, controlled environment to test FLB registration
and callback invocation without requiring userspace interaction or
actual kexec reboots.

The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h      |   5 +
 kernel/liveupdate/luo_file.c     |   8 +-
 kernel/liveupdate/luo_internal.h |   8 ++
 lib/Kconfig.debug                |  23 +++++
 lib/tests/Makefile               |   1 +
 lib/tests/liveupdate.c           | 160 +++++++++++++++++++++++++++++++
 6 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 lib/tests/liveupdate.c

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index ea21ad1535bf..db2fd9611334 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -235,4 +235,9 @@ struct luo_flb_ser {
 	u64 count;
 } __packed;
 
+/* Kernel Live Update Test ABI */
+#ifdef CONFIG_LIVEUPDATE_TEST
+#define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
+#endif
+
 #endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index ecaa93bbcb12..94eb8a13676a 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -868,6 +868,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	list_add_tail(&ACCESS_PRIVATE(fh, list), &luo_file_handler_list);
 	luo_session_resume();
 
+	liveupdate_test_register(fh);
+
 	return 0;
 
 err_resume:
@@ -899,8 +901,10 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	if (!liveupdate_enabled())
 		return -EOPNOTSUPP;
 
+	liveupdate_test_unregister(fh);
+
 	if (!luo_session_quiesce())
-		return -EBUSY;
+		goto err_register;
 
 	if (!list_empty(&ACCESS_PRIVATE(fh, flb_list)))
 		goto err_resume;
@@ -913,6 +917,8 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 
 err_resume:
 	luo_session_resume();
+err_register:
+	liveupdate_test_register(fh);
 	return err;
 }
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index fa9d2a77c394..ee1db7ebee4e 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -130,4 +130,12 @@ int __init luo_flb_setup_outgoing(void *fdt);
 int __init luo_flb_setup_incoming(void *fdt);
 void luo_flb_serialize(void);
 
+#ifdef CONFIG_LIVEUPDATE_TEST
+void liveupdate_test_register(struct liveupdate_file_handler *fh);
+void liveupdate_test_unregister(struct liveupdate_file_handler *fh);
+#else
+static inline void liveupdate_test_register(struct liveupdate_file_handler *fh) { }
+static inline void liveupdate_test_unregister(struct liveupdate_file_handler *fh) { }
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bd3bb7a0c801..59b5ce8f89cf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2803,6 +2803,29 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config LIVEUPDATE_TEST
+	bool "Live Update Kernel Test"
+	default n
+	depends on LIVEUPDATE
+	help
+	  Enable a built-in kernel test module for the Live Update
+	  Orchestrator.
+
+	  This module validates the File-Lifecycle-Bound subsystem by
+	  registering a set of mock FLB objects with any real file handlers
+	  that support live update (such as the memfd handler).
+
+	  When live update operations are performed, this test module will
+	  output messages to the kernel log (dmesg), confirming that its
+	  registration and various callback functions (preserve, retrieve,
+	  finish, etc.) are being invoked correctly.
+
+	  This is a debugging and regression testing tool for developers
+	  working on the Live Update subsystem. It should not be enabled in
+	  production kernels.
+
+	  If unsure, say N
+
 config CMDLINE_KUNIT_TEST
 	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 601dba4b7d96..ab0173e6e8b0 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
 
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
diff --git a/lib/tests/liveupdate.c b/lib/tests/liveupdate.c
new file mode 100644
index 000000000000..cf30d53668b0
--- /dev/null
+++ b/lib/tests/liveupdate.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME " test: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+#include "../../kernel/liveupdate/luo_internal.h"
+
+static const struct liveupdate_flb_ops test_flb_ops;
+#define DEFINE_TEST_FLB(i) {						\
+	.ops = &test_flb_ops,						\
+	.compatible = LIVEUPDATE_TEST_FLB_COMPATIBLE(i),		\
+}
+
+/* Number of Test FLBs to register with every file handler */
+#define TEST_NFLBS 3
+static struct liveupdate_flb test_flbs[TEST_NFLBS] = {
+	DEFINE_TEST_FLB(0),
+	DEFINE_TEST_FLB(1),
+	DEFINE_TEST_FLB(2),
+};
+
+#define TEST_FLB_MAGIC_BASE 0xFEEDF00DCAFEBEE0ULL
+
+static int test_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	ptrdiff_t index = argp->flb - test_flbs;
+
+	pr_info("%s: preserve was triggered\n", argp->flb->compatible);
+	argp->data = TEST_FLB_MAGIC_BASE + index;
+
+	return 0;
+}
+
+static void test_flb_unpreserve(struct liveupdate_flb_op_args *argp)
+{
+	pr_info("%s: unpreserve was triggered\n", argp->flb->compatible);
+}
+
+static int test_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	ptrdiff_t index = argp->flb - test_flbs;
+	u64 expected_data = TEST_FLB_MAGIC_BASE + index;
+
+	if (argp->data == expected_data) {
+		pr_info("%s: found flb data from the previous boot\n",
+			argp->flb->compatible);
+		argp->obj = (void *)argp->data;
+	} else {
+		pr_err("%s: ERROR - incorrect data handle: %llx, expected %llx\n",
+		       argp->flb->compatible, argp->data, expected_data);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void test_flb_finish(struct liveupdate_flb_op_args *argp)
+{
+	ptrdiff_t index = argp->flb - test_flbs;
+	void *expected_obj = (void *)(TEST_FLB_MAGIC_BASE + index);
+
+	if (argp->obj == expected_obj) {
+		pr_info("%s: finish was triggered\n", argp->flb->compatible);
+	} else {
+		pr_err("%s: ERROR - finish called with invalid object\n",
+		       argp->flb->compatible);
+	}
+}
+
+static const struct liveupdate_flb_ops test_flb_ops = {
+	.preserve	= test_flb_preserve,
+	.unpreserve	= test_flb_unpreserve,
+	.retrieve	= test_flb_retrieve,
+	.finish		= test_flb_finish,
+	.owner		= THIS_MODULE,
+};
+
+static void liveupdate_test_init(void)
+{
+	static DEFINE_MUTEX(init_lock);
+	static bool initialized;
+	int i;
+
+	guard(mutex)(&init_lock);
+
+	if (initialized)
+		return;
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+		void *obj;
+		int err;
+
+		err = liveupdate_flb_incoming_locked(flb, &obj);
+		if (!err) {
+			liveupdate_flb_incoming_unlock(flb, obj);
+		} else if (err != -ENODATA && err != -ENOENT) {
+			pr_err("liveupdate_flb_incoming_locked for %s failed: %pe\n",
+			       flb->compatible, ERR_PTR(err));
+		}
+	}
+	initialized = true;
+}
+
+void liveupdate_test_register(struct liveupdate_file_handler *fh)
+{
+	int err, i;
+
+	liveupdate_test_init();
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+
+		err = liveupdate_register_flb(fh, flb);
+		if (err) {
+			pr_err("Failed to register %s %pe\n",
+			       flb->compatible, ERR_PTR(err));
+		}
+	}
+
+	err = liveupdate_register_flb(fh, &test_flbs[0]);
+	if (!err || err != -EEXIST) {
+		pr_err("Failed: %s should be already registered, but got err: %pe\n",
+		       test_flbs[0].compatible, ERR_PTR(err));
+	}
+
+	pr_info("Registered %d FLBs with file handler: [%s]\n",
+		TEST_NFLBS, fh->compatible);
+}
+
+void liveupdate_test_unregister(struct liveupdate_file_handler *fh)
+{
+	int err, i;
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+
+		err = liveupdate_unregister_flb(fh, flb);
+		if (err) {
+			pr_err("Failed to unregister %s %pe\n",
+			       flb->compatible, ERR_PTR(err));
+		}
+	}
+
+	pr_info("Unregistered %d FLBs from file handler: [%s]\n",
+		TEST_NFLBS, fh->compatible);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pasha Tatashin <pasha.tatashin@soleen.com>");
+MODULE_DESCRIPTION("In-kernel test for LUO mechanism");
-- 
2.52.0.rc2.455.g230fcf2819-goog


