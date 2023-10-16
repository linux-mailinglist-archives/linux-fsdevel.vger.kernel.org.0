Return-Path: <linux-fsdevel+bounces-477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662297CB413
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209482817DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FD381AF;
	Mon, 16 Oct 2023 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXDB3EJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B0381C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:32 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067BF1;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2doX7aDgrAV7u7ZEcXBGS632IaXA7nYXC8nB0Wjw2AM=; b=VXDB3EJIBvuFx1npUPASJAh20s
	GZG1kzcIMnZx6lxWT4/n8avEKvq0ZcGwYjJ6LPydIpk4TibPykmuJS5Ayvbf3mXpU73vKoFr3WAt0
	qN5JnSSWUIC4HkSTIZYJZLnhV5blUlPAMvVM+JvvKqhXZdpltHXIH2Ai/eILiIKYXXNO3MtT9hN94
	o4mKONkLHvhsBBWNt7XPb0O7Y3WBwLNGzPcUujtO20GNKw0PTI1odXCXMu+yjXFJ+EYhVYeNg8+kx
	l9jwr9ZXAkjSpDWJ696Knz4UX0NI1netv9Oc13BVYS51TJJNJDbTbI3s+I2rJPYcm5/3qKlpMrfKV
	cQYSqw+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvq-0085cA-St; Mon, 16 Oct 2023 20:11:18 +0000
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
Subject: [PATCH v2 19/27] ntfs: Convert ntfs_prepare_pages_for_non_resident_write() to folios
Date: Mon, 16 Oct 2023 21:11:06 +0100
Message-Id: <20231016201114.1928083-20-willy@infradead.org>
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

Convert each element of the pages array to a folio before using it.
This in no way renders the function large-folio safe, but it does remove
a lot of hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/file.c | 89 +++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 48 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index cbc545999cfe..099141d20db6 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -567,7 +567,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 	LCN lcn;
 	s64 bh_pos, vcn_len, end, initialized_size;
 	sector_t lcn_block;
-	struct page *page;
+	struct folio *folio;
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni = NULL;
 	ntfs_volume *vol;
@@ -601,20 +601,6 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 			(long long)pos, bytes);
 	blocksize = vol->sb->s_blocksize;
 	blocksize_bits = vol->sb->s_blocksize_bits;
-	u = 0;
-	do {
-		page = pages[u];
-		BUG_ON(!page);
-		/*
-		 * create_empty_buffers() will create uptodate/dirty buffers if
-		 * the page is uptodate/dirty.
-		 */
-		if (!page_has_buffers(page)) {
-			create_empty_buffers(page, blocksize, 0);
-			if (unlikely(!page_has_buffers(page)))
-				return -ENOMEM;
-		}
-	} while (++u < nr_pages);
 	rl_write_locked = false;
 	rl = NULL;
 	err = 0;
@@ -626,14 +612,21 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 	end = pos + bytes;
 	cend = (end + vol->cluster_size - 1) >> vol->cluster_size_bits;
 	/*
-	 * Loop over each page and for each page over each buffer.  Use goto to
+	 * Loop over each buffer in each folio.  Use goto to
 	 * reduce indentation.
 	 */
 	u = 0;
-do_next_page:
-	page = pages[u];
-	bh_pos = (s64)page->index << PAGE_SHIFT;
-	bh = head = page_buffers(page);
+do_next_folio:
+	folio = page_folio(pages[u]);
+	bh_pos = folio_pos(folio);
+	head = folio_buffers(folio);
+	if (!head)
+		/*
+		 * create_empty_buffers() will create uptodate/dirty
+		 * buffers if the folio is uptodate/dirty.
+		 */
+		head = folio_create_empty_buffers(folio, blocksize, 0);
+	bh = head;
 	do {
 		VCN cdelta;
 		s64 bh_end;
@@ -653,15 +646,15 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 			if (buffer_uptodate(bh))
 				continue;
 			/*
-			 * The buffer is not uptodate.  If the page is uptodate
+			 * The buffer is not uptodate.  If the folio is uptodate
 			 * set the buffer uptodate and otherwise ignore it.
 			 */
-			if (PageUptodate(page)) {
+			if (folio_test_uptodate(folio)) {
 				set_buffer_uptodate(bh);
 				continue;
 			}
 			/*
-			 * Neither the page nor the buffer are uptodate.  If
+			 * Neither the folio nor the buffer are uptodate.  If
 			 * the buffer is only partially being written to, we
 			 * need to read it in before the write, i.e. now.
 			 */
@@ -679,7 +672,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 					ntfs_submit_bh_for_read(bh);
 					*wait_bh++ = bh;
 				} else {
-					zero_user(page, bh_offset(bh),
+					folio_zero_range(folio, bh_offset(bh),
 							blocksize);
 					set_buffer_uptodate(bh);
 				}
@@ -706,7 +699,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 					(bh_cofs >> blocksize_bits);
 			set_buffer_mapped(bh);
 			/*
-			 * If the page is uptodate so is the buffer.  If the
+			 * If the folio is uptodate so is the buffer.  If the
 			 * buffer is fully outside the write, we ignore it if
 			 * it was already allocated and we mark it dirty so it
 			 * gets written out if we allocated it.  On the other
@@ -714,7 +707,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 			 * marking it dirty we set buffer_new so we can do
 			 * error recovery.
 			 */
-			if (PageUptodate(page)) {
+			if (folio_test_uptodate(folio)) {
 				if (!buffer_uptodate(bh))
 					set_buffer_uptodate(bh);
 				if (unlikely(was_hole)) {
@@ -754,7 +747,8 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 						ntfs_submit_bh_for_read(bh);
 						*wait_bh++ = bh;
 					} else {
-						zero_user(page, bh_offset(bh),
+						folio_zero_range(folio,
+								bh_offset(bh),
 								blocksize);
 						set_buffer_uptodate(bh);
 					}
@@ -773,7 +767,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 			 */
 			if (bh_end <= pos || bh_pos >= end) {
 				if (!buffer_uptodate(bh)) {
-					zero_user(page, bh_offset(bh),
+					folio_zero_range(folio, bh_offset(bh),
 							blocksize);
 					set_buffer_uptodate(bh);
 				}
@@ -786,7 +780,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 				u8 *kaddr;
 				unsigned pofs;
 					
-				kaddr = kmap_atomic(page);
+				kaddr = kmap_local_folio(folio, 0);
 				if (bh_pos < pos) {
 					pofs = bh_pos & ~PAGE_MASK;
 					memset(kaddr + pofs, 0, pos - bh_pos);
@@ -795,8 +789,8 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 					pofs = end & ~PAGE_MASK;
 					memset(kaddr + pofs, 0, bh_end - end);
 				}
-				kunmap_atomic(kaddr);
-				flush_dcache_page(page);
+				kunmap_local(kaddr);
+				flush_dcache_folio(folio);
 			}
 			continue;
 		}
@@ -809,11 +803,12 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 		initialized_size = ni->allocated_size;
 		read_unlock_irqrestore(&ni->size_lock, flags);
 		if (bh_pos > initialized_size) {
-			if (PageUptodate(page)) {
+			if (folio_test_uptodate(folio)) {
 				if (!buffer_uptodate(bh))
 					set_buffer_uptodate(bh);
 			} else if (!buffer_uptodate(bh)) {
-				zero_user(page, bh_offset(bh), blocksize);
+				folio_zero_range(folio, bh_offset(bh),
+						blocksize);
 				set_buffer_uptodate(bh);
 			}
 			continue;
@@ -927,17 +922,17 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 				bh->b_blocknr = -1;
 				/*
 				 * If the buffer is uptodate we skip it.  If it
-				 * is not but the page is uptodate, we can set
-				 * the buffer uptodate.  If the page is not
+				 * is not but the folio is uptodate, we can set
+				 * the buffer uptodate.  If the folio is not
 				 * uptodate, we can clear the buffer and set it
 				 * uptodate.  Whether this is worthwhile is
 				 * debatable and this could be removed.
 				 */
-				if (PageUptodate(page)) {
+				if (folio_test_uptodate(folio)) {
 					if (!buffer_uptodate(bh))
 						set_buffer_uptodate(bh);
 				} else if (!buffer_uptodate(bh)) {
-					zero_user(page, bh_offset(bh),
+					folio_zero_range(folio, bh_offset(bh),
 						blocksize);
 					set_buffer_uptodate(bh);
 				}
@@ -1167,7 +1162,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 	} while (bh_pos += blocksize, (bh = bh->b_this_page) != head);
 	/* If there are no errors, do the next page. */
 	if (likely(!err && ++u < nr_pages))
-		goto do_next_page;
+		goto do_next_folio;
 	/* If there are no errors, release the runlist lock if we took it. */
 	if (likely(!err)) {
 		if (unlikely(rl_write_locked)) {
@@ -1185,9 +1180,8 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 		bh = *--wait_bh;
 		wait_on_buffer(bh);
 		if (likely(buffer_uptodate(bh))) {
-			page = bh->b_page;
-			bh_pos = ((s64)page->index << PAGE_SHIFT) +
-					bh_offset(bh);
+			folio = bh->b_folio;
+			bh_pos = folio_pos(folio) + bh_offset(bh);
 			/*
 			 * If the buffer overflows the initialized size, need
 			 * to zero the overflowing region.
@@ -1197,7 +1191,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 
 				if (likely(bh_pos < initialized_size))
 					ofs = initialized_size - bh_pos;
-				zero_user_segment(page, bh_offset(bh) + ofs,
+				folio_zero_segment(folio, bh_offset(bh) + ofs,
 						blocksize);
 			}
 		} else /* if (unlikely(!buffer_uptodate(bh))) */
@@ -1324,21 +1318,20 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 	u = 0;
 	end = bh_cpos << vol->cluster_size_bits;
 	do {
-		page = pages[u];
-		bh = head = page_buffers(page);
+		folio = page_folio(pages[u]);
+		bh = head = folio_buffers(folio);
 		do {
 			if (u == nr_pages &&
-					((s64)page->index << PAGE_SHIFT) +
-					bh_offset(bh) >= end)
+			    folio_pos(folio) + bh_offset(bh) >= end)
 				break;
 			if (!buffer_new(bh))
 				continue;
 			clear_buffer_new(bh);
 			if (!buffer_uptodate(bh)) {
-				if (PageUptodate(page))
+				if (folio_test_uptodate(folio))
 					set_buffer_uptodate(bh);
 				else {
-					zero_user(page, bh_offset(bh),
+					folio_zero_range(folio, bh_offset(bh),
 							blocksize);
 					set_buffer_uptodate(bh);
 				}
-- 
2.40.1


