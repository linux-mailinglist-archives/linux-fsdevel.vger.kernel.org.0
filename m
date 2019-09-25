Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A81BD5E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411291AbfIYAwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411284AbfIYAw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cFah0KKXQyC1uWypSS4R6u3pxcVf3XmfQzNfxpF7ksY=; b=Y7odDPcVVmdoYj0pm9p8PjLP3t
        ap/2uYnhzNSTPQ0UsA7u/qoy71/BdWDnRbwRs9All7mfgg78WzhP7/tPnanfMIYrfaIEDnYNDkhYw
        eRyYtI9B5iAXvn/e1XMeqprHuDgj0hWf+cBcNxBov9zvMCyPQL5cJSCJ26cDJ0i689lIzfg15k9sb
        r6SszJGTw0EJLyY2vpMu6lw0n182VL7uK1eCRU0dVZ4NqP02lAr3VHuY78Nryh1ejXt5w8c5nJoaa
        WMyRjIGNmvYGX5wFgsQdA32lhiKtz2GJV30EsZNGQnXWIXz3AnTPwoK0bXGTIEHXqcJJsKkOZv+3O
        3MAVTtCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076W-EK; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/15] xfs: Support large pages
Date:   Tue, 24 Sep 2019 17:52:04 -0700
Message-Id: <20190925005214.27240-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Mostly this is just checking the page size of each page instead of
assuming PAGE_SIZE.  Clean up the logic in writepage a little.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_aops.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 102cfd8a97d6..1a26e9ca626b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -765,7 +765,7 @@ xfs_add_to_ioend(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct block_device	*bdev = xfs_find_bdev_for_inode(inode);
 	unsigned		len = i_blocksize(inode);
-	unsigned		poff = offset & (PAGE_SIZE - 1);
+	unsigned		poff = offset & (page_size(page) - 1);
 	bool			merged, same_page = false;
 	sector_t		sector;
 
@@ -843,7 +843,7 @@ xfs_aops_discard_page(
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	xfs_vm_invalidatepage(page, 0, PAGE_SIZE);
+	xfs_vm_invalidatepage(page, 0, page_size(page));
 }
 
 /*
@@ -984,8 +984,7 @@ xfs_do_writepage(
 	struct xfs_writepage_ctx *wpc = data;
 	struct inode		*inode = page->mapping->host;
 	loff_t			offset;
-	uint64_t              end_offset;
-	pgoff_t                 end_index;
+	uint64_t		end_offset;
 
 	trace_xfs_writepage(inode, page, 0, 0);
 
@@ -1024,10 +1023,9 @@ xfs_do_writepage(
 	 * ---------------------------------^------------------|
 	 */
 	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (xfs_off_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	end_offset = file_offset_of_next_page(page);
+
+	if (end_offset > offset) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1039,7 +1037,8 @@ xfs_do_writepage(
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		unsigned offset_into_page = offset_in_this_page(page, offset);
+		pgoff_t end_index = offset >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1070,7 +1069,7 @@ xfs_do_writepage(
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, offset_into_page, page_size(page));
 
 		/* Adjust the end_offset to the end of file */
 		end_offset = offset;
-- 
2.23.0

