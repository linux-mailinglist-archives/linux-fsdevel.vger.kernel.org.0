Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361953F0DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiFFUt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiFFUsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:48:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F126142;
        Mon,  6 Jun 2022 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qQEq4mdildUXXhXlw26OgbbgbPBpQ0UP7iPop0FGmsk=; b=smk5cZ9QlxWeUzBKWfo86nVrRn
        486Q4WmG9O8N7FW33RHEsLn1KdnhRCjpYsCnh2VTGHbxlEbEoaGncZWPwo88zaujLhSpvhlFYqZjF
        rT/pg4CkWWNMdWfegFLoYHJvmoFIm1xAxZgu4kmCe6BWjH2QkN1GsU7kYe50wZfva3uEoQHLUVRRU
        edvLwLiCnvO9Xryb+ZR231DA0eGBN7CXz/fAN+xjcrsnTNRjReFVIp2BGCweM6NJZGbCkhTvenoYZ
        cQCh2ENLaKQwbX+uc1wEhsR2j84htsXjEviyNnafZBo9+lFBva15d5sRZGRRozu2cOzqXNQM+sbim
        Zzrgg9gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWx-00B19U-0Q; Mon, 06 Jun 2022 20:40:55 +0000
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
Subject: [PATCH 06/20] btrfs: Convert btree_migratepage to migrate_folio
Date:   Mon,  6 Jun 2022 21:40:36 +0100
Message-Id: <20220606204050.2625949-7-willy@infradead.org>
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

Use a folio throughout this function.  migrate_page() will be converted
later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 12b11e645c14..9ceb73f683af 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -952,28 +952,28 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 }
 
 #ifdef CONFIG_MIGRATION
-static int btree_migratepage(struct address_space *mapping,
-			struct page *newpage, struct page *page,
-			enum migrate_mode mode)
+static int btree_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
 	/*
 	 * we can't safely write a btree page from here,
 	 * we haven't done the locking hook
 	 */
-	if (PageDirty(page))
+	if (folio_test_dirty(src))
 		return -EAGAIN;
 	/*
 	 * Buffers may be managed in a filesystem specific way.
 	 * We must have no buffers or drop them.
 	 */
-	if (page_has_private(page) &&
-	    !try_to_release_page(page, GFP_KERNEL))
+	if (folio_get_private(src) &&
+	    !filemap_release_folio(src, GFP_KERNEL))
 		return -EAGAIN;
-	return migrate_page(mapping, newpage, page, mode);
+	return migrate_page(mapping, &dst->page, &src->page, mode);
 }
+#else
+#define btree_migrate_folio NULL
 #endif
 
-
 static int btree_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
@@ -1073,10 +1073,8 @@ static const struct address_space_operations btree_aops = {
 	.writepages	= btree_writepages,
 	.release_folio	= btree_release_folio,
 	.invalidate_folio = btree_invalidate_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= btree_migratepage,
-#endif
-	.dirty_folio = btree_dirty_folio,
+	.migrate_folio	= btree_migrate_folio,
+	.dirty_folio	= btree_dirty_folio,
 };
 
 struct extent_buffer *btrfs_find_create_tree_block(
-- 
2.35.1

