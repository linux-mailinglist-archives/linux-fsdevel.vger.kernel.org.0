Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4F53F0CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiFFUsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiFFUrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:47:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F09013C4F5;
        Mon,  6 Jun 2022 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6sny7mgbMzuLsgsgFN8vZ/E7WcZlP1DaRKRtHbfX8Jw=; b=ukaURbWCm8w3KS3KzoVJUL3FxY
        wPlS18+1fh2iCVNChPqRPFTRbEAtlGq0XwMOhU5vLgXypaXzfZHPQHZ1bZ4aQLr6Cu5P4yx0Kxma8
        0yqfDFojKiDMNDRg/HtYwsxO/5Fhsv16i+mFYNs6xr/xrTZFC/MBisglBy5L4jIm9MB5Kv2FAVqXV
        XxvToTCQvDD1XlfJcZCtmPoTaDK39ctCmCZdLVOEq8NDfk4AFr30qp2hJ/HL+HMnFTZ0pIgzaZ1s1
        wQ/JRTi1nkJymMfIe48lYeHhHid1CC1P28h0uKjey4WY0qpcZHqgqc7fRJ3/TEyvZHuwFjaV+eKj3
        1m9LeW5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWx-00B19g-HE; Mon, 06 Jun 2022 20:40:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 12/20] f2fs: Convert to filemap_migrate_folio()
Date:   Mon,  6 Jun 2022 21:40:42 +0100
Message-Id: <20220606204050.2625949-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606204050.2625949-1-willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
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

filemap_migrate_folio() fits f2fs's needs perfectly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c |  4 +---
 fs/f2fs/data.c       | 40 +---------------------------------------
 fs/f2fs/f2fs.h       |  4 ----
 fs/f2fs/node.c       |  4 +---
 4 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6d8b2bf14de0..8259e0fa97e1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -463,9 +463,7 @@ const struct address_space_operations f2fs_meta_aops = {
 	.dirty_folio	= f2fs_dirty_meta_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 	.release_folio	= f2fs_release_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage    = f2fs_migrate_page,
-#endif
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7fcbcf979737..318a3f91ad74 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3751,42 +3751,6 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	return blknr;
 }
 
-#ifdef CONFIG_MIGRATION
-#include <linux/migrate.h>
-
-int f2fs_migrate_page(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode)
-{
-	int rc, extra_count = 0;
-
-	BUG_ON(PageWriteback(page));
-
-	rc = migrate_page_move_mapping(mapping, newpage,
-				page, extra_count);
-	if (rc != MIGRATEPAGE_SUCCESS)
-		return rc;
-
-	/* guarantee to start from no stale private field */
-	set_page_private(newpage, 0);
-	if (PagePrivate(page)) {
-		set_page_private(newpage, page_private(page));
-		SetPagePrivate(newpage);
-		get_page(newpage);
-
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
-
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
-	else
-		migrate_page_states(newpage, page);
-
-	return MIGRATEPAGE_SUCCESS;
-}
-#endif
-
 #ifdef CONFIG_SWAP
 static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 							unsigned int blkcnt)
@@ -4018,15 +3982,13 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.write_begin	= f2fs_write_begin,
 	.write_end	= f2fs_write_end,
 	.dirty_folio	= f2fs_dirty_data_folio,
+	.migrate_folio	= filemap_migrate_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 	.release_folio	= f2fs_release_folio,
 	.direct_IO	= noop_direct_IO,
 	.bmap		= f2fs_bmap,
 	.swap_activate  = f2fs_swap_activate,
 	.swap_deactivate = f2fs_swap_deactivate,
-#ifdef CONFIG_MIGRATION
-	.migratepage    = f2fs_migrate_page,
-#endif
 };
 
 void f2fs_clear_page_cache_dirty_tag(struct page *page)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..f258a1b6faed 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3764,10 +3764,6 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
-#ifdef CONFIG_MIGRATION
-int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
-			struct page *page, enum migrate_mode mode);
-#endif
 bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
 void f2fs_clear_page_cache_dirty_tag(struct page *page);
 int f2fs_init_post_read_processing(void);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 836c79a20afc..ed1cbfb0345f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2163,9 +2163,7 @@ const struct address_space_operations f2fs_node_aops = {
 	.dirty_folio	= f2fs_dirty_node_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 	.release_folio	= f2fs_release_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= f2fs_migrate_page,
-#endif
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
-- 
2.35.1

