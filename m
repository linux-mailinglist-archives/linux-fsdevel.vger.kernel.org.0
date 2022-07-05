Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4888567AA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiGEXWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 19:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiGEXWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:22:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E50D19C26;
        Tue,  5 Jul 2022 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657063335; x=1688599335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+6zhrfQatJA+7vvvGNeZ5EhrPDLmRMbBvly8QQTcho=;
  b=jGw7xr+EKA2kZIibMmh2l/t4fA/uEavqi5kM9yrHD2Mk4u7aDsFEVzIj
   PJ+DGvjqfz1DvyzHlEozn7C2VZICZhvQsJzVwnNfH90UKBdgqBtSa09ti
   zeU3bUhJe+LcP8yXz0iEFdptWtjfEtYC5eRdhvrII1Uolt4GuvmqXXtia
   JxlN7g5e6dR4UWbnnwnDHUsS03rsnhPdWnGe7ZzsUjL9x275pAsQbHAST
   SM7T2ZWdRk/65vUgat1805VlsZxNrGV45LBBbBhVozv21pjYo74rKX0S5
   FDU1jTC5K0SGfa43cl6NUlMtAz8vH71bJJBe8prnHcnihRhCI2z7vJVQY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263987402"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="263987402"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="660731827"
Received: from adiazinf-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.103])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:12 -0700
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
Subject: [RFC PATCH 2/3] pci/doe: Use devm_xa_init()
Date:   Tue,  5 Jul 2022 16:21:58 -0700
Message-Id: <20220705232159.2218958-3-ira.weiny@intel.com>
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

The XArray being used to store the protocols does not even store
allocated objects.

Use devm_xa_init() to automatically destroy the XArray when the PCI
device goes away.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/doe.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 0b02f33ef994..aa36f459d375 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -386,13 +386,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 	return 0;
 }
 
-static void pci_doe_xa_destroy(void *mb)
-{
-	struct pci_doe_mb *doe_mb = mb;
-
-	xa_destroy(&doe_mb->prots);
-}
-
 static void pci_doe_destroy_workqueue(void *mb)
 {
 	struct pci_doe_mb *doe_mb = mb;
@@ -440,11 +433,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
 	doe_mb->pdev = pdev;
 	doe_mb->cap_offset = cap_offset;
 	init_waitqueue_head(&doe_mb->wq);
-
-	xa_init(&doe_mb->prots);
-	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
+	if (devm_xa_init(dev, &doe_mb->prots))
+		return ERR_PTR(-ENOMEM);
 
 	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
 						     doe_mb->cap_offset);
-- 
2.35.3

