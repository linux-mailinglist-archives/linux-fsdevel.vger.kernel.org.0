Return-Path: <linux-fsdevel+bounces-53009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB5AE9253
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD37C6A38BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62402307AF6;
	Wed, 25 Jun 2025 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="FGgIHfX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB0287243
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893547; cv=none; b=n6Vlq0Qz7uINDb98TIs6VNaEYorrUH6cttJFd8WRjwj8cjK790Gou3Jilp+OcOgSiG98oAYMHV88JC15OMk/+bHAiZQfCDqcxvbo29Dw2Z8QB0Tb4O47mIgLqrSPKkQUCZ+U1T3CHMLK0zr75AccUxwThjBUkYBBAGm/hXS1sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893547; c=relaxed/simple;
	bh=LCBnkF05BFy67Dj3X9soES2dtoYMqCQz73KyCOTgCrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYima5FT5E76wtbT3Aee/8bcEQWmHTZek0/QgW8ZLXurQoi+63sZM+uEMVBbXMte43cBxZkEN7j6xgVk9/zKgZmd025wA9pj87srAz6RKRnjEA8EGeaoZg+DyIMZf/jsxyM3tcfAxfm88gphd5YgiPi2x7IGhJQpUXouBiygQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=FGgIHfX1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e4043c5b7so4990557b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893544; x=1751498344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZSlqdnTxC2Wjx/Crjm0HF+UsFjTh+cAEzYLoPE8XGM=;
        b=FGgIHfX1tvADYaLlL4oQlXAWnNyVc7s3CaHLUODjsp1KllhH9piGXd79r5ZEzQPDBv
         wwmHz5/uuI43VFDjhdjeE/edJI8KkQ619nUA328FDzA9xnY48wq1T2GXN8LtTfqueJwr
         doPy3TMesDzsvKcPfIQxQYKpYL3Aq8qXJCrMHY48PTeStM3l8VV5FUtn6Pvgmw99L+pO
         uGIfoFuQWW/l6ljk0d623KCbU/97udHY9sQp2YyirctaNZFNRcHUtM8kNKjGa3cJHQ9d
         hcDbIWGvJBfwQTzhgdZC2ki94oc1Jt5NV1HNkLl9ipnrAdFOViAWB+e2XJr7d6ymTBi9
         Z8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893544; x=1751498344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZSlqdnTxC2Wjx/Crjm0HF+UsFjTh+cAEzYLoPE8XGM=;
        b=uWWMDE83xB0XeZui0ZUpILBitaYCqYiCqjJXZVOyJ6mc/Sh9yo619w8Rl7H/zLQiWm
         rFjwnILAVqCx3oaETqF/iBQEeZQ4xaZasRUvWOpfrBsGWSz1iUgvpKhXpONNEP//WrOE
         4e8DaY0rSY5LwB1tZzYhJrHlx3asgr8KuBf7yH43f8ijOehw+RhHS5Tpbwkt/mq1T9jg
         xcCJklx/V7pqhLQk9pWTim3irV4NtclwzjHgjJfizZU0dWkhCKqcVQpeAI9ZFbfaV+hf
         xnYovBCMGZ8aopsYJlqFYXOSf0qN6jmt2QvclQxHrJivXhG/7osgJHJxziaQVVTEEBtK
         XE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpUCzCUCvMjB7cG8hwlFCE26f0WwzUUpPFZWvquA7aT/Cus7v77gK37xuuEnxc1UdI9MsX33HDlt/bKaCp@vger.kernel.org
X-Gm-Message-State: AOJu0YyBD3ViZg/LPJKlbsDmhUpQWznyfNbTWB+L/N4ZjbZ9P+woaq6U
	aO5o5G0oqWVOe+P8+C+vN4mwwWY5U6RlQW1O+CyawvnwhidfUW0xCQcHoySxQW5MYE0=
X-Gm-Gg: ASbGncssPtzTgGTbJoVfxsJOCawfXOuMfIk2Tr9zFjrdR8E3ckv+quzWqZOV2tkF53Y
	ewctp3L6AyrkVYH+AwxnTGv6EyOgRv9F9FEgg7DYwHQFGALn8fJZJQ0cWwA2rVl6dnbo6MKKDB2
	4KHNRxy5lCYBdqwLBl+2ozOar+TCjf3RK833+57conveKjSVvGfIKvWyxwZngrBfjdG8gZXb0zt
	qpgfCskDm1uLyMVvkt9yCU4HBzW7lWZ/BUQOOULqx3L0j998k0sK05x+tS5i44whildxfrym42g
	9tqsqTkJjkeAZXgaOO9jrYKy5Ofmho2AVqBR6oTF8zlmlVrq08udhiG2PMvEBggFpIxF23pFdrM
	UMzsZWUpugcbdUZK4W/8RgRvkOyijaP3+Laqi0XDlzdUB1aSkU9Jn
X-Google-Smtp-Source: AGHT+IFUBGWR2vgXdeu6WMqjmysPRfKH2b0g+Y1BY72xIGjHQryfk9+9u7i490nYs2DPXKqM9VEAwA==
X-Received: by 2002:a05:690c:6ac4:b0:70e:7663:8bb4 with SMTP id 00721157ae682-71406e064cbmr72906017b3.25.1750893543841;
        Wed, 25 Jun 2025 16:19:03 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:03 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	zhangguopeng@kylinos.cn,
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 12/32] liveupdate: luo_subsystems: add subsystem registration
Date: Wed, 25 Jun 2025 23:17:59 +0000
Message-ID: <20250625231838.1897085-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the framework for kernel subsystems (e.g., KVM, IOMMU, device
drivers) to register with LUO and participate in the live update process
via callbacks.

Subsystem Registration:
- Defines struct liveupdate_subsystem in linux/liveupdate.h,
  which subsystems use to provide their name and optional callbacks
  (prepare, freeze, cancel, finish). The callbacks accept
  a u64 *data intended for passing state/handles.
- Exports liveupdate_register_subsystem() and
  liveupdate_unregister_subsystem() API functions.
- Adds drivers/misc/liveupdate/luo_subsystems.c to manage a list
  of registered subsystems.
  Registration/unregistration is restricted to
  specific LUO states (NORMAL/UPDATED).

Callback Framework:
- The main luo_core.c state transition functions
  now delegate to new luo_do_subsystems_*_calls() functions
  defined in luo_subsystems.c.
- These new functions are intended to iterate through the registered
  subsystems and invoke their corresponding callbacks.

FDT Integration:
- Adds a /subsystems subnode within the main LUO FDT created in
  luo_core.c. This node has its own compatibility string
  (subsystems-v1).
- luo_subsystems_fdt_setup() populates this node by adding a
  property for each registered subsystem, using the subsystem's
  name.
  Currently, these properties are initialized with a placeholder
  u64 value (0).
- luo_subsystems_startup() is called from luo_core.c on boot to
  find and validate the /subsystems node in the FDT received via
  KHO. It panics if the node is missing or incompatible.
- Adds a stub API function liveupdate_get_subsystem_data() intended
  for subsystems to retrieve their persisted u64 data from the FDT
      in the new kernel.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h         |  61 +++++++
 kernel/liveupdate/Makefile         |   1 +
 kernel/liveupdate/luo_core.c       |  19 +-
 kernel/liveupdate/luo_internal.h   |   7 +
 kernel/liveupdate/luo_subsystems.c | 284 +++++++++++++++++++++++++++++
 5 files changed, 370 insertions(+), 2 deletions(-)
 create mode 100644 kernel/liveupdate/luo_subsystems.c

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index da8f05c81e51..fed68b9ab32b 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -88,6 +88,47 @@ enum liveupdate_state  {
 	LIVEUPDATE_STATE_UPDATED = 4,
 };
 
+/**
+ * struct liveupdate_subsystem_ops - LUO events callback functions
+ * @prepare:      Optional. Called during LUO prepare phase. Should perform
+ *                preparatory actions and can store a u64 handle/state
+ *                via the 'data' pointer for use in later callbacks.
+ *                Return 0 on success, negative error code on failure.
+ * @freeze:       Optional. Called during LUO freeze event (before actual jump
+ *                to new kernel). Should perform final state saving actions and
+ *                can update the u64 handle/state via the 'data' pointer. Retur:
+ *                0 on success, negative error code on failure.
+ * @cancel:       Optional. Called if the live update process is canceled after
+ *                prepare (or freeze) was called. Receives the u64 data
+ *                set by prepare/freeze. Used for cleanup.
+ * @finish:       Optional. Called after the live update is finished in the new
+ *                kernel.
+ *                Receives the u64 data set by prepare/freeze. Used for cleanup.
+ */
+struct liveupdate_subsystem_ops {
+	int (*prepare)(void *arg, u64 *data);
+	int (*freeze)(void *arg, u64 *data);
+	void (*cancel)(void *arg, u64 data);
+	void (*finish)(void *arg, u64 data);
+};
+
+/**
+ * struct liveupdate_subsystem - Represents a subsystem participating in LUO
+ * @ops:          Callback functions
+ * @name:         Unique name identifying the subsystem.
+ * @arg:          Add this argument to callback functions.
+ * @list:         List head used internally by LUO. Should not be modified by
+ *                caller after registration.
+ * @private_data: For LUO internal use, cached value of data field.
+ */
+struct liveupdate_subsystem {
+	const struct liveupdate_subsystem_ops *ops;
+	const char *name;
+	void *arg;
+	struct list_head list;
+	u64 private_data;
+};
+
 #ifdef CONFIG_LIVEUPDATE
 
 /* Return true if live update orchestrator is enabled */
@@ -109,6 +150,10 @@ bool liveupdate_state_normal(void);
 
 enum liveupdate_state liveupdate_get_state(void);
 
+int liveupdate_register_subsystem(struct liveupdate_subsystem *h);
+int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h);
+int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline int liveupdate_reboot(void)
@@ -136,5 +181,21 @@ static inline enum liveupdate_state liveupdate_get_state(void)
 	return LIVEUPDATE_STATE_NORMAL;
 }
 
+static inline int liveupdate_register_subsystem(struct liveupdate_subsystem *h)
+{
+	return 0;
+}
+
+static inline int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h)
+{
+	return 0;
+}
+
+static inline int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h,
+						u64 *data)
+{
+	return -ENODATA;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index b3c72c405780..999208a1fdbb 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_LIVEUPDATE)		+= luo_core.o
+obj-$(CONFIG_LIVEUPDATE)		+= luo_subsystems.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index c80a1f188359..fff84c51d986 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -130,6 +130,10 @@ static int luo_fdt_setup(void)
 	if (ret)
 		goto exit_free;
 
+	ret = luo_subsystems_fdt_setup(fdt_out);
+	if (ret)
+		goto exit_free;
+
 	ret = kho_preserve_phys(__pa(fdt_out), LUO_FDT_SIZE);
 	if (ret)
 		goto exit_free;
@@ -160,20 +164,30 @@ static void luo_fdt_destroy(void)
 
 static int luo_do_prepare_calls(void)
 {
-	return 0;
+	int ret;
+
+	ret = luo_do_subsystems_prepare_calls();
+
+	return ret;
 }
 
 static int luo_do_freeze_calls(void)
 {
-	return 0;
+	int ret;
+
+	ret = luo_do_subsystems_freeze_calls();
+
+	return ret;
 }
 
 static void luo_do_finish_calls(void)
 {
+	luo_do_subsystems_finish_calls();
 }
 
 static void luo_do_cancel_calls(void)
 {
+	luo_do_subsystems_cancel_calls();
 }
 
 static int __luo_prepare(void)
@@ -419,6 +433,7 @@ static int __init luo_startup(void)
 	}
 
 	__luo_set_state(LIVEUPDATE_STATE_UPDATED);
+	luo_subsystems_startup(luo_fdt_in);
 
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 3d10f3eb20a7..98bf799adb61 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -18,4 +18,11 @@ void luo_state_read_exit(void);
 
 const char *luo_current_state_str(void);
 
+void luo_subsystems_startup(void *fdt);
+int luo_subsystems_fdt_setup(void *fdt);
+int luo_do_subsystems_prepare_calls(void);
+int luo_do_subsystems_freeze_calls(void);
+void luo_do_subsystems_finish_calls(void);
+void luo_do_subsystems_cancel_calls(void);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_subsystems.c b/kernel/liveupdate/luo_subsystems.c
new file mode 100644
index 000000000000..436929a17de0
--- /dev/null
+++ b/kernel/liveupdate/luo_subsystems.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO Subsystems support
+ *
+ * Various kernel subsystems register with the Live Update Orchestrator to
+ * participate in the live update process. These subsystems are notified at
+ * different stages of the live update sequence, allowing them to serialize
+ * device state before the reboot and restore it afterwards. Examples include
+ * the device layer, interrupt controllers, KVM, IOMMU, and specific device
+ * drivers.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/err.h>
+#include <linux/libfdt.h>
+#include <linux/liveupdate.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include "luo_internal.h"
+
+#define LUO_SUBSYSTEMS_NODE_NAME	"subsystems"
+#define LUO_SUBSYSTEMS_COMPATIBLE	"subsystems-v1"
+
+static DEFINE_MUTEX(luo_subsystem_list_mutex);
+static LIST_HEAD(luo_subsystems_list);
+static void *luo_fdt_out;
+static void *luo_fdt_in;
+
+/**
+ * luo_subsystems_fdt_setup - Adds and populates the 'subsystems' node in the
+ * FDT.
+ * @fdt: Pointer to the LUO FDT blob.
+ *
+ * Add subsystems node and each subsystem to the LUO FDT blob.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int luo_subsystems_fdt_setup(void *fdt)
+{
+	struct liveupdate_subsystem *subsystem;
+	const u64 zero_data = 0;
+	int ret, node_offset;
+
+	ret = fdt_add_subnode(fdt, 0, LUO_SUBSYSTEMS_NODE_NAME);
+	if (ret < 0)
+		goto exit_error;
+
+	node_offset = ret;
+	ret = fdt_setprop_string(fdt, node_offset, "compatible",
+				 LUO_SUBSYSTEMS_COMPATIBLE);
+	if (ret < 0)
+		goto exit_error;
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		ret = fdt_setprop(fdt, node_offset, subsystem->name,
+				  &zero_data, sizeof(zero_data));
+		if (ret < 0)
+			goto exit_error;
+	}
+
+	luo_fdt_out = fdt;
+	return 0;
+exit_error:
+	pr_err("Failed to setup 'subsystems' node to FDT: %s\n",
+	       fdt_strerror(ret));
+	return -ENOSPC;
+}
+
+/**
+ * luo_subsystems_startup - Validates the LUO subsystems FDT node at startup.
+ * @fdt: Pointer to the LUO FDT blob passed from the previous kernel.
+ *
+ * This __init function checks the existence and validity of the '/subsystems'
+ * node in the FDT. This node is considered mandatory. It calls panic() if
+ * the node is missing, inaccessible, or invalid (e.g., missing compatible,
+ * wrong compatible string), indicating a critical configuration error for LUO.
+ */
+void __init luo_subsystems_startup(void *fdt)
+{
+	int ret, node_offset;
+
+	node_offset = fdt_subnode_offset(fdt, 0, LUO_SUBSYSTEMS_NODE_NAME);
+	if (node_offset < 0)
+		panic("Failed to find /subsystems node\n");
+
+	ret = fdt_node_check_compatible(fdt, node_offset,
+					LUO_SUBSYSTEMS_COMPATIBLE);
+	if (ret) {
+		panic("FDT '%s' is incompatible with '%s' [%d]\n",
+		      LUO_SUBSYSTEMS_NODE_NAME, LUO_SUBSYSTEMS_COMPATIBLE, ret);
+	}
+	luo_fdt_in = fdt;
+}
+
+/**
+ * luo_do_subsystems_prepare_calls - Calls prepare callbacks and updates FDT
+ * if all prepares succeed. Handles cancellation on failure.
+ *
+ * Phase 1: Calls 'prepare' for all subsystems and stores results temporarily.
+ * If any 'prepare' fails, calls 'cancel' on previously prepared subsystems
+ * and returns the error.
+ * Phase 2: If all 'prepare' calls succeeded, writes the stored data to the FDT.
+ * If any FDT write fails, calls 'cancel' on *all* prepared subsystems and
+ * returns the FDT error.
+ *
+ * Returns: 0 on success. Negative errno on failure.
+ */
+int luo_do_subsystems_prepare_calls(void)
+{
+	return 0;
+}
+
+/**
+ * luo_do_subsystems_freeze_calls - Calls freeze callbacks and updates FDT
+ * if all freezes succeed. Handles cancellation on failure.
+ *
+ * Phase 1: Calls 'freeze' for all subsystems and stores results temporarily.
+ * If any 'freeze' fails, calls 'cancel' on previously called subsystems
+ * and returns the error.
+ * Phase 2: If all 'freeze' calls succeeded, writes the stored data to the FDT.
+ * If any FDT write fails, calls 'cancel' on *all* subsystems and
+ * returns the FDT error.
+ *
+ * Returns: 0 on success. Negative errno on failure.
+ */
+int luo_do_subsystems_freeze_calls(void)
+{
+	return 0;
+}
+
+/**
+ * luo_do_subsystems_finish_calls- Calls finish callbacks for all subsystems.
+ *
+ * This function is called at the end of live update cycle to do the final
+ * clean-up or housekeeping of the post-live update states.
+ */
+void luo_do_subsystems_finish_calls(void)
+{
+}
+
+/**
+ * luo_do_subsystems_cancel_calls - Calls cancel callbacks for all subsystems.
+ *
+ * This function is typically called when the live update process needs to be
+ * aborted externally, for example, after the prepare phase may have run but
+ * before actual reboot. It iterates through all registered subsystems and calls
+ * the 'cancel' callback for those that implement it and likely completed
+ * prepare.
+ */
+void luo_do_subsystems_cancel_calls(void)
+{
+}
+
+/**
+ * liveupdate_register_subsystem - Register a kernel subsystem handler with LUO
+ * @h: Pointer to the liveupdate_subsystem structure allocated and populated
+ * by the calling subsystem.
+ *
+ * Registers a subsystem handler that provides callbacks for different events
+ * of the live update cycle. Registration is typically done during the
+ * subsystem's module init or core initialization.
+ *
+ * Can only be called when LUO is in the NORMAL or UPDATED states.
+ * The provided name (@h->name) must be unique among registered subsystems.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int liveupdate_register_subsystem(struct liveupdate_subsystem *h)
+{
+	struct liveupdate_subsystem *iter;
+	int ret = 0;
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	mutex_lock(&luo_subsystem_list_mutex);
+	list_for_each_entry(iter, &luo_subsystems_list, list) {
+		if (iter == h) {
+			pr_warn("Subsystem '%s' (%p) already registered.\n",
+				h->name, h);
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+
+		if (!strcmp(iter->name, h->name)) {
+			pr_err("Subsystem with name '%s' already registered.\n",
+			       h->name);
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+	}
+
+	INIT_LIST_HEAD(&h->list);
+	list_add_tail(&h->list, &luo_subsystems_list);
+
+out_unlock:
+	mutex_unlock(&luo_subsystem_list_mutex);
+	luo_state_read_exit();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(liveupdate_register_subsystem);
+
+/**
+ * liveupdate_unregister_subsystem - Unregister a kernel subsystem handler from
+ * LUO
+ * @h: Pointer to the same liveupdate_subsystem structure that was used during
+ * registration.
+ *
+ * Unregisters a previously registered subsystem handler. Typically called
+ * during module exit or subsystem teardown. LUO removes the structure from its
+ * internal list; the caller is responsible for any necessary memory cleanup
+ * of the structure itself.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ * -EINVAL if h is NULL.
+ * -ENOENT if the specified handler @h is not found in the registration list.
+ * -EBUSY if LUO is not in the NORMAL state.
+ */
+int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h)
+{
+	struct liveupdate_subsystem *iter;
+	bool found = false;
+	int ret = 0;
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	mutex_lock(&luo_subsystem_list_mutex);
+	list_for_each_entry(iter, &luo_subsystems_list, list) {
+		if (iter == h) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found) {
+		list_del_init(&h->list);
+	} else {
+		pr_warn("Subsystem handler '%s' not found for unregistration.\n",
+			h->name);
+		ret = -ENOENT;
+	}
+
+	mutex_unlock(&luo_subsystem_list_mutex);
+	luo_state_read_exit();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(liveupdate_unregister_subsystem);
+
+/**
+ * liveupdate_get_subsystem_data - Retrieve raw private data for a subsystem
+ * from FDT.
+ * @h:      Pointer to the liveupdate_subsystem structure representing the
+ * subsystem instance. The 'name' field is used to find the property.
+ * @data:   Output pointer where the subsystem's raw private u64 data will be
+ * stored via memcpy.
+ *
+ * Reads the 8-byte data property associated with the subsystem @h->name
+ * directly from the '/subsystems' node within the globally accessible
+ * 'luo_fdt_in' blob. Returns appropriate error codes if inputs are invalid, or
+ * nodes/properties are missing or invalid.
+ *
+ * Return:  0 on success. -ENOENT on error.
+ */
+int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(liveupdate_get_subsystem_data);
-- 
2.50.0.727.gbf7dc18ff4-goog


