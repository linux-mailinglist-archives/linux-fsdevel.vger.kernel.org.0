Return-Path: <linux-fsdevel+bounces-484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6589F7CB421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891E81C20C1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84338FB2;
	Mon, 16 Oct 2023 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="quxX8YME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FF37C9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:33 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61800103;
	Mon, 16 Oct 2023 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pZNvvzzb8w2vdFH9XpjAcLrT4q6laln9GH3DKBbL5lk=; b=quxX8YMEDJp6HebYDp697r3l5h
	nuevpsll6VIIRlBopRKJIJhtuSWkYtDO3CUcwiCuivSm4kd3/ge0zLM30bKGaBPKCqB8TEX2UahE6
	qwJnbCWJ4Qbhf1blnOL/XbDb6qxWR/IelPH6HuFeZLNAhJkj/X982ZP7NsGuN9AHVUWi64oPy+XRF
	ZFe1U4TJDy413thxTnH/iFGiAor/QGoIq/hvOHcIrM5ab/6XjrOfbwoZayiIVK/McfAkdH/JBLUxm
	7Lm2j5fRmRlle50bKv+ZY/Rebb2Za+Y1ZztiwC4+i7b5AdJxPGO2DhJ1Q2yVJOLO7x3UYBmFI5VOf
	cfzURIyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvr-0085ci-Dg; Mon, 16 Oct 2023 20:11:19 +0000
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
Subject: [PATCH v2 23/27] ufs: Add ufs_get_locked_folio and ufs_put_locked_folio
Date: Mon, 16 Oct 2023 21:11:10 +0100
Message-Id: <20231016201114.1928083-24-willy@infradead.org>
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

Convert the _page variants to call them.  Saves a few hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/util.c | 43 +++++++++++++++++++++++++------------------
 fs/ufs/util.h | 13 +++++++++----
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 08ddf41eaaad..151b400cb3b6 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -229,43 +229,50 @@ ufs_set_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi, dev_t dev
 		ufsi->i_u1.i_data[0] = cpu_to_fs32(sb, fs32);
 }
 
+struct page *ufs_get_locked_page(struct address_space *mapping, pgoff_t index)
+{
+	struct folio *folio = ufs_get_locked_folio(mapping, index);
+
+	if (folio)
+		return folio_file_page(folio, index);
+	return NULL;
+}
+
 /**
- * ufs_get_locked_page() - locate, pin and lock a pagecache page, if not exist
+ * ufs_get_locked_folio() - locate, pin and lock a pagecache folio, if not exist
  * read it from disk.
  * @mapping: the address_space to search
  * @index: the page index
  *
- * Locates the desired pagecache page, if not exist we'll read it,
+ * Locates the desired pagecache folio, if not exist we'll read it,
  * locks it, increments its reference
  * count and returns its address.
  *
  */
-
-struct page *ufs_get_locked_page(struct address_space *mapping,
+struct folio *ufs_get_locked_folio(struct address_space *mapping,
 				 pgoff_t index)
 {
 	struct inode *inode = mapping->host;
-	struct page *page = find_lock_page(mapping, index);
-	if (!page) {
-		page = read_mapping_page(mapping, index, NULL);
+	struct folio *folio = filemap_lock_folio(mapping, index);
+	if (!folio) {
+		folio = read_mapping_folio(mapping, index, NULL);
 
-		if (IS_ERR(page)) {
-			printk(KERN_ERR "ufs_change_blocknr: "
-			       "read_mapping_page error: ino %lu, index: %lu\n",
+		if (IS_ERR(folio)) {
+			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %lu, index: %lu\n",
 			       mapping->host->i_ino, index);
-			return page;
+			return folio;
 		}
 
-		lock_page(page);
+		folio_lock(folio);
 
-		if (unlikely(page->mapping == NULL)) {
+		if (unlikely(folio->mapping == NULL)) {
 			/* Truncate got there first */
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return NULL;
 		}
 	}
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << inode->i_blkbits, 0);
-	return page;
+	if (!folio_buffers(folio))
+		folio_create_empty_buffers(folio, 1 << inode->i_blkbits, 0);
+	return folio;
 }
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 89247193d96d..62542561d150 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -273,12 +273,17 @@ extern void _ubh_ubhcpymem_(struct ufs_sb_private_info *, unsigned char *, struc
 extern void _ubh_memcpyubh_(struct ufs_sb_private_info *, struct ufs_buffer_head *, unsigned char *, unsigned);
 
 /* This functions works with cache pages*/
-extern struct page *ufs_get_locked_page(struct address_space *mapping,
-					pgoff_t index);
+struct page *ufs_get_locked_page(struct address_space *mapping, pgoff_t index);
+struct folio *ufs_get_locked_folio(struct address_space *mapping, pgoff_t index);
+static inline void ufs_put_locked_folio(struct folio *folio)
+{
+       folio_unlock(folio);
+       folio_put(folio);
+}
+
 static inline void ufs_put_locked_page(struct page *page)
 {
-       unlock_page(page);
-       put_page(page);
+	ufs_put_locked_folio(page_folio(page));
 }
 
 
-- 
2.40.1


