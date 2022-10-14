Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8895FF735
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJNX5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNX5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:57:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF19A299
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791823; x=1697327823;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QVmMXmTNKFM/iXiTwxmy31zTJO5VhS550m6cgY6v88=;
  b=Fk8jh/xb1nwSt5cmTLHLPb0bcuKVdD29VL0Vd42TW+NGSDNoO7ZXkY56
   BfY1jF4/bnCbFaGG2lO8lpYydep9WK3GRhOgvbnAi5JdQg6EZCQsS349I
   kHOiPSZJwobhTQ4mp+CQ+h9MXa1oC8l+JtyMP49+8/GSHD/MUUdcPPs4x
   Y5Dy6EJCN3+8RjzHqtgiVHZW+rZbY4k2qpHEvbZUXR4oHY9+7BTxcKtBZ
   mtc8CnErwLlRBLA9vhqhsHplNfLzB+QED9oGNPeV43H5O5ZubV+oCy3vT
   nRvs5sRS5IAtMB2IwKleQ3UpiYVfp+wHdVBP9FHq70wov2bC7maJR0Lt4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="288791260"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="288791260"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="658759494"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="658759494"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:03 -0700
Subject: [PATCH v3 01/25] fsdax: Wait on @page not @page->_refcount
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:02 -0700
Message-ID: <166579182271.2236710.15120970389485390592.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The __wait_var_event facility calculates a wait queue from a hash of the
address of the variable being passed. Use the @page argument directly as
it is less to type and is the object that is being waited upon.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext4/inode.c   |    8 ++++----
 fs/fuse/dax.c     |    6 +++---
 fs/xfs/xfs_file.c |    6 +++---
 mm/memremap.c     |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..b028a4413bea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3961,10 +3961,10 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = ___wait_var_event(page,
+					  atomic_read(&page->_refcount) == 1,
+					  TASK_INTERRUPTIBLE, 0, 0,
+					  ext4_wait_dax_page(inode));
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e23e802a8013..4e12108c68af 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,9 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return ___wait_var_event(page, atomic_read(&page->_refcount) == 1,
+				 TASK_INTERRUPTIBLE, 0, 0,
+				 fuse_wait_dax_page(inode));
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c6c80265c0b2..73e7b7ec0a4c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -827,9 +827,9 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return ___wait_var_event(page, atomic_read(&page->_refcount) == 1,
+				 TASK_INTERRUPTIBLE, 0, 0,
+				 xfs_wait_dax_page(inode));
 }
 
 int
diff --git a/mm/memremap.c b/mm/memremap.c
index 421bec3a29ee..f9287babb3ce 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -542,7 +542,7 @@ bool __put_devmap_managed_page_refs(struct page *page, int refs)
 	 * stable because nobody holds a reference on the page.
 	 */
 	if (page_ref_sub_return(page, refs) == 1)
-		wake_up_var(&page->_refcount);
+		wake_up_var(page);
 	return true;
 }
 EXPORT_SYMBOL(__put_devmap_managed_page_refs);

