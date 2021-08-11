Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D383E8838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhHKCun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhHKCuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:50:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E1C0613D3;
        Tue, 10 Aug 2021 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FR/F6zFiyXJZzu8vEIOrFQsDTp4ULH8sPUGRfjIRxho=; b=LzI30qInMgHfFpWkqFmx6zfEU+
        XopEb2v0xI4z422LHUgtYjWsYZZzCqA9BKwwA+kASucxv4l/s1vCp3S01tkUEHzw2HiF9S8D7iI21
        eNCDhYzeiOX9UrUWcst1ZH8fr3UtvbqgBQi5jKzUfLWgZnrp4woD5iu97PvXhoIJL2sq814wJp4xy
        pJqav6lVfOld7a3u8wISANM7IpoKP1+oUh5oCU+Msxfmag4TK256AVPe9KxOXM5wAzuJo3mG0tP0/
        gmFwN90vYi/DNOzi37YgETWnTdKwoXezsLDJIv+pBv1sV44qxMZF9C9ArwIqsju4LMF2lfMmRExdo
        k922vuwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeIC-00Cs9r-4O; Wed, 11 Aug 2021 02:48:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/8] iomap: Do not pass iomap_writepage_ctx to iomap_add_to_ioend()
Date:   Wed, 11 Aug 2021 03:46:42 +0100
Message-Id: <20210811024647.3067739-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for calling iomap_add_to_ioend() without a writepage_ctx
available, pass in the iomap and the (current) ioend, and return the
current ioend.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5ff3369718a1..d92943332c6c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1258,22 +1258,19 @@ static bool iomap_can_add_to_ioend(struct iomap *iomap,
  * Test to see if we have an existing ioend structure that we could append to
  * first; otherwise finish off the current ioend and start another.
  */
-static void
-iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
-		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
+static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
+		loff_t pos, struct page *page, struct iomap_page *iop,
+		struct iomap *iomap, struct iomap_ioend *ioend,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
-	struct iomap *iomap = &wpc->iomap;
-	struct iomap_ioend *ioend = wpc->ioend;
-	sector_t sector = iomap_sector(iomap, offset);
+	sector_t sector = iomap_sector(iomap, pos);
 	unsigned len = i_blocksize(inode);
-	unsigned poff = offset & (PAGE_SIZE - 1);
+	unsigned poff = offset_in_page(pos);
 
-	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, offset, sector)) {
+	if (!ioend || !iomap_can_add_to_ioend(iomap, ioend, pos, sector)) {
 		if (ioend)
 			list_add(&ioend->io_list, iolist);
-		ioend = iomap_alloc_ioend(inode, iomap, offset, sector, wbc);
-		wpc->ioend = ioend;
+		ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
 	}
 
 	if (bio_add_page(ioend->io_bio, page, len, poff) != len) {
@@ -1285,6 +1282,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 		atomic_add(len, &iop->write_bytes_pending);
 	ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, page, len);
+	return ioend;
 }
 
 /*
@@ -1335,8 +1333,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
-				 &submit_list);
+		wpc->ioend = iomap_add_to_ioend(inode, file_offset, page, iop,
+				&wpc->iomap, wpc->ioend, wbc, &submit_list);
 		count++;
 	}
 
-- 
2.30.2

