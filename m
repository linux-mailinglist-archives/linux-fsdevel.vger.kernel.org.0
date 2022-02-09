Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C424AFE39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiBIUWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A8E040C99
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=c0Sc9Grsc54NDXOoQXQboIxaFYB8iakui+0wHMtTeew=; b=pKfRF6LOcAaPiYBIlgQiaTPCxQ
        UKi0wEofLMLB0PqvPiZVpXTgcGAxoex1BgtrQcVMYLLOOczYWREg4GtHnNvYr5/MZVldftRpAxFLy
        +bdzeXYtsKwx0pQc5QBz3SECOGnuBmtj4FkGdLkFI+CPY5tKzqmCs0TavhZZMIVo5jolSN511ULmY
        2DbJOpoa+B0Do7UyrHiZk4fd9P8ztFKcc0+uki4S+13DkER0r9lWtYvVS/snOl0v2ChuJitKdyDPJ
        /qK9/8hMom0DL9zvsIas+MgArUyn0umPjRgd0HTu/4YQVcdcA8p3LYpJaM5bZ6GsRMSrFkt3XY42e
        WlibhkVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqn-HG; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 23/56] erofs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:42 +0000
Message-Id: <20220209202215.2055748-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/erofs/super.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 915eefe0d7e2..a64c422f6763 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -535,25 +535,24 @@ static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
-static void erofs_managed_cache_invalidatepage(struct page *page,
-					       unsigned int offset,
-					       unsigned int length)
+static void erofs_managed_cache_invalidate_folio(struct folio *folio,
+					       size_t offset, size_t length)
 {
-	const unsigned int stop = length + offset;
+	const size_t stop = length + offset;
 
-	DBG_BUGON(!PageLocked(page));
+	DBG_BUGON(!folio_test_locked(folio));
 
 	/* Check for potential overflow in debug mode */
-	DBG_BUGON(stop > PAGE_SIZE || stop < length);
+	DBG_BUGON(stop > folio_size(folio) || stop < length);
 
-	if (offset == 0 && stop == PAGE_SIZE)
-		while (!erofs_managed_cache_releasepage(page, GFP_NOFS))
+	if (offset == 0 && stop == folio_size(folio))
+		while (!erofs_managed_cache_releasepage(&folio->page, GFP_NOFS))
 			cond_resched();
 }
 
 static const struct address_space_operations managed_cache_aops = {
 	.releasepage = erofs_managed_cache_releasepage,
-	.invalidatepage = erofs_managed_cache_invalidatepage,
+	.invalidate_folio = erofs_managed_cache_invalidate_folio,
 };
 
 static int erofs_init_managed_cache(struct super_block *sb)
-- 
2.34.1

