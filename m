Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C814AFE58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiBIUXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D26E040DF3
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Heo4sZ/0EmCWIp6dTGIfEqm/fbEKl3X5a6MMpLADkhU=; b=dIDczPxicyfJKNrTXq9Cvh6SoO
        opJlphnAjg7NkAQm3VrreFtcGjwLyk5wCfX6VIYEipQjyV+a14UuITxh5LGmf6wLp8ygDH5/o9P86
        fM44lsKUvF11f/NKxf1Vw3b+lKHh6z0mAhhojmcOFEHU5EW2chPUJLLVf0hRr5kUtUX1B27LK54H0
        3uR7jj8pADHWXSwT3Ar5jMg9s+mkqCF3zSLwmIMtgmHPImA6qfXngB2GciWTeEdZzDgyumNpV72bJ
        VrwVWhpovzhNaYEKX2ujFCxY/nrxo0Y0O2jQ0yMTt/EcvW/FY6ZgsU9IZNtdDo3k0lSCoYEUEpHxI
        GTuzfoHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008csh-0a; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 43/56] btrfs: Convert from set_page_dirty to dirty_folio
Date:   Wed,  9 Feb 2022 20:22:02 +0000
Message-Id: <20220209202215.2055748-44-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Optimise the non-DEBUG case to just call filemap_dirty_folio
directly.  The DEBUG case doesn't actually compile, but convert
it to dirty_folio anyway.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7e9d3b9c50e3..90642cedae78 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1014,26 +1014,25 @@ static void btree_invalidate_folio(struct folio *folio, size_t offset,
 	}
 }
 
-static int btree_set_page_dirty(struct page *page)
-{
 #ifdef DEBUG
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+static bool btree_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
 	struct btrfs_subpage *subpage;
 	struct extent_buffer *eb;
 	int cur_bit = 0;
-	u64 page_start = page_offset(page);
+	u64 page_start = folio_pos(folio);
 
 	if (fs_info->sectorsize == PAGE_SIZE) {
-		BUG_ON(!PagePrivate(page));
-		eb = (struct extent_buffer *)page->private;
+		eb = folio_get_private(folio);
 		BUG_ON(!eb);
 		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 		BUG_ON(!atomic_read(&eb->refs));
 		btrfs_assert_tree_write_locked(eb);
-		return __set_page_dirty_nobuffers(page);
+		return filemap_dirty_folio(mapping, folio);
 	}
-	ASSERT(PagePrivate(page) && page->private);
-	subpage = (struct btrfs_subpage *)page->private;
+	subpage = folio_get_private(folio);
 
 	ASSERT(subpage->dirty_bitmap);
 	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
@@ -1059,9 +1058,11 @@ static int btree_set_page_dirty(struct page *page)
 
 		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits);
 	}
-#endif
-	return __set_page_dirty_nobuffers(page);
+	return filemap_dirty_folio(mapping, folio);
 }
+#else
+#define btree_dirty_folio filemap_dirty_folio
+#endif
 
 static const struct address_space_operations btree_aops = {
 	.writepages	= btree_writepages,
@@ -1070,7 +1071,7 @@ static const struct address_space_operations btree_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= btree_migratepage,
 #endif
-	.set_page_dirty = btree_set_page_dirty,
+	.dirty_folio = btree_dirty_folio,
 };
 
 struct extent_buffer *btrfs_find_create_tree_block(
-- 
2.34.1

