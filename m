Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BF5151D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379513AbiD2R31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376912AbiD2R3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906898593
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ATnuT7N0epb/e80siA2Nrn8r9Wwz8RTRUGV2l5yaIvs=; b=MfzfO2F8yxV9alwNEz7a8TBUaA
        IYq5uTh1879Jo6ekmx+r/i9Nb1repBKAW1PAJYQX0bbKkeggi/sa9TDfhCaI7naGYuSjMYUhs+OEC
        7NTRhLeunnd8ILSr2+MM1zva2qMOmFB4M5ChTsTDn2tedMGuu3gKVmM3HhDS3x/4qLAkADVTZx9Ao
        lYIwb8QAgQkNg6Qbdf2d7Kv6RYF0sUesVJqzW9nyfAbON+yl2tTYRK1qt6E1LlaQVeU/q01Z3BZZ3
        27GoFt9+lp8uCKRA+bEiuI2waKLteeFEdWSVnCn8Fbp3r4SxUFthvFmVT/JsAiFjfaj92zZUAhg4M
        CJt3m/Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNW-00CdXH-KC; Fri, 29 Apr 2022 17:26:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 06/69] ext4: Allow GFP_FS allocations in ext4_da_convert_inline_data_to_extent()
Date:   Fri, 29 Apr 2022 18:24:53 +0100
Message-Id: <20220429172556.3011843-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

