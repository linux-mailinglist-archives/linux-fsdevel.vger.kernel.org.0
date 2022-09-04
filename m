Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE645AC210
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIDCRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDCQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:16:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE854E84D
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257819; x=1693793819;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRd33zR9nL8ko8mlBX12iNdK9JcdjXgX57uT6RLRguc=;
  b=bkc3vb0fZts5dQgQEiiY74MS6uotkaQdAZQIrAjDX2DI0lBVH5oc8vMN
   rEsnrQ1Rz7tzMKri17xqZa4XBRn7Pd0aOv2ktomgS2b67MIP89rH8BuWw
   JX2/FuNhs9F6/a25X1xvhdHbxP7AsL5BTuoDUF/WZrVr3iUzX3JJhU11a
   xofHxy5EEEk28KUmJZyDdp5r0ppPtRZMXdW6H3fgR5OvpXMRkBXLyFXfL
   oDraMOuFV1xl/Mhl0dejTJOX+AzHzCocNodALE5gBkpDuApPi1Wz3M3Zv
   ZupmzF3Wo0vES7OugdGwF9skfVNhFYoaABYXujCC3d8sBJVpjVRfftkAV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="276599848"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="276599848"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="590497054"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:58 -0700
Subject: [PATCH 10/13] dax: Prep dax_{associate,
 disassociate}_entry() for compound pages
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:16:58 -0700
Message-ID: <166225781800.2351842.4542681429835252305.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Switch to just checking PageHead() directly.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig   |    1 +
 drivers/dax/mapping.c |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 3ed4da3935e5..2dcc8744277d 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -10,6 +10,7 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
+	depends on !FS_DAX_LIMITED
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
index 0810af7d9503..6bd38ddba2cb 100644
--- a/drivers/dax/mapping.c
+++ b/drivers/dax/mapping.c
@@ -351,6 +351,8 @@ static vm_fault_t dax_associate_entry(void *entry,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
+		page = compound_head(page);
+
 		if (flags & DAX_COW) {
 			dax_mapping_set_cow(page);
 		} else {
@@ -358,6 +360,13 @@ static vm_fault_t dax_associate_entry(void *entry,
 			page->mapping = mapping;
 			page->index = index + i++;
 		}
+
+		/*
+		 * page->mapping and page->index are only manipulated on
+		 * head pages
+		 */
+		if (PageHead(page))
+			break;
 	}
 
 	return 0;
@@ -380,6 +389,8 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 
 	for_each_mapped_pfn(entry, pfn) {
 		page = pfn_to_page(pfn);
+		page = compound_head(page);
+
 		WARN_ON_ONCE(trunc && page_maybe_dma_pinned(page));
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
@@ -389,6 +400,13 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
 		page->mapping = NULL;
 		page->index = 0;
+
+		/*
+		 * page->mapping and page->index are only manipulated on
+		 * head pages
+		 */
+		if (PageHead(page))
+			break;
 	}
 }
 

