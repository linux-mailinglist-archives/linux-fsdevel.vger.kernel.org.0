Return-Path: <linux-fsdevel+bounces-67477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0AC41AC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15D454F1074
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52630F954;
	Fri,  7 Nov 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IhsyqgB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013826A1AF
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549537; cv=none; b=e8UH+mUc22bGlTlLfncGmOh9XTUbMJ6nkWfRt3MVY9nQuxofD0en3Cp2hhb6LrGhswp7M3tKlJ/Sp3RAF8/3T4M1kigGqaHT62yy7V+40XG8MVs5IMKwxwr9E6h6j7slB43X3Qjx0DZ2UGs9FryDA10uC/TmqJ4AwXgkVpzu0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549537; c=relaxed/simple;
	bh=uQw6SGnZOWAOjWeWczV4MS6Gt9k2Q4Va7EYPM+WPPIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6klvwqlc/EH0EldtH9XL245aciWcBfr1I2ihdPgx62CcEJVmXQWHBKPr8QBsggvC6sjYAbcQb5vUxsifPMpQGlw6f+4IUWswbKvM+wr95iVS3psPHRkZ1Oody7zMFFqmCyBrpn2a28NjCzMe+nFDiNdVSnTy3S7Jc9g/Mr7vbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IhsyqgB4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7866dcf50b1so11446977b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549534; x=1763154334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zu+sQZxV/DK1mZF4LzYMVwMmIZV5lUcGvIMy5Jfwns0=;
        b=IhsyqgB4Wl6g+6wrOHs24i0Jry9ozWFeEy2Bg4w1ocms7sXzpMZf2bLJ+aApsbtW4l
         Pqoh1BMlhkOmKAM/fCCxXJpSo86siU56TjVXlqV41B3igpuXzDSyt3BnOmYrBzLLMCVY
         y/19DShA6MytWcWjvgCLGQtasW65niK22hOrAkmq6WooNGN5v3yQPrnBhEnRhkS78fKa
         GyNmZpuOCFjvoAdG7e83b2xDVeZbugZ+Ghrtlv+Hb1Bq2xx4QIYkhCDZxf4Ip0KZ/M35
         h7W9iqO0O9F/1e5AuwazYYTEb6bl7FFW6huWsPqH+DCT/yEn/iwKrcUjo5JMOUUcRtGD
         l2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549534; x=1763154334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zu+sQZxV/DK1mZF4LzYMVwMmIZV5lUcGvIMy5Jfwns0=;
        b=YLPlVQbWK5i4NqPgXJkra3g7jzwD2svUuMY3A/LcceDYa8wGwpejufHoLYE277EWU3
         0OYygh0mbeiDe7uoTibFPMEijYLx2FWyQDXY4bdNJswB7OoQD6Z//g8jzTHq2EAMDr3b
         QHUHgoux8wyhapj0IYqZ5ptzScoANh5khjO9tObm9jxRwyXJ5oEHYzy8t/ewm9OpPrhv
         VYbEuqsZG0NFQCNKvIGuMle+EttVCvseKUvNRonlEYU87mIEsL84BlYguRPrqwUGHLno
         5LOxBQf6qaT5f5VJj4A4VFHt8yDjqn9h9qq1zICWymoyTn8MluMiXHVMTby6H0p+a2z6
         98Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXTvKSWWmVs6YGPnnY2aJJ1EV6nTNrO4uNitrATqFsgblgjdgWIEWVZgPTpuwpe+ESaZ8fs++MUj3Q3XnKN@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUdKgmCu0UrwE7S7TkWae4fzUEMI5mjl/nEOpwgCC51UW+oDS
	AbcTG8F+dcBYJ/vCAXcv03f6USezP/kYqmbYEUTdnVIRlyxxS1JOTVH7JA12PJ6Kbg8=
X-Gm-Gg: ASbGncuJ46x/1t7vg3kzDDecPren4h7y1kl/MnKc/tH1IVQ6QnDDq66dBIYPcvN+87b
	7Ftf1dCbwU/0wyjySttjvFyflq+brJziFHs8UCAF41hX+mqmnj2Om0A5FmJbqRu3o9MN3QpzncH
	ssMfp8unXPUKUnIkOENEw6ciAVnZAcjMFBI7GScq2ykmTQw6dgQPaRvRfWlXbCpu1J4R+17O6uV
	gsG0hhfc0uQZgZWIRYMS3znesHE0Iubw6DzM77oXxiWt0eH7n3VQr/EKEFdNEOADdNxRmKgz3Me
	O6A/rYIuTKErCdm82gcYY/BVPqd9eCvyzNE9MO4S2Ao0cvVHZbsCcvo0iuXVP3i2huMMPQmp7y7
	S4y96DtTgW2IIEBLZquP6ljJfIbY2++XLKeNtBpo9oZoueiCEJMp3eUfvvPYM/tZnDbTFfWVfsh
	G64TJf1nJzU6uEf3rQRbleXBOUVa6lv3Z03kPyp3FVjcKyBBk3qplY3R9Pn9+jvyWuP5D+n3Q6N
	dIUNvdqjsyH
X-Google-Smtp-Source: AGHT+IGkl2IVxRZTWeoOPperMhisjG1fXbHj29RAaasJvCOsVAl4Mwy+BOKFhe1CUBjQYDl+bzz8kA==
X-Received: by 2002:a05:690c:9689:b0:784:841e:c044 with SMTP id 00721157ae682-787d54521a4mr7498967b3.59.1762549533932;
        Fri, 07 Nov 2025 13:05:33 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:33 -0800 (PST)
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
	chrisl@kernel.org
Subject: [PATCH v5 01/22] liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
Date: Fri,  7 Nov 2025 16:02:59 -0500
Message-ID: <20251107210526.257742-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
---
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 include/linux/liveupdate.h                    | 35 ++++++++
 include/uapi/linux/liveupdate.h               | 46 ++++++++++
 kernel/liveupdate/Kconfig                     | 27 ++++++
 kernel/liveupdate/Makefile                    |  6 ++
 kernel/liveupdate/luo_core.c                  | 86 +++++++++++++++++++
 kernel/liveupdate/luo_ioctl.c                 | 45 ++++++++++
 7 files changed, 247 insertions(+)
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_ioctl.c

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
index 000000000000..730b76625fec
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
+#include <linux/types.h>
+#include <linux/list.h>
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
index 1379a4c40b09..e1fdcf7f57f3 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -1,7 +1,34 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Google LLC.
+# Pasha Tatashin <pasha.tatashin@soleen.com>
+#
+# Live Update Orchestrator
+#
 
 menu "Live Update and Kexec HandOver"
 
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
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index f52ce1ebcf86..413722002b7a 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
+luo-y :=								\
+		luo_core.o						\
+		luo_ioctl.o
+
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
+
+obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
new file mode 100644
index 000000000000..0e1ab19fa1cd
--- /dev/null
+++ b/kernel/liveupdate/luo_core.c
@@ -0,0 +1,86 @@
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
+ * LUO framework itself is designed to be workload-agnostic. Much like Kernel
+ * Live Patching, which applies security fixes regardless of the workload,
+ * Live Update facilitates a full kernel version upgrade for any type of system.
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
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
new file mode 100644
index 000000000000..44d365185f7c
--- /dev/null
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include <linux/liveupdate.h>
+#include <linux/miscdevice.h>
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
+module_init(liveupdate_ioctl_init);
+
+static void __exit liveupdate_exit(void)
+{
+	misc_deregister(&luo_dev.miscdev);
+}
+module_exit(liveupdate_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pasha Tatashin");
+MODULE_DESCRIPTION("Live Update Orchestrator");
+MODULE_VERSION("0.1");
-- 
2.51.2.1041.gc1ab5b90ca-goog


