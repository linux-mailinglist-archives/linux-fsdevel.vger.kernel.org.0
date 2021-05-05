Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA1374725
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhEERrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhEERqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:46:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A842C04BE72;
        Wed,  5 May 2021 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZBU7jPypC0OmyrNV2pHtiZ4kYo5fDiKgQzb2hz2EjpQ=; b=SVv8IHDEucyKt0txVHvkTbWfZE
        NkO18eOHhcH31yu5zi8eBWl8uMP2u8Nx/xr9ywSXvqNRL6+/q7M47srBqdhnK9v9NnV41DVfHjNLz
        tFlIOIcssWAde9nFi7SD6ig0Ud4rKwEQPuDEGqGvDEbVj1/xKVgVu+fuPyZfKT+M3/9tjzAx4S8Sj
        KFmQAskcKqvMRWjXdN39A6Yb1tNe4vIcnwZgzJCqUwPcdmPBNY/TNch3V1lxsQlVMXknGVa+8uSMf
        vo5wmkXTUlQd6c1BPZxnPjtSsLWFbbwBHRYgcp0znQEhLnHS9nN5Z79TwDYs3aXamhtpfE2jtpRFq
        sLiIf7Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leL7Z-000dMi-RC; Wed, 05 May 2021 17:16:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 85/96] iomap: Convert iomap_releasepage to use a folio
Date:   Wed,  5 May 2021 16:06:17 +0100
Message-Id: <20210505150628.111735-86-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an address_space operation, so its argument must remain as a
struct page, but we can use a folio internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f2d0df0837c..33226a32e5c5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -458,15 +458,15 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct folio *folio = page_folio(page);
 
-	trace_iomap_releasepage(page->mapping->host, page_offset(page),
-			PAGE_SIZE);
+	trace_iomap_releasepage(folio->mapping->host, folio_offset(folio),
+			folio_size(folio));
 
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
 	 * ->releasepage() via shrink_active_list(), skip those here.
 	 */
-	if (PageDirty(page) || PageWriteback(page))
+	if (folio_dirty(folio) || folio_writeback(folio))
 		return 0;
 	iomap_page_release(folio);
 	return 1;
-- 
2.30.2

