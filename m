Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBE95A2D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbiHZRST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344677AbiHZRSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:18:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7362D5DF0;
        Fri, 26 Aug 2022 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534289; x=1693070289;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCTeJYnVfz9emV2HwJCGmwSTFAShgS49A/17AEqM6p0=;
  b=JGoqSADel1w7BFMX9rVRNizT3B4bXaoHuCkagW/4NIuwwOyEhuKhgh4C
   7fmxC0ZnxKB6tQpcTBuuG5+S10TE/NY/06rUgsGRbbS0Oc90coXPlsbjy
   JinnqtBHx/h7mUIRrN5uMBwXEg/tNfpqS7zOmMNnmmlai8oFPQOcQJGcS
   0AlzHFVTD/ATfoJtkDlMDwwfgBCBnGE+eHUDXqJpUoOP64VQgEcOezE/u
   KY5fZRA47p7uUAv46JxmkBAIJXhf6/EJOwBkYGcSSxgrlIT3UoMtOgtPg
   N8A+JQc+BWlzWsmJ7p3AOfH/TFQ9i3ztF2Dy3FXWc7QZzj142P1DBHgDV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295333559"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295333559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:18:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="613590592"
Received: from jodirobx-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.108.22])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:18:08 -0700
Subject: [PATCH 3/4] mm/memory-failure: Fix detection of memory_failure()
 handlers
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org, djwong@kernel.org
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 26 Aug 2022 10:18:07 -0700
Message-ID: <166153428781.2758201.1990616683438224741.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some pagemap types, like MEMORY_DEVICE_GENERIC (device-dax) do not even
have pagemap ops which results in crash signatures like this:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 8000000205073067 P4D 8000000205073067 PUD 2062b3067 PMD 0
  Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 22 PID: 4535 Comm: device-dax Tainted: G           OE    N 6.0.0-rc2+ #59
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:memory_failure+0x667/0xba0
 [..]
  Call Trace:
   <TASK>
   ? _printk+0x58/0x73
   do_madvise.part.0.cold+0xaf/0xc5

Check for ops before checking if the ops have a memory_failure()
handler.

Fixes: 33a8f7f2b3a3 ("pagemap,pmem: introduce ->memory_failure()")
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |    5 +++++
 mm/memory-failure.c      |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 19010491a603..c3b4cc84877b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -139,6 +139,11 @@ struct dev_pagemap {
 	};
 };
 
+static inline bool pgmap_has_memory_failure(struct dev_pagemap *pgmap)
+{
+	return pgmap->ops && pgmap->ops->memory_failure;
+}
+
 static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
 {
 	if (pgmap->flags & PGMAP_ALTMAP_VALID)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14439806b5ef..8a4294afbfa0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1928,7 +1928,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * Call driver's implementation to handle the memory failure, otherwise
 	 * fall back to generic handler.
 	 */
-	if (pgmap->ops->memory_failure) {
+	if (pgmap_has_memory_failure(pgmap)) {
 		rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
 		/*
 		 * Fall back to generic handler too if operation is not

