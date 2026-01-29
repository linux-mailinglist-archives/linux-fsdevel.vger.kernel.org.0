Return-Path: <linux-fsdevel+bounces-75903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH+ZAu/Le2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:06:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5BEB47BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F5503052ACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5B35E559;
	Thu, 29 Jan 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OUKin7me"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B935D5EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720711; cv=none; b=sh1QwFxfdEFsIl9/oIPys9LfUEjO2L/vBVZnRfO/t/WbZoykzx2Z2wO6ghE/9/xXZvBOXxT5thSt9R7tC2wPga59DblL11zk1uw7kIBe7OoY984BEW8WBV/omFcevbulMsAG9DwYrUKdiCaEPiWNcUULANagbOj1pZ8YxUdmb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720711; c=relaxed/simple;
	bh=iBrRdDjjJNCNPe98g9cITjVy6s0GzL4YINvlGeB4imc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqy06fHYFpec2igrF3xSFsOseAQPlgYfN1EmldH+MsEvwkCC+ebzPR6sEYeWIFi1W/nFH4PJ6FglemPuUmtl1qy0EXZ/yQIBjvil0RFoZai2WjV96hhGpWa07XMijvrHnD7JkPWvO+yUiUDO0Cogn9m1410cUjm5FlKtooT6/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OUKin7me; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8947404b367so16549136d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720703; x=1770325503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpgSTfoH6x9FkcQxT+wr5JUESeygPnLUnHeiLg7bHkA=;
        b=OUKin7mehiPc0J+MFPXJDEJ07nav+vz8WRu15f/bWbDd3TZxl2kjWxtA92vxD9AM0/
         VJcsTrSfMH/h7LrWf+2OR9vPUbqKILssoXvhD7g/dFAkvwI6Cos8ZgVC2Cg3ukwbeFF4
         LfF2uiNj5t6eyj7Ija1WV720htkSJGf9MJM61Hd11m60So97L4Ocn48yaOV/MfCilFkM
         EmLpxLLJfjgwBi6Ct/o3uVB4emRpCWf4MrgPB5tvZVbg+rV/wD1/mgM6eHGqd8kfzQ/b
         mvWMQQ+2d8XeTNdsbpxHuOt/hBBaha2i1kZEDcUhlPEg4PkjoPBXFe1Xy+JJlrL8h0SP
         8m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720703; x=1770325503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpgSTfoH6x9FkcQxT+wr5JUESeygPnLUnHeiLg7bHkA=;
        b=gFQWm5XW4Xvx8Qx42FkrOkr5iFoK1qFKG0FBJRoJ7wNSnUgnOeBaMSvsekRMRUde04
         uWiXWSMcSmBEByWfC8/CANhIpMi6HDdvjvimx0jejQdj5yx8i0rrK+hvnTocNhkQmnj4
         oeKNMToDpmkNmbwMfpITPxe4atwkGEDjQxbKXY+dyka/bSlA8yG+7MvQ+6eshYd/Y8TX
         KSM07UcYOdB2tjJsZvOvDFrUS1Ca4gP/VVUZPYovn/c9foers2vpfBDSca/SHUojOXGR
         vbDM+N38BvDyVfSSVC16vgfGWy8JHlzmndfSAVMAY/LGvQctDpkOs/Rs1fYDd1lSVZ3f
         Bqcg==
X-Forwarded-Encrypted: i=1; AJvYcCVQf6SCT9Z1MmnEcr6+oS0iAj/JlLxYSklQTgLY9qHzMrNzh/PXXDYjasM8JLrZp3m6Qlo6ihLk2kj8jfOW@vger.kernel.org
X-Gm-Message-State: AOJu0YzvL7ui43EB4SHURLa9vfIsLjSYtNPtGMyv5IfQMUJeh2/NpScq
	93vjXJb1OR8jJ5gcSWPLRj2xe7k2UD7EcjM9Z2gKLg9m/+egp9QYlZJw+CzYVZPzc+Y=
X-Gm-Gg: AZuq6aIl/NW//BbSdErXmGzDW5Nl1mcWSVArSDZFh+Q4UFRqj5BSV6rbrA6Wn68CkIe
	pAir3rxw0qU9G7tYCNDXM/5J9alEwGwcu5cgVsT9skjFW8uc0+Kq0OHJOO+vxQoygXrdzO15jmQ
	/6pnLLjlhSyWUhhLP6Tbkv66a138R2d+EhFgTyMU0e0blSRq3LHguvNopLneZwZ/ObgyiE0szak
	nj6wguNR1FHKKL22WbK/AE7Z0ik+tZ7+9EW422UE5NpLWNrdgJsD1VWu6s4gsvvvinSBrwNmDi6
	APstT+i5FntZBoDg+HYWUHhbNAfP2qi84b0hmtRvJ7wewRSuYOEym4SAJn/3L8wU/fGPeZcPgI6
	6OUnunrjchYZdGtTWVX1RrbwGUCt/fTfo+XwTOerssh5bi5OMqX5NegHPabRDrGPk9XR1iSlk3D
	l9X70zSG3fYrbddQjFNQE45/3y/G7yQRfuT91cg9ulREb+D/7vzjBTZFLrgqwOWUQm9FMjqy9Be
	2Q=
X-Received: by 2002:ad4:5aa2:0:b0:894:78e4:27cc with SMTP id 6a1803df08f44-894ea026eeemr11955076d6.38.1769720703415;
        Thu, 29 Jan 2026 13:05:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:05:03 -0800 (PST)
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
Subject: [PATCH 7/9] cxl/core: add cxl_devdax_region driver for explicit userland region binding
Date: Thu, 29 Jan 2026 16:04:40 -0500
Message-ID: <20260129210442.3951412-8-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	TAGGED_FROM(0.00)[bounces-75903-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:email,gourry.net:dkim,gourry.net:mid]
X-Rspamd-Queue-Id: BB5BEB47BE
X-Rspamd-Action: no action

Add a new cxl_devdax_region driver that probes CXL regions in device
dax mode and creates dax_region devices. This allows explicit binding to
the device_dax dax driver instead of the kmem driver.

Exports to_cxl_region() to core.h so it can be used by the driver.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h       |  2 ++
 drivers/cxl/core/dax_region.c | 16 ++++++++++++++++
 drivers/cxl/core/region.c     | 21 +++++++++++++++++----
 drivers/cxl/cxl.h             |  1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 217dd708a2a6..ea4df8abc2ad 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -46,6 +46,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
+extern struct cxl_driver cxl_devdax_region_driver;
+
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
index 0602db5f7248..391d51e5ec37 100644
--- a/drivers/cxl/core/dax_region.c
+++ b/drivers/cxl/core/dax_region.c
@@ -111,3 +111,19 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr,
 	put_device(dev);
 	return rc;
 }
+
+static int cxl_devdax_region_driver_probe(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	if (cxlr->mode != CXL_PARTMODE_RAM)
+		return -ENODEV;
+
+	return devm_cxl_add_dax_region(cxlr, DAXDRV_DEVICE_TYPE);
+}
+
+struct cxl_driver cxl_devdax_region_driver = {
+	.name = "cxl_devdax_region",
+	.probe = cxl_devdax_region_driver_probe,
+	.id = CXL_DEVICE_REGION,
+};
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 61ec939c1462..6200ca1cc2dd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -39,8 +39,6 @@
  */
 static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
 
-static struct cxl_region *to_cxl_region(struct device *dev);
-
 #define __ACCESS_ATTR_RO(_level, _name) {				\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
 	.show	= _name##_access##_level##_show,			\
@@ -2430,7 +2428,7 @@ bool is_cxl_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
 
-static struct cxl_region *to_cxl_region(struct device *dev)
+struct cxl_region *to_cxl_region(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
 			  "not a cxl_region device\n"))
@@ -3726,11 +3724,26 @@ static struct cxl_driver cxl_region_driver = {
 
 int cxl_region_init(void)
 {
-	return cxl_driver_register(&cxl_region_driver);
+	int rc;
+
+	rc = cxl_driver_register(&cxl_region_driver);
+	if (rc)
+		return rc;
+
+	rc = cxl_driver_register(&cxl_devdax_region_driver);
+	if (rc)
+		goto err_dax;
+
+	return 0;
+
+err_dax:
+	cxl_driver_unregister(&cxl_region_driver);
+	return rc;
 }
 
 void cxl_region_exit(void)
 {
+	cxl_driver_unregister(&cxl_devdax_region_driver);
 	cxl_driver_unregister(&cxl_region_driver);
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c06a239c0008..674d5f870c70 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -859,6 +859,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
+struct cxl_region *to_cxl_region(struct device *dev);
 
 extern const struct bus_type cxl_bus_type;
 
-- 
2.52.0


