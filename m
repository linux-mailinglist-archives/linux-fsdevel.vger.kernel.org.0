Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B945224D552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgHUMqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 08:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgHUMqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:46:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CDC061385;
        Fri, 21 Aug 2020 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sW/lmAUNObsQf0xR5kBTl1oS2J9NZWgwGdTe/goMtJc=; b=XH+MQDTHFsZE57LVURtyeRxmYw
        6/dfXxrWnHJJkt4XbykeOx8FHKU/mulEfjrbmUdSev/mDoncXGheSwvLhvt1XjOYBtQD5yVSOrAIA
        NxakaZhPd3Z6EF7YA9mWcLIfyJnyo7KwbLV+a8s3nWmoT+uu9x/ACkN7T2UhsLsctYixJN0cbAA4J
        8s2Z97w7AJ3sli3NRgjM3vsJR/XuT8obN90aSEFR5CNVJeH6hTjcSdBruxVfnfe7bjXvy/Gme/2VC
        EoSGqZJe271uQU/8HDBb5uwK+WukB4Pv8UW3j1GxCjd0ccKj6K+ebSBjnYxDRKSCo6gz7ch8JS3x2
        73v9DwEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96Qu-0002hP-Cm; Fri, 21 Aug 2020 12:46:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/3] iomap: Use bitmap ops to set uptodate bits
Date:   Fri, 21 Aug 2020 13:46:05 +0100
Message-Id: <20200821124606.10165-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821124606.10165-1-willy@infradead.org>
References: <20200821124424.GQ17456@casper.infradead.org>
 <20200821124606.10165-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the bitmap is protected by a spinlock, we can use the
more efficient bitmap ops instead of individual test/set bit ops.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 639d54a4177e..dbf9572dabe9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -134,19 +134,11 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	struct inode *inode = page->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	bool uptodate = true;
 	unsigned long flags;
-	unsigned int i;
 
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
-		if (i >= first && i <= last)
-			set_bit(i, iop->uptodate);
-		else if (!test_bit(i, iop->uptodate))
-			uptodate = false;
-	}
-
-	if (uptodate)
+	bitmap_set(iop->uptodate, first, last - first + 1);
+	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
 		SetPageUptodate(page);
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
-- 
2.28.0

