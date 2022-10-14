Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC475FF740
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJNX53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJNX51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:57:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C719A2B7
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791846; x=1697327846;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyqxUkdpstu7tUvj01n9d1PqdUdnL/T7kQZf98+vfF8=;
  b=I/MbUmAis1+8aSsLtONkUj/4mAYhveAUon6RK8qXGtlMra4nD2OCnU7I
   LNw1ri6O8/1KFGAXRWfg3vLl8g2XbTSrpPPgbFlmUxwP5EAvpk0df+Q8C
   MsYHyapzSvbiu/r7qczvYegtXTGwvKOhH+if9BV5gAzHiqWrOGSmNz8B3
   j3O2EHevVwUT/2ksJrA42yl14y3ca9kTZn5uNiFwZcU/BVL1J35TBj3RV
   RAG/AQ5+yzLaSjfLy02jIP4PLElM72r9aGh9wfqV2D5fSoCCGdvdBJ7l6
   5MISwNmlF8u7DCKpHQNXYokQ/B5Sl0Yd5/zMlr1gbxnKApWtaH+b1qL7x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304236574"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304236574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="658759571"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="658759571"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:25 -0700
Subject: [PATCH v3 05/25] fsdax: Wait for pinned pages during
 truncate_inode_pages_final()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>, nvdimm@lists.linux.dev,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:25 -0700
Message-ID: <166579184544.2236710.791897642091142558.stgit@dwillia2-xfh.jf.intel.com>
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

The fsdax truncate vs page pinning solution is incomplete. The initial
solution landed in v4.17 and covered typical truncate invoked through
truncate(2) and fallocate(2), i.e. the truncate_inode_pages() called on
open files. However, that enabling left truncate_inode_pages_final(),
called after iput_final() to free the inode, unprotected. Thankfully
that v4.17 enabling also left a warning in place to fire if any truncate
is attempted while a DAX page is still pinned:

commit d2c997c0f145 ("fs, dax: use page->mapping to warn if truncate collides with a busy page")

While a lore search indicates no reports of that firing, the hole is
there nonetheless. The concern is that if/when that warning fires it
indicates a use-after-free condition whereby the filesystem has lost the
ability to arbitrate access to its storage blocks. For example, in the
worst case, DMA may be ongoing while the filesystem thinks the block is
free to be reallocated to another inode.

This patch is based on an observation from Dave that during iput_final()
there is no need to hold filesystem locks like the explicit truncate
path. The wait can occur from within dax_delete_mapping_entry() called
by truncate_folio_batch_exceptionals().

This solution trades off fixing the use-after-free with a theoretical
deadlock scenario. If the agent holding the page pin triggers inode
reclaim and that reclaim waits for the pin to drop it will deadlock. Two
observations make this approach still worth pursuing:

1/ Any existing scenarios where that happens would have triggered the
   warning referenced above which has shipped upstream for ~5 years
   without a bug report on lore.

2/ Most I/O drivers only hold page pins in their fast paths and new
   __GFP_FS allocations are unlikely in a driver fast path. I.e. if the
   deadlock triggers the likely fix would be in the offending driver, not
   new band-aids in fsdax.

So, update the DAX core to notice that the inode->i_mapping is in the
exiting state and use that as a signal that the inode is unreferenced
await page-pins to drain.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index a75d4bf541b4..e3deb60a792f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -803,13 +803,37 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	return ret;
 }
 
+/*
+ * wait indefinitely for all pins to drop, the alternative to waiting is
+ * a potential use-after-free scenario
+ */
+static void dax_break_layout(struct address_space *mapping, pgoff_t index)
+{
+	/* To do this without locks, the inode needs to be unreferenced */
+	WARN_ON(atomic_read(&mapping->host->i_count));
+	do {
+		struct page *page;
+
+		page = dax_zap_mappings_range(mapping, index << PAGE_SHIFT,
+					      (index + 1) << PAGE_SHIFT);
+		if (!page)
+			return;
+		wait_var_event(page, dax_page_idle(page));
+	} while (true);
+}
+
 /*
  * Delete DAX entry at @index from @mapping.  Wait for it
  * to be unlocked before deleting it.
  */
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 {
-	int ret = __dax_invalidate_entry(mapping, index, true);
+	int ret;
+
+	if (mapping_exiting(mapping))
+		dax_break_layout(mapping, index);
+
+	ret = __dax_invalidate_entry(mapping, index, true);
 
 	/*
 	 * This gets called from truncate / punch_hole path. As such, the caller

