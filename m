Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7E3E8846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhHKCxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHKCxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:53:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E654C061765;
        Tue, 10 Aug 2021 19:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4jN8eXm7tM/DW7NOVI24swwa1JV1kyssEsF/qhXwg7g=; b=G6+MBH+zqZVCioh34dF2s9+76s
        onONX+k41uwewamjAS5+a5CNwz0bPD28U4sMr4pWUzuKhQ6TT1rjGrL6UDvrnMVBhjcT01ob6GxRZ
        JNdT8k5eYAkdT94Qqq9cbQkiBMU/yaqX/BCTzDLv/Jivbr4iUDd5rcuQzIE4l3d2ya4U70rhNSFsI
        2FBRbj2IspFmqoAzgcdtGF0NuKm7mLOzb9/pogP57X+Hooq/TNDpEtkuWjJpvtwGEza8CtRCC1HZE
        RCJH/ERKioFmTieAFpMVfAPv+302CuoFAVKWOHSvCaUUQ6QYzua6RtEIroZm9JqjLxw4tO1FCuUy/
        XUhDbDJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeLO-00CsQY-PO; Wed, 11 Aug 2021 02:52:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 7/8] iomap: Pass a length to iomap_add_to_ioend()
Date:   Wed, 11 Aug 2021 03:46:46 +0100
Message-Id: <20210811024647.3067739-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the caller to specify how much of the page to add to the ioend
instead of assuming a single sector.  Somebody should probably enhance
iomap_writepage_map() to make one call per extent instead of one per
block.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2b89c43aedd7..eb068e21d3bb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1276,12 +1276,12 @@ static bool iomap_can_add_to_ioend(struct iomap *iomap,
  * first; otherwise finish off the current ioend and start another.
  */
 static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
-		loff_t pos, struct page *page, struct iomap_page *iop,
-		struct iomap *iomap, struct iomap_ioend *ioend,
-		struct writeback_control *wbc, struct list_head *iolist)
+		loff_t pos, size_t len, struct page *page,
+		struct iomap_page *iop, struct iomap *iomap,
+		struct iomap_ioend *ioend, struct writeback_control *wbc,
+		struct list_head *iolist)
 {
 	sector_t sector = iomap_sector(iomap, pos);
-	unsigned len = i_blocksize(inode);
 	unsigned poff = offset_in_page(pos);
 
 	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, pos, sector)) {
@@ -1350,8 +1350,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		wpc->ioend = iomap_add_to_ioend(inode, file_offset, page, iop,
-				&wpc->iomap, wpc->ioend, wbc, &submit_list);
+		wpc->ioend = iomap_add_to_ioend(inode, file_offset, len, page,
+				iop, &wpc->iomap, wpc->ioend, wbc,
+				&submit_list);
 		count++;
 	}
 
-- 
2.30.2

