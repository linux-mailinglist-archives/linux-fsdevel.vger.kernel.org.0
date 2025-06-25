Return-Path: <linux-fsdevel+bounces-53013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD44AE9279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B797BABED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3E2DD5E2;
	Wed, 25 Jun 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="i3xFptcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BA2D9780
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893555; cv=none; b=nk/qXTA4Ud2qeTRkfqnvxSk1/tNi/pcdiFQvmKZX4gWNvirGPH1upVMDv9IkhK/RN2G+FPX3npY4zreKJkIzk26nrq8PYRiyDsEThhvIwz5OL5fLyyUpDsSZjyq25OooDvXELgOTyM1TldxxVfWurLghv82QS0idPK6jv9NNju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893555; c=relaxed/simple;
	bh=S+USuASgiAWLoGLEg40jmspH2nuy/XVSxxvs0BOFsVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeI+2h2PvGcagQOFtEXQzD2Ox7zKUIMwjhewbwy8LUsQIuezp8IYr8gLAzypHO6ObjJk/ek6rgx0lRgnuf2aDOI10leTBnYlOGxOqaYr1w319huuGIfErDTGPXtT+0JghWpm5BANvXAXeBNELW+VY1JJD25Z8hLIXeej+7ryyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=i3xFptcD; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81a7d90835so317394276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893551; x=1751498351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9OeQwvAtSpE7KYIsGHzDzwJJRVZThZJEHAd4sog2is=;
        b=i3xFptcD/U7quPFTmW2Ljdj58v7u98wRxAmu7vFEcTbyYEBaUqVbfyHREA+8oeYnHL
         Uu05lYVQ3gGp07Ckm718CPN21jgeCXGACEg3TdDbRZVAazxbT/hHK0ChswY3cB3f9WEA
         BjnVW4KNvPNtpvyO7Yeva7BENOyR4mRwkBIx8xXeoStRvCgH5hrWHIayIpdMMYMJ1pG1
         /OGfqrRsoZeIKH5eMyB1SdKB3Fd6/4slHHl2pOAxOj+FVqFpIGSKCjTia6ijR50dtsrF
         gQIOhlyFPRnZtRbEwIe4/0nGdsZQQP+7HzMzDtS7ph0ekYULO0o9cfiNya8gcpD2+uVQ
         xhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893551; x=1751498351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9OeQwvAtSpE7KYIsGHzDzwJJRVZThZJEHAd4sog2is=;
        b=RZfln4vJNB+4mjVZVLGh5kDyNm0n7ctHRCOCNQNxWVv9EOerFRZqsXR1mm3WSKCOwN
         7jodjeT6+F/mQn2eGJweeTOzZpWenhxWdi4J6j66vhMOA9HtPsUCkAVyqrsE5H3G2O27
         wGDehiT6Fv0gJ3MiB8zg1mg90/XYA/cD0ecNrtBcnNCnUWhh17jypVTMJwC+eMFKCgwt
         K0Qh+EgduYvfM9nt74DMFlyUcykRBLglcJcLRzB5VhdjBSWh4M7myO40mjesfQJzswYH
         vdiIOC85eQ9dmyrbKCKcntKWAAHwPEAhAp/mKWNRpTWG01YMy69vNHc5e7nJMUDedmdq
         vwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmMuhbXAHzWl2tcYY3vBOE7UgdWajjSWOPMPQmSx6R3w5i2Q14uGm+nh4CTcsxMyG4pEhRjx4Fc3ehyHdb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ARIOh3DvIZRzIvxHFGfFBJxZ89Gd8GbARb8osbSu8ayoo1F7
	p5mSExBSkgZ5W4XXu7cqDce2x/wslhPtqrYAyUAgvPnMh07KnD3ldYL+bzDf+EG5K+g=
X-Gm-Gg: ASbGncs/sr81a1Xq0z+O1rLAJpRvz6ctefKhStvIU6rMapGlvj1LVNJpcrD8DESUemM
	ptl5bLfecX4kgM0YSabWUn0ClEsv4W7OmCk5ydIFYj/WwEZixQHv4KokhRKeiD5MrsNY6FNOtFD
	QCqlhlRlBuSNu+ubkS+ZX+ncwDsnuhxpFbnJi8BbirYiI+WwMTAYwyK9AICc2FE5QR3Hrx8vl1H
	Xg6k91lLi3bFQR0Cu1MYyN8kkOsjhH/b0mbhU1ooKNvmsp5JpLvMLnwfkJ3GP8oWgFPHfXvmRW0
	RKCrO6v5c3GeK+dIn8XrVwOWpqnWM1PnVx2mS3lQZOJbbJ+RDi2b3nfncdwOuqvXmLjTvX/pkiu
	xUNlsHHf4cI58airT/hvLLMnABxGDfh78bwRl3RXBkzsBqPRndaX2
X-Google-Smtp-Source: AGHT+IF28eiwjJHMy7Ve+TxPexX03L5N+dFsr5T9nLJ5gUzi03DI4MbfpJsnWZJhna2trPwN4u1gRA==
X-Received: by 2002:a05:6902:724:b0:e7d:59e0:f65e with SMTP id 3f1490d57ef6-e86016db6b6mr5123970276.1.1750893550859;
        Wed, 25 Jun 2025 16:19:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:10 -0700 (PDT)
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
Subject: [PATCH v1 16/32] liveupdate: luo_ioctl: add ioctl interface
Date: Wed, 25 Jun 2025 23:18:03 +0000
Message-ID: <20250625231838.1897085-17-pasha.tatashin@soleen.com>
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


