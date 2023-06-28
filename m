Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A23740B33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjF1IYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:24:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:64476 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233844AbjF1IVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687940464; x=1719476464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/qPMcMuAbH8XbNYSsnxXR9j+8vlCJi+JFzYYpfZQA1s=;
  b=GIYEgrXlJ2Ufss14RtWTZPaEtgueYMAJ+owErqDSPkBZXBCcMjqfBDMx
   FL/qRxjq40LWs9bdciFc1l7k4aE0viGuum4Gn7sOKib8/5grrnli0iUoK
   N0SMfjtf3qe38bYi5zk31yUhMlFPPRRez/Q1KbxUSN1sRZxl0EOTtZw9z
   R6ndsJvsmRPLs8+0KiD6Dcxnlaaa/eiZoH6idTbbRGJH7ysplYbfjNJtI
   zI1dOj992dytBxRNnHP0Yy2p51zpNP99MGT+trqkNz78mRas4Ue+Bi1Ap
   /vb4FuV8W9QINe99P1aTtpl+gN2GXtIW6T2mZAkrtUYSnRLVX5jRjZUWo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342087734"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="342087734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 21:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806741515"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="806741515"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2023 21:43:08 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        willy@infradead.org, ackerleytng@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com, oliver.sang@intel.com
Subject: [PATCH v2] readahead: Correct the start and size in ondemand_readahead()
Date:   Wed, 28 Jun 2023 12:43:03 +0800
Message-Id: <20230628044303.1412624-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit
9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
updated the page_cache_next_miss() to return the index beyond
range.

But it breaks the start/size of ra in ondemand_readahead() because
the offset by one is accumulated to readahead_index. As a consequence,
not best readahead order is picked.

Tracing of the order parameter of filemap_alloc_folio() showed:
     page order    : count     distribution
        0          : 892073   |                                        |
        1          : 0        |                                        |
        2          : 65120457 |****************************************|
        3          : 32914005 |********************                    |
        4          : 33020991 |********************                    |
with 9425c591e06a9.

With parent commit:
     page order    : count     distribution
        0          : 3417288  |****                                    |
        1          : 0        |                                        |
        2          : 877012   |*                                       |
        3          : 288      |                                        |
        4          : 5607522  |*******                                 |
        5          : 29974228 |****************************************|

Fix the issue by removing the offset by one when page_cache_next_miss()
returns no gaps in the range.

After the fix:
    page order     : count     distribution
        0          : 2598561  |***                                     |
        1          : 0        |                                        |
        2          : 687739   |                                        |
        3          : 288      |                                        |
        4          : 207210   |                                        |
        5          : 32628260 |****************************************|

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
Changes from v1:
  - only removing offset by one when there is no gaps found by
    page_cache_next_miss()
  - Update commit message to include the histogram of page order
    after fix

 mm/readahead.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..a93af773686f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -614,9 +614,17 @@ static void ondemand_readahead(struct readahead_control *ractl,
 				max_pages);
 		rcu_read_unlock();
 
-		if (!start || start - index > max_pages)
+		if (!start || start - index - 1 > max_pages)
 			return;
 
+		/*
+		 * If no gaps in the range, page_cache_next_miss() returns
+		 * index beyond range. Adjust it back to make sure
+		 * ractl->_index is updated correctly later.
+		 */
+		if ((start - index - 1) == max_pages)
+			start--;
+
 		ra->start = start;
 		ra->size = start - index;	/* old async_size */
 		ra->size += req_size;
-- 
2.39.2

