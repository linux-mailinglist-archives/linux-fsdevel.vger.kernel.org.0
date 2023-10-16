Return-Path: <linux-fsdevel+bounces-489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7923D7CB42F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE411C20941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8AD3B791;
	Mon, 16 Oct 2023 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LjMtLS0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0409374DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:35 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95B122;
	Mon, 16 Oct 2023 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cRIJK0L477qKsa1RgyOitdDzKo1JzlVVyIWmDMpqQlE=; b=LjMtLS0ERzR4VCVVkxcf6vJ6LF
	Px6ulMUEkd6ZzHya8NiEL8edOoEoQJS8UZaUMcRwm8/nxOrAgs8OInub+7LrICNMHwVoLkrKiLDeL
	WdPjzpRvQOduk3ZJ9Wmd6SM/9p9ijGVC0fPPgI3XzMrLB9cZTLWcsnxnMkZ513AZLCsHS4PDRRXuw
	iOhiosd1Fn/3UFBJRKKc/ZGH5PyR9rYwGeowOhAE72JA5BGVqC+NR4WHjeGfRegkTPt5GnIaVH+kr
	hVRJwvb+ezVoszgMrk+Z71lO+vnB7FOy2vsaFbg0BJ4Y2pbucq4kYMHJDgqLcPwrqP3JpAtOs43VA
	d79x7hXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvp-0085ae-58; Mon, 16 Oct 2023 20:11:17 +0000
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
	Pankaj Raghav <p.raghav@samsung.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 06/27] gfs2: Convert inode unstuffing to use a folio
Date: Mon, 16 Oct 2023 21:10:53 +0100
Message-Id: <20231016201114.1928083-7-willy@infradead.org>
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

Use the folio APIs, removing numerous hidden calls to compound_head().
Also remove the stale comment about the page being looked up if it's NULL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index f1d92e4d1538..f7ea1af9d842 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -43,53 +43,51 @@ struct metapath {
 static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length);
 
 /**
- * gfs2_unstuffer_page - unstuff a stuffed inode into a block cached by a page
+ * gfs2_unstuffer_folio - unstuff a stuffed inode into a block cached by a folio
  * @ip: the inode
  * @dibh: the dinode buffer
  * @block: the block number that was allocated
- * @page: The (optional) page. This is looked up if @page is NULL
+ * @folio: The folio.
  *
  * Returns: errno
  */
-
-static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
-			       u64 block, struct page *page)
+static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
+			       u64 block, struct folio *folio)
 {
 	struct inode *inode = &ip->i_inode;
 
-	if (!PageUptodate(page)) {
-		void *kaddr = kmap(page);
+	if (!folio_test_uptodate(folio)) {
+		void *kaddr = kmap_local_folio(folio, 0);
 		u64 dsize = i_size_read(inode);
  
 		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
-		memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
-		kunmap(page);
+		memset(kaddr + dsize, 0, folio_size(folio) - dsize);
+		kunmap_local(kaddr);
 
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
 
 	if (gfs2_is_jdata(ip)) {
-		struct buffer_head *bh;
+		struct buffer_head *bh = folio_buffers(folio);
 
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, BIT(inode->i_blkbits),
-					     BIT(BH_Uptodate));
+		if (!bh)
+			bh = folio_create_empty_buffers(folio,
+				BIT(inode->i_blkbits), BIT(BH_Uptodate));
 
-		bh = page_buffers(page);
 		if (!buffer_mapped(bh))
 			map_bh(bh, inode->i_sb, block);
 
 		set_buffer_uptodate(bh);
 		gfs2_trans_add_data(ip->i_gl, bh);
 	} else {
-		set_page_dirty(page);
+		folio_mark_dirty(folio);
 		gfs2_ordered_add_inode(ip);
 	}
 
 	return 0;
 }
 
-static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct page *page)
+static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 {
 	struct buffer_head *bh, *dibh;
 	struct gfs2_dinode *di;
@@ -118,7 +116,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct page *page)
 					      dibh, sizeof(struct gfs2_dinode));
 			brelse(bh);
 		} else {
-			error = gfs2_unstuffer_page(ip, dibh, block, page);
+			error = gfs2_unstuffer_folio(ip, dibh, block, folio);
 			if (error)
 				goto out_brelse;
 		}
@@ -157,17 +155,17 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct page *page)
 int gfs2_unstuff_dinode(struct gfs2_inode *ip)
 {
 	struct inode *inode = &ip->i_inode;
-	struct page *page;
+	struct folio *folio;
 	int error;
 
 	down_write(&ip->i_rw_mutex);
-	page = grab_cache_page(inode->i_mapping, 0);
-	error = -ENOMEM;
-	if (!page)
+	folio = filemap_grab_folio(inode->i_mapping, 0);
+	error = PTR_ERR(folio);
+	if (IS_ERR(folio))
 		goto out;
-	error = __gfs2_unstuff_inode(ip, page);
-	unlock_page(page);
-	put_page(page);
+	error = __gfs2_unstuff_inode(ip, folio);
+	folio_unlock(folio);
+	folio_put(folio);
 out:
 	up_write(&ip->i_rw_mutex);
 	return error;
-- 
2.40.1


