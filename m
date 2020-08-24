Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05DC2500E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHXPXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgHXPR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D55C06179A;
        Mon, 24 Aug 2020 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GPa/f1s9d2u/PuYPCiIU+4Nee5fNzjjdkCFYgSpocY4=; b=OmmOLV8xzcX7qqjpLomJ8zGwQd
        z2K0FTYxiyLFlVv+FLrifaHYjUYOlUwJD2Kko0doP0aDjPHosbMMmq+hlzdZix9Azb5uij+QoPiJC
        W3ofjxVxCXijvp+O9eSARifw4k1xAUcjaJuSm5RG5cug0w/Jk4Lu4l0qQfiGglAhwbgFN6UmsWqAL
        MXkLeoaN+cbt7rsRo3/cahvkpPoYNz2fKN/hIMWsBXByUOKAWcj5rQkhEfRUE2oHy5zw/6KqsdQ1z
        bhJ+yMQ4Lypok8ULGhOmwoz8rM0jgOtHJLg9hF8f0DF4soyq6nhppYCxTsYiaWqbFPYDHrFsMiQei
        w5ieW9rA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDZ-0004Dt-Dq; Mon, 24 Aug 2020 15:17:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/11] iomap: Inline data shouldn't see THPs
Date:   Mon, 24 Aug 2020 16:16:59 +0100
Message-Id: <20200824151700.16097-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Assert that we're not seeing THPs in functions that read/write
inline data, rather than zeroing out the tail.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 52d371c59758..ca2aa1995519 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -210,6 +210,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 		return;
 
 	BUG_ON(page->index);
+	BUG_ON(PageCompound(page));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
@@ -727,6 +728,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 
 	flush_dcache_page(page);
 	WARN_ON_ONCE(!PageUptodate(page));
+	BUG_ON(PageCompound(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
-- 
2.28.0

