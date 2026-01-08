Return-Path: <linux-fsdevel+bounces-72939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC86D06271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6FA83038188
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B233291A;
	Thu,  8 Jan 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sv4IqeaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94005331222
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904757; cv=none; b=EvWqH32jizjvEK0clvCtpFPCC4/hYKogRAixW5s26IXqwfTbmHc57/XJuO3da+HNsExRVx0k5dohW20lN63PnF8M98gudQLkpC2OZvhKdauPQ6/+s6dNuKZs2k/zvrQAniZbN1dCnBuMNhqP4Dvha9uzUltcwO9zkEVJb1O1vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904757; c=relaxed/simple;
	bh=H1aiie8D4svpNDzSmOI68CzAj4t2rzf4KLw2L055t2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqRjXE8W+P2+r38b6aJ0iY/4XfPebnouXI9K7ZWZxVXIKVCMsjkBXwWVOt2O185Ao3gcYqLsyQQV1+oMl2dT5D0GAA2r4SRuk/5uI7DTVkrUFOVxZyNeUtEXuvKJIyk6UVsMvNe/xsW4VLwT7pSjevRNvaxVUwP94M5scPJ7sJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sv4IqeaF; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee05b2b1beso34407291cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904754; x=1768509554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbAJPMgZOoJSjKjyh3GK6UyuoBx+8LBWNLKG00C3DPA=;
        b=sv4IqeaF1/x3PeHIs+GscpVxUPxX8J3UWJ7TgRxTJec0UV/1R0tuHdwgy/2tmS1kVn
         CroY5GoHsj8ja2LtiCn8lb56rvpzFCowKGEPTasLH3c6hbFA/K4wQzBrraT0scodrf6B
         TEMy4f9+7GPxIdFkVU3aw2tC5LBU2sxPDl7uq1HNnByEmr9nZQcFYyaOo5plfhfmE4pg
         zEgoT4RmyzKJBQ/HeB1poljUX+caNgVaCLbZL6dIds+XD/74CVbL4sGKuaKBIofv2vaQ
         ferxu6wmqIzgxcluE0XEFkfywnei2mL9AoL+dzS5Cs3uFow5vLs+vgm4goSZbcauAv94
         nijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904754; x=1768509554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hbAJPMgZOoJSjKjyh3GK6UyuoBx+8LBWNLKG00C3DPA=;
        b=vaPFw+x8dCWux6CHyT+Et6+2KJdLhIJWQKMkC1W7WWkvEGYg3kTBP4f26fWkmeft8k
         lVOGOh+OgTk8BHZtAmYaUW2l//IdaGIY05J/OgGA7KSMlNW331l1nj02gUfC/ZmicYfS
         X0+R/keNA3gPWrSmjdobSqqX4TOvGlVNnp2lQVfA/61kESEdclJk70mBztaaS3WOBBZx
         bm7cQL1qlaSnCz5DaY1ABL3Mk8DKSJWJ01pEBNI35PcTfK434q9wFP9MnI+/ZnafwXIk
         f/XL8CNnwJigBKGGCWoqYGhcJ/o1E3GPrrxz4gf+Ds+jC8O1YfGiNWTR2ySTp//JzeBN
         sPDg==
X-Forwarded-Encrypted: i=1; AJvYcCXmtnL6RWG7VSamoJxQpfYnHY2NYjIjEUL9Fesq/11rU3O7CL3NnwF8L988n+SK9vBrWO6K/s+C3Fafnw+6@vger.kernel.org
X-Gm-Message-State: AOJu0YwkF5lZxD/1jzpI7VB0tqwNJO8j7p4g93J+N6KLD4Gm5zl1pFHm
	KjoOwAbj0i4+tN7j2CG9B0zaz28Y0m6Muvi5CS7yfnkENkPsGfhpRbHFK3LU+Yv9g8w=
X-Gm-Gg: AY/fxX7TBn41ea/c/dx+otnkMj8JwKc+Yhhc9/J0HcqxJUmV26w9zxZqEFE0/7x/P2B
	DupHR5smz4MZgqR8rAo+ty9uhE91FGo62OPgYoQ7cBls0JXf7Ft0vUN026vZsEWDLHcUndmSGaD
	/aB/y4c2OhRJJH6YhHozFU3uCAiGH9bDlwyd5iVBm+QR/jWW7s9nxtQbxObTI35NQeCXR6RhOuv
	ibxKksTeGho7vxsEQ7+sE6T04RC0CmQG9Wd4ocjcNxUQF23EN2paMVJFOpJYGxeu0+K3VJAwLQF
	KvukLdMCjBxeLNQkJnLGz9zRjVnU07Y7RENkcf1BGD5a+HNj5IeAp39Zv6PPIRaPHuMR2XCv0L9
	gVyYRQxed2Qgax0p0R8Nz49kQBbkf7tSngBEoHE8cdh2nSoB/lqgNGGXTEeN/rpCFAJF7rMbrs6
	P83w8xukBs2cF0vCUucI7EUk5yLLbo7Kp9NXxn32ZZStws227T8GBca8UZY88gOez4bjjo1D7nH
	Y8=
X-Google-Smtp-Source: AGHT+IETJUC85zNJ1zZIUFzv9QwdWQGaYClNK785q5YOPJAvYLx3d5ypHJ/HCEokjoFg0FJKBiPjgg==
X-Received: by 2002:a05:622a:124f:b0:4ee:24b8:2275 with SMTP id d75a77b69052e-4ffb4913960mr88384181cf.1.1767904754417;
        Thu, 08 Jan 2026 12:39:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:39:13 -0800 (PST)
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
Subject: [RFC PATCH v3 8/8] drivers/cxl: add zswap private_region type
Date: Thu,  8 Jan 2026 15:37:55 -0500
Message-ID: <20260108203755.1163107-9-gourry@gourry.net>
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

Add a sample type of a zswap region, which registers itself as a valid
target node with mm/zswap.  Zswap will callback into the driver on new
page allocation and free.

On cxl_zswap_page_allocated(), we would check whether the worst case vs
current compression ratio is safe to allow new writes.

On cxl_zswap_page_freed(), zero the page to adjust the ratio down.

A device driver registering a Zswap private region would need to provide
an indicator to this component whether to allow new allocations - this
would probably be done via an interrupt setting a bit which says the
compression ratio has reached some conservative threshold.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/private_region/Makefile      |   3 +
 .../cxl/core/private_region/private_region.c  |  10 ++
 .../cxl/core/private_region/private_region.h  |   4 +
 drivers/cxl/core/private_region/zswap.c       | 127 ++++++++++++++++++
 drivers/cxl/cxl.h                             |   2 +
 5 files changed, 146 insertions(+)
 create mode 100644 drivers/cxl/core/private_region/zswap.c

diff --git a/drivers/cxl/core/private_region/Makefile b/drivers/cxl/core/private_region/Makefile
index d17498129ba6..ba495cd3f89f 100644
--- a/drivers/cxl/core/private_region/Makefile
+++ b/drivers/cxl/core/private_region/Makefile
@@ -7,3 +7,6 @@ ccflags-y += -I$(srctree)/drivers/cxl
 
 # Core dispatch and sysfs
 obj-$(CONFIG_CXL_REGION) += private_region.o
+
+# Type-specific implementations
+obj-$(CONFIG_CXL_REGION) += zswap.o
diff --git a/drivers/cxl/core/private_region/private_region.c b/drivers/cxl/core/private_region/private_region.c
index ead48abb9fc7..da5fb3d264e1 100644
--- a/drivers/cxl/core/private_region/private_region.c
+++ b/drivers/cxl/core/private_region/private_region.c
@@ -16,6 +16,8 @@
 static const char *private_type_to_string(enum cxl_private_region_type type)
 {
 	switch (type) {
+	case CXL_PRIVATE_ZSWAP:
+		return "zswap";
 	default:
 		return "";
 	}
@@ -23,6 +25,8 @@ static const char *private_type_to_string(enum cxl_private_region_type type)
 
 static enum cxl_private_region_type string_to_private_type(const char *str)
 {
+	if (sysfs_streq(str, "zswap"))
+		return CXL_PRIVATE_ZSWAP;
 	return CXL_PRIVATE_NONE;
 }
 
@@ -88,6 +92,9 @@ int cxl_register_private_region(struct cxl_region *cxlr)
 
 	/* Call type-specific registration which sets memtype and callbacks */
 	switch (cxlr->private_type) {
+	case CXL_PRIVATE_ZSWAP:
+		rc = cxl_register_zswap_region(cxlr);
+		break;
 	default:
 		dev_dbg(&cxlr->dev, "unsupported private_type: %d\n",
 			cxlr->private_type);
@@ -113,6 +120,9 @@ void cxl_unregister_private_region(struct cxl_region *cxlr)
 
 	/* Dispatch to type-specific cleanup */
 	switch (cxlr->private_type) {
+	case CXL_PRIVATE_ZSWAP:
+		cxl_unregister_zswap_region(cxlr);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/cxl/core/private_region/private_region.h b/drivers/cxl/core/private_region/private_region.h
index 9b34e51d8df4..84d43238dbe1 100644
--- a/drivers/cxl/core/private_region/private_region.h
+++ b/drivers/cxl/core/private_region/private_region.h
@@ -7,4 +7,8 @@ struct cxl_region;
 int cxl_register_private_region(struct cxl_region *cxlr);
 void cxl_unregister_private_region(struct cxl_region *cxlr);
 
+/* Type-specific registration functions - called from region.c dispatch */
+int cxl_register_zswap_region(struct cxl_region *cxlr);
+void cxl_unregister_zswap_region(struct cxl_region *cxlr);
+
 #endif /* __CXL_PRIVATE_REGION_H__ */
diff --git a/drivers/cxl/core/private_region/zswap.c b/drivers/cxl/core/private_region/zswap.c
new file mode 100644
index 000000000000..c213abe2fad7
--- /dev/null
+++ b/drivers/cxl/core/private_region/zswap.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CXL Private Region - zswap type implementation
+ *
+ * This file implements the zswap private region type for CXL devices.
+ * It handles registration/unregistration of CXL regions as zswap
+ * compressed memory targets.
+ */
+
+#include <linux/device.h>
+#include <linux/highmem.h>
+#include <linux/node.h>
+#include <linux/zswap.h>
+#include <linux/memory_hotplug.h>
+#include "../../cxl.h"
+#include "../core.h"
+#include "private_region.h"
+
+/*
+ * CXL zswap region page_allocated callback
+ *
+ * This callback is invoked by zswap when a page is allocated from a private
+ * node to validate that the page is safe to use. For a real compressed memory
+ * device, this would check the device's compression ratio and return an error
+ * if the page cannot safely store data.
+ *
+ * Currently this is a placeholder that always succeeds. A real implementation
+ * would query the device hardware to determine if sufficient compression
+ * headroom exists.
+ */
+static int cxl_zswap_page_allocated(struct page *page, void *data)
+{
+	struct cxl_region *cxlr = data;
+
+	/*
+	 * TODO: Query the CXL device to check if this page allocation is safe.
+	 *
+	 * A real compressed memory device would track its compression ratio
+	 * and report whether it has headroom to accept new data. If the
+	 * compression ratio is too low (device is near capacity), this should
+	 * return -ENOSPC to tell zswap to try another node.
+	 *
+	 * For now, always succeed since we're testing with regular memory.
+	 */
+	dev_dbg(&cxlr->dev, "page_allocated callback for nid %d\n",
+		page_to_nid(page));
+
+	return 0;
+}
+
+/*
+ * CXL zswap region page_freed callback
+ *
+ * This callback is invoked when a page from a private node is being freed.
+ * We zero the page before returning it to the allocator so that the compressed
+ * memory device can reclaim capacity - zeroed pages achieve excellent
+ * compression ratios.
+ */
+static void cxl_zswap_page_freed(struct page *page, void *data)
+{
+	struct cxl_region *cxlr = data;
+
+	/*
+	 * Zero the page to improve the device's compression ratio.
+	 * Zeroed pages compress extremely well, reclaiming device capacity.
+	 */
+	clear_highpage(page);
+
+	dev_dbg(&cxlr->dev, "page_freed callback for nid %d\n",
+		page_to_nid(page));
+}
+
+/*
+ * Unregister a zswap region from the zswap subsystem.
+ *
+ * This function removes the node from zswap direct nodes and unregisters
+ * the private node operations.
+ */
+void cxl_unregister_zswap_region(struct cxl_region *cxlr)
+{
+	int nid;
+
+	if (!cxlr->private ||
+	    cxlr->private_ops.memtype != NODE_MEM_ZSWAP)
+		return;
+
+	if (!cxlr->params.res)
+		return;
+
+	nid = phys_to_target_node(cxlr->params.res->start);
+
+	zswap_remove_direct_node(nid);
+	node_unregister_private(nid, &cxlr->private_ops);
+
+	dev_dbg(&cxlr->dev, "unregistered zswap region for nid %d\n", nid);
+}
+
+/*
+ * Register a zswap region with the zswap subsystem.
+ *
+ * This function sets up the memtype, page_allocated callback, and
+ * registers the node with zswap as a direct compression target.
+ * The caller is responsible for adding the dax region after this succeeds.
+ */
+int cxl_register_zswap_region(struct cxl_region *cxlr)
+{
+	int nid, rc;
+
+	if (!cxlr->private || !cxlr->params.res)
+		return -EINVAL;
+
+	nid = phys_to_target_node(cxlr->params.res->start);
+
+	/* Register with node subsystem as zswap memory */
+	cxlr->private_ops.memtype = NODE_MEM_ZSWAP;
+	cxlr->private_ops.page_allocated = cxl_zswap_page_allocated;
+	cxlr->private_ops.page_freed = cxl_zswap_page_freed;
+	rc = node_register_private(nid, &cxlr->private_ops);
+	if (rc)
+		return rc;
+
+	/* Register this node with zswap as a direct compression target */
+	zswap_add_direct_node(nid);
+
+	dev_dbg(&cxlr->dev, "registered zswap region for nid %d\n", nid);
+	return 0;
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b276956ff88d..89d8ae4e796c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -534,9 +534,11 @@ enum cxl_partition_mode {
 /**
  * enum cxl_private_region_type - CXL private region types
  * @CXL_PRIVATE_NONE: No private region type set
+ * @CXL_PRIVATE_ZSWAP: Region used for zswap compressed memory
  */
 enum cxl_private_region_type {
 	CXL_PRIVATE_NONE,
+	CXL_PRIVATE_ZSWAP,
 };
 
 /**
-- 
2.52.0


