Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295E85C19A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfGARC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfGARC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnUVJ089802;
        Mon, 1 Jul 2019 17:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VIejqG2igV29HgNnbLiNUbmRMclPGOOlhHFwq2631xU=;
 b=CMivQU5Y66rdg4Iwws31MGG95mJNUve+GjDmtEjK0ZvacRdKFl/dROLEvapHqivjscby
 8VHPgWgseeCNMW/l1MlkBYM7tVR7vGpk/G+MDigfdWYoh12Xqc5X25ZdXLkApdx9ql1m
 RiyUeoK6iklGKKYIK8uBMZkiPOXfPK3GmZvUphej7CgIA9ogS1pSC5ao0tSfysX4SRxj
 d5SSurrI7XxtZnwq3HxuZ48VLoAFzA/AIGF0x1rhSf/ziSkv2hRBMeFKLFDXyfYN3Zdu
 Z5OJn1YWvINaHanBPRCRpsXbxSzDkHsdbOmeOizgrgeWm1NqZcY0WgtBihf0I8rmTwth /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbevfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmLRb154033;
        Mon, 1 Jul 2019 17:02:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tebqg1gw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H2Lfv030281;
        Mon, 1 Jul 2019 17:02:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:20 -0700
Subject: [PATCH 03/11] iomap: move the file mapping reporting code into a
 separate file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:19 -0700
Message-ID: <156200053964.1790352.14719190843587972058.stgit@magnolia>
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

Move the file mapping reporting code (FIEMAP/FIBMAP) into a separate
file so that we can group related functions in a single file instead of
having a single enormous source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c        |  136 -------------------------------------------------
 fs/iomap/Makefile |    3 +
 fs/iomap/fiemap.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 136 deletions(-)
 create mode 100644 fs/iomap/fiemap.c


diff --git a/fs/iomap.c b/fs/iomap.c
index b0887e94d4ce..21a1300fc5b8 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1145,108 +1145,6 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-struct fiemap_ctx {
-	struct fiemap_extent_info *fi;
-	struct iomap prev;
-};
-
-static int iomap_to_fiemap(struct fiemap_extent_info *fi,
-		struct iomap *iomap, u32 flags)
-{
-	switch (iomap->type) {
-	case IOMAP_HOLE:
-		/* skip holes */
-		return 0;
-	case IOMAP_DELALLOC:
-		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
-		break;
-	case IOMAP_MAPPED:
-		break;
-	case IOMAP_UNWRITTEN:
-		flags |= FIEMAP_EXTENT_UNWRITTEN;
-		break;
-	case IOMAP_INLINE:
-		flags |= FIEMAP_EXTENT_DATA_INLINE;
-		break;
-	}
-
-	if (iomap->flags & IOMAP_F_MERGED)
-		flags |= FIEMAP_EXTENT_MERGED;
-	if (iomap->flags & IOMAP_F_SHARED)
-		flags |= FIEMAP_EXTENT_SHARED;
-
-	return fiemap_fill_next_extent(fi, iomap->offset,
-			iomap->addr != IOMAP_NULL_ADDR ? iomap->addr : 0,
-			iomap->length, flags);
-}
-
-static loff_t
-iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap)
-{
-	struct fiemap_ctx *ctx = data;
-	loff_t ret = length;
-
-	if (iomap->type == IOMAP_HOLE)
-		return length;
-
-	ret = iomap_to_fiemap(ctx->fi, &ctx->prev, 0);
-	ctx->prev = *iomap;
-	switch (ret) {
-	case 0:		/* success */
-		return length;
-	case 1:		/* extent array full */
-		return 0;
-	default:
-		return ret;
-	}
-}
-
-int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
-		loff_t start, loff_t len, const struct iomap_ops *ops)
-{
-	struct fiemap_ctx ctx;
-	loff_t ret;
-
-	memset(&ctx, 0, sizeof(ctx));
-	ctx.fi = fi;
-	ctx.prev.type = IOMAP_HOLE;
-
-	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC);
-	if (ret)
-		return ret;
-
-	if (fi->fi_flags & FIEMAP_FLAG_SYNC) {
-		ret = filemap_write_and_wait(inode->i_mapping);
-		if (ret)
-			return ret;
-	}
-
-	while (len > 0) {
-		ret = iomap_apply(inode, start, len, IOMAP_REPORT, ops, &ctx,
-				iomap_fiemap_actor);
-		/* inode with no (attribute) mapping will give ENOENT */
-		if (ret == -ENOENT)
-			break;
-		if (ret < 0)
-			return ret;
-		if (ret == 0)
-			break;
-
-		start += ret;
-		len -= ret;
-	}
-
-	if (ctx.prev.type != IOMAP_HOLE) {
-		ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iomap_fiemap);
-
 /*
  * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
  * Returns true if found and updates @lastoff to the offset in file.
@@ -2001,37 +1899,3 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
-
-static loff_t
-iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap)
-{
-	sector_t *bno = data, addr;
-
-	if (iomap->type == IOMAP_MAPPED) {
-		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
-		if (addr > INT_MAX)
-			WARN(1, "would truncate bmap result\n");
-		else
-			*bno = addr;
-	}
-	return 0;
-}
-
-/* legacy ->bmap interface.  0 is the error return (!) */
-sector_t
-iomap_bmap(struct address_space *mapping, sector_t bno,
-		const struct iomap_ops *ops)
-{
-	struct inode *inode = mapping->host;
-	loff_t pos = bno << inode->i_blkbits;
-	unsigned blocksize = i_blocksize(inode);
-
-	if (filemap_write_and_wait(mapping))
-		return 0;
-
-	bno = 0;
-	iomap_apply(inode, pos, blocksize, 0, ops, &bno, iomap_bmap_actor);
-	return bno;
-}
-EXPORT_SYMBOL_GPL(iomap_bmap);
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index e38061f2b901..861c07137792 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -8,4 +8,7 @@ ccflags-y += -I $(srctree)/$(src)/..
 
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
+iomap-y				+= \
+					fiemap.o
+
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
new file mode 100644
index 000000000000..42ed9ef56699
--- /dev/null
+++ b/fs/iomap/fiemap.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+
+#include "internal.h"
+
+struct fiemap_ctx {
+	struct fiemap_extent_info *fi;
+	struct iomap prev;
+};
+
+static int iomap_to_fiemap(struct fiemap_extent_info *fi,
+		struct iomap *iomap, u32 flags)
+{
+	switch (iomap->type) {
+	case IOMAP_HOLE:
+		/* skip holes */
+		return 0;
+	case IOMAP_DELALLOC:
+		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
+		break;
+	case IOMAP_MAPPED:
+		break;
+	case IOMAP_UNWRITTEN:
+		flags |= FIEMAP_EXTENT_UNWRITTEN;
+		break;
+	case IOMAP_INLINE:
+		flags |= FIEMAP_EXTENT_DATA_INLINE;
+		break;
+	}
+
+	if (iomap->flags & IOMAP_F_MERGED)
+		flags |= FIEMAP_EXTENT_MERGED;
+	if (iomap->flags & IOMAP_F_SHARED)
+		flags |= FIEMAP_EXTENT_SHARED;
+
+	return fiemap_fill_next_extent(fi, iomap->offset,
+			iomap->addr != IOMAP_NULL_ADDR ? iomap->addr : 0,
+			iomap->length, flags);
+}
+
+static loff_t
+iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
+		struct iomap *iomap)
+{
+	struct fiemap_ctx *ctx = data;
+	loff_t ret = length;
+
+	if (iomap->type == IOMAP_HOLE)
+		return length;
+
+	ret = iomap_to_fiemap(ctx->fi, &ctx->prev, 0);
+	ctx->prev = *iomap;
+	switch (ret) {
+	case 0:		/* success */
+		return length;
+	case 1:		/* extent array full */
+		return 0;
+	default:
+		return ret;
+	}
+}
+
+int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
+		loff_t start, loff_t len, const struct iomap_ops *ops)
+{
+	struct fiemap_ctx ctx;
+	loff_t ret;
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.fi = fi;
+	ctx.prev.type = IOMAP_HOLE;
+
+	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC);
+	if (ret)
+		return ret;
+
+	if (fi->fi_flags & FIEMAP_FLAG_SYNC) {
+		ret = filemap_write_and_wait(inode->i_mapping);
+		if (ret)
+			return ret;
+	}
+
+	while (len > 0) {
+		ret = iomap_apply(inode, start, len, IOMAP_REPORT, ops, &ctx,
+				iomap_fiemap_actor);
+		/* inode with no (attribute) mapping will give ENOENT */
+		if (ret == -ENOENT)
+			break;
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			break;
+
+		start += ret;
+		len -= ret;
+	}
+
+	if (ctx.prev.type != IOMAP_HOLE) {
+		ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_fiemap);
+
+static loff_t
+iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
+		void *data, struct iomap *iomap)
+{
+	sector_t *bno = data, addr;
+
+	if (iomap->type == IOMAP_MAPPED) {
+		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
+		if (addr > INT_MAX)
+			WARN(1, "would truncate bmap result\n");
+		else
+			*bno = addr;
+	}
+	return 0;
+}
+
+/* legacy ->bmap interface.  0 is the error return (!) */
+sector_t
+iomap_bmap(struct address_space *mapping, sector_t bno,
+		const struct iomap_ops *ops)
+{
+	struct inode *inode = mapping->host;
+	loff_t pos = bno << inode->i_blkbits;
+	unsigned blocksize = i_blocksize(inode);
+
+	if (filemap_write_and_wait(mapping))
+		return 0;
+
+	bno = 0;
+	iomap_apply(inode, pos, blocksize, 0, ops, &bno, iomap_bmap_actor);
+	return bno;
+}
+EXPORT_SYMBOL_GPL(iomap_bmap);

