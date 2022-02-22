Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C204C024B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiBVTsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiBVTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB6B82D8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gvwyCCNYqAXOeP45u3vWzXmwy6meRfdaKWb8zbQHv+c=; b=RJxAkW8bkCQ2hVcV9i6+txcVpy
        RYssn3Kc3dwAxWpbSIBhHlfYI9h+PT3jNy6GYbYxhyYbOHcl3sP2NbSLZI1o4/C7TRk2TI8REo0Zo
        U8rNpSUdj6jF/UEG32ofxXlX1kjby7DH58S64yC9HUryws8jdjgVGs/6zENWXzs5hIkJ76aNKkwyb
        +IWV5i5SFvzyEaVJ0LInBQJXvHcMjcMr86GejN3ibx3P0SLr8Wi4TddYvXI9cnDE1Bo+7MQPRVukU
        GKZVdZAy+QJ3U0yUNxAHUJQx9rUSraP9mj8k1kUx0r1NeV/qVF9U+TIJA6sRvu1g3ExlcW6cQV149
        QhQTMRJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-003605-Ue; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/22] ext4: Allow GFP_FS allocations in ext4_da_convert_inline_data_to_extent()
Date:   Tue, 22 Feb 2022 19:48:07 +0000
Message-Id: <20220222194820.737755-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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
---
 fs/ext4/inline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e42941803605..7865fe136b66 100644
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

