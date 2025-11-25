Return-Path: <linux-fsdevel+bounces-69807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09384C860EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A78EB35092D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FEF32A3C8;
	Tue, 25 Nov 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="A04ZTY6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C5329C5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089942; cv=none; b=sQRHfeXM1AsudGQQjCV3S1maOBjLcy6TvR6gHQAj62XwskMvdk+s9HCrYy1MGNwV3p2zVB2wAE9ZtiNGc7+fvkNoJyyLhRneEYSLGy+4p2Hxj8LxWNdZeQLyk2GOQMhWKovVJ/VGWZZldusUopeCXJFsVs+loV4N7JWKUTr4QOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089942; c=relaxed/simple;
	bh=WEusQLnBtna6buMpqlL2tqSWEtVqXOBlWahKJLdWuRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXLpcsuPchI9qadsHhsdw6LDGhD2l+sVdBefvzTXtEM13VJbI71FoTKjzNOE5VaSXj8SiPb8SOHrs7AKoZDz7P3CtJF2MXqzB5V3mvTvgK59Ou+3FsHWepovnxK26JtNI0LZwpjdiicQA269+Oli1kzLCsPl3//UkNJpArgF+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=A04ZTY6O; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7881b67da53so57750997b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089938; x=1764694738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVXlOcghSkBH1UGo3jOcilbAwCQIPzNeYGCZyURm31Q=;
        b=A04ZTY6OQHcT3KFLL9ZucmStLDLBiGXHZrKhDCqDYAanuHOGg01cQu9RtE5otmiYip
         xk9xIAt5MiuoV/Pafa72Nj+nBIyx2WKoUj7j+I+GRHFBq78zdiHMg12bziBHswHREg7E
         yXtYaMecke8nhihoeIny9SvmrJcDQhKgh81L5A+/hrY0ZoclFjC5naLAMBBAhiH57AgU
         Qu2GrfXnbNQk9AYx1f/yx9OovMe+0UX4ox0mwk8I4EFuCLFYyCzBXmnoXToy/aKayYin
         amUDvCg5BujiaM7f9JNWuboJIrPJK7ieb6YfMyQHVAUuhI2OcmbBbGHQl+NE5Ovg7LH6
         +3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089938; x=1764694738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZVXlOcghSkBH1UGo3jOcilbAwCQIPzNeYGCZyURm31Q=;
        b=YJCKv2Oz6prvGq1nM1N1wl6OB/Po0KDi/Fla6nPGaJp3/ruAO+fYc5UufMnPKBoMfI
         gYva6GfOuClNkdZ8lf+mkzfI2PEwrRFcRz6JwaUtooVj9zZqE9AWncf7a8MB+XH/x7dw
         JeY7nmQ15ynRnLBJHQvv7aH26tWiCaL0hm/dlopHznUuvyW3GuEJbWp0EsYrFUMnsdYU
         BsG1B9klj4B/d872NJa+eEsn5jGNXB1FWtSYqPdbohxrFVRRhF0x4BGrZJQkOTTYl0V+
         BFdentddXCKZepqyIPaNJvk+WLro+u/Hm1vzH5uIYmWBtLm0yA8yYiU7kC7E8DA2Smmk
         32LA==
X-Forwarded-Encrypted: i=1; AJvYcCVMjBsdqFGFzK7NjUoCk9b9buqElkLtbGzJuGVRrIhZgN5V6HQYOyRgXPp/LRdtkOdYXS5gO40zcphUx2AP@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHMp4qd11nzNTtrtFAnEmRYn7afJLMlol1/ged5TKBr7wXKVQ
	JxLAJhedu3YTGqshwDJKoWYtta0eV1wTnlIIXS/soeszV96mXBwS36iXa1EOvROp1oU=
X-Gm-Gg: ASbGncs6tjHfa1r+FX6fpUg7RhPX7EKXRJwK0Q2C5R8c5a+EqVkWuH1guqDE2u+fq5x
	F3zVbUkeFZdu1ihUk/4eiGLQ616Vxh4SaTEXnp2WaAdA9tMyJLpYKl9E7XCwv5H6nMFo1j1hU/p
	W5NIpIEe3L+jqVy/gKcv8JubRkoOFg3PdMOzjRAHe8FQVvO0FhhhbQCK6HNNICYr7JVz7jk/zM4
	Ieu6p1bccXPy832Vy3BjOgqdiuunrDBhOeRjnXBhTbpip+Yc3EgMFGNS+cGcznNjyHJxhGqdPt4
	wyT/CW0IlMC6cMoO0cxEJLKKHVDTavs4/P1BBhnnlX1k/VqO0/5IhL4+tX9EKHAfCY0+wk2oOKN
	aBvsYxlJWOgd4+FdmQVVIiGuTKOJIyZCzX2/R+l7ea87UqnLTBgFcNecWDb0EYM5O+iN2lYq+4y
	CRl0TJTXfr7UeicwLSiNbUNLeXuM1dYbBpw20ZXrPGygpNzATXc+WV4bTOM1RpdpBZ
X-Google-Smtp-Source: AGHT+IFzLqONdmoMxtvQP22Mx+4CTT73xksgrCrTHrFT5fvQtJf9pzYLQiDyCLe6HMYfhVNW4vvqQw==
X-Received: by 2002:a05:690c:4c13:b0:787:ce99:eaa0 with SMTP id 00721157ae682-78a8b580502mr146674547b3.70.1764089938106;
        Tue, 25 Nov 2025 08:58:58 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:58:57 -0800 (PST)
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
Subject: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato,
Date: Tue, 25 Nov 2025 11:58:31 -0500
Message-ID: <20251125165850.3389713-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 include/linux/liveupdate.h                    |  35 ++++++
 include/uapi/linux/liveupdate.h               |  46 ++++++++
 kernel/liveupdate/Kconfig                     |  21 ++++
 kernel/liveupdate/Makefile                    |   5 +
 kernel/liveupdate/luo_core.c                  | 111 ++++++++++++++++++
 6 files changed, 220 insertions(+)
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
index a973a54447de..9b2515f31afb 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -51,4 +51,25 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
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
2.52.0.460.gd25c4c69ec-goog


