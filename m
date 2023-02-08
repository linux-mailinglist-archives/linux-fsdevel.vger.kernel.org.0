Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A368F147
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBHOxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjBHOxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:53:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04FAEFBE;
        Wed,  8 Feb 2023 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5twZFLWxkhGrNUYEW65e76d9+Wc/N4CV9H47V5oY874=; b=jhLXZ5eOcYzyv9Lg+xvTxRJyod
        htyi0O7wkyJihprDroJwDFHYs9W2CcWo4Bs4BJHOjW9nuD0JUNpaFK5Wa61HKdQkPMSQCLgqkyg/M
        DV0Dnzg3tzPaqy0lbr+4FLoiA+i5arMxHxV8SW9J5hc9kLAkar0MCXj/KCk2QIbirelqMTDrVme0R
        A3URQMf7LwUPHnghYb3mTGC17gS+DN/dNrYNpJq8NeBmPVZYYyIzaz6Pz0nQ9H1PKke7jbWoVWrvx
        J4o/VqVfhlKIA+0WzL9koVRa5NLxuH5MvC09KZRtCGqBVSbjjKgZHfaSSwR5LK124VOts++i7+9Hw
        H0agG0oA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlpK-001HwR-SC; Wed, 08 Feb 2023 14:53:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Date:   Wed,  8 Feb 2023 14:53:33 +0000
Message-Id: <20230208145335.307287-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230208145335.307287-1-willy@infradead.org>
References: <20230208145335.307287-1-willy@infradead.org>
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

XFS doesn't actually need to be holding the XFS_MMAPLOCK_SHARED
to do this, any more than it needs the XFS_MMAPLOCK_SHARED for a
read() that hits in the page cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_file.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 705250f9f90a..528fc538b6b9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1388,25 +1388,10 @@ xfs_filemap_pfn_mkwrite(
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
 }
 
-static vm_fault_t
-xfs_filemap_map_pages(
-	struct vm_fault		*vmf,
-	pgoff_t			start_pgoff,
-	pgoff_t			end_pgoff)
-{
-	struct inode		*inode = file_inode(vmf->vma->vm_file);
-	vm_fault_t ret;
-
-	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
-	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-	return ret;
-}
-
 static const struct vm_operations_struct xfs_file_vm_ops = {
 	.fault		= xfs_filemap_fault,
 	.huge_fault	= xfs_filemap_huge_fault,
-	.map_pages	= xfs_filemap_map_pages,
+	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= xfs_filemap_page_mkwrite,
 	.pfn_mkwrite	= xfs_filemap_pfn_mkwrite,
 };
-- 
2.35.1

