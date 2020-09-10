Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF62655C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgIJXsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIJXrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:47:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED9C061757;
        Thu, 10 Sep 2020 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HcWQtDNuseBKEWHIB6Uw1jNXoqcHNymiL5aD/zPafZk=; b=VV3H4J1NcWISSb8Gj9bpB7KZ6x
        jROScpbYWM8FBiBkHpnbuW6RnoNokwGNMKvy8nG602I4Y/OSTEn+fVAF9EBYKK5wysZUkwIb1uRO/
        w76Z1rEakOIjhRdyqHNLU3YrZPkgolm2QJYu+/DWWSF15DggGjDBYEYFoT3gjAxIfWq0nxPwDuXJd
        ZWQym3yLmzApbBmpEXi8bRxJEvJbnPseeLZMtjGeuQZyaIWXCIk8SaT+JQvzBYf1e9xs4uTemj3qw
        ntOYk5pnUGkaQgqW0Pz7agmge0QrN9xiMF4N7l3inJewKsVac6aN7lKma0B2xHtNooOGy4RCv5IVC
        vezUor+g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGWHW-0001Rm-E4; Thu, 10 Sep 2020 23:47:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 4/9] iomap: Use bitmap ops to set uptodate bits
Date:   Fri, 11 Sep 2020 00:47:02 +0100
Message-Id: <20200910234707.5504-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the bitmap is protected by a spinlock, we can use the
more efficient bitmap ops instead of individual test/set bit ops.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 58a1fd83f2a4..7fc0e02d27b0 100644
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

