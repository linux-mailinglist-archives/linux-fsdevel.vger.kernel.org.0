Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFC3C97C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhGOEzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhGOEzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:55:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED2C06175F;
        Wed, 14 Jul 2021 21:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DiCvdub2NyAxi5vdcBAAoKILUi2SsTMXk5wTzRXz3nU=; b=m9own6200ikSVQdzgLeJVvFbXk
        KLK5jjJLwmy//gHZAkUqKCRKAlllGQYXZ/mUuuaalkPV6wyi213cdVmFWEEvnWi7jeBz5FceaqnKu
        zYZWQsCeeiQcmaCS3zSkXH7A4kUFTJJrS1LJ3gXUTDCsdLg1h1ogtjStJLts3VXfcZLwU8hNSK3pR
        N2HdugKThAMJifZIdWxCuiSMV3pwoMWX2KLBCUnY14r/XTFzAajSnlVll8cbQregxqzEGHBf8yqKM
        zH4ygOVU55t924HiuKrSK1AxkjcLICLQ0+n/cV9jHsd7R9Fcsgk6MkAh7rENjwz+WPpGh09RgBcaD
        hRuaIIMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tLa-002yxB-Ff; Thu, 15 Jul 2021 04:51:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 095/138] iomap: Convert iomap_releasepage to use a folio
Date:   Thu, 15 Jul 2021 04:36:21 +0100
Message-Id: <20210715033704.692967-96-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 251ec45426aa..abb065b50e38 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -458,15 +458,15 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct folio *folio = page_folio(page);
 
-	trace_iomap_releasepage(page->mapping->host, page_offset(page),
-			PAGE_SIZE);
+	trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
+			folio_size(folio));
 
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
 	 * ->releasepage() via shrink_active_list(), skip those here.
 	 */
-	if (PageDirty(page) || PageWriteback(page))
+	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
 	iomap_page_release(folio);
 	return 1;
-- 
2.30.2

