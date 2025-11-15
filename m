Return-Path: <linux-fsdevel+bounces-68592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD56C60D95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8334E3BEDCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0C310652;
	Sat, 15 Nov 2025 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JVP5e2o3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5030FC04
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249706; cv=none; b=Zd41WXLk+bRZupqnRPs3rnoAVdMotgf1tPuD9VWR3EaIoU1B1KSItlAnaQV0W/mALkHNDtUoqHQnkfgR91HDbO4jP+WtzkynzQpzi0LUw6Cw/oSlrtqBijDEHX3jcT/gNh05wYeZYsN2h7IF85siC2Xz4F5tvGum+jwP0sKlq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249706; c=relaxed/simple;
	bh=5sxzx1bZt4H4ppGfEKJyxtR/cxVtMYfIiDYpbNHVfW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJFAwOghZ5WvISYDBbKKx6COafHmplPP1zT4aqi/o5uY0MfalN4sl8Z3+t3J35N25qAFlfb5vh5aZQrLEqUvoKdXFI3YIGn/Ih04KYppi3G4M351M4RpVLvUDmyJvV2CNZf9sJyOH0NnwYDqO3eGZ0WphSoSswBDE2eW+unbn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JVP5e2o3; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f9beb2730so2493193d50.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249702; x=1763854502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90EWWx4Mqnqhp1SMDUIMTw5wlXkO7ivVTgHSWLpFw+Q=;
        b=JVP5e2o3exPEFykJdNXUI7hbIs8P0xHwuBtHAgC6NEmCcGUFaLkirNrA9qktcHm/VQ
         br/ClZkTsg5G1mlM1CL79AYi7QQaH8INw9jqDaENa2UaMRXsBtEAHvivyGjR7//iJOIj
         BQgyF15W/r1SC8ekYoHt3K2scHdau+SMpG91+WYc8MmDota9ytwsFjJYWHORAfVZF0lh
         sRSEc1O4asi8Y9nIpVKwAkC4VKt+8zO54S7riYAeNYFo0sNOO/GOEj1sZPMVaObm9JzB
         BZBiD5ms8kz+j1SovR65XyWWInB37eFJuKTvHLlE28R0aah3c4FcqaXzY6p26kDFV267
         4EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249702; x=1763854502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=90EWWx4Mqnqhp1SMDUIMTw5wlXkO7ivVTgHSWLpFw+Q=;
        b=HNDpcWRjsLUEGuEt9gdkUTK2qAANVjcXtjbILjKKngnDtqkHtfz3CzDWuIDhGUzjlN
         NXC90Fa9KZ6+rqe9AzgCJlnrLqxiq4Mz32c/7tqJcSwxm0+bL94Lg0QZ1NsEav4h6Mok
         ldE7JRR7SNs0Ycdx/ZslkUwiB0er9WHs2rakXTVylDfzMKjn2jvuDJ907W8Gkm4C+t4S
         VkzjGhtoo7RdJ9Wc66RMF/zwIibLXT1aLDYYhxe5K1xM7hqwrLI8vrMWUBjjl64VtgJ1
         Fe8TrlUdqFsO2IEnYWNSDpaJo9r7bdMkrZ7idzfebiqAQQYsrBIL3UgttXEBsIALMQUE
         ULig==
X-Forwarded-Encrypted: i=1; AJvYcCUZgNtaV5x2V031omJoTum70kYRHR0qgKLysFxwJIuINcDaxys/K0w2cxG4CW8dN65qXpyceZXldwJ4L8H4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41sFVV6h+0PKFmGZzYgZm0fzXUIB/qPqMvtaFzcVF0XVQR+fi
	1vjuWUd3v4VN82G3KAurGbC0CpI316TfYB6WJeN/KSHYVY+Po87ddje9b/LKL3i8Qqs=
X-Gm-Gg: ASbGnctJsFHiTBIH0oERvvvK7Ij29pL65B3oTbBq+Db1VdBRYKqydNGYYruQ2tiJSFm
	CgqQ3AMmWuLF8upvrUzIr0FGYeGZW3xe7bVz2tYzOZXYiZhVFFArGYX2amj3LKdaGD71XKcE5w6
	eEsh4fZxB+qb44PfTmp9gOIEphsJ8i35VQznxk6eWgV257uJCq1slzSEYWBwJn/TFY6URb8MmIT
	8K2SV37cEkVDF8+p0uSt4SI/F3KsYITtgcLC/n1egFeg6C4WWm1WQHscmAubVdEjXJw+FdWXPZa
	vlFsuxfScKyD3MR8h7/vnMXNNPF0ntCKSjorXep56x7pG8xaQ/0kYU/LmWLQtMWA8OQgg1LGPLW
	gsv3xYY9Lc6ozDdjGRsmpVfncLfxjM6wsoDtnz/6WGu59mr/w85vRwVkdtL5nefxUszxUQXc+Qp
	CXbuTJWJAyMWBSBKiYTom/heXObd6EiJN8hRJoIr9oqSE1WoO5BG+h4agVOxlhf57FkqS4UgcSd
	Lu4E4E=
X-Google-Smtp-Source: AGHT+IG/UxHvAnv9mWVe8wsyDfZKwfGnjYpnQZh3+Log3+EltTNlF7D6RJztgMPJcAoGZZph5wgzaA==
X-Received: by 2002:a05:690e:d02:b0:641:f347:5b57 with SMTP id 956f58d0204a3-641f3475ba1mr4093730d50.71.1763249702125;
        Sat, 15 Nov 2025 15:35:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:35:01 -0800 (PST)
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
Subject: [PATCH v6 20/20] tests/liveupdate: Add in-kernel liveupdate test
Date: Sat, 15 Nov 2025 18:34:06 -0500
Message-ID: <20251115233409.768044-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
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
 include/linux/liveupdate/abi/luo.h |   5 +
 kernel/liveupdate/luo_file.c       |   2 +
 kernel/liveupdate/luo_internal.h   |   6 ++
 lib/Kconfig.debug                  |  23 +++++
 lib/tests/Makefile                 |   1 +
 lib/tests/liveupdate.c             | 143 +++++++++++++++++++++++++++++
 6 files changed, 180 insertions(+)
 create mode 100644 lib/tests/liveupdate.c

diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
index 85596ce68c16..cdcace9b48f5 100644
--- a/include/linux/liveupdate/abi/luo.h
+++ b/include/linux/liveupdate/abi/luo.h
@@ -230,4 +230,9 @@ struct luo_flb_ser {
 	u64 count;
 } __packed;
 
+/* Kernel Live Update Test ABI */
+#ifdef CONFIG_LIVEUPDATE_TEST
+#define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
+#endif
+
 #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index df337c9c4f21..9a531096bdb5 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -834,6 +834,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	INIT_LIST_HEAD(&fh->flb_list);
 	list_add_tail(&fh->list, &luo_file_handler_list);
 
+	liveupdate_test_register(fh);
+
 	return 0;
 }
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 389fb102775f..c863cb051d49 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -86,4 +86,10 @@ int __init luo_flb_setup_outgoing(void *fdt);
 int __init luo_flb_setup_incoming(void *fdt);
 void luo_flb_serialize(void);
 
+#ifdef CONFIG_LIVEUPDATE_TEST
+void liveupdate_test_register(struct liveupdate_file_handler *h);
+#else
+static inline void liveupdate_test_register(struct liveupdate_file_handler *h) { }
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9a087826498a..eaa2af2bd963 100644
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
index f7460831cfdd..8e5c527a94ac 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
 
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
diff --git a/lib/tests/liveupdate.c b/lib/tests/liveupdate.c
new file mode 100644
index 000000000000..05c05b8c1c22
--- /dev/null
+++ b/lib/tests/liveupdate.c
@@ -0,0 +1,143 @@
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
+		liveupdate_init_flb(flb);
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
+void liveupdate_test_register(struct liveupdate_file_handler *h)
+{
+	int err, i;
+
+	liveupdate_test_init();
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+
+		err = liveupdate_register_flb(h, flb);
+		if (err)
+			pr_err("Failed to register %s %pe\n",
+			       flb->compatible, ERR_PTR(err));
+	}
+
+	err = liveupdate_register_flb(h, &test_flbs[0]);
+	if (!err || err != -EEXIST) {
+		pr_err("Failed: %s should be already registered, but got err: %pe\n",
+		       test_flbs[0].compatible, ERR_PTR(err));
+	}
+
+	pr_info("Registered %d FLBs with file handler: [%s]\n",
+		TEST_NFLBS, h->compatible);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pasha Tatashin <pasha.tatashin@soleen.com>");
+MODULE_DESCRIPTION("In-kernel test for LUO mechanism");
-- 
2.52.0.rc1.455.g30608eb744-goog


