Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C536C844B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjCXSDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjCXSCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7621977;
        Fri, 24 Mar 2023 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MGN3vFL81QYuszytlukf8a9MbfEwpRsuaQzu7+5vdaU=; b=oi92BTxA6u8dXfMwKg/pLsiVDj
        aDi/pFFCfSabzwfN5kU9B0Arotv/QOXcotcy4OR9AIacmvqHTQiHArcjjLKuIRxuGXnDmju65ZIJx
        xGmQx8VmwM3IOSCvztMRvNuyzYnJ1SHHB4IUkca+/Liq5VZl2n6a5evkG1MgcA6xL3ZXOBiZHpCPD
        BHa4Z1o9zyVykFhKpBkODoLHNcHgz0jnUGDNLeo0DKaZVB404vCJmQmRskU2tKXMhqKLZJctttYRX
        PGIw8cKYC2bhWn1gVkq1zsFRfuVPTU+YEbehe8lj17SElzw44Dl5QHAuNJCw5axvNfnYqa+4tSsAE
        HIuCAZvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057Zk-72; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/29] ext4: Convert ext4_da_convert_inline_data_to_extent() to use a folio
Date:   Fri, 24 Mar 2023 18:01:12 +0000
Message-Id: <20230324180129.1220691-13-willy@infradead.org>
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
 fs/ext4/inline.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 881d559c503f..45d74274d822 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -848,10 +848,11 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
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
@@ -862,32 +863,32 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 
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
2.39.2

