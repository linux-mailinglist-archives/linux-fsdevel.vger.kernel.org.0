Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0851F175
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiEHUgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiEHUd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74067101E6
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ATnuT7N0epb/e80siA2Nrn8r9Wwz8RTRUGV2l5yaIvs=; b=DW5TTMIP7qv0biJnw4pK6nWddW
        fJ9UCSfpjFYUw9BEVHgwLdmc/+ZuvTdneiHMVGE4xBIzf8/xrVnEicQ/9arAyateGHTTPS5EO6Ey8
        mvV72sO8ocakc0DeUXYqEBZqwYHoIdKlx9oDELfOANHvFOUrYCml8PembGE1EYCQfbBpjqLZMPdmw
        kIc3yUvfrWxZ0be05oXAsqTMIrsfT/EG3KFT4+9yL4PiLzycKZQp3QM24zq3hMlG8vqEM32b8+3HQ
        0DII8nKa7cGzOODDKwil3B09yopaBGVMStz+EsT6R6TLOXCdVeTGDrPdOei1O6kmDnzIl96rk9pu0
        ROAKoU1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nY4-6d; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 05/25] ext4: Allow GFP_FS allocations in ext4_da_convert_inline_data_to_extent()
Date:   Sun,  8 May 2022 21:29:21 +0100
Message-Id: <20220508202941.667024-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
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

Since commit 8bc1379b82b8, the transaction is stopped before calling
ext4_da_convert_inline_data_to_extent(), which means we can do GFP_FS
allocations and recurse into the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9c076262770d..93694ceb5a34 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -848,13 +848,12 @@ ext4_journalled_write_inline_data(struct inode *inode,
  */
 static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 						 struct inode *inode,
-						 unsigned flags,
 						 void **fsdata)
 {
 	int ret = 0, inline_size;
 	struct page *page;
 
-	page = grab_cache_page_write_begin(mapping, 0, flags);
+	page = grab_cache_page_write_begin(mapping, 0, 0);
 	if (!page)
 		return -ENOMEM;
 
@@ -942,7 +941,6 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		ext4_journal_stop(handle);
 		ret = ext4_da_convert_inline_data_to_extent(mapping,
 							    inode,
-							    flags,
 							    fsdata);
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
-- 
2.34.1

