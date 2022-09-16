Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF725BA563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIPDgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIPDg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:36:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1139D126;
        Thu, 15 Sep 2022 20:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299386; x=1694835386;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajaFzvrRPG16T180cU73eT4NP/l2RlRiUDdGWZj7wgU=;
  b=M7BW1+EzIhNgpVsBTrNRSxKsaN2T/mazZoEBrJxq+h5Oxk59wtKgHC4V
   uV7mKLkszUHF9dPikfeweM2+81CAq/yWd2GwEzHvLADFuKqvasA325CVf
   nFt6s1kv1MmREQpFwhQ4WK0wGXZ/Yckb9k9C7AtyOz22p3nMcEZTb6FWr
   AM2JZ89R/kREtAqLd8lis0oSzI7tBZkN/0KPlXaq9CzN5MWuZKrrDkCsu
   4k4hqj4FnMgKpNVx7BrIXDwV6dWmT/VsS+PygiUsdUYOmlHdLx5RFeHfM
   Gyeym6sGIpV86x1AtnngNrmb+V10+q7pqGoFXlwNLq4Bwb1KYV0JhqLZw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325170450"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="325170450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="679809498"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:25 -0700
Subject: [PATCH v2 13/18] dax: Prep mapping helpers for compound pages
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 15 Sep 2022 20:36:25 -0700
Message-ID: <166329938508.2786261.5544204703263725154.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for device-dax to use the same mapping machinery as
fsdax, add support for device-dax compound pages.

Presently this is handled by dax_set_mapping() which is careful to only
update page->mapping for head pages. However, it does that by looking at
properties in the 'struct dev_dax' instance associated with the page.
Switch to just checking PageHead() directly in the functions that
iterate over pages in a large mapping.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig   |    1 +
 drivers/dax/mapping.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 205e9dda8928..2eddd32c51f4 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -9,6 +9,7 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
+	depends on !FS_DAX_LIMITED
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
index 70576aa02148..5d4b9601f183 100644
--- a/drivers/dax/mapping.c
+++ b/drivers/dax/mapping.c
@@ -345,6 +345,8 @@ static vm_fault_t dax_associate_entry(void *entry,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
+		page = compound_head(page);
+
 		if (flags & DAX_COW) {
 			dax_mapping_set_cow(page);
 		} else {
@@ -353,6 +355,9 @@ static vm_fault_t dax_associate_entry(void *entry,
 			page->index = index + i++;
 			page_ref_inc(page);
 		}
+
+		if (PageHead(page))
+			break;
 	}
 
 	return 0;
@@ -372,6 +377,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 
 	for_each_mapped_pfn(entry, pfn) {
 		page = pfn_to_page(pfn);
+
+		page = compound_head(page);
+
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
 			if (page->index-- > 0)
@@ -383,6 +391,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		}
 		page->mapping = NULL;
 		page->index = 0;
+
+		if (PageHead(page))
+			break;
 	}
 
 	if (trunc && !dax_mapping_is_cow(page->mapping)) {
@@ -660,11 +671,16 @@ static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
+		page = compound_head(page);
+
 		if (zap)
 			page_ref_dec(page);
 
 		if (!ret && !dax_page_idle(page))
 			ret = page;
+
+		if (PageHead(page))
+			break;
 	}
 
 	if (zap)

