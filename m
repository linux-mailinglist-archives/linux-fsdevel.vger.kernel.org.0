Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0786C8470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjCXSEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjCXSC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE71C7F4;
        Fri, 24 Mar 2023 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ySFLU03Vjrasdg27HUfS2pEfc/CGNxGUZQvn4Jg7yfs=; b=mv5fQcLWqhFD7BBTGkfoUR0Irj
        oXWT/fyRFgCkG59B6fTC6EsLzM3PMyDmpoIVkTBu8p5cm5YCTU/msa2oXvf2uQQSO2r4hqq+FZf2e
        pPqQwbsdvCtYKW+HHuZIRC8VthP2ZYGeEMZ5WG7/KNkd02xUZd9yJLNSED1r0eMQsvOH2NzCAbZk6
        yTYHaWOD69D/KKBTdHNN3aElfW5b4hqfeCGPQci7WrlEhx6C059jE8fvUdCbZYk9Zv+o0ufj6XiI5
        ndAcAFqA88ESdgdDRkfjedJBTj4T1TXo7xYlOTCgbP6rodqalhPQcPPg3ssdhjI1UlfVhRshjcX05
        ukgsPY3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljO-0057bS-64; Fri, 24 Mar 2023 18:01:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 25/29] ext4: Use a folio in ext4_page_mkwrite()
Date:   Fri, 24 Mar 2023 18:01:25 +0000
Message-Id: <20230324180129.1220691-26-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to the folio API, saving a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cf2b89a819cb..f0ebf211983d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6075,7 +6075,7 @@ static int ext4_bh_unmapped(handle_t *handle, struct inode *inode,
 vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	loff_t size;
 	unsigned long len;
 	int err;
@@ -6119,19 +6119,18 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
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
@@ -6139,17 +6138,17 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
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
@@ -6170,26 +6169,25 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
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
-			if (ext4_journal_page_buffers(handle, page, len))
+			if (ext4_journal_page_buffers(handle, &folio->page, len))
 				goto out_error;
 		} else {
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 	}
 	ext4_journal_stop(handle);
@@ -6202,7 +6200,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 out_error:
-	unlock_page(page);
+	folio_unlock(folio);
 	ext4_journal_stop(handle);
 	goto out;
 }
-- 
2.39.2

