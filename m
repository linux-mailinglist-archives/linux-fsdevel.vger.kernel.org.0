Return-Path: <linux-fsdevel+bounces-75902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP9mCc7Le2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:06:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E2B4792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C406B3047BF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1135CBB2;
	Thu, 29 Jan 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qgPcdWs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834C35BDDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720710; cv=none; b=qFfWOLVN1eURD5Qd97QIsR2LbSku2gc16EtdPoDXu2/lmkd85F9Oir1XyrU4OCkK3mzEuNZE74YcFfq7qXMNxeMGCsurWY8akz9JV2/X1fmFXUvcc90txkL3fybB/UO7J/vuL3IiaUtXFAnsVpmqJBSzM43ii1s7/CnB7q/N3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720710; c=relaxed/simple;
	bh=CqZQbtYz/ZVP4jGvHXo5e1nBzZGiUulJQNBLbQqBBEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNR9T4gaxtMcZz9ENwBM/EM4Le5hk+MF3AyZ/+1ziWTTLeZHLWEm0NsHIa/Tyf9Aeh+jn9kueKrvw75Kl8V3Hpg15MxpVbACW2aPOqC0yRJEU9KEh1BfMCQyKMWlg7O8oZ0DaNq960Gwjko/pYYosbV47OSylbxcVUwD44cAMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qgPcdWs0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5029aa94f28so11496251cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720706; x=1770325506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=291o5/6KJmg6RjVBO7LQXStrTekTD0wgyo4wONMNnas=;
        b=qgPcdWs0wA+XKLsc6FyPT48RhPLBIGcL6F924f16dy/P/7JXectLc3VZxYx2FIug+z
         vLTZ3bZyLYXEsVJ0YN8EuDsk1vWw+fOt/b2ecsd1OGdqI9vluzQ49uTw429u3uhQenGX
         cutksRap4W/OBkZwBQYkouID+6GwIBt3x+D4fR9eZxZ1kR1kAnzfnhFAjajsz33Amt7q
         rM1Wfp9t1IV01QDpJSXgt+JcPTdE9wLMHFkXkCGoUWO5uPdmLDiZoFPqEVC22mOcerxs
         66vJL+oJJPPMOTEngwQ5NFcpT7Tr51Dair5oNPNE+qPsRreAKXpXeuiuf+/pl+u55A9F
         meXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720706; x=1770325506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=291o5/6KJmg6RjVBO7LQXStrTekTD0wgyo4wONMNnas=;
        b=bGD/Bw2xW3h6XENO36Og/ZuYEvRdyQBqIG4nYAyBwFPyBuD6zw0WWD5EUzkdDtKlxW
         g5VCES42yFRQpGkt2ssnmVHzWVz2NAWCFK6K9wyPV+afdfit1E0k93GHEbzd2q2L/usA
         reLtnUBqsOYciYBL4eVgpwE/3usXnHrOA637faj8krNGdmefdvpxmYmcTgfM+XpdsYmJ
         dtud3QvX1Nf1IQEFV03kVeyWHkCEOkTDt1Kc8WtpQztN087LfBPa+Ilx8dPOiizS5km4
         KICQpJStuPYlVCcOPcX0GI9grvDakKlttSNxyImGcGmv959QfxcQwqxgPIGwVnRDAtxx
         NOxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUiWnmgKKjqiZp0zmq0PqhRBbyswsgvHfUVLkhhxuBmnULtzvrbl9EoGLHKTX6aFjtLxC2XSWejCUZ6S0r@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXKlBneG/c0NZqNBGQC930DGcpRoBn1t4iaflXjcQ/yoeE/4b
	TXCTcxtkgbL2xDcYYEInW5uORQryPbUBqdZ7SSSsWv0j/PETwCUsIeymSUaGr7D2YcM=
X-Gm-Gg: AZuq6aKKj2V/Rd5Qmwa4TLSjcmhcPihcpfYro2ol3hyv0iCam32u3N0sQGMvfPhm1aG
	fPLVHz4Cdw0Lcad0GOGsbFk65Dc7knKK6jTXHLaNYSmoi1GNDl0y11KStiEkstU3oVAglOTLhci
	mMHXei0ltL0RcM/FjChWEo+5cIAz2rsMBvJnzpty0Cqd6dglDKs16m6y5/XUCvriV5vyYeZ4ITE
	M7tj6ZM5bdPWwK3oOzouiOYUS8g1Qv0SwpJx6tvhWFhkQXm6coqyZv2NolvaHT4+5oJrHBe4rel
	nCjmjxmX42wBB9badzL8CBBab9N2tSVrERTWQxa5m/dg1l156WtTah03BGGM4zi1+PptqEHxr48
	D54Dbpvx/9rgMtYSrTVX/kRP+XQZph1RI5cWaW+lwsulE6a0N/5s74bi4tOfZHUVIS+j7e61Ix0
	rrnk9UJcqja0jkNRvi5IZ1EeJ8QzXi9sc9MZ3HTq+vBtcgdawsGr8AXSAh30SaFNGHO1LsZ9Fh7
	88=
X-Received: by 2002:ac8:7f84:0:b0:4f1:8bfd:bdc2 with SMTP id d75a77b69052e-5036a94de88mr60405161cf.41.1769720705646;
        Thu, 29 Jan 2026 13:05:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:05:05 -0800 (PST)
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
Subject: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region drivers
Date: Thu, 29 Jan 2026 16:04:41 -0500
Message-ID: <20260129210442.3951412-9-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	TAGGED_FROM(0.00)[bounces-75902-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:email,gourry.net:dkim,gourry.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD0E2B4792
X-Rspamd-Action: no action

In the current kmem driver binding process, the only way for users
to define hotplug policy is via a build-time option, or by not
onlining memory by default and setting each individual memory block
online after hotplug occurs.  We can solve this with a configuration
step between region-probe and dax-probe.

Add the infrastructure for a two-stage driver binding for kmem-mode
dax regions. The cxl_dax_kmem_region driver probes cxl_sysram_region
devices and creates cxl_dax_region with dax_driver=kmem.

This creates an interposition step where users can configure policy.

Device hierarchy:
  region0 -> sysram_region0 -> dax_region0 -> dax0.0

The sysram_region device exposes a sysfs 'online_type' attribute
that allows users to configure the memory online type before the
underlying dax_region is created and memory is hotplugged.

  sysram_region0/online_type:
      invalid:        not configured, blocks probe
      offline:        memory will not be onlined automatically
      online:         memory will be onlined in ZONE_NORMAL
      online_movable: memory will be onlined in ZONE_MMOVABLE

The device initializes with online_type=invalid which prevents the
cxl_dax_kmem_region driver from binding until the user explicitly
configures a valid online_type.

This enables a two-step binding process:
  echo region0 > cxl_sysram_region/bind
  echo online_movable > sysram_region0/online_type
  echo sysram_region0 > cxl_dax_kmem_region/bind

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  21 +++
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/core.h                 |   6 +
 drivers/cxl/core/dax_region.c           |  50 +++++++
 drivers/cxl/core/port.c                 |   2 +
 drivers/cxl/core/region.c               |  14 ++
 drivers/cxl/core/sysram_region.c        | 180 ++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  25 ++++
 8 files changed, 299 insertions(+)
 create mode 100644 drivers/cxl/core/sysram_region.c

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c80a1b5a03db..a051cb86bdfc 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -624,3 +624,24 @@ Description:
 		The count is persistent across power loss and wraps back to 0
 		upon overflow. If this file is not present, the device does not
 		have the necessary support for dirty tracking.
+
+
+What:		/sys/bus/cxl/devices/sysram_regionZ/online_type
+Date:		January, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) This attribute allows users to configure the memory online
+		type before the underlying dax_region engages in hotplug.
+
+		Valid values:
+		  'invalid': Not configured (default). Blocks probe.
+		  'offline': Memory will not be onlined automatically.
+		  'online' : Memory will be onlined in ZONE_NORMAL.
+		  'online_movable': Memory will be onlined in ZONE_MOVABLE.
+
+		The device initializes with online_type='invalid' which prevents
+		the cxl_dax_kmem_region driver from binding until the user
+		explicitly configures a valid online_type. This enables a
+		two-step binding process that gives users control over memory
+		hotplug policy before memory is added to the system.
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 36f284d7c500..faf662c7d88b 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -18,6 +18,7 @@ cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_REGION) += dax_region.o
+cxl_core-$(CONFIG_CXL_REGION) += sysram_region.o
 cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ea4df8abc2ad..04b32015e9b1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -26,6 +26,7 @@ extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_dax_region_type;
+extern const struct device_type cxl_sysram_region_type;
 extern const struct device_type cxl_region_type;
 
 int cxl_decoder_detach(struct cxl_region *cxlr,
@@ -37,6 +38,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
 #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
 #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
+#define CXL_SYSRAM_REGION_TYPE(x) (&cxl_sysram_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
@@ -44,9 +46,12 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
+int devm_cxl_add_sysram_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 extern struct cxl_driver cxl_devdax_region_driver;
+extern struct cxl_driver cxl_dax_kmem_region_driver;
+extern struct cxl_driver cxl_sysram_region_driver;
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
@@ -81,6 +86,7 @@ static inline void cxl_region_exit(void)
 #define SET_CXL_REGION_ATTR(x)
 #define CXL_PMEM_REGION_TYPE(x) NULL
 #define CXL_DAX_REGION_TYPE(x) NULL
+#define CXL_SYSRAM_REGION_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
index 391d51e5ec37..a379f5b85e3d 100644
--- a/drivers/cxl/core/dax_region.c
+++ b/drivers/cxl/core/dax_region.c
@@ -127,3 +127,53 @@ struct cxl_driver cxl_devdax_region_driver = {
 	.probe = cxl_devdax_region_driver_probe,
 	.id = CXL_DEVICE_REGION,
 };
+
+static int cxl_dax_kmem_region_driver_probe(struct device *dev)
+{
+	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
+	struct cxl_dax_region *cxlr_dax;
+	struct cxl_region *cxlr;
+	int rc;
+
+	if (!cxlr_sysram)
+		return -ENODEV;
+
+	/* Require explicit online_type configuration before binding */
+	if (cxlr_sysram->online_type == -1)
+		return -ENODEV;
+
+	cxlr = cxlr_sysram->cxlr;
+
+	cxlr_dax = cxl_dax_region_alloc(cxlr);
+	if (IS_ERR(cxlr_dax))
+		return PTR_ERR(cxlr_dax);
+
+	/* Inherit online_type from parent sysram_region */
+	cxlr_dax->online_type = cxlr_sysram->online_type;
+	cxlr_dax->dax_driver = DAXDRV_KMEM_TYPE;
+
+	/* Parent is the sysram_region device */
+	cxlr_dax->dev.parent = dev;
+
+	rc = dev_set_name(&cxlr_dax->dev, "dax_region%d", cxlr->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(&cxlr_dax->dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(dev, "%s: register %s\n", dev_name(dev),
+		dev_name(&cxlr_dax->dev));
+
+	return devm_add_action_or_reset(dev, cxlr_dax_unregister, cxlr_dax);
+err:
+	put_device(&cxlr_dax->dev);
+	return rc;
+}
+
+struct cxl_driver cxl_dax_kmem_region_driver = {
+	.name = "cxl_dax_kmem_region",
+	.probe = cxl_dax_kmem_region_driver_probe,
+	.id = CXL_DEVICE_SYSRAM_REGION,
+};
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3310dbfae9d6..dc7262a5efd6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -66,6 +66,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_PMEM_REGION;
 	if (dev->type == CXL_DAX_REGION_TYPE())
 		return CXL_DEVICE_DAX_REGION;
+	if (dev->type == CXL_SYSRAM_REGION_TYPE())
+		return CXL_DEVICE_SYSRAM_REGION;
 	if (is_cxl_port(dev)) {
 		if (is_cxl_root(to_cxl_port(dev)))
 			return CXL_DEVICE_ROOT;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6200ca1cc2dd..8bef91dc726c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3734,8 +3734,20 @@ int cxl_region_init(void)
 	if (rc)
 		goto err_dax;
 
+	rc = cxl_driver_register(&cxl_sysram_region_driver);
+	if (rc)
+		goto err_sysram;
+
+	rc = cxl_driver_register(&cxl_dax_kmem_region_driver);
+	if (rc)
+		goto err_dax_kmem;
+
 	return 0;
 
+err_dax_kmem:
+	cxl_driver_unregister(&cxl_sysram_region_driver);
+err_sysram:
+	cxl_driver_unregister(&cxl_devdax_region_driver);
 err_dax:
 	cxl_driver_unregister(&cxl_region_driver);
 	return rc;
@@ -3743,6 +3755,8 @@ int cxl_region_init(void)
 
 void cxl_region_exit(void)
 {
+	cxl_driver_unregister(&cxl_dax_kmem_region_driver);
+	cxl_driver_unregister(&cxl_sysram_region_driver);
 	cxl_driver_unregister(&cxl_devdax_region_driver);
 	cxl_driver_unregister(&cxl_region_driver);
 }
diff --git a/drivers/cxl/core/sysram_region.c b/drivers/cxl/core/sysram_region.c
new file mode 100644
index 000000000000..5665db238d0f
--- /dev/null
+++ b/drivers/cxl/core/sysram_region.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Meta Platforms, Inc. All rights reserved. */
+/*
+ * CXL Sysram Region - Intermediate device for kmem hotplug configuration
+ *
+ * This provides an intermediate device between cxl_region and cxl_dax_region
+ * that allows users to configure memory hotplug parameters (like online_type)
+ * before the underlying dax_region is created and memory is hotplugged.
+ */
+
+#include <linux/memory_hotplug.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "core.h"
+
+static void cxl_sysram_region_release(struct device *dev)
+{
+	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
+
+	kfree(cxlr_sysram);
+}
+
+static ssize_t online_type_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
+
+	switch (cxlr_sysram->online_type) {
+	case MMOP_OFFLINE:
+		return sysfs_emit(buf, "offline\n");
+	case MMOP_ONLINE:
+		return sysfs_emit(buf, "online\n");
+	case MMOP_ONLINE_MOVABLE:
+		return sysfs_emit(buf, "online_movable\n");
+	default:
+		return sysfs_emit(buf, "invalid\n");
+	}
+}
+
+static ssize_t online_type_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
+{
+	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
+
+	if (sysfs_streq(buf, "offline"))
+		cxlr_sysram->online_type = MMOP_OFFLINE;
+	else if (sysfs_streq(buf, "online"))
+		cxlr_sysram->online_type = MMOP_ONLINE;
+	else if (sysfs_streq(buf, "online_movable"))
+		cxlr_sysram->online_type = MMOP_ONLINE_MOVABLE;
+	else
+		return -EINVAL;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(online_type);
+
+static struct attribute *cxl_sysram_region_attrs[] = {
+	&dev_attr_online_type.attr,
+	NULL,
+};
+
+static const struct attribute_group cxl_sysram_region_attribute_group = {
+	.attrs = cxl_sysram_region_attrs,
+};
+
+static const struct attribute_group *cxl_sysram_region_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	&cxl_sysram_region_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_sysram_region_type = {
+	.name = "cxl_sysram_region",
+	.release = cxl_sysram_region_release,
+	.groups = cxl_sysram_region_attribute_groups,
+};
+
+static bool is_cxl_sysram_region(struct device *dev)
+{
+	return dev->type == &cxl_sysram_region_type;
+}
+
+struct cxl_sysram_region *to_cxl_sysram_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_sysram_region(dev),
+			  "not a cxl_sysram_region device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_sysram_region, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_sysram_region, "CXL");
+
+static struct lock_class_key cxl_sysram_region_key;
+
+static struct cxl_sysram_region *cxl_sysram_region_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_sysram_region *cxlr_sysram;
+	struct device *dev;
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return ERR_PTR(-ENXIO);
+
+	cxlr_sysram = kzalloc(sizeof(*cxlr_sysram), GFP_KERNEL);
+	if (!cxlr_sysram)
+		return ERR_PTR(-ENOMEM);
+
+	cxlr_sysram->hpa_range.start = p->res->start;
+	cxlr_sysram->hpa_range.end = p->res->end;
+	cxlr_sysram->online_type = -1;  /* Require explicit configuration */
+
+	dev = &cxlr_sysram->dev;
+	cxlr_sysram->cxlr = cxlr;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_sysram_region_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_sysram_region_type;
+
+	return cxlr_sysram;
+}
+
+static void cxlr_sysram_unregister(void *_cxlr_sysram)
+{
+	struct cxl_sysram_region *cxlr_sysram = _cxlr_sysram;
+
+	device_unregister(&cxlr_sysram->dev);
+}
+
+int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
+{
+	struct cxl_sysram_region *cxlr_sysram;
+	struct device *dev;
+	int rc;
+
+	cxlr_sysram = cxl_sysram_region_alloc(cxlr);
+	if (IS_ERR(cxlr_sysram))
+		return PTR_ERR(cxlr_sysram);
+
+	dev = &cxlr_sysram->dev;
+	rc = dev_set_name(dev, "sysram_region%d", cxlr->id);
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
+	return devm_add_action_or_reset(&cxlr->dev, cxlr_sysram_unregister,
+					cxlr_sysram);
+err:
+	put_device(dev);
+	return rc;
+}
+
+static int cxl_sysram_region_driver_probe(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	/* Only handle RAM regions */
+	if (cxlr->mode != CXL_PARTMODE_RAM)
+		return -ENODEV;
+
+	return devm_cxl_add_sysram_region(cxlr);
+}
+
+struct cxl_driver cxl_sysram_region_driver = {
+	.name = "cxl_sysram_region",
+	.probe = cxl_sysram_region_driver_probe,
+	.id = CXL_DEVICE_REGION,
+};
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 674d5f870c70..1544c27e9c89 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -596,6 +596,25 @@ struct cxl_dax_region {
 	enum dax_driver_type dax_driver;
 };
 
+/**
+ * struct cxl_sysram_region - CXL RAM region for system memory hotplug
+ * @dev: device for this sysram_region
+ * @cxlr: parent cxl_region
+ * @hpa_range: Host physical address range for the region
+ * @online_type: Memory online type (MMOP_* 0-3, or -1 if not configured)
+ *
+ * Intermediate device that allows configuration of memory hotplug
+ * parameters before the underlying dax_region is created. The device
+ * starts with online_type=-1 which prevents the cxl_dax_kmem_region
+ * driver from binding until the user explicitly sets online_type.
+ */
+struct cxl_sysram_region {
+	struct device dev;
+	struct cxl_region *cxlr;
+	struct range hpa_range;
+	int online_type;
+};
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -890,6 +909,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_SYSRAM_REGION	10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -907,6 +927,7 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+struct cxl_sysram_region *to_cxl_sysram_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -925,6 +946,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline struct cxl_sysram_region *to_cxl_sysram_region(struct device *dev)
+{
+	return NULL;
+}
 static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 					       u64 spa)
 {
-- 
2.52.0


