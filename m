Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF62517D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiECGoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiECGnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C09306
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XCJ91jXIpCbq7tbi/tOEae2ltQHQZ4hxcr1LF5joPeU=; b=SFORG1Z6RmnvNAVglTUAQwU0Sw
        siYSCFV9+Rfi1QoEdPdeflyvd8JzgUoavCsQQ43qzwbprnNb6QjihWjFeRHnbQKsxgEA9DgvjVFYn
        7JaXfN8tuiJ6qHL8qDfsqMiZAw8bpKxlP6cinoRHULAI/oKXdQZdMDcvtsjrQFTzM65nzjCg6SQY+
        e/Bt/8kfreXPstssN73oUQbFx8X4L4TXpg0FWnu7c45jFwnfC/7T2naipr7lCpHtUjoaCM7EnI0Ig
        fhHe43HcxAx2gMvD07oEK9WtnxBpC1w8D+0+IxibqCezbwIphrRVP8SMaktsAJmrIC+FbpQgrq02y
        SZg7PE0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCi-00FRxi-EV; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 09/10] iomap: Add writethrough for O_SYNC
Date:   Tue,  3 May 2022 07:40:07 +0100
Message-Id: <20220503064008.3682332-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220503064008.3682332-1-willy@infradead.org>
References: <20220503064008.3682332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For O_SYNC writes, if the filesystem has already allocated blocks for
the range, we can avoid marking the page as dirty and skip straight to
marking the page as writeback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 74 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c540390eec3..5050adbd4bc8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -531,6 +531,12 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 EXPORT_SYMBOL_GPL(iomap_migrate_page);
 #endif /* CONFIG_MIGRATION */
 
+struct iomap_write_ctx {
+	struct iomap_ioend *ioend;
+	struct list_head iolist;
+	bool write_through;
+};
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -875,8 +881,38 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	return status;
 }
 
-static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
-		size_t copied, struct folio *folio)
+/* Returns true if we can skip dirtying the page */
+static bool iomap_write_through(struct iomap_write_ctx *iwc,
+		struct iomap *iomap, struct inode *inode, struct folio *folio,
+		loff_t pos, size_t len)
+{
+	unsigned int blksize = i_blocksize(inode);
+
+	if (!iwc || !iwc->write_through)
+		return false;
+	if (folio_test_dirty(folio))
+		return true;
+	if (folio_test_writeback(folio))
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
+	iwc->ioend = iomap_add_to_ioend(inode, pos, len, folio,
+			iomap_page_create(inode, folio), iomap, iwc->ioend,
+			NULL, &iwc->iolist);
+	folio_start_writeback(folio);
+	return true;
+}
+
+static size_t __iomap_write_end(struct iomap_write_ctx *iwc,
+		struct iomap *iomap, struct inode *inode, loff_t pos,
+		size_t len, size_t copied, struct folio *folio)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_folio(folio);
@@ -895,7 +931,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
-	filemap_dirty_folio(inode->i_mapping, folio);
+	if (!iomap_write_through(iwc, iomap, inode, folio, pos, len))
+		filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
 
@@ -918,7 +955,8 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
 }
 
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
-static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
+static size_t iomap_write_end(struct iomap_write_ctx *iwc,
+		struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
@@ -932,7 +970,8 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
 				copied, &folio->page, NULL);
 	} else {
-		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
+		ret = __iomap_write_end(iwc, &iter->iomap, iter->inode, pos,
+				len, copied, folio);
 	}
 
 	/*
@@ -957,7 +996,8 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	return ret;
 }
 
-static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
+static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
+		struct iomap_write_ctx *iwc)
 {
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
@@ -999,7 +1039,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
-		status = iomap_write_end(iter, pos, bytes, copied, folio);
+		status = iomap_write_end(iwc, iter, pos, bytes, copied, folio);
 
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
@@ -1036,10 +1076,24 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
 	};
+	struct iomap_write_ctx iwc = {
+		.iolist = LIST_HEAD_INIT(iwc.iolist),
+		.write_through = iocb->ki_flags & IOCB_SYNC,
+	};
+	struct iomap_ioend *ioend, *next;
 	int ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_write_iter(&iter, i);
+		iter.processed = iomap_write_iter(&iter, i, &iwc);
+
+	list_for_each_entry_safe(ioend, next, &iwc.iolist, io_list) {
+		list_del_init(&ioend->io_list);
+		ret = iomap_submit_ioend(NULL, ioend, ret);
+	}
+
+	if (iwc.ioend)
+		ret = iomap_submit_ioend(NULL, iwc.ioend, ret);
+
 	if (iter.pos == iocb->ki_pos)
 		return ret;
 	return iter.pos - iocb->ki_pos;
@@ -1071,7 +1125,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		if (unlikely(status))
 			return status;
 
-		status = iomap_write_end(iter, pos, bytes, bytes, folio);
+		status = iomap_write_end(NULL, iter, pos, bytes, bytes, folio);
 		if (WARN_ON_ONCE(status == 0))
 			return -EIO;
 
@@ -1133,7 +1187,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		bytes = iomap_write_end(NULL, iter, pos, bytes, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
-- 
2.34.1

