Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDD3D449F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 05:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhGXDFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 23:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhGXDFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:05:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FAC061575;
        Fri, 23 Jul 2021 20:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1QGe1P+AGqPkdhsfqm260/tVRR1SHgGtiI0q85LYd9Q=; b=jSlxkZ6dt/BkPAjxJiUzNne+Pe
        HH17ELba5ZgaAT8GAODPfsrtbkqJiDore0EwcW1z8WohZAWAFQnNmExwprf3CUe+TIG7cqMI5jald
        U1vmlL//zcytFzEEZPe6/TMnZzXOBZ1D1q9J90kg1BMMfuSCuy7gaGbg3m8yMbgW8k4Je2zf8Rftt
        iZ/Q+Ep+gKHR0srywwmGkdm09XJcGkDVQ9eYOjsWjZaJIeQiSRez1tgT0N+PrmSdtfsnM4JTE9iTT
        QGa7y79iCKOuFuN3oYwT1aX9Rmrk+gyn80a58YahVgFt5rN6n3OnymJ5zsamU1ywrGep/wwGsPgzg
        h7xKNjkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m78bS-00Byb9-SM; Sat, 24 Jul 2021 03:45:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] iomap: Support inline data with block size < page size
Date:   Sat, 24 Jul 2021 04:44:35 +0100
Message-Id: <20210724034435.2854295-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210724034435.2854295-1-willy@infradead.org>
References: <20210724034435.2854295-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the restriction that inline data must start on a page boundary
in a file.  This allows, for example, the first 2KiB to be stored out
of line and the trailing 30 bytes to be stored inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7bd8e5de996d..d7d6af29af7f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -209,25 +209,23 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap, loff_t pos)
 {
 	size_t size = iomap->length + iomap->offset - pos;
+	size_t poff = offset_in_page(pos);
 	void *addr;
 
 	if (PageUptodate(page))
-		return PAGE_SIZE;
+		return PAGE_SIZE - poff;
 
-	/* inline data must start page aligned in the file */
-	if (WARN_ON_ONCE(offset_in_page(pos)))
-		return -EIO;
 	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
 		return -EIO;
-	if (WARN_ON_ONCE(page_has_private(page)))
-		return -EIO;
+	if (poff > 0)
+		iomap_page_create(inode, page);
 
-	addr = kmap_atomic(page);
+	addr = kmap_atomic(page) + poff;
 	memcpy(addr, iomap_inline_buf(iomap, pos), size);
-	memset(addr + size, 0, PAGE_SIZE - size);
+	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_atomic(addr);
-	SetPageUptodate(page);
-	return PAGE_SIZE;
+	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
+	return PAGE_SIZE - poff;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
-- 
2.30.2

