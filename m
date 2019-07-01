Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C623F5C1AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfGARDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:03:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38492 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGARDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:03:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnU3h183985;
        Mon, 1 Jul 2019 17:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XycoibodgEBQexl740VV8wsDuKqP5Tphpcth02e9nR8=;
 b=4WtvE0AnieiNlctGLmqZ98RcEPLzMhs1tuORh0P9IlNUKnFrdkSivamzDmUr1V7TZEnT
 +MzrvhGbRpTMafKUqZIeCOrkbNqTx+ZItgg2jZmi/gRHgmycUZ4b3eKW+VkThERS+lmD
 lKLW0rJeR4UoiQvkQIbV3XholEpPHOpOMnLRYTNlyVgMJHY8PTwcTo6Jy49M7cAhgK9s
 3ifrGgjlJGDvie+rhcrH8fGp06JGwFRf43Dx7sLVfQILcaCsU4UHWHBZ+zop4qO0SogI
 sq/98OxdI61TCTtiCwLXwGKDsvE1S86YkZA0uYiYdQU6/fol2/nsjY11q4MDKZ7HZpFp 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61dxueg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:03:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmM10183133;
        Mon, 1 Jul 2019 17:03:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebktspaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:03:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H37Rd032681;
        Mon, 1 Jul 2019 17:03:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:03:06 -0700
Subject: [PATCH 10/11] iomap: move the main iteration code into a separate
 file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:03:05 -0700
Message-ID: <156200058572.1790352.7002559181117144841.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the main iteration code into a separate file so that we can group
related functions in a single file instead of having a single enormous
source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/Makefile       |    1 -
 fs/iomap.c        |   98 -----------------------------------------------------
 fs/iomap/Makefile |    1 +
 fs/iomap/iomap.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 99 deletions(-)
 delete mode 100644 fs/iomap.c
 create mode 100644 fs/iomap/iomap.c


diff --git a/fs/Makefile b/fs/Makefile
index 8e61bdf9f330..d60089fd689b 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_COREDUMP)		+= coredump.o
 obj-$(CONFIG_SYSCTL)		+= drop_caches.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
-obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 obj-y				+= iomap/
 
 obj-y				+= quota/
diff --git a/fs/iomap.c b/fs/iomap.c
deleted file mode 100644
index 885e2021b4d0..000000000000
--- a/fs/iomap.c
+++ /dev/null
@@ -1,98 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2010 Red Hat, Inc.
- * Copyright (c) 2016-2018 Christoph Hellwig.
- */
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/fs.h>
-#include <linux/iomap.h>
-#include <linux/uaccess.h>
-#include <linux/gfp.h>
-#include <linux/migrate.h>
-#include <linux/mm.h>
-#include <linux/mm_inline.h>
-#include <linux/swap.h>
-#include <linux/pagemap.h>
-#include <linux/pagevec.h>
-#include <linux/file.h>
-#include <linux/uio.h>
-#include <linux/backing-dev.h>
-#include <linux/buffer_head.h>
-#include <linux/task_io_accounting_ops.h>
-#include <linux/dax.h>
-#include <linux/sched/signal.h>
-
-#include "internal.h"
-#include "iomap/iomap_internal.h"
-
-/*
- * Execute a iomap write on a segment of the mapping that spans a
- * contiguous range of pages that have identical block mapping state.
- *
- * This avoids the need to map pages individually, do individual allocations
- * for each page and most importantly avoid the need for filesystem specific
- * locking per page. Instead, all the operations are amortised over the entire
- * range of pages. It is assumed that the filesystems will lock whatever
- * resources they require in the iomap_begin call, and release them in the
- * iomap_end call.
- */
-loff_t
-iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
-		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
-{
-	struct iomap iomap = { 0 };
-	loff_t written = 0, ret;
-
-	/*
-	 * Need to map a range from start position for length bytes. This can
-	 * span multiple pages - it is only guaranteed to return a range of a
-	 * single type of pages (e.g. all into a hole, all mapped or all
-	 * unwritten). Failure at this point has nothing to undo.
-	 *
-	 * If allocation is required for this range, reserve the space now so
-	 * that the allocation is guaranteed to succeed later on. Once we copy
-	 * the data into the page cache pages, then we cannot fail otherwise we
-	 * expose transient stale data. If the reserve fails, we can safely
-	 * back out at this point as there is nothing to undo.
-	 */
-	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
-	if (ret)
-		return ret;
-	if (WARN_ON(iomap.offset > pos))
-		return -EIO;
-	if (WARN_ON(iomap.length == 0))
-		return -EIO;
-
-	/*
-	 * Cut down the length to the one actually provided by the filesystem,
-	 * as it might not be able to give us the whole size that we requested.
-	 */
-	if (iomap.offset + iomap.length < pos + length)
-		length = iomap.offset + iomap.length - pos;
-
-	/*
-	 * Now that we have guaranteed that the space allocation will succeed.
-	 * we can do the copy-in page by page without having to worry about
-	 * failures exposing transient data.
-	 */
-	written = actor(inode, pos, length, data, &iomap);
-
-	/*
-	 * Now the data has been copied, commit the range we've copied.  This
-	 * should not fail unless the filesystem has had a fatal error.
-	 */
-	if (ops->iomap_end) {
-		ret = ops->iomap_end(inode, pos, length,
-				     written > 0 ? written : 0,
-				     flags, &iomap);
-	}
-
-	return written ? written : ret;
-}
-
-sector_t
-iomap_sector(struct iomap *iomap, loff_t pos)
-{
-	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
-}
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index c88888795e12..2c0131b83af8 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 iomap-y				+= \
 					direct-io.o \
 					fiemap.o \
+					iomap.o \
 					page.o \
 					read.o \
 					seek.o \
diff --git a/fs/iomap/iomap.c b/fs/iomap/iomap.c
new file mode 100644
index 000000000000..bdaa6d07b354
--- /dev/null
+++ b/fs/iomap/iomap.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/blkdev.h>
+
+#include "internal.h"
+#include "iomap_internal.h"
+
+/*
+ * Execute a iomap write on a segment of the mapping that spans a
+ * contiguous range of pages that have identical block mapping state.
+ *
+ * This avoids the need to map pages individually, do individual allocations
+ * for each page and most importantly avoid the need for filesystem specific
+ * locking per page. Instead, all the operations are amortised over the entire
+ * range of pages. It is assumed that the filesystems will lock whatever
+ * resources they require in the iomap_begin call, and release them in the
+ * iomap_end call.
+ */
+loff_t
+iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
+		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
+{
+	struct iomap iomap = { 0 };
+	loff_t written = 0, ret;
+
+	/*
+	 * Need to map a range from start position for length bytes. This can
+	 * span multiple pages - it is only guaranteed to return a range of a
+	 * single type of pages (e.g. all into a hole, all mapped or all
+	 * unwritten). Failure at this point has nothing to undo.
+	 *
+	 * If allocation is required for this range, reserve the space now so
+	 * that the allocation is guaranteed to succeed later on. Once we copy
+	 * the data into the page cache pages, then we cannot fail otherwise we
+	 * expose transient stale data. If the reserve fails, we can safely
+	 * back out at this point as there is nothing to undo.
+	 */
+	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
+	if (ret)
+		return ret;
+	if (WARN_ON(iomap.offset > pos))
+		return -EIO;
+	if (WARN_ON(iomap.length == 0))
+		return -EIO;
+
+	/*
+	 * Cut down the length to the one actually provided by the filesystem,
+	 * as it might not be able to give us the whole size that we requested.
+	 */
+	if (iomap.offset + iomap.length < pos + length)
+		length = iomap.offset + iomap.length - pos;
+
+	/*
+	 * Now that we have guaranteed that the space allocation will succeed.
+	 * we can do the copy-in page by page without having to worry about
+	 * failures exposing transient data.
+	 */
+	written = actor(inode, pos, length, data, &iomap);
+
+	/*
+	 * Now the data has been copied, commit the range we've copied.  This
+	 * should not fail unless the filesystem has had a fatal error.
+	 */
+	if (ops->iomap_end) {
+		ret = ops->iomap_end(inode, pos, length,
+				     written > 0 ? written : 0,
+				     flags, &iomap);
+	}
+
+	return written ? written : ret;
+}
+
+sector_t
+iomap_sector(struct iomap *iomap, loff_t pos)
+{
+	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
+}

