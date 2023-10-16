Return-Path: <linux-fsdevel+bounces-470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF717CB409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E399B20EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432E37156;
	Mon, 16 Oct 2023 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aLLIB/nJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED1374E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:30 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4FFD;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Ni6ShFlqoJTAQg1Mb9enULsIc0tMU8TggROzTwBAvx4=; b=aLLIB/nJBQ1ivAkFSyGghQPz06
	sa6qZs6qkCy0hYYh/i2hh23ELfHea+dC2k7CwHh/g0gIx7MS+MjbKljH2IVC/CrPwH66ZtV/PVks/
	HouQuzJFl/Zyb1q5G2Dx/itJKbLrArWlDq9TRyq6IFMeArzLMGKCWlkfSCptPjkQ8NErjv4HU8qN+
	J/eer3D9qjrpxiOc2rCydBr47RUSAdA1dwM2zelqsvtXBGEFCz+NwPXXq9yK6rvwiWoVShMmiHTof
	ojF5Z8P7IlFOzSU32iPrLfUkMENCbg1+JA4Fm0TWwuyUPe8Goq7XkaNJsXSYjBPC+eCQsa5YEHqFY
	0ItWQZXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvq-0085bM-1R; Mon, 16 Oct 2023 20:11:18 +0000
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
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 13/27] nilfs2: Convert nilfs_mdt_forget_block() to use a folio
Date: Mon, 16 Oct 2023 21:11:00 +0100
Message-Id: <20231016201114.1928083-14-willy@infradead.org>
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

Remove a number of folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index db2260d6e44d..11b7cf4acc92 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -356,30 +356,28 @@ int nilfs_mdt_delete_block(struct inode *inode, unsigned long block)
  */
 int nilfs_mdt_forget_block(struct inode *inode, unsigned long block)
 {
-	pgoff_t index = (pgoff_t)block >>
-		(PAGE_SHIFT - inode->i_blkbits);
-	struct page *page;
-	unsigned long first_block;
+	pgoff_t index = block >> (PAGE_SHIFT - inode->i_blkbits);
+	struct folio *folio;
+	struct buffer_head *bh;
 	int ret = 0;
 	int still_dirty;
 
-	page = find_lock_page(inode->i_mapping, index);
-	if (!page)
+	folio = filemap_lock_folio(inode->i_mapping, index);
+	if (IS_ERR(folio))
 		return -ENOENT;
 
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
-	first_block = (unsigned long)index <<
-		(PAGE_SHIFT - inode->i_blkbits);
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh;
-
-		bh = nilfs_page_get_nth_block(page, block - first_block);
+	bh = folio_buffers(folio);
+	if (bh) {
+		unsigned long first_block = index <<
+				(PAGE_SHIFT - inode->i_blkbits);
+		bh = get_nth_bh(bh, block - first_block);
 		nilfs_forget_buffer(bh);
 	}
-	still_dirty = PageDirty(page);
-	unlock_page(page);
-	put_page(page);
+	still_dirty = folio_test_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (still_dirty ||
 	    invalidate_inode_pages2_range(inode->i_mapping, index, index) != 0)
-- 
2.40.1


