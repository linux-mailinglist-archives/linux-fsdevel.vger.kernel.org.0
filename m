Return-Path: <linux-fsdevel+bounces-75901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJg6F6rMe2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:10:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F6BB4850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2903094C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1335CBD7;
	Thu, 29 Jan 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XGOgVsGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06935BDC7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720707; cv=none; b=BEl9x/i5jFEDcRbHykQd26ZoULX/Wu/wjsTVjLxn02XBQ8oHXnM1HGlgFNS4t+qQcWM4vMG5jJAGm899OWYJ/i4uBw6QrFTKSfbx1c4Yxn8eE1E7seEHR3zi14awHXco7SFQNjj62EXS3AMGHvokPjJcFSgIr0mDYhGu1+yiBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720707; c=relaxed/simple;
	bh=QNsY4J+Tc0rw1kzVfyOgqVGbBo/47Sd9HfuK48nkDOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr8hCn+ya76LiMiy45x1g3OPzdqJz0Pmo9S0WkvtP1on0GMpoxxXTik6AfskqG3UiGbw1hwIaHxLSx9nvPe2L5kUxMkAJ3h5TbuDj0MPaNvc7cJj/3U9fGsss7NHcyg56gtk8XuxvvfNZO0hsKxAda2nrTrcm5vfrc3IRXygnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XGOgVsGE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c532d8be8cso144860485a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720697; x=1770325497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alwv4SGOFS63mWmVzbrgd9Xf0He8PRBJ686/YkdtOI4=;
        b=XGOgVsGE7lEH2jvTzMPTXM6VTcQCg0Fg1rN6+diAOZtBaxaAOARbZhqQQ6OqVTORFM
         u6tk6WVBLAPnaGrIC9yLob0RiedBLUU/acXRCKjpZbNlp9IiDInS0k6WJ5jwq3bfM5H8
         TBXMHljBw+bbfmoSAsHHMnV4gZLdAIsnNuIjYJuOI0MtCeY4IOn2S+4GwB0GP0C4HJfq
         8ee0hrWR2NifSyj7NiNZzWgko8u+1EyXK/J108U/LfXkMEqMm4cRroaB6ga2BvaXLQcT
         scFuuwo/PKMwy/snL/fvWEC7rqm992HmD28II3GxdtfS8V3LwfitDnXnR9W9GoVeKV2k
         XkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720697; x=1770325497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alwv4SGOFS63mWmVzbrgd9Xf0He8PRBJ686/YkdtOI4=;
        b=KqHIiJKC7fmANvNgLzTl1UW8PZNABPUl54lJbsRzBIM7KqvGlk9Ba1dZAqtPFsblBQ
         W4eXpf0AJKYpHc5JXHGLzdZxIfgIHeiCwH2Q0zQR1JtM9fQAJmxwEZjo4HINHTPOJkib
         koP2kmMtjMbVlefZmrx8YvUIYm0PyQO/1hk4NxtHSfLg5gixky7Wjp2NT0uMLSTNgcFd
         bceSz4dF4guuASgKR0VfnlTWCrM0awjKnfBWdBUL7/r4XeVr8IJmb+d4hmkecXueEyV3
         jkrRfWzWXdyeN4Qw9OeIne0xuFWK+c/tftfknYtAPWHTBojVtXR/A1QULMLD84i22IhX
         IL8w==
X-Forwarded-Encrypted: i=1; AJvYcCU76U/XRv5WYFSRIPepRqH5KAaYnVtG2eqJ56HiG17Xwo3ZIOu1NxO+04MDuOGfsWF5hGMwpPfdk3nBqzxD@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCz1ScPcvgfmR0f9ljhs6ijaVRoq1tMwY8kjp/UOf3vzQ0gDp
	vXiKZz+DKcVI/JI/gDMdNIj0B2uZFaXYxKyBvuggaKQNGKZBL470O8wxg1a+GWezKd0=
X-Gm-Gg: AZuq6aI4/9tCD/5lnPJKCz1Os0E/gEY97gNQCbReGlgVt9atrRC9GzQblXeVt/QsdX0
	lzBD0XWW4376IVXujSF3LuSVfvksEyQFFoOARSn1D8WSJd7XzQiruSPBET0oco5RdupnmpPTP2y
	kWfHg8/CjNs+y2mmd+31tvDd2M+UO+myWFAMH6J7enJyi484sFQl9QPrHPcdKtkH+QMq5995+0P
	WE+DC7+nFV5GjvVnbHN1xp7N1V2TuZQgfi6eND07zYWST9Jh6r3IqBaEd4FESoj0GfZ4pq1VenW
	G+JZuulKRuxCq5b7Qm2nJUSaEN+WbdXXNc4jhrcQ5cp/xE+fYLBi+75+JQRcmiNre1q/5BvpA6x
	vjaKA99pQfMeb5LJ/kdvak9B6R4JbmJaNqc//SwlYg4xGvwIHwORIqvBH68RJeLI55L1i7csZlg
	6KZRwYTYoboxk4dvHKsB0lIoGUO7CX/na/JYzGIdr0GV6n8Hx5wHNhqeblrlyhyggDrl6xRtm1L
	Lo=
X-Received: by 2002:a05:620a:254e:b0:8c2:faed:ded3 with SMTP id af79cd13be357-8c9eb349005mr136193485a.89.1769720697462;
        Thu, 29 Jan 2026 13:04:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:57 -0800 (PST)
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
Subject: [PATCH 4/9] drivers/cxl,dax: add dax driver mode selection for dax regions
Date: Thu, 29 Jan 2026 16:04:37 -0500
Message-ID: <20260129210442.3951412-5-gourry@gourry.net>
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
	TAGGED_FROM(0.00)[bounces-75901-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email,gourry.net:dkim,gourry.net:mid,jagalactic.com:email]
X-Rspamd-Queue-Id: D0F6BB4850
X-Rspamd-Action: no action

CXL regions may wish not to auto-configure their memory as dax kmem,
but the current plumbing defaults all cxl-created dax devices to the
kmem driver.  This exposes them to hotplug policy, even if the user
intends to use the memory as a dax device.

Add plumbing to allow CXL drivers to select whether a DAX region should
default to kmem (DAXDRV_KMEM_TYPE) or device (DAXDRV_DEVICE_TYPE).

Add a 'dax_driver' field to struct cxl_dax_region and update
devm_cxl_add_dax_region() to take a dax_driver_type parameter.

In drivers/dax/cxl.c, the IORESOURCE_DAX_KMEM flag used by dax driver
matching code is now set conditionally based on dax_region->dax_driver.

Exports `enum dax_driver_type` to linux/dax.h for use in the cxl driver.

All current callers pass DAXDRV_KMEM_TYPE for backward compatibility.

Cc: John Groves <john@jagalactic.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/region.c | 6 ++++--
 drivers/cxl/cxl.h         | 2 ++
 drivers/dax/bus.h         | 6 +-----
 drivers/dax/cxl.c         | 6 +++++-
 include/linux/dax.h       | 5 +++++
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..dd987ef2def5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/dax.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index eef5d5fe3f95..e4097c464ed3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3450,7 +3450,8 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 	device_unregister(&cxlr_dax->dev);
 }
 
-static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+static int devm_cxl_add_dax_region(struct cxl_region *cxlr,
+				   enum dax_driver_type dax_driver)
 {
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
@@ -3461,6 +3462,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 		return PTR_ERR(cxlr_dax);
 
 	cxlr_dax->online_type = mhp_get_default_online_type();
+	cxlr_dax->dax_driver = dax_driver;
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
@@ -3994,7 +3996,7 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
-		return devm_cxl_add_dax_region(cxlr);
+		return devm_cxl_add_dax_region(cxlr, DAXDRV_KMEM_TYPE);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 07d57d13f4c7..c06a239c0008 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/range.h>
+#include <linux/dax.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -592,6 +593,7 @@ struct cxl_dax_region {
 	struct cxl_region *cxlr;
 	struct range hpa_range;
 	int online_type; /* MMOP_ value for kmem driver */
+	enum dax_driver_type dax_driver;
 };
 
 /**
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 4ac92a4edfe7..9144593b4029 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
 #ifndef __DAX_BUS_H__
 #define __DAX_BUS_H__
+#include <linux/dax.h>
 #include <linux/device.h>
 #include <linux/range.h>
 
@@ -29,11 +30,6 @@ struct dev_dax_data {
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
 
-enum dax_driver_type {
-	DAXDRV_KMEM_TYPE,
-	DAXDRV_DEVICE_TYPE,
-};
-
 struct dax_device_driver {
 	struct device_driver drv;
 	struct list_head ids;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 856a0cd24f3b..b13ecc2f9806 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -11,14 +11,18 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
 	int nid = phys_to_target_node(cxlr_dax->hpa_range.start);
 	struct cxl_region *cxlr = cxlr_dax->cxlr;
+	unsigned long flags = 0;
 	struct dax_region *dax_region;
 	struct dev_dax_data data;
 
+	if (cxlr_dax->dax_driver == DAXDRV_KMEM_TYPE)
+		flags |= IORESOURCE_DAX_KMEM;
+
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, IORESOURCE_DAX_KMEM);
+				      PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index bf103f317cac..e62f92d0ace1 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -19,6 +19,11 @@ enum dax_access_mode {
 	DAX_RECOVERY_WRITE,
 };
 
+enum dax_driver_type {
+	DAXDRV_KMEM_TYPE,
+	DAXDRV_DEVICE_TYPE,
+};
+
 struct dax_operations {
 	/*
 	 * direct_access: translate a device-relative
-- 
2.52.0


