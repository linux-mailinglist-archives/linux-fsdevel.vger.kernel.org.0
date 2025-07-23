Return-Path: <linux-fsdevel+bounces-55850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E532B0F5FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2C61CC2768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788DF2FC3CD;
	Wed, 23 Jul 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="So7eXAwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD72FA640
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282045; cv=none; b=IWTNkM/47sOc+EiackNXwCwKjyKWsNSm4A9Q68bM2rrv/KshkcETr3w6ADeYx0loPEJdI5mI6Y9VdPkr3wZTh7TgByOuqLtGYe51VWcxV9RpiZCzk8jelm+YWt4dE2e/v09KYbcRleVRztWuAhkIw2MbaZkozZsxWwUfoS/Y+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282045; c=relaxed/simple;
	bh=6xtfxyIVDA3x4P9xsRb/FLVHQxnX4xAqJhNXgoG+/2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkMuoNHGirxMT8j+9WFQxWzzJhjNepxpEAgLNPmB6bdhEww75vQ9o8GMqmmJRx3wxCzT4xa+aAr/PV+lsl4vyVr1r7s7tCAIxda5XLDJTqknnD/mS6Wsq8Ejc+ZgVj2cAQkXKKS4Ul6qoNngWEu0nnueZrbEsI9Aikdu9+NHo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=So7eXAwP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-710e344bbf9so64513877b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282035; x=1753886835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXQSCYE6FRs6KbafkWlGbnDNp03kOfKlk9RAaFRpXVc=;
        b=So7eXAwPGlrRgtouaNFgWzwQcYiPyub3GZ69Tpmb2hgEMTCzWijyjtski32Wi2M+Q6
         CuLLwMTMFExMhWUsyQByuQNNrBkVqu7VATcy0kgo1nOseQgvmrIIGBYeW7IE8YiImk4s
         bBqrQEACQptuL9kk05/w/5iJOro6tEbb6BkWVNTO08noABtA8ID380lljw2atK5e5hu1
         En7rF5CiAeEb0Y4fj0DZEYqjqT/+dv5sG+j1zvNggJNnPJmsCEGMtYWqRJyUlBw8CGd3
         SlPxuRqdu92gRKo+T2pUuUxcCNtxscnuMfg4HLgWwXQzBQSC8iVkxx54jSBdITbL7+i9
         iiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282035; x=1753886835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXQSCYE6FRs6KbafkWlGbnDNp03kOfKlk9RAaFRpXVc=;
        b=cwZzrREO2TWaAQOKvFwVukMQ+7q86hvGHOoYqK2Oazpev9hnFzXqPJ2ribh4n/k0Re
         2gVT1JYvLT92GQp2+ths+0IWErubpE8SjFziwav7ME21xUHcXx1ooZ0BrTdh7ZWJ34Pd
         ySzx/D4/rPtA/a/6PHtFWpd7II3I2t+r1RJQcMOSdm7vNMiS0X1YTADg/a8n9pHkVYqg
         uVtpI82RcPrPq4aDr46YPK4ki9yIb6Qn9PqoLpLfHLaDsXeki9QA8F6EO1WAqHRA91A4
         SIhfjUDT7HqxY9cLaLe3qf7SIL7DB4B0PcljId68l0RhQ4MllUq8pKEgBeKV3CbsbVYk
         K0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUcNIBUFXGgvUWr7p/kG2iVcg0TTmmvpeXV9zvXoGsXGWlaqCCa5j6hwf2bfrKHN62fwVNEflCpO9GStGpV@vger.kernel.org
X-Gm-Message-State: AOJu0YxBV4JqsCjCqr1xKgOxTfqYFTH7NAHT+NFbNfWH2mvtmNjxzJEK
	IMcjHRhRgabdV/m/iySAzGmuKx6Nt7CeYUKV4xnZnm+QcVtX9Adr9MEewsxgGi6Q7Sg=
X-Gm-Gg: ASbGnctVRWessN/QEna/qv8MmPDceFa20fnq3VEaJH1hafXpc79KOTNoDTW4oDK9QKh
	ZAmFJL8hUKOBbFOJpgSua+D1mAL2XzAzwjdzeK33SLDkIll0awE+R7lYXTE00Uo4DkpSB/ZTSlg
	XQHuOujYPuhN9Ue2FHfUjYiYEyapYFJL64HnEfda9+71o+Dbomd9jvvz30yvCSe25v2rL3L9iH+
	VVXjUIZhAbiTRaq7EsnZnzdMyk/6cWjPy/oQrjMYXaaNB+6DAdDgkjKM5mor4Czn13GE2zzThMB
	6S7IoLQsgpKQT++vVF+qxxvJuMDSzujGw01UE3PdV2mRpsKflr5LTq9pKHdshwo96sGxDPOkXEL
	aV1qsG6eTxIrUIWP7S/uDhABZroONxFYwMSQcG71lo7xw82VOO1DZ2arLhPbDTA+dglgYdGusqm
	e2/m2AbYAFAs9jlg==
X-Google-Smtp-Source: AGHT+IGfTs7pf0AbBWquufObMODOggfiGd1fHBHu+qiKXvkfWPENf9ewiJ9dh+/X4YXAKKzqsynwKg==
X-Received: by 2002:a05:690c:74c3:b0:710:f1da:1b5f with SMTP id 00721157ae682-719b424d284mr43190267b3.34.1753282034740;
        Wed, 23 Jul 2025 07:47:14 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:14 -0700 (PDT)
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
	witu@nvidia.com
Subject: [PATCH v2 10/32] liveupdate: luo_core: Live Update Orchestrator
Date: Wed, 23 Jul 2025 14:46:23 +0000
Message-ID: <20250723144649.1696299-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h       | 140 ++++++++++++++
 kernel/liveupdate/Kconfig        |  27 +++
 kernel/liveupdate/Makefile       |   1 +
 kernel/liveupdate/luo_core.c     | 301 +++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  21 +++
 5 files changed, 490 insertions(+)
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_internal.h

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
new file mode 100644
index 000000000000..da8f05c81e51
--- /dev/null
+++ b/include/linux/liveupdate.h
@@ -0,0 +1,140 @@
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
+/**
+ * enum liveupdate_event - Events that trigger live update callbacks.
+ * @LIVEUPDATE_PREPARE: PREPARE should happen *before* the blackout window.
+ *                      Subsystems should prepare for an upcoming reboot by
+ *                      serializing their states. However, it must be considered
+ *                      that user applications, e.g. virtual machines are still
+ *                      running during this phase.
+ * @LIVEUPDATE_FREEZE:  FREEZE sent from the reboot() syscall, when the current
+ *                      kernel is on its way out. This is the final opportunity
+ *                      for subsystems to save any state that must persist
+ *                      across the reboot. Callbacks for this event should be as
+ *                      fast as possible since they are on the critical path of
+ *                      rebooting into the next kernel.
+ * @LIVEUPDATE_FINISH:  FINISH is sent in the newly booted kernel after a
+ *                      successful live update and normally *after* the blackout
+ *                      window. Subsystems should perform any final cleanup
+ *                      during this phase. This phase also provides an
+ *                      opportunity to clean up devices that were preserved but
+ *                      never explicitly reclaimed during the live update
+ *                      process. State restoration should have already occurred
+ *                      before this event. Callbacks for this event must not
+ *                      fail. The completion of this call transitions the
+ *                      machine from ``updated`` to ``normal`` state.
+ * @LIVEUPDATE_CANCEL:  CANCEL the live update and go back to normal state. This
+ *                      event is user initiated, or is done automatically when
+ *                      LIVEUPDATE_PREPARE or LIVEUPDATE_FREEZE stage fails.
+ *                      Subsystems should revert any actions taken during the
+ *                      corresponding prepare event. Callbacks for this event
+ *                      must not fail.
+ *
+ * These events represent the different stages and actions within the live
+ * update process that subsystems (like device drivers and bus drivers)
+ * need to be aware of to correctly serialize and restore their state.
+ *
+ */
+enum liveupdate_event {
+	LIVEUPDATE_PREPARE,
+	LIVEUPDATE_FREEZE,
+	LIVEUPDATE_FINISH,
+	LIVEUPDATE_CANCEL,
+};
+
+/**
+ * enum liveupdate_state - Defines the possible states of the live update
+ * orchestrator.
+ * @LIVEUPDATE_STATE_UNDEFINED:      State has not yet been initialized.
+ * @LIVEUPDATE_STATE_NORMAL:         Default state, no live update in progress.
+ * @LIVEUPDATE_STATE_PREPARED:       Live update is prepared for reboot; the
+ *                                   LIVEUPDATE_PREPARE callbacks have completed
+ *                                   successfully.
+ *                                   Devices might operate in a limited state
+ *                                   for example the participating devices might
+ *                                   not be allowed to unbind, and also the
+ *                                   setting up of new DMA mappings might be
+ *                                   disabled in this state.
+ * @LIVEUPDATE_STATE_FROZEN:         The final reboot event
+ *                                   (%LIVEUPDATE_FREEZE) has been sent, and the
+ *                                   system is performing its final state saving
+ *                                   within the "blackout window". User
+ *                                   workloads must be suspended. The actual
+ *                                   reboot (kexec) into the next kernel is
+ *                                   imminent.
+ * @LIVEUPDATE_STATE_UPDATED:        The system has rebooted into the next
+ *                                   kernel via live update the system is now
+ *                                   running the next kernel, awaiting the
+ *                                   finish event.
+ *
+ * These states track the progress and outcome of a live update operation.
+ */
+enum liveupdate_state  {
+	LIVEUPDATE_STATE_UNDEFINED = 0,
+	LIVEUPDATE_STATE_NORMAL = 1,
+	LIVEUPDATE_STATE_PREPARED = 2,
+	LIVEUPDATE_STATE_FROZEN = 3,
+	LIVEUPDATE_STATE_UPDATED = 4,
+};
+
+#ifdef CONFIG_LIVEUPDATE
+
+/* Return true if live update orchestrator is enabled */
+bool liveupdate_enabled(void);
+
+/* Called during reboot to tell participants to complete serialization */
+int liveupdate_reboot(void);
+
+/*
+ * Return true if machine is in updated state (i.e. live update boot in
+ * progress)
+ */
+bool liveupdate_state_updated(void);
+
+/*
+ * Return true if machine is in normal state (i.e. no live update in progress).
+ */
+bool liveupdate_state_normal(void);
+
+enum liveupdate_state liveupdate_get_state(void);
+
+#else /* CONFIG_LIVEUPDATE */
+
+static inline int liveupdate_reboot(void)
+{
+	return 0;
+}
+
+static inline bool liveupdate_enabled(void)
+{
+	return false;
+}
+
+static inline bool liveupdate_state_updated(void)
+{
+	return false;
+}
+
+static inline bool liveupdate_state_normal(void)
+{
+	return true;
+}
+
+static inline enum liveupdate_state liveupdate_get_state(void)
+{
+	return LIVEUPDATE_STATE_NORMAL;
+}
+
+#endif /* CONFIG_LIVEUPDATE */
+#endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index eebe564b385d..f6b0bde188d9 100644
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
 
 menu "Live Update"
 
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
index 72cf7a8e6739..b3c72c405780 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
+obj-$(CONFIG_LIVEUPDATE)		+= luo_core.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
new file mode 100644
index 000000000000..8cee093807ff
--- /dev/null
+++ b/kernel/liveupdate/luo_core.c
@@ -0,0 +1,301 @@
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
+ * The core of LUO is a state machine that tracks the progress of a live update,
+ * along with a callback API that allows other kernel subsystems to participate
+ * in the process. Example subsystems that can hook into LUO include: kvm,
+ * iommu, interrupts, vfio, participating filesystems, and memory management.
+ *
+ * LUO uses Kexec Handover to transfer memory state from the current kernel to
+ * the next kernel. For more details see
+ * Documentation/core-api/kho/concepts.rst.
+ *
+ * The LUO state machine ensures that operations are performed in the correct
+ * sequence and provides a mechanism to track and recover from potential
+ * failures.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/err.h>
+#include <linux/kobject.h>
+#include <linux/liveupdate.h>
+#include <linux/rwsem.h>
+#include <linux/string.h>
+#include "luo_internal.h"
+
+static DECLARE_RWSEM(luo_state_rwsem);
+
+static enum liveupdate_state luo_state = LIVEUPDATE_STATE_UNDEFINED;
+
+static const char *const luo_state_str[] = {
+	[LIVEUPDATE_STATE_UNDEFINED]	= "undefined",
+	[LIVEUPDATE_STATE_NORMAL]	= "normal",
+	[LIVEUPDATE_STATE_PREPARED]	= "prepared",
+	[LIVEUPDATE_STATE_FROZEN]	= "frozen",
+	[LIVEUPDATE_STATE_UPDATED]	= "updated",
+};
+
+static bool luo_enabled;
+
+static int __init early_liveupdate_param(char *buf)
+{
+	return kstrtobool(buf, &luo_enabled);
+}
+early_param("liveupdate", early_liveupdate_param);
+
+/* Return true if the current state is equal to the provided state */
+static inline bool is_current_luo_state(enum liveupdate_state expected_state)
+{
+	return liveupdate_get_state() == expected_state;
+}
+
+static void __luo_set_state(enum liveupdate_state state)
+{
+	WRITE_ONCE(luo_state, state);
+}
+
+static inline void luo_set_state(enum liveupdate_state state)
+{
+	pr_info("Switched from [%s] to [%s] state\n",
+		luo_current_state_str(), luo_state_str[state]);
+	__luo_set_state(state);
+}
+
+static int luo_do_freeze_calls(void)
+{
+	return 0;
+}
+
+static void luo_do_finish_calls(void)
+{
+}
+
+/* Get the current state as a string */
+const char *luo_current_state_str(void)
+{
+	return luo_state_str[liveupdate_get_state()];
+}
+
+enum liveupdate_state liveupdate_get_state(void)
+{
+	return READ_ONCE(luo_state);
+}
+
+int luo_prepare(void)
+{
+	return 0;
+}
+
+/**
+ * luo_freeze() - Initiate the final freeze notification phase for live update.
+ *
+ * Attempts to transition the live update orchestrator state from
+ * %LIVEUPDATE_STATE_PREPARED to %LIVEUPDATE_STATE_FROZEN. This function is
+ * typically called just before the actual reboot system call (e.g., kexec)
+ * is invoked, either directly by the orchestration tool or potentially from
+ * within the reboot syscall path itself.
+ *
+ * @return  0: Success. Negative error otherwise. State is reverted to
+ * %LIVEUPDATE_STATE_NORMAL in case of an error during callbacks, and everything
+ * is canceled via cancel notifcation.
+ */
+int luo_freeze(void)
+{
+	int ret;
+
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn("[freeze] event canceled by user\n");
+		return -EAGAIN;
+	}
+
+	if (!is_current_luo_state(LIVEUPDATE_STATE_PREPARED)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_FROZEN],
+			luo_current_state_str());
+		up_write(&luo_state_rwsem);
+
+		return -EINVAL;
+	}
+
+	ret = luo_do_freeze_calls();
+	if (!ret)
+		luo_set_state(LIVEUPDATE_STATE_FROZEN);
+	else
+		luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+	up_write(&luo_state_rwsem);
+
+	return ret;
+}
+
+/**
+ * luo_finish - Finalize the live update process in the new kernel.
+ *
+ * This function is called  after a successful live update reboot into a new
+ * kernel, once the new kernel is ready to transition to the normal operational
+ * state. It signals the completion of the live update sequence to subsystems.
+ *
+ * @return 0 on success, ``-EAGAIN`` if the state change was cancelled by the
+ * user while waiting for the lock, or ``-EINVAL`` if the orchestrator is not in
+ * the updated state.
+ */
+int luo_finish(void)
+{
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn("[finish] event canceled by user\n");
+		return -EAGAIN;
+	}
+
+	if (!is_current_luo_state(LIVEUPDATE_STATE_UPDATED)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_NORMAL],
+			luo_current_state_str());
+		up_write(&luo_state_rwsem);
+
+		return -EINVAL;
+	}
+
+	luo_do_finish_calls();
+	luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+	up_write(&luo_state_rwsem);
+
+	return 0;
+}
+
+int luo_cancel(void)
+{
+	return 0;
+}
+
+void luo_state_read_enter(void)
+{
+	down_read(&luo_state_rwsem);
+}
+
+void luo_state_read_exit(void)
+{
+	up_read(&luo_state_rwsem);
+}
+
+static int __init luo_startup(void)
+{
+	__luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+	return 0;
+}
+early_initcall(luo_startup);
+
+/* Public Functions */
+
+/**
+ * liveupdate_reboot() - Kernel reboot notifier for live update final
+ * serialization.
+ *
+ * This function is invoked directly from the reboot() syscall pathway if a
+ * reboot is initiated while the live update state is %LIVEUPDATE_STATE_PREPARED
+ * (i.e., if the user did not explicitly trigger the frozen state). It handles
+ * the implicit transition into the final frozen state.
+ *
+ * It triggers the %LIVEUPDATE_REBOOT event callbacks for participating
+ * subsystems. These callbacks must perform final state saving very quickly as
+ * they execute during the blackout period just before kexec.
+ *
+ * If any %LIVEUPDATE_FREEZE callback fails, this function triggers the
+ * %LIVEUPDATE_CANCEL event for all participants to revert their state, aborts
+ * the live update, and returns an error.
+ */
+int liveupdate_reboot(void)
+{
+	if (!is_current_luo_state(LIVEUPDATE_STATE_PREPARED))
+		return 0;
+
+	return luo_freeze();
+}
+EXPORT_SYMBOL_GPL(liveupdate_reboot);
+
+/**
+ * liveupdate_state_updated - Check if the system is in the live update
+ * 'updated' state.
+ *
+ * This function checks if the live update orchestrator is in the
+ * ``LIVEUPDATE_STATE_UPDATED`` state. This state indicates that the system has
+ * successfully rebooted into a new kernel as part of a live update, and the
+ * preserved devices are expected to be in the process of being reclaimed.
+ *
+ * This is typically used by subsystems during early boot of the new kernel
+ * to determine if they need to attempt to restore state from a previous
+ * live update.
+ *
+ * @return true if the system is in the ``LIVEUPDATE_STATE_UPDATED`` state,
+ * false otherwise.
+ */
+bool liveupdate_state_updated(void)
+{
+	return is_current_luo_state(LIVEUPDATE_STATE_UPDATED);
+}
+EXPORT_SYMBOL_GPL(liveupdate_state_updated);
+
+/**
+ * liveupdate_state_normal - Check if the system is in the live update 'normal'
+ * state.
+ *
+ * This function checks if the live update orchestrator is in the
+ * ``LIVEUPDATE_STATE_NORMAL`` state. This state indicates that no live update
+ * is in progress. It represents the default operational state of the system.
+ *
+ * This can be used to gate actions that should only be performed when no
+ * live update activity is occurring.
+ *
+ * @return true if the system is in the ``LIVEUPDATE_STATE_NORMAL`` state,
+ * false otherwise.
+ */
+bool liveupdate_state_normal(void)
+{
+	return is_current_luo_state(LIVEUPDATE_STATE_NORMAL);
+}
+EXPORT_SYMBOL_GPL(liveupdate_state_normal);
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
+	return luo_enabled;
+}
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
new file mode 100644
index 000000000000..3d10f3eb20a7
--- /dev/null
+++ b/kernel/liveupdate/luo_internal.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _LINUX_LUO_INTERNAL_H
+#define _LINUX_LUO_INTERNAL_H
+
+int luo_cancel(void);
+int luo_prepare(void);
+int luo_freeze(void);
+int luo_finish(void);
+
+void luo_state_read_enter(void);
+void luo_state_read_exit(void);
+
+const char *luo_current_state_str(void);
+
+#endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


