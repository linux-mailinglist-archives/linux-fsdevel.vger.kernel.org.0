Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE95FF757
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJNX6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJNX6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483AD0194
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791918; x=1697327918;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utXjDwHtVMO/W0wdDgPICi14CmGCX+3qR5RCZ+LxUbs=;
  b=NA5hyU7Tw3hMBBcePTFmkKGWBbZYdRfqpSBknsGB4fRoJ3pm3NNHqiOV
   Rk0NVQXiDJYTgMyAguwYJl2mHtN+Z0NgxaV6qgyhx6DTiVrpXlc5rXlWW
   BucELt5ZcCp69UEJUhbtARE50aygi2O2eMR/oA8Zj2PyFD4glpB+aQ0Jr
   gYVC9jMT6qA7mW7CyubMChZ43950UIyLmNERw/ZWs0si51iGTOt/2DkRQ
   q7RZYWL4eaG/0EVM/Wg5gaUYVhCareD2NZVz+g3zL/YsGzloBaBoE7NJz
   NYbQIDRQj77Y80fRzZNC++ECXRNGkgrwbrpviMaGgwLpVL4WshUfqxmWT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369693860"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="369693860"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="802798941"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="802798941"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:38 -0700
Subject: [PATCH v3 17/25] devdax: Sparse fixes for xarray locking
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     kernel test robot <lkp@intel.com>, david@fromorbit.com, hch@lst.de,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:58:38 -0700
Message-ID: <166579191803.2236710.11651241811946564050.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the dax-mapping-entry code has moved to a common location take
the opportunity to fixup some long standing sparse warnings. In this
case annotate the manipulations of the Xarray lock:

Fixes:
drivers/dax/mapping.c:216:13: sparse: warning: context imbalance in 'wait_entry_unlocked' - unexpected unlock
drivers/dax/mapping.c:953:9: sparse: warning: context imbalance in 'dax_writeback_one' - unexpected unlock

Reported-by: Reported-by: kernel test robot <lkp@intel.com>
Link: http://lore.kernel.org/r/202210091141.cHaQEuCs-lkp@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/mapping.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
index 19121b7421fb..803ae64c13d4 100644
--- a/drivers/dax/mapping.c
+++ b/drivers/dax/mapping.c
@@ -213,7 +213,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
  * (it's cycled in clear_inode() after removing the entries from i_pages)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
  */
-static void wait_entry_unlocked(struct xa_state *xas, void *entry)
+static void wait_entry_unlocked(struct xa_state *xas, void *entry) __releases(xas)
 {
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;
@@ -910,7 +910,7 @@ vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 }
 
 int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
-		      struct address_space *mapping, void *entry)
+		      struct address_space *mapping, void *entry) __must_hold(xas)
 {
 	unsigned long pfn, index, count, end;
 	long ret = 0;

