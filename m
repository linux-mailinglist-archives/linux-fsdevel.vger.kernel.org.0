Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586AA67D64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjAZUYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjAZUY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600F521CC;
        Thu, 26 Jan 2023 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SGFGC12Z+ymBcv5e0zP1PI9n9QX5NFVw+YtLBtPI3gA=; b=YHgd7mAsWjQRAPVKDcCPaubHIC
        816gwbuIimsAaGYh62Xw3szc+2KJcfyONOYlDzvhSy9+WaCLK1LsGnXz/jIT0d1EhtJeuXxNvLRme
        tZbiUeFUvGaY3pto0ziN38YyPcZClSHIf2F8g30FiZfMPk0m7zJtdU5JxiS0Ug9uwpaXOF7Dq6zrF
        Jyq1+h98kh93pWuGF2fKfDuSXR1/XD66RqtPxmr9FzF2RqPjVCa5z8OxKxik0cF9ihKz2ogBaTs7n
        azVngSBgYr/9Yf+0RKJ7kNsZX9tcBHTjdVrB1kPy2xYJCphF0pc7qRsZWhcbkxeduP506jfE8gVNg
        Em8KxtzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nG-0073mM-6G; Thu, 26 Jan 2023 20:24:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/31] ext4: Use a folio in ext4_read_merkle_tree_page
Date:   Thu, 26 Jan 2023 20:24:15 +0000
Message-Id: <20230126202415.1682629-32-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

This is an implementation of fsverity_operations read_merkle_tree_page,
so it must still return the precise page asked for, but we can use the
folio API to reduce the number of conversions between folios & pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index afe847c967a4..3b01247066dd 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,21 +361,21 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	struct page *page;
+	struct folio *folio;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
-	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
-	if (!page || !PageUptodate(page)) {
+	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (!folio || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (page)
-			put_page(page);
+		if (folio)
+			folio_put(folio);
 		else if (num_ra_pages > 1)
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		page = read_mapping_page(inode->i_mapping, index, NULL);
+		folio = read_mapping_folio(inode->i_mapping, index, NULL);
 	}
-	return page;
+	return folio_file_page(folio, index);
 }
 
 static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
-- 
2.35.1

