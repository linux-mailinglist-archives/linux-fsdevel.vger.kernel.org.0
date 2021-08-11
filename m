Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9B3E884F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhHKCya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhHKCy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:54:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638AC061765;
        Tue, 10 Aug 2021 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iwzzerqMwO0iARK6ivjyqoH0sPMbU6DdjS1W/L65Gw4=; b=dl4Idaw9os9wRyASw7lpS62HOc
        uKMrpUoq04IeDgqBDLyq7mdsf7JH8Vx/+ozDbo7kG6T3O2Lzl/w/cw40mvsC3f4PFlcRsUkMVX74M
        AEcDlY6tGRRRqZolxggI1XFJu2c7lY+nLzvvaP+3MAhQx7EVpDmJUFtObw1lwMeLKcPCgUtz01T7P
        CaSRY+bnjrUxaZfXOWAHSDBszlChtAWPrlYzqfqz3B6pgY/rhDn/5/Qbfwd97JFjDtHi+icgZ6YOF
        joPXDLfwdob5DByPLCPhWGSkPfQb2nugWT8agM7A5JMAQrmrLL8cAJy5y6Hrq+dAcd4tJAGem6X0n
        ibjDPxYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeMH-00CsUv-Bk; Wed, 11 Aug 2021 02:53:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 8/8] iomap: Add writethrough for O_SYNC
Date:   Wed, 11 Aug 2021 03:46:47 +0100
Message-Id: <20210811024647.3067739-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For O_SYNC writes, if the filesystem has already allocated blocks for
the range, we can avoid marking the page as dirty and skip straight to
marking the page as writeback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 78 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index eb068e21d3bb..93b889338172 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -657,8 +657,45 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	return status;
 }
 
-static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
-		size_t copied, struct page *page)
+/* Rearrange file so we don't need this forward declaration */
+static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
+		loff_t pos, size_t len, struct page *page,
+		struct iomap_page *iop, struct iomap *iomap,
+		struct iomap_ioend *ioend, struct writeback_control *wbc,
+		struct list_head *iolist);
+
+/* Returns true if we can skip dirtying the page */
+static bool iomap_write_through(struct iomap_write_ctx *iwc,
+		struct iomap *iomap, struct inode *inode, struct page *page,
+		loff_t pos, size_t len)
+{
+	unsigned int blksize = i_blocksize(inode);
+
+	if (!iwc || !iwc->write_through)
+		return false;
+	if (PageDirty(page))
+		return true;
+	if (PageWriteback(page))
+		return false;
+
+	/* Can't allocate blocks here because we don't have ->prepare_ioend */
+	if (iomap->type != IOMAP_MAPPED || iomap->type != IOMAP_UNWRITTEN ||
+	    iomap->flags & IOMAP_F_SHARED)
+		return false;
+
+	len = round_up(pos + len - 1, blksize);
+	pos = round_down(pos, blksize);
+	len -= pos;
+	iwc->ioend = iomap_add_to_ioend(inode, pos, len, page,
+			iomap_page_create(inode, page), iomap, iwc->ioend, NULL,
+			&iwc->iolist);
+	set_page_writeback(page);
+	return true;
+}
+
+static size_t __iomap_write_end(struct iomap_write_ctx *iwc,
+		struct iomap *iomap, struct inode *inode, loff_t pos,
+		size_t len, size_t copied, struct page *page)
 {
 	flush_dcache_page(page);
 
@@ -676,7 +713,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	__set_page_dirty_nobuffers(page);
+	if (!iomap_write_through(iwc, iomap, inode, page, pos, len))
+		__set_page_dirty_nobuffers(page);
 	return copied;
 }
 
@@ -698,9 +736,9 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 }
 
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
-static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
-		size_t copied, struct page *page, struct iomap *iomap,
-		struct iomap *srcmap)
+static size_t iomap_write_end(struct iomap_write_ctx *iwc, struct inode *inode,
+		loff_t pos, size_t len, size_t copied, struct page *page,
+		struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	loff_t old_size = inode->i_size;
@@ -712,7 +750,8 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
 	} else {
-		ret = __iomap_write_end(inode, pos, len, copied, page);
+		ret = __iomap_write_end(iwc, iomap, inode, pos, len, copied,
+				page);
 	}
 
 	/*
@@ -780,8 +819,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
-		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
-				srcmap);
+		status = iomap_write_end(iwc, inode, pos, bytes, copied, page,
+				iomap, srcmap);
 
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
@@ -808,6 +847,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	return written ? written : status;
 }
 
+/* Also rearrange */
+static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc,
+		struct iomap_ioend *ioend, int error);
+
 ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops)
@@ -817,6 +860,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 		.iolist = LIST_HEAD_INIT(iwc.iolist),
 		.write_through = iocb->ki_flags & IOCB_SYNC,
 	};
+	struct iomap_ioend *ioend, *next;
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
 
@@ -829,6 +873,15 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 		written += ret;
 	}
 
+	if (ret > 0)
+		ret = 0;
+
+	list_for_each_entry_safe(ioend, next, &iwc.iolist, io_list) {
+		list_del_init(&ioend->io_list);
+		ret = iomap_submit_ioend(NULL, ioend, ret);
+	}
+	if (iwc.ioend)
+		ret = iomap_submit_ioend(NULL, iwc.ioend, ret);
 	return written ? written : ret;
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
@@ -857,8 +910,8 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (unlikely(status))
 			return status;
 
-		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
-				srcmap);
+		status = iomap_write_end(NULL, inode, pos, bytes, bytes, page,
+				iomap, srcmap);
 		if (WARN_ON_ONCE(status == 0))
 			return -EIO;
 
@@ -908,7 +961,8 @@ static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
 	zero_user(page, offset, bytes);
 	mark_page_accessed(page);
 
-	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
+	return iomap_write_end(NULL, inode, pos, bytes, bytes, page, iomap,
+			srcmap);
 }
 
 static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
-- 
2.30.2

