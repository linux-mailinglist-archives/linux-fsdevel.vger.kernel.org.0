Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8C47F735
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhLZOfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 09:35:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18864 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233756AbhLZOfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:35:15 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A5dJFNqMnbhxAUJ7vrR3OlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQWw025w1TVUnTAXXjyDM6yLNmPwf94ladvg9xtVvsSEm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79CAmj//QH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQXpeGccSfj2SCU5wicG5f2+N1iBV83MaUW4OFyBnt?=
 =?us-ascii?q?E9OBeIzcIBjiDjOKewbS1UOBgi80vas7xM+s3tnhmizOfEvciRZHKRr7i5NlE0?=
 =?us-ascii?q?TN2jcdLdd7SZdUebzVHbxnaZRBLfFANB/oWmOaum2m6djhwq0ycrqlx5HLcpCR?=
 =?us-ascii?q?3zrTsNd/9ft2RWd4Tmkeeu3KA82nnajkYPdqSjzGF71qrnObEmS69U4UXfJW89?=
 =?us-ascii?q?/h3kBid3WAeFhASfUW0rOP/iUOkXd9bbUsO9UIGqak06VzuTdTnWRC8iGCLswR?=
 =?us-ascii?q?aWNdKFeA+rgaXxcL85wefG3hBXjBaQMIpudVwRjEw0FKN2dTzClRSXBe9IZ6G3?=
 =?us-ascii?q?u7M62rsZm5OdilfDRLohDAtu7HLyLzfRDqSJjq7LJOIsw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdRTF867TYaIeGrGX2APXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635177600"; 
   d="scan'208";a="119563874"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Dec 2021 22:35:10 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B3C114D146F3;
        Sun, 26 Dec 2021 22:35:07 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:35:08 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Dec 2021 22:35:05 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 09/10] xfs: Implement ->notify_failure() for XFS
Date:   Sun, 26 Dec 2021 22:34:38 +0800
Message-ID: <20211226143439.3985960-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B3C114D146F3.A146E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce xfs_notify_failure.c to handle failure related works, such as
implement ->notify_failure(), register/unregister dax holder in xfs, and
so on.

If the rmap feature of XFS enabled, we can query it to find files and
metadata which are associated with the corrupt data.  For now all we do
is kill processes with that file mapped into their address spaces, but
future patches could actually do something about corrupt metadata.

After that, the memory failure needs to notify the processes who are
using those files.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/Makefile             |   1 +
 fs/xfs/xfs_buf.c            |  15 +++
 fs/xfs/xfs_fsops.c          |   3 +
 fs/xfs/xfs_mount.h          |   1 +
 fs/xfs/xfs_notify_failure.c | 189 ++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.h |  10 ++
 6 files changed, 219 insertions(+)
 create mode 100644 fs/xfs/xfs_notify_failure.c
 create mode 100644 fs/xfs/xfs_notify_failure.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 04611a1068b4..389970b3e13b 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -84,6 +84,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_message.o \
 				   xfs_mount.o \
 				   xfs_mru_cache.o \
+				   xfs_notify_failure.o \
 				   xfs_pwork.o \
 				   xfs_reflink.o \
 				   xfs_stats.o \
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index bbb0fbd34e64..d0df7604fa9e 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -19,6 +19,7 @@
 #include "xfs_errortag.h"
 #include "xfs_error.h"
 #include "xfs_ag.h"
+#include "xfs_notify_failure.h"
 
 static struct kmem_cache *xfs_buf_cache;
 
@@ -1892,6 +1893,8 @@ xfs_free_buftarg(
 	list_lru_destroy(&btp->bt_lru);
 
 	blkdev_issue_flush(btp->bt_bdev);
+	if (btp->bt_daxdev)
+		dax_unregister_holder(btp->bt_daxdev);
 	fs_put_dax(btp->bt_daxdev);
 
 	kmem_free(btp);
@@ -1946,6 +1949,18 @@ xfs_alloc_buftarg(
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
 	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
+	if (btp->bt_daxdev) {
+		dax_write_lock(btp->bt_daxdev);
+		if (dax_get_holder(btp->bt_daxdev)) {
+			dax_write_unlock(btp->bt_daxdev);
+			xfs_err(mp, "DAX device already in use?!");
+			goto error_free;
+		}
+
+		dax_register_holder(btp->bt_daxdev, mp,
+				&xfs_dax_holder_operations);
+		dax_write_unlock(btp->bt_daxdev);
+	}
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 33e26690a8c4..d4d36c5bef11 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -542,6 +542,9 @@ xfs_do_force_shutdown(
 	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
 		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
 		why = "Corruption of in-memory data";
+	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
+		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
+		why = "Corruption of on-disk metadata";
 	} else {
 		tag = XFS_PTAG_SHUTDOWN_IOERROR;
 		why = "Metadata I/O Error";
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 00720a02e761..47ff4ac53c4c 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
 #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
 #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
+#define SHUTDOWN_CORRUPT_ONDISK	0x0010  /* corrupt metadata on device */
 
 #define XFS_SHUTDOWN_STRINGS \
 	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
new file mode 100644
index 000000000000..a87bd08365f4
--- /dev/null
+++ b/fs/xfs/xfs_notify_failure.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
+ */
+
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_alloc.h"
+#include "xfs_bit.h"
+#include "xfs_btree.h"
+#include "xfs_inode.h"
+#include "xfs_icache.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtalloc.h"
+#include "xfs_trans.h"
+
+#include <linux/mm.h>
+#include <linux/dax.h>
+
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
+		/* TODO check and try to fix metadata */
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
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
+	/* TODO try to fix data */
+	xfs_irele(ip);
+
+	return error;
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
+	struct xfs_mount	*mp = dax_get_holder(dax_dev);
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
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+		return -EFSCORRUPTED;
+	}
+
+	if (!xfs_has_rmapbt(mp)) {
+		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
+		return -EOPNOTSUPP;
+	}
+
+	offset -= mp->m_ddev_targp->bt_dax_part_off;
+	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
+			mf_flags);
+}
+
+const struct dax_holder_operations xfs_dax_holder_operations = {
+	.notify_failure		= xfs_dax_notify_failure,
+};
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
new file mode 100644
index 000000000000..f40cb315e7ce
--- /dev/null
+++ b/fs/xfs/xfs_notify_failure.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
+ */
+#ifndef __XFS_NOTIFY_FAILURE_H__
+#define __XFS_NOTIFY_FAILURE_H__
+
+extern const struct dax_holder_operations xfs_dax_holder_operations;
+
+#endif  /* __XFS_NOTIFY_FAILURE_H__ */
-- 
2.34.1



