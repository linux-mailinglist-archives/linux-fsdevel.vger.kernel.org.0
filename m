Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2373F3D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 07:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjF0FHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjF0FHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:07:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13038F;
        Mon, 26 Jun 2023 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687842430; x=1719378430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ud+CunnfVYp9ThBCLHD+sITFdVXD+yTRAxxIAbdMevk=;
  b=lveK8XWXhPV2If6FcupEmwVUHikLFv1soxx5L6he8VMxcdb8E7GQRP/r
   whLYJUrp4wCPEFopYVBwhpkIlWsOYRuwTZzmqppjpBID4gXLO3G30+88Q
   F2dhD6eP0QZWxbSclCvI5m1666Tp84Ub5ZXgRaIczqNWqN2q9bMPvsF/R
   89MqM2LqQqwLJkHQkCfZphyYDKnF7ANBgaMYOh4qlggzDVFE619yxYYf5
   cO6SEzTsyDzJrqXhLjMVriuHJySt6YgIZUJYZ1b3/NlBs4IktyifEjirk
   LXQLpU8i3FOf58F4LE2VkddFsTkd0y713Ds6c9sxi2M71B4xK31GRA00M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341816754"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="341816754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 22:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="806315435"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="806315435"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2023 22:07:08 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        willy@infradead.org, ackerleytng@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] readahead: Correct the start and size in ondemand_readahead()
Date:   Tue, 27 Jun 2023 13:07:02 +0800
Message-Id: <20230627050702.823033-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Fix the issue by set correct start/size of ra in ondemand_readahead().

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/readahead.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122e..a1b8c628851a9 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -614,11 +614,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
 				max_pages);
 		rcu_read_unlock();
 
-		if (!start || start - index > max_pages)
+		if (!start || start - index - 1 > max_pages)
 			return;
 
-		ra->start = start;
-		ra->size = start - index;	/* old async_size */
+		ra->start = start - 1;
+		ra->size = start - index - 1;	/* old async_size */
 		ra->size += req_size;
 		ra->size = get_next_ra_size(ra, max_pages);
 		ra->async_size = ra->size;
-- 
2.39.2

