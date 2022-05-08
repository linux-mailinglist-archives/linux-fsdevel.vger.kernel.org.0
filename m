Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08651F15D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiEHUf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiEHUfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E4338B2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y6x4tCLM/EtIuFI41ik1GpmwkPE/byLnfHHJAw1Tkrw=; b=UTKrvDz4Rn5WG9niwWAO8eaVHf
        dauqYzYy91oHbnzd7u17ChOpb+LuKlpR3i9Vm0oChj6Wg2uzWgopaZ9CtcbBE8usbcZpa+G8BGJ9h
        ejlAXJKR1DB/xN60jkLINzK/+YiET713qx7LIcq0Xit9gQiiJ9LZRSk2vC9D2/wMxNfEcksfQGYmk
        N1jSN0KWUBoBM1akE/O4RHu0FHvMPIFc2kkAJGDQkCoc/X4b37bPvFOdxEX1ro/iv9sZQeI9HfYIE
        A+S/F8YYCE1IWi27fPEBFEtuRcPw0IjbrnMb2bZ3Se9TEezzBbR0s8lw7EwV60y5D7H9ukwrxgqjT
        7UTk+PEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ5-002noQ-5b; Sun, 08 May 2022 20:31:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/37] ext4: Convert ext4 to read_folio
Date:   Sun,  8 May 2022 21:31:12 +0100
Message-Id: <20220508203131.667959-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c       | 9 +++++----
 fs/ext4/move_extent.c | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d3a7e8581291..c6b8cb4949f1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3180,8 +3180,9 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 	return iomap_bmap(mapping, block, &ext4_iomap_ops);
 }
 
-static int ext4_readpage(struct file *file, struct page *page)
+static int ext4_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	int ret = -EAGAIN;
 	struct inode *inode = page->mapping->host;
 
@@ -3608,7 +3609,7 @@ static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
 }
 
 static const struct address_space_operations ext4_aops = {
-	.readpage		= ext4_readpage,
+	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
@@ -3626,7 +3627,7 @@ static const struct address_space_operations ext4_aops = {
 };
 
 static const struct address_space_operations ext4_journalled_aops = {
-	.readpage		= ext4_readpage,
+	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
@@ -3643,7 +3644,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 };
 
 static const struct address_space_operations ext4_da_aops = {
-	.readpage		= ext4_readpage,
+	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 4172a7d22471..701f1d6a217f 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -669,8 +669,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		 * Up semaphore to avoid following problems:
 		 * a. transaction deadlock among ext4_journal_start,
 		 *    ->write_begin via pagefault, and jbd2_journal_commit
-		 * b. racing with ->readpage, ->write_begin, and ext4_get_block
-		 *    in move_extent_per_page
+		 * b. racing with ->read_folio, ->write_begin, and
+		 *    ext4_get_block in move_extent_per_page
 		 */
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
 		/* Swap original branches with new branches */
-- 
2.34.1

