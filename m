Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7224B5BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiBNUzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBNUzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:55:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA4887B1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nL1y+cA4P888mFebv8qG8FpJF507qBBYt5Z/9iNdM4Y=; b=vkimeCog77ITCjfBXHIHRBPhE4
        LArEOJP53DqFtZrE87w1s8YrvKS1CeNdX5PCa2NBT6sej+SzNSllpnPB3y1N+TiBoXXamNcpmjXT4
        BJr7SvqKP/YJGj7zNKQiEpHY6tHM/rL//OGa/2hsft7KK+3F73fF9oEiqjyjFKGhCGmKFqMXFSimw
        kkNIlmD+/6ElARfxKsr6oV3ncH0ZwnhATbYu60WTUO+PpVY4DC+lY83pGb+NsHYf5ld6DUAmwoHAd
        BHPHlBkmBatLN61su94noOSrqL4rOJQenecnM8IFLGYD5oaMD2oL+fd1AdUa+wscf04r3BySILcgE
        RMyMeQyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWF-00DDdY-MN; Mon, 14 Feb 2022 20:00:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/10] mm/truncate: Convert invalidate_inode_page() to use a folio
Date:   Mon, 14 Feb 2022 20:00:10 +0000
Message-Id: <20220214200017.3150590-4-willy@infradead.org>
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

This saves a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index e5e2edaa0b76..b73c30c95cd0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -281,14 +281,15 @@ EXPORT_SYMBOL(generic_error_remove_page);
  */
 int invalidate_inode_page(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio_mapping(folio);
 	if (!mapping)
 		return 0;
-	if (PageDirty(page) || PageWriteback(page))
+	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
 	if (page_mapped(page))
 		return 0;
-	if (page_has_private(page) && !try_to_release_page(page, 0))
+	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
 		return 0;
 
 	return remove_mapping(mapping, page);
-- 
2.34.1

