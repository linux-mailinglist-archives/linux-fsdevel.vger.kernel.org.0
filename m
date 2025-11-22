Return-Path: <linux-fsdevel+bounces-69483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A2C7D8A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AEC534B565
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E32C1584;
	Sat, 22 Nov 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dKLAWaiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DD26CE33
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850241; cv=none; b=O7b27bXpkkE63hetKnkxnXpg5y0xTmdVDZ05GPkjhV8/Q8ugW/CRF6h8Cv8l1Jh+E6PciMq5WEdUlVH7vVLTRS636cXwnRcxYkREYdFjb6hFYDIqETHCJYFRwBOFa4xUyC703Z/12l11cIVNq1rROp6yNhy4kKDsN2c3kZ61ako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850241; c=relaxed/simple;
	bh=3JHb8VX+BStVVujQOo7zw0T1WjffUSPpJl7REIH8YgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNIssRQ1ErVJZucYNNOzt5dmk8bwyQs7foPAwh0CCkAvjR0UleiRSDOelM1hMTy3VVIqsyobjE00N3ss2Pu9ib7Fqug4GzANgvfE+vlEfwCfAFPUJdjeyTEKGTzOfRErbdeDIG/1psMfXXhZWab7BqHfhiwq9TdIl3/wxN5YDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dKLAWaiy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78a6c7ac3caso32356607b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850239; x=1764455039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNqa2AMoTm2GXKVPNq5SENNKpDOhG7qaiAonHBUruqY=;
        b=dKLAWaiyIjrbkuub0uVNEpRwUCJ2pCE6OUertFFe/8G1RRJ5ldxpYzhET7kX+Eq80u
         R/6pkBaak9GVTLeLW0+szHN0ZA7QiKGHf0Nu88QRiDOabYlYC6gN+1Hdzw3DZviNAHMk
         Ka2Xu0wwWKiZ9550cQkMFTPwCKv3tDIRqXxkoxGauIlKwqRj3Egh6uQQFx+fzzyCHhZX
         yPeY7JZQ7bLQk/9xofZUem51UiwMG3SL9Gjgp3LcFxgBz/vnmIYO4EJ19lbDdlTFIic5
         wbbY6M5ORY0nuCaGA5Cjdnfgd2CV4t2413N65CpdXZwFhkquvi3ATQbsSc2f5hBzy9aT
         GryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850239; x=1764455039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dNqa2AMoTm2GXKVPNq5SENNKpDOhG7qaiAonHBUruqY=;
        b=v3oaHC/y3ejyycMuWbwu4iaHXyKKrvMOC45xudrk2Xg0sHFBXCZ3YqdsnSZxkvEewR
         9bNQ7yMKuUBq1fRTUH7PlnT5EDYqFduRTQu9A1zc3Mp95nCR3q86DERF6C6ew/QuUOU6
         eTKGX2OSNC9HnZwDuZNDG1sW0c0UdD1SNOuNbPaZ3n9urd8+csaSMxmqWUnAXi63AWDe
         /3+DGf3O1DwugLxGKQbcAY03R46sz21aMZqcVyJ/pnz9on34MshbQQOAsdVeCTWya3YO
         Ke2/JAPb42B87YI3Qgd+4Dj9CAHY//lQLnibIXoWZQ+JsTHKLKE4aVFWatkm2460nFA+
         atUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/zuDlfbSGXRJ6VMg+q1gDyoY2e+dnv2mn8erRn0si0nQsoIXVaZrCd2wcRLoYrYPj7pUiIQZcIjWqOExw@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSKcDiHdzFUSdIRQJi43J/KgunrMw+Bv83I6Lc9DYYrBgsMJR
	KdKB2mNgxtbfLmNbaCBplGqXNkHiG7l2YC4GxokQIjj7up1WzkvzYmN/4ub4iqg3aiE=
X-Gm-Gg: ASbGncscPj3V+FB/2RJLeM3cVYTLR8HszAaBV3iCW7IvOnAWavp/WSldgllxL2UDx89
	g9J9t/9Yhh0zhE4J65c/JC4rhASrInDGm4Lxai1V2BlHpYIYbLK/BX8AdepGQ03zGD/epWfWVa9
	tVIctGWiDBi31xnaVRXEDoSERBFFSBE5l2GhhGcALiqQsLq/g44r7iHh/wTBIU4d1gzRPCm68PD
	suMBrrEWbKQtlrigS0qD6WMbarnq42Q93/FTq1nYYkGb32lXRQN5+gDoaGZi0H8lGHH+XeWPdb4
	unEfCQ2UYsLBsv7kK6jcf5cfdhFdkzv8ArvOgWmVodWXv8g5JsLbPR1n78OsUV36Nucm9GNLhRb
	85f0akhWRzxQUfrFFngqTeBmkUrbVXPCe1OWb7OePpadrViEesiwmBNgZkU3GLIATqJNuejLT4Q
	6aqv458j9xAr7qION5cwnrz36T+GcjdmcAruhnrrN0TXGTlAifLSeQQ/OwYqe0fxVs9aznPbX/N
	FMaZs4=
X-Google-Smtp-Source: AGHT+IF+QIPDkZ8c3ehnwAu2ppYoebnLrM6KhSaO+IvE/8Ir8krSEKQs+zG84x7hnCz9/ff0vwyg5w==
X-Received: by 2002:a05:690c:4b81:b0:788:1846:875d with SMTP id 00721157ae682-78a8b48b5bdmr59359977b3.29.1763850238778;
        Sat, 22 Nov 2025 14:23:58 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:23:58 -0800 (PST)
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
Subject: [PATCH v7 01/22] liveupdate: luo_core: Live Update Orchestrator
Date: Sat, 22 Nov 2025 17:23:28 -0500
Message-ID: <20251122222351.1059049-2-pasha.tatashin@soleen.com>
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

Introduce LUO, a mechanism intended to facilitate kernel updates while
keeping designated devices operational across the transition (e.g., via
kexec). The primary use case is updating hypervisors with minimal
disruption to running virtual machines. For userspace side of hypervisor
update we have copyless migration. LUO is for updating the kernel.

This initial patch lays the groundwork for the LUO subsystem.

Further functionality, including the implementation of state transition
logic, integration with KHO, and hooks for subsystems and file
descriptors, will be added in subsequent patches.

Create a character device at /dev/liveupdate.

A new uAPI header, <uapi/linux/liveupdate.h>, will define the necessary
structures. The magic number for IOCTL is registered in
Documentation/userspace-api/ioctl/ioctl-number.rst.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 include/linux/liveupdate.h                    |  35 ++++++
 include/uapi/linux/liveupdate.h               |  46 ++++++++
 kernel/liveupdate/Kconfig                     |  27 +++++
 kernel/liveupdate/Makefile                    |   5 +
 kernel/liveupdate/luo_core.c                  | 111 ++++++++++++++++++
 6 files changed, 226 insertions(+)
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_core.c

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 7c527a01d1cf..7232b3544cec 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -385,6 +385,8 @@ Code  Seq#    Include File                                             Comments
 0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                                Marvell CN10K DPI driver
 0xB8  all    uapi/linux/mshv.h                                         Microsoft Hyper-V /dev/mshv driver
                                                                        <mailto:linux-hyperv@vger.kernel.org>
+0xBA  00-0F  uapi/linux/liveupdate.h                                   Pasha Tatashin
+                                                                       <mailto:pasha.tatashin@soleen.com>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h                                           Dead since 6.15
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
new file mode 100644
index 000000000000..c6a1d6bd90cb
--- /dev/null
+++ b/include/linux/liveupdate.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef _LINUX_LIVEUPDATE_H
+#define _LINUX_LIVEUPDATE_H
+
+#include <linux/bug.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_LIVEUPDATE
+
+/* Return true if live update orchestrator is enabled */
+bool liveupdate_enabled(void);
+
+/* Called during kexec to tell LUO that entered into reboot */
+int liveupdate_reboot(void);
+
+#else /* CONFIG_LIVEUPDATE */
+
+static inline bool liveupdate_enabled(void)
+{
+	return false;
+}
+
+static inline int liveupdate_reboot(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_LIVEUPDATE */
+#endif /* _LINUX_LIVEUPDATE_H */
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
new file mode 100644
index 000000000000..df34c1642c4d
--- /dev/null
+++ b/include/uapi/linux/liveupdate.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+/*
+ * Userspace interface for /dev/liveupdate
+ * Live Update Orchestrator
+ *
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _UAPI_LIVEUPDATE_H
+#define _UAPI_LIVEUPDATE_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * DOC: General ioctl format
+ *
+ * The ioctl interface follows a general format to allow for extensibility. Each
+ * ioctl is passed in a structure pointer as the argument providing the size of
+ * the structure in the first u32. The kernel checks that any structure space
+ * beyond what it understands is 0. This allows userspace to use the backward
+ * compatible portion while consistently using the newer, larger, structures.
+ *
+ * ioctls use a standard meaning for common errnos:
+ *
+ *  - ENOTTY: The IOCTL number itself is not supported at all
+ *  - E2BIG: The IOCTL number is supported, but the provided structure has
+ *    non-zero in a part the kernel does not understand.
+ *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
+ *    understood, however a known field has a value the kernel does not
+ *    understand or support.
+ *  - EINVAL: Everything about the IOCTL was understood, but a field is not
+ *    correct.
+ *  - ENOENT: A provided token does not exist.
+ *  - ENOMEM: Out of memory.
+ *  - EOVERFLOW: Mathematics overflowed.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define LIVEUPDATE_IOCTL_TYPE		0xBA
+
+#endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index a973a54447de..90857dccb359 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Google LLC.
+# Pasha Tatashin <pasha.tatashin@soleen.com>
+#
+# Live Update Orchestrator
+#
 
 menu "Live Update and Kexec HandOver"
 	depends on !DEFERRED_STRUCT_PAGE_INIT
@@ -51,4 +57,25 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
 	  The default behavior can still be overridden at boot time by
 	  passing 'kho=off'.
 
+config LIVEUPDATE
+	bool "Live Update Orchestrator"
+	depends on KEXEC_HANDOVER
+	help
+	  Enable the Live Update Orchestrator. Live Update is a mechanism,
+	  typically based on kexec, that allows the kernel to be updated
+	  while keeping selected devices operational across the transition.
+	  These devices are intended to be reclaimed by the new kernel and
+	  re-attached to their original workload without requiring a device
+	  reset.
+
+	  Ability to handover a device from current to the next kernel depends
+	  on specific support within device drivers and related kernel
+	  subsystems.
+
+	  This feature primarily targets virtual machine hosts to quickly update
+	  the kernel hypervisor with minimal disruption to the running virtual
+	  machines.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index f52ce1ebcf86..08954c1770c4 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+luo-y :=								\
+		luo_core.o
+
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
+
+obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
new file mode 100644
index 000000000000..30ad8836360b
--- /dev/null
+++ b/kernel/liveupdate/luo_core.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Live Update Orchestrator (LUO)
+ *
+ * Live Update is a specialized, kexec-based reboot process that allows a
+ * running kernel to be updated from one version to another while preserving
+ * the state of selected resources and keeping designated hardware devices
+ * operational. For these devices, DMA activity may continue throughout the
+ * kernel transition.
+ *
+ * While the primary use case driving this work is supporting live updates of
+ * the Linux kernel when it is used as a hypervisor in cloud environments, the
+ * LUO framework itself is designed to be workload-agnostic. Live Update
+ * facilitates a full kernel version upgrade for any type of system.
+ *
+ * For example, a non-hypervisor system running an in-memory cache like
+ * memcached with many gigabytes of data can use LUO. The userspace service
+ * can place its cache into a memfd, have its state preserved by LUO, and
+ * restore it immediately after the kernel kexec.
+ *
+ * Whether the system is running virtual machines, containers, a
+ * high-performance database, or networking services, LUO's primary goal is to
+ * enable a full kernel update by preserving critical userspace state and
+ * keeping essential devices operational.
+ *
+ * The core of LUO is a mechanism that tracks the progress of a live update,
+ * along with a callback API that allows other kernel subsystems to participate
+ * in the process. Example subsystems that can hook into LUO include: kvm,
+ * iommu, interrupts, vfio, participating filesystems, and memory management.
+ *
+ * LUO uses Kexec Handover to transfer memory state from the current kernel to
+ * the next kernel. For more details see
+ * Documentation/core-api/kho/concepts.rst.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kobject.h>
+#include <linux/liveupdate.h>
+#include <linux/miscdevice.h>
+
+static struct {
+	bool enabled;
+} luo_global;
+
+static int __init early_liveupdate_param(char *buf)
+{
+	return kstrtobool(buf, &luo_global.enabled);
+}
+early_param("liveupdate", early_liveupdate_param);
+
+/* Public Functions */
+
+/**
+ * liveupdate_reboot() - Kernel reboot notifier for live update final
+ * serialization.
+ *
+ * This function is invoked directly from the reboot() syscall pathway
+ * if kexec is in progress.
+ *
+ * If any callback fails, this function aborts KHO, undoes the freeze()
+ * callbacks, and returns an error.
+ */
+int liveupdate_reboot(void)
+{
+	return 0;
+}
+
+/**
+ * liveupdate_enabled - Check if the live update feature is enabled.
+ *
+ * This function returns the state of the live update feature flag, which
+ * can be controlled via the ``liveupdate`` kernel command-line parameter.
+ *
+ * @return true if live update is enabled, false otherwise.
+ */
+bool liveupdate_enabled(void)
+{
+	return luo_global.enabled;
+}
+
+struct luo_device_state {
+	struct miscdevice miscdev;
+};
+
+static const struct file_operations luo_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static struct luo_device_state luo_dev = {
+	.miscdev = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name  = "liveupdate",
+		.fops  = &luo_fops,
+	},
+};
+
+static int __init liveupdate_ioctl_init(void)
+{
+	if (!liveupdate_enabled())
+		return 0;
+
+	return misc_register(&luo_dev.miscdev);
+}
+late_initcall(liveupdate_ioctl_init);
-- 
2.52.0.rc2.455.g230fcf2819-goog


