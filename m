Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167C23EDD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHGNNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:13:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10729 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726061AbgHGNNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:13:48 -0400
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800"; 
   d="scan'208";a="97774910"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 364964CE34EF;
        Fri,  7 Aug 2020 21:13:37 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:39 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:37 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 1/8] fs: introduce get_shared_files() for dax&reflink
Date:   Fri, 7 Aug 2020 21:13:29 +0800
Message-ID: <20200807131336.318774-2-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 364964CE34EF.ADD3D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Under the mode of both dax and reflink on, one page may be shared by
multiple files and offsets.  In order to track them in memory-failure or
other cases, we introduce this function by finding out who is sharing
this block(the page) in a filesystem.  It returns a list that contains
all the owners, and the offset in each owner.

For XFS, rmapbt is used to find out the owners of one block.  So, it
should be turned on when we want to use dax&reflink feature together.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_super.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h |  7 +++++
 include/linux/fs.h  |  2 ++
 3 files changed, 76 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 379cbff438bc..b71392219c91 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -35,6 +35,9 @@
 #include "xfs_refcount_item.h"
 #include "xfs_bmap_item.h"
 #include "xfs_reflink.h"
+#include "xfs_alloc.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -1097,6 +1100,69 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+static int _get_shared_files_fn(
+	struct xfs_btree_cur	*cur,
+	struct xfs_rmap_irec	*rec,
+	void			*priv)
+{
+	struct list_head	*list = priv;
+	struct xfs_inode	*ip;
+	struct shared_files	*sfp;
+
+	/* Get files that incore, filter out others that are not in use. */
+	xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE, 0, &ip);
+	if (ip && !ip->i_vnode.i_mapping)
+		return 0;
+
+	sfp = kmalloc(sizeof(*sfp), GFP_KERNEL);
+	sfp->mapping = ip->i_vnode.i_mapping;
+	sfp->index = rec->rm_offset;
+	list_add_tail(&sfp->list, list);
+
+	return 0;
+}
+
+static int
+xfs_fs_get_shared_files(
+	struct super_block	*sb,
+	pgoff_t			offset,
+	struct list_head	*list)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_rmap_irec	rmap_low = { 0 }, rmap_high = { 0 };
+	struct xfs_buf		*agf_bp = NULL;
+	xfs_agblock_t		bno = XFS_B_TO_FSB(mp, offset);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, bno);
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
+	memset(&cur->bc_rec, 0, sizeof(cur->bc_rec));
+	/* Construct the range for one rmap search */
+	memset(&rmap_low, 0, sizeof(rmap_low));
+	memset(&rmap_high, 0xFF, sizeof(rmap_high));
+	rmap_low.rm_startblock = rmap_high.rm_startblock = bno;
+
+	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
+				     _get_shared_files_fn, list);
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
@@ -1110,6 +1176,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
+	.get_shared_files	= xfs_fs_get_shared_files,
 };
 
 static int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..0a85e321d6b4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -40,6 +40,13 @@ struct dax_operations {
 
 extern struct attribute_group dax_attribute_group;
 
+struct shared_files {
+	struct list_head	list;
+	struct address_space	*mapping;
+	pgoff_t			index;
+	dax_entry_t		cookie;
+};
+
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *dax_get_by_host(const char *host);
 struct dax_device *alloc_dax(void *private, const char *host,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..81de3d2739b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1977,6 +1977,8 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	int (*get_shared_files)(struct super_block *sb, pgoff_t offset,
+				struct list_head *list);
 };
 
 /*
-- 
2.27.0



