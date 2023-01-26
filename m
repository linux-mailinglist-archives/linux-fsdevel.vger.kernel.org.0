Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D356067D643
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjAZUYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjAZUYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7694E4AA49;
        Thu, 26 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kEXYXbsM0fDELA034BmJN/Q2NbhIEm6ZfcGpwk7oDVY=; b=mLcquS0ppn9TSucOfF8R/FH4l5
        FykYbPiUsQv7/Li4nCSYIetf+8eL8XSpnVIk+Hv3WqhksU7xC/wOv7nmh2UPmWLhelEd/LkZXsn88
        k0iG6iGqyjZmrUxaddSQuMUATmfIiwe/gEUHQQ0JlM3nAfJWMamrw4k7TXiBtWCwCjcWPcVC3zGK8
        8C05hutgaeLmeAJ43AggmGOAZ3QY6CxWemCBjjztuYTPCz4T14iV2sqsSl7xCoe5LxzKuSdeDxqtF
        esh0YK9Tkg9sJkMUi2J1O0GgbQ5Rp1XDGmnVuhjYRB09Eop7qsePQOh8F3uMUQh4zhjmvHnlTxk1l
        yTEfyXiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nF-0073ln-M6; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 27/31] ext4: Use a folio in ext4_page_mkwrite()
Date:   Thu, 26 Jan 2023 20:24:11 +0000
Message-Id: <20230126202415.1682629-28-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

Convert to the folio API, saving a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9bcf7459a0c0..dcb99121f1c1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6215,7 +6215,7 @@ static int ext4_bh_unmapped(handle_t *handle, struct inode *inode,
 vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	loff_t size;
 	unsigned long len;
 	int err;
@@ -6259,19 +6259,18 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		goto out_ret;
 	}
 
-	lock_page(page);
+	folio_lock(folio);
 	size = i_size_read(inode);
 	/* Page got truncated from under us? */
-	if (page->mapping != mapping || page_offset(page) > size) {
-		unlock_page(page);
+	if (folio->mapping != mapping || folio_pos(folio) > size) {
+		folio_unlock(folio);
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
 
-	if (page->index == size >> PAGE_SHIFT)
-		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size)
+		len = size - folio_pos(folio);
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
 	 * journal_start/journal_stop which can block and take a long time
@@ -6279,17 +6278,17 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	 * This cannot be done for data journalling, as we have to add the
 	 * inode to the transaction's list to writeprotect pages on commit.
 	 */
-	if (page_has_buffers(page)) {
-		if (!ext4_walk_page_buffers(NULL, inode, page_buffers(page),
+	if (folio_buffers(folio)) {
+		if (!ext4_walk_page_buffers(NULL, inode, folio_buffers(folio),
 					    0, len, NULL,
 					    ext4_bh_unmapped)) {
 			/* Wait so that we don't change page under IO */
-			wait_for_stable_page(page);
+			folio_wait_stable(folio);
 			ret = VM_FAULT_LOCKED;
 			goto out;
 		}
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 	/* OK, we need to fill the hole... */
 	if (ext4_should_dioread_nolock(inode))
 		get_block = ext4_get_block_unwritten;
@@ -6310,36 +6309,35 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	if (!ext4_should_journal_data(inode)) {
 		err = block_page_mkwrite(vma, vmf, get_block);
 	} else {
-		lock_page(page);
+		folio_lock(folio);
 		size = i_size_read(inode);
 		/* Page got truncated from under us? */
-		if (page->mapping != mapping || page_offset(page) > size) {
+		if (folio->mapping != mapping || folio_pos(folio) > size) {
 			ret = VM_FAULT_NOPAGE;
 			goto out_error;
 		}
 
-		if (page->index == size >> PAGE_SHIFT)
-			len = size & ~PAGE_MASK;
-		else
-			len = PAGE_SIZE;
+		len = folio_size(folio);
+		if (folio_pos(folio) + len > size)
+			len = size - folio_pos(folio);
 
-		err = __block_write_begin(page, 0, len, ext4_get_block);
+		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
 			if (ext4_walk_page_buffers(handle, inode,
-					page_buffers(page), 0, len, NULL,
+					folio_buffers(folio), 0, len, NULL,
 					do_journal_get_write_access))
 				goto out_error;
 			if (ext4_walk_page_buffers(handle, inode,
-					page_buffers(page), 0, len, NULL,
+					folio_buffers(folio), 0, len, NULL,
 					write_end_fn))
 				goto out_error;
 			if (ext4_jbd2_inode_add_write(handle, inode,
-						      page_offset(page), len))
+						      folio_pos(folio), len))
 				goto out_error;
 			ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 		} else {
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 	}
 	ext4_journal_stop(handle);
@@ -6352,7 +6350,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 out_error:
-	unlock_page(page);
+	folio_unlock(folio);
 	ext4_journal_stop(handle);
 	goto out;
 }
-- 
2.35.1

