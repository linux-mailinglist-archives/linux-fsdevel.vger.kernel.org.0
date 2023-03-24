Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D376C8452
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjCXSDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCXSCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549851D90B;
        Fri, 24 Mar 2023 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/dfZpTtTM+oxzrxfgF15HCdASyiRxuak3JVT0a6PtTQ=; b=Rc2ZurESU7sMlCbf0Who7oD9ZF
        55non8I/vI2D6j0nUF8ngXS9tcMEv/ipSBp2O/4dXMymA0MFlC6bxblLfw6Jn77RVVgA9NhJgSGqX
        VCJTeHqG40hI+hlcLscsMsNp7y6YH+0aZ08/7O0u0LEMujSh3bK8J4gsNBY1mqUOmLoIEkP9FN7od
        NZ+I08k17Y3Yurc4ZRcG0NIpvonM8AICKBqpeR4x+Q16eNDsHiusZMZpKNNKrdXFreZsyfwCE8hMW
        +S+45Qoa61NFqgNCF0EkMFxaiy26Wv8fiYoBEfFpQxHFwVEUEMdMqybihO9QbLGXVLVC+vXaAv6Wi
        hbIvZLRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljN-0057ak-Lk; Fri, 24 Mar 2023 18:01:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 22/29] ext4: Use a folio in ext4_da_write_begin()
Date:   Fri, 24 Mar 2023 18:01:22 +0000
Message-Id: <20230324180129.1220691-23-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index acb2345fb379..c88ce6f43c01 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2902,7 +2902,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			       struct page **pagep, void **fsdata)
 {
 	int ret, retries = 0;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index;
 	struct inode *inode = mapping->host;
 
@@ -2929,22 +2929,23 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 retry:
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (!folio)
 		return -ENOMEM;
 
-	/* In case writeback began while the page was unlocked */
-	wait_for_stable_page(page);
+	/* In case writeback began while the folio was unlocked */
+	folio_wait_stable(folio);
 
 #ifdef CONFIG_FS_ENCRYPTION
-	ret = ext4_block_write_begin(page, pos, len,
+	ret = ext4_block_write_begin(&folio->page, pos, len,
 				     ext4_da_get_block_prep);
 #else
-	ret = __block_write_begin(page, pos, len, ext4_da_get_block_prep);
+	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
 #endif
 	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		/*
 		 * block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
@@ -2959,7 +2960,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 		return ret;
 	}
 
-	*pagep = page;
+	*pagep = &folio->page;
 	return ret;
 }
 
-- 
2.39.2

