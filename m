Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955E3E8834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhHKCtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHKCtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:49:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5AC061765;
        Tue, 10 Aug 2021 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gwGkXVBkzh4gVIcV5S5PiXgpcLawqMmGuNwCcmE9UI4=; b=WdfHHEVkbM23Q/vLMoUJC1iCvF
        cFE/GCoDC5wtuD+E+bdZanKHL5GAPTFh/Fm8ZpBqpcJRqMGHbBhtmoL6qI7tPfmMzLl5mkflg7i9h
        ddcEz8cNF3NuyIm/nMk719Gfe1GEW55YPvSqgeg4/XKwEC9BaP5455tkbbP0LgexaZtfr1nWULaNt
        +FZjyuC0C2iRJsgKjMeQBbfdM5uSt3MWETz0iLx9zF17svtqhgD9UzdpJTq2XfP0xeu2jsfEeJd+u
        YKH5VgpdfrPvcGiTEGN5lN70yQ5ab6kPiOrBbj3qtCdwjHY8QQWWTm4gU1prQX5zdjKVlBR2jLmVq
        9y3qq/yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeHd-00Cs8r-Oa; Wed, 11 Aug 2021 02:48:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/8] iomap: Remove iomap_writepage_ctx from iomap_can_add_to_ioend()
Date:   Wed, 11 Aug 2021 03:46:41 +0100
Message-Id: <20210811024647.3067739-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for using this function without an iomap_writepage_ctx,
pass in the iomap and ioend.  Also simplify iomap_add_to_ioend() by
using the iomap & ioend directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3bf65daf55fc..5ff3369718a1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1239,18 +1239,17 @@ iomap_chain_bio(struct bio *prev)
 	return new;
 }
 
-static bool
-iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
-		sector_t sector)
+static bool iomap_can_add_to_ioend(struct iomap *iomap,
+		struct iomap_ioend *ioend, loff_t offset, sector_t sector)
 {
-	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
-	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
+	if ((iomap->flags & IOMAP_F_SHARED) !=
+	    (ioend->io_flags & IOMAP_F_SHARED))
 		return false;
-	if (wpc->iomap.type != wpc->ioend->io_type)
+	if (iomap->type != ioend->io_type)
 		return false;
-	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
+	if (offset != ioend->io_offset + ioend->io_size)
 		return false;
-	if (sector != bio_end_sector(wpc->ioend->io_bio))
+	if (sector != bio_end_sector(ioend->io_bio))
 		return false;
 	return true;
 }
@@ -1265,25 +1264,26 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
 	struct iomap *iomap = &wpc->iomap;
+	struct iomap_ioend *ioend = wpc->ioend;
 	sector_t sector = iomap_sector(iomap, offset);
 	unsigned len = i_blocksize(inode);
 	unsigned poff = offset & (PAGE_SIZE - 1);
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
-		if (wpc->ioend)
-			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, iomap, offset, sector,
-				wbc);
+	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, offset, sector)) {
+		if (ioend)
+			list_add(&ioend->io_list, iolist);
+		ioend = iomap_alloc_ioend(inode, iomap, offset, sector, wbc);
+		wpc->ioend = ioend;
 	}
 
-	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
-		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
-		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
+	if (bio_add_page(ioend->io_bio, page, len, poff) != len) {
+		ioend->io_bio = iomap_chain_bio(ioend->io_bio);
+		__bio_add_page(ioend->io_bio, page, len, poff);
 	}
 
 	if (iop)
 		atomic_add(len, &iop->write_bytes_pending);
-	wpc->ioend->io_size += len;
+	ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, page, len);
 }
 
-- 
2.30.2

