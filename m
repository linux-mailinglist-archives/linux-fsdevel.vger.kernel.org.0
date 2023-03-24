Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8276C843A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjCXSCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjCXSCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18386EA1;
        Fri, 24 Mar 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bu7uZgrjAEFRngwiRJYcdU86axyjwDNbBJmyJgRwmhM=; b=NEvm3VMZhlPIbzOespe1UXoX4S
        zCCIQmHHAOgmSMVOEBlyXlq2gsvo0HX8qeYfnT+m/tlit0lVhmdERTeGJtMY5lhaZf7IcS4Oc+iaO
        SL8/4mIvbq9NuK9LwmpqkLmlhOlDpZy+mLsAmm/SvcckPU0oEjKpIkEfcIFNbGc9R1YmRzh78/3iC
        ZOE37vPvfNbv9mnUQbqz9UUhO7aeVIXKVTI8Ex+XjMKnh7ORmgrjL5bu4BWGWMmTZg/Gexz1zPXmc
        5EyxfzohLaxddLMtCICBREv+kRUskdnfOhdr/jRKJxWPLvsdI6VUJWrEt5ggzeXG1RPaJ6yXPv3Pe
        lerVLo6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057Ze-2C; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/29] ext4: Convert ext4_try_to_write_inline_data() to use a folio
Date:   Fri, 24 Mar 2023 18:01:11 +0000
Message-Id: <20230324180129.1220691-12-willy@infradead.org>
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
 fs/ext4/inline.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f339340ba66c..881d559c503f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -653,8 +653,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 {
 	int ret;
 	handle_t *handle;
-	unsigned int flags;
-	struct page *page;
+	struct folio *folio;
 	struct ext4_iloc iloc;
 
 	if (pos + len > ext4_get_max_inline_size(inode))
@@ -691,28 +690,27 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
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
2.39.2

