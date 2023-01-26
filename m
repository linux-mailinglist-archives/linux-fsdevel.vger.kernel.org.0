Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBD67D624
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjAZUYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjAZUYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268A49954;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eRdVjrXjCbsfnXq/P5UITQIPfitOB84uZkudpPQpvRI=; b=dOEAdlfR7LrVqTsxal7rq0vVqo
        pnGruQvnm/Njw+TzuGcmgsV3VH+tfeokmzNbizx9QIcgnS2i6W+XLPwR5j1V0UZqx7miQP2YjLmbJ
        MSIshv/qyb1E2F156QoO/IXdk/2cueRtH0p8K03up9Xrp6qJMEUJCyD6KRVzhS+I3i7U7prFKOs83
        wrYDm3YTTsEH8OH4s3bWvgZXPYCfrSnD+kW+yYYmSCyOfjyyLG2ZQJf4igvwIme4JYi3ihNRhrbt8
        Sxaf+XzIfHaWXn6vRlB4TiP4LZVHMW+aFQyDeA5j9WmHoLJCoNS2EvDHg/1ke57HCxjrd2FTqB3Pu
        dLF/CmBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073jt-Fv; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/31] ext4: Convert ext4_try_to_write_inline_data() to use a folio
Date:   Thu, 26 Jan 2023 20:23:55 +0000
Message-Id: <20230126202415.1682629-12-willy@infradead.org>
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

Saves a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2091077e37dc..6d136353ccc2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -654,8 +654,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 {
 	int ret;
 	handle_t *handle;
-	unsigned int flags;
-	struct page *page;
+	struct folio *folio;
 	struct ext4_iloc iloc;
 
 	if (pos + len > ext4_get_max_inline_size(inode))
@@ -692,28 +691,27 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	if (ret)
 		goto out;
 
-	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0);
-	memalloc_nofs_restore(flags);
-	if (!page) {
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+					mapping_gfp_mask(mapping));
+	if (!folio) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	*pagep = page;
+	*pagep = &folio->page;
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
 		ret = 0;
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		goto out_up_read;
 	}
 
-	if (!PageUptodate(page)) {
-		ret = ext4_read_inline_page(inode, page);
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_page(inode, &folio->page);
 		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			goto out_up_read;
 		}
 	}
-- 
2.35.1

