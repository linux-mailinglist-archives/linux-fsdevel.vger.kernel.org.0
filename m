Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B95FF742
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJNX5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJNX5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:57:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE690A837F
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791854; x=1697327854;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDhrLpyapWWVzBNALsAavqF2Cp5tBjhlbxEJIcuaLkE=;
  b=SAsxNngwX0ECbtUUDzpFTEbMYRJu96jowqtSY9eGSgGNBtM4dpqAdasG
   wXLsBBAcq3YbLuKJ1mOJPm5W5m/9fvnx8dxqAIHXdIrOP1rqDy9zaGokH
   /X2Lf4nTCPO1J9M74GRgOTXg36SoubJ6oUqYoeM8dUQY9OjJUNJ5bcegW
   34x75LB7aljJUyHffcPyqtRAPjGtiYY12UtbRJsQpO9fPUMq3qW5Ny2kW
   tjcVpnNoUozbmxvFahnL/sODGVBumkE1gJUbMD5q0FhgC5n6bviNFH/lB
   8qMPtO3JFsSx8VjCsSnx/g0qaZ/HRov0bNJu6sTeP5trSHpRCHuRXW5Ey
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="306580530"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="306580530"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113254"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113254"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:31 -0700
Subject: [PATCH v3 06/25] fsdax: Validate DAX layouts broken before truncate
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>, nvdimm@lists.linux.dev,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:31 -0700
Message-ID: <166579185112.2236710.17571345510304035858.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that iput_final() arranges for dax_break_layouts(), all
truncate_inode_pages() paths in the kernel ensure that no DAX pages
hosted by that inode are in use. Add warnings to assert the new entry
state transitions.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index e3deb60a792f..1d4f0072e58d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -401,13 +401,15 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(trunc && !dax_page_idle(page));
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
 			if (page->index-- > 0)
 				continue;
-		} else
+		} else {
+			WARN_ON_ONCE(trunc && !dax_is_zapped(entry));
+			WARN_ON_ONCE(trunc && !dax_page_idle(page));
 			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
+		}
 		page->mapping = NULL;
 		page->index = 0;
 	}

