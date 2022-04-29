Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E65151F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379665AbiD2RaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379571AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983D1A27E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XQRW3lZzumjUXQZd6nQRKP1nNWR2SkdAYLiqccqYpe0=; b=buGfuJ/8y/xdCRNIUfe8CSM4n2
        HTgUSH16Bw1r3nJgyRzzc+1PxFVrYavBfn/2O8dVVAsD1qYI/7pPiOdjtRlbVS+erntiu3SOIApFc
        vWr1W41kw6k/rBfb6l7xI+FhWPhr43VdAQy5JJpYDOQ6GTQXS9IQuSu8bjgTtLq3skMYHoLUr7Xef
        N601wRkqhOQ5sWCyKNUXdZIr2A+sbtSgxfFdvwb7VRd362ZqiyJpgylxZlIQ4BWoF1KfcZ7Xv3DTY
        JxdNTcuts9VBsJxRZ59T0K8P3PSMlssirAJV22oU1FW+ZvQtUSIJeniTQn4KRN9P99h7mgy5tMXYV
        npeekr4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00Cdb7-Pt; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 46/69] cramfs: Convert cramfs to read_folio
Date:   Fri, 29 Apr 2022 18:25:33 +0100
Message-Id: <20220429172556.3011843-47-willy@infradead.org>
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
 fs/cramfs/README  | 8 ++++----
 fs/cramfs/inode.c | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/cramfs/README b/fs/cramfs/README
index d71b27e0ff15..778df5c4d70b 100644
--- a/fs/cramfs/README
+++ b/fs/cramfs/README
@@ -115,7 +115,7 @@ Block Size
 
 (Block size in cramfs refers to the size of input data that is
 compressed at a time.  It's intended to be somewhere around
-PAGE_SIZE for cramfs_readpage's convenience.)
+PAGE_SIZE for cramfs_read_folio's convenience.)
 
 The superblock ought to indicate the block size that the fs was
 written for, since comments in <linux/pagemap.h> indicate that
@@ -161,7 +161,7 @@ size.  The options are:
      PAGE_SIZE.
 
 It's easy enough to change the kernel to use a smaller value than
-PAGE_SIZE: just make cramfs_readpage read multiple blocks.
+PAGE_SIZE: just make cramfs_read_folio read multiple blocks.
 
 The cost of option 1 is that kernels with a larger PAGE_SIZE
 value don't get as good compression as they can.
@@ -173,9 +173,9 @@ they don't mind their cramfs being inaccessible to kernels with
 smaller PAGE_SIZE values.
 
 Option 3 is easy to implement if we don't mind being CPU-inefficient:
-e.g. get readpage to decompress to a buffer of size MAX_BLKSIZE (which
+e.g. get read_folio to decompress to a buffer of size MAX_BLKSIZE (which
 must be no larger than 32KB) and discard what it doesn't need.
-Getting readpage to read into all the covered pages is harder.
+Getting read_folio to read into all the covered pages is harder.
 
 The main advantage of option 3 over 1, 2, is better compression.  The
 cost is greater complexity.  Probably not worth it, but I hope someone
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 666aa380011e..7ae59a6afc5c 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -414,7 +414,7 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		/*
 		 * Let's create a mixed map if we can't map it all.
 		 * The normal paging machinery will take care of the
-		 * unpopulated ptes via cramfs_readpage().
+		 * unpopulated ptes via cramfs_read_folio().
 		 */
 		int i;
 		vma->vm_flags |= VM_MIXEDMAP;
@@ -814,8 +814,9 @@ static struct dentry *cramfs_lookup(struct inode *dir, struct dentry *dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int cramfs_readpage(struct file *file, struct page *page)
+static int cramfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	u32 maxblock;
 	int bytes_filled;
@@ -925,7 +926,7 @@ static int cramfs_readpage(struct file *file, struct page *page)
 }
 
 static const struct address_space_operations cramfs_aops = {
-	.readpage = cramfs_readpage
+	.read_folio = cramfs_read_folio
 };
 
 /*
-- 
2.34.1

