Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACFF567A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 01:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGEXWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGEXWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:22:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B28193F0;
        Tue,  5 Jul 2022 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657063331; x=1688599331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zm0KOQVEYYEWOhSmHB8yhZfj2F0Gg29XPhX+LCnTORc=;
  b=mdGOMkJ7d0uBXjLiAbhSyP1c1EpyP4APMNnYWw6HYRB4KrxGg3jJeVLR
   D3RRrxIZ5D+4ajhBvFBO1Ca7qqb7Zxy+vxBZjHLdSfpj4k2LmCHpm05G6
   2v2jodirotfgEY1ib51xFyAJqJYtIBRwFBWuxbr/9K9uYUqPYk2tC+y4v
   sTsCol47M3BfKI+2CbtWSotrbRk64NS0T7mBGdKz5F2/YFZvq7AmqRTRy
   glyfJX4a0lcC3JOTwLI6/D0KZ/foJktbnW+WDlkh1GrlIgc2oKmwxDJLA
   Q/Dooof+X6TJBXUVFMY8ePuPiMYwHwETUa+4mL4+avZxDvLQpvcEx4KTg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283593110"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="283593110"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="597455659"
Received: from adiazinf-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.103])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:09 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Date:   Tue,  5 Jul 2022 16:21:57 -0700
Message-Id: <20220705232159.2218958-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705232159.2218958-1-ira.weiny@intel.com>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Many devices may have arrays of resources which are allocated with
device managed functions.  The objects referenced by the XArray are
therefore automatically destroyed without the need for the XArray.

Introduce devm_xa_init() which takes care of the destruction of the
XArray meta data automatically as well.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
The main issue I see with this is defining devm_xa_init() in device.h.
This makes sense because a device is required to use the call.  However,
I'm worried about if users will find the call there vs including it in
xarray.h?
---
 drivers/base/core.c    | 20 ++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2eede2ec3d64..8c5c20a62744 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2609,6 +2609,26 @@ void devm_device_remove_groups(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_device_remove_groups);
 
+static void xa_destroy_cb(void *xa)
+{
+	xa_destroy(xa);
+}
+
+/**
+ * devm_xa_init() - Device managed initialization of an empty XArray
+ * @dev: The device this xarray is associated with
+ * @xa: XArray
+ *
+ * Context: Any context
+ * Returns: 0 on success, -errno if the action fails to be set
+ */
+int devm_xa_init(struct device *dev, struct xarray *xa)
+{
+	xa_init(xa);
+	return devm_add_action(dev, xa_destroy_cb, xa);
+}
+EXPORT_SYMBOL(devm_xa_init);
+
 static int device_add_attrs(struct device *dev)
 {
 	struct class *class = dev->class;
diff --git a/include/linux/device.h b/include/linux/device.h
index 073f1b0126ac..e06dc63e375b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -27,6 +27,7 @@
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
+#include <linux/xarray.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
@@ -978,6 +979,8 @@ int __must_check devm_device_add_group(struct device *dev,
 void devm_device_remove_group(struct device *dev,
 			      const struct attribute_group *grp);
 
+int devm_xa_init(struct device *dev, struct xarray *xa);
+
 /*
  * Platform "fixup" functions - allow the platform to have their say
  * about devices and actions that the general device layer doesn't
-- 
2.35.3

