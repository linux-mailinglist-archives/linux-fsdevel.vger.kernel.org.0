Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B9567AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 01:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiGEXW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 19:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiGEXWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:22:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2201A3A7;
        Tue,  5 Jul 2022 16:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657063340; x=1688599340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXVHNJCtIuqHam3NNieA0W34pcZC7c81/cpdnlVw4AQ=;
  b=DtUW+pxk6IlycrHJ6KZ9WgjNHzkdzGfKCp/kdLbk+qL590Hfu3rl5W1A
   GDnKPmajYtgC2bPadaKMjL2G+9RJlNAdJHb3quzwTOovHedV3FiovNMrC
   +TtqTjyk8L8tMtbqBsf0j9/P1ni5zuhIHNr3ha1UKN+cztaYEaS6QL/K8
   sOwA+qCUKT4Jk4rJV+1F1DXNYCiKy/k8CuSxVSeAGyUuGSCLg7nHpGdUS
   p2MaaenU1otM6ujRTqU+ooQD8ZOT2N2euNUCz4yLqzJyeH448STlLg+Uu
   lJYOkJdAg0l8TurNKMeMCDhSVMkXsNT0sBVvn87pWoWBZgOe2WHD1/5oY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345250085"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="345250085"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="735338613"
Received: from adiazinf-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.103])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:16 -0700
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
Subject: [RFC PATCH 3/3] CXL/doe: Use devm_xa_init()
Date:   Tue,  5 Jul 2022 16:21:59 -0700
Message-Id: <20220705232159.2218958-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705232159.2218958-1-ira.weiny@intel.com>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The DOE mailboxes are all allocated with device managed calls.
Therefore, the XArray can go away when the device goes away.

Use devm_xa_init() and remove the callback needed for xa_destroy().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6228c95fd142..adb8198fc6ad 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -387,11 +387,6 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
-static void cxl_pci_destroy_doe(void *mbs)
-{
-	xa_destroy(mbs);
-}
-
 static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
@@ -446,8 +441,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
-	xa_init(&cxlds->doe_mbs);
-	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs))
+	if (devm_xa_init(&pdev->dev, &cxlds->doe_mbs))
 		return -ENOMEM;
 
 	cxlds->serial = pci_get_dsn(pdev);
-- 
2.35.3

