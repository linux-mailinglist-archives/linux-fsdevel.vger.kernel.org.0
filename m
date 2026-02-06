Return-Path: <linux-fsdevel+bounces-76636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPWAA10/hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:22:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD36102A6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 596E4309D83B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B442E01B;
	Fri,  6 Feb 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="sdYCdS6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE442E001
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405192; cv=none; b=HFotWbxbkyPNQTlU+gxS/RKtfnWVEii5zPwTotpgnWrw+4HuIQLq032v5H9z/6SlU+7k9fNlEgdn67989z0C79s2t4OfC/WNDk5FaqiQwj3vuxhccGU1NiAVuRpYnaa1kf8aEQiIo/m+/Wk9frx7WsELYjtC0ds7wP/bdkAJjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405192; c=relaxed/simple;
	bh=uzb0Wmip9GI4B1gGq8HYrnW2SoCSKaczLTjwlI4YvRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+4u6KzxNEWGSVUqb1aVeswW1uF0cmYPLDZgOcZPbNgyLU00zQTh9Hh7zcPVC1iyyMOXXSqfC1gUos7MJ107rxSyyFuskA0v3bx3q3Eqx3AamHvVZGp9qu+rdJaNQgoM8CkVWZXOSDG0iX2k5/jTpiBT6k0KK2yDsoruyeLHHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=sdYCdS6y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7948e902fadso23505657b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770405191; x=1771009991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb1OdGpCtAwc8beSe19LPmFPW+UDoGnStsGyK3KBbAk=;
        b=sdYCdS6yPNJcxM9SkyHcwMajxeK1f1j0kNTWs4p52la1wEkLGwnK724yqo2OAuqBcJ
         Opa2pNvGV4tVB1xbqmlMR4QVnMO26AjHNYWxgNsLY5MX5T3l9Pvbde5U1wp9kexriSRU
         x9wRZOsnxjoS7NUkqpkabil6lcI4B+i6SKNpoqwmHAIcyQwThPHmq3Acs5ds3DrM03Ee
         B16t9PRvU2LLirh5cu901TXbS0ESqn65WpDnCQWkdbjBgj7DFHgTIK3p8t6hmXVo1kEM
         znBkhBfazcwQbmMsQT0RVH3Bow8wbRQe08jBmtnjea9PVz54mZVGnsBas09JNLpuv/69
         gsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405191; x=1771009991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eb1OdGpCtAwc8beSe19LPmFPW+UDoGnStsGyK3KBbAk=;
        b=h78zB6zhXsXcylIcSRs6/B6SsGepC9Mg78uMz7ras5UJ9WhBCf7K3+1WjzaCBz5ELE
         RzgRZ3VVKjNIPyQdKyhgm9RQKrAb/KgixG9vLen6s8HjFoXqka1uOSZUnYP4iOO2lNuc
         BFIMqDyvsMDMGo3iLfSxGYZBkmz6Zd7d/553r0phbMIMmzqpBAVaRBYUi2Luih5l2acJ
         x8Bn9aFm2aDUW9gDv73D3q/GqRU51vteRwAkdCErx3Db1GffLsYtxEhfeeuTKl6GCNnJ
         0NS1DiY1mNvM84TFC9k0Maz/fsWRHUATwkS7nE+IXQTpHwWZDL2Ysw8biXwXO/XM8ccJ
         un6Q==
X-Gm-Message-State: AOJu0YyI8ZyclViydxcjcrnZepYOAev4Tg5U2uT8XvvjTBRyAshU6IzY
	P8jN7HErvR9EQA2cExFV7kiISYpqOlxCkS2dE9tP2pjTmZI+rsgM+G0pILK3mOsQLQwrG+A6+iB
	K2iT8JTo=
X-Gm-Gg: AZuq6aJ+125/MXujmMzMv85CKjLZSH8QLnSsuXR74x1xMIZZSAMBgR/Womkh6jB12uF
	OMOdbxJhKUWA5idGPT1wL4AQMZcX+vxQ+vbXbYadePsRQti0arMUhboNGM5Co/8XRMYZLPupmt0
	jEaCAfgGBkxjyRrKac6VRJqZoCudNxRE5Ag/pzG1nvOfdy24CotLvg/q6rLmU5v+Hl7BYD1l54w
	KCLsNJXB5+jTdW2Xbjc47QHATCOymlH8rBWbMRdDGzcbkZ8dO9cb7EPJqbaBipQ9MPphEA462M8
	aClc3r5Qf8p1nUuoSf0MKXxwD8liFPMwn5B5FRguroPKCRqnXrWm1OowjIM9Ii35Rmcxv6Fxda2
	P6liejkMisazFHHmn/o31WaPRXQnZ9ygKPhffWfrM0S2xCXmK1vBG6NvE2pH1BQWZPnsvmfMJxO
	z2vbk9Y+hfwoDZFL6AwLhJQa6v2Dxdj5zcpBpicsHKUoSJYGvrTkSRDsIJCwSwPLwWWLcpCMJB5
	SE9Yw5sfVmJ
X-Received: by 2002:a05:690c:6b09:b0:795:294c:fd30 with SMTP id 00721157ae682-7952ab3fc08mr29459087b3.39.1770405190554;
        Fri, 06 Feb 2026 11:13:10 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9fc0:ed7d:72bd:ecd1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28697fsm29051277b3.50.2026.02.06.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:13:09 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/4] ml-lib: Implement PoC of Machine Learning (ML) library functionality
Date: Fri,  6 Feb 2026 11:11:34 -0800
Message-Id: <20260206191136.2609767-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206191136.2609767-1-slava@dubeyko.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dubeyko.com];
	TAGGED_FROM(0.00)[bounces-76636-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:mid,dubeyko.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBD36102A6F
X-Rspamd-Action: no action

ML model can be represented by process/thread running in user-space.
Particular kernel subsystem needs to implement ML model proxy
on kernel-space side. The process of loading kernel subsystem
creates and intializes the ML model proxy, create sysfs entries,
and character device, for example. The sysfs entries and character
device create the mechanism of interaction and collaboration of
kernel subsystem and ML model in user-space.

The simplest model of collaboration could include such steps:
(1) user-space process/thread (ML model) sends START command
    to kernel subsystem through sysfs control entry;
(2) user-space process/thread (ML model) requests to prepare
    a dataset by means of PREPARE_DATASET command through
    sysfs control entry;
(3) user-space process/thread (ML model) extracts the dataset
    by means of reading data from character device;
(4) dataset can be marked as obsolete after extraction
    by means of DISCARD_DATASET command through sysfs control entry
    and new dataset can be requested and extracted;
(5) extracted data can be used as training data by ML model
    on user-space side;
(6) ML model can execute the inference after some number of
    training cycles and to elaborate some recommendations or
    optimized logic for kernel subsystem;
(7) ML model's recommendations can be written into character
    device, for example, by user-space process/thread and
    kernel subsystem can use this recommendations for
    optimization or changing the logic;
(8) based on kernel subsystem's mode, recommendations can be
    completely ignored, partially applied, tested, or
    used instead of default configuration/logic;
(9) every time efficiency of applied recommendations or
    logic needs to be estimated;
(10) if ML model recommendations degrade efficiency of kernel
     subsystem, then error backpropagation needs to be used
     for ML model correction on user-space side.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 lib/Kconfig              |   6 +
 lib/Makefile             |   2 +
 lib/ml-lib/Kconfig       |  18 +
 lib/ml-lib/Makefile      |   7 +
 lib/ml-lib/ml_lib_main.c | 758 +++++++++++++++++++++++++++++++++++++++
 lib/ml-lib/sysfs.c       | 187 ++++++++++
 lib/ml-lib/sysfs.h       |  17 +
 7 files changed, 995 insertions(+)
 create mode 100644 lib/ml-lib/Kconfig
 create mode 100644 lib/ml-lib/Makefile
 create mode 100644 lib/ml-lib/ml_lib_main.c
 create mode 100644 lib/ml-lib/sysfs.c
 create mode 100644 lib/ml-lib/sysfs.h

diff --git a/lib/Kconfig b/lib/Kconfig
index 2923924bea78..2d56977c0638 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -604,6 +604,12 @@ config LWQ_TEST
 	help
           Run boot-time test of light-weight queuing.
 
+#
+# Machine Learning (ML) library configuration
+#
+
+source "lib/ml-lib/Kconfig"
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index aaf677cf4527..154e7fd220ab 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -332,3 +332,5 @@ obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
 
 subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
+
+obj-$(CONFIG_ML_LIB) += ml-lib/
diff --git a/lib/ml-lib/Kconfig b/lib/ml-lib/Kconfig
new file mode 100644
index 000000000000..d2f2ea40a833
--- /dev/null
+++ b/lib/ml-lib/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+#
+# Machine Learning (ML) library configuration
+#
+
+config ML_LIB
+	tristate "ML library support"
+	help
+	  Machine Learning (ML) library has goal to provide
+	  the interaction and communication of ML models in
+	  user-space with kernel subsystems. It implements
+	  the basic code primitives that builds the way of
+	  ML models integration into Linux kernel functionality.
+
+	  If unsure, say N.
+
+source "lib/ml-lib/test_driver/Kconfig"
diff --git a/lib/ml-lib/Makefile b/lib/ml-lib/Makefile
new file mode 100644
index 000000000000..b1103ab3e1c8
--- /dev/null
+++ b/lib/ml-lib/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ML_LIB) += ml_lib.o
+
+ml_lib-y := sysfs.o ml_lib_main.o
+
+obj-$(CONFIG_ML_LIB_TEST_DRIVER) += test_driver/
diff --git a/lib/ml-lib/ml_lib_main.c b/lib/ml-lib/ml_lib_main.c
new file mode 100644
index 000000000000..ef336d6a83fb
--- /dev/null
+++ b/lib/ml-lib/ml_lib_main.c
@@ -0,0 +1,758 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Machine Learning (ML) library
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <linux/ml-lib/ml_lib.h>
+
+#include "sysfs.h"
+
+#define UNKNOWN_SUBSYSTEM_NAME "unknown_subsystem"
+#define UNKNOWN_ML_MODEL_NAME "unknown_model"
+
+/*
+ * default_ml_model_ops - default ML model operations
+ */
+struct ml_lib_model_operations default_ml_model_ops = {
+	.create				= generic_create_ml_model,
+	.init				= generic_init_ml_model,
+	.re_init			= generic_re_init_ml_model,
+	.start				= generic_start_ml_model,
+	.stop				= generic_stop_ml_model,
+	.destroy			= generic_destroy_ml_model,
+	.get_system_state		= generic_get_system_state,
+	.get_dataset			= generic_get_dataset,
+	.preprocess_data		= generic_preprocess_data,
+	.publish_data			= generic_publish_data,
+	.preprocess_recommendation	= generic_preprocess_recommendation,
+	.estimate_system_state		= generic_estimate_system_state,
+	.apply_recommendation		= generic_apply_recommendation,
+	.execute_operation		= generic_execute_operation,
+	.estimate_efficiency		= generic_estimate_efficiency,
+	.error_backpropagation		= generic_error_backpropagation,
+	.correct_system_state		= generic_correct_system_state,
+};
+
+/******************************************************************************
+ *                             ML library API                                 *
+ ******************************************************************************/
+
+void *allocate_ml_model(size_t size, gfp_t gfp)
+{
+	struct ml_lib_model *ml_model;
+
+	if (size < sizeof(struct ml_lib_model))
+		return ERR_PTR(-EINVAL);
+
+	ml_model = kzalloc(size, gfp);
+	if (unlikely(!ml_model))
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&ml_model->mode, ML_LIB_UNKNOWN_MODE);
+	atomic_set(&ml_model->state, ML_LIB_UNKNOWN_MODEL_STATE);
+	ml_model->model_ops = &default_ml_model_ops;
+
+	return (void *)ml_model;
+}
+EXPORT_SYMBOL(allocate_ml_model);
+
+void free_ml_model(struct ml_lib_model *ml_model)
+{
+	if (!ml_model)
+		return;
+
+	free_subsystem_object(ml_model->parent);
+	kfree(ml_model);
+}
+EXPORT_SYMBOL(free_ml_model);
+
+void *allocate_subsystem_object(size_t size, gfp_t gfp)
+{
+	struct ml_lib_subsystem *subsystem;
+
+	if (size < sizeof(struct ml_lib_subsystem))
+		return ERR_PTR(-EINVAL);
+
+	subsystem = kzalloc(size, gfp);
+	if (unlikely(!subsystem))
+		return ERR_PTR(-ENOMEM);
+
+	subsystem->size = size;
+	atomic_set(&subsystem->type, ML_LIB_UNKNOWN_SUBSYSTEM_TYPE);
+
+	return (void *)subsystem;
+}
+EXPORT_SYMBOL(allocate_subsystem_object);
+
+void free_subsystem_object(struct ml_lib_subsystem *object)
+{
+	if (!object)
+		return;
+
+	kfree(object);
+}
+EXPORT_SYMBOL(free_subsystem_object);
+
+void *allocate_ml_model_options(size_t size, gfp_t gfp)
+{
+	struct ml_lib_model_options *options;
+
+	if (size < sizeof(struct ml_lib_model_options))
+		return ERR_PTR(-EINVAL);
+
+	options = kzalloc(size, gfp);
+	if (unlikely(!options))
+		return ERR_PTR(-ENOMEM);
+
+	options->sleep_timeout = U32_MAX;
+
+	return (void *)options;
+}
+EXPORT_SYMBOL(allocate_ml_model_options);
+
+void free_ml_model_options(struct ml_lib_model_options *options)
+{
+	if (!options)
+		return;
+
+	kfree(options);
+}
+EXPORT_SYMBOL(free_ml_model_options);
+
+void *allocate_subsystem_state(size_t size, gfp_t gfp)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(allocate_subsystem_state);
+
+void free_subsystem_state(struct ml_lib_subsystem_state *state)
+{
+}
+EXPORT_SYMBOL(free_subsystem_state);
+
+void *allocate_dataset(size_t size, gfp_t gfp)
+{
+	struct ml_lib_dataset *dataset;
+
+	if (size < sizeof(struct ml_lib_dataset))
+		return ERR_PTR(-EINVAL);
+
+	dataset = kzalloc(size, gfp);
+	if (unlikely(!dataset))
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&dataset->type, ML_LIB_UNKNOWN_DATASET_TYPE);
+	atomic_set(&dataset->state, ML_LIB_UNKNOWN_DATASET_STATE);
+
+	return (void *)dataset;
+}
+EXPORT_SYMBOL(allocate_dataset);
+
+void free_dataset(struct ml_lib_dataset *dataset)
+{
+	if (!dataset)
+		return;
+
+	kfree(dataset);
+}
+EXPORT_SYMBOL(free_dataset);
+
+void *allocate_request_config(size_t size, gfp_t gfp)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(allocate_request_config);
+
+void free_request_config(struct ml_lib_request_config *config)
+{
+}
+EXPORT_SYMBOL(free_request_config);
+
+int ml_model_create(struct ml_lib_model *ml_model,
+		    const char *subsystem_name,
+		    const char *model_name,
+		    struct kobject *subsystem_kobj)
+{
+	struct kobject *parent = NULL;
+	size_t size;
+	int err = 0;
+
+	if (!ml_model)
+		return -EINVAL;
+
+	if (!subsystem_name)
+		ml_model->subsystem_name = UNKNOWN_SUBSYSTEM_NAME;
+	else
+		ml_model->subsystem_name = subsystem_name;
+
+	if (!model_name)
+		ml_model->model_name = UNKNOWN_ML_MODEL_NAME;
+	else
+		ml_model->model_name = model_name;
+
+	if (!subsystem_kobj)
+		parent = kernel_kobj;
+	else
+		parent = subsystem_kobj;
+
+	spin_lock_init(&ml_model->parent_state_lock);
+	spin_lock_init(&ml_model->options_lock);
+	spin_lock_init(&ml_model->dataset_lock);
+
+	err = ml_model_create_sysfs_group(ml_model, parent);
+	if (err) {
+		pr_err("ml_lib: failed to create sysfs group: err %d\n", err);
+		goto finish_model_create;
+	}
+
+	if (!ml_model->model_ops || !ml_model->model_ops->create) {
+		size = sizeof(struct ml_lib_subsystem);
+
+		ml_model->parent = allocate_subsystem_object(size, GFP_KERNEL);
+		if (unlikely(!ml_model->parent)) {
+			err = -ENOMEM;
+			goto remove_sysfs_group;
+		}
+
+		atomic_set(&ml_model->parent->type, ML_LIB_GENERIC_SUBSYSTEM);
+	} else {
+		err = ml_model->model_ops->create(ml_model);
+		if (unlikely(err)) {
+			pr_err("ml_lib: failed to create ML model: err %d\n",
+				err);
+			goto remove_sysfs_group;
+		}
+	}
+
+	atomic_set(&ml_model->state, ML_LIB_MODEL_CREATED);
+
+	return 0;
+
+remove_sysfs_group:
+	ml_model_delete_sysfs_group(ml_model);
+
+finish_model_create:
+	return err;
+}
+EXPORT_SYMBOL(ml_model_create);
+
+int ml_model_init(struct ml_lib_model *ml_model,
+		  struct ml_lib_model_options *options)
+{
+	struct ml_lib_model_options *old_options;
+	int err = 0;
+
+	if (!ml_model)
+		return -EINVAL;
+
+	if (!ml_model->model_ops || !ml_model->model_ops->init)
+		options->sleep_timeout = ML_LIB_SLEEP_TIMEOUT_DEFAULT;
+	else {
+		err = ml_model->model_ops->init(ml_model, options);
+		if (unlikely(err)) {
+			pr_err("ml_lib: failed to init ML model: err %d\n",
+				err);
+			goto finish_model_init;
+		}
+	}
+
+	spin_lock(&ml_model->options_lock);
+	old_options = rcu_dereference_protected(ml_model->options,
+				lockdep_is_held(&ml_model->options_lock));
+	rcu_assign_pointer(ml_model->options, options);
+	spin_unlock(&ml_model->options_lock);
+	synchronize_rcu();
+	free_ml_model_options(old_options);
+
+	atomic_set(&ml_model->state, ML_LIB_MODEL_INITIALIZED);
+
+finish_model_init:
+	return err;
+}
+EXPORT_SYMBOL(ml_model_init);
+
+int ml_model_re_init(struct ml_lib_model *ml_model,
+		     struct ml_lib_model_options *options)
+{
+	struct ml_lib_model_options *old_options;
+
+	if (!ml_model)
+		return -EINVAL;
+
+	spin_lock(&ml_model->options_lock);
+	old_options = rcu_dereference_protected(ml_model->options,
+				lockdep_is_held(&ml_model->options_lock));
+	rcu_assign_pointer(ml_model->options, options);
+	spin_unlock(&ml_model->options_lock);
+	synchronize_rcu();
+	free_ml_model_options(old_options);
+
+	return 0;
+}
+EXPORT_SYMBOL(ml_model_re_init);
+
+int ml_model_start(struct ml_lib_model *ml_model,
+		   struct ml_lib_model_run_config *config)
+{
+	if (!ml_model)
+		return -EINVAL;
+
+	/* TODO: implement ML model start logic*/
+	atomic_set(&ml_model->state, ML_LIB_MODEL_STARTED);
+	pr_err("ml_lib: TODO: implement start ML model\n");
+	return 0;
+}
+EXPORT_SYMBOL(ml_model_start);
+
+int ml_model_stop(struct ml_lib_model *ml_model)
+{
+	if (!ml_model)
+		return -EINVAL;
+
+	/* TODO: implement ML model stop logic*/
+	atomic_set(&ml_model->state, ML_LIB_MODEL_STOPPED);
+	pr_err("ml_lib: TODO: implement stop ML model\n");
+	return 0;
+}
+EXPORT_SYMBOL(ml_model_stop);
+
+void ml_model_destroy(struct ml_lib_model *ml_model)
+{
+	struct ml_lib_model_options *old_options;
+	struct ml_lib_dataset *old_dataset;
+
+	if (!ml_model)
+		return;
+
+	atomic_set(&ml_model->state, ML_LIB_MODEL_SHUTTING_DOWN);
+
+	ml_model_delete_sysfs_group(ml_model);
+
+	spin_lock(&ml_model->options_lock);
+	old_options = rcu_dereference_protected(ml_model->options,
+				lockdep_is_held(&ml_model->options_lock));
+	rcu_assign_pointer(ml_model->options, NULL);
+	spin_unlock(&ml_model->options_lock);
+	synchronize_rcu();
+	free_ml_model_options(old_options);
+
+	spin_lock(&ml_model->dataset_lock);
+	old_dataset = rcu_dereference_protected(ml_model->dataset,
+				lockdep_is_held(&ml_model->dataset_lock));
+	rcu_assign_pointer(ml_model->dataset, NULL);
+	spin_unlock(&ml_model->dataset_lock);
+	synchronize_rcu();
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->destroy) {
+		/*
+		 * Do nothing
+		 */
+	} else
+		ml_model->dataset_ops->destroy(old_dataset);
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->free)
+		free_dataset(old_dataset);
+	else
+		ml_model->dataset_ops->free(old_dataset);
+
+	if (!ml_model->model_ops || !ml_model->model_ops->destroy) {
+		atomic_set(&ml_model->parent->type,
+			   ML_LIB_UNKNOWN_SUBSYSTEM_TYPE);
+	} else
+		ml_model->model_ops->destroy(ml_model);
+
+	atomic_set(&ml_model->state, ML_LIB_MODEL_STATE_MAX);
+}
+EXPORT_SYMBOL(ml_model_destroy);
+
+struct ml_lib_subsystem_state *get_system_state(struct ml_lib_model *ml_model)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(get_system_state);
+
+int ml_model_get_dataset(struct ml_lib_model *ml_model,
+			 struct ml_lib_request_config *config,
+			 struct ml_lib_user_space_request *request)
+{
+	struct ml_lib_dataset *old_dataset;
+	struct ml_lib_dataset *new_dataset;
+	size_t desc_size = sizeof(struct ml_lib_dataset);
+	int state;
+	int err = 0;
+
+	if (!ml_model)
+		return -EINVAL;
+
+	atomic_set(&ml_model->state, ML_LIB_MODEL_RUNNING);
+
+	rcu_read_lock();
+	old_dataset = rcu_dereference(ml_model->dataset);
+	if (old_dataset)
+		state = atomic_read(&old_dataset->state);
+	else
+		state = ML_LIB_UNKNOWN_DATASET_STATE;
+	rcu_read_unlock();
+
+	switch (state) {
+	case ML_LIB_DATASET_CLEAN:
+	case ML_LIB_DATASET_EXTRACTED_PARTIALLY:
+	case ML_LIB_DATASET_EXTRACTED_COMPLETELY:
+		/* nothing should be done */
+		goto finish_get_dataset;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->allocate)
+		new_dataset = allocate_dataset(desc_size, GFP_KERNEL);
+	else {
+		new_dataset = ml_model->dataset_ops->allocate(desc_size,
+							      GFP_KERNEL);
+	}
+
+	if (IS_ERR(new_dataset)) {
+		err = PTR_ERR(new_dataset);
+		pr_err("ml_lib: Failed to allocate dataset\n");
+		return err;
+	} else if (!new_dataset) {
+		err = -ENOMEM;
+		pr_err("ml_lib: Failed to allocate dataset\n");
+		return err;
+	}
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->init) {
+		/*
+		 * Do nothing
+		 */
+	} else {
+		err = ml_model->dataset_ops->init(new_dataset);
+		if (err) {
+			pr_err("ml_lib: Failed to init dataset: err %d\n",
+				err);
+			goto fail_get_dataset;
+		}
+	}
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->extract) {
+		atomic_set(&new_dataset->type, ML_LIB_EMPTY_DATASET);
+		atomic_set(&new_dataset->state, ML_LIB_DATASET_CLEAN);
+		new_dataset->allocated_size = 0;
+		new_dataset->portion_offset = 0;
+		new_dataset->portion_size = 0;
+	} else {
+		err = ml_model->dataset_ops->extract(ml_model, new_dataset);
+		if (err) {
+			pr_err("ml_lib: Failed to extract dataset: err %d\n",
+				err);
+			goto fail_get_dataset;
+		}
+	}
+
+	spin_lock(&ml_model->dataset_lock);
+	old_dataset = rcu_dereference_protected(ml_model->dataset,
+				lockdep_is_held(&ml_model->dataset_lock));
+	rcu_assign_pointer(ml_model->dataset, new_dataset);
+	spin_unlock(&ml_model->dataset_lock);
+	synchronize_rcu();
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->destroy) {
+		/*
+		 * Do nothing
+		 */
+	} else
+		ml_model->dataset_ops->destroy(old_dataset);
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->free)
+		free_dataset(old_dataset);
+	else
+		ml_model->dataset_ops->free(old_dataset);
+
+finish_get_dataset:
+	return 0;
+
+fail_get_dataset:
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->destroy) {
+		/*
+		 * Do nothing
+		 */
+	} else
+		ml_model->dataset_ops->destroy(new_dataset);
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->free)
+		free_dataset(new_dataset);
+	else
+		ml_model->dataset_ops->free(new_dataset);
+
+	return err;
+}
+EXPORT_SYMBOL(ml_model_get_dataset);
+
+int ml_model_discard_dataset(struct ml_lib_model *ml_model)
+{
+	struct ml_lib_dataset *old_dataset;
+	struct ml_lib_dataset *new_dataset;
+	size_t desc_size = sizeof(struct ml_lib_dataset);
+	int err;
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->allocate)
+		new_dataset = allocate_dataset(desc_size, GFP_KERNEL);
+	else {
+		new_dataset = ml_model->dataset_ops->allocate(desc_size,
+							      GFP_KERNEL);
+	}
+
+	if (IS_ERR(new_dataset)) {
+		err = PTR_ERR(new_dataset);
+		pr_err("ml_lib: Failed to allocate dataset\n");
+		return err;
+	} else if (!new_dataset) {
+		err = -ENOMEM;
+		pr_err("ml_lib: Failed to allocate dataset\n");
+		return err;
+	}
+
+	spin_lock(&ml_model->dataset_lock);
+	old_dataset = rcu_dereference_protected(ml_model->dataset,
+				lockdep_is_held(&ml_model->dataset_lock));
+	if (old_dataset) {
+		atomic_set(&new_dataset->type, atomic_read(&old_dataset->type));
+		new_dataset->allocated_size = old_dataset->allocated_size;
+		new_dataset->portion_offset = old_dataset->portion_offset;
+		new_dataset->portion_size = old_dataset->portion_size;
+	} else {
+		atomic_set(&new_dataset->type, ML_LIB_EMPTY_DATASET);
+		new_dataset->allocated_size = 0;
+		new_dataset->portion_offset = 0;
+		new_dataset->portion_size = 0;
+	}
+	atomic_set(&new_dataset->state, ML_LIB_DATASET_OBSOLETE);
+	rcu_assign_pointer(ml_model->dataset, new_dataset);
+	spin_unlock(&ml_model->dataset_lock);
+	synchronize_rcu();
+
+	if (!ml_model->dataset_ops || !ml_model->dataset_ops->free)
+		free_dataset(old_dataset);
+	else
+		ml_model->dataset_ops->free(old_dataset);
+
+	return 0;
+}
+EXPORT_SYMBOL(ml_model_discard_dataset);
+
+int ml_model_preprocess_data(struct ml_lib_model *ml_model,
+			     struct ml_lib_dataset *dataset)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(ml_model_preprocess_data);
+
+int ml_model_publish_data(struct ml_lib_model *ml_model,
+			  struct ml_lib_dataset *dataset,
+			  struct ml_lib_user_space_notification *notify)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(ml_model_publish_data);
+
+int ml_model_preprocess_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(ml_model_preprocess_recommendation);
+
+int estimate_system_state(struct ml_lib_model *ml_model)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(estimate_system_state);
+
+int apply_ml_model_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(apply_ml_model_recommendation);
+
+int execute_ml_model_operation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(execute_ml_model_operation);
+
+int estimate_ml_model_efficiency(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(estimate_ml_model_efficiency);
+
+int ml_model_error_backpropagation(struct ml_lib_model *ml_model,
+			    struct ml_lib_backpropagation_feedback *feedback,
+			    struct ml_lib_user_space_notification *notify)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(ml_model_error_backpropagation);
+
+int correct_system_state(struct ml_lib_model *ml_model)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(correct_system_state);
+
+/******************************************************************************
+ *              Generic implementation of ML model's methods                  *
+ ******************************************************************************/
+
+int generic_create_ml_model(struct ml_lib_model *ml_model)
+{
+	size_t size = sizeof(struct ml_lib_subsystem);
+
+	ml_model->parent = allocate_subsystem_object(size, GFP_KERNEL);
+	if (unlikely(!ml_model->parent))
+		return -ENOMEM;
+
+	atomic_set(&ml_model->parent->type, ML_LIB_GENERIC_SUBSYSTEM);
+	atomic_set(&ml_model->mode, ML_LIB_EMERGENCY_MODE);
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_create_ml_model);
+
+int generic_init_ml_model(struct ml_lib_model *ml_model,
+			  struct ml_lib_model_options *options)
+{
+	options->sleep_timeout = ML_LIB_SLEEP_TIMEOUT_DEFAULT;
+	return 0;
+}
+EXPORT_SYMBOL(generic_init_ml_model);
+
+int generic_re_init_ml_model(struct ml_lib_model *ml_model,
+			     struct ml_lib_model_options *options)
+{
+	options->sleep_timeout = ML_LIB_SLEEP_TIMEOUT_DEFAULT;
+	return 0;
+}
+EXPORT_SYMBOL(generic_re_init_ml_model);
+
+int generic_start_ml_model(struct ml_lib_model *ml_model,
+			   struct ml_lib_model_run_config *config)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_start_ml_model);
+
+int generic_stop_ml_model(struct ml_lib_model *ml_model)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_stop_ml_model);
+
+void generic_destroy_ml_model(struct ml_lib_model *ml_model)
+{
+	atomic_set(&ml_model->parent->type, ML_LIB_UNKNOWN_SUBSYSTEM_TYPE);
+	atomic_set(&ml_model->mode, ML_LIB_UNKNOWN_MODE);
+}
+EXPORT_SYMBOL(generic_destroy_ml_model);
+
+struct ml_lib_subsystem_state *
+generic_get_system_state(struct ml_lib_model *ml_model)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(generic_get_system_state);
+
+int generic_get_dataset(struct ml_lib_model *ml_model,
+			struct ml_lib_dataset *dataset)
+{
+	atomic_set(&dataset->type, ML_LIB_EMPTY_DATASET);
+	atomic_set(&dataset->state, ML_LIB_DATASET_CLEAN);
+	dataset->allocated_size = 0;
+	dataset->portion_offset = 0;
+	dataset->portion_size = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_get_dataset);
+
+int generic_preprocess_data(struct ml_lib_model *ml_model,
+			    struct ml_lib_dataset *dataset)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_preprocess_data);
+
+int generic_publish_data(struct ml_lib_model *ml_model,
+			 struct ml_lib_dataset *dataset,
+			 struct ml_lib_user_space_notification *notify)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_publish_data);
+
+int generic_preprocess_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_preprocess_recommendation);
+
+int generic_estimate_system_state(struct ml_lib_model *ml_model)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_estimate_system_state);
+
+int generic_apply_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_apply_recommendation);
+
+int generic_execute_operation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_execute_operation);
+
+int generic_estimate_efficiency(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_estimate_efficiency);
+
+int generic_error_backpropagation(struct ml_lib_model *ml_model,
+			    struct ml_lib_backpropagation_feedback *feedback,
+			    struct ml_lib_user_space_notification *notify)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_error_backpropagation);
+
+int generic_correct_system_state(struct ml_lib_model *ml_model)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(generic_correct_system_state);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Viacheslav Dubeyko <slava@dubeyko.com>");
+MODULE_DESCRIPTION("ML library");
+MODULE_VERSION("1.0");
diff --git a/lib/ml-lib/sysfs.c b/lib/ml-lib/sysfs.c
new file mode 100644
index 000000000000..fb4b7f44f793
--- /dev/null
+++ b/lib/ml-lib/sysfs.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Machine Learning (ML) library
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <linux/ml-lib/ml_lib.h>
+
+#include "sysfs.h"
+
+struct ml_lib_feature_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct ml_lib_feature_attr *,
+			struct ml_lib_model *,
+			char *);
+	ssize_t (*store)(struct ml_lib_feature_attr *,
+				struct ml_lib_model *,
+				const char *, size_t);
+};
+
+#define ML_LIB_ATTR(type, name, mode, show, store) \
+	static struct ml_lib_##type##_attr ml_lib_##type##_attr_##name = \
+		__ATTR(name, mode, show, store)
+
+#define ML_LIB_FEATURE_INFO_ATTR(name) \
+	ML_LIB_ATTR(feature, name, 0444, NULL, NULL)
+#define ML_LIB_FEATURE_RO_ATTR(name) \
+	ML_LIB_ATTR(feature, name, 0444, ml_lib_feature_##name##_show, NULL)
+#define ML_LIB_FEATURE_W_ATTR(name) \
+	ML_LIB_ATTR(feature, name, 0220, NULL, ml_lib_feature_##name##_store)
+#define ML_LIB_FEATURE_RW_ATTR(name) \
+	ML_LIB_ATTR(feature, name, 0644, \
+		    ml_lib_feature_##name##_show, ml_lib_feature_##name##_store)
+
+enum {
+	ML_LIB_START_COMMAND,
+	ML_LIB_STOP_COMMAND,
+	ML_LIB_PREPARE_DATASET_COMMAND,
+	ML_LIB_DISCARD_DATASET_COMMAND,
+	ML_LIB_COMMAND_NUMBER
+};
+
+static const char *control_command_str[ML_LIB_COMMAND_NUMBER] = {
+	"start",
+	"stop",
+	"prepare_dataset",
+	"discard_dataset",
+};
+
+static ssize_t ml_lib_feature_control_store(struct ml_lib_feature_attr *attr,
+					    struct ml_lib_model *ml_model,
+					    const char *buf, size_t len)
+{
+	struct ml_lib_model_run_config config = {0};
+	int i;
+	int err;
+
+	for (i = 0; i < ML_LIB_COMMAND_NUMBER; i++) {
+		size_t iter_len = min(len, strlen(control_command_str[i]));
+
+		if (strncmp(control_command_str[i], buf, iter_len) == 0)
+			break;
+	}
+
+	if (i >= ML_LIB_COMMAND_NUMBER)
+		return -EOPNOTSUPP;
+
+	switch (i) {
+	case ML_LIB_START_COMMAND:
+		err = ml_model_start(ml_model, &config);
+		break;
+
+	case ML_LIB_STOP_COMMAND:
+		err = ml_model_stop(ml_model);
+		break;
+
+	case ML_LIB_PREPARE_DATASET_COMMAND:
+		err = ml_model_get_dataset(ml_model, NULL, NULL);
+		break;
+
+	case ML_LIB_DISCARD_DATASET_COMMAND:
+		err = ml_model_discard_dataset(ml_model);
+		break;
+	}
+
+	if (unlikely(err))
+		return err;
+
+	return len;
+}
+
+ML_LIB_FEATURE_W_ATTR(control);
+
+static struct attribute *ml_model_attrs[] = {
+	&ml_lib_feature_attr_control.attr,
+	NULL,
+};
+
+static const struct attribute_group ml_model_group = {
+	.attrs = ml_model_attrs,
+};
+
+static const struct attribute_group *ml_model_groups[] = {
+	&ml_model_group,
+	NULL,
+};
+
+static
+ssize_t ml_model_attr_show(struct kobject *kobj,
+			   struct attribute *attr,
+			   char *buf)
+{
+	struct ml_lib_model *ml_model = container_of(kobj,
+						     struct ml_lib_model,
+						     kobj);
+	struct ml_lib_feature_attr *ml_model_attr =
+			container_of(attr, struct ml_lib_feature_attr, attr);
+
+	if (!ml_model_attr->show)
+		return -EIO;
+
+	return ml_model_attr->show(ml_model_attr, ml_model, buf);
+}
+
+static
+ssize_t ml_model_attr_store(struct kobject *kobj,
+			    struct attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct ml_lib_model *ml_model = container_of(kobj,
+						     struct ml_lib_model,
+						     kobj);
+	struct ml_lib_feature_attr *ml_model_attr =
+			container_of(attr, struct ml_lib_feature_attr, attr);
+
+	if (!ml_model_attr->store)
+		return -EIO;
+
+	return ml_model_attr->store(ml_model_attr, ml_model, buf, len);
+}
+
+static const struct sysfs_ops ml_model_attr_ops = {
+	.show	= ml_model_attr_show,
+	.store	= ml_model_attr_store,
+};
+
+static inline
+void ml_model_kobj_release(struct kobject *kobj)
+{
+	struct ml_lib_model *ml_model = container_of(kobj,
+						     struct ml_lib_model,
+						     kobj);
+	complete(&ml_model->kobj_unregister);
+}
+
+static struct kobj_type ml_model_ktype = {
+	.default_groups = ml_model_groups,
+	.sysfs_ops	= &ml_model_attr_ops,
+	.release	= ml_model_kobj_release,
+};
+
+int ml_model_create_sysfs_group(struct ml_lib_model *ml_model,
+				struct kobject *subsystem_kobj)
+{
+	int err;
+
+	init_completion(&ml_model->kobj_unregister);
+
+	err = kobject_init_and_add(&ml_model->kobj, &ml_model_ktype,
+				   subsystem_kobj,
+				   "%s", ml_model->model_name);
+	if (err)
+		pr_err("ml_lib: failed to create sysfs group: err %d\n", err);
+
+	return err;
+}
+
+void ml_model_delete_sysfs_group(struct ml_lib_model *ml_model)
+{
+	kobject_del(&ml_model->kobj);
+	kobject_put(&ml_model->kobj);
+	wait_for_completion(&ml_model->kobj_unregister);
+}
diff --git a/lib/ml-lib/sysfs.h b/lib/ml-lib/sysfs.h
new file mode 100644
index 000000000000..6bd3ab64a1c0
--- /dev/null
+++ b/lib/ml-lib/sysfs.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Machine Learning (ML) library
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _LINUX_ML_LIB_SYSFS_H
+#define _LINUX_ML_LIB_SYSFS_H
+
+#include <linux/sysfs.h>
+
+int ml_model_create_sysfs_group(struct ml_lib_model *ml_model,
+				struct kobject *subsystem_kobj);
+void ml_model_delete_sysfs_group(struct ml_lib_model *ml_model);
+
+#endif /* _LINUX_ML_LIB_SYSFS_H */
-- 
2.34.1


