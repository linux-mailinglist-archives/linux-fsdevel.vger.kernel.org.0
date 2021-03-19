Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498CF34127E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 02:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhCSByD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 21:54:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41531 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233206AbhCSBxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:53:52 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9ZhpB6iJvsmtHmbHsKShAWs1jHBQXjoji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsGomlBUnd+5l8/JULMd6ZMTXOlW?=
 =?us-ascii?q?O0IOhZg7fK7DHtFib3/OwY9YoIScJDIfLqC1wSt6fHyS2ZN/pl/9Wd6qCvgo7l?=
 =?us-ascii?q?vhJQZCVncbtp4Qs8KivzKDwUeCB8CZA0FIWR66N8zlLORV0scs+5CnMZNtKzxe?=
 =?us-ascii?q?HjqZSOW347Li9iwAyPoBft07TiDiWfty10bxp/hZsk7kjJ+jaU2pme?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800"; 
   d="scan'208";a="105876746"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Mar 2021 09:53:50 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 9903D4CEA871;
        Fri, 19 Mar 2021 09:53:44 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:53:44 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 19 Mar 2021 09:53:44 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v3 10/10] fs/xfs: Add dedupe support for fsdax
Date:   Fri, 19 Mar 2021 09:52:37 +0800
Message-ID: <20210319015237.993880-11-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9903D4CEA871.A1D44
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add xfs_break_two_dax_layouts() to break layout for tow dax files.  Then
call compare range function only when files are both DAX or not.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_file.c    | 20 ++++++++++++++++++++
 fs/xfs/xfs_inode.c   |  8 +++++++-
 fs/xfs/xfs_inode.h   |  1 +
 fs/xfs/xfs_reflink.c |  5 +++--
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1987d15eab61..82467d08e3ce 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -784,6 +784,26 @@ xfs_break_dax_layouts(
 			0, 0, xfs_wait_dax_page(inode));
 }
 
+int
+xfs_break_two_dax_layouts(
+	struct inode		*src,
+	struct inode		*dest)
+{
+	int			error;
+	bool			retry = false;
+
+retry:
+	error = xfs_break_dax_layouts(src, &retry);
+	if (error || retry)
+		goto retry;
+
+	error = xfs_break_dax_layouts(dest, &retry);
+	if (error || retry)
+		goto retry;
+
+	return error;
+}
+
 int
 xfs_break_layouts(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index b7352bc4c815..c11b11e59a83 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3651,8 +3651,10 @@ xfs_ilock2_io_mmap(
 	struct xfs_inode	*ip2)
 {
 	int			ret;
+	struct inode		*inode1 = VFS_I(ip1);
+	struct inode		*inode2 = VFS_I(ip2);
 
-	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
+	ret = xfs_iolock_two_inodes_and_break_layout(inode1, inode2);
 	if (ret)
 		return ret;
 	if (ip1 == ip2)
@@ -3660,6 +3662,10 @@ xfs_ilock2_io_mmap(
 	else
 		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
 				    ip2, XFS_MMAPLOCK_EXCL);
+
+	if (IS_DAX(inode1) && IS_DAX(inode2))
+		ret = xfs_break_two_dax_layouts(inode1, inode2);
+
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eca333f5f715..9ed7a2895602 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -431,6 +431,7 @@ enum xfs_prealloc_flags {
 
 int	xfs_update_prealloc_flags(struct xfs_inode *ip,
 				  enum xfs_prealloc_flags flags);
+int	xfs_break_two_dax_layouts(struct inode *inode1, struct inode *inode2);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 73c556c2ff76..e62b00c2a0c8 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -29,6 +29,7 @@
 #include "xfs_iomap.h"
 #include "xfs_sb.h"
 #include "xfs_ag_resv.h"
+#include <linux/dax.h>
 
 /*
  * Copy on Write of Shared Blocks
@@ -1303,8 +1304,8 @@ xfs_reflink_remap_prep(
 	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
 		goto out_unlock;
 
-	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	/* Don't share DAX file data with non-DAX file. */
+	if (IS_DAX(inode_in) != IS_DAX(inode_out))
 		goto out_unlock;
 
 	if (IS_DAX(inode_in))
-- 
2.30.1



