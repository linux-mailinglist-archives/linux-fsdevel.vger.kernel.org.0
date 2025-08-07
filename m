Return-Path: <linux-fsdevel+bounces-56938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A795FB1D067
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EE2569E79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89A22A7F9;
	Thu,  7 Aug 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XNxdTF6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C145222568
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531112; cv=none; b=JijG/xkCJxSE1YM1Dcn5X6gl1Pcv+E2iKDJtk01SGxmgNljlN8uGGhsmDi9DC+xrQ7uBCvCCc0chBUte2bYL73lt7Xm/JRk/9Jai69Btog24orC8m0pDz0JZ1A1iSpPmX8g9kmsapZ4NqPrsP6gHDgP3EwNvDQRCxA/BxKsJQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531112; c=relaxed/simple;
	bh=JgDVxicg+AOekGOe+/9MAKxIOxeDHs3VbHkVSf0QKAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEwY9YtxArk368q45hW0oj6CrYPHPNshPrY90A7bNn8ACaAInKSyAscDcbcIKw6cfnNcB/lrFw5Mw2P7u16ERdc42kkPK09+ymnvjgf6/9C1zGcuid1HZZJl6PrX7FCEBgyqx4Wjs0Mz/XMyhI5Khyqh48mXybGKt8Y4vQZCgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XNxdTF6i; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70875cc3423so5976756d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531108; x=1755135908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mp1vmIN6774rh53/eJBOc5kRP469D2TV1rphzED5Sxg=;
        b=XNxdTF6iksWI/03rM5SZyzdcDwPpKCKmG7L7KBoE/JNeoIf+/s0n8y/tNMHhh8c6HW
         zT/MzdlBUbv2kp2pqXXEgqdWSowwpx0iITXpaDysdiPsCD1q6vIo37v8VR37lqyYxjmA
         IrLAOskjzdKXAvNnqDMNlWOr7yH/qFwVzlHV9lKWLDzaG9v4nnrMsTHbNUQrklvz25s6
         WG4lad9dnlvRYEVXKGNJ0NQQD9m4+nyQq9HcsajF/R60FStHjuKwW1VJHJFVyjpCBZ/P
         DuLlBGz3u8+2peBVA/5ObxDtOVeDpbjboQS8yIq+rV/XB/J7k7ma+asVXpWF7IYsy5GT
         IOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531108; x=1755135908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp1vmIN6774rh53/eJBOc5kRP469D2TV1rphzED5Sxg=;
        b=urshCzWkBv/9F/8/3lIXZ+elYdMZZFcZbqek9dHPr1A0NptCTguv0jzpFCqsLWWKGj
         HNSGwhwSdH5y1xv0h4HtPg2BQUjHAQ7cABI6h3x3WagvW/oQ+GGpHanEE33ZSTxOXeRq
         tBeI6VNTBVEmHwZ8yTxqMo1Aumf8JFftykoyD3hvnAni8UUKVkPUWtHwv1qgwksAY+ir
         Wg1SIpb8j54Pc8AF+lnaImdnuhHrwuGKHI/OeauVx/EBfD1THwBy3aZ1uCFmDetsTPUo
         Et7QMmElHOuq3p8S9vDynsy1pVX5YrAisj4rLoB2QE/8CwCfw0VI01pJFYTwf2iinNIx
         tEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0q07z42VThD3nfQ71RWjDtBSqGaLfmsoQfxIllM84ihsZIoNyongQHGKL8X1XeYd4e0mHAbkTL/QL/q9T@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPKlGxZAA6m/CVLA1ygwLWaBPEnhrSpgkSx/UkJ6op4pbbuVC
	zdY3gua+rf3XGqN7aaWgBWjAPhR85rK+1tRYtooEYPogi+n9Zc1DURpTVjPMfmpGvL4=
X-Gm-Gg: ASbGnctR7IEo4IQSXIItTILSmPuZ4OXHutKPXR5xB8TG9f7TccaYvzpj2gV3FqpStIj
	BkeUKwkm/SuGY97RPzIouICGi3uI7DUC8hh8Vp9CFtZFManTECca4iLscsU349IxC7sIaQQ5NS2
	RjZ8OZtgnWh0yst0qodJXS0BZwJdYGBE2H9pSgWFhzjlNzRFfKkBlAl/W05WYeqM0coVwTe5ZmT
	sbTYlgW1x6D3PZuSWPpwoBS/X7j31YRO8a1qT61ZVOSy76lXg1L01di1IMFiUmDAkjkpcRkJnev
	faR9gWOXI7W266rK9JY2y3xT1zARCMSvkGe4dNAua91mADAkFAE0HpR+gmuM1S0Q58hVaR58R7b
	YbO0jKGHk3i7u4H/nYPawHwj0mqlfO/iaK50Xq3Trp1SHpxd3WiiRMmGrpnkf/NfRYeNqinWmHS
	N/z5Ujo5wEfM6hSXxYPXRqCZ4=
X-Google-Smtp-Source: AGHT+IHW6xOS8icaV4fCZErUgrfoJrCJf1Yssvt+ylUZS0UycAitGY8nEQwBLa80lBpJIc7l5fKEdg==
X-Received: by 2002:a05:6214:2422:b0:707:6409:d001 with SMTP id 6a1803df08f44-7098943a0camr29339416d6.21.1754531107741;
        Wed, 06 Aug 2025 18:45:07 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:07 -0700 (PDT)
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
Subject: [PATCH v3 14/30] liveupdate: luo_files: add infrastructure for FDs
Date: Thu,  7 Aug 2025 01:44:20 +0000
Message-ID: <20250807014442.3829950-15-pasha.tatashin@soleen.com>
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

Introduce the framework within LUO to support preserving specific types
of file descriptors across a live update transition. This allows
stateful FDs (like memfds or vfio FDs used by VMs) to be recreated in
the new kernel.

Note: The core logic for iterating through the luo_files_list and
invoking the handler callbacks (prepare, freeze, cancel, finish)
within luo_do_files_*_calls, as well as managing the u64 data
persistence via the FDT for individual files, is currently implemented
as stubs in this patch. This patch sets up the registration, FDT layout,
and retrieval framework.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h       |  73 ++++
 kernel/liveupdate/Makefile       |   1 +
 kernel/liveupdate/luo_files.c    | 677 +++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |   4 +
 4 files changed, 755 insertions(+)
 create mode 100644 kernel/liveupdate/luo_files.c

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 4c378a986cfe..72786482ca48 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -13,6 +13,66 @@
 #include <uapi/linux/liveupdate.h>
 
 struct liveupdate_subsystem;
+struct liveupdate_file_handler;
+struct file;
+
+/**
+ * struct liveupdate_file_ops - Callbacks for live-updatable files.
+ * @prepare:       Optional. Saves state for a specific file instance @file,
+ *                 before update, potentially returning value via @data.
+ *                 Returns 0 on success, negative errno on failure.
+ * @freeze:        Optional. Performs final actions just before kernel
+ *                 transition, potentially reading/updating the handle via
+ *                 @data.
+ *                 Returns 0 on success, negative errno on failure.
+ * @cancel:        Optional. Cleans up state/resources if update is aborted
+ *                 after prepare/freeze succeeded, using the @data handle (by
+ *                 value) from the successful prepare. Returns void.
+ * @finish:        Optional. Performs final cleanup in the new kernel using the
+ *                 preserved @data handle (by value). Returns void.
+ * @retrieve:      Retrieve the preserved file. Must be called before finish.
+ * @can_preserve:  callback to determine if @file can be preserved by this
+ *                 handler.
+ *                 Return bool (true if preservable, false otherwise).
+ * @owner:         Module reference
+ */
+struct liveupdate_file_ops {
+	int (*prepare)(struct liveupdate_file_handler *handler,
+		       struct file *file, u64 *data);
+	int (*freeze)(struct liveupdate_file_handler *handler,
+		      struct file *file, u64 *data);
+	void (*cancel)(struct liveupdate_file_handler *handler,
+		       struct file *file, u64 data);
+	void (*finish)(struct liveupdate_file_handler *handler,
+		       struct file *file, u64 data, bool reclaimed);
+	int (*retrieve)(struct liveupdate_file_handler *handler,
+			u64 data, struct file **file);
+	bool (*can_preserve)(struct liveupdate_file_handler *handler,
+			     struct file *file);
+	struct module *owner;
+};
+
+/**
+ * struct liveupdate_file_handler - Represents a handler for a live-updatable
+ * file type.
+ * @ops:           Callback functions
+ * @compatible:    The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
+ *                 that uniquely identifies the file type this handler supports.
+ *                 This is matched against the compatible string associated with
+ *                 individual &struct liveupdate_file instances.
+ * @list:          used for linking this handler instance into a global list of
+ *                 registered file handlers.
+ *
+ * Modules that want to support live update for specific file types should
+ * register an instance of this structure. LUO uses this registration to
+ * determine if a given file can be preserved and to find the appropriate
+ * operations to manage its state across the update.
+ */
+struct liveupdate_file_handler {
+	const struct liveupdate_file_ops *ops;
+	const char *compatible;
+	struct list_head list;
+};
 
 /**
  * struct liveupdate_subsystem_ops - LUO events callback functions
@@ -83,6 +143,9 @@ int liveupdate_register_subsystem(struct liveupdate_subsystem *h);
 int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h);
 int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data);
 
+int liveupdate_register_file_handler(struct liveupdate_file_handler *h);
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *h);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline int liveupdate_reboot(void)
@@ -126,5 +189,15 @@ static inline int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h,
 	return -ENODATA;
 }
 
+static inline int liveupdate_register_file_handler(struct liveupdate_file_handler *h)
+{
+	return 0;
+}
+
+static inline int liveupdate_unregister_file_handler(struct liveupdate_file_handler *h)
+{
+	return 0;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index 47e9ad56675b..c67fa2797796 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -5,6 +5,7 @@
 
 luo-y :=								\
 		luo_core.o						\
+		luo_files.o						\
 		luo_ioctl.o						\
 		luo_subsystems.o
 
diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
new file mode 100644
index 000000000000..4b7568d0f0f0
--- /dev/null
+++ b/kernel/liveupdate/luo_files.c
@@ -0,0 +1,677 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO file descriptors
+ *
+ * LUO provides the infrastructure necessary to preserve
+ * specific types of stateful file descriptors across a kernel live
+ * update transition. The primary goal is to allow workloads, such as virtual
+ * machines using vfio, memfd, or iommufd to retain access to their essential
+ * resources without interruption after the underlying kernel is  updated.
+ *
+ * The framework operates based on handler registration and instance tracking:
+ *
+ * 1. Handler Registration: Kernel modules responsible for specific file
+ * types (e.g., memfd, vfio) register a &struct liveupdate_file_handler
+ * handler. This handler contains callbacks
+ * (&liveupdate_file_handler.ops->prepare,
+ * &liveupdate_file_handler.ops->freeze,
+ * &liveupdate_file_handler.ops->finish, etc.) and a unique 'compatible' string
+ * identifying the file type. Registration occurs via
+ * liveupdate_register_file_handler().
+ *
+ * 2. File Instance Tracking: When a potentially preservable file needs to be
+ * managed for live update, the core LUO logic (luo_register_file()) finds a
+ * compatible registered handler using its
+ * &liveupdate_file_handler.ops->can_preserve callback. If found,  an internal
+ * &struct luo_file instance is created, assigned a unique u64 'token', and
+ * added to a list.
+ *
+ * 3. State Persistence (FDT): During the LUO prepare/freeze phases, the
+ * registered handler callbacks are invoked for each tracked file instance.
+ * These callbacks can generate a u64 data payload representing the minimal
+ * state needed for restoration. This payload, along with the handler's
+ * compatible string and the unique token, is stored in a dedicated
+ * '/file-descriptors' node within the main LUO FDT blob passed via
+ * Kexec Handover (KHO).
+ *
+ * 4. Restoration: In the new kernel, the LUO framework parses the incoming
+ * FDT to reconstruct the list of &struct luo_file instances. When the
+ * original owner requests the file, luo_retrieve_file() uses the corresponding
+ * handler's &liveupdate_file_handler.ops->retrieve callback, passing the
+ * persisted u64 data, to recreate or find the appropriate &struct file object.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/err.h>
+#include <linux/file.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+#include "luo_internal.h"
+
+#define LUO_FILES_NODE_NAME	"file-descriptors"
+#define LUO_FILES_COMPATIBLE	"file-descriptors-v1"
+
+static DEFINE_XARRAY(luo_files_xa_in);
+static DEFINE_XARRAY(luo_files_xa_out);
+static bool luo_files_xa_in_recreated;
+
+/* Registered files. */
+static DECLARE_RWSEM(luo_register_file_list_rwsem);
+static LIST_HEAD(luo_register_file_list);
+
+static DECLARE_RWSEM(luo_file_fdt_rwsem);
+static void *luo_file_fdt_out;
+static void *luo_file_fdt_in;
+
+static size_t luo_file_fdt_out_size;
+
+static atomic64_t luo_files_count;
+
+/**
+ * struct luo_file - Represents a file descriptor instance preserved
+ * across live update.
+ * @fh:            Pointer to the &struct liveupdate_file_handler containing
+ *                 the implementation of prepare, freeze, cancel, and finish
+ *                 operations specific to this file's type.
+ * @file:          A pointer to the kernel's &struct file object representing
+ *                 the open file descriptor that is being preserved.
+ * @private_data:  Internal storage used by the live update core framework
+ *                 between phases.
+ * @reclaimed:     Flag indicating whether this preserved file descriptor has
+ *                 been successfully 'reclaimed' (e.g., requested via an ioctl)
+ *                 by user-space or the owning kernel subsystem in the new
+ *                 kernel after the live update.
+ * @state:         The current state of file descriptor, it is allowed to
+ *                 prepare, freeze, and finish FDs before the global state
+ *                 switch.
+ * @mutex:         Lock to protect FD state, and allow independently to change
+ *                 the FD state compared to global state.
+ *
+ * This structure holds the necessary callbacks and context for managing a
+ * specific open file descriptor throughout the different phases of a live
+ * update process. Instances of this structure are typically allocated,
+ * populated with file-specific details (&file, &arg, callbacks, compatibility
+ * string, token), and linked into a central list managed by the LUO. The
+ * private_data field is used internally by the core logic to store state
+ * between phases.
+ */
+struct luo_file {
+	struct liveupdate_file_handler *fh;
+	struct file *file;
+	u64 private_data;
+	bool reclaimed;
+	enum liveupdate_state state;
+	struct mutex mutex;
+};
+
+static void luo_files_recreate_luo_files_xa_in(void)
+{
+	const char *node_name, *fdt_compat_str;
+	struct liveupdate_file_handler *fh;
+	struct luo_file *luo_file;
+	const void *data_ptr;
+	int file_node_offset;
+	int ret = 0;
+
+	guard(rwsem_read)(&luo_file_fdt_rwsem);
+	if (luo_files_xa_in_recreated || !luo_file_fdt_in)
+		return;
+
+	/* Take write in order to guarantee that we re-create list once */
+	guard(rwsem_write)(&luo_register_file_list_rwsem);
+	if (luo_files_xa_in_recreated)
+		return;
+
+	fdt_for_each_subnode(file_node_offset, luo_file_fdt_in, 0) {
+		bool handler_found = false;
+		u64 token;
+
+		node_name = fdt_get_name(luo_file_fdt_in, file_node_offset,
+					 NULL);
+		if (!node_name) {
+			luo_restore_fail("FDT subnode at offset %d: Cannot get name\n",
+					 file_node_offset);
+		}
+
+		ret = kstrtou64(node_name, 0, &token);
+		if (ret < 0) {
+			luo_restore_fail("FDT node '%s': Failed to parse token\n",
+					 node_name);
+		}
+
+		if (xa_load(&luo_files_xa_in, token)) {
+			luo_restore_fail("Duplicate token %llu found in incoming FDT for file descriptors.\n",
+					 token);
+		}
+
+		fdt_compat_str = fdt_getprop(luo_file_fdt_in, file_node_offset,
+					     "compatible", NULL);
+		if (!fdt_compat_str) {
+			luo_restore_fail("FDT node '%s': Missing 'compatible' property\n",
+					 node_name);
+		}
+
+		data_ptr = fdt_getprop(luo_file_fdt_in, file_node_offset, "data",
+				       NULL);
+		if (!data_ptr) {
+			luo_restore_fail("Can't recover property 'data' for FDT node '%s'\n",
+					 node_name);
+		}
+
+		list_for_each_entry(fh, &luo_register_file_list, list) {
+			if (!strcmp(fh->compatible, fdt_compat_str)) {
+				handler_found = true;
+				break;
+			}
+		}
+
+		if (!handler_found) {
+			luo_restore_fail("FDT node '%s': No registered handler for compatible '%s'\n",
+					 node_name, fdt_compat_str);
+		}
+
+		luo_file = kmalloc(sizeof(*luo_file),
+				   GFP_KERNEL | __GFP_NOFAIL);
+		luo_file->fh = fh;
+		luo_file->file = NULL;
+		memcpy(&luo_file->private_data, data_ptr, sizeof(u64));
+		luo_file->reclaimed = false;
+		mutex_init(&luo_file->mutex);
+		luo_file->state = LIVEUPDATE_STATE_UPDATED;
+		ret = xa_err(xa_store(&luo_files_xa_in, token, luo_file,
+				      GFP_KERNEL | __GFP_NOFAIL));
+		if (ret < 0) {
+			luo_restore_fail("Failed to store luo_file for token %llu in XArray: %d\n",
+					 token, ret);
+		}
+	}
+	luo_files_xa_in_recreated = true;
+}
+
+static size_t luo_files_fdt_size(void)
+{
+	u64 num_files = atomic64_read(&luo_files_count);
+
+	/* Estimate a 1K overhead, + 128 bytes per file entry */
+	return PAGE_SIZE << get_order(SZ_1K + (num_files * 128));
+}
+
+static void luo_files_fdt_cleanup(void)
+{
+	WARN_ON_ONCE(kho_unpreserve_phys(__pa(luo_file_fdt_out),
+					 luo_file_fdt_out_size));
+
+	free_pages((unsigned long)luo_file_fdt_out,
+		   get_order(luo_file_fdt_out_size));
+
+	luo_file_fdt_out_size = 0;
+	luo_file_fdt_out = NULL;
+}
+
+static int luo_files_to_fdt(struct xarray *files_xa_out)
+{
+	const u64 zero_data = 0;
+	unsigned long token;
+	struct luo_file *h;
+	char token_str[19];
+	int ret = 0;
+
+	xa_for_each(files_xa_out, token, h) {
+		snprintf(token_str, sizeof(token_str), "%#0llx", (u64)token);
+
+		ret = fdt_begin_node(luo_file_fdt_out, token_str);
+		if (ret < 0)
+			break;
+
+		ret = fdt_property_string(luo_file_fdt_out, "compatible",
+					  h->fh->compatible);
+		if (ret < 0) {
+			fdt_end_node(luo_file_fdt_out);
+			break;
+		}
+
+		ret = fdt_property_u64(luo_file_fdt_out, "data", zero_data);
+		if (ret < 0) {
+			fdt_end_node(luo_file_fdt_out);
+			break;
+		}
+
+		ret = fdt_end_node(luo_file_fdt_out);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+static int luo_files_fdt_setup(void)
+{
+	int ret;
+
+	guard(rwsem_write)(&luo_file_fdt_rwsem);
+	luo_file_fdt_out_size = luo_files_fdt_size();
+	luo_file_fdt_out = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						    get_order(luo_file_fdt_out_size));
+	if (!luo_file_fdt_out) {
+		pr_err("Failed to allocate FDT memory (%zu bytes)\n",
+		       luo_file_fdt_out_size);
+		luo_file_fdt_out_size = 0;
+		return -ENOMEM;
+	}
+
+	ret = kho_preserve_phys(__pa(luo_file_fdt_out), luo_file_fdt_out_size);
+	if (ret) {
+		pr_err("Failed to kho preserve FDT memory (%zu bytes)\n",
+		       luo_file_fdt_out_size);
+		luo_file_fdt_out_size = 0;
+		luo_file_fdt_out = NULL;
+		return ret;
+	}
+
+	ret = fdt_create(luo_file_fdt_out, luo_file_fdt_out_size);
+	if (ret < 0)
+		goto exit_cleanup;
+
+	ret = fdt_finish_reservemap(luo_file_fdt_out);
+	if (ret < 0)
+		goto exit_finish;
+
+	ret = fdt_begin_node(luo_file_fdt_out, LUO_FILES_NODE_NAME);
+	if (ret < 0)
+		goto exit_finish;
+
+	ret = fdt_property_string(luo_file_fdt_out, "compatible",
+				  LUO_FILES_COMPATIBLE);
+	if (ret < 0)
+		goto exit_end_node;
+
+	ret = luo_files_to_fdt(&luo_files_xa_out);
+	if (ret < 0)
+		goto exit_end_node;
+
+	ret = fdt_end_node(luo_file_fdt_out);
+	if (ret < 0)
+		goto exit_finish;
+
+	ret = fdt_finish(luo_file_fdt_out);
+	if (ret < 0)
+		goto exit_cleanup;
+
+	return 0;
+
+exit_end_node:
+	fdt_end_node(luo_file_fdt_out);
+exit_finish:
+	fdt_finish(luo_file_fdt_out);
+exit_cleanup:
+	pr_err("Failed to setup FDT: %s (ret %d)\n", fdt_strerror(ret), ret);
+	luo_files_fdt_cleanup();
+
+	return ret;
+}
+
+static int luo_files_prepare(struct liveupdate_subsystem *h, u64 *data)
+{
+	int ret;
+
+	ret = luo_files_fdt_setup();
+	if (ret)
+		return ret;
+
+	scoped_guard(rwsem_read, &luo_file_fdt_rwsem)
+		*data = __pa(luo_file_fdt_out);
+
+	return ret;
+}
+
+static int luo_files_freeze(struct liveupdate_subsystem *h, u64 *data)
+{
+	return 0;
+}
+
+static void luo_files_finish(struct liveupdate_subsystem *h, u64 data)
+{
+	luo_files_recreate_luo_files_xa_in();
+}
+
+static void luo_files_cancel(struct liveupdate_subsystem *h, u64 data)
+{
+}
+
+static void luo_files_boot(struct liveupdate_subsystem *h, u64 fdt_pa)
+{
+	int ret;
+
+	ret = fdt_node_check_compatible(__va(fdt_pa), 0,
+					LUO_FILES_COMPATIBLE);
+	if (ret) {
+		luo_restore_fail("FDT '%s' is incompatible with '%s' [%d]\n",
+				 LUO_FILES_NODE_NAME, LUO_FILES_COMPATIBLE,
+				 ret);
+	}
+	scoped_guard(rwsem_write, &luo_file_fdt_rwsem)
+		luo_file_fdt_in = __va(fdt_pa);
+}
+
+static const struct liveupdate_subsystem_ops luo_file_subsys_ops = {
+	.prepare = luo_files_prepare,
+	.freeze = luo_files_freeze,
+	.cancel = luo_files_cancel,
+	.boot = luo_files_boot,
+	.finish = luo_files_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_subsystem luo_file_subsys = {
+	.ops = &luo_file_subsys_ops,
+	.name = LUO_FILES_NODE_NAME,
+};
+
+static int __init luo_files_startup(void)
+{
+	int ret;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	ret = liveupdate_register_subsystem(&luo_file_subsys);
+	if (ret) {
+		pr_warn("Failed to register luo_file subsystem [%d]\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+late_initcall(luo_files_startup);
+
+/**
+ * luo_register_file - Register a file descriptor for live update management.
+ * @token: Token value for this file descriptor.
+ * @fd: file descriptor to be preserved.
+ *
+ * Context: Must be called when LUO is in 'normal' state.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int luo_register_file(u64 token, int fd)
+{
+	struct liveupdate_file_handler *fh;
+	struct luo_file *luo_file;
+	bool found = false;
+	int ret = -ENOENT;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file) {
+		pr_err("Bad file descriptor\n");
+		return -EBADF;
+	}
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		pr_warn("File can be registered only in normal or updated state\n");
+		luo_state_read_exit();
+		fput(file);
+		return -EBUSY;
+	}
+
+	guard(rwsem_read)(&luo_register_file_list_rwsem);
+	list_for_each_entry(fh, &luo_register_file_list, list) {
+		if (fh->ops->can_preserve(fh, file)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		goto exit_unlock;
+
+	luo_file = kmalloc(sizeof(*luo_file), GFP_KERNEL);
+	if (!luo_file) {
+		ret = -ENOMEM;
+		goto exit_unlock;
+	}
+
+	luo_file->private_data = 0;
+	luo_file->reclaimed = false;
+
+	luo_file->file = file;
+	luo_file->fh = fh;
+	mutex_init(&luo_file->mutex);
+	luo_file->state = LIVEUPDATE_STATE_NORMAL;
+
+	if (xa_load(&luo_files_xa_out, token)) {
+		ret = -EEXIST;
+		pr_warn("Token %llu is already taken\n", token);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+		goto exit_unlock;
+	}
+
+	ret = xa_err(xa_store(&luo_files_xa_out, token, luo_file,
+			      GFP_KERNEL));
+	if (ret < 0) {
+		pr_warn("Failed to store file for token %llu in XArray: %d\n",
+			token, ret);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+		goto exit_unlock;
+	}
+	atomic64_inc(&luo_files_count);
+
+exit_unlock:
+	luo_state_read_exit();
+
+	if (ret)
+		fput(file);
+
+	return ret;
+}
+
+static int __luo_unregister_file(u64 token)
+{
+	struct luo_file *luo_file;
+
+	luo_file = xa_erase(&luo_files_xa_out, token);
+	if (!luo_file)
+		return -ENOENT;
+
+	fput(luo_file->file);
+	mutex_destroy(&luo_file->mutex);
+	kfree(luo_file);
+	atomic64_dec(&luo_files_count);
+
+	return 0;
+}
+
+/**
+ * luo_unregister_file - Unregister a file instance using its token.
+ * @token: The unique token of the file instance to unregister.
+ *
+ * Finds the &struct luo_file associated with the @token in the
+ * global list and removes it. This function *only* removes the entry from the
+ * list; it does *not* free the memory allocated for the &struct luo_file
+ * itself. The caller is responsible for freeing the structure after this
+ * function returns successfully.
+ *
+ * Context: Can be called when a preserved file descriptor is closed or
+ * no longer needs live update management.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int luo_unregister_file(u64 token)
+{
+	int ret = 0;
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		pr_warn("File can be unregistered only in normal or updates state\n");
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	ret = __luo_unregister_file(token);
+	if (ret) {
+		pr_warn("Failed to unregister: token %llu not found.\n",
+			token);
+	}
+	luo_state_read_exit();
+
+	return ret;
+}
+
+/**
+ * luo_retrieve_file - Find a registered file instance by its token.
+ * @token: The unique token of the file instance to retrieve.
+ * @filep: Output parameter. On success (return value 0), this will point
+ * to the retrieved "struct file".
+ *
+ * Searches the global list for a &struct luo_file matching the @token. Uses a
+ * read lock, allowing concurrent retrievals.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int luo_retrieve_file(u64 token, struct file **filep)
+{
+	struct luo_file *luo_file;
+	int ret = 0;
+
+	luo_files_recreate_luo_files_xa_in();
+	luo_state_read_enter();
+	if (!liveupdate_state_updated()) {
+		pr_warn("File can be retrieved only in updated state\n");
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	luo_file = xa_load(&luo_files_xa_in, token);
+	if (luo_file && !luo_file->reclaimed) {
+		scoped_guard(mutex, &luo_file->mutex) {
+			if (!luo_file->reclaimed) {
+				luo_file->reclaimed = true;
+				ret = luo_file->fh->ops->retrieve(luo_file->fh,
+								  luo_file->private_data,
+								  filep);
+				if (!ret)
+					luo_file->file = *filep;
+			}
+		}
+	} else if (luo_file && luo_file->reclaimed) {
+		pr_err("The file descriptor for token %lld has already been retrieved\n",
+		       token);
+		ret = -EINVAL;
+	} else {
+		ret = -ENOENT;
+	}
+
+	luo_state_read_exit();
+
+	return ret;
+}
+
+/**
+ * liveupdate_register_file_handler - Register a file handler with LUO.
+ * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
+ * The caller must initialize this structure, including a unique
+ * 'compatible' string and a valid 'fh' callbacks. This function adds the
+ * handler to the global list of supported file handlers.
+ *
+ * Context: Typically called during module initialization for file types that
+ * support live update preservation.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
+{
+	struct liveupdate_file_handler *fh_iter;
+	int ret = 0;
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	guard(rwsem_write)(&luo_register_file_list_rwsem);
+	list_for_each_entry(fh_iter, &luo_register_file_list, list) {
+		if (!strcmp(fh_iter->compatible, fh->compatible)) {
+			pr_err("File handler registration failed: Compatible string '%s' already registered.\n",
+			       fh->compatible);
+			ret = -EEXIST;
+			goto exit_unlock;
+		}
+	}
+
+	if (!try_module_get(fh->ops->owner)) {
+		pr_warn("File handler '%s' unable to get reference.\n",
+			fh->compatible);
+		ret = -EAGAIN;
+		goto exit_unlock;
+	}
+
+	INIT_LIST_HEAD(&fh->list);
+	list_add_tail(&fh->list, &luo_register_file_list);
+
+exit_unlock:
+	luo_state_read_exit();
+
+	return ret;
+}
+
+/**
+ * liveupdate_unregister_file - Unregister a file handler.
+ * @fh: Pointer to the specific &struct liveupdate_file_handler instance
+ * that was previously returned by or passed to
+ * liveupdate_register_file_handler.
+ *
+ * Removes the specified handler instance @fh from the global list of
+ * registered file handlers. This function only removes the entry from the
+ * list; it does not free the memory associated with @fh itself. The caller
+ * is responsible for freeing the structure memory after this function returns
+ * successfully.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
+{
+	unsigned long token;
+	struct luo_file *h;
+	int ret = 0;
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	guard(rwsem_write)(&luo_register_file_list_rwsem);
+
+	xa_for_each(&luo_files_xa_out, token, h) {
+		if (h->fh == fh) {
+			luo_state_read_exit();
+			return -EBUSY;
+		}
+	}
+
+	list_del_init(&fh->list);
+	luo_state_read_exit();
+	module_put(fh->ops->owner);
+
+	return ret;
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 40bfbe279d34..5692196fd425 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -34,4 +34,8 @@ int luo_do_subsystems_freeze_calls(void);
 void luo_do_subsystems_finish_calls(void);
 void luo_do_subsystems_cancel_calls(void);
 
+int luo_retrieve_file(u64 token, struct file **filep);
+int luo_register_file(u64 token, int fd);
+int luo_unregister_file(u64 token);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.1.565.gc32cd1483b-goog


