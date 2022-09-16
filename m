Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920D35BA538
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIPDfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIPDfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:35:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7846766F;
        Thu, 15 Sep 2022 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299322; x=1694835322;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09smizwI4GSJLiX2SQxDnF1gC8wYEWwvB8zT8M3pE8M=;
  b=ALRJa740N8oIKKi6rgQ3AAxzXSpOdduIWifehDoHQBhZAEEjT1qfuRDt
   mrBXp20ssWqwVeIE0vj285fonMzHX0EHrnnnjtC5pj1HVOtmuqy4czNlJ
   UDal7VO4ptHynOBI7lEglaQzoSz+FDaU03KVRMywf4Fy0jjv4Jn4PSt4l
   YNMZVt1rYdX6fdyI8NjjCfsgyb5t1gG1dx80OhgCXRexrDpoj6hSijMEW
   iPsvNrPyI20y7sTe5k7/V9tfWwVdZvmSfSWURkOq2C2VbN4Ja97BNX7KD
   2JoBH6GR6Mj6ISoK3cXEpUoX3iMYf9k3lLeV+hwsJ1BuHRPfLJ5ClRRYW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="278630752"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="278630752"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:35:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="792961772"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:35:21 -0700
Subject: [PATCH v2 02/18] fsdax: Use dax_page_idle() to document DAX busy
 page checking
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
Date:   Thu, 15 Sep 2022 20:35:21 -0700
Message-ID: <166329932151.2786261.15762187070104795379.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
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

