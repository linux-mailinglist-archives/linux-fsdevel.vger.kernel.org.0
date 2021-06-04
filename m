Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E239AF8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFDBVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:21:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12868 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229911AbhFDBVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:21:36 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9SJqT6lOmHo+bnnG0ZR7u1pBhNHpDfLI3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV8sjzsiWE7gr5OUtQ4OxoV5PhfZqxz/JICMwqTNKftWrdyQ?=
 =?us-ascii?q?yVxeNZnOjfKlTbckWUnINgPOVbAsxD4bbLbGSS4/yU3ODBKadD/DCYytHUuc7u?=
 =?us-ascii?q?i2dqURpxa7xtqyNwCgOgGEVwQwVcbKBJb6a0145WoSa6Y3QLYoCeDnkBZeLKoN?=
 =?us-ascii?q?rGj9bIehgDbiRXkjWmvHe57qLgCRiE0lM7WzNL+70r9m/IiEjYy8yYwomG9iM?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="109209841"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jun 2021 09:19:49 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7B97E4C36A01;
        Fri,  4 Jun 2021 09:19:46 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 09:19:36 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 4 Jun 2021 09:19:35 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v4 09/10] xfs: Implement ->corrupted_range() for XFS
Date:   Fri, 4 Jun 2021 09:18:43 +0800
Message-ID: <20210604011844.1756145-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7B97E4C36A01.A2B39
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is used to handle errors which may cause data lost in
filesystem.  Such as memory failure in fsdax mode.

If the rmap feature of XFS enabled, we can query it to find files and
metadata which are associated with the corrupt data.  For now all we do
is kill processes with that file mapped into their address spaces, but
future patches could actually do something about corrupt metadata.

After that, the memory failure needs to notify the processes who are
using those files.

Only support data device.  Realtime device is not supported for now.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_fsops.c |   5 +++
 fs/xfs/xfs_mount.h |   1 +
 fs/xfs/xfs_super.c | 108 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index be9cf88d2ad7..e89ada33d8fc 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -551,6 +551,11 @@ xfs_do_force_shutdown(
 "Corruption of in-memory data detected.  Shutting down filesystem");
 		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
 			xfs_stack_trace();
+	} else if (flags & SHUTDOWN_CORRUPT_META) {
+		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
+"Corruption of on-disk metadata detected.  Shutting down filesystem");
+		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
+			xfs_stack_trace();
 	} else if (logerror) {
 		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
 			"Log I/O Error Detected. Shutting down filesystem");
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index bb67274ee23f..c62ccf3e07d0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -276,6 +276,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
 #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
 #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
+#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
 
 /*
  * Flags for xfs_mountfs
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a2dab05332ac..498edaeb8363 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -36,6 +36,11 @@
 #include "xfs_bmap_item.h"
 #include "xfs_reflink.h"
 #include "xfs_pwork.h"
+#include "xfs_alloc.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtalloc.h"
+#include "xfs_bit.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -392,6 +397,7 @@ xfs_open_devices(
 	struct block_device	*logdev = NULL, *rtdev = NULL;
 	int			error;
 
+	dax_set_holder(dax_ddev, mp->m_super, &fs_dax_holder_ops);
 	/*
 	 * Open real time and log devices - order is important.
 	 */
@@ -400,6 +406,9 @@ xfs_open_devices(
 		if (error)
 			goto out;
 		dax_logdev = fs_dax_get_by_bdev(logdev);
+		if (dax_logdev != dax_ddev)
+			dax_set_holder(dax_logdev, mp->m_super,
+				       &fs_dax_holder_ops);
 	}
 
 	if (mp->m_rtname) {
@@ -414,6 +423,7 @@ xfs_open_devices(
 			goto out_close_rtdev;
 		}
 		dax_rtdev = fs_dax_get_by_bdev(rtdev);
+		dax_set_holder(dax_rtdev, mp->m_super, &fs_dax_holder_ops);
 	}
 
 	/*
@@ -1076,6 +1086,103 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+static int
+xfs_corrupt_helper(
+	struct xfs_btree_cur		*cur,
+	struct xfs_rmap_irec		*rec,
+	void				*data)
+{
+	struct xfs_inode		*ip;
+	struct address_space		*mapping;
+	int				rc = 0;
+	int				*flags = data;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
+	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		// TODO check and try to fix metadata
+		xfs_force_shutdown(cur->bc_mp, SHUTDOWN_CORRUPT_META);
+		return -EFSCORRUPTED;
+	}
+
+	/*
+	 * Get files that incore, filter out others that are not in use.
+	 */
+	rc = xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
+			0, &ip);
+	if (rc)
+		return rc;
+
+	mapping = VFS_I(ip)->i_mapping;
+	rc = mf_dax_kill_procs(mapping, rec->rm_offset, *flags);
+
+	// TODO try to fix data
+	xfs_irele(ip);
+
+	return rc;
+}
+
+static int
+xfs_fs_corrupted_range(
+	struct super_block	*sb,
+	struct block_device	*bdev,
+	loff_t			offset,
+	size_t			len,
+	void			*data)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_rmap_irec	rmap_low, rmap_high;
+	struct xfs_buf		*agf_bp = NULL;
+	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
+	xfs_filblks_t		bcnt = XFS_B_TO_FSB(mp, len);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
+	int			error = 0;
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
+		xfs_warn(mp, "corrupted_range support not available for realtime device!");
+		return -EOPNOTSUPP;
+	}
+	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_bdev == bdev &&
+	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
+		return -EFSCORRUPTED;
+	}
+
+	if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
+		xfs_warn(mp, "corrupted_range needs rmapbt enabled!");
+		return -EOPNOTSUPP;
+	}
+
+	error = xfs_trans_alloc_empty(mp, &tp);
+	if (error)
+		return error;
+
+	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+	if (error)
+		goto out_cancel_tp;
+
+	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
+
+	/* Construct a range for rmap query */
+	memset(&rmap_low, 0, sizeof(rmap_low));
+	memset(&rmap_high, 0xFF, sizeof(rmap_high));
+	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
+	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bcnt;
+
+	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
+				     xfs_corrupt_helper, data);
+
+	xfs_btree_del_cursor(cur, error);
+	xfs_trans_brelse(tp, agf_bp);
+
+out_cancel_tp:
+	xfs_trans_cancel(tp);
+	return error;
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1089,6 +1196,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
+	.corrupted_range	= xfs_fs_corrupted_range,
 };
 
 static int
-- 
2.31.1



