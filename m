Return-Path: <linux-fsdevel+bounces-55856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A96B0F612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92479672E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE17A2FE315;
	Wed, 23 Jul 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="z7kLsxSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171A2FC3DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282056; cv=none; b=OiRJvmQwJ04XPXk11i/DhX18CpkyIr9aIeq7re3pVWb3fUUX7Y5XzDxtrKqWeAoIjyxrZjePwD+nMcJHxaBJAusDLwKCbalzMMtL9joZ45/F+8G744gzX14Gg0s9v5yn2FKASgJ6zLfLEkW6JiQVTko7QB+g4WFeXXuN1yUqP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282056; c=relaxed/simple;
	bh=S+USuASgiAWLoGLEg40jmspH2nuy/XVSxxvs0BOFsVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD0nkgTuIqfAgSdRXZze06erve2XO1RE5710da9nNr3+zCEX9BqwKiMFt4Us9j2/PD56MIETuF/FLQsYy9WtXeinhZKu1bRQc7UQFJR6OxXN+Dor/plgPyg1jaTHcx4CwRAV5/o6fYhVpORgZRtjmmd0C+73L7pkUJb+8gwcJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=z7kLsxSx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-719728a1811so44998137b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282048; x=1753886848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9OeQwvAtSpE7KYIsGHzDzwJJRVZThZJEHAd4sog2is=;
        b=z7kLsxSxz4m6w2WyWBlzth234hZUWBRLrqHjQkvTXD1xT/61UYCkFSBiRGMANXP8Hc
         aGAYKsZuDu6lzBeiavvC1xrXhTUSC6S5uCYnAmWh/pRroMZhtMkWp/pr0lgxoMBYSJiq
         KdmnInZQM63Z3hHfIth7YgyLfJ7MzEFmC+a7VCNf94oHVsJCrHReuCiybbJGma5Tcy9H
         APCILb31/1PzSO46ySORPouWI5Iu5PoIjfssjRHJBlHzl1Fh87KA9UQ6+EwjFEJUatrI
         wZy3obPlpd/K0Ymanl2EAS6NH9or6A8queBazweQFiay72OY343xmVxp2uPwJ9BJHl6P
         Ur0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282048; x=1753886848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9OeQwvAtSpE7KYIsGHzDzwJJRVZThZJEHAd4sog2is=;
        b=YlK2FsysmYNxR8Bxz60tBGn8tFUa18v/CvAPK09uGX49F4wEQbNuSihvuz12EI6so5
         PLffRLk5Pn9txn4Es/YYz+osbsDGxrH4H+MuXc+kPnK56fv7O8TlCwrmpayUw9WI0Yds
         YRKmIHxEKQTY4n7f9A2ZtdcfVpzolx6ambapEQ2ei3Qh7W4u/e6qtLxF+WhkE9xsSfxF
         VESjQ/+4eQCFZbvs7JXVH2saW+445lPUMnniy+deaFU3ejJwrMuISRvP/zKPukjexcwR
         d8aawrpUzjVljuhAKhcLzq3vBYKNwpcSoBuLCNcXJ2T0XYXi6OoFQQfnIKycUEUnm5hX
         3HHA==
X-Forwarded-Encrypted: i=1; AJvYcCXpiTg08os+HjSsRQ8uT2JNCXnFsNn5AD2mffIIBBwCsWLmJeGxOnv0wQJ/IcNK03ReJp5I1t16BGEOLjMC@vger.kernel.org
X-Gm-Message-State: AOJu0YySu6f5F3+eoura0TEnvTpVDyTXnfJ9OPMy7IHO80Iu+YJrrsJd
	5ZcBKaCCUhqaHeBdNE0gRsfWI778HO8UeU3XcYj2evpOYU3mkarz5LcOtZQ7ovRJn5M=
X-Gm-Gg: ASbGncut5kf/WIeEVr2EHZOpKSf0oW06JBAm/+e1JD9ENbQ6LAFpeZ9HBBnEF6FLNz7
	5pcK9xZPMvtO0mq+f8/EkuLzEXAePoM44lJ8dA8TBTckBeujk8lUT+7ixSxLihD3UDiehJR/Qlw
	hh3tEAFOvZAxbL9BS7HBO63/tT1C4r2O04TYFuffTvoo8p3InZEF/hn0H8VLiMXsqmyBm2yG55M
	DCC6ndquoGNQrtWMtxFaUV0qCYgOh354ch/dyncLsOegHMGta+tU/4FLxzL3KGiHeDar6xyeoAa
	bt+ZP7NUS9g5PKJvyoRmUS0zUnFz7WqYKe/mlXZo23pbr2tyGkyONd7FDoqx1J8VcNIS5CRA0Tx
	pjcTs+1cGmmAuOI77ZadD/csMfXuv8EBdghfy0tGYfh5rS+mXcS/S2kUJvy5vB7AXjjfP5uxj+/
	4UcPoqYQqG0Pg7lhtMxq2USIHB
X-Google-Smtp-Source: AGHT+IF4tR956kUR9cpPnn2sFwi5VeVXYICzL+BOy6UFPlMUfshdtWwybksAvrcMrknJvRf/sOFakA==
X-Received: by 2002:a05:690c:4d83:b0:70e:7503:1181 with SMTP id 00721157ae682-719b41660f4mr39787257b3.18.1753282047128;
        Wed, 23 Jul 2025 07:47:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:26 -0700 (PDT)
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
Subject: [PATCH v2 16/32] liveupdate: luo_ioctl: add ioctl interface
Date: Wed, 23 Jul 2025 14:46:29 +0000
Message-ID: <20250723144649.1696299-17-pasha.tatashin@soleen.com>
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

Introduce the user-space interface for the Live Update Orchestrator
via ioctl commands, enabling external control over the live update
process and management of preserved resources.

Create a character device at /dev/liveupdate. Access
to this device requires the CAP_SYS_ADMIN capability.

A new uAPI header, <uapi/linux/liveupdate.h>, defines the necessary
structures. The magic number is registered in
Documentation/userspace-api/ioctl/ioctl-number.rst.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 include/linux/liveupdate.h                    |  36 +--
 include/uapi/linux/liveupdate.h               | 265 ++++++++++++++++++
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/luo_ioctl.c                 | 178 ++++++++++++
 5 files changed, 447 insertions(+), 35 deletions(-)
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_ioctl.c

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index bc91756bde73..8368aa05b4df 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -380,6 +380,8 @@ Code  Seq#    Include File                                           Comments
 0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI driver
 0xB8  all    uapi/linux/mshv.h                                       Microsoft Hyper-V /dev/mshv driver
                                                                      <mailto:linux-hyperv@vger.kernel.org>
+0xBA  all    uapi/linux/liveupdate.h                                 Pasha Tatashin
+                                                                     <mailto:pasha.tatashin@soleen.com>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h                                         Dead since 6.15
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 28a8aa4cafca..970447de5d8c 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -10,6 +10,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <uapi/linux/liveupdate.h>
 
 /**
  * enum liveupdate_event - Events that trigger live update callbacks.
@@ -53,41 +54,6 @@ enum liveupdate_event {
 	LIVEUPDATE_CANCEL,
 };
 
-/**
- * enum liveupdate_state - Defines the possible states of the live update
- * orchestrator.
- * @LIVEUPDATE_STATE_UNDEFINED:      State has not yet been initialized.
- * @LIVEUPDATE_STATE_NORMAL:         Default state, no live update in progress.
- * @LIVEUPDATE_STATE_PREPARED:       Live update is prepared for reboot; the
- *                                   LIVEUPDATE_PREPARE callbacks have completed
- *                                   successfully.
- *                                   Devices might operate in a limited state
- *                                   for example the participating devices might
- *                                   not be allowed to unbind, and also the
- *                                   setting up of new DMA mappings might be
- *                                   disabled in this state.
- * @LIVEUPDATE_STATE_FROZEN:         The final reboot event
- *                                   (%LIVEUPDATE_FREEZE) has been sent, and the
- *                                   system is performing its final state saving
- *                                   within the "blackout window". User
- *                                   workloads must be suspended. The actual
- *                                   reboot (kexec) into the next kernel is
- *                                   imminent.
- * @LIVEUPDATE_STATE_UPDATED:        The system has rebooted into the next
- *                                   kernel via live update the system is now
- *                                   running the next kernel, awaiting the
- *                                   finish event.
- *
- * These states track the progress and outcome of a live update operation.
- */
-enum liveupdate_state  {
-	LIVEUPDATE_STATE_UNDEFINED = 0,
-	LIVEUPDATE_STATE_NORMAL = 1,
-	LIVEUPDATE_STATE_PREPARED = 2,
-	LIVEUPDATE_STATE_FROZEN = 3,
-	LIVEUPDATE_STATE_UPDATED = 4,
-};
-
 struct file;
 
 /**
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
new file mode 100644
index 000000000000..7b12a1073c3c
--- /dev/null
+++ b/include/uapi/linux/liveupdate.h
@@ -0,0 +1,265 @@
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
+/**
+ * struct liveupdate_fd - Holds parameters for preserving and restoring file
+ * descriptors across live update.
+ * @fd:    Input for %LIVEUPDATE_IOCTL_FD_PRESERVE: The user-space file
+ *         descriptor to be preserved.
+ *         Output for %LIVEUPDATE_IOCTL_FD_RESTORE: The new file descriptor
+ *         representing the fully restored kernel resource.
+ * @flags: Unused, reserved for future expansion, must be set to 0.
+ * @token: Input for %LIVEUPDATE_IOCTL_FD_PRESERVE: An opaque, unique token
+ *         preserved for preserved resource.
+ *         Input for %LIVEUPDATE_IOCTL_FD_RESTORE: The token previously
+ *         provided to the preserve ioctl for the resource to be restored.
+ *
+ * This structure is used as the argument for the %LIVEUPDATE_IOCTL_FD_PRESERVE
+ * and %LIVEUPDATE_IOCTL_FD_RESTORE ioctls. These ioctls allow specific types
+ * of file descriptors (for example memfd, kvm, iommufd, and VFIO) to have their
+ * underlying kernel state preserved across a live update cycle.
+ *
+ * To preserve an FD, user space passes this struct to
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE with the @fd field set. On success, the
+ * kernel uses the @token field to uniquly associate the preserved FD.
+ *
+ * After the live update transition, user space passes the struct populated with
+ * the *same* @token to %LIVEUPDATE_IOCTL_FD_RESTORE. The kernel uses the @token
+ * to find the preserved state and, on success, populates the @fd field with a
+ * new file descriptor referring to the restored resource.
+ */
+struct liveupdate_fd {
+	int		fd;
+	__u32		flags;
+	__aligned_u64	token;
+};
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define LIVEUPDATE_IOCTL_TYPE		0xBA
+
+/**
+ * LIVEUPDATE_IOCTL_FD_PRESERVE - Validate and initiate preservation for a file
+ * descriptor.
+ *
+ * Argument: Pointer to &struct liveupdate_fd.
+ *
+ * User sets the @fd field identifying the file descriptor to preserve
+ * (e.g., memfd, kvm, iommufd, VFIO). The kernel validates if this FD type
+ * and its dependencies are supported for preservation. If validation passes,
+ * the kernel marks the FD internally and *initiates the process* of preparing
+ * its state for saving. The actual snapshotting of the state typically occurs
+ * during the subsequent %LIVEUPDATE_IOCTL_PREPARE execution phase, though
+ * some finalization might occur during freeze.
+ * On successful validation and initiation, the kernel uses the @token
+ * field with an opaque identifier representing the resource being preserved.
+ * This token confirms the FD is targeted for preservation and is required for
+ * the subsequent %LIVEUPDATE_IOCTL_FD_RESTORE call after the live update.
+ *
+ * Return: 0 on success (validation passed, preservation initiated), negative
+ * error code on failure (e.g., unsupported FD type, dependency issue,
+ * validation failed).
+ */
+#define LIVEUPDATE_IOCTL_FD_PRESERVE					\
+	_IOW(LIVEUPDATE_IOCTL_TYPE, 0x00, struct liveupdate_fd)
+
+/**
+ * LIVEUPDATE_IOCTL_FD_UNPRESERVE - Remove a file descriptor from the
+ * preservation list.
+ *
+ * Argument: Pointer to __u64 token.
+ *
+ * Allows user space to explicitly remove a file descriptor from the set of
+ * items marked as potentially preservable. User space provides a pointer to the
+ * __u64 @token that was previously returned by a successful
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE call (potentially from a prior, possibly
+ * cancelled, live update attempt). The kernel reads the token value from the
+ * provided user-space address.
+ *
+ * On success, the kernel removes the corresponding entry (identified by the
+ * token value read from the user pointer) from its internal preservation list.
+ * The provided @token (representing the now-removed entry) becomes invalid
+ * after this call.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., -EBUSY or -EINVAL
+ * if not in %LIVEUPDATE_STATE_NORMAL, bad address provided, invalid token value
+ * read, token not found).
+ */
+#define LIVEUPDATE_IOCTL_FD_UNPRESERVE					\
+	_IOW(LIVEUPDATE_IOCTL_TYPE, 0x01, __u64)
+
+/**
+ * LIVEUPDATE_IOCTL_FD_RESTORE - Restore a previously preserved file descriptor.
+ *
+ * Argument: Pointer to &struct liveupdate_fd.
+ *
+ * User sets the @token field to the value obtained from a successful
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE call before the live update. On success,
+ * the kernel restores the state (saved during the PREPARE/FREEZE phases)
+ * associated with the token and populates the @fd field with a new file
+ * descriptor referencing the restored resource in the current (new) kernel.
+ * This operation must be performed *before* signaling completion via
+ * %LIVEUPDATE_IOCTL_FINISH.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., invalid token).
+ */
+#define LIVEUPDATE_IOCTL_FD_RESTORE					\
+	_IOWR(LIVEUPDATE_IOCTL_TYPE, 0x02, struct liveupdate_fd)
+
+/**
+ * LIVEUPDATE_IOCTL_GET_STATE - Query the current state of the live update
+ * orchestrator.
+ *
+ * Argument: Pointer to &enum liveupdate_state.
+ *
+ * The kernel fills the enum value pointed to by the argument with the current
+ * state of the live update subsystem. Possible states are:
+ *
+ * - %LIVEUPDATE_STATE_NORMAL:   Default state; no live update operation is
+ *                               currently in progress.
+ * - %LIVEUPDATE_STATE_PREPARED: The preparation phase (triggered by
+ *                               %LIVEUPDATE_IOCTL_PREPARE) has completed
+ *                               successfully. The system is ready for the
+ *                               reboot transition. Note that some
+ *                               device operations (e.g., unbinding, new DMA
+ *                               mappings) might be restricted in this state.
+ * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully rebooted into the
+ *                               new kernel via live update. It is now running
+ *                               the new kernel code and is awaiting the
+ *                               completion signal from user space via
+ *                               %LIVEUPDATE_IOCTL_FINISH after
+ *                               restoration tasks are done.
+ *
+ * See the definition of &enum liveupdate_state for more details on each state.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+#define LIVEUPDATE_IOCTL_GET_STATE					\
+	_IOR(LIVEUPDATE_IOCTL_TYPE, 0x03, enum liveupdate_state)
+
+/**
+ * LIVEUPDATE_IOCTL_PREPARE - Initiate preparation phase and trigger state
+ * saving.
+ *
+ * Argument: None.
+ *
+ * Initiates the live update preparation phase. This action corresponds to
+ * the internal %LIVEUPDATE_PREPARE. This typically triggers the saving process
+ * for items marked via the PRESERVE ioctls. This typically occurs *before*
+ * the "blackout window", while user applications (e.g., VMs) may still be
+ * running. Kernel subsystems receiving the %LIVEUPDATE_PREPARE event should
+ * serialize necessary state. This command does not transfer data.
+ *
+ * Return: 0 on success, negative error code on failure. Transitions state
+ * towards %LIVEUPDATE_STATE_PREPARED on success.
+ */
+#define LIVEUPDATE_IOCTL_PREPARE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x04)
+
+/**
+ * LIVEUPDATE_IOCTL_CANCEL - Cancel the live update preparation phase.
+ *
+ * Argument: None.
+ *
+ * Notifies the live update subsystem to abort the preparation sequence
+ * potentially initiated by %LIVEUPDATE_IOCTL_PREPARE. This action
+ * typically corresponds to the internal %LIVEUPDATE_CANCEL kernel event,
+ * which might also be triggered automatically if the PREPARE stage fails
+ * internally.
+ *
+ * When triggered, subsystems receiving the %LIVEUPDATE_CANCEL event should
+ * revert any state changes or actions taken specifically for the aborted
+ * prepare phase (e.g., discard partially serialized state). The kernel
+ * releases resources allocated specifically for this *aborted preparation
+ * attempt*.
+ *
+ * This operation cancels the current *attempt* to prepare for a live update
+ * but does **not** remove previously validated items from the internal list
+ * of potentially preservable resources. Consequently, preservation tokens
+ * previously generated by successful %LIVEUPDATE_IOCTL_FD_PRESERVE or calls
+ * generally **remain valid** as identifiers for those potentially preservable
+ * resources. However, since the system state returns towards
+ * %LIVEUPDATE_STATE_NORMAL, user space must initiate a new live update sequence
+ * (starting with %LIVEUPDATE_IOCTL_PREPARE) to proceed with an update
+ * using these (or other) tokens.
+ *
+ * This command does not transfer data. Kernel callbacks for the
+ * %LIVEUPDATE_CANCEL event must not fail.
+ *
+ * Return: 0 on success, negative error code on failure. Transitions state back
+ * towards %LIVEUPDATE_STATE_NORMAL on success.
+ */
+#define LIVEUPDATE_IOCTL_CANCEL						\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x06)
+
+/**
+ * LIVEUPDATE_IOCTL_EVENT_FINISH - Signal restoration completion and trigger
+ * cleanup.
+ *
+ * Argument: None.
+ *
+ * Signals that user space has completed all necessary restoration actions in
+ * the new kernel (after a live update reboot). This action corresponds to the
+ * internal %LIVEUPDATE_FINISH kernel event. Calling this ioctl triggers the
+ * cleanup phase: any resources that were successfully preserved but were *not*
+ * subsequently restored (reclaimed) via the RESTORE ioctls will have their
+ * preserved state discarded and associated kernel resources released. Involved
+ * devices may be reset. All desired restorations *must* be completed *before*
+ * this. Kernel callbacks for the %LIVEUPDATE_FINISH event must not fail.
+ * Successfully completing this phase transitions the system state from
+ * %LIVEUPDATE_STATE_UPDATED back to %LIVEUPDATE_STATE_NORMAL. This command does
+ * not transfer data.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+#define LIVEUPDATE_IOCTL_FINISH						\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x07)
+
+#endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index b5054140b9a9..cb3ea380f6b9 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_LIVEUPDATE)		+= luo_core.o
 obj-$(CONFIG_LIVEUPDATE)		+= luo_files.o
+obj-$(CONFIG_LIVEUPDATE)		+= luo_ioctl.o
 obj-$(CONFIG_LIVEUPDATE)		+= luo_subsystems.o
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
new file mode 100644
index 000000000000..3de1d243df5a
--- /dev/null
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO ioctl Interface
+ *
+ * The IOCTL user-space control interface for the LUO subsystem.
+ * It registers a misc character device, typically found at ``/dev/liveupdate``,
+ * which allows privileged userspace applications (requiring %CAP_SYS_ADMIN) to
+ * manage and monitor the LUO state machine and associated resources like
+ * preservable file descriptors.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/liveupdate.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/liveupdate.h>
+#include "luo_internal.h"
+
+static int luo_ioctl_fd_restore(struct liveupdate_fd *luo_fd)
+{
+	struct file *file;
+	int ret;
+	int fd;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		pr_err("Failed to allocate new fd: %d\n", fd);
+		return fd;
+	}
+
+	ret = luo_retrieve_file(luo_fd->token, &file);
+	if (ret < 0) {
+		put_unused_fd(fd);
+
+		return ret;
+	}
+
+	fd_install(fd, file);
+	luo_fd->fd = fd;
+
+	return 0;
+}
+
+static int luo_open(struct inode *inodep, struct file *filep)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (filep->f_flags & O_EXCL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct liveupdate_fd luo_fd;
+	enum liveupdate_state state;
+	int ret = 0;
+	u64 token;
+
+	if (_IOC_TYPE(cmd) != LIVEUPDATE_IOCTL_TYPE)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case LIVEUPDATE_IOCTL_GET_STATE:
+		state = liveupdate_get_state();
+		if (copy_to_user(argp, &state, sizeof(state)))
+			ret = -EFAULT;
+		break;
+
+	case LIVEUPDATE_IOCTL_PREPARE:
+		ret = luo_prepare();
+		break;
+
+	case LIVEUPDATE_IOCTL_FINISH:
+		ret = luo_finish();
+		break;
+
+	case LIVEUPDATE_IOCTL_CANCEL:
+		ret = luo_cancel();
+		break;
+
+	case LIVEUPDATE_IOCTL_FD_PRESERVE:
+		if (copy_from_user(&luo_fd, argp, sizeof(luo_fd))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = luo_register_file(luo_fd.token, luo_fd.fd);
+		if (!ret && copy_to_user(argp, &luo_fd, sizeof(luo_fd))) {
+			WARN_ON_ONCE(luo_unregister_file(luo_fd.token));
+			ret = -EFAULT;
+		}
+		break;
+
+	case LIVEUPDATE_IOCTL_FD_UNPRESERVE:
+		if (copy_from_user(&token, argp, sizeof(u64))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = luo_unregister_file(token);
+		break;
+
+	case LIVEUPDATE_IOCTL_FD_RESTORE:
+		if (copy_from_user(&luo_fd, argp, sizeof(luo_fd))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = luo_ioctl_fd_restore(&luo_fd);
+		if (!ret && copy_to_user(argp, &luo_fd, sizeof(luo_fd)))
+			ret = -EFAULT;
+		break;
+
+	default:
+		pr_warn("ioctl: unknown command nr: 0x%x\n", _IOC_NR(cmd));
+		ret = -ENOTTY;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations fops = {
+	.owner          = THIS_MODULE,
+	.open           = luo_open,
+	.unlocked_ioctl = luo_ioctl,
+};
+
+static struct miscdevice liveupdate_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name  = "liveupdate",
+	.fops  = &fops,
+};
+
+static int __init liveupdate_init(void)
+{
+	int err;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	err = misc_register(&liveupdate_miscdev);
+	if (err < 0) {
+		pr_err("Failed to register misc device '%s': %d\n",
+		       liveupdate_miscdev.name, err);
+	}
+
+	return err;
+}
+module_init(liveupdate_init);
+
+static void __exit liveupdate_exit(void)
+{
+	misc_deregister(&liveupdate_miscdev);
+}
+module_exit(liveupdate_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pasha Tatashin");
+MODULE_DESCRIPTION("Live Update Orchestrator");
+MODULE_VERSION("0.1");
-- 
2.50.0.727.gbf7dc18ff4-goog


