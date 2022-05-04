Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2140651A218
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348920AbiEDOZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiEDOZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 10:25:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF401CB30;
        Wed,  4 May 2022 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XLxV/TIyV3EdJRUDLXVMjkRopTDe0zDQgGSg/GzMdCU=; b=1MvQPo8u9PkvWF2gedGO2OP8FH
        U8YdKv8f62/+SK58ev1FQrEksbj60fZjWImgtIWWWkkvQhiuaCnn8g4M0w7cKsENGdLqdFUujswkz
        OjeXpF7TwtQ0+RcfTN+NggcM3ExFZeT2bw/sGiX5cVnf4pJ8Gcevb1lUzibpqFA4P6yMrCu5WYQjq
        neuNeXXN3gMPv8sAO4owQU088Tto4wfwyZ6o3aj5rZGFS2uIHZIrReATAP786rShSZxXY0/BfbIQA
        BXTA9RfUV/rf1LABEElqNvG9dbgDxkc3Z0Lq/1RofuFije3dpTN11l+oKkVtJwV3PEaBEElHImmGh
        AhVyopEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmFtM-00BFS9-Nc; Wed, 04 May 2022 14:22:12 +0000
Date:   Wed, 4 May 2022 07:22:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: iomap_write_end cleanup
Message-ID: <YnKMFNtBshOa1eWs@infradead.org>
References: <20220503213727.3273873-1-agruenba@redhat.com>
 <YnGkO9zpuzahiI0F@casper.infradead.org>
 <CAHc6FU5_JTi+RJxYwa+CLc9tx_3_CS8_r8DjkEiYRhyjUvbFww@mail.gmail.com>
 <20220503230226.GK8265@magnolia>
 <YnHIeHuAXr6WCk7M@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnHIeHuAXr6WCk7M@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 01:27:36AM +0100, Matthew Wilcox wrote:
> This is one of the things I noticed when folioising iomap and didn't
> get round to cleaning up, but I feel like we should change the calling
> convention here to bool (true = success, false = fail).  Changing
> block_write_end() might not be on the cards, unless someone's really
> motivated, but we can at least change iomap_write_end() to not have this
> stupid calling convention.

I kinda hate the bools for something that is not a simple

	if (foo()))
		return;

as propagating them is a bit of a mess.  I do however thing that
switching to 0 / -errno might work nicely here, completely untested
patch below:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8bc0989cf447fa..764174e2f1a183 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -685,13 +685,13 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * redo the whole thing.
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return 0;
+		return -EIO;
 	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
-	return copied;
+	return 0;
 }
 
-static size_t iomap_write_end_inline(const struct iomap_iter *iter,
+static void iomap_write_end_inline(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -706,23 +706,22 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
 	kunmap_local(addr);
 
 	mark_inode_dirty(iter->inode);
-	return copied;
 }
 
-/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
-static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
+static int iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t old_size = iter->inode->i_size;
-	size_t ret;
+	int ret = 0;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(iter, folio, pos, copied);
+		iomap_write_end_inline(iter, folio, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
-				copied, &folio->page, NULL);
+		if (block_write_end(NULL, iter->inode->i_mapping, pos, len,
+				    copied, &folio->page, NULL) < len)
+			ret = -EIO;
 	} else {
 		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
 	}
@@ -732,8 +731,8 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	 * cache.  It's up to the file system to write the updated size to disk,
 	 * preferably after I/O completion so that no stale data is exposed.
 	 */
-	if (pos + ret > old_size) {
-		i_size_write(iter->inode, pos + ret);
+	if (!ret && pos + len > old_size) {
+		i_size_write(iter->inode, pos + len);
 		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 	}
 	folio_unlock(folio);
@@ -741,10 +740,11 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	if (old_size < pos)
 		pagecache_isize_extended(iter->inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, ret, &folio->page);
+		page_ops->page_done(iter->inode, pos, ret ? ret : len,
+				    &folio->page);
 	folio_put(folio);
 
-	if (ret < len)
+	if (ret)
 		iomap_write_failed(iter->inode, pos, len);
 	return ret;
 }
@@ -754,7 +754,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	ssize_t written = 0;
-	long status = 0;
+	int status = 0;
 
 	do {
 		struct folio *folio;
@@ -792,26 +792,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
-
-		if (unlikely(copied != status))
-			iov_iter_revert(i, copied - status);
-
-		cond_resched();
-		if (unlikely(status == 0)) {
+		if (unlikely(status)) {
 			/*
 			 * A short copy made iomap_write_end() reject the
 			 * thing entirely.  Might be memory poisoning
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
+			if (copied) {
+				iov_iter_revert(i, copied);
 				bytes = copied;
+			}
 			goto again;
 		}
-		pos += status;
-		written += status;
-		length -= status;
+		pos += bytes;
+		written += bytes;
+		length -= bytes;
 
+		cond_resched();
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
 	} while (iov_iter_count(i) && length);
 
@@ -844,7 +842,6 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
-	long status = 0;
 	loff_t written = 0;
 
 	/* don't bother with blocks that are not shared to start with */
@@ -858,20 +855,21 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		unsigned long offset = offset_in_page(pos);
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct folio *folio;
+		int status;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
 			return status;
 
 		status = iomap_write_end(iter, pos, bytes, bytes, folio);
-		if (WARN_ON_ONCE(status == 0))
-			return -EIO;
+		if (WARN_ON_ONCE(status))
+			return status;
 
 		cond_resched();
 
-		pos += status;
-		written += status;
-		length -= status;
+		pos += bytes;
+		written += bytes;
+		length -= bytes;
 
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
 	} while (length);
@@ -925,9 +923,9 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
-		if (WARN_ON_ONCE(bytes == 0))
-			return -EIO;
+		status = iomap_write_end(iter, pos, bytes, bytes, folio);
+		if (WARN_ON_ONCE(status))
+			return status;
 
 		pos += bytes;
 		length -= bytes;
