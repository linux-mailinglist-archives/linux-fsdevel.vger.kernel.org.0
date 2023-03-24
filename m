Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610F26C8451
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXSDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjCXSCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69572724;
        Fri, 24 Mar 2023 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wzu8+rP7kpLMx5Txvie5hKn/W6mtBGcbkKCDJJVaCV4=; b=UNwQyAat6ZHLbso/QNiRVck/if
        rKJ1PD90W9v03CSVSY4iskv8XIMvLBGHNWGBID1yudFU+L2dTag+QMc1K9OGHl7PU7eos7HZeg7p0
        enOMA0nLi1mYvUwVGFOHGfGzAdmebzXr0gjUouFzEwl7SwIX97k4eA1qZROW/9EGKf8HbWrkCWo6K
        6GWUzk2vohMhc3Ik20Bu2/svazLrxy6GodY13/uPCOuQ24ITuRl/gvEA43kHy30dzgiCyPEZUwrFF
        iNL1NKKUq7IaJfwp4oob3yri4K7F+fVDpD/9z4uuCuhLsnrqNzqxk3UNQvwwZME5bXfDXF8i1TJhA
        KaOBCXLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057Zq-Ar; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/29] ext4: Convert ext4_da_write_inline_data_begin() to use a folio
Date:   Fri, 24 Mar 2023 18:01:13 +0000
Message-Id: <20230324180129.1220691-14-willy@infradead.org>
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

Saves a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 45d74274d822..2fa6c51baef9 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -909,10 +909,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 {
 	int ret;
 	handle_t *handle;
-	struct page *page;
+	struct folio *folio;
 	struct ext4_iloc iloc;
 	int retries = 0;
-	unsigned int flags;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -944,10 +943,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	 * We cannot recurse into the filesystem as the transaction
 	 * is already started.
 	 */
-	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0);
-	memalloc_nofs_restore(flags);
-	if (!page) {
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+					mapping_gfp_mask(mapping));
+	if (!folio) {
 		ret = -ENOMEM;
 		goto out_journal;
 	}
@@ -958,8 +956,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 	}
 
-	if (!PageUptodate(page)) {
-		ret = ext4_read_inline_page(inode, page);
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_page(inode, &folio->page);
 		if (ret < 0)
 			goto out_release_page;
 	}
@@ -969,13 +967,13 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 
 	up_read(&EXT4_I(inode)->xattr_sem);
-	*pagep = page;
+	*pagep = &folio->page;
 	brelse(iloc.bh);
 	return 1;
 out_release_page:
 	up_read(&EXT4_I(inode)->xattr_sem);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 out_journal:
 	ext4_journal_stop(handle);
 out:
-- 
2.39.2

