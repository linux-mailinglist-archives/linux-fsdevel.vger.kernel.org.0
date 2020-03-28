Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2801E19672E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC1Pv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 11:51:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC1Pv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mgwfH4593N2+qz4WBbsqfRR6945Tx6eYtBgv6YjyDAA=; b=pGJyG50TKjfn+yka9yaSMawNWM
        B5RCrF9UxZioaKcGu2LDDaNsYUtCdzBhFjzWleVpwgK6NM/jRG9K/dv1iB85sXLFYQBJjbDn1gbbf
        wqgkAtyYe8KrSoFZ2R9cn9DGqJDY7TlAARBNhJlZefoPtPGkTwmxO5ww5papkxqO32NSUtWAqIAMa
        A9vtm7k3KRLWXrDx/sOT6N84W7EEv19JAKNRx8UlmWeUAFpSpSt5oyDC5kVPQnPDRvNlxx7KhHFq4
        mReA/LUk0dFcUA5LDxxNeB9z8wQaw0fUG20JSL1WxPdO276OUyKwbfTlhw2Uu1LjfgfuSClpN0sjl
        hLqT8TBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIDka-0005o7-LA; Sat, 28 Mar 2020 15:51:56 +0000
Date:   Sat, 28 Mar 2020 08:51:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
Subject: [RFC] iomap: Remove indirect function call
Message-ID: <20200328155156.GS22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By splitting iomap_apply into __iomap_apply and an inline iomap_apply,
we convert the call to 'actor' into a direct function call.  I haven't
done any performance measurements, but given the current costs of indirect
function calls, this would seem worthwhile to me?

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..c747cbf66a3d 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -9,24 +9,11 @@
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
+loff_t __iomap_apply(struct inode *inode, loff_t pos, loff_t length,
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap,
+		const struct iomap_ops *ops, iomap_actor_t actor)
 {
-	struct iomap iomap = { .type = IOMAP_HOLE };
-	struct iomap srcmap = { .type = IOMAP_HOLE };
-	loff_t written = 0, ret;
+	loff_t ret;
 	u64 end;
 
 	trace_iomap_apply(inode, pos, length, flags, ops, actor, _RET_IP_);
@@ -43,52 +30,26 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 * expose transient stale data. If the reserve fails, we can safely
 	 * back out at this point as there is nothing to undo.
 	 */
-	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
+	ret = ops->iomap_begin(inode, pos, length, flags, iomap, srcmap);
 	if (ret)
 		return ret;
-	if (WARN_ON(iomap.offset > pos))
+	if (WARN_ON(iomap->offset > pos))
 		return -EIO;
-	if (WARN_ON(iomap.length == 0))
+	if (WARN_ON(iomap->length == 0))
 		return -EIO;
 
-	trace_iomap_apply_dstmap(inode, &iomap);
-	if (srcmap.type != IOMAP_HOLE)
-		trace_iomap_apply_srcmap(inode, &srcmap);
+	trace_iomap_apply_dstmap(inode, iomap);
+	if (srcmap->type != IOMAP_HOLE)
+		trace_iomap_apply_srcmap(inode, srcmap);
 
 	/*
 	 * Cut down the length to the one actually provided by the filesystem,
 	 * as it might not be able to give us the whole size that we requested.
 	 */
-	end = iomap.offset + iomap.length;
-	if (srcmap.type != IOMAP_HOLE)
-		end = min(end, srcmap.offset + srcmap.length);
+	end = iomap->offset + iomap->length;
+	if (srcmap->type != IOMAP_HOLE)
+		end = min(end, srcmap->offset + srcmap->length);
 	if (pos + length > end)
 		length = end - pos;
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
+	return length;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..31e82e4d30f8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -148,9 +148,62 @@ struct iomap_ops {
 typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
 		void *data, struct iomap *iomap, struct iomap *srcmap);
 
-loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
-		unsigned flags, const struct iomap_ops *ops, void *data,
-		iomap_actor_t actor);
+loff_t __iomap_apply(struct inode *inode, loff_t pos, loff_t length,
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap,
+		const struct iomap_ops *ops, iomap_actor_t actor);
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
+static inline loff_t
+iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
+		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
+{
+	struct iomap iomap = { .type = IOMAP_HOLE };
+	struct iomap srcmap = { .type = IOMAP_HOLE };
+	loff_t written;
+
+	length = __iomap_apply(inode, pos, length, flags, &iomap, &srcmap,
+				ops, actor);
+	/*
+	 * Now that we have guaranteed that the space allocation will succeed,
+	 * we can do the copy-in page by page without having to worry about
+	 * failures exposing transient data.
+	 *
+	 * To support COW operations, we read in data for partially blocks from
+	 * the srcmap if the file system filled it in.  In that case we the
+	 * length needs to be limited to the earlier of the ends of the iomaps.
+	 * If the file system did not provide a srcmap we pass in the normal
+	 * iomap into the actors so that they don't need to have special
+	 * handling for the two cases.
+	 */
+	if (length < 0)
+		return length;
+
+	written = actor(inode, pos, length, data, &iomap,
+			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
+	/*
+	 * Now the data has been copied, commit the range we've copied.  This
+	 * should not fail unless the filesystem has had a fatal error.
+	 */
+	if (ops->iomap_end) {
+		loff_t ret = ops->iomap_end(inode, pos, length,
+				     written > 0 ? written : 0,
+				     flags, &iomap);
+		if (!written)
+			written = ret;
+	}
+
+	return written;
+}
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
