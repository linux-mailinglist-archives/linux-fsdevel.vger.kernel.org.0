Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1006C25010E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHXP0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgHXPG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:06:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6112C061799;
        Mon, 24 Aug 2020 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f+4HK1pbdrI+GZMocakT3270ISsveIlHdCnmjXaoHx8=; b=PGbnOU90Bl3xSTJD7AiRQYkpN8
        D/RTsnFTpXSiSIQmr6weLiXNoUHj9q2XOWQqd5jlRXHDFLL+fk9fSkh4jTwP5buiqNRPfdNYTSMC1
        IsSYrK2QQBFsyc0AXHb0E0u+Q+v0LecFNLBbE2KfzK0Aq18vGM0O36LVyZb5upCapRVKB2PiLx3Ut
        XK+sfPwkuo+4rrofM2VMAKDdJD1kN9eFG2FPjjSTz3H3INT5iCv6QEd0rpDh2ASl9EDf1k9L1sPWW
        Gvi5TXKsAJlbHUyCatxNrTq0mb8BjsG2/43zAGn4BzeOaIOZjQ7+AtOG/4zxXbKpnvKYp2X/dvrbc
        DldLKpKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kADsP-0002m3-Ez; Mon, 24 Aug 2020 14:55:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/9] iomap: Use kzalloc to allocate iomap_page
Date:   Mon, 24 Aug 2020 15:55:04 +0100
Message-Id: <20200824145511.10500-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can skip most of the initialisation, although spinlocks still
need explicit initialisation as architectures may use a non-zero
value to indicate unlocked.  The comment is no longer useful as
attach_page_private() handles the refcount now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 13d5cdab8dcd..639d54a4177e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -49,16 +49,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
-	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
-	atomic_set(&iop->read_count, 0);
-	atomic_set(&iop->write_count, 0);
+	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
-
-	/*
-	 * migrate_page_move_mapping() assumes that pages with private data have
-	 * their count elevated by 1.
-	 */
 	attach_page_private(page, iop);
 	return iop;
 }
-- 
2.28.0

