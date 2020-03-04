Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891831793E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgCDPrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:47:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgCDPrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mbDpQCexCemcwXZaAQfRUr+B74URk9yLqwZuAx34Yvs=; b=R8dCJppmusPr6+zr+xAawBNyMM
        7XVoIPNRmP2DttClfV92Can+cRr0nJm76Foi5qz/NhrpuOyEMPmas7tC+xc1rDXLZ1tONeRag3v2F
        0dgRWcTO1nqKyCU7qNbj2BrPs5BGS5DAOuYFubids0T3SIpoiBspRqVRo0fPLqIR7V+B6RSpp62C9
        8rhIUtilHFAe9HFcyTq3hsuUpSBPUO5B7a2AF9Q3I7NMDvqO96Cz4oisd78DAZWi8D7aeYxA54tQg
        4q3U00Cse7cmZDbiUuUAyR12EEonoNjd0iFXBzJZUnrBglsjDM68aymxRa0VLdyarwjR7pXmdoZoR
        tmlLGGkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9WEk-0008PM-HN; Wed, 04 Mar 2020 15:47:06 +0000
Date:   Wed, 4 Mar 2020 07:47:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v2] iomap: Remove pgoff from tracepoints
Message-ID: <20200304154706.GH29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

The 'pgoff' displayed by the tracepoints wasn't a pgoff at all; it
was a byte offset from the start of the file.  We already emit that in
the form of the 'offset', so we can just remove pgoff.  That means we
can remove 'page' as an argument to the tracepoint, and rename this
type of tracepoint from being a page class to being a range class.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7057ef155a29..cab29ffb2b40 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -487,7 +487,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 int
 iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
-	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
+	trace_iomap_releasepage(page->mapping->host, 0, 0);
 
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
-	trace_iomap_invalidatepage(page->mapping->host, page, offset, len);
+	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
 	 * If we are invalidating the entire page, clear the dirty state from it
@@ -1503,7 +1503,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	u64 end_offset;
 	loff_t offset;
 
-	trace_iomap_writepage(inode, page, 0, 0);
+	trace_iomap_writepage(inode, 0, 0);
 
 	/*
 	 * Refuse to write the page out if we are called from reclaim context.
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index d6ba705f938a..5693a39d52fb 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -41,14 +41,12 @@ DEFINE_EVENT(iomap_readpage_class, name,	\
 DEFINE_READPAGE_EVENT(iomap_readpage);
 DEFINE_READPAGE_EVENT(iomap_readahead);
 
-DECLARE_EVENT_CLASS(iomap_page_class,
-	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
-		 unsigned int len),
-	TP_ARGS(inode, page, off, len),
+DECLARE_EVENT_CLASS(iomap_range_class,
+	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),
+	TP_ARGS(inode, off, len),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(u64, ino)
-		__field(pgoff_t, pgoff)
 		__field(loff_t, size)
 		__field(unsigned long, offset)
 		__field(unsigned int, length)
@@ -56,29 +54,26 @@ DECLARE_EVENT_CLASS(iomap_page_class,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->pgoff = page_offset(page);
 		__entry->size = i_size_read(inode);
 		__entry->offset = off;
 		__entry->length = len;
 	),
-	TP_printk("dev %d:%d ino 0x%llx pgoff 0x%lx size 0x%llx offset %lx "
+	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset %lx "
 		  "length %x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
-		  __entry->pgoff,
 		  __entry->size,
 		  __entry->offset,
 		  __entry->length)
 )
 
-#define DEFINE_PAGE_EVENT(name)		\
-DEFINE_EVENT(iomap_page_class, name,	\
-	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
-		 unsigned int len),	\
-	TP_ARGS(inode, page, off, len))
-DEFINE_PAGE_EVENT(iomap_writepage);
-DEFINE_PAGE_EVENT(iomap_releasepage);
-DEFINE_PAGE_EVENT(iomap_invalidatepage);
+#define DEFINE_RANGE_EVENT(name)		\
+DEFINE_EVENT(iomap_range_class, name,	\
+	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),\
+	TP_ARGS(inode, off, len))
+DEFINE_RANGE_EVENT(iomap_writepage);
+DEFINE_RANGE_EVENT(iomap_releasepage);
+DEFINE_RANGE_EVENT(iomap_invalidatepage);
 
 #define IOMAP_TYPE_STRINGS \
 	{ IOMAP_HOLE,		"HOLE" }, \
