Return-Path: <linux-fsdevel+bounces-69484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4560C7D8BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EB5B350600
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59D2D3EC1;
	Sat, 22 Nov 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="F4gTOmRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A02BEFE0
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850245; cv=none; b=N4OLnT5Llvo589/Lrlx/O2JX/3bZdjNnPlaa/c9B8wT9RQXA2d13Fg8ELm4e0C174GcZbds21qVVf6LRVqad1v9HJ10gKoEsmrbdYqOfLidi4bFIqBAnlwKdbrqU9IGA2Aue+CqZPRj3K4Q/cg9HZIpx6wHh0vzX3RSc5yoFRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850245; c=relaxed/simple;
	bh=3nfw+zx4IScFJ5mrBLPkQXCSS1yFCVNe+3qg09HSg7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs+oQ2wyrHE9bi3efhJqnJvxPUWY1xhmfu2mzf3kzhTZPoE+7Nmew/6TQpeOVO6Z3wxqsINtB0VtpbveuAkcwW+DrX+8D6QTECixxSo5PXrxyuxI3+gtcATbI3kBO9+OYdn1+zqjEl6+rjqm2u1Q2IxmWNzHD1tr8A2Lek8WoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=F4gTOmRE; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640f88b873bso2736371d50.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850241; x=1764455041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ou+OqCZKXj1OdOlQOs0wG/rcVUwC/PJeGlhuLikCmu4=;
        b=F4gTOmREaeJok/wBkRc0u4mkmNQe/rCEviTvJ3wCwpsTZSyIJ/Q+HgejCeZhaQoWRi
         ZJekCQrE+XyAdaaaV2cLOHfHfkp8xuUSN8ktEkpYIpheZDDeYk9xFlZahCEApwrP1iow
         ZUmRqcDZV158RHaUAo7T44Y7tc1mai/OTQbdQdfk2tnXDGDW3V0f5CZj5Xj49Hv5loCp
         LBh+2s09+m3I0PELJDTw2c0FnTQe5VQeKgkUNCcrcGEgTwPzmt8lvM7c3wbY/BZ9NuUf
         EYFy9eY/Dimn/4WjMRFQFOdgceLQ+vxA0GTEhsKHh3ex+eKaYHpNBwSZfA0jokbXtMN9
         foVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850241; x=1764455041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ou+OqCZKXj1OdOlQOs0wG/rcVUwC/PJeGlhuLikCmu4=;
        b=rc19vuWhRU3iRao+1x59zLLjoDkSedtlbxE5ufTyMdIRwNNKSC0oOTHSUv/MaQ/3rI
         nHRS3ZE55BbGdt1u8fpQjzPNMIe6Y2J1UM0YX7Ef3xNCzjd7AV43NLpVDhLD3pRJ5L2Y
         J1D74sYnBVxLJrwwMeasMWBh20QSsfaHhFE3LaFYZ8CoGCIPmwBN3V1v9d+GYWCLxJHz
         VcpaOFcooYFKBZB7Uu16TCsA/8WFmxNrJl2RkjA8OVSx6h5+Oi1ik8ZHPV3YApT9+1BT
         R+gCcevI1xGXB/XUJ/sMLqBU4nJ5ocRBz4Mz4pX/7ShgAlGQuTh7LiOAFjxDbx4beJQW
         iLOw==
X-Forwarded-Encrypted: i=1; AJvYcCXu0x10GIbrjfM+wqM3ZHA0cEYk1pPCjx/6M9jH58kO9F7owSil1DIAvEhp7FhnIFY3UVjTkqsNpno6gFzw@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2mWBfMrujEXo3MZ2W+D+aVbT4XnxlX5DaS/aWQjY2tRvo807
	UZOv0ROL7gEj/0NzW8/Kij5kBGoa6KmK2C3gTblGMFOh2bKMVwmyuokv6FyJ+47/wPU=
X-Gm-Gg: ASbGncseVSxxJcUK+nMkGZyiysGZ7Cn1PzFKJHc/q0mxeCLINmgfJ0rIJGmVsmVOTiw
	VihiB2ByfvJMViXA3ULJASvT+F1RLawTnd844DvP6mceqf76q0wu34zF7RTYLCQpM0Mc72Y/rWk
	YHlilzhG6jIvf/R0ULh0DXxCeiWauZIdWaXDZmH2SAiPekOhZOnE27dTtHHiLWWAf5mk7nIrZQy
	UM86rnVN2qNiEQQgKbt4kwTnpM71zqeQwkkF5ihdqTXym8STOEyt+zjxj6rmjftMYq94sIv8ZmI
	+zZY1wvfuz/fsVK3SmviC/1i65g9kZH2N+48nm/hRoXPgQAE/jwbyR7n4uABP3YkG0tY6sgpOlx
	VhLsgRjkZ9wfR+2jz0mNraqF4vPfko/7KensGlRHeoA4cSCnFalciVCU419WGy5YP/0GWBQf5Sv
	71ynsRudrYaDKYQP11pgiKd6RZdTIcyVw8rrjfHLTUw1eN6JJduL0xoT7kOx73dkMglT5aHMLY5
	2Bz9/I=
X-Google-Smtp-Source: AGHT+IGfZof8qUF1IkZZI7c6YLOTPv1WiDaxFjl7jw8fTLuhBRkKSr+RcqIexB8nICTyaMONoMz9vw==
X-Received: by 2002:a05:690e:d08:b0:641:e826:bb71 with SMTP id 956f58d0204a3-643029b20e8mr4919920d50.0.1763850240618;
        Sat, 22 Nov 2025 14:24:00 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:00 -0800 (PST)
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
Subject: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
Date: Sat, 22 Nov 2025 17:23:29 -0500
Message-ID: <20251122222351.1059049-3-pasha.tatashin@soleen.com>
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

Integrate the LUO with the KHO framework to enable passing LUO state
across a kexec reboot.

This patch implements the lifecycle integration with KHO:

1. Incoming State: During early boot (`early_initcall`), LUO checks if
   KHO is active. If so, it retrieves the "LUO" subtree, verifies the
   "luo-v1" compatibility string, and reads the `liveupdate-number` to
   track the update count.

2. Outgoing State: During late initialization (`late_initcall`), LUO
   allocates a new FDT for the next kernel, populates it with the basic
   header (compatible string and incremented update number), and
   registers it with KHO (`kho_add_subtree`).

3. Finalization: The `liveupdate_reboot()` notifier is updated to invoke
   `kho_finalize()`. This ensures that all memory segments marked for
   preservation are properly serialized before the kexec jump.

LUO now depends on `CONFIG_KEXEC_HANDOVER`.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h      |  54 +++++++++++
 kernel/liveupdate/luo_core.c     | 154 ++++++++++++++++++++++++++++++-
 kernel/liveupdate/luo_internal.h |  22 +++++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kho/abi/luo.h
 create mode 100644 kernel/liveupdate/luo_internal.h

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
new file mode 100644
index 000000000000..8523b3ff82d1
--- /dev/null
+++ b/include/linux/kho/abi/luo.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Live Update Orchestrator ABI
+ *
+ * This header defines the stable Application Binary Interface used by the
+ * Live Update Orchestrator to pass state from a pre-update kernel to a
+ * post-update kernel. The ABI is built upon the Kexec HandOver framework
+ * and uses a Flattened Device Tree to describe the preserved data.
+ *
+ * This interface is a contract. Any modification to the FDT structure, node
+ * properties, compatible strings, or the layout of the `__packed` serialization
+ * structures defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the relevant `_COMPATIBLE` string to
+ * prevent a new kernel from misinterpreting data from an old kernel.
+ *
+ * FDT Structure Overview:
+ *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
+ *   This entry contains an FDT with the following layout:
+ *
+ *   .. code-block:: none
+ *
+ *     / {
+ *         compatible = "luo-v1";
+ *         liveupdate-number = <...>;
+ *     };
+ *
+ * Main LUO Node (/):
+ *
+ *   - compatible: "luo-v1"
+ *     Identifies the overall LUO ABI version.
+ *   - liveupdate-number: u64
+ *     A counter tracking the number of successful live updates performed.
+ */
+
+#ifndef _LINUX_KHO_ABI_LUO_H
+#define _LINUX_KHO_ABI_LUO_H
+
+/*
+ * The LUO FDT hooks all LUO state for sessions, fds, etc.
+ * In the root it also carries "liveupdate-number" 64-bit property that
+ * corresponds to the number of live-updates performed on this machine.
+ */
+#define LUO_FDT_SIZE		PAGE_SIZE
+#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
+#define LUO_FDT_COMPATIBLE	"luo-v1"
+#define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
+
+#endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 30ad8836360b..9f9fe9a81b29 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -41,12 +41,26 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/kobject.h>
+#include <linux/libfdt.h>
 #include <linux/liveupdate.h>
 #include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#include "kexec_handover_internal.h"
+#include "luo_internal.h"
 
 static struct {
 	bool enabled;
+	void *fdt_out;
+	void *fdt_in;
+	u64 liveupdate_num;
 } luo_global;
 
 static int __init early_liveupdate_param(char *buf)
@@ -55,6 +69,129 @@ static int __init early_liveupdate_param(char *buf)
 }
 early_param("liveupdate", early_liveupdate_param);
 
+static int __init luo_early_startup(void)
+{
+	phys_addr_t fdt_phys;
+	int err, ln_size;
+	const void *ptr;
+
+	if (!kho_is_enabled()) {
+		if (liveupdate_enabled())
+			pr_warn("Disabling liveupdate because KHO is disabled\n");
+		luo_global.enabled = false;
+		return 0;
+	}
+
+	/* Retrieve LUO subtree, and verify its format. */
+	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys);
+	if (err) {
+		if (err != -ENOENT) {
+			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
+			       LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
+			return err;
+		}
+
+		return 0;
+	}
+
+	luo_global.fdt_in = phys_to_virt(fdt_phys);
+	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
+					LUO_FDT_COMPATIBLE);
+	if (err) {
+		pr_err("FDT '%s' is incompatible with '%s' [%d]\n",
+		       LUO_FDT_KHO_ENTRY_NAME, LUO_FDT_COMPATIBLE, err);
+
+		return -EINVAL;
+	}
+
+	ln_size = 0;
+	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_LIVEUPDATE_NUM,
+			  &ln_size);
+	if (!ptr || ln_size != sizeof(luo_global.liveupdate_num)) {
+		pr_err("Unable to get live update number '%s' [%d]\n",
+		       LUO_FDT_LIVEUPDATE_NUM, ln_size);
+
+		return -EINVAL;
+	}
+
+	luo_global.liveupdate_num = get_unaligned((u64 *)ptr);
+	pr_info("Retrieved live update data, liveupdate number: %lld\n",
+		luo_global.liveupdate_num);
+
+	return 0;
+}
+
+static int __init liveupdate_early_init(void)
+{
+	int err;
+
+	err = luo_early_startup();
+	if (err) {
+		luo_global.enabled = false;
+		luo_restore_fail("The incoming tree failed to initialize properly [%pe], disabling live update\n",
+				 ERR_PTR(err));
+	}
+
+	return err;
+}
+early_initcall(liveupdate_early_init);
+
+/* Called during boot to create outgoing LUO fdt tree */
+static int __init luo_fdt_setup(void)
+{
+	const u64 ln = luo_global.liveupdate_num + 1;
+	void *fdt_out;
+	int err;
+
+	fdt_out = kho_alloc_preserve(LUO_FDT_SIZE);
+	if (IS_ERR(fdt_out)) {
+		pr_err("failed to allocate/preserve FDT memory\n");
+		return PTR_ERR(fdt_out);
+	}
+
+	err = fdt_create(fdt_out, LUO_FDT_SIZE);
+	err |= fdt_finish_reservemap(fdt_out);
+	err |= fdt_begin_node(fdt_out, "");
+	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
+	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
+	err |= fdt_end_node(fdt_out);
+	err |= fdt_finish(fdt_out);
+	if (err)
+		goto exit_free;
+
+	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out);
+	if (err)
+		goto exit_free;
+	luo_global.fdt_out = fdt_out;
+
+	return 0;
+
+exit_free:
+	kho_unpreserve_free(fdt_out);
+	pr_err("failed to prepare LUO FDT: %d\n", err);
+
+	return err;
+}
+
+/*
+ * late initcall because it initializes the outgoing tree that is needed only
+ * once userspace starts using /dev/liveupdate.
+ */
+static int __init luo_late_startup(void)
+{
+	int err;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	err = luo_fdt_setup();
+	if (err)
+		luo_global.enabled = false;
+
+	return err;
+}
+late_initcall(luo_late_startup);
+
 /* Public Functions */
 
 /**
@@ -69,7 +206,22 @@ early_param("liveupdate", early_liveupdate_param);
  */
 int liveupdate_reboot(void)
 {
-	return 0;
+	int err;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	err = kho_finalize();
+	if (err) {
+		pr_err("kho_finalize failed %d\n", err);
+		/*
+		 * kho_finalize() may return libfdt errors, to aboid passing to
+		 * userspace unknown errors, change this to EAGAIN.
+		 */
+		err = -EAGAIN;
+	}
+
+	return err;
 }
 
 /**
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
new file mode 100644
index 000000000000..8612687b2000
--- /dev/null
+++ b/kernel/liveupdate/luo_internal.h
@@ -0,0 +1,22 @@
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
+#include <linux/liveupdate.h>
+
+/*
+ * Handles a deserialization failure: devices and memory is in unpredictable
+ * state.
+ *
+ * Continuing the boot process after a failure is dangerous because it could
+ * lead to leaks of private data.
+ */
+#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
+
+#endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.52.0.rc2.455.g230fcf2819-goog


