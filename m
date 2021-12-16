Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F7477E35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhLPVHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbhLPVHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD216C061401;
        Thu, 16 Dec 2021 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Oc7hLAdhalV5iGmAfu2+59peoMoCuxLvV2dLzDsyFaw=; b=U1SB07RUdLpqtMp7E6z/UgLf31
        w7Qit5iwuxTtUrGWEBhsNXb3B36YxwQJwHptFKAjhUqbKOU5icI8ZI48dd2IvLZ0tbbdsV0Iz8B6J
        dJxZCV/mFBgKVGRz6TVTftX8e7pAZh4kceU5VrhjwJXnbXklS30N9gWhWYFiekRLZZtUG8Y1u4U48
        GFEROHiXo5es3momAAPZv9mV/qMA07rnRDxB602slOL10QICydhAoF8LfsmgyGdUPj3fg3hmgQmIj
        Kbz0F+OTeKgI5hNKXXRKb1MbV11WlCBI7glIp1pd7rA3Y69BxfIy4mNzjNzIsuMtCLFWNR6VyNv1J
        cCgVydmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyD-00Fx4h-2J; Thu, 16 Dec 2021 21:07:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 18/25] iomap: Convert iomap_write_end_inline to take a folio
Date:   Thu, 16 Dec 2021 21:07:08 +0000
Message-Id: <20211216210715.3801857-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This conversion is only safe because iomap only supports writes to inline
data which starts at the beginning of the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 975a4a6aeca0..b2bf7f337e75 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -683,16 +683,16 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 }
 
 static size_t iomap_write_end_inline(const struct iomap_iter *iter,
-		struct page *page, loff_t pos, size_t copied)
+		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(!iomap_inline_data_valid(iomap));
 
-	flush_dcache_page(page);
-	addr = kmap_local_page(page) + pos;
+	flush_dcache_folio(folio);
+	addr = kmap_local_folio(folio, pos);
 	memcpy(iomap_inline_data(iomap, pos), addr, copied);
 	kunmap_local(addr);
 
@@ -710,7 +710,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(iter, &folio->page, pos, copied);
+		ret = iomap_write_end_inline(iter, folio, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
 				copied, &folio->page, NULL);
-- 
2.33.0

