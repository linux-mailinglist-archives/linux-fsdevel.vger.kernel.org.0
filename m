Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF272310F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbgG1RcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgG1RcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:32:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27EDC061794;
        Tue, 28 Jul 2020 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uwY0ONWKwr3Ka+gep+cKXT7IFiXgK//BuYwZIzr6bf8=; b=bLeh556Brgj/G76hyz/vYg6oxY
        T4OzrlC+wiykIG/04WiVYNoSOOaW18k2YQZuQlefracBOgUSBuVDjUZd+IjhKXOXxUJNZcLdSTImN
        O6l10CrD0Q5/j5Ym/DGpZHo3x4Le0ltFFHXHYZ5KHLDRu3EcnyCm7b5bukD/PoWxqyyvt6d+p+swJ
        ysBP8V6pfNHYhjI1PLubfAZ7DrV3+01JoXszImSeQ2BvFdDxBU6I7/CaPTn/vggmTJUj+PcYoxg6d
        bocL9Zl6vkbQCsMrWetMlOsISDhEQ0uYcktMxE12MdW1QAzjQ+humh0P3QmI2NFDjXR0BOdRdBRP2
        Xz5RUWFA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0TSc-0001t7-FZ; Tue, 28 Jul 2020 17:32:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] iomap: Add iomap_iter
Date:   Tue, 28 Jul 2020 18:32:14 +0100
Message-Id: <20200728173216.7184-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200728173216.7184-1-willy@infradead.org>
References: <20200728173216.7184-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap_iter provides a convenient way to package up and maintain
all the arguments to the various mapping and operation functions.
iomi_advance() moves the iterator forward to the next chunk of the file.
This approach has only one callback to the filesystem -- the iomap_next_t
instead of the separate iomap_begin / iomap_end calls.  This slightly
complicates the filesystems, but is more efficient.  The next function
will be called even after an error has occurred to allow the filesystem
the opportunity to clean up.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/apply.c      | 29 ++++++++++++++++++++++
 include/linux/iomap.h | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..c83dcd203558 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -92,3 +92,32 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 
 	return written ? written : ret;
 }
+
+bool iomi_advance(struct iomap_iter *iomi, int err)
+{
+	struct iomap *iomap = &iomi->iomap;
+
+	if (likely(!err)) {
+		iomi->pos += iomi->copied;
+		iomi->len -= iomi->copied;
+		iomi->ret += iomi->copied;
+		if (!iomi->len)
+			return false;
+		iomi->copied = 0;
+		if (WARN_ON(iomap->offset > iomi->pos))
+			err = -EIO;
+		if (WARN_ON(iomap->offset + iomap->length <= iomi->pos))
+			err = -EIO;
+	}
+
+	if (unlikely(err < 0)) {
+		if (iomi->copied < 0)
+			return false;
+		/* Give the body a chance to see the error and clean up */
+		iomi->copied = err;
+		if (!iomi->ret)
+			iomi->ret = err;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(iomi_advance);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..fe58e68ec0c1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -142,6 +142,63 @@ struct iomap_ops {
 			ssize_t written, unsigned flags, struct iomap *iomap);
 };
 
+/**
+ * struct iomap_iter - Iterate through a range of a file.
+ * @inode: Set at the start of the iteration and should not change.
+ * @pos: The current file position we are operating on.  It is updated by
+ *	calls to iomap_iter().  Treat as read-only in the body.
+ * @len: The remaining length of the file segment we're operating on.
+ *	It is updated at the same time as @pos.
+ * @ret: What we want our declaring function to return.  It is initialised
+ *	to zero and is the cumulative number of bytes processed so far.
+ *	It is updated at the same time as @pos.
+ * @copied: The number of bytes operated on by the body in the most
+ *	recent iteration.  If no bytes were operated on, it may be set to
+ *	a negative errno.  0 is treated as -EIO.
+ * @flags: Zero or more of the iomap_begin flags above.
+ * @iomap: ...
+ * @srcma:s ...
+ */
+struct iomap_iter {
+	struct inode *inode;
+	loff_t pos;
+	u64 len;
+	loff_t ret;
+	ssize_t copied;
+	unsigned flags;
+	struct iomap iomap;
+	struct iomap srcmap;
+};
+
+#define IOMAP_ITER(name, _inode, _pos, _len, _flags)			\
+	struct iomap_iter name = {					\
+		.inode = _inode,					\
+		.pos = _pos,						\
+		.len = _len,						\
+		.flags = _flags,					\
+	}
+
+typedef int (*iomap_next_t)(const struct iomap_iter *,
+		struct iomap *iomap, struct iomap *srcmap);
+bool iomi_advance(struct iomap_iter *iomi, int err);
+
+static inline bool iomap_iter(struct iomap_iter *iomi, iomap_next_t next)
+{
+	if (iomi->ret && iomi->copied == 0)
+		iomi->copied = -EIO;
+
+	return iomi_advance(iomi, next(iomi, &iomi->iomap, &iomi->srcmap));
+}
+
+static inline u64 iomap_length(const struct iomap_iter *iomi)
+{
+	u64 end = iomi->iomap.offset + iomi->iomap.length;
+
+	if (iomi->srcmap.type != IOMAP_HOLE)
+		end = min(end, iomi->srcmap.offset + iomi->srcmap.length);
+	return min(iomi->len, end - iomi->pos);
+}
+
 /*
  * Main iomap iterator function.
  */
-- 
2.27.0

