Return-Path: <linux-fsdevel+bounces-482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F02E7CB428
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F625B20EAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C540381C4;
	Mon, 16 Oct 2023 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBrYfkQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24661381C2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:32 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741AEB;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Wsr22ZpjWpe8fxWjxYKfzNniRcYvF9L97ZdEJ2FF4/Y=; b=gBrYfkQP4sfJfcJbui9LmC5G8s
	einGaU3FDrywjShBva2hxLnsFzqDYa7vYj1+IcO2HDWUft+0XMxopO/ZLqNGjj+DbrwbsSK3dcWzK
	6Sl7FsaYl0HLwHN7hRzckFX9/vZKlNx9eXotFlnsTqd5wjuemKfmExYprBYZa1aGyzk8xEQK8XGwz
	lKjjlJY1Q8P9exmchQygQ4JM6u/QtujFU4AParKGhEPz7dMBNOCUxVprUxNxde98iF43uezdzLWPf
	r1Ph+Z69O00vmSlJ/4p0ZIxv76vbqYpjnMfc58p3CsAc2F4xdBDQwf2QtSAVsUaPEddhiQAszwJ9c
	oFXt2sMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvq-0085bs-Ju; Mon, 16 Oct 2023 20:11:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	reiserfs-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 17/27] ntfs: Convert ntfs_read_block() to use a folio
Date: Mon, 16 Oct 2023 21:11:04 +0100
Message-Id: <20231016201114.1928083-18-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231016201114.1928083-1-willy@infradead.org>
References: <20231016201114.1928083-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The caller already has the folio, so pass it in and use the folio API
throughout saving five hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/aops.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 4e158bce4192..d66a9f5ffde9 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -145,13 +145,12 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 }
 
 /**
- * ntfs_read_block - fill a @page of an address space with data
- * @page:	page cache page to fill with data
+ * ntfs_read_block - fill a @folio of an address space with data
+ * @folio:	page cache folio to fill with data
  *
- * Fill the page @page of the address space belonging to the @page->host inode.
  * We read each buffer asynchronously and when all buffers are read in, our io
  * completion handler ntfs_end_buffer_read_async(), if required, automatically
- * applies the mst fixups to the page before finally marking it uptodate and
+ * applies the mst fixups to the folio before finally marking it uptodate and
  * unlocking it.
  *
  * We only enforce allocated_size limit because i_size is checked for in
@@ -161,7 +160,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
  *
  * Contains an adapted version of fs/buffer.c::block_read_full_folio().
  */
-static int ntfs_read_block(struct page *page)
+static int ntfs_read_block(struct folio *folio)
 {
 	loff_t i_size;
 	VCN vcn;
@@ -178,7 +177,7 @@ static int ntfs_read_block(struct page *page)
 	int i, nr;
 	unsigned char blocksize_bits;
 
-	vi = page->mapping->host;
+	vi = folio->mapping->host;
 	ni = NTFS_I(vi);
 	vol = ni->vol;
 
@@ -188,15 +187,10 @@ static int ntfs_read_block(struct page *page)
 	blocksize = vol->sb->s_blocksize;
 	blocksize_bits = vol->sb->s_blocksize_bits;
 
-	if (!page_has_buffers(page)) {
-		create_empty_buffers(page, blocksize, 0);
-		if (unlikely(!page_has_buffers(page))) {
-			unlock_page(page);
-			return -ENOMEM;
-		}
-	}
-	bh = head = page_buffers(page);
-	BUG_ON(!bh);
+	head = folio_buffers(folio);
+	if (!head)
+		head = folio_create_empty_buffers(folio, blocksize, 0);
+	bh = head;
 
 	/*
 	 * We may be racing with truncate.  To avoid some of the problems we
@@ -205,11 +199,11 @@ static int ntfs_read_block(struct page *page)
 	 * may leave some buffers unmapped which are now allocated.  This is
 	 * not a problem since these buffers will just get mapped when a write
 	 * occurs.  In case of a shrinking truncate, we will detect this later
-	 * on due to the runlist being incomplete and if the page is being
+	 * on due to the runlist being incomplete and if the folio is being
 	 * fully truncated, truncate will throw it away as soon as we unlock
 	 * it so no need to worry what we do with it.
 	 */
-	iblock = (s64)page->index << (PAGE_SHIFT - blocksize_bits);
+	iblock = (s64)folio->index << (PAGE_SHIFT - blocksize_bits);
 	read_lock_irqsave(&ni->size_lock, flags);
 	lblock = (ni->allocated_size + blocksize - 1) >> blocksize_bits;
 	init_size = ni->initialized_size;
@@ -221,7 +215,7 @@ static int ntfs_read_block(struct page *page)
 	}
 	zblock = (init_size + blocksize - 1) >> blocksize_bits;
 
-	/* Loop through all the buffers in the page. */
+	/* Loop through all the buffers in the folio. */
 	rl = NULL;
 	nr = i = 0;
 	do {
@@ -299,7 +293,7 @@ static int ntfs_read_block(struct page *page)
 			if (!err)
 				err = -EIO;
 			bh->b_blocknr = -1;
-			SetPageError(page);
+			folio_set_error(folio);
 			ntfs_error(vol->sb, "Failed to read from inode 0x%lx, "
 					"attribute type 0x%x, vcn 0x%llx, "
 					"offset 0x%x because its location on "
@@ -312,13 +306,13 @@ static int ntfs_read_block(struct page *page)
 		/*
 		 * Either iblock was outside lblock limits or
 		 * ntfs_rl_vcn_to_lcn() returned error.  Just zero that portion
-		 * of the page and set the buffer uptodate.
+		 * of the folio and set the buffer uptodate.
 		 */
 handle_hole:
 		bh->b_blocknr = -1UL;
 		clear_buffer_mapped(bh);
 handle_zblock:
-		zero_user(page, i * blocksize, blocksize);
+		folio_zero_range(folio, i * blocksize, blocksize);
 		if (likely(!err))
 			set_buffer_uptodate(bh);
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
@@ -349,11 +343,11 @@ static int ntfs_read_block(struct page *page)
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
-	if (likely(!PageError(page)))
-		SetPageUptodate(page);
+	if (likely(!folio_test_error(folio)))
+		folio_mark_uptodate(folio);
 	else /* Signal synchronous i/o error. */
 		nr = -EIO;
-	unlock_page(page);
+	folio_unlock(folio);
 	return nr;
 }
 
@@ -433,7 +427,7 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 	/* NInoNonResident() == NInoIndexAllocPresent() */
 	if (NInoNonResident(ni)) {
 		/* Normal, non-resident data stream. */
-		return ntfs_read_block(page);
+		return ntfs_read_block(folio);
 	}
 	/*
 	 * Attribute is resident, implying it is not compressed or encrypted.
-- 
2.40.1


