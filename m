Return-Path: <linux-fsdevel+bounces-69486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC41C7D88E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F44E068A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96CE294A10;
	Sat, 22 Nov 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="if5Eigtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E52D593D
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850249; cv=none; b=ZvfX9qX+nUCXk5G4OM3/6uqUt3/1ZJ3ryph3Ad3RfsvjYD/qKq8+8F5WgeJUq1baCBGbno/AX8a9YtMPNvIkxy2D9d68Xb4P3abh8lf9MHhOsuEZdX5CeF0zdUyLxAC2ew5xUdgzl2BGn24j0PtNQxcjmYaXUskdYdimUYjdzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850249; c=relaxed/simple;
	bh=cgPKVK0mI/a8cjxeuMSi5z9QJUbnDqOWgRrusyvIGpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIihyspdtecLbMpAwzkdb1bnv3y/sgzRsb+utpfZwmnwn+pQoDi1hyQgtkWN9F2j9Ta+pjZP7TPWULiV7p5GmlCyE385UGcdmeuYEpBuSJAoj1OxWiKnTgEpyl3inGXZj+6/quupSLjIBhjSr/917a10VuAeQU2yCA4UMwjtD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=if5Eigtx; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640f88b873bso2736385d50.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850244; x=1764455044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f97FmhRHLdKBFhVEdbeaZSyOpcaCVspu56X5lhG/iHw=;
        b=if5EigtxwHwibHNKCEKHx5CK5G51Ji7jZxP3twDfpkFbwwQFlX2Ootvkea4sOZmWR/
         e7iXTDRLLPQjcbPdNR1YuMbyql+E0j25czpmJrOdKFqIwyrBZdMpPjTzlxNLixdDYXkr
         miJD3+g16F2Iu4WF1XJ9MCcA90phIIDtcn6U/k8MjfdhUAav0OjDa9tdXfyPsVFwp8Ks
         iPaCm40jGU+gt3Lz3Xj1GTo8u8is0BkCmU0NNYjknUcbYvXYHPYJT529NCBwOpnS4lIR
         lM444YSsT9zIUlhmC6K4yeMHSiKhNatzUx03qEcvp+7SezTqJpAZHurljPpU1PwFxpzU
         drvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850244; x=1764455044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f97FmhRHLdKBFhVEdbeaZSyOpcaCVspu56X5lhG/iHw=;
        b=OU+wOujPxc/FYVvslce501rb13oYnQ/ZMPzv7LouJrmncme7bxIGcyq+4s5AlzYxPg
         5SB4R3kKt92tAbSoNLjZgbaZgjgwYEGXV2mkUtq2EshG2iEsw79T9eQsqmcB+KwseghU
         JR4lWFcBsXiiElmyQwSXgED2XR/4pP+Rewl0JMKOoWnXOWkmgiDLPf2W72ciME3vAMlK
         eVwO3NHB3PHoIZH47MiY2hGo0EvbKzzqtwHvZxVz2ECJumETUmOFQRSuoA976JaU5Cl9
         LZGYjwHhtqq3+LJHZvCC/zU++MWKGURkORir05AyNtDzgs2Kf0eJA1bCQlwi8ptRNxvW
         Ce7A==
X-Forwarded-Encrypted: i=1; AJvYcCVyYTTHR+cSQOdrXYuuor/oSgaSn2T8xmgIqMF3fNW790wlGWE+2DRQVhHZOeqlemRh+ZOmljz9c9eHkSBU@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYUNifRhdsaSG/DjC4ja8hsNsB3wb8L6k55gccQiboFsh2Npf
	o92Sfrc7p8hJUObMB/QABOQF3AZ43nsQEKGj67PBvwWv41iSMnvxxhUgBZjUnRdIkZ4=
X-Gm-Gg: ASbGncsRX53A1vwk1wm6eVL0RGJ27+wRsiqgRXXHcHTjF1euOIMNWnnHplEnq8iKjpS
	NiegrgprpGTtiPJihyZpy1Y4ecpyvuYpbX84uCjEmfN79gzQHGDtvSBqfwEioGLpMMwTBqVWbHd
	/Ek3aZH/U1sbPOyml3vVpI7arOjh5koCH28FSuKEOuNldgrJRUHvUzdIvGnlHXwZg1gC9pi/UNM
	8D4ozUbgtVTkw1X4rAMInMHmvJGPbhuPpJulGnAKCGW+DdjFjKYhW0ifRb8onJvbPoHe7O+ZN0t
	yQypiluIXq1ana1cZC84xFTqSC3MjcZr9RkfLqRzoSNAXZKCOtKl8x0+LUsV89rFHqO2dbDmCM2
	wivVzFOL6qQj7Pknf7J+R3NoWP8ComrvLjhppxGnd/+3rZyhNYpI54e2i/HW0uxEoQguIiEcpXR
	AtZgIslfQJeDpD82Egc6OuzXylqyJPr69XYZwNDJW2geGN+8oU4Ok/fLoyBcBkm7WXVi+moXp9/
	AmLc4A=
X-Google-Smtp-Source: AGHT+IGnrzCEuuylhqPkAjSlcdsyrO4o6aqtyMRDVxZk2R8kYrvFUB/uDbfsoHva1q9rBA+u1Xb6WA==
X-Received: by 2002:a53:5003:0:b0:641:f5bc:6998 with SMTP id 956f58d0204a3-64302b38722mr3621491d50.84.1763850244299;
        Sat, 22 Nov 2025 14:24:04 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:03 -0800 (PST)
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
Subject: [PATCH v7 04/22] liveupdate: luo_session: add sessions support
Date: Sat, 22 Nov 2025 17:23:31 -0500
Message-ID: <20251122222351.1059049-5-pasha.tatashin@soleen.com>
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

Introduce concept of "Live Update Sessions" within the LUO framework.
LUO sessions provide a mechanism to group and manage `struct file *`
instances (representing file descriptors) that need to be preserved
across a kexec-based live update.

Each session is identified by a unique name and acts as a container
for file objects whose state is critical to a userspace workload, such
as a virtual machine or a high-performance database, aiming to maintain
their functionality across a kernel transition.

This groundwork establishes the framework for preserving file-backed
state across kernel updates, with the actual file data preservation
mechanisms to be implemented in subsequent patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h      |  71 +++++
 include/uapi/linux/liveupdate.h  |   3 +
 kernel/liveupdate/Makefile       |   3 +-
 kernel/liveupdate/luo_core.c     |   9 +
 kernel/liveupdate/luo_internal.h |  29 ++
 kernel/liveupdate/luo_session.c  | 462 +++++++++++++++++++++++++++++++
 6 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 kernel/liveupdate/luo_session.c

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 8523b3ff82d1..a2d2940eca6b 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -28,6 +28,11 @@
  *     / {
  *         compatible = "luo-v1";
  *         liveupdate-number = <...>;
+ *
+ *         luo-session {
+ *             compatible = "luo-session-v1";
+ *             luo-session-header = <phys_addr_of_session_header_ser>;
+ *         };
  *     };
  *
  * Main LUO Node (/):
@@ -36,11 +41,37 @@
  *     Identifies the overall LUO ABI version.
  *   - liveupdate-number: u64
  *     A counter tracking the number of successful live updates performed.
+ *
+ * Session Node (luo-session):
+ *   This node describes all preserved user-space sessions.
+ *
+ *   - compatible: "luo-session-v1"
+ *     Identifies the session ABI version.
+ *   - luo-session-header: u64
+ *     The physical address of a `struct luo_session_header_ser`. This structure
+ *     is the header for a contiguous block of memory containing an array of
+ *     `struct luo_session_ser`, one for each preserved session.
+ *
+ * Serialization Structures:
+ *   The FDT properties point to memory regions containing arrays of simple,
+ *   `__packed` structures. These structures contain the actual preserved state.
+ *
+ *   - struct luo_session_header_ser:
+ *     Header for the session array. Contains the total page count of the
+ *     preserved memory block and the number of `struct luo_session_ser`
+ *     entries that follow.
+ *
+ *   - struct luo_session_ser:
+ *     Metadata for a single session, including its name and a physical pointer
+ *     to another preserved memory block containing an array of
+ *     `struct luo_file_ser` for all files in that session.
  */
 
 #ifndef _LINUX_KHO_ABI_LUO_H
 #define _LINUX_KHO_ABI_LUO_H
 
+#include <uapi/linux/liveupdate.h>
+
 /*
  * The LUO FDT hooks all LUO state for sessions, fds, etc.
  * In the root it also carries "liveupdate-number" 64-bit property that
@@ -51,4 +82,44 @@
 #define LUO_FDT_COMPATIBLE	"luo-v1"
 #define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
 
+/*
+ * LUO FDT session node
+ * LUO_FDT_SESSION_HEADER:  is a u64 physical address of struct
+ *                          luo_session_header_ser
+ */
+#define LUO_FDT_SESSION_NODE_NAME	"luo-session"
+#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v1"
+#define LUO_FDT_SESSION_HEADER		"luo-session-header"
+
+/**
+ * struct luo_session_header_ser - Header for the serialized session data block.
+ * @count: The number of `struct luo_session_ser` entries that immediately
+ *         follow this header in the memory block.
+ *
+ * This structure is located at the beginning of a contiguous block of
+ * physical memory preserved across the kexec. It provides the necessary
+ * metadata to interpret the array of session entries that follow.
+ *
+ * If this structure is modified, `LUO_FDT_SESSION_COMPATIBLE` must be updated.
+ */
+struct luo_session_header_ser {
+	u64 count;
+} __packed;
+
+/**
+ * struct luo_session_ser - Represents the serialized metadata for a LUO session.
+ * @name:         The unique name of the session, provided by the userspace at
+ *                the time of session creation.
+ *
+ * This structure is used to package session-specific metadata for transfer
+ * between kernels via Kexec Handover. An array of these structures (one per
+ * session) is created and passed to the new kernel, allowing it to reconstruct
+ * the session context.
+ *
+ * If this structure is modified, `LUO_FDT_SESSION_COMPATIBLE` must be updated.
+ */
+struct luo_session_ser {
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+} __packed;
+
 #endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index df34c1642c4d..40578ae19668 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -43,4 +43,7 @@
 /* The ioctl type, documented in ioctl-number.rst */
 #define LIVEUPDATE_IOCTL_TYPE		0xBA
 
+/* The maximum length of session name including null termination */
+#define LIVEUPDATE_SESSION_NAME_LENGTH 64
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index 08954c1770c4..6af93caa58cf 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 luo-y :=								\
-		luo_core.o
+		luo_core.o						\
+		luo_session.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 9f9fe9a81b29..a0f7788cd003 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -118,6 +118,10 @@ static int __init luo_early_startup(void)
 	pr_info("Retrieved live update data, liveupdate number: %lld\n",
 		luo_global.liveupdate_num);
 
+	err = luo_session_setup_incoming(luo_global.fdt_in);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -154,6 +158,7 @@ static int __init luo_fdt_setup(void)
 	err |= fdt_begin_node(fdt_out, "");
 	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
 	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
+	err |= luo_session_setup_outgoing(fdt_out);
 	err |= fdt_end_node(fdt_out);
 	err |= fdt_finish(fdt_out);
 	if (err)
@@ -211,6 +216,10 @@ int liveupdate_reboot(void)
 	if (!liveupdate_enabled())
 		return 0;
 
+	err = luo_session_serialize();
+	if (err)
+		return err;
+
 	err = kho_finalize();
 	if (err) {
 		pr_err("kho_finalize failed %d\n", err);
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8612687b2000..05ae91695ec6 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -19,4 +19,33 @@
  */
 #define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
 
+/**
+ * struct luo_session - Represents an active or incoming Live Update session.
+ * @name:       A unique name for this session, used for identification and
+ *              retrieval.
+ * @ser:        Pointer to the serialized data for this session.
+ * @list:       A list_head member used to link this session into a global list
+ *              of either outgoing (to be preserved) or incoming (restored from
+ *              previous kernel) sessions.
+ * @retrieved:  A boolean flag indicating whether this session has been
+ *              retrieved by a consumer in the new kernel.
+ * @mutex:      protects fields in the luo_session.
+ */
+struct luo_session {
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	struct luo_session_ser *ser;
+	struct list_head list;
+	bool retrieved;
+	struct mutex mutex;
+};
+
+int luo_session_create(const char *name, struct file **filep);
+int luo_session_retrieve(const char *name, struct file **filep);
+int __init luo_session_setup_outgoing(void *fdt);
+int __init luo_session_setup_incoming(void *fdt);
+int luo_session_serialize(void);
+int luo_session_deserialize(void);
+bool luo_session_quiesce(void);
+void luo_session_resume(void);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
new file mode 100644
index 000000000000..ee363d1b2b10
--- /dev/null
+++ b/kernel/liveupdate/luo_session.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO Sessions
+ *
+ * LUO Sessions provide the core mechanism for grouping and managing `struct
+ * file *` instances that need to be preserved across a kexec-based live
+ * update. Each session acts as a named container for a set of file objects,
+ * allowing a userspace agent to manage the lifecycle of resources critical to a
+ * workload.
+ *
+ * Core Concepts:
+ *
+ * - Named Containers: Sessions are identified by a unique, user-provided name,
+ *   which is used for both creation in the current kernel and retrieval in the
+ *   next kernel.
+ *
+ * - Userspace Interface: Session management is driven from userspace via
+ *   ioctls on /dev/liveupdate.
+ *
+ * - Serialization: Session metadata is preserved using the KHO framework. When
+ *   a live update is triggered via kexec, an array of `struct luo_session_ser`
+ *   is populated and placed in a preserved memory region. An FDT node is also
+ *   created, containing the count of sessions and the physical address of this
+ *   array.
+ *
+ * Session Lifecycle:
+ *
+ * 1.  Creation: A userspace agent calls `luo_session_create()` to create a
+ *     new, empty session and receives a file descriptor for it.
+ *
+ * 2.  Serialization: When the `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is
+ *     made, `luo_session_serialize()` is called. It iterates through all
+ *     active sessions and writes their metadata into a memory area preserved
+ *     by KHO.
+ *
+ * 3.  Deserialization (in new kernel): After kexec, `luo_session_deserialize()`
+ *     runs, reading the serialized data and creating a list of `struct
+ *     luo_session` objects representing the preserved sessions.
+ *
+ * 4.  Retrieval: A userspace agent in the new kernel can then call
+ *     `luo_session_retrieve()` with a session name to get a new file
+ *     descriptor and access the preserved state.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/liveupdate.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+#include <uapi/linux/liveupdate.h>
+#include "luo_internal.h"
+
+/* 16 4K pages, give space for 744 sessions */
+#define LUO_SESSION_PGCNT	16ul
+#define LUO_SESSION_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
+		sizeof(struct luo_session_header_ser)) /		\
+		sizeof(struct luo_session_ser))
+
+/**
+ * struct luo_session_header - Header struct for managing LUO sessions.
+ * @count:      The number of sessions currently tracked in the @list.
+ * @list:       The head of the linked list of `struct luo_session` instances.
+ * @rwsem:      A read-write semaphore providing synchronized access to the
+ *              session list and other fields in this structure.
+ * @header_ser: The header data of serialization array.
+ * @ser:        The serialized session data (an array of
+ *              `struct luo_session_ser`).
+ * @active:     Set to true when first initialized. If previous kernel did not
+ *              send session data, active stays false for incoming.
+ */
+struct luo_session_header {
+	long count;
+	struct list_head list;
+	struct rw_semaphore rwsem;
+	struct luo_session_header_ser *header_ser;
+	struct luo_session_ser *ser;
+	bool active;
+};
+
+/**
+ * struct luo_session_global - Global container for managing LUO sessions.
+ * @incoming:     The sessions passed from the previous kernel.
+ * @outgoing:     The sessions that are going to be passed to the next kernel.
+ */
+struct luo_session_global {
+	struct luo_session_header incoming;
+	struct luo_session_header outgoing;
+};
+
+static struct luo_session_global luo_session_global = {
+	.incoming = {
+		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
+		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
+	},
+	.outgoing = {
+		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
+		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
+	},
+};
+
+static struct luo_session *luo_session_alloc(const char *name)
+{
+	struct luo_session *session = kzalloc(sizeof(*session), GFP_KERNEL);
+
+	if (!session)
+		return ERR_PTR(-ENOMEM);
+
+	strscpy(session->name, name, sizeof(session->name));
+	INIT_LIST_HEAD(&session->list);
+	mutex_init(&session->mutex);
+
+	return session;
+}
+
+static void luo_session_free(struct luo_session *session)
+{
+	mutex_destroy(&session->mutex);
+	kfree(session);
+}
+
+static int luo_session_insert(struct luo_session_header *sh,
+			      struct luo_session *session)
+{
+	struct luo_session *it;
+
+	guard(rwsem_write)(&sh->rwsem);
+
+	/*
+	 * For outgoing we should make sure there is room in serialization array
+	 * for new session.
+	 */
+	if (sh == &luo_session_global.outgoing) {
+		if (sh->count == LUO_SESSION_MAX)
+			return -ENOMEM;
+	}
+
+	/*
+	 * For small number of sessions this loop won't hurt performance
+	 * but if we ever start using a lot of sessions, this might
+	 * become a bottle neck during deserialization time, as it would
+	 * cause O(n*n) complexity.
+	 */
+	list_for_each_entry(it, &sh->list, list) {
+		if (!strncmp(it->name, session->name, sizeof(it->name)))
+			return -EEXIST;
+	}
+	list_add_tail(&session->list, &sh->list);
+	sh->count++;
+
+	return 0;
+}
+
+static void luo_session_remove(struct luo_session_header *sh,
+			       struct luo_session *session)
+{
+	guard(rwsem_write)(&sh->rwsem);
+	list_del(&session->list);
+	sh->count--;
+}
+
+static int luo_session_release(struct inode *inodep, struct file *filep)
+{
+	struct luo_session *session = filep->private_data;
+	struct luo_session_header *sh;
+
+	/* If retrieved is set, it means this session is from incoming list */
+	if (session->retrieved)
+		sh = &luo_session_global.incoming;
+	else
+		sh = &luo_session_global.outgoing;
+
+	luo_session_remove(sh, session);
+	luo_session_free(session);
+
+	return 0;
+}
+
+static const struct file_operations luo_session_fops = {
+	.owner = THIS_MODULE,
+	.release = luo_session_release,
+};
+
+/* Create a "struct file" for session */
+static int luo_session_getfile(struct luo_session *session, struct file **filep)
+{
+	char name_buf[128];
+	struct file *file;
+
+	lockdep_assert_held(&session->mutex);
+	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
+	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	*filep = file;
+
+	return 0;
+}
+
+int luo_session_create(const char *name, struct file **filep)
+{
+	struct luo_session *session;
+	int err;
+
+	session = luo_session_alloc(name);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	err = luo_session_insert(&luo_session_global.outgoing, session);
+	if (err)
+		goto err_free;
+
+	scoped_guard(mutex, &session->mutex)
+		err = luo_session_getfile(session, filep);
+	if (err)
+		goto err_remove;
+
+	return 0;
+
+err_remove:
+	luo_session_remove(&luo_session_global.outgoing, session);
+err_free:
+	luo_session_free(session);
+
+	return err;
+}
+
+int luo_session_retrieve(const char *name, struct file **filep)
+{
+	struct luo_session_header *sh = &luo_session_global.incoming;
+	struct luo_session *session = NULL;
+	struct luo_session *it;
+	int err;
+
+	scoped_guard(rwsem_read, &sh->rwsem) {
+		list_for_each_entry(it, &sh->list, list) {
+			if (!strncmp(it->name, name, sizeof(it->name))) {
+				session = it;
+				break;
+			}
+		}
+	}
+
+	if (!session)
+		return -ENOENT;
+
+	guard(mutex)(&session->mutex);
+	if (session->retrieved)
+		return -EINVAL;
+
+	err = luo_session_getfile(session, filep);
+	if (!err)
+		session->retrieved = true;
+
+	return err;
+}
+
+int __init luo_session_setup_outgoing(void *fdt_out)
+{
+	struct luo_session_header_ser *header_ser;
+	void *outgoing_buffer;
+	u64 header_ser_pa;
+	int err;
+
+	outgoing_buffer = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(outgoing_buffer))
+		return PTR_ERR(header_ser);
+	header_ser = outgoing_buffer;
+	header_ser_pa = virt_to_phys(header_ser);
+
+	err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
+	err |= fdt_property_string(fdt_out, "compatible",
+				   LUO_FDT_SESSION_COMPATIBLE);
+	err |= fdt_property(fdt_out, LUO_FDT_SESSION_HEADER, &header_ser_pa,
+			    sizeof(header_ser_pa));
+	err |= fdt_end_node(fdt_out);
+
+	if (err)
+		goto err_unpreserve;
+
+	luo_session_global.outgoing.header_ser = header_ser;
+	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
+	luo_session_global.outgoing.active = true;
+
+	return 0;
+
+err_unpreserve:
+	kho_unpreserve_free(header_ser);
+	return err;
+}
+
+int __init luo_session_setup_incoming(void *fdt_in)
+{
+	struct luo_session_header_ser *header_ser;
+	int err, header_size, offset;
+	u64 header_ser_pa;
+	const void *ptr;
+
+	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_SESSION_NODE_NAME);
+	if (offset < 0) {
+		pr_err("Unable to get session node: [%s]\n",
+		       LUO_FDT_SESSION_NODE_NAME);
+		return -EINVAL;
+	}
+
+	err = fdt_node_check_compatible(fdt_in, offset,
+					LUO_FDT_SESSION_COMPATIBLE);
+	if (err) {
+		pr_err("Session node incompatible [%s]\n",
+		       LUO_FDT_SESSION_COMPATIBLE);
+		return -EINVAL;
+	}
+
+	header_size = 0;
+	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_SESSION_HEADER, &header_size);
+	if (!ptr || header_size != sizeof(u64)) {
+		pr_err("Unable to get session header '%s' [%d]\n",
+		       LUO_FDT_SESSION_HEADER, header_size);
+		return -EINVAL;
+	}
+
+	header_ser_pa = get_unaligned((u64 *)ptr);
+	header_ser = phys_to_virt(header_ser_pa);
+
+	luo_session_global.incoming.header_ser = header_ser;
+	luo_session_global.incoming.ser = (void *)(header_ser + 1);
+	luo_session_global.incoming.active = true;
+
+	return 0;
+}
+
+int luo_session_deserialize(void)
+{
+	struct luo_session_header *sh = &luo_session_global.incoming;
+	static bool is_deserialized;
+	static int err;
+
+	/* If has been deserialized, always return the same error code */
+	if (is_deserialized)
+		return err;
+
+	is_deserialized = true;
+	if (!sh->active)
+		return 0;
+
+	/*
+	 * Note on error handling:
+	 *
+	 * If deserialization fails (e.g., allocation failure or corrupt data),
+	 * we intentionally skip cleanup of sessions that were already restored.
+	 *
+	 * A partial failure leaves the preserved state inconsistent.
+	 * Implementing a safe "undo" to unwind complex dependencies (sessions,
+	 * files, hardware state) is error-prone and provides little value, as
+	 * the system is effectively in a broken state.
+	 *
+	 * We treat these resources as leaked. The expected recovery path is for
+	 * userspace to detect the failure and trigger a reboot, which will
+	 * reliably reset devices and reclaim memory.
+	 */
+	for (int i = 0; i < sh->header_ser->count; i++) {
+		struct luo_session *session;
+
+		session = luo_session_alloc(sh->ser[i].name);
+		if (IS_ERR(session)) {
+			pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
+				sh->ser[i].name, session);
+			return PTR_ERR(session);
+		}
+
+		err = luo_session_insert(sh, session);
+		if (err) {
+			luo_session_free(session);
+			pr_warn("Failed to insert session [%s] %pe\n",
+				session->name, ERR_PTR(err));
+			return err;
+		}
+	}
+
+	kho_restore_free(sh->header_ser);
+	sh->header_ser = NULL;
+	sh->ser = NULL;
+
+	return 0;
+}
+
+int luo_session_serialize(void)
+{
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session *session;
+	int i = 0;
+
+	guard(rwsem_write)(&sh->rwsem);
+	list_for_each_entry(session, &sh->list, list) {
+		strscpy(sh->ser[i].name, session->name,
+			sizeof(sh->ser[i].name));
+		i++;
+	}
+	sh->header_ser->count = sh->count;
+
+	return 0;
+}
+
+/**
+ * luo_session_quiesce - Ensure no active sessions exist and lock session lists.
+ *
+ * Acquires exclusive write locks on both incoming and outgoing session lists.
+ * It then validates no sessions exist in either list.
+ *
+ * This mechanism is used during file handler un/registration to ensure that no
+ * sessions are currently using the handler, and no new sessions can be created
+ * while un/registration is in progress.
+ *
+ * Return:
+ * true  - System is quiescent (0 sessions) and locked.
+ * false - Active sessions exist. The locks are released internally.
+ */
+bool luo_session_quiesce(void)
+{
+	down_write(&luo_session_global.incoming.rwsem);
+	down_write(&luo_session_global.outgoing.rwsem);
+
+	if (luo_session_global.incoming.count ||
+	    luo_session_global.outgoing.count) {
+		up_write(&luo_session_global.outgoing.rwsem);
+		up_write(&luo_session_global.incoming.rwsem);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * luo_session_resume - Unlock session lists and resume normal activity.
+ *
+ * Releases the exclusive locks acquired by a successful call to
+ * luo_session_quiesce().
+ */
+void luo_session_resume(void)
+{
+	up_write(&luo_session_global.outgoing.rwsem);
+	up_write(&luo_session_global.incoming.rwsem);
+}
-- 
2.52.0.rc2.455.g230fcf2819-goog


