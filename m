Return-Path: <linux-fsdevel+bounces-72937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC2D06262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 407C630814BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CE3328EA;
	Thu,  8 Jan 2026 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Bu/wvCUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866493321A7
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904750; cv=none; b=CMJDFO2Mbe/lVAYp66tmfSAMetkJZ2uUntGyFhfIoCiqH/y5luuXW3rxvp9qQ1IoBT6NnvCvuQZ+Dr956UeAEXEY+rAkJ3CrbIABodckDADHvx6BZn/+ZWmVHstl+j3ZJJM4k5DPqMybhxJrfL6B34G/ThcF2RIF/VCbvti2opE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904750; c=relaxed/simple;
	bh=xii4wO1lEnLuXt5FEyh6bs/i4HOiIb27LXChmEfzilo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtktXq0QITOBfdic1yhKik4p6rgmgGiAh8L3NgFv6ZXt6A2sOoK8C6+ScJaRhSnGJ9couK4TWxlyu/yqbbPFfskB1z60uJnEXZF4PnbJKW8R8gZV9f1jB2gjzUbo35gd15vBZJKdaVmrLkqZtfRHd6TINHnQGviiTNuxq1+Ap44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Bu/wvCUS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b29ff9d18cso377273285a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904744; x=1768509544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwgM57cBzuIgAiPMK5GxhnYsXF2RBvqFNs+qFbak5h0=;
        b=Bu/wvCUSzvE1wOrM1YeQH/zu/nTFQkmi/JULxPvAXca4qSjAhWGwiUvRUT89s2X6xE
         r5CnFWg01qf11wPsRE5OmpeoETNGxmtlwaGcCSH3JyhfX5Vq0LKgn22h7EyHHHUNZxW6
         RSPDle7YU7Bl0z/G00liKYzEwSq1NCubdSUHrXwAH0y09MNg7bITTrHNoG4j7pq6D4Pl
         ZYROv9A6/IbC3tu8J4qZNHJa67t8MGPwFGr3cddg9MBn8K84aJNQs+9zb4Kdi6L7YFX7
         UE+SZ5/9MLwVQgRlC7Ms/PDMzAS1qHCbB9q5Oanrre2bLosixNWZ1jPZDV8TplyyZgKN
         JK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904744; x=1768509544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwgM57cBzuIgAiPMK5GxhnYsXF2RBvqFNs+qFbak5h0=;
        b=L8gNDgMOVpuMwQgK70YQsQp8tmeZbdlz9jSCz8xIKaEVEuv6hv06WKiTS2vGm7FFCU
         O3cC5t1fXMm2cFLXiI1nWSrmKAsBPR/g+fjuab0rhPSjqZneXrRy/esnbISULjqUChN9
         JaKMH3yKNMyMYj4wT+EKI8pONjsCGfJbf317F6hUT2Iop7IjlaKweHTxbKIiJAODeSJG
         R7XdBNFnkn2UfRYrZQLW36lMSvyZm/jOzl6H+cnKG+nFZGidDyEEKqroqvoXU6WbaLJt
         Hg4pkTKsurT8KlGqi8gLDZa+Mdd2jvg8q6qSAPlpGSGumhtpS4PEXEVa910sxeTVpJ5k
         UosQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyTKuOYW8jykIhXXhHt0I5tcOgB33n/mc6+ubeo2CwEpEb7SoIaGRpMD12NAJiELn1YVYAp8BToUqla4Nm@vger.kernel.org
X-Gm-Message-State: AOJu0YyqoByyd/B8Oh9nBRWeHpx2E/zJvhvGyskkCgH08tfNo6TNoCeo
	Vssr7r+w9yfjeSFNThnyc8VRDUGQuo72zaH5edeChTm3dUs8GymAf7+4ZTvqNiOqgMw=
X-Gm-Gg: AY/fxX5KudDykDIIfzwr5ug1R6EoN43/XwGnnRsDf2Ks7tJZwZ6MD/XfFOuCCl7QIZB
	zKCa/p9tjh4HfYwJpj6RnpTXweAsxeBonAoPE9qFz9PsbS2aRm7E5+1Wck/cTF17E/XgSZLk5kh
	nd4uxlZNLFBAiGuk3a0sUZ3clZKd2bPrgTm8KsR6lZ43HMeE6GEClkkwgJfWd3lpPh9lMl6lusk
	EL85ceaAaF+6EotdQXIiSY1PsRgsl9GQmmwgcoxiNnu7OBe9U/Z83DV2fRL3NTTSocUh4x5qRQm
	1WKHJQuA/9EfOgXUJYNTXENtkKGDjpG+NMuxS7xa5ypzj8WiPSs6x7e3YxTQQ/pn/tgw0lsRFpo
	y/KA3guVvaggQEQk+w6l+2Yk8LZOHb8zTY/4LpqYyn7MReXcnOgWsSZosj6He6jpxDoDAqS1XDV
	0LGBy41d46P/4jZnhrhphgC5dMnHyZfCz6w1fUTfwh40VYqX0UNokNrOSNUc/MYnFxMXsD2LVyo
	nY=
X-Google-Smtp-Source: AGHT+IEohul7eh/tCSXsk4Ov9Y1GsfVyXy+u/Ko/qY44ZfRMGDZ1/y3sswNjUUv0CUGvS9SQKMHaSg==
X-Received: by 2002:a05:620a:1a9d:b0:8b2:d6eb:8204 with SMTP id af79cd13be357-8c389416dbfmr982794985a.71.1767904744299;
        Thu, 08 Jan 2026 12:39:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:39:03 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 6/8] drivers/cxl/core/region: add private_region
Date: Thu,  8 Jan 2026 15:37:53 -0500
Message-ID: <20260108203755.1163107-7-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A private_region is just a RAM region which attempts to set the
target_node to N_PRIVATE before continuing to create a DAX device and
subsequently hotplugging memory onto the system.

A CXL device driver would create a private_region with the intent to
manage how the memory can be used more granuarly than typical SystemRAM.

This patch adds the infrastructure for a private memory region. Added
as a separate folder to keep private region types organized.

usage:
    echo regionN > decoderX.Y/create_private_region
    echo type    > regionN/private_type

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   4 +
 drivers/cxl/core/port.c                       |   4 +
 drivers/cxl/core/private_region/Makefile      |   9 ++
 .../cxl/core/private_region/private_region.c  | 119 ++++++++++++++++++
 .../cxl/core/private_region/private_region.h  |  10 ++
 drivers/cxl/core/region.c                     |  63 ++++++++--
 drivers/cxl/cxl.h                             |  20 +++
 8 files changed, 219 insertions(+), 11 deletions(-)
 create mode 100644 drivers/cxl/core/private_region/Makefile
 create mode 100644 drivers/cxl/core/private_region/private_region.c
 create mode 100644 drivers/cxl/core/private_region/private_region.h

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..2dd882a52609 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+obj-$(CONFIG_CXL_REGION) += private_region/
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..159f92e4bea1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -21,6 +21,7 @@ enum cxl_detach_mode {
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
+extern struct device_attribute dev_attr_create_private_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
@@ -30,6 +31,9 @@ extern const struct device_type cxl_region_type;
 int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
+int devm_cxl_add_dax_region(struct cxl_region *cxlr);
+struct cxl_region *to_cxl_region(struct device *dev);
+extern struct device_attribute dev_attr_private_type;
 
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..aedecb83e59b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -333,6 +333,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
+	SET_CXL_REGION_ATTR(create_private_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
@@ -362,6 +363,9 @@ static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *
 	if (a == CXL_REGION_ATTR(create_ram_region) && !can_create_ram(cxlrd))
 		return 0;
 
+	if (a == CXL_REGION_ATTR(create_private_region) && !can_create_ram(cxlrd))
+		return 0;
+
 	if (a == CXL_REGION_ATTR(delete_region) &&
 	    !(can_create_pmem(cxlrd) || can_create_ram(cxlrd)))
 		return 0;
diff --git a/drivers/cxl/core/private_region/Makefile b/drivers/cxl/core/private_region/Makefile
new file mode 100644
index 000000000000..d17498129ba6
--- /dev/null
+++ b/drivers/cxl/core/private_region/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# CXL Private Region type implementations
+#
+
+ccflags-y += -I$(srctree)/drivers/cxl
+
+# Core dispatch and sysfs
+obj-$(CONFIG_CXL_REGION) += private_region.o
diff --git a/drivers/cxl/core/private_region/private_region.c b/drivers/cxl/core/private_region/private_region.c
new file mode 100644
index 000000000000..ead48abb9fc7
--- /dev/null
+++ b/drivers/cxl/core/private_region/private_region.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CXL Private Region - dispatch and lifecycle management
+ *
+ * This file implements the main registration and unregistration dispatch
+ * for CXL private regions. It handles common initialization and delegates
+ * to type-specific implementations.
+ */
+
+#include <linux/device.h>
+#include <linux/cleanup.h>
+#include "../../cxl.h"
+#include "../core.h"
+#include "private_region.h"
+
+static const char *private_type_to_string(enum cxl_private_region_type type)
+{
+	switch (type) {
+	default:
+		return "";
+	}
+}
+
+static enum cxl_private_region_type string_to_private_type(const char *str)
+{
+	return CXL_PRIVATE_NONE;
+}
+
+static ssize_t private_type_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%s\n", private_type_to_string(cxlr->private_type));
+}
+
+static ssize_t private_type_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	enum cxl_private_region_type type;
+	ssize_t rc;
+
+	type = string_to_private_type(buf);
+	if (type == CXL_PRIVATE_NONE)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	/* Can only change type before region is committed */
+	if (p->state >= CXL_CONFIG_COMMIT)
+		return -EBUSY;
+
+	cxlr->private_type = type;
+
+	return len;
+}
+DEVICE_ATTR_RW(private_type);
+
+/*
+ * Register a private CXL region based on its private_type.
+ *
+ * This function is called during commit. It validates the private_type,
+ * initializes the private_ops, and dispatches to the appropriate
+ * registration function which handles memtype, callbacks, and node
+ * registration.
+ */
+int cxl_register_private_region(struct cxl_region *cxlr)
+{
+	int rc = 0;
+
+	if (!cxlr->params.res)
+		return -EINVAL;
+
+	if (cxlr->private_type == CXL_PRIVATE_NONE) {
+		dev_err(&cxlr->dev, "private_type must be set before commit\n");
+		return -EINVAL;
+	}
+
+	/* Initialize the private_ops with region info */
+	cxlr->private_ops.res_start = cxlr->params.res->start;
+	cxlr->private_ops.res_end = cxlr->params.res->end;
+	cxlr->private_ops.data = cxlr;
+
+	/* Call type-specific registration which sets memtype and callbacks */
+	switch (cxlr->private_type) {
+	default:
+		dev_dbg(&cxlr->dev, "unsupported private_type: %d\n",
+			cxlr->private_type);
+		rc = -EINVAL;
+		break;
+	}
+
+	if (!rc)
+		set_bit(CXL_REGION_F_PRIVATE_REGISTERED, &cxlr->flags);
+	return rc;
+}
+
+/*
+ * Unregister a private CXL region.
+ *
+ * This function is called during region reset or device release.
+ * It dispatches to the appropriate type-specific cleanup function.
+ */
+void cxl_unregister_private_region(struct cxl_region *cxlr)
+{
+	if (!test_and_clear_bit(CXL_REGION_F_PRIVATE_REGISTERED, &cxlr->flags))
+		return;
+
+	/* Dispatch to type-specific cleanup */
+	switch (cxlr->private_type) {
+	default:
+		break;
+	}
+}
diff --git a/drivers/cxl/core/private_region/private_region.h b/drivers/cxl/core/private_region/private_region.h
new file mode 100644
index 000000000000..9b34e51d8df4
--- /dev/null
+++ b/drivers/cxl/core/private_region/private_region.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CXL_PRIVATE_REGION_H__
+#define __CXL_PRIVATE_REGION_H__
+
+struct cxl_region;
+
+int cxl_register_private_region(struct cxl_region *cxlr);
+void cxl_unregister_private_region(struct cxl_region *cxlr);
+
+#endif /* __CXL_PRIVATE_REGION_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..c60eef96c0ca 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -15,6 +15,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "private_region/private_region.h"
 
 /**
  * DOC: cxl core region
@@ -38,8 +39,6 @@
  */
 static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
 
-static struct cxl_region *to_cxl_region(struct device *dev);
-
 #define __ACCESS_ATTR_RO(_level, _name) {				\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
 	.show	= _name##_access##_level##_show,			\
@@ -398,9 +397,6 @@ static int __commit(struct cxl_region *cxlr)
 		return rc;
 
 	rc = cxl_region_decode_commit(cxlr);
-	if (rc)
-		return rc;
-
 	p->state = CXL_CONFIG_COMMIT;
 
 	return 0;
@@ -615,12 +611,17 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	const char *desc;
 
-	if (cxlr->mode == CXL_PARTMODE_RAM)
-		desc = "ram";
-	else if (cxlr->mode == CXL_PARTMODE_PMEM)
+	switch (cxlr->mode) {
+	case CXL_PARTMODE_RAM:
+		desc = cxlr->private ? "private" : "ram";
+		break;
+	case CXL_PARTMODE_PMEM:
 		desc = "pmem";
-	else
+		break;
+	default:
 		desc = "";
+		break;
+	}
 
 	return sysfs_emit(buf, "%s\n", desc);
 }
@@ -772,6 +773,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_extended_linear_cache_size.attr,
+	&dev_attr_private_type.attr,
 	NULL,
 };
 
@@ -2400,6 +2402,9 @@ static void cxl_region_release(struct device *dev)
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	int id = atomic_read(&cxlrd->region_id);
 
+	/* Ensure private region is cleaned up if not already done */
+	cxl_unregister_private_region(cxlr);
+
 	/*
 	 * Try to reuse the recently idled id rather than the cached
 	 * next id to prevent the region id space from increasing
@@ -2429,7 +2434,7 @@ bool is_cxl_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
 
-static struct cxl_region *to_cxl_region(struct device *dev)
+struct cxl_region *to_cxl_region(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
 			  "not a cxl_region device\n"))
@@ -2638,6 +2643,13 @@ static ssize_t create_ram_region_show(struct device *dev,
 	return __create_region_show(to_cxl_root_decoder(dev), buf);
 }
 
+static ssize_t create_private_region_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 					  enum cxl_partition_mode mode, int id)
 {
@@ -2698,6 +2710,28 @@ static ssize_t create_ram_region_store(struct device *dev,
 }
 DEVICE_ATTR_RW(create_ram_region);
 
+static ssize_t create_private_region_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	struct cxl_region *cxlr;
+	int rc, id;
+
+	rc = sscanf(buf, "region%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	cxlr = __create_region(cxlrd, CXL_PARTMODE_RAM, id);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
+
+	cxlr->private = true;
+
+	return len;
+}
+DEVICE_ATTR_RW(create_private_region);
+
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -3431,7 +3465,7 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 	device_unregister(&cxlr_dax->dev);
 }
 
-static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
@@ -3974,6 +4008,13 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+
+
+		if (cxlr->private) {
+			rc = cxl_register_private_region(cxlr);
+			if (rc)
+				return rc;
+		}
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..b276956ff88d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -525,6 +525,20 @@ enum cxl_partition_mode {
  */
 #define CXL_REGION_F_LOCK 2
 
+/*
+ * Indicate that this region has been registered as a private region.
+ * Used to track lifecycle and prevent double-unregistration.
+ */
+#define CXL_REGION_F_PRIVATE_REGISTERED 3
+
+/**
+ * enum cxl_private_region_type - CXL private region types
+ * @CXL_PRIVATE_NONE: No private region type set
+ */
+enum cxl_private_region_type {
+	CXL_PRIVATE_NONE,
+};
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
@@ -534,10 +548,13 @@ enum cxl_partition_mode {
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
+ * @private: Region is private (not exposed to system memory)
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @private_type: CXL private region type for dispatch (set via sysfs)
+ * @private_ops: private node operations for callbacks (if mode is PRIVATE)
  */
 struct cxl_region {
 	struct device dev;
@@ -547,10 +564,13 @@ struct cxl_region {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
+	bool private;
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	enum cxl_private_region_type private_type;
+	struct private_node_ops private_ops;
 };
 
 struct cxl_nvdimm_bridge {
-- 
2.52.0


