Return-Path: <linux-fsdevel+bounces-53011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63876AE9254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E417A4E1E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F432FCE32;
	Wed, 25 Jun 2025 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="sP89KzmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DA307AF5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893551; cv=none; b=c375PZDCrc6gR+s7AekwS5Nwq9IRlZbb+brqVG1Ui44COsFcIIl3FRoBLUXf3I29M1TwWdQHCcVVKAq7w9y5a9zeOMLisM2oBVe84lcoRb2PslatWYEFexejPeuGKl7MsxGNcgLItKGfc58hpXEubsu/xQSGvwktnXv92N6LNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893551; c=relaxed/simple;
	bh=JEBv7ujCg/6ppGBPUrQkC9q5/Jniw7vqQmsSqDtLHdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjKcEMSEgzXza/2j9IujZOgq1X+edGQ0cXEOKPwkDWdTXFqEur5uU7o6a4/ka9JxcUYcBuZk0Ou0R5yxqZnZ3ecdfj5RDm4bKjUsMTdYEAlmnCq78aPAYZKsMirjR8Q5tXo8UEFac6v+0YlD8ewENx7jk5X43hXoYjCiQ0VQyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=sP89KzmU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so315202276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893547; x=1751498347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LimjlICD6sUHgsbY/Y2oVH6YvmC/VDcU5uGtC2pfHEg=;
        b=sP89KzmUJSP1w6eLr5RmWbXJDy1y3q5merdtcRli4gFLkCd+/BRAdG6cU/Ag+Ku0ZN
         0aIKSWJoLrAOpjzymcwQemEAIpyAgOHvtoqPQJBoa5yTEtngD9Fwm1dMYIsocr32mkMQ
         4IyksvUfFFzQTSuyR4e2zoEN+C6r1uqzJ6+fEHE4VT5bZ16zwn3E1XAJBOJBPEviYoKD
         9LOW/CallSgXTagNapQTnrLwOCq3GFtkQzpCYCOqI9cvUInmCm2XiszPqtdozQ3Rp4Np
         IQI49MrNbBLLKBDZ6CH2VHIyN7GuK8q/ua87SVkbke+gVmX3MWL3DKNeeMO266wKfkgJ
         qTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893547; x=1751498347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LimjlICD6sUHgsbY/Y2oVH6YvmC/VDcU5uGtC2pfHEg=;
        b=flIcmez0lUt3IvarKr7HflCaXe1apBzqeAIrYCBzdAYHp05kDp4NBcw161dSEWPw0D
         mV27/oWzMSpLdgUIa5T/ktIUA8MUnDIw9KZrCgwXmVNDvuV8HNK9vjXciNmuHOJEHEOh
         pjhOaixXRLiMYj6Zx+n+VEeekUIsOwAi/Z4OtMJQXdzrckWSzpVpjOFCtmmLRprRjVyi
         KZ7VEl+B6zjotghLAEPOyRfp5ojMcStoBrbiQQxXdIhXF0mEk8vLoUfwtGmkwBHRXs05
         jD4ZUHKkUCY7k9um7sQ1mQo/GRX/J+STthOVJaIthdZSHobDZWJTsBnOT46Qa09r7Kn+
         pNDA==
X-Forwarded-Encrypted: i=1; AJvYcCWB63J/b4GmSsHMYiNQ7DCgRZpEILTEI22ScJoB3VPIe6huHPhc/Yy9MDN8BUJA0MhyjO9MlCcAy7FLnd5j@vger.kernel.org
X-Gm-Message-State: AOJu0YxfixhsPpVSUY0+pxrQYd7LTKtoCT2BLQbu7ZY9zu0e2b+vUZsZ
	12A1D01lcp7HmKmb+Us1yUPUBKnlnTqB3+HM02j1kfLOZF+pSQEryO03zOsvAGELGcg=
X-Gm-Gg: ASbGnctNx2XGhKmLVF3AMPM0kskcHzppC5lIegYLR9S1tHpF+9s0kQeEkH3V5bPKcKs
	OaC3BM71BrKaMqa5z3+Qq3IXbdvkM0nI2lS958JyGpJNcfHV48D+fSFCkajNtYLw7BGrKlCRbEi
	2SxvNsu2aDZgDtv5Bnaq3nthJzeNnP3vM305a2uJrnj5YC+wwxwct3SM6ZSvvJgEgybgAnyJDuH
	hPh3uJiurpWukQ79yljIBhknjoLaL7ijdJMTCBuV8Jk5rSC7p577DCG9djDCLkSFds1HizOGK5/
	Zfufk0ihiNA6glnzed8gI9EyveAEU87kxzJzGcYkMSeveWbtVimf+vbPuBjBP+A0gPlPfitCuwx
	BGgM+z73lei/imJ+pKO5xPOtfVTiMafbpGUtMyW8X51PZXhIXxQEfkXTPQjIlyI8=
X-Google-Smtp-Source: AGHT+IGu2WAR4FR4EPR+F7ziPNzvRl1Fc8v7SjdbR09dC5+Z93Z5wRlVgHdrsEbJjK/h3jUtwcIiXw==
X-Received: by 2002:a05:6902:138d:b0:e84:13c9:67d7 with SMTP id 3f1490d57ef6-e860171d6d3mr5935837276.20.1750893547311;
        Wed, 25 Jun 2025 16:19:07 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:06 -0700 (PDT)
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
Subject: [PATCH v1 14/32] liveupdate: luo_files: add infrastructure for FDs
Date: Wed, 25 Jun 2025 23:18:01 +0000
Message-ID: <20250625231838.1897085-15-pasha.tatashin@soleen.com>
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
 include/linux/liveupdate.h       |  68 ++++
 kernel/liveupdate/Makefile       |   1 +
 kernel/liveupdate/luo_files.c    | 663 +++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |   4 +
 4 files changed, 736 insertions(+)
 create mode 100644 kernel/liveupdate/luo_files.c

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index fed68b9ab32b..28a8aa4cafca 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -88,6 +88,61 @@ enum liveupdate_state  {
 	LIVEUPDATE_STATE_UPDATED = 4,
 };
 
+struct file;
+
+/**
+ * struct liveupdate_file_ops - Callbacks for for live-updatable files.
+ * @prepare:       Optional. Saves state for a specific file instance (@file,
+ *                 @arg) before update, potentially returning value via @data.
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
+ * @can_preserve:  callback to determine if @file with associated context (@arg)
+ *                 can be preserved by this handler.
+ *                 Return bool (true if preservable, false otherwise).
+ */
+struct liveupdate_file_ops {
+	int (*prepare)(struct file *file, void *arg, u64 *data);
+	int (*freeze)(struct file *file, void *arg, u64 *data);
+	void (*cancel)(struct file *file, void *arg, u64 data);
+	void (*finish)(struct file *file, void *arg, u64 data, bool reclaimed);
+	int (*retrieve)(void *arg, u64 data, struct file **file);
+	bool (*can_preserve)(struct file *file, void *arg);
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
+ * @arg:           An opaque pointer to implementation-specific context data
+ *                 associated with this file handler registration.
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
+	void *arg;
+	struct list_head list;
+};
+
 /**
  * struct liveupdate_subsystem_ops - LUO events callback functions
  * @prepare:      Optional. Called during LUO prepare phase. Should perform
@@ -154,6 +209,9 @@ int liveupdate_register_subsystem(struct liveupdate_subsystem *h);
 int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h);
 int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data);
 
+int liveupdate_register_file_handler(struct liveupdate_file_handler *h);
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *h);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline int liveupdate_reboot(void)
@@ -197,5 +255,15 @@ static inline int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h,
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
index 999208a1fdbb..b5054140b9a9 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_LIVEUPDATE)		+= luo_core.o
+obj-$(CONFIG_LIVEUPDATE)		+= luo_files.o
 obj-$(CONFIG_LIVEUPDATE)		+= luo_subsystems.o
diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
new file mode 100644
index 000000000000..3582f1ec96c4
--- /dev/null
+++ b/kernel/liveupdate/luo_files.c
@@ -0,0 +1,663 @@
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
+ * @mutex:          Lock to protect FD state, and allow independently to change
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
+	if (luo_files_xa_in_recreated || !luo_file_fdt_in)
+		return;
+
+	/* Take write in order to guarantee that we re-create list once */
+	down_write(&luo_register_file_list_rwsem);
+	if (luo_files_xa_in_recreated)
+		goto exit_unlock;
+
+	fdt_for_each_subnode(file_node_offset, luo_file_fdt_in, 0) {
+		bool handler_found = false;
+		u64 token;
+
+		node_name = fdt_get_name(luo_file_fdt_in, file_node_offset,
+					 NULL);
+		if (!node_name) {
+			panic("FDT subnode at offset %d: Cannot get name\n",
+			      file_node_offset);
+		}
+
+		ret = kstrtou64(node_name, 0, &token);
+		if (ret < 0) {
+			panic("FDT node '%s': Failed to parse token\n",
+			      node_name);
+		}
+
+		if (xa_load(&luo_files_xa_in, token)) {
+			panic("Duplicate token %llu found in incoming FDT for file descriptors.\n",
+			      token);
+		}
+
+		fdt_compat_str = fdt_getprop(luo_file_fdt_in, file_node_offset,
+					     "compatible", NULL);
+		if (!fdt_compat_str) {
+			panic("FDT node '%s': Missing 'compatible' property\n",
+			      node_name);
+		}
+
+		data_ptr = fdt_getprop(luo_file_fdt_in, file_node_offset, "data",
+				       NULL);
+		if (!data_ptr) {
+			panic("Can't recover property 'data' for FDT node '%s'\n",
+			      node_name);
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
+			panic("FDT node '%s': No registered handler for compatible '%s'\n",
+			      node_name, fdt_compat_str);
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
+			panic("Failed to store luo_file for token %llu in XArray: %d\n",
+			      token, ret);
+		}
+	}
+	luo_files_xa_in_recreated = true;
+
+exit_unlock:
+	up_write(&luo_register_file_list_rwsem);
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
+static int luo_files_prepare(void *arg, u64 *data)
+{
+	int ret;
+
+	ret = luo_files_fdt_setup();
+	if (ret)
+		return ret;
+
+	*data = __pa(luo_file_fdt_out);
+
+	return ret;
+}
+
+static int luo_files_freeze(void *arg, u64 *data)
+{
+	return 0;
+}
+
+static void luo_files_finish(void *arg, u64 data)
+{
+	luo_files_recreate_luo_files_xa_in();
+}
+
+static void luo_files_cancel(void *arg, u64 data)
+{
+}
+
+static const struct liveupdate_subsystem_ops luo_file_subsys_ops = {
+	.prepare = luo_files_prepare,
+	.freeze = luo_files_freeze,
+	.cancel = luo_files_cancel,
+	.finish = luo_files_finish,
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
+	if (liveupdate_state_updated()) {
+		u64 fdt_pa;
+
+		ret = liveupdate_get_subsystem_data(&luo_file_subsys, &fdt_pa);
+		if (ret)
+			panic("Failed to retrieve luo_file data [%d]\n", ret);
+
+		ret = fdt_node_check_compatible(__va(fdt_pa), 0,
+						LUO_FILES_COMPATIBLE);
+		if (ret) {
+			panic("FDT '%s' is incompatible with '%s' [%d]\n",
+			      LUO_FILES_NODE_NAME, LUO_FILES_COMPATIBLE, ret);
+		}
+		luo_file_fdt_in = __va(fdt_pa);
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
+	down_read(&luo_register_file_list_rwsem);
+	list_for_each_entry(fh, &luo_register_file_list, list) {
+		if (fh->ops->can_preserve(file, fh->arg)) {
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
+	up_read(&luo_register_file_list_rwsem);
+	luo_state_read_exit();
+
+	if (ret)
+		fput(file);
+
+	return ret;
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
+	struct luo_file *luo_file;
+	int ret = 0;
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		pr_warn("File can be unregistered only in normal or updates state\n");
+		luo_state_read_exit();
+		return -EBUSY;
+	}
+
+	luo_file = xa_erase(&luo_files_xa_out, token);
+	if (luo_file) {
+		fput(luo_file->file);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+		atomic64_dec(&luo_files_count);
+	} else {
+		pr_warn("Failed to unregister: token %llu not found.\n",
+			token);
+		ret = -ENOENT;
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
+		mutex_lock(&luo_file->mutex);
+		if (!luo_file->reclaimed) {
+			luo_file->reclaimed = true;
+			ret = luo_file->fh->ops->retrieve(luo_file->fh->arg,
+							  luo_file->private_data,
+							  filep);
+			if (!ret)
+				luo_file->file = *filep;
+		}
+		mutex_unlock(&luo_file->mutex);
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
+	down_write(&luo_register_file_list_rwsem);
+	list_for_each_entry(fh_iter, &luo_register_file_list, list) {
+		if (!strcmp(fh_iter->compatible, fh->compatible)) {
+			pr_err("File handler registration failed: Compatible string '%s' already registered.\n",
+			       fh->compatible);
+			ret = -EEXIST;
+			goto exit_unlock;
+		}
+	}
+
+	INIT_LIST_HEAD(&fh->list);
+	list_add_tail(&fh->list, &luo_register_file_list);
+
+exit_unlock:
+	up_write(&luo_register_file_list_rwsem);
+	luo_state_read_exit();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
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
+	down_write(&luo_register_file_list_rwsem);
+
+	xa_for_each(&luo_files_xa_out, token, h) {
+		if (h->fh == fh) {
+			up_write(&luo_register_file_list_rwsem);
+			luo_state_read_exit();
+			return -EBUSY;
+		}
+	}
+
+	list_del_init(&fh->list);
+	up_write(&luo_register_file_list_rwsem);
+	luo_state_read_exit();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 98bf799adb61..f77e8b3044f9 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -25,4 +25,8 @@ int luo_do_subsystems_freeze_calls(void);
 void luo_do_subsystems_finish_calls(void);
 void luo_do_subsystems_cancel_calls(void);
 
+int luo_retrieve_file(u64 token, struct file **filep);
+int luo_register_file(u64 token, int fd);
+int luo_unregister_file(u64 token);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


