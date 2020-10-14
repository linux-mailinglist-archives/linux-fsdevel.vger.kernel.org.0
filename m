Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F8C28DD3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgJNJXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgJNJXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:23:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C69C0F26F3;
        Tue, 13 Oct 2020 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1e91Asfpb/o4Ps9/wGE3CU5stqf4CIBV6Nn0nrPVRoM=; b=ntibXZzmDHAR1Q5xYvRs9f6j8q
        V+UK0m3POBUBnFvAU5t3JdQqb6a8qPlC7Coi20lYHYuuo3HKxAgOu/mNQDLA3RuIiUfqNprN8Q9/f
        ZjFzbOyVtUYuSjaHtT9I8X3K3/BEeTeXFGD97TWytMlkWRr0X09+5inotIdVRbXP/f2vC9qTVjM4s
        XL8uQYGcqPRul2J8XcjOMhyWg50MZpzcj9hfl6kOEiZAyMXwP1B21DUOBvBHfRu2YPoOCTbPQgHU+
        SaIszX8Kxy9TnAE12CDHCW2s9cEiu0obb5NP9Y5isBt0J8iAkAOLnfg8rqf6rakDtlPPXoxeCTO7R
        tBbbxhwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX58-0005jO-9K; Wed, 14 Oct 2020 03:04:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/14] iomap: Inline data shouldn't see THPs
Date:   Wed, 14 Oct 2020 04:03:55 +0100
Message-Id: <20201014030357.21898-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 38fd69ebd4cc..38b6b75e7639 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -247,6 +247,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 		return;
 
 	BUG_ON(page->index);
+	BUG_ON(PageCompound(page));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
@@ -782,6 +783,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
+	BUG_ON(PageCompound(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	flush_dcache_page(page);
-- 
2.28.0

