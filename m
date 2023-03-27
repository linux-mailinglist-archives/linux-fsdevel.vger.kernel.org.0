Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF96CAC12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC0Rpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 13:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0Rpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:45:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862519AD;
        Mon, 27 Mar 2023 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fIu8B1m7y8UbXtnikmeJqrXTu7pczz9sY+BTw0TDSzU=; b=CKZEq1dbnw8YiG6UxQX5giGqXs
        b9qOE9hP4Zc+UTvy3UaWf9zFtTwqx+oPjlM6oYJZ+pjwcvBhQVO9urgYaxU378GSBu8PsOwkXiF2A
        P4w04/3X/Fk1dY8qO8rC5ABsCZ7tFnh7uVzkv62LsGUGSEU/ICt9/0nUVB4km/SkSgNgS4BL+TAzC
        I4/GoC4sgAfZcX7tK4aIIKfdPPPTJFpJSW94ooUXmGFjYrE5T3cpYJG7HES7h2QaDy3NFlDwcgp3O
        TsA8xaG1nVozZmC/WGOlhUKJiumhksvu+7CChPzNidOSqJ41toO1BytsA5c0/aUS1F1bhyv5WDQRu
        uZdUAbvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgquI-007bGU-9o; Mon, 27 Mar 2023 17:45:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Date:   Mon, 27 Mar 2023 18:45:13 +0100
Message-Id: <20230327174515.1811532-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230327174515.1811532-1-willy@infradead.org>
References: <20230327174515.1811532-1-willy@infradead.org>
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

XFS doesn't actually need to be holding the XFS_MMAPLOCK_SHARED to do
this.  filemap_map_pages() cannot bring new folios into the page cache
and the folio lock is taken during filemap_map_pages() which provides
sufficient protection against a truncation or hole punch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_file.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 863289aaa441..aede746541f8 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1389,25 +1389,10 @@ xfs_filemap_pfn_mkwrite(
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
2.39.2

