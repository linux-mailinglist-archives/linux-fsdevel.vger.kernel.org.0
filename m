Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D767D628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjAZUY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjAZUYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A04AA49;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VlaXoQTjOKuL56Vm7lVE3emEdqOQU4UkXh98jLQo7SQ=; b=rRUYxIkfc7aXhsx2YPaasFSahL
        zU6w6tdjoXRPLbUpmKa8yY2VuLszht2OFek+4kitNAqmkZmjbRnd2Jc5p9uPE0ZpCTObfPATRt8DP
        246fqJkJYZu7xOx4pp81dliTrm//CFxdf6TZXoQR7kCtRa23g8Lx2tEMe13limZgD0GY/oKn4BdUq
        Zy/I3W8iH28mFQGMvqb+S5G+04dlIpsxhNQIn4DEFqYhfJQQ62AUbC3QsvjVWYjjIGTaXyOgPZcuI
        wf5/K8rOr9kgdla0mDLbgi39V54mb7uCAVstCl/En/HE1hf7WHSkQHH/AYxDhlFFTtWA5OVsF8R56
        O832S9Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073jz-KV; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/31] ext4: Convert ext4_da_convert_inline_data_to_extent() to use a folio
Date:   Thu, 26 Jan 2023 20:23:56 +0000
Message-Id: <20230126202415.1682629-13-willy@infradead.org>
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
 fs/ext4/inline.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 6d136353ccc2..99c77dd519f0 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -849,10 +849,11 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 						 void **fsdata)
 {
 	int ret = 0, inline_size;
-	struct page *page;
+	struct folio *folio;
 
-	page = grab_cache_page_write_begin(mapping, 0);
-	if (!page)
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN,
+					mapping_gfp_mask(mapping));
+	if (!folio)
 		return -ENOMEM;
 
 	down_read(&EXT4_I(inode)->xattr_sem);
@@ -863,32 +864,32 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 
 	inline_size = ext4_get_inline_size(inode);
 
-	if (!PageUptodate(page)) {
-		ret = ext4_read_inline_page(inode, page);
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_page(inode, &folio->page);
 		if (ret < 0)
 			goto out;
 	}
 
-	ret = __block_write_begin(page, 0, inline_size,
+	ret = __block_write_begin(&folio->page, 0, inline_size,
 				  ext4_da_get_block_prep);
 	if (ret) {
 		up_read(&EXT4_I(inode)->xattr_sem);
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		ext4_truncate_failed_write(inode);
 		return ret;
 	}
 
-	SetPageDirty(page);
-	SetPageUptodate(page);
+	folio_mark_dirty(folio);
+	folio_mark_uptodate(folio);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	*fsdata = (void *)CONVERT_INLINE_DATA;
 
 out:
 	up_read(&EXT4_I(inode)->xattr_sem);
-	if (page) {
-		unlock_page(page);
-		put_page(page);
+	if (folio) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	return ret;
 }
-- 
2.35.1

