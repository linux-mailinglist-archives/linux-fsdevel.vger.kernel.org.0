Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175286C844C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjCXSDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjCXSCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD11EBD6;
        Fri, 24 Mar 2023 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ziofsDCZyLo/pTH97EI1QVLPGqzEPW/n1l1vmWnjM2c=; b=M57M/ON3L3H8HqKBbMcd+691fK
        fzj+JYlRr1ZDGprjqxpyPWrTHP68Wyz2ebBffF45lgDPB6DVM3B2T1Vr3fzk5MOMYKOSipBMNKNmZ
        ljY4mm16W2FN/Wxb8h57m/nPkbo+6gmATzWpSP52Anuo7Tf11DfqC8QdF7cMFV7jI6mXFf16E92W7
        RWXy1okWqRytObA7ORjO7m6kFreLfrMc445ayprw17I2B7c07dhU2m6YL3V3G+z+qzAvYE2JhsRk7
        5fbeKyNTwDfIzi8RVGm1b6Uuz0scarsIt+nCU5ptPTxIZ+0YOlp4nxtc9u0y3bs6MmoVSGvLIFQzW
        vWGk3+tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljN-0057aT-Ev; Fri, 24 Mar 2023 18:01:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 20/29] ext4: Convert __ext4_block_zero_page_range() to use a folio
Date:   Fri, 24 Mar 2023 18:01:20 +0000
Message-Id: <20230324180129.1220691-21-willy@infradead.org>
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

Use folio APIs throughout.  Saves many calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 92418efe1afe..a81540a6e8c6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3669,23 +3669,26 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	ext4_lblk_t iblock;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
-	struct page *page;
+	struct folio *folio;
 	int err = 0;
 
-	page = find_or_create_page(mapping, from >> PAGE_SHIFT,
-				   mapping_gfp_constraint(mapping, ~__GFP_FS));
-	if (!page)
+	folio = __filemap_get_folio(mapping, from >> PAGE_SHIFT,
+				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				    mapping_gfp_constraint(mapping, ~__GFP_FS));
+	if (!folio)
 		return -ENOMEM;
 
 	blocksize = inode->i_sb->s_blocksize;
 
 	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
+	bh = folio_buffers(folio);
+	if (!bh) {
+		create_empty_buffers(&folio->page, blocksize, 0);
+		bh = folio_buffers(folio);
+	}
 
 	/* Find the buffer that contains "offset" */
-	bh = page_buffers(page);
 	pos = blocksize;
 	while (offset >= pos) {
 		bh = bh->b_this_page;
@@ -3707,7 +3710,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	}
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		set_buffer_uptodate(bh);
 
 	if (!buffer_uptodate(bh)) {
@@ -3717,7 +3720,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
-			err = fscrypt_decrypt_pagecache_blocks(page_folio(page),
+			err = fscrypt_decrypt_pagecache_blocks(folio,
 							       blocksize,
 							       bh_offset(bh));
 			if (err) {
@@ -3733,7 +3736,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		if (err)
 			goto unlock;
 	}
-	zero_user(page, offset, length);
+	folio_zero_range(folio, offset, length);
 	BUFFER_TRACE(bh, "zeroed end of block");
 
 	if (ext4_should_journal_data(inode)) {
@@ -3747,8 +3750,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	}
 
 unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.39.2

