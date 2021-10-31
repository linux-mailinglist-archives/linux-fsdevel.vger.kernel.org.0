Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466BD440F0F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJaPXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:23:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24386 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230191AbhJaPXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:23:36 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AVGM1AK8Lm2L8cGzQAKDADrUD63+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp21T0PmGZMWDyDbPqCMWLxfIxxaoi29ksOvZLRmN42SldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4EfyWlTdhSMkj/jRHuGlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0Oaefybg7p3DkiUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqewLm7YuhqiN4qIMTiMMUYoH4I5T3QC7AkB4/CR6HL7NpD9?=
 =?us-ascii?q?DY2ms1KW/3ZYqIxZThwaxLPSx5CIFEaDNQ5hujArn3+dSBI7VeQjakp6mPQigt?=
 =?us-ascii?q?r39DFNsTZe9mPbcFUhVqD4GbH+XnpRB0XKrS3yzOD/zSnhvLnmjnyU4YfUra/8?=
 =?us-ascii?q?5ZChFyV23xWBgYaWEW2pdGnhUOkHdFSMUoZ/mwpt6da3EiqSMTtGh61uniJujY?=
 =?us-ascii?q?CVNdKVe438geAzuzT+QnxLmwFSCNRLcwor+coSjEwkFyEhdXkAXpoqrL9dJ433?=
 =?us-ascii?q?t94thvrYW5MczBEPnRCEGM4DxDYiNlbpnryohxLTcZZVuHIJAw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYRu4ya981CME0P2RnVRuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116677985"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:20:59 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0BC804D0F915;
        Sun, 31 Oct 2021 23:20:58 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:56 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:56 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 7/8] xfs: Implement ->notify_failure() for XFS
Date:   Sun, 31 Oct 2021 23:20:27 +0800
Message-ID: <20211031152028.3724121-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
References: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0BC804D0F915.A83D0
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c |  19 ++++
 fs/xfs/xfs_fsops.c  |   3 +
 fs/xfs/xfs_mount.h  |   1 +
 fs/xfs/xfs_super.c  | 207 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h |  18 ++++
 5 files changed, 248 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ed1b27198382..8e1cc032e7b5 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -137,6 +137,25 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 
+void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	dax_set_holder(dax_dev, holder, ops);
+}
+EXPORT_SYMBOL_GPL(fs_dax_register_holder);
+
+void fs_dax_unregister_holder(struct dax_device *dax_dev)
+{
+	dax_set_holder(dax_dev, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(fs_dax_unregister_holder);
+
+void *fs_dax_get_holder(struct dax_device *dax_dev)
+{
+	return dax_get_holder(dax_dev);
+}
+EXPORT_SYMBOL_GPL(fs_dax_get_holder);
+
 bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors)
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 33e26690a8c4..4c2d3d4ca5a5 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -542,6 +542,9 @@ xfs_do_force_shutdown(
 	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
 		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
 		why = "Corruption of in-memory data";
+	} else if (flags & SHUTDOWN_CORRUPT_META) {
+		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
+		why = "Corruption of on-disk metadata";
 	} else {
 		tag = XFS_PTAG_SHUTDOWN_IOERROR;
 		why = "Metadata I/O Error";
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e091f3b3fa15..d0f6da23e3df 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -434,6 +434,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
 #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
 #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
+#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
 
 #define XFS_SHUTDOWN_STRINGS \
 	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c4e0cd1c1c8c..364225c44c41 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -37,11 +37,19 @@
 #include "xfs_reflink.h"
 #include "xfs_pwork.h"
 #include "xfs_ag.h"
+#include "xfs_alloc.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtalloc.h"
+#include "xfs_bit.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/mm.h>
+#include <linux/dax.h>
 
+static const struct dax_holder_operations xfs_dax_holder_operations;
 static const struct super_operations xfs_super_operations;
 
 static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
@@ -377,6 +385,8 @@ xfs_close_devices(
 
 		xfs_free_buftarg(mp->m_logdev_targp);
 		xfs_blkdev_put(logdev);
+		if (dax_logdev)
+			fs_dax_unregister_holder(dax_logdev);
 		fs_put_dax(dax_logdev);
 	}
 	if (mp->m_rtdev_targp) {
@@ -385,9 +395,13 @@ xfs_close_devices(
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
 		xfs_blkdev_put(rtdev);
+		if (dax_rtdev)
+			fs_dax_unregister_holder(dax_rtdev);
 		fs_put_dax(dax_rtdev);
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
+	if (dax_ddev)
+		fs_dax_unregister_holder(dax_ddev);
 	fs_put_dax(dax_ddev);
 }
 
@@ -411,6 +425,9 @@ xfs_open_devices(
 	struct block_device	*logdev = NULL, *rtdev = NULL;
 	int			error;
 
+	if (dax_ddev)
+		fs_dax_register_holder(dax_ddev, mp,
+				&xfs_dax_holder_operations);
 	/*
 	 * Open real time and log devices - order is important.
 	 */
@@ -419,6 +436,9 @@ xfs_open_devices(
 		if (error)
 			goto out;
 		dax_logdev = fs_dax_get_by_bdev(logdev);
+		if (dax_logdev != dax_ddev && dax_logdev)
+			fs_dax_register_holder(dax_logdev, mp,
+					&xfs_dax_holder_operations);
 	}
 
 	if (mp->m_rtname) {
@@ -433,6 +453,9 @@ xfs_open_devices(
 			goto out_close_rtdev;
 		}
 		dax_rtdev = fs_dax_get_by_bdev(rtdev);
+		if (dax_rtdev)
+			fs_dax_register_holder(dax_rtdev, mp,
+					&xfs_dax_holder_operations);
 	}
 
 	/*
@@ -1110,6 +1133,190 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+struct failure_info {
+	xfs_agblock_t		startblock;
+	xfs_filblks_t		blockcount;
+	int			mf_flags;
+};
+
+static pgoff_t
+xfs_failure_pgoff(
+	struct xfs_mount		*mp,
+	const struct xfs_rmap_irec	*rec,
+	const struct failure_info	*notify)
+{
+	uint64_t pos = rec->rm_offset;
+
+	if (notify->startblock > rec->rm_startblock)
+		pos += XFS_FSB_TO_B(mp,
+				notify->startblock - rec->rm_startblock);
+	return pos >> PAGE_SHIFT;
+}
+
+static unsigned long
+xfs_failure_pgcnt(
+	struct xfs_mount		*mp,
+	const struct xfs_rmap_irec	*rec,
+	const struct failure_info	*notify)
+{
+	xfs_agblock_t start_rec = rec->rm_startblock;
+	xfs_agblock_t end_rec = rec->rm_startblock + rec->rm_blockcount;
+	xfs_agblock_t start_notify = notify->startblock;
+	xfs_agblock_t end_notify = notify->startblock + notify->blockcount;
+	xfs_agblock_t start_cross = max(start_rec, start_notify);
+	xfs_agblock_t end_cross = min(end_rec, end_notify);
+
+	return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
+}
+
+static int
+xfs_dax_failure_fn(
+	struct xfs_btree_cur		*cur,
+	const struct xfs_rmap_irec	*rec,
+	void				*data)
+{
+	struct xfs_mount		*mp = cur->bc_mp;
+	struct xfs_inode		*ip;
+	struct address_space		*mapping;
+	struct failure_info		*notify = data;
+	int				error = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
+	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		// TODO check and try to fix metadata
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
+		return -EFSCORRUPTED;
+	}
+
+	/* Get files that incore, filter out others that are not in use. */
+	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
+			 0, &ip);
+	/* Continue the rmap query if the inode isn't incore */
+	if (error == -ENODATA)
+		return 0;
+	if (error)
+		return error;
+
+	mapping = VFS_I(ip)->i_mapping;
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+		pgoff_t off = xfs_failure_pgoff(mp, rec, notify);
+		unsigned long cnt = xfs_failure_pgcnt(mp, rec, notify);
+
+		error = mf_dax_kill_procs(mapping, off, cnt, notify->mf_flags);
+	}
+	// TODO try to fix data
+	xfs_irele(ip);
+
+	return error;
+}
+
+static u64
+xfs_dax_ddev_offset(
+	struct xfs_mount	*mp,
+	struct dax_device	*dax_dev,
+	u64			disk_offset)
+{
+	struct block_device *bdev;
+
+	if (mp->m_ddev_targp->bt_daxdev == dax_dev)
+		bdev = mp->m_ddev_targp->bt_bdev;
+	else if (mp->m_logdev_targp->bt_daxdev == dax_dev)
+		bdev = mp->m_logdev_targp->bt_bdev;
+	else
+		bdev = mp->m_rtdev_targp->bt_bdev;
+
+	return disk_offset - (get_start_sect(bdev) << SECTOR_SHIFT);
+}
+
+static int
+xfs_dax_notify_ddev_failure(
+	struct xfs_mount	*mp,
+	xfs_daddr_t		daddr,
+	xfs_daddr_t		bblen,
+	int			mf_flags)
+{
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_buf		*agf_bp = NULL;
+	struct failure_info	notify = { .mf_flags = mf_flags };
+	int			error = 0;
+	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
+	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
+
+	error = xfs_trans_alloc_empty(mp, &tp);
+	if (error)
+		return error;
+
+	for (; agno <= end_agno; agno++) {
+		struct xfs_rmap_irec	ri_low = { };
+		struct xfs_rmap_irec	ri_high;
+
+		notify.startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
+		notify.blockcount = XFS_BB_TO_FSB(mp, bblen);
+
+		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+		if (error)
+			break;
+
+		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
+
+		memset(&ri_high, 0xFF, sizeof(ri_high));
+		ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
+		if (agno == end_agno)
+			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
+
+		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
+				xfs_dax_failure_fn, &notify);
+		xfs_btree_del_cursor(cur, error);
+		xfs_trans_brelse(tp, agf_bp);
+		if (error)
+			break;
+
+		fsbno = XFS_AGB_TO_FSB(mp, agno + 1, 0);
+	}
+
+	xfs_trans_cancel(tp);
+	return error;
+}
+
+static int
+xfs_dax_notify_failure(
+	struct dax_device	*dax_dev,
+	u64			offset,
+	u64			len,
+	int			mf_flags)
+{
+	struct xfs_mount	*mp = fs_dax_get_holder(dax_dev);
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
+		xfs_warn(mp,
+			 "notify_failure() not supported on realtime device!");
+		return -EOPNOTSUPP;
+	}
+
+	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
+	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
+		return -EFSCORRUPTED;
+	}
+
+	if (!xfs_has_rmapbt(mp)) {
+		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
+		return -EOPNOTSUPP;
+	}
+
+	offset = xfs_dax_ddev_offset(mp, dax_dev, offset);
+	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
+			mf_flags);
+}
+
+static const struct dax_holder_operations xfs_dax_holder_operations = {
+	.notify_failure		= xfs_dax_notify_failure,
+};
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index e652a5ae3cc0..8412ec5393e4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -145,6 +145,10 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 }
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
+void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void fs_dax_unregister_holder(struct dax_device *dax_dev);
+void *fs_dax_get_holder(struct dax_device *dax_dev);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
@@ -175,6 +179,20 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 	return NULL;
 }
 
+static inline void fs_dax_register_holder(struct dax_device *dax_dev,
+		void *holder, const struct dax_holder_operations *ops)
+{
+}
+
+static inline void fs_dax_unregister_holder(struct dax_device *dax_dev)
+{
+}
+
+static inline void *fs_dax_get_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
+
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.33.0



