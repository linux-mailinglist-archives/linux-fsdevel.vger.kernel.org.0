Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175FA5FF73C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJNX5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJNX5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:57:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7346A3AB0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791835; x=1697327835;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6sp/aip8YX3p0mDPRXhTTeKlVhlMlg1fVCnBOk4kgao=;
  b=ampZ1icRQ7gyXSInvuVS3Vo2xJ1NZrT0T+PXZcgUxs2ILrze2cZv7OuF
   gWVXKNDaRC3TjWT+7TDbJj+QHMyYkXtsTFSbyGZNRrAOLEDzIer34uM/Y
   PH1YWqxI8uEyWDJo0e2C2LQ7NCCd4lo02xc9Xt7T9gQjAh09xhZ+qx3YR
   d1IG7G3uabrC5t9FR2+wkKOiUKsKTy3R/wQctUzVi7ZI0y47C0eBqSil4
   KFwX7kJGADdYYYzIOPs6D0fSsbB+l1XQlcv6AIyF6pw0+eIGc2jdJjPRu
   /ui02uq6AATOhERQtHlJpCqapoqGvTl93xxTLDjBShG1TWEkIIymzIAiu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304236540"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304236540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="658759517"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="658759517"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:08 -0700
Subject: [PATCH v3 02/25] fsdax: Use dax_page_idle() to document DAX busy
 page checking
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:08 -0700
Message-ID: <166579182839.2236710.16461867548859813784.stgit@dwillia2-xfh.jf.intel.com>
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

In advance of converting DAX pages to be 0-based, use a new
dax_page_idle() helper to both simplify that future conversion, but also
document all the kernel locations that are watching for DAX page idle
events.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c            |    4 ++--
 fs/ext4/inode.c     |    3 +--
 fs/fuse/dax.c       |    5 ++---
 fs/xfs/xfs_file.c   |    5 ++---
 include/linux/dax.h |    9 +++++++++
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c440dcef4b1b..e762b9c04fb4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -395,7 +395,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
+		WARN_ON_ONCE(trunc && !dax_page_idle(page));
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
 			if (page->index-- > 0)
@@ -414,7 +414,7 @@ static struct page *dax_busy_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (page_ref_count(page) > 1)
+		if (!dax_page_idle(page))
 			return page;
 	}
 	return NULL;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b028a4413bea..478ec6bc0935 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3961,8 +3961,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(page,
-					  atomic_read(&page->_refcount) == 1,
+		error = ___wait_var_event(page, dax_page_idle(page),
 					  TASK_INTERRUPTIBLE, 0, 0,
 					  ext4_wait_dax_page(inode));
 	} while (error == 0);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 4e12108c68af..ae52ef7dbabe 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,8 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(page, atomic_read(&page->_refcount) == 1,
-				 TASK_INTERRUPTIBLE, 0, 0,
-				 fuse_wait_dax_page(inode));
+	return ___wait_var_event(page, dax_page_idle(page), TASK_INTERRUPTIBLE,
+				 0, 0, fuse_wait_dax_page(inode));
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 73e7b7ec0a4c..556e28d06788 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -827,9 +827,8 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(page, atomic_read(&page->_refcount) == 1,
-				 TASK_INTERRUPTIBLE, 0, 0,
-				 xfs_wait_dax_page(inode));
+	return ___wait_var_event(page, dax_page_idle(page), TASK_INTERRUPTIBLE,
+				 0, 0, xfs_wait_dax_page(inode));
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ba985333e26b..04987d14d7e0 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -210,6 +210,15 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+/*
+ * Document all the code locations that want know when a dax page is
+ * unreferenced.
+ */
+static inline bool dax_page_idle(struct page *page)
+{
+	return page_ref_count(page) == 1;
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);

