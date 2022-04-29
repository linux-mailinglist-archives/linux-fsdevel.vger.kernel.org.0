Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B55151FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379655AbiD2RaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379589AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A2A5EAA
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y6x4tCLM/EtIuFI41ik1GpmwkPE/byLnfHHJAw1Tkrw=; b=Sj67EQ8SYixy67ewGb2QAQsR7/
        RCEJLbryPYIETpTdy1B+bP/OuNoS9ovbSv5Yr+3i2JXuE4h2FtQokFDxuBhrV4/niW+z9UrpYG0Sf
        qE/+Lx6RiBN4ZkxEMQIMOO7rePbrACZsMlS08/fSWRhAvaPJyLonXx7+tjEMWxrUrd+feXUzXKnmn
        MUDlC8MjDHpa83LTV2Ju+NWH5J0OMBY3RZPj46t+DW3uyex8uI4mBlmxrmby2O+Qkp5HtxQAxWQE/
        giLqaGvFqvPXr12B+xU9xqu9GGCPfsEQhOG11BNl2H8T7mKI56wFwy4AtuCquEGPslD6Q40v8F9NF
        eGNkZhYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNc-00Cdbx-Bu; Fri, 29 Apr 2022 17:26:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 50/69] ext4: Convert ext4 to read_folio
Date:   Fri, 29 Apr 2022 18:25:37 +0100
Message-Id: <20220429172556.3011843-51-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

