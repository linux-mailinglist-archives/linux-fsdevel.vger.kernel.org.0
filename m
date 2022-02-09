Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299AC4AFE57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiBIUXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E7E040DDB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wmg1+IdiR6jAvgBFbP027H92X37n7oQn5/bS2W8dMW8=; b=IiGx8ymWJoaV5attCX+sU9Isiu
        tDYqAni0LvdyvIhb7oxK9K+3NcjeXDN8BCGD5jq51FgLaPTItRdYh+V6Ia2rt0Gh0up2+ozFGfkN0
        pMBwbGAVT4K0ydiwSLE0MBByI5O2LkI9cfSAK/9F/+3KoKSKeiUl5f58+8ZQY9O3pFGVMufH6ttfQ
        rS/rtDiUMOkXIRXHlCZJgsaspDOGFIeSTkK3J+Uduu2pns2LsQtdyo209O+unj/sPANdP/6EWWjqo
        P8D8acV5xL4L/zeFXd8M7sMJpKzoPrwnuMbPDvDzrWeBVHuQu61AmhWxxwhVv1EAlEULYke159E6x
        CHC3nXcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008csL-HM; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 39/56] orangefs: Convert launder_page to launder_folio
Date:   Wed,  9 Feb 2022 20:21:58 +0000
Message-Id: <20220209202215.2055748-40-willy@infradead.org>
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

OrangeFS launders its pages from a number of locations, so add a
small amount of folio usage to its callers where it makes sense.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 69 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 26f163b13b16..8a9bbbbdf406 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -243,7 +243,7 @@ static int orangefs_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int orangefs_launder_page(struct page *);
+static int orangefs_launder_folio(struct folio *);
 
 static void orangefs_readahead(struct readahead_control *rac)
 {
@@ -290,14 +290,15 @@ static void orangefs_readahead(struct readahead_control *rac)
 
 static int orangefs_readpage(struct file *file, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	struct iov_iter iter;
 	struct bio_vec bv;
 	ssize_t ret;
 	loff_t off; /* offset into this page */
 
-	if (PageDirty(page))
-		orangefs_launder_page(page);
+	if (folio_test_dirty(folio))
+		orangefs_launder_folio(folio);
 
 	off = page_offset(page);
 	bv.bv_page = page;
@@ -330,6 +331,7 @@ static int orangefs_write_begin(struct file *file,
     void **fsdata)
 {
 	struct orangefs_write_range *wr;
+	struct folio *folio;
 	struct page *page;
 	pgoff_t index;
 	int ret;
@@ -341,27 +343,28 @@ static int orangefs_write_begin(struct file *file,
 		return -ENOMEM;
 
 	*pagep = page;
+	folio = page_folio(page);
 
-	if (PageDirty(page) && !PagePrivate(page)) {
+	if (folio_test_dirty(folio) && !folio_test_private(folio)) {
 		/*
 		 * Should be impossible.  If it happens, launder the page
 		 * since we don't know what's dirty.  This will WARN in
 		 * orangefs_writepage_locked.
 		 */
-		ret = orangefs_launder_page(page);
+		ret = orangefs_launder_folio(folio);
 		if (ret)
 			return ret;
 	}
-	if (PagePrivate(page)) {
+	if (folio_test_private(folio)) {
 		struct orangefs_write_range *wr;
-		wr = (struct orangefs_write_range *)page_private(page);
+		wr = folio_get_private(folio);
 		if (wr->pos + wr->len == pos &&
 		    uid_eq(wr->uid, current_fsuid()) &&
 		    gid_eq(wr->gid, current_fsgid())) {
 			wr->len += len;
 			goto okay;
 		} else {
-			ret = orangefs_launder_page(page);
+			ret = orangefs_launder_folio(folio);
 			if (ret)
 				return ret;
 		}
@@ -375,7 +378,7 @@ static int orangefs_write_begin(struct file *file,
 	wr->len = len;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	attach_page_private(page, wr);
+	folio_attach_private(folio, wr);
 okay:
 	return 0;
 }
@@ -481,7 +484,7 @@ static void orangefs_invalidate_folio(struct folio *folio,
 	 * Thus the following runs if wr was modified above.
 	 */
 
-	orangefs_launder_page(&folio->page);
+	orangefs_launder_folio(folio);
 }
 
 static int orangefs_releasepage(struct page *page, gfp_t foo)
@@ -494,17 +497,17 @@ static void orangefs_freepage(struct page *page)
 	kfree(detach_page_private(page));
 }
 
-static int orangefs_launder_page(struct page *page)
+static int orangefs_launder_folio(struct folio *folio)
 {
 	int r = 0;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = 0,
 	};
-	wait_on_page_writeback(page);
-	if (clear_page_dirty_for_io(page)) {
-		r = orangefs_writepage_locked(page, &wbc);
-		end_page_writeback(page);
+	folio_wait_writeback(folio);
+	if (folio_clear_dirty_for_io(folio)) {
+		r = orangefs_writepage_locked(&folio->page, &wbc);
+		folio_end_writeback(folio);
 	}
 	return r;
 }
@@ -637,13 +640,13 @@ static const struct address_space_operations orangefs_address_operations = {
 	.invalidate_folio = orangefs_invalidate_folio,
 	.releasepage = orangefs_releasepage,
 	.freepage = orangefs_freepage,
-	.launder_page = orangefs_launder_page,
+	.launder_folio = orangefs_launder_folio,
 	.direct_IO = orangefs_direct_IO,
 };
 
 vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	unsigned long *bitlock = &orangefs_inode->bitlock;
@@ -657,27 +660,27 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 		goto out;
 	}
 
-	lock_page(page);
-	if (PageDirty(page) && !PagePrivate(page)) {
+	folio_lock(folio);
+	if (folio_test_dirty(folio) && !folio_test_private(folio)) {
 		/*
-		 * Should be impossible.  If it happens, launder the page
+		 * Should be impossible.  If it happens, launder the folio
 		 * since we don't know what's dirty.  This will WARN in
 		 * orangefs_writepage_locked.
 		 */
-		if (orangefs_launder_page(page)) {
+		if (orangefs_launder_folio(folio)) {
 			ret = VM_FAULT_LOCKED|VM_FAULT_RETRY;
 			goto out;
 		}
 	}
-	if (PagePrivate(page)) {
-		wr = (struct orangefs_write_range *)page_private(page);
+	if (folio_test_private(folio)) {
+		wr = folio_get_private(folio);
 		if (uid_eq(wr->uid, current_fsuid()) &&
 		    gid_eq(wr->gid, current_fsgid())) {
-			wr->pos = page_offset(page);
+			wr->pos = page_offset(vmf->page);
 			wr->len = PAGE_SIZE;
 			goto okay;
 		} else {
-			if (orangefs_launder_page(page)) {
+			if (orangefs_launder_folio(folio)) {
 				ret = VM_FAULT_LOCKED|VM_FAULT_RETRY;
 				goto out;
 			}
@@ -688,27 +691,27 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_LOCKED|VM_FAULT_RETRY;
 		goto out;
 	}
-	wr->pos = page_offset(page);
+	wr->pos = page_offset(vmf->page);
 	wr->len = PAGE_SIZE;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	attach_page_private(page, wr);
+	folio_attach_private(folio, wr);
 okay:
 
 	file_update_time(vmf->vma->vm_file);
-	if (page->mapping != inode->i_mapping) {
-		unlock_page(page);
+	if (folio->mapping != inode->i_mapping) {
+		folio_unlock(folio);
 		ret = VM_FAULT_LOCKED|VM_FAULT_NOPAGE;
 		goto out;
 	}
 
 	/*
-	 * We mark the page dirty already here so that when freeze is in
+	 * We mark the folio dirty already here so that when freeze is in
 	 * progress, we are guaranteed that writeback during freezing will
-	 * see the dirty page and writeprotect it again.
+	 * see the dirty folio and writeprotect it again.
 	 */
-	set_page_dirty(page);
-	wait_for_stable_page(page);
+	folio_mark_dirty(folio);
+	folio_wait_stable(folio);
 	ret = VM_FAULT_LOCKED;
 out:
 	sb_end_pagefault(inode->i_sb);
-- 
2.34.1

