Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F13E3FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhHIG3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhHIG3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:29:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA21C0613CF;
        Sun,  8 Aug 2021 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m9b6YNvsLzNONFanU6RhGrYZvY35bdAagUM7E3HgPsI=; b=aROZ8XoAPCzn836VduwppxbNuF
        BAItc06YLhnqSHJsnoCJNYquGN6CZJunqz8MJHjmLGDsxoD6CniNFtwL5wa7j2+aAAaoz9aGQrDFh
        NpfjLMgAtvaCdAY9TWo6igRfjofSiCqYEVLolz59arnO4vWwjquJcXNwt4qLVcQ2kpN38e640CmzR
        wfm0tzLBsoYnm9SZPwflS2cqBykd8RL9qyNABPJXPULlugE0BLT/gm5W8HycFo/0lEH6HjT2YrvBC
        /FtLS6nsa8efMt/+x5nOkQq0/2EH1sebyt0cwvOELiUSM8rD2wMFJOiN4onbnY4mQc6kwjZg/L+Mc
        tYvKBhvg==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyke-00AhQ0-Mq; Mon, 09 Aug 2021 06:27:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 18/30] iomap: switch iomap_fiemap to use iomap_iter
Date:   Mon,  9 Aug 2021 08:12:32 +0200
Message-Id: <20210809061244.1196573-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite the ->fiemap implementation based on iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/fiemap.c | 70 ++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index aab070df4a2175..acad09a8c188df 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2016-2018 Christoph Hellwig.
+ * Copyright (c) 2016-2021 Christoph Hellwig.
  */
 #include <linux/module.h>
 #include <linux/compiler.h>
@@ -8,13 +8,8 @@
 #include <linux/iomap.h>
 #include <linux/fiemap.h>
 
-struct fiemap_ctx {
-	struct fiemap_extent_info *fi;
-	struct iomap prev;
-};
-
 static int iomap_to_fiemap(struct fiemap_extent_info *fi,
-		struct iomap *iomap, u32 flags)
+		const struct iomap *iomap, u32 flags)
 {
 	switch (iomap->type) {
 	case IOMAP_HOLE:
@@ -43,24 +38,22 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 			iomap->length, flags);
 }
 
-static loff_t
-iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
+		struct fiemap_extent_info *fi, struct iomap *prev)
 {
-	struct fiemap_ctx *ctx = data;
-	loff_t ret = length;
+	int ret;
 
-	if (iomap->type == IOMAP_HOLE)
-		return length;
+	if (iter->iomap.type == IOMAP_HOLE)
+		return iomap_length(iter);
 
-	ret = iomap_to_fiemap(ctx->fi, &ctx->prev, 0);
-	ctx->prev = *iomap;
+	ret = iomap_to_fiemap(fi, prev, 0);
+	*prev = iter->iomap;
 	switch (ret) {
 	case 0:		/* success */
-		return length;
+		return iomap_length(iter);
 	case 1:		/* extent array full */
 		return 0;
-	default:
+	default:	/* error */
 		return ret;
 	}
 }
@@ -68,38 +61,33 @@ iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 		u64 start, u64 len, const struct iomap_ops *ops)
 {
-	struct fiemap_ctx ctx;
-	loff_t ret;
-
-	memset(&ctx, 0, sizeof(ctx));
-	ctx.fi = fi;
-	ctx.prev.type = IOMAP_HOLE;
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= start,
+		.len		= len,
+		.flags		= IOMAP_REPORT,
+	};
+	struct iomap prev = {
+		.type		= IOMAP_HOLE,
+	};
+	int ret;
 
-	ret = fiemap_prep(inode, fi, start, &len, 0);
+	ret = fiemap_prep(inode, fi, start, &iter.len, 0);
 	if (ret)
 		return ret;
 
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
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_fiemap_iter(&iter, fi, &prev);
 
-		start += ret;
-		len -= ret;
-	}
-
-	if (ctx.prev.type != IOMAP_HOLE) {
-		ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
+	if (prev.type != IOMAP_HOLE) {
+		ret = iomap_to_fiemap(fi, &prev, FIEMAP_EXTENT_LAST);
 		if (ret < 0)
 			return ret;
 	}
 
+	/* inode with no (attribute) mapping will give ENOENT */
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_fiemap);
-- 
2.30.2

