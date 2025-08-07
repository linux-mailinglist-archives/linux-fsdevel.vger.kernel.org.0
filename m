Return-Path: <linux-fsdevel+bounces-56944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 221ADB1D088
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479A61AA10BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0E24C676;
	Thu,  7 Aug 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Uajcy2Nr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C95238174
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531120; cv=none; b=a2F1J0FN1ZtB+iKhOSlGZFYWvXG1uswclc7QrVxuNAvog2VPmuRiJUjILjcstRqS23okbUHiyegki53fjWLX00feLm5YBI9J2EFDJiKbMirMygQ3J6VdoHkBS3fMysSXlMbIfoaCDCDDPDafyPXe5OI+jbqDcAJ0d6gJvtgdMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531120; c=relaxed/simple;
	bh=Rx/tyv8veGFGG2JeXQPCv++VWJ0RVIdQqE9qIDTRPF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOuXX+2px1J+4qjkWN6XZ0eU85OKxbt0mAGdHfAA+9UYhuQXRTKfeZt5XZ88iX9akajIK4MfglvHQFl+iEwvWA/kmu/le9YUrtbQKw4cijOq5jtFULi5s+3SSxzCltgrpYocGAMqdKhsGqT7HrC5c5+7mqQLLkEscqu0Ih/Xipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Uajcy2Nr; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0739c6557so7728321cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531115; x=1755135915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WF/QU/y7x54PCzdmrSK0bQUFRNe6CNoszBlEiHHR+XM=;
        b=Uajcy2Nr8ISkpfSUxoYPN7gxJWft3y/BStQ2jcAbnCuX+OEf2eqz9w+02DVZTChAJ7
         PyqjgWh+uICCm7U2fotjUUd8gvI1IcrEucWHvWYKUj880zxRYVzpULYnj2SYn6L5dKCZ
         SPe91YqdlwP0B9stb914coi1OIuYq7c93R9H0VbPD0mthrTz51wJ/wPLPFz9GNn5lIAf
         TJplvCEqoZt9tMrzXN/yMPTRd+FVgzLFZ/05zNmMqM8XeYJIQm1+S7aj9gaS1l6x1TKD
         5Vmu7yM40tskG/zQXoktaX0G/2coRfhnqIUlSi9HsvH4838D3Vg6Q6Ms6AdfPkvRVUPM
         LXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531115; x=1755135915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF/QU/y7x54PCzdmrSK0bQUFRNe6CNoszBlEiHHR+XM=;
        b=eCkUY6oFWLS7n40Z0aLt/2nGNSBNZn2rlhEzfN65twV3phaFYzA+vlEuapxvGGd8eT
         0AWA1giD/4p5VDlpiWbtXl89dKZbWI3FvpHwmH3QVBD85nr7bZzpxuYUaQ3+Uhh4hQM+
         iI/q+a2xN5QvmbJ0cGrTVYJ8bRa6768z09M0Bt3mfbd8qWAF1M9AmmXPu847yTLLdBv6
         AHFKE+uS+mTF1lUjKjJHZap3uM91AClyP1RRE3UViw/Rol1vDGzbqFQz0LVZpUa/r3os
         bwwpjkYWvDZpH9hrBRHdjWOHXrM8dHk8DPykiiE7P85axXdDwVjD5mQR1JjrWV01C+2Y
         zfkw==
X-Forwarded-Encrypted: i=1; AJvYcCXSlPUtu3SgWug7A96AvNyTYoxTW991w+lMBI1tOn7BCIIMG/F+/7vWg9QcLigtQBhj/21ZO8B1tp17hrYC@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOLKdkIfSvjOcnt0dQpB/33W7yxf8bj4ZJ9qonyQhraxXnPBS
	4KQ8Nt+j9Z16JLLJDF+T6g5iA0xHs5Quju2Rq8pLplfP3V5rW4AAoaRUy+vhhV2eNyQ=
X-Gm-Gg: ASbGnct88lbFGGMZMco0dZy92QrTd7Oh18j4JZA3mZ99C4n1vmR6yuVVx5hRqX2pT4l
	MzjAaCyjIVh8Dt5HA8YJKhXdIsKe+IjOtMv9DyYUFzJtsCt1JxStBNy9NGjSDqDOPt0abbzmM1o
	Jk2Fdx9bgEHjcRrEpITMCJrWYME0bQquuKI6QYmYpyUnfNfYZT/1xQpqhXsveiTa3t9fyyYXnI7
	4yuPqEkQvAh0v+s7DLQOTlmoaypybUPlfJ8+OGbiRiSzzczIYosOlTB98xacB5i5u1nKTW9w49t
	zLPM91Kp1QROX3+QbCh9Ta/98NabKSzIWYIp3jkCRnHyQ/5QL1sDXwmIWdx6136wfhkKzxWo4JW
	0hpnV8hQcUqepQJo7+FQ6ACz76sgJkWbq4SbBWKB+WPJBawYi1+iSaL5hyAHUmYdumWEExKM5Q0
	SKkSKbD1+GId/ePWkIpql1v0I=
X-Google-Smtp-Source: AGHT+IFKHH1YeAK0b2tzEkZQep5rY0nibsccM8bhcvnZ6YiF0cNDdr12cF9wjVLlo+2LNmKUV8uQBg==
X-Received: by 2002:ac8:6904:0:b0:4b0:6463:7d0d with SMTP id d75a77b69052e-4b0915c39d2mr77833781cf.42.1754531115362;
        Wed, 06 Aug 2025 18:45:15 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:14 -0700 (PDT)
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
Subject: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
Date: Thu,  7 Aug 2025 01:44:25 +0000
Message-ID: <20250807014442.3829950-20-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a sysfs interface for the Live Update Orchestrator
under /sys/kernel/liveupdate/. This interface provides a way for
userspace tools and scripts to monitor the current state of the LUO
state machine.

The main feature is a read-only file, state, which displays the
current LUO state as a string ("normal", "prepared", "frozen",
"updated"). The interface uses sysfs_notify to allow userspace
listeners (e.g., via poll) to be efficiently notified of state changes.

ABI documentation for this new sysfs interface is added in
Documentation/ABI/testing/sysfs-kernel-liveupdate.

This read-only sysfs interface complements the main ioctl interface
provided by /dev/liveupdate, which handles LUO control operations and
resource management.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../ABI/testing/sysfs-kernel-liveupdate       | 51 ++++++++++
 kernel/liveupdate/Kconfig                     | 18 ++++
 kernel/liveupdate/Makefile                    |  1 +
 kernel/liveupdate/luo_core.c                  |  1 +
 kernel/liveupdate/luo_internal.h              |  6 ++
 kernel/liveupdate/luo_sysfs.c                 | 92 +++++++++++++++++++
 6 files changed, 169 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
 create mode 100644 kernel/liveupdate/luo_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-liveupdate b/Documentation/ABI/testing/sysfs-kernel-liveupdate
new file mode 100644
index 000000000000..bb85cbae4943
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-liveupdate
@@ -0,0 +1,51 @@
+What:		/sys/kernel/liveupdate/
+Date:		May 2025
+KernelVersion:	6.16.0
+Contact:	pasha.tatashin@soleen.com
+Description:	Directory containing interfaces to query the live
+		update orchestrator. Live update is the ability to reboot the
+		host kernel (e.g., via kexec, without a full power cycle) while
+		keeping specifically designated devices operational ("alive")
+		across the transition. After the new kernel boots, these devices
+		can be re-attached to their original workloads (e.g., virtual
+		machines) with their state preserved. This is particularly
+		useful, for example, for quick hypervisor updates without
+		terminating running virtual machines.
+
+
+What:		/sys/kernel/liveupdate/state
+Date:		May 2025
+KernelVersion:	6.16.0
+Contact:	pasha.tatashin@soleen.com
+Description:	Read-only file that displays the current state of the live
+		update orchestrator as a string. Possible values are:
+
+		"normal"	No live update operation is in progress. This is
+				the default operational state.
+
+		"prepared"	The live update preparation phase has completed
+				successfully (e.g., triggered via the
+				/dev/liveupdate event). Kernel subsystems have
+				been notified via the %LIVEUPDATE_PREPARE
+				event/callback and should have initiated state
+				saving. User workloads (e.g., VMs) are generally
+				still running, but some operations (like device
+				unbinding or new DMA mappings) might be
+				restricted. The system is ready for the reboot
+				trigger.
+
+		"frozen"	The final reboot notification has been sent
+				(e.g., triggered via the 'reboot()' syscall),
+				corresponding to the %LIVEUPDATE_REBOOT kernel
+				event. Subsystems have had their final chance to
+				save state. User workloads must be suspended.
+				The system is about to execute the reboot into
+				the new kernel (imminent kexec). This state
+				corresponds to the "blackout window".
+
+		"updated"	The system has successfully rebooted into the
+				new kernel via live update. Restoration of
+				preserved resources can now occur (typically via
+				ioctl commands). The system is awaiting the
+				final 'finish' signal after user space completes
+				restoration tasks.
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index f6b0bde188d9..75a17ca8a592 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -29,6 +29,24 @@ config LIVEUPDATE
 
 	  If unsure, say N.
 
+config LIVEUPDATE_SYSFS_API
+	bool "Live Update sysfs monitoring interface"
+	depends on SYSFS
+	depends on LIVEUPDATE
+	help
+	  Enable a sysfs interface for the Live Update Orchestrator
+	  at /sys/kernel/liveupdate/.
+
+	  This allows monitoring the LUO state ('normal', 'prepared',
+	  'frozen', 'updated') via the read-only 'state' file.
+
+	  This interface complements the primary /dev/liveupdate ioctl
+	  interface, which handles the full update process.
+	  This sysfs API may be useful for scripting, or userspace monitoring
+	  needed to coordinate application restarts and minimize downtime.
+
+	  If unsure, say N.
+
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index c67fa2797796..47f5d0378a75 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
+obj-$(CONFIG_LIVEUPDATE_SYSFS_API)	+= luo_sysfs.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 64d53b31d6d8..bd07ee859112 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -100,6 +100,7 @@ static inline bool is_current_luo_state(enum liveupdate_state expected_state)
 static void __luo_set_state(enum liveupdate_state state)
 {
 	WRITE_ONCE(luo_state, state);
+	luo_sysfs_notify();
 }
 
 static inline void luo_set_state(enum liveupdate_state state)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 01bd0d3b023b..9091ed04c606 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -47,4 +47,10 @@ int luo_file_freeze(u64 token);
 int luo_file_cancel(u64 token);
 int luo_file_finish(u64 token);
 
+#ifdef CONFIG_LIVEUPDATE_SYSFS_API
+void luo_sysfs_notify(void);
+#else
+static inline void luo_sysfs_notify(void) {}
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_sysfs.c b/kernel/liveupdate/luo_sysfs.c
new file mode 100644
index 000000000000..935946bb741b
--- /dev/null
+++ b/kernel/liveupdate/luo_sysfs.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO sysfs interface
+ *
+ * Provides a sysfs interface at ``/sys/kernel/liveupdate/`` for monitoring LUO
+ * state.  Live update allows rebooting the kernel (via kexec) while preserving
+ * designated device state for attached workloads (e.g., VMs), useful for
+ * minimizing downtime during hypervisor updates.
+ *
+ * /sys/kernel/liveupdate/state
+ * ----------------------------
+ * - Permissions:  Read-only
+ * - Description:  Displays the current LUO state string.
+ * - Valid States:
+ *     @normal
+ *       Idle state.
+ *     @prepared
+ *       Preparation phase complete (triggered via '/dev/liveupdate'). Resources
+ *       checked, state saving initiated via %LIVEUPDATE_PREPARE event.
+ *       Workloads mostly running but may be restricted. Ready forreboot
+ *       trigger.
+ *     @frozen
+ *       Final reboot notification sent (triggered via 'reboot'). Corresponds to
+ *       %LIVEUPDATE_REBOOT event. Final state saving. Workloads must be
+ *       suspended. System about to kexec ("blackout window").
+ *     @updated
+ *       New kernel booted via live update. Awaiting 'finish' signal.
+ *
+ * Userspace Interaction & Blackout Window Reduction
+ * -------------------------------------------------
+ * Userspace monitors the ``state`` file to coordinate actions:
+ *   - Suspend workloads before @frozen state is entered.
+ *   - Initiate resource restoration upon entering @updated state.
+ *   - Resume workloads after restoration, minimizing downtime.
+ */
+
+#include <linux/kobject.h>
+#include <linux/liveupdate.h>
+#include <linux/sysfs.h>
+#include "luo_internal.h"
+
+static bool luo_sysfs_initialized;
+
+#define LUO_DIR_NAME	"liveupdate"
+
+void luo_sysfs_notify(void)
+{
+	if (luo_sysfs_initialized)
+		sysfs_notify(kernel_kobj, LUO_DIR_NAME, "state");
+}
+
+/* Show the current live update state */
+static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", luo_current_state_str());
+}
+
+static struct kobj_attribute state_attribute = __ATTR_RO(state);
+
+static struct attribute *luo_attrs[] = {
+	&state_attribute.attr,
+	NULL
+};
+
+static struct attribute_group luo_attr_group = {
+	.attrs = luo_attrs,
+	.name = LUO_DIR_NAME,
+};
+
+static int __init luo_init(void)
+{
+	int ret;
+
+	ret = sysfs_create_group(kernel_kobj, &luo_attr_group);
+	if (ret) {
+		pr_err("Failed to create group\n");
+		return ret;
+	}
+
+	luo_sysfs_initialized = true;
+	pr_info("Initialized\n");
+
+	return 0;
+}
+subsys_initcall(luo_init);
-- 
2.50.1.565.gc32cd1483b-goog


