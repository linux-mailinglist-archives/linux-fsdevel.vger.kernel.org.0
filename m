Return-Path: <linux-fsdevel+bounces-62966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1DBA7ADE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CA43B5C8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B20235053;
	Mon, 29 Sep 2025 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Z0B5rVxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF4B2236F0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107829; cv=none; b=OjGR7zMDnH4DEXRCv/vAkKsmlU02zA5ZverRX/CsB3mXFHbNp550GOYm4Fd03wbYIy85mNXpE+a1vSsi44VQr3G74NvAkWG/aF0H7BbjviTpWhPQA6/P0pq1w9fKxTCmhIXf/5RJV5FbVicn8f3qPTZ+bcCO+V+0DfWEw9n+9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107829; c=relaxed/simple;
	bh=zK93UZTn2t7PGQ3H6iYrbXG4ZbFX30XxJbMiQ2s5Z6o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQZMT2PgbGsjcS1X2dIh3QKiB6Lt5oeSGfyHKoLHdPmqs/gDw9KHFM4oUcLpHJozEQZ6nvu+64q2SRuuxjLqPXMq+K/pbhnxkKtalbmDNopkEzdo0tNn9cMiq2rtQyTuY6IvwaR3EiNv/z1DIUu51NG6RUpfnRi5nZoJeGvrDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Z0B5rVxJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4da72b541f8so51421741cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107825; x=1759712625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRKEwXa1tg/M6bNaqOfoeFXrUpvvgwejj9DdMRFtL4w=;
        b=Z0B5rVxJDSr91zM/+frz61GmcvcSePgnhnSQtMyxvEcTWsebr44znOfryGcB/3AhSN
         xaX9KTmsnn3zsOXkmRwtCx9dOZcZii1jkzAkhh4W47WVK2iVMeMVl7VhsljxDNm5DnYV
         mrm65QLHMGDfq1z99nxqqGGAJqhoUfmdsU4MBGmWbMoeNmpkP72nqP5Uu/YzIk2BAwX9
         +apPgqDBFDEp6V2VgHnL9gtMGn6qn+ym0UADdI6HLgYmBeKACHkScDtqfWm8mLDxZB7b
         3Bcti+yLDegTnRPn/JfiAVzSoVG/Tai6eNWuHDrsaoBIYVkD6FNO6xOnwniUaQml5M4Y
         pMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107825; x=1759712625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRKEwXa1tg/M6bNaqOfoeFXrUpvvgwejj9DdMRFtL4w=;
        b=Xrwu+l9VL8WoU6eR3tfhepk+uk9hB2HNmTX7SipACTWv6CzHn4ug+FwBLg4t6Dv0pR
         owOOzWRydaEVJ1U2h8WWsE0fcuDvJc/JJ7TSP43jXUTUaWUh0T8/cuQ2S9OqDmd34pFD
         wh7JvcooVvVK05kmCpaAGcZUYw1ts3hX1YZpARr5WxKkcdhy810FVOCDDWD/pMfQ4eHr
         xDVR7RsDPIK0embvAcqoP58aqjeZgDmHMz/ds+pFqDS8QZfJH7H9BzRejpqUEV5X1Ud+
         jneZM8yVchHKZMy199lRhbtmIihDNZX0Ww6UNfZEZ8Em7IgDtG3kWw6yVouyrN4+owSF
         r0zg==
X-Forwarded-Encrypted: i=1; AJvYcCUVx8E7h5NMWpFS+eCELacqDBlc8Xrz3GFfZKxo1pTDT1X19JmE3i4Q2enBSnmaxgEKmXKHa3JjQaWm1Y0z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ErUkPBGOlW98Uf5sCB0UGagQuu7dIrXVCYxySC6ts55STtTw
	Vn97AMQwaAA8x1s8oUWgHm71jN/urGpz9cUMt58lMpQQ8efQ3irb6DxKR6Z0dFkx8ME=
X-Gm-Gg: ASbGncuP526i9Phm0ELfT+hoI07QG2DuvY3rqRD8TZG4NAvNy3to43rnbjpDofoU5S4
	GFeLemCyGZS8A/ewv0nv11iS9vD6IlzVG1yY61Mr2hzNwhFpMWJ/K5eODy9dMh4P4zZ0ybbsSzm
	Mq94Uy+twsi7IxDa6jFEPSMPvExCVEfCEZtROpKVAA4We0zTVmwsahjzqbmgiuFDP/0BMP8ZGto
	0RWnAQVFagNeoeLpIM1J2b1NZld9tg9NgdMxfhbVYIVp283uf8/syH55O5hm01HWZppDxRTpQI3
	n7bZHILSxLRcDC60JxxsAcAw4roZOGwJLbsqN8gHEUDMrD2+LUTKRQlBnHuKg0/6HskEeToWZ3M
	hk7+NYHqcs5qT1lGZyrmM4fGpwyOuLCwvrIdr149um9pooDQ7fu6fwI83C87AnXSEOgJERJR8w6
	4FbJzGGPpzc5vzO+LzlA==
X-Google-Smtp-Source: AGHT+IEwhqe/BqmKvNuWGS3uf0Nm2/PuSwk/9IAcyGtlVKkcjZXQAFpVwNkxDeP2e7Bl4f/no/k03w==
X-Received: by 2002:ac8:7e86:0:b0:4d9:c572:f9b6 with SMTP id d75a77b69052e-4da4bbe418cmr172161361cf.55.1759107824543;
        Sun, 28 Sep 2025 18:03:44 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:43 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 09/30] liveupdate: luo_subsystems: add subsystem registration
Date: Mon, 29 Sep 2025 01:03:00 +0000
Message-ID: <20250929010321.3462457-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
  KHO.
- Adds a stub API function liveupdate_get_subsystem_data() intended
  for subsystems to retrieve their persisted u64 data from the FDT
      in the new kernel.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h         |  66 +++++++
 kernel/liveupdate/Makefile         |   3 +-
 kernel/liveupdate/luo_core.c       |  19 +-
 kernel/liveupdate/luo_internal.h   |   7 +
 kernel/liveupdate/luo_subsystems.c | 291 +++++++++++++++++++++++++++++
 5 files changed, 383 insertions(+), 3 deletions(-)
 create mode 100644 kernel/liveupdate/luo_subsystems.c

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 85a6828c95b0..4c378a986cfe 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -12,6 +12,52 @@
 #include <linux/list.h>
 #include <uapi/linux/liveupdate.h>
 
+struct liveupdate_subsystem;
+
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
+ * @boot:         Optional. Call durng boot post live update. This callback is
+ *                done when subsystem register during live update.
+ * @finish:       Optional. Called after the live update is finished in the new
+ *                kernel.
+ *                Receives the u64 data set by prepare/freeze. Used for cleanup.
+ * @owner:        Module reference
+ */
+struct liveupdate_subsystem_ops {
+	int (*prepare)(struct liveupdate_subsystem *handle, u64 *data);
+	int (*freeze)(struct liveupdate_subsystem *handle, u64 *data);
+	void (*cancel)(struct liveupdate_subsystem *handle, u64 data);
+	void (*boot)(struct liveupdate_subsystem *handle, u64 data);
+	void (*finish)(struct liveupdate_subsystem *handle, u64 data);
+	struct module *owner;
+};
+
+/**
+ * struct liveupdate_subsystem - Represents a subsystem participating in LUO
+ * @ops:          Callback functions
+ * @name:         Unique name identifying the subsystem.
+ * @list:         List head used internally by LUO. Should not be modified by
+ *                caller after registration.
+ * @private_data: For LUO internal use, cached value of data field.
+ */
+struct liveupdate_subsystem {
+	const struct liveupdate_subsystem_ops *ops;
+	const char *name;
+	struct list_head list;
+	u64 private_data;
+};
+
 #ifdef CONFIG_LIVEUPDATE
 
 /* Return true if live update orchestrator is enabled */
@@ -33,6 +79,10 @@ bool liveupdate_state_normal(void);
 
 enum liveupdate_state liveupdate_get_state(void);
 
+int liveupdate_register_subsystem(struct liveupdate_subsystem *h);
+int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h);
+int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline int liveupdate_reboot(void)
@@ -60,5 +110,21 @@ static inline enum liveupdate_state liveupdate_get_state(void)
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
index d90cc3b4bf7b..2881bab0c6df 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -2,7 +2,8 @@
 
 luo-y :=								\
 		luo_core.o						\
-		luo_ioctl.o
+		luo_ioctl.o						\
+		luo_subsystems.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 10796481447a..92edaeaaad3e 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -130,6 +130,10 @@ static int luo_fdt_setup(void)
 	if (ret)
 		goto exit_free;
 
+	ret = luo_subsystems_fdt_setup(fdt_out);
+	if (ret)
+		goto exit_free;
+
 	ret = kho_add_subtree(LUO_KHO_ENTRY_NAME, fdt_out);
 	if (ret)
 		goto exit_free;
@@ -153,20 +157,30 @@ static void luo_fdt_destroy(void)
 
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
@@ -408,6 +422,7 @@ static int __init luo_startup(void)
 	}
 
 	__luo_set_state(LIVEUPDATE_STATE_UPDATED);
+	luo_subsystems_startup(luo_fdt_in);
 
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index c98842caa4a0..c62fbbb0790c 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -32,4 +32,11 @@ void *luo_contig_alloc_preserve(size_t size);
 void luo_contig_free_unpreserve(void *mem, size_t size);
 void luo_contig_free_restore(void *mem, size_t size);
 
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
index 000000000000..69f00d5c000e
--- /dev/null
+++ b/kernel/liveupdate/luo_subsystems.c
@@ -0,0 +1,291 @@
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
+#include <linux/module.h>
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
+	guard(mutex)(&luo_subsystem_list_mutex);
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
+ * node in the FDT. This node is considered mandatory.
+ */
+void __init luo_subsystems_startup(void *fdt)
+{
+	int ret, node_offset;
+
+	guard(mutex)(&luo_subsystem_list_mutex);
+	node_offset = fdt_subnode_offset(fdt, 0, LUO_SUBSYSTEMS_NODE_NAME);
+	if (node_offset < 0)
+		luo_restore_fail("Failed to find /subsystems node\n");
+
+	ret = fdt_node_check_compatible(fdt, node_offset,
+					LUO_SUBSYSTEMS_COMPATIBLE);
+	if (ret) {
+		luo_restore_fail("FDT '%s' is incompatible with '%s' [%d]\n",
+				 LUO_SUBSYSTEMS_NODE_NAME,
+				 LUO_SUBSYSTEMS_COMPATIBLE, ret);
+	}
+	luo_fdt_in = fdt;
+}
+
+static int luo_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
+{
+	return 0;
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
+	guard(mutex)(&luo_subsystem_list_mutex);
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
+	if (!try_module_get(h->ops->owner)) {
+		pr_warn("Subsystem '%s' unable to get reference.\n", h->name);
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	INIT_LIST_HEAD(&h->list);
+	list_add_tail(&h->list, &luo_subsystems_list);
+
+out_unlock:
+	/*
+	 * If we are booting during live update, and subsystem provided a boot
+	 * callback, do it now, since we know that subsystem has already
+	 * initialized.
+	 */
+	if (!ret && liveupdate_state_updated() && h->ops->boot) {
+		u64 data;
+
+		ret = luo_get_subsystem_data(h, &data);
+		if (!WARN_ON_ONCE(ret))
+			h->ops->boot(h, data);
+	}
+
+	luo_state_read_exit();
+
+	return ret;
+}
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
+	guard(mutex)(&luo_subsystem_list_mutex);
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
+	module_put(h->ops->owner);
+	luo_state_read_exit();
+
+	return ret;
+}
+
+int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
+{
+	return 0;
+}
-- 
2.51.0.536.g15c5d4f767-goog


