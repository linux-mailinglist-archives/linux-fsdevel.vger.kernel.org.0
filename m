Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D96A912D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 07:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCCGnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 01:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCCGn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:43:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727DEB7A;
        Thu,  2 Mar 2023 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EikGI9w+uPXjJ4dtrLFAW51qvClSS07G2CZElAuAwUM=; b=pFoSD5j/ApLVQvdntttTFaO3z9
        SlGGg8n7vFMOzmPPCx5rPn16IOZV3SJwQtp9wXcBXGqCZJwNV2wV5vzC9viHEy3TdZ8pNCeSuEUjy
        XoaaO7ffk9b9Bypr53t5V0V8bTwS6FWe5zmKt2UUCEMOxayIon/Z7fA77xqjkjn/vUjZfntfDULDL
        uYwnbeDNu5SJN4CR2mmBHsgwYwzjpnFJqFtnbC9TaPaVMT6Gqbq68fB/KUZUI29kRlAFwYZtTh/ku
        pNSfMwOVs+ptQcPIXkFyeF28R5iSGybOkAXxSjIOKFQM43Uf2/ovmjpZQXuXxwpJEodwy4sqnfPyr
        SyIPkIKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXz8P-002wO8-KJ; Fri, 03 Mar 2023 06:43:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <xiang@kernel.org>
Subject: [PATCH 2/2] iomap: Use folio_copy_tail()
Date:   Fri,  3 Mar 2023 06:43:15 +0000
Message-Id: <20230303064315.701090-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230303064315.701090-1-willy@infradead.org>
References: <20230303064315.701090-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap handling of tails doesn't support multi-page folios, so
convert it to call folio_copy_tail(), which does.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 10a203515583..d08edf2de19c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -215,31 +215,20 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 {
 	struct iomap_page *iop;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
-	size_t size = i_size_read(iter->inode) - iomap->offset;
-	size_t poff = offset_in_page(iomap->offset);
-	size_t offset = offset_in_folio(folio, iomap->offset);
-	void *addr;
+	loff_t pos = iomap->offset;
 
 	if (folio_test_uptodate(folio))
 		return 0;
 
-	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
-		return -EIO;
-	if (WARN_ON_ONCE(size > PAGE_SIZE -
-			 offset_in_page(iomap->inline_data)))
-		return -EIO;
-	if (WARN_ON_ONCE(size > iomap->length))
-		return -EIO;
-	if (offset > 0)
+	if (pos > folio_pos(folio))
 		iop = iomap_page_create(iter->inode, folio, iter->flags);
 	else
 		iop = to_iomap_page(folio);
 
-	addr = kmap_local_folio(folio, offset);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - poff - size);
-	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
+	folio_copy_tail(folio, pos, iomap->inline_data,
+			iomap->length);
+	iomap_set_range_uptodate(folio, iop, pos - folio_pos(folio),
+			folio_size(folio) - offset_in_folio(folio, pos));
 	return 0;
 }
 
-- 
2.39.1

