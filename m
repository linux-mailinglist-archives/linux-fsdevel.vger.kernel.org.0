Return-Path: <linux-fsdevel+bounces-487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76E7CB431
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B251EB2167F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7A3B2B1;
	Mon, 16 Oct 2023 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cm2/6gey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A638F83
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:35 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABCF125;
	Mon, 16 Oct 2023 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5zWLpgCpPdJ2OPyT7ybTpYNCwh68G15oM+bmUL5Qut4=; b=Cm2/6geygP8ZUrICSnQ8OvqL6x
	VIA3Zg5qgrfDLu//yeF2ucQMzFl7gvU4owiaM10L4uVEb9eU/u734bScQAKRaJTsfr6x+9xOYYeFj
	hLR54mpl1vQKk+XGT2pRrVEzPK9cWhbHcqDNc8XG1zrm3sMq2c4MU/FgkRgdZTRRuxRURoXTXPIGH
	wtXKayQ3kcdVe38fW2sAB6je4GpBoAKQiCPSNIKUajYpnWsDIHwqfcDxP0vzo29+ikrjYO99Wn7Rf
	fqDzW3TnjHGr3z+EE8+spbeIFkmdjkOpEKgydANNzprLs5Kajry6ouFuN4oRJZSpu8fnRMzU7Hadx
	D3CcqJrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvp-0085ac-2Q; Mon, 16 Oct 2023 20:11:17 +0000
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
Subject: [PATCH v2 05/27] buffer: Add get_nth_bh()
Date: Mon, 16 Oct 2023 21:10:52 +0100
Message-Id: <20231016201114.1928083-6-willy@infradead.org>
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

Extract this useful helper from nilfs_page_get_nth_block()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.h            |  7 +------
 include/linux/buffer_head.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 21ddcdd4d63e..344d71942d36 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -55,12 +55,7 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 static inline struct buffer_head *
 nilfs_page_get_nth_block(struct page *page, unsigned int count)
 {
-	struct buffer_head *bh = page_buffers(page);
-
-	while (count-- > 0)
-		bh = bh->b_this_page;
-	get_bh(bh);
-	return bh;
+	return get_nth_bh(page_buffers(page), count);
 }
 
 #endif /* _NILFS_PAGE_H */
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 1001244a8941..3d85a0cf0ca5 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -457,6 +457,28 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
 	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
 }
 
+/**
+ * get_nth_bh - Get a reference on the n'th buffer after this one.
+ * @bh: The buffer to start counting from.
+ * @count: How many buffers to skip.
+ *
+ * This is primarily useful for finding the nth buffer in a folio; in
+ * that case you pass the head buffer and the byte offset in the folio
+ * divided by the block size.  It can be used for other purposes, but
+ * it will wrap at the end of the folio rather than returning NULL or
+ * proceeding to the next folio for you.
+ *
+ * Return: The requested buffer with an elevated refcount.
+ */
+static inline __must_check
+struct buffer_head *get_nth_bh(struct buffer_head *bh, unsigned int count)
+{
+	while (count--)
+		bh = bh->b_this_page;
+	get_bh(bh);
+	return bh;
+}
+
 bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 
 #ifdef CONFIG_BUFFER_HEAD
-- 
2.40.1


