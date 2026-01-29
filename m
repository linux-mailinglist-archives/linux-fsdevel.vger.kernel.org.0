Return-Path: <linux-fsdevel+bounces-75898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNofHkzMe2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:08:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF0B4819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CBC303744B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2247435CBCB;
	Thu, 29 Jan 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="g9vz+XDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE135C1B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720699; cv=none; b=nwDOmHJePTWuYL46Ey9gyOe90pRk/TDTixgk4pWF0vfya6XTqWuN2Ym8rF+I4rfiS3QKkUaopAuOqhJUpgXHYCWgintlbgbWP58J9Zd2VX2s05kRQhvZMPwpUDCsOxMx5OACErYYHck7CD80+XR1Os9DmiuSyu1a3KR1dOOH2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720699; c=relaxed/simple;
	bh=JnLujJWDw0BcQgi5wBFcpc/5Wt50jW8kOx4fggwynCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUXuTQJ/jfQ/quOF/od4uh5wOBgwxU5mX3uLwZ2pk+2+qxdNPAtkwYEa5kUxRTXgaTD6CVKEYzeC+t7C92QHWWfAaHrx6EgQ6Uvwul86GWsF/+HTKr8ZEA4JiCsx1YAeAr1RQANQW0AOx40QsjfIuyvlzzvKTSgJAje6+AxoRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=g9vz+XDJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6f21c2d81so147089485a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720695; x=1770325495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CRGF+/n1V2R5uGEqix6U/LES5Uojp7M/qLfKImGPj8=;
        b=g9vz+XDJot6ZFC3/rlZpZoVtoDv7/BHlydoBPk4WOrXSZ7rbCPGdE7bjR84cc5TfFw
         FGRBeB0jfBp/4CIWM27d+Nmzw2KAaIf6B8nD5ab9YNjC74gxENyJmEbcTdP7P4sD96uM
         Jm0+M5Y6m3llk1gJTKX/WLXQN5sQwdruuSTymv/qD5rE4XtXgrM6B9C2Z9gtGW2fNcFI
         DLPPqOL2TAQdWrldEPX4DySh+VZLjqjrjl5uKywZHRdBlumuq7DnM7E5CuZRZXZZZSpn
         QjOlaM+pNa2o4ZhUa6IVZEahwdfwbu4HPYm5K/AvWHjY4/fWiY3JUXO+6Y+VLAkqVRBS
         44oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720695; x=1770325495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CRGF+/n1V2R5uGEqix6U/LES5Uojp7M/qLfKImGPj8=;
        b=QzJ4ZJSwyWWIYOpY3eMY4W1qXfAWPMo7FY2wJc3S9PFdE3NEnOc5O+aRA3ySj0bN6j
         NBak8EfD6dbsfgNSpYr9ObFj4COPZtpSxblmnS7fjApZM1KUOsyRJIQLKntRLU249DQ7
         Qeaqn5n3sUTR8VHErpsEtIW4ls2u5/VZGUH22ptf8JRd3bDPfJVnpR64l0OjGOp0TdmR
         0lVXDoeJmrTt1/XqnIdubLpJ+Hmx8yEg5hcWhqrLiK9S2b5vq/9B2qP8jLszS4pk47pW
         GF+W4VVQIIfboZnwYF89XL8nZPFbqW048xVE6mDWMAr2XSZDvXJyudgdmGpz0rTOoZOj
         Kppw==
X-Forwarded-Encrypted: i=1; AJvYcCXeTLrMxsmW7fjythRm5jZhwHQ2J72SlOxvmNaPEw6mi6gTHOlEDSdvXFXIN48bKjPLseNtEYIyiFOdzq+N@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8di5S7sobD9d3hKtEBc7HOJyVCgX4gY1S9oYLvpKfuxJ5Hks
	17/wIak6b8RWUizatZTaiQzi82K0IJixJggAwnPic39GQ1ZZCq9VecaSXqrdmKeF1lryiHi9tYQ
	xsZrHUag=
X-Gm-Gg: AZuq6aIR4aIMYdDgcC8FKyryx94r9ClIF5qdPJ97At27YHrn6amGJWZpl7Y6d3TB8W0
	SDkl0laUX7NtIdmbkkK9WmFWA4/gdxLnzUwCceYLai3HQWdT2cy8Lrr3KJU1ON9O+D2Vm++TD9v
	C5qOowXwylkHwzU/vI9z8Y9mb5RS/AK50TPpYGIiG22nnjxDE4D2R1+Yn7PrkR9bzolqTb8RcDQ
	X6xf2vEj/jmdPxvlxBR5s5ytRJ1KP+n6raObICBDbV9R94sEgsDu2i3lV/QSD+lmgfcI414JGp4
	6ecHglY3BraGHIDjGQ2KNPnBNxK79XdewDHeKlVZKEdBXktDYHO1WGLHfF8LqTxYhn3GpFRfPKD
	mR/9KTlXcGWr/nsJddLeM3hZZiKWsy6T8UeCmSC54O4TfLII0eLe1aD3GEwKQSCC5CVTuwpnDpE
	+KODDPVjHiYcL2f2zeDFmEgQ/P+OPo8eWbKt/XfTXNpVe2sGh0bC+EkWl+B9fpZ3KUMjsHKAEwX
	OM=
X-Received: by 2002:a05:620a:17aa:b0:8c6:b2ce:f46 with SMTP id af79cd13be357-8c9eb1fc03cmr152696085a.14.1769720695300;
        Thu, 29 Jan 2026 13:04:55 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:54 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com
Subject: [PATCH 3/9] dax: plumb online_type from dax_kmem creators to hotplug
Date: Thu, 29 Jan 2026 16:04:36 -0500
Message-ID: <20260129210442.3951412-4-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	TAGGED_FROM(0.00)[bounces-75898-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email,gourry.net:dkim,gourry.net:mid]
X-Rspamd-Queue-Id: D8BF0B4819
X-Rspamd-Action: no action

There is no way for drivers leveraging dax_kmem to plumb through a
preferred auto-online policy - the system default policy is forced.

Add online_type field to DAX device creation path to allow drivers
to specify an auto-online policy when using the kmem driver.

Current callers initialize online_type to mhp_get_default_online_type()
which resolves to the system default (memhp_default_online_type).

No functional change to existing drivers.

Cc:David Hildenbrand <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c |  2 ++
 drivers/cxl/cxl.h         |  1 +
 drivers/dax/bus.c         |  3 +++
 drivers/dax/bus.h         |  1 +
 drivers/dax/cxl.c         |  1 +
 drivers/dax/dax-private.h |  2 ++
 drivers/dax/hmem/hmem.c   |  2 ++
 drivers/dax/kmem.c        | 13 +++++++++++--
 drivers/dax/pmem.c        |  2 ++
 9 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5bd1213737fa..eef5d5fe3f95 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/memregion.h>
+#include <linux/memory_hotplug.h>
 #include <linux/genalloc.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -3459,6 +3460,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	if (IS_ERR(cxlr_dax))
 		return PTR_ERR(cxlr_dax);
 
+	cxlr_dax->online_type = mhp_get_default_online_type();
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..07d57d13f4c7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -591,6 +591,7 @@ struct cxl_dax_region {
 	struct device dev;
 	struct cxl_region *cxlr;
 	struct range hpa_range;
+	int online_type; /* MMOP_ value for kmem driver */
 };
 
 /**
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..121a6dd0afe7 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2017-2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
+#include <linux/memory_hotplug.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -395,6 +396,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
 			.size = 0,
 			.id = -1,
 			.memmap_on_memory = false,
+			.online_type = mhp_get_default_online_type(),
 		};
 		struct dev_dax *dev_dax = __devm_create_dev_dax(&data);
 
@@ -1494,6 +1496,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->online_type = data->online_type;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..4ac92a4edfe7 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -24,6 +24,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	int online_type;	/* MMOP_ value for kmem driver */
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..856a0cd24f3b 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.online_type = cxlr_dax->online_type,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index c6ae27c982f4..9559718cc988 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -77,6 +77,7 @@ struct dev_dax_range {
  * @dev: device core
  * @pgmap: pgmap for memmap setup / lifetime (driver owned)
  * @memmap_on_memory: allow kmem to put the memmap in the memory
+ * @online_type: MMOP_* online type for memory hotplug
  * @nr_range: size of @ranges
  * @ranges: range tuples of memory used
  */
@@ -91,6 +92,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	int online_type;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c18451a37e4f..119914b08fd9 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/platform_device.h>
+#include <linux/memory_hotplug.h>
 #include <linux/memregion.h>
 #include <linux/module.h>
 #include <linux/dax.h>
@@ -36,6 +37,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		.id = -1,
 		.size = region_idle ? 0 : range_len(&mri->range),
 		.memmap_on_memory = false,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..550dc605229e 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -16,6 +16,11 @@
 #include "dax-private.h"
 #include "bus.h"
 
+/* Internal function exported only to kmem module */
+extern int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				       const char *resource_name,
+				       mhp_t mhp_flags, int online_type);
+
 /*
  * Default abstract distance assigned to the NUMA node onlined
  * by DAX/kmem if the low level platform driver didn't initialize
@@ -72,6 +77,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	struct dax_kmem_data *data;
 	struct memory_dev_type *mtype;
 	int i, rc, mapped = 0;
+	int online_type;
 	mhp_t mhp_flags;
 	int numa_node;
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
@@ -134,6 +140,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		goto err_reg_mgid;
 	data->mgid = rc;
 
+	online_type = dev_dax->online_type;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
@@ -174,8 +182,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * Ensure that future kexec'd kernels will not treat
 		 * this as RAM automatically.
 		 */
-		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags);
+		rc = __add_memory_driver_managed(data->mgid, range.start,
+				range_len(&range), kmem_name, mhp_flags,
+				online_type);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..a5925146b09f 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
+#include <linux/memory_hotplug.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include "../nvdimm/pfn.h"
@@ -63,6 +64,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.pgmap = &pgmap,
 		.size = range_len(&range),
 		.memmap_on_memory = false,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return devm_create_dev_dax(&data);
-- 
2.52.0


