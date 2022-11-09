Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6615C62322B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKISQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKISQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62685264A7;
        Wed,  9 Nov 2022 10:16:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E4461C35;
        Wed,  9 Nov 2022 18:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F8C433C1;
        Wed,  9 Nov 2022 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017773;
        bh=ffalxco4vMIPr9QXpolVOaht3PDMHaKDBezZ/QCSaio=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W/beKbm9R9N8m336mL8TengcT11m9tdITy5V+51bjO3HrCMNHGQ7BFzpkmmJ1os/r
         YrIVDibZUBydpWfbQuF6NANqy+AfTmbgyG2Ks160mdM5KY025VLbdoAlcQoFk6tDSJ
         8FIfI3kLFCQ2pOK+IhxBiBXtcr06kroJVLS0ZQqAZeXYlQ6hLp6j7C48kx9br2cuGk
         4tixgCWDAhysS+ngIjyd4Q0IBPED9ojYC3OeD295o6N5WjKSY4jC6Ws4Iup0mgB9ip
         H3naeyHMMdNs2ar3Oy25d16xZj5SzAhfxziilJLakz6WR/DniKuetPkOFrl2tqK9Kw
         D6uEenV1bbzyA==
Subject: [PATCH 05/14] iomap: write iomap validity checks
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:12 -0800
Message-ID: <166801777288.3992140.7344765088146895690.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

A recent multithreaded write data corruption has been uncovered in
the iomap write code. The core of the problem is partial folio
writes can be flushed to disk while a new racing write can map it
and fill the rest of the page:

writeback			new write

allocate blocks
  blocks are unwritten
submit IO
.....
				map blocks
				iomap indicates UNWRITTEN range
				loop {
				  lock folio
				  copyin data
.....
IO completes
  runs unwritten extent conv
    blocks are marked written
				  <iomap now stale>
				  get next folio
				}

Now add memory pressure such that memory reclaim evicts the
partially written folio that has already been written to disk.

When the new write finally gets to the last partial page of the new
write, it does not find it in cache, so it instantiates a new page,
sees the iomap is unwritten, and zeros the part of the page that
it does not have data from. This overwrites the data on disk that
was originally written.

The full description of the corruption mechanism can be found here:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

To solve this problem, we need to check whether the iomap is still
valid after we lock each folio during the write. We have to do it
after we lock the page so that we don't end up with state changes
occurring while we wait for the folio to be locked.

Hence we need a mechanism to be able to check that the cached iomap
is still valid (similar to what we already do in buffered
writeback), and we need a way for ->begin_write to back out and
tell the high level iomap iterator that we need to remap the
remaining write range.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |   53 ++++++++++++++++++++++++++++++++++++++----------
 fs/iomap/iter.c        |   19 ++++++++++++++++-
 include/linux/iomap.h  |   17 +++++++++++++++
 3 files changed, 77 insertions(+), 12 deletions(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 91ee0b308e13..d3c565aa29f8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -584,8 +584,9 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 	return iomap_read_inline_data(iter, folio);
 }
 
-static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
-		size_t len, struct folio **foliop)
+static int iomap_write_begin(struct iomap_iter *iter,
+		const struct iomap_ops *ops, loff_t pos, size_t len,
+		struct folio **foliop)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -618,6 +619,27 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
 		goto out_no_page;
 	}
+
+	/*
+	 * Now we have a locked folio, before we do anything with it we need to
+	 * check that the iomap we have cached is not stale. The inode extent
+	 * mapping can change due to concurrent IO in flight (e.g.
+	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
+	 * reclaimed a previously partially written page at this index after IO
+	 * completion before this write reaches this file offset) and hence we
+	 * could do the wrong thing here (zero a page range incorrectly or fail
+	 * to zero) and corrupt data.
+	 */
+	if (ops->iomap_valid) {
+		bool iomap_valid = ops->iomap_valid(iter->inode, &iter->iomap);
+
+		if (!iomap_valid) {
+			iter->iomap.flags |= IOMAP_F_STALE;
+			status = 0;
+			goto out_unlock;
+		}
+	}
+
 	if (pos + len > folio_pos(folio) + folio_size(folio))
 		len = folio_pos(folio) + folio_size(folio) - pos;
 
@@ -727,7 +749,8 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	return ret;
 }
 
-static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
+static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
+		const struct iomap_ops *ops)
 {
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
@@ -770,9 +793,11 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, ops, pos, bytes, &folio);
 		if (unlikely(status))
 			break;
+		if (iter->iomap.flags & IOMAP_F_STALE)
+			break;
 
 		page = folio_file_page(folio, pos >> PAGE_SHIFT);
 		if (mapping_writably_mapped(mapping))
@@ -825,14 +850,15 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		iter.flags |= IOMAP_NOWAIT;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_write_iter(&iter, i);
+		iter.processed = iomap_write_iter(&iter, i, ops);
 	if (iter.pos == iocb->ki_pos)
 		return ret;
 	return iter.pos - iocb->ki_pos;
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
-static loff_t iomap_unshare_iter(struct iomap_iter *iter)
+static loff_t iomap_unshare_iter(struct iomap_iter *iter,
+		const struct iomap_ops *ops)
 {
 	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -853,9 +879,11 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct folio *folio;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, ops, pos, bytes, &folio);
 		if (unlikely(status))
 			return status;
+		if (iter->iomap.flags & IOMAP_F_STALE)
+			break;
 
 		status = iomap_write_end(iter, pos, bytes, bytes, folio);
 		if (WARN_ON_ONCE(status == 0))
@@ -886,12 +914,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 	int ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_unshare_iter(&iter);
+		iter.processed = iomap_unshare_iter(&iter, ops);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
+static loff_t iomap_zero_iter(struct iomap_iter *iter,
+		const struct iomap_ops *ops, bool *did_zero)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
@@ -908,9 +937,11 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, ops, pos, bytes, &folio);
 		if (status)
 			return status;
+		if (iter->iomap.flags & IOMAP_F_STALE)
+			break;
 
 		offset = offset_in_folio(folio, pos);
 		if (bytes > folio_size(folio) - offset)
@@ -946,7 +977,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	int ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_zero_iter(&iter, did_zero);
+		iter.processed = iomap_zero_iter(&iter, ops, did_zero);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_zero_range);
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index a1c7592d2ade..79a0614eaab7 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -7,12 +7,28 @@
 #include <linux/iomap.h>
 #include "trace.h"
 
+/*
+ * Advance to the next range we need to map.
+ *
+ * If the iomap is marked IOMAP_F_STALE, it means the existing map was not fully
+ * processed - it was aborted because the extent the iomap spanned may have been
+ * changed during the operation. In this case, the iteration behaviour is to
+ * remap the unprocessed range of the iter, and that means we may need to remap
+ * even when we've made no progress (i.e. iter->processed = 0). Hence the
+ * "finished iterating" case needs to distinguish between
+ * (processed = 0) meaning we are done and (processed = 0 && stale) meaning we
+ * need to remap the entire remaining range.
+ */
 static inline int iomap_iter_advance(struct iomap_iter *iter)
 {
+	bool stale = iter->iomap.flags & IOMAP_F_STALE;
+
 	/* handle the previous iteration (if any) */
 	if (iter->iomap.length) {
-		if (iter->processed <= 0)
+		if (iter->processed < 0)
 			return iter->processed;
+		if (!iter->processed && !stale)
+			return 0;
 		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
 			return -EIO;
 		iter->pos += iter->processed;
@@ -33,6 +49,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
 	WARN_ON_ONCE(iter->iomap.length == 0);
 	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
+	WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_STALE);
 
 	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
 	if (iter->srcmap.type != IOMAP_HOLE)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 238a03087e17..308931f0840a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -62,8 +62,13 @@ struct vm_fault;
  *
  * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
  * has changed as the result of this write operation.
+ *
+ * IOMAP_F_STALE indicates that the iomap is not valid any longer and the file
+ * range it covers needs to be remapped by the high level before the operation
+ * can proceed.
  */
 #define IOMAP_F_SIZE_CHANGED	0x100
+#define IOMAP_F_STALE		0x200
 
 /*
  * Flags from 0x1000 up are for file system specific usage:
@@ -165,6 +170,18 @@ struct iomap_ops {
 	 */
 	int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
 			ssize_t written, unsigned flags, struct iomap *iomap);
+
+	/*
+	 * Check that the cached iomap still maps correctly to the filesystem's
+	 * internal extent map. FS internal extent maps can change while iomap
+	 * is iterating a cached iomap, so this hook allows iomap to detect that
+	 * the iomap needs to be refreshed during a long running write
+	 * operation.
+	 *
+	 * This is called with the folio over the specified file position
+	 * held locked by the iomap code.
+	 */
+	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
 };
 
 /**

