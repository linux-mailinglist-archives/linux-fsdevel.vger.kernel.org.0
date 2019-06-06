Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D793697B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 03:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfFFBp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 21:45:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:36145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfFFBp0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:45:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:45:25 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:24 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH RFC 09/10] fs/xfs: Fail truncate if pages are GUP pinned
Date:   Wed,  5 Jun 2019 18:45:42 -0700
Message-Id: <20190606014544.8339-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

If pages are actively gup pinned fail the truncate operation.  To
support an application who wishes to removing a pin upon SIGIO reception
we must change the order of breaking layout leases with respect to DAX
layout leases.

Check for a GUP pin on the page being truncated and return ETXTBSY if it
is GUP pinned.

Change the order of XFS break leased layouts and break DAX layouts.

Select EXPORT_BLOCK_OPS for FS_DAX to ensure that
xfs_break_lease_layouts() is defined for FS_DAX as well as pNFS.

Update comment for xfs_break_lease_layouts()

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/Kconfig        |  1 +
 fs/xfs/xfs_file.c |  8 ++++++--
 fs/xfs/xfs_pnfs.c | 14 +++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85..c54b0b88abbf 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -49,6 +49,7 @@ config FS_DAX
 	select DEV_PAGEMAP_OPS if (ZONE_DEVICE && !FS_DAX_LIMITED)
 	select FS_IOMAP
 	select DAX
+	select EXPORTFS_BLOCK_OPS
 	help
 	  Direct Access (DAX) can be used on memory-backed block devices.
 	  If the block device supports DAX and the filesystem supports DAX,
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 350eb5546d36..1dc61c98f7cd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -756,6 +756,9 @@ xfs_break_dax_layouts(
 	if (!page)
 		return 0;
 
+	if (page_gup_pinned(page))
+		return -ETXTBSY;
+
 	*retry = true;
 	return ___wait_var_event(&page->_refcount,
 			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
@@ -779,10 +782,11 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry, off, len);
+			error = xfs_break_leased_layouts(inode, iolock, &retry);
 			if (error || retry)
 				break;
-			/* fall through */
+			error = xfs_break_dax_layouts(inode, &retry, off, len);
+			break;
 		case BREAK_WRITE:
 			error = xfs_break_leased_layouts(inode, iolock, &retry);
 			break;
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index bde2c9f56a46..e70d24d12cbf 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -21,14 +21,14 @@
 #include "xfs_pnfs.h"
 
 /*
- * Ensure that we do not have any outstanding pNFS layouts that can be used by
- * clients to directly read from or write to this inode.  This must be called
- * before every operation that can remove blocks from the extent map.
- * Additionally we call it during the write operation, where aren't concerned
- * about exposing unallocated blocks but just want to provide basic
+ * Ensure that we do not have any outstanding pNFS or longterm GUP layouts that
+ * can be used by clients to directly read from or write to this inode.  This
+ * must be called before every operation that can remove blocks from the extent
+ * map.  Additionally we call it during the write operation, where aren't
+ * concerned about exposing unallocated blocks but just want to provide basic
  * synchronization between a local writer and pNFS clients.  mmap writes would
- * also benefit from this sort of synchronization, but due to the tricky locking
- * rules in the page fault path we don't bother.
+ * also benefit from this sort of synchronization, but due to the tricky
+ * locking rules in the page fault path we don't bother.
  */
 int
 xfs_break_leased_layouts(
-- 
2.20.1

