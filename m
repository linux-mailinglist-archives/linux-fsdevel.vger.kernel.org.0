Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4D5151F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379651AbiD2RaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379557AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CAA2079
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uljn2IWBs8DqnOE3i3bTad2L0Ix1+446tUcqtKovHII=; b=GQd3ByjOdq8lsWpJeQbah4rhXZ
        Oj7JxCeYwwfTrlgrbHXhfr77AbQYO6looN6utlWGSmgL8AQ+IVx8sw9CXV+4f07II2K1SsFFfrqRZ
        qbaio9LjZoPjPVxTZj0cO07YiGvvyxEieeQb8cx+rwqqrRP8GHgfe7iA39Eratf5e+ajACqnmwFyj
        Lw7PlEVMAq4GMWjK5Qhn6mNAg4k6iOO7tt88qJuKSK0w6rN/fK3/778Zk+t+LGbdlj5F3yDRDnNZ3
        H9VV3biOxOWLto67uQRRXwpLpMAy3B1HpcsYV+c8qbt0eiIdGLywXOj6zmGTl5a1UoFmn9ZajKnOk
        P80ayonA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00Cdab-5Y; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 41/69] afs: Convert afs_symlink_readpage to afs_symlink_read_folio
Date:   Fri, 29 Apr 2022 18:25:28 +0100
Message-Id: <20220429172556.3011843-42-willy@infradead.org>
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

This function mostly used folios already, and only a few minor changes
were needed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index e277fbe55262..65ef69a1f78e 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -19,7 +19,7 @@
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
-static int afs_symlink_readpage(struct file *file, struct page *page);
+static int afs_symlink_read_folio(struct file *file, struct folio *folio);
 static void afs_invalidate_folio(struct folio *folio, size_t offset,
 			       size_t length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
@@ -63,7 +63,7 @@ const struct address_space_operations afs_file_aops = {
 };
 
 const struct address_space_operations afs_symlink_aops = {
-	.readpage	= afs_symlink_readpage,
+	.read_folio	= afs_symlink_read_folio,
 	.releasepage	= afs_releasepage,
 	.invalidate_folio = afs_invalidate_folio,
 };
@@ -332,11 +332,10 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	afs_put_read(fsreq);
 }
 
-static int afs_symlink_readpage(struct file *file, struct page *page)
+static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 {
-	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
+	struct afs_vnode *vnode = AFS_FS_I(folio->mapping->host);
 	struct afs_read *fsreq;
-	struct folio *folio = page_folio(page);
 	int ret;
 
 	fsreq = afs_alloc_read(GFP_NOFS);
@@ -347,13 +346,13 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
 	fsreq->len	= folio_size(folio);
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
-	iov_iter_xarray(&fsreq->def_iter, READ, &page->mapping->i_pages,
+	iov_iter_xarray(&fsreq->def_iter, READ, &folio->mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
 	ret = afs_fetch_data(fsreq->vnode, fsreq);
 	if (ret == 0)
-		SetPageUptodate(page);
-	unlock_page(page);
+		folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return ret;
 }
 
-- 
2.34.1

