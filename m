Return-Path: <linux-fsdevel+bounces-481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B47CB423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40604B21500
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BBF38FB1;
	Mon, 16 Oct 2023 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jvapso4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DB37C93
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:33 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620C101;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gXwo5POojlfzHGFPYZRyYtvPtwVY0DoWyticsN4hNno=; b=jvapso4hnLBZ129A2I9r/MGoKu
	+fqKNQfCcpXIuIuyTQQNA+A36skRya7TK5BhzgF8xsazEhoyKTQqOaUTkA3PHxYt9xEmUWPN2Pl3T
	Rzphl65eC1qmrCQsUtYaKLgpH25fAoALpbfd2Swh62Qz3t5hWRp9x6vPgV01VaLbI8tbsiHLyyqhM
	xJxTwsMq5E+AdLHZ04jSpHMVyEq8PU2sokmJlU1JPiUxBMe53V5cNv8V+hHMfdMmTqP1ptNECh4YF
	KO2+TwroNrv/AzDzSw8KUZVVf5CaQqLFyG0Hii58+7Z5n6Utg/rnELb4an9J19N+65kHVvCg0fMca
	+AATcieA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvr-0085cL-1I; Mon, 16 Oct 2023 20:11:19 +0000
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
Subject: [PATCH v2 20/27] ntfs3: Convert ntfs_zero_range() to use a folio
Date: Mon, 16 Oct 2023 21:11:07 +0100
Message-Id: <20231016201114.1928083-21-willy@infradead.org>
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

Use the folio API throughout, saving six hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/file.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index ad4a70b5d432..135af3340a19 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -187,7 +187,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	struct buffer_head *head, *bh;
 	u32 bh_next, bh_off, to;
 	sector_t iblock;
-	struct page *page;
+	struct folio *folio;
 
 	for (; idx < idx_end; idx += 1, from = 0) {
 		page_off = (loff_t)idx << PAGE_SHIFT;
@@ -195,16 +195,17 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 						       PAGE_SIZE;
 		iblock = page_off >> inode->i_blkbits;
 
-		page = find_or_create_page(mapping, idx,
-					   mapping_gfp_constraint(mapping,
-								  ~__GFP_FS));
-		if (!page)
-			return -ENOMEM;
+		folio = __filemap_get_folio(mapping, idx,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, blocksize, 0);
+		head = folio_buffers(folio);
+		if (!head)
+			head = folio_create_empty_buffers(folio, blocksize, 0);
 
-		bh = head = page_buffers(page);
+		bh = head;
 		bh_off = 0;
 		do {
 			bh_next = bh_off + blocksize;
@@ -220,14 +221,14 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 			}
 
 			/* Ok, it's mapped. Make sure it's up-to-date. */
-			if (PageUptodate(page))
+			if (folio_test_uptodate(folio))
 				set_buffer_uptodate(bh);
 
 			if (!buffer_uptodate(bh)) {
 				err = bh_read(bh, 0);
 				if (err < 0) {
-					unlock_page(page);
-					put_page(page);
+					folio_unlock(folio);
+					folio_put(folio);
 					goto out;
 				}
 			}
@@ -237,10 +238,10 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		} while (bh_off = bh_next, iblock += 1,
 			 head != (bh = bh->b_this_page));
 
-		zero_user_segment(page, from, to);
+		folio_zero_segment(folio, from, to);
 
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		cond_resched();
 	}
 out:
-- 
2.40.1


