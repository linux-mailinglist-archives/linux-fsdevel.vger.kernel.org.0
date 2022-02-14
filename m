Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A734B5BEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiBNUye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiBNUyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:54:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557EC16E7C6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pMmUPjORgDlTWoCIHyx1XACEheIw3KyZ8x3eCP/DL/c=; b=CZST60YHjYmI78xvxO0cAcvnMi
        e/s10L759y9ZqvQdld9dccxUESCCpqsiddGHWTBqdGL8YSlJGAzOPlz4k4h2I2FTwmBBH5i4wIFvG
        JbH2oUFEWpoi/HlwOhZR+GhQFpJC7rAuDaF19baH/305JWtw35Oe9ZR6wyYeoXkYx/bbGtzUsAWS6
        pm5zNQu5YyvxbqlEM+gXCpG4QjPAaJWu+5oH/Lsfza0DBWEahfxLDlWSEh3uUNSYik/dEhdEpVlAe
        ESxlZk1Pa+lvA46eCAC+6lPZlrSy4tEOSc14i8XQ7Qlv4TaqusZsRMwjBZI2kLO0vNNYRRMyLIIYI
        zwIptykg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWF-00DDdg-Ud; Mon, 14 Feb 2022 20:00:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/10] mm/truncate: Replace page_mapped() call in invalidate_inode_page()
Date:   Mon, 14 Feb 2022 20:00:11 +0000
Message-Id: <20220214200017.3150590-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
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

folio_mapped() is expensive because it has to check each page's mapcount
field.  A cheaper check is whether there are any extra references to
the page, other than the one we own and the ones held by the page cache.
The call to remove_mapping() will fail in any case if it cannot freeze
the refcount, but failing here avoids cycling the i_pages spinlock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index b73c30c95cd0..d67fa8871b75 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -287,7 +287,7 @@ int invalidate_inode_page(struct page *page)
 		return 0;
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
-	if (page_mapped(page))
+	if (folio_ref_count(folio) > folio_nr_pages(folio) + 1)
 		return 0;
 	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
 		return 0;
-- 
2.34.1

