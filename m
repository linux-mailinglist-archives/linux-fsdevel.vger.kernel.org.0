Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD27A3E988B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhHKTSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 15:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKTSu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:18:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DEAA60EB9;
        Wed, 11 Aug 2021 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628709506;
        bh=UdgfDXXujrxmL4idohc3c8tjVe5qH4DuaJJFmReZljk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcrvppARhMk3/ieOBELNzLrP6bwuX6v0LGfsYUJ9OOg+y+jPUPgxfBSz6J2SwZBoP
         kjud+1G40MDhqwvk5vS6EzOeVT2VkL4yBAC2zYMWaYh2iqgui/mKDVBKQXbgNhburM
         ZaI7CggvvKuhT0FjWhJlE3oHyELyXXdb/tfbAfXXl8qrIl60p3leTVkn34dUdMSP1I
         AOGh+3YQEvhw9i6+k4GHfGpSssouXQcrOErxLhRq6LfkXcccmiNknS1Cx9PeQ/WUtI
         naJ3TSKa3WkfW+PrQjpgNY+quQ4PIeyZnOAmk73qqpttJ6U+5Fb71BHHBJdfDa5U+f
         fgddqM58qFo/A==
Date:   Wed, 11 Aug 2021 12:18:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH v2.1 24/30] iomap: remove iomap_apply
Message-ID: <20210811191826.GI3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-25-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

iomap_apply is unused now, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[djwong: rebase this patch to preserve git history of iomap loop control]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/apply.c      |   91 -------------------------------------------------
 fs/iomap/trace.h      |   40 ----------------------
 include/linux/iomap.h |   10 -----
 3 files changed, 141 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index e82647aef7ea..a1c7592d2ade 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -3,101 +3,10 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (c) 2016-2021 Christoph Hellwig.
  */
-#include <linux/module.h>
-#include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/iomap.h>
 #include "trace.h"
 
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
-	struct iomap iomap = { .type = IOMAP_HOLE };
-	struct iomap srcmap = { .type = IOMAP_HOLE };
-	loff_t written = 0, ret;
-	u64 end;
-
-	trace_iomap_apply(inode, pos, length, flags, ops, actor, _RET_IP_);
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
-	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
-	if (ret)
-		return ret;
-	if (WARN_ON(iomap.offset > pos)) {
-		written = -EIO;
-		goto out;
-	}
-	if (WARN_ON(iomap.length == 0)) {
-		written = -EIO;
-		goto out;
-	}
-
-	trace_iomap_apply_dstmap(inode, &iomap);
-	if (srcmap.type != IOMAP_HOLE)
-		trace_iomap_apply_srcmap(inode, &srcmap);
-
-	/*
-	 * Cut down the length to the one actually provided by the filesystem,
-	 * as it might not be able to give us the whole size that we requested.
-	 */
-	end = iomap.offset + iomap.length;
-	if (srcmap.type != IOMAP_HOLE)
-		end = min(end, srcmap.offset + srcmap.length);
-	if (pos + length > end)
-		length = end - pos;
-
-	/*
-	 * Now that we have guaranteed that the space allocation will succeed,
-	 * we can do the copy-in page by page without having to worry about
-	 * failures exposing transient data.
-	 *
-	 * To support COW operations, we read in data for partially blocks from
-	 * the srcmap if the file system filled it in.  In that case we the
-	 * length needs to be limited to the earlier of the ends of the iomaps.
-	 * If the file system did not provide a srcmap we pass in the normal
-	 * iomap into the actors so that they don't need to have special
-	 * handling for the two cases.
-	 */
-	written = actor(inode, pos, length, data, &iomap,
-			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
-
-out:
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
 static inline int iomap_iter_advance(struct iomap_iter *iter)
 {
 	/* handle the previous iteration (if any) */
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 1012d7af6b68..f1519f9a1403 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -138,49 +138,9 @@ DECLARE_EVENT_CLASS(iomap_class,
 DEFINE_EVENT(iomap_class, name,	\
 	TP_PROTO(struct inode *inode, struct iomap *iomap), \
 	TP_ARGS(inode, iomap))
-DEFINE_IOMAP_EVENT(iomap_apply_dstmap);
-DEFINE_IOMAP_EVENT(iomap_apply_srcmap);
 DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
 DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
 
-TRACE_EVENT(iomap_apply,
-	TP_PROTO(struct inode *inode, loff_t pos, loff_t length,
-		unsigned int flags, const void *ops, void *actor,
-		unsigned long caller),
-	TP_ARGS(inode, pos, length, flags, ops, actor, caller),
-	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(u64, ino)
-		__field(loff_t, pos)
-		__field(loff_t, length)
-		__field(unsigned int, flags)
-		__field(const void *, ops)
-		__field(void *, actor)
-		__field(unsigned long, caller)
-	),
-	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
-		__entry->ino = inode->i_ino;
-		__entry->pos = pos;
-		__entry->length = length;
-		__entry->flags = flags;
-		__entry->ops = ops;
-		__entry->actor = actor;
-		__entry->caller = caller;
-	),
-	TP_printk("dev %d:%d ino 0x%llx pos %lld length %lld flags %s (0x%x) "
-		  "ops %ps caller %pS actor %ps",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		   __entry->ino,
-		   __entry->pos,
-		   __entry->length,
-		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
-		   __entry->flags,
-		   __entry->ops,
-		   (void *)__entry->caller,
-		   __entry->actor)
-);
-
 TRACE_EVENT(iomap_iter,
 	TP_PROTO(struct iomap_iter *iter, const void *ops,
 		 unsigned long caller),
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 66e04aedd2ca..6784a8b64714 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -217,16 +217,6 @@ static inline struct iomap *iomap_iter_srcmap(struct iomap_iter *i)
 	return &i->iomap;
 }
 
-/*
- * Main iomap iterator function.
- */
-typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
-		void *data, struct iomap *iomap, struct iomap *srcmap);
-
-loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
-		unsigned flags, const struct iomap_ops *ops, void *data,
-		iomap_actor_t actor);
-
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
