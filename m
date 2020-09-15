Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8226A2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIOKNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 06:13:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32367 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgIOKNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:13:33 -0400
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="99252005"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Sep 2020 18:13:19 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A34B748990EB;
        Tue, 15 Sep 2020 18:13:15 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Sep 2020 18:13:14 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Sep 2020 18:13:13 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <darrick.wong@oracle.com>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 1/4] fs: introduce ->storage_lost() for memory-failure
Date:   Tue, 15 Sep 2020 18:13:08 +0800
Message-ID: <20200915101311.144269-2-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
References: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A34B748990EB.ABBA3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is used to handle errors which may cause data lost in
filesystem.  Such as memory-failure in fsdax mode.

In XFS, it requires "rmapbt" feature in order to query for files or
metadata which associated to the error block.  Then we could call fs
recover functions to try to repair the damaged data.(did not implemented
in this patch)

After that, the memory-failure also needs to kill processes who are
using those files.  The struct mf_recover_controller is created to store
necessary parameters.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_super.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 include/linux/mm.h |  6 ++++
 3 files changed, 87 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 71ac6c1cdc36..118d9c5d9e1e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -35,6 +35,10 @@
 #include "xfs_refcount_item.h"
 #include "xfs_bmap_item.h"
 #include "xfs_reflink.h"
+#include "xfs_alloc.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_bit.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -1104,6 +1108,81 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+static int
+xfs_storage_lost_helper(
+	struct xfs_btree_cur		*cur,
+	struct xfs_rmap_irec		*rec,
+	void				*priv)
+{
+	struct xfs_inode		*ip;
+	struct mf_recover_controller	*mfrc = priv;
+	int				rc = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {
+		// TODO check and try to fix metadata
+	} else {
+		/*
+		 * Get files that incore, filter out others that are not in use.
+		 */
+		xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
+			 0, &ip);
+		if (!ip)
+			return 0;
+		if (!VFS_I(ip)->i_mapping)
+			goto out;
+
+		rc = mfrc->recover_fn(mfrc->pfn, mfrc->flags,
+				      VFS_I(ip)->i_mapping, rec->rm_offset);
+
+		// TODO try to fix data
+out:
+		xfs_irele(ip);
+	}
+
+	return rc;
+}
+
+static int
+xfs_fs_storage_lost(
+	struct super_block	*sb,
+	loff_t			offset,
+	void			*priv)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_rmap_irec	rmap_low, rmap_high;
+	struct xfs_buf		*agf_bp = NULL;
+	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
+	int			error = 0;
+
+	error = xfs_trans_alloc_empty(mp, &tp);
+	if (error)
+		return error;
+
+	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+	if (error)
+		return error;
+
+	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
+
+	/* Construct a range for rmap query */
+	memset(&rmap_low, 0, sizeof(rmap_low));
+	memset(&rmap_high, 0xFF, sizeof(rmap_high));
+	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
+
+	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
+				     xfs_storage_lost_helper, priv);
+	if (error == -ECANCELED)
+		error = 0;
+
+	xfs_btree_del_cursor(cur, error);
+	xfs_trans_brelse(tp, agf_bp);
+	return error;
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1117,6 +1196,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
+	.storage_lost		= xfs_fs_storage_lost,
 };
 
 static int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347..bd90485cfdc9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1951,6 +1951,7 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	int (*storage_lost)(struct super_block *sb, loff_t offset, void *priv);
 };
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1983e08f5906..3f0c36e1bf3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3002,6 +3002,12 @@ extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 
+struct mf_recover_controller {
+	int (*recover_fn)(unsigned long pfn, int flags,
+		struct address_space *mapping, pgoff_t index);
+	unsigned long pfn;
+	int flags;
+};
 
 /*
  * Error handlers for various types of pages.
-- 
2.28.0



