Return-Path: <linux-fsdevel+bounces-75900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN3EK6LMe2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:09:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 457BEB4848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A647303816D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7135CBCA;
	Thu, 29 Jan 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eSPcV3wN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34D35C19F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720707; cv=none; b=mTvLQEVCvh30msKonyFRn01p4qAt767h0BJoqDToCwsufkIGhtyG8goUsFuW3mIX52oW9xLlhP2ZigtFxxQblDH4C9yVoofFBCeAQNfsBG88JsOpdXU3lB/cHC04IgEdnVFiI6cvWqeWq/bey+bjL5TK8wGobjQHPbWItcqLINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720707; c=relaxed/simple;
	bh=AXe5PQvLdK8hxmdbrwIXi4vOiSDdinSnNnxoyEcMa4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piw+bC4/NZp1sO3Cb/gJO4BExVT+4/nsAhvlMDRNk4dsZvU9wYl5RPcWZ3SDVMS0FVAHzNq6DIXxyfqMC2ueqEngVDOf37SJSNy1nyhgxpgMMJOjma0qgivxXUTV3gYsrDKiFR9fKsMMKymCyMEnwG/tXyVMIcZJKQ4KUs1gFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eSPcV3wN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70c6b2bcaso152818685a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720702; x=1770325502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrqa+fxuwjNl7Vx5HUEIUV4yNFrGE6eFCuap5wTqfpc=;
        b=eSPcV3wNRUoB9dA726Xw13JkAkS5NGKczZi+Y7OtS489wl9YSTW7wlIIR7cX7J2nkv
         u32fg+zEuw+dhFVc8pxyjkq5VE4WK9Wu8UhtPzrp9PTad7rspX8asj8dKIh3yPdKl9va
         V6KyMiCNyoEoXChYxmmFd579IELX8k943oQZwEVy6D1iEF2uIKqDZO4rOOD4mNq0uex/
         KoK/WkKQfGJ8a5MoSGpTlGMrpaLeizvkcty6Gu8CwK2e6bGkdn5F+2EOmQ796VdgH890
         WG2burwbMMvnGxxib32Z7Os9UYBTpXG5Zv+HxxxqwBeK4fyf8amzLeQcrCKAgPEpisWm
         W5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720702; x=1770325502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrqa+fxuwjNl7Vx5HUEIUV4yNFrGE6eFCuap5wTqfpc=;
        b=gJHnSss5OFCRM2DZewFRHoO5oSSJW07F9m8gMcHciqp2YDFhXz0b25GH0595A2ULM6
         VqR5hqzfShd/t8RgwZZtLisd8kRXxZaLg/OOGB5Ibj7bRoaGTU6XWzmR5rQQOiEAnqhM
         E6+nKd/XYBmccaDvkzPciNyjBck9WZ/0Xhc8IDsXXsbON8qm4O7n5SFPPZf0HhbJJnFJ
         Lc+la7unaWEGQ3pLjmN1DvimB8P1D+CXboN44QriDAMABbvm339J6o+ignty4timJgfN
         Rc2+wFhcmzYTqZJ9W7IEhvtIbIiMlCRrIEqfAHv7aK3tb5aX+ZNFnzSMCeq9lu8miB/g
         nrew==
X-Forwarded-Encrypted: i=1; AJvYcCWuw3fdyves1pDLAiom3hqWwqBkXW3w60CEOrnnk40YjUn6MesWvRVttHl5gfijeePb4KPnvMfe1EwGJa1M@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdu+4TdjJRu8kr9DA5AiOq9KhBszyGW6IKs8wTlWrwC1ORMyt
	ZJ4WwjosNR9xpICzyUMNRwrWba93oNLWGPuTKFgU7Tf8orhCiodYLCxgbnoGO5tvWoU=
X-Gm-Gg: AZuq6aJeOwjXTQkjVfJdlqnkmkCFU49N0xcAohuSY//8e1cuIYdKYpFp8Af3OjkIhR9
	d7MViZg7Xuhmnlhzum2JiHPcAzV8Eh/JKC9iudZudH0zunWZEWSzpKuX7/M7tHEEHCeyM+Co8aG
	xWEwGfwJfodKpQHFJTjP/9JclKtxMTrnoypj+iPTgDFUlbK5lwD4+qQ+jbyn1/1WkLSNbkVPqPb
	27iwfdDvehmE0ddT6ETY4I//wb2Rdqb1PjQCHN8NVNpF6yLZVd/SRxqXictY60f9r0B5/paYqN2
	0we8EGT0FlwKd9mLWvCSiit5M62c1AlsfutHkg/x71Ooq+GbKsFRCVarQ5Kk8m158GyKIPSlfTe
	K3OYV4MO9bxA/2N2xZzQrrChky9337emsouDxkmiMnnbmYfyg8npYGxgMh9LfSdbQmJo/YKOU/H
	znJXgp0sPv5T0DBYhmECi8NvMWAdre8IBcgmDhQhD/xRvaTSWai4YNOZuY21cxjiKZPH4gtctJn
	rI=
X-Received: by 2002:a05:620a:4591:b0:8c7:1af9:b868 with SMTP id af79cd13be357-8c9eb28d35cmr167526085a.36.1769720701558;
        Thu, 29 Jan 2026 13:05:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:05:01 -0800 (PST)
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
Subject: [PATCH 6/9] cxl/core/region: move dax region device logic into dax_region.c
Date: Thu, 29 Jan 2026 16:04:39 -0500
Message-ID: <20260129210442.3951412-7-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	TAGGED_FROM(0.00)[bounces-75900-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email,gourry.net:dkim,gourry.net:mid]
X-Rspamd-Queue-Id: 457BEB4848
X-Rspamd-Action: no action

Move the CXL DAX region device infrastructure from region.c into a
new dax_region.c file.

No functional changes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |   1 +
 drivers/cxl/core/dax_region.c | 113 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c     | 102 ------------------------------
 4 files changed, 115 insertions(+), 102 deletions(-)
 create mode 100644 drivers/cxl/core/dax_region.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 23269c81fd44..36f284d7c500 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_REGION) += dax_region.o
 cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 26991de12d76..217dd708a2a6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -43,6 +43,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 #else
diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
new file mode 100644
index 000000000000..0602db5f7248
--- /dev/null
+++ b/drivers/cxl/core/dax_region.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2022 Intel Corporation. All rights reserved.
+ * Copyright(c) 2026 Meta Technologies Inc. All rights reserved.
+ */
+#include <linux/memory_hotplug.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "core.h"
+
+static void cxl_dax_region_release(struct device *dev)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+
+	kfree(cxlr_dax);
+}
+
+static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_dax_region_type = {
+	.name = "cxl_dax_region",
+	.release = cxl_dax_region_release,
+	.groups = cxl_dax_region_attribute_groups,
+};
+
+static bool is_cxl_dax_region(struct device *dev)
+{
+	return dev->type == &cxl_dax_region_type;
+}
+
+struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
+			  "not a cxl_dax_region device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_dax_region, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
+
+static struct lock_class_key cxl_dax_region_key;
+
+static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return ERR_PTR(-ENXIO);
+
+	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
+	if (!cxlr_dax)
+		return ERR_PTR(-ENOMEM);
+
+	cxlr_dax->hpa_range.start = p->res->start;
+	cxlr_dax->hpa_range.end = p->res->end;
+
+	dev = &cxlr_dax->dev;
+	cxlr_dax->cxlr = cxlr;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_dax_region_type;
+
+	return cxlr_dax;
+}
+
+static void cxlr_dax_unregister(void *_cxlr_dax)
+{
+	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
+
+	device_unregister(&cxlr_dax->dev);
+}
+
+int devm_cxl_add_dax_region(struct cxl_region *cxlr,
+			    enum dax_driver_type dax_driver)
+{
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+	int rc;
+
+	cxlr_dax = cxl_dax_region_alloc(cxlr);
+	if (IS_ERR(cxlr_dax))
+		return PTR_ERR(cxlr_dax);
+
+	cxlr_dax->online_type = mhp_get_default_online_type();
+	cxlr_dax->dax_driver = dax_driver;
+	dev = &cxlr_dax->dev;
+	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
+		dev_name(dev));
+
+	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
+					cxlr_dax);
+err:
+	put_device(dev);
+	return rc;
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fc56f8f03805..61ec939c1462 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3196,108 +3196,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	return -ENXIO;
 }
 
-static void cxl_dax_region_release(struct device *dev)
-{
-	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
-
-	kfree(cxlr_dax);
-}
-
-static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
-	&cxl_base_attribute_group,
-	NULL,
-};
-
-const struct device_type cxl_dax_region_type = {
-	.name = "cxl_dax_region",
-	.release = cxl_dax_region_release,
-	.groups = cxl_dax_region_attribute_groups,
-};
-
-static bool is_cxl_dax_region(struct device *dev)
-{
-	return dev->type == &cxl_dax_region_type;
-}
-
-struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
-{
-	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
-			  "not a cxl_dax_region device\n"))
-		return NULL;
-	return container_of(dev, struct cxl_dax_region, dev);
-}
-EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
-
-static struct lock_class_key cxl_dax_region_key;
-
-static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_dax_region *cxlr_dax;
-	struct device *dev;
-
-	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->state != CXL_CONFIG_COMMIT)
-		return ERR_PTR(-ENXIO);
-
-	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
-	if (!cxlr_dax)
-		return ERR_PTR(-ENOMEM);
-
-	cxlr_dax->hpa_range.start = p->res->start;
-	cxlr_dax->hpa_range.end = p->res->end;
-
-	dev = &cxlr_dax->dev;
-	cxlr_dax->cxlr = cxlr;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
-	device_set_pm_not_required(dev);
-	dev->parent = &cxlr->dev;
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_dax_region_type;
-
-	return cxlr_dax;
-}
-
-static void cxlr_dax_unregister(void *_cxlr_dax)
-{
-	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
-
-	device_unregister(&cxlr_dax->dev);
-}
-
-static int devm_cxl_add_dax_region(struct cxl_region *cxlr,
-				   enum dax_driver_type dax_driver)
-{
-	struct cxl_dax_region *cxlr_dax;
-	struct device *dev;
-	int rc;
-
-	cxlr_dax = cxl_dax_region_alloc(cxlr);
-	if (IS_ERR(cxlr_dax))
-		return PTR_ERR(cxlr_dax);
-
-	cxlr_dax->online_type = mhp_get_default_online_type();
-	cxlr_dax->dax_driver = dax_driver;
-	dev = &cxlr_dax->dev;
-	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
-	if (rc)
-		goto err;
-
-	rc = device_add(dev);
-	if (rc)
-		goto err;
-
-	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
-		dev_name(dev));
-
-	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
-					cxlr_dax);
-err:
-	put_device(dev);
-	return rc;
-}
-
 static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-- 
2.52.0


