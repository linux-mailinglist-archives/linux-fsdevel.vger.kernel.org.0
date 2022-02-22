Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC044C0251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiBVTtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiBVTsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ECFB82F5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1Ve8jTfpx2CA/un383Ws0DtrzQjZwvjgsaXvNkw2F7M=; b=a5S+PjxTDL/vnClhauX5xmSEpm
        GFbcND/D9TiEIUWBKhxnklYw2tKP+rYvEvE9k29LzeqKnmYEPfFTSbOAacSXEhygKuV3vz8mKsXcs
        +AVzA1YeZROmajbJsPP1f3tLq+vcWnqjhj9GpZfbzd56G94qSn2jPsFG3JLIpXD23/apoi+qchzT2
        MSbUdM9BQRJN5TeZBUJRhT3K9vjG5JCMSRExs82HvnIMBu4c22kxoBOjdybyIhWKePHyIFe7LrtZj
        1H8lfpZLLez6eSHTY2UD5h9YMugUb7ZK1q1LTNp/rmIWIhUCVGAhFmOtFJalAQU17ljwmmMgvfLfc
        8+5oFoEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb96-00360A-2b; Tue, 22 Feb 2022 19:48:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/22] ext4: Use scoped memory API in mext_page_double_lock()
Date:   Tue, 22 Feb 2022 19:48:08 +0000
Message-Id: <20220222194820.737755-11-willy@infradead.org>
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

Replace use of AOP_FLAG_NOFS with calls to memalloc_nofs_save()
and memalloc_nofs_restore().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 95aa212f0863..56f21272fb00 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/slab.h>
+#include <linux/sched/mm.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include "ext4_extents.h"
@@ -127,7 +128,7 @@ mext_page_double_lock(struct inode *inode1, struct inode *inode2,
 		      pgoff_t index1, pgoff_t index2, struct page *page[2])
 {
 	struct address_space *mapping[2];
-	unsigned fl = AOP_FLAG_NOFS;
+	unsigned int flags;
 
 	BUG_ON(!inode1 || !inode2);
 	if (inode1 < inode2) {
@@ -139,11 +140,15 @@ mext_page_double_lock(struct inode *inode1, struct inode *inode2,
 		mapping[1] = inode1->i_mapping;
 	}
 
-	page[0] = grab_cache_page_write_begin(mapping[0], index1, fl);
-	if (!page[0])
+	flags = memalloc_nofs_save();
+	page[0] = grab_cache_page_write_begin(mapping[0], index1, 0);
+	if (!page[0]) {
+		memalloc_nofs_restore(flags);
 		return -ENOMEM;
+	}
 
-	page[1] = grab_cache_page_write_begin(mapping[1], index2, fl);
+	page[1] = grab_cache_page_write_begin(mapping[1], index2, 0);
+	memalloc_nofs_restore(flags);
 	if (!page[1]) {
 		unlock_page(page[0]);
 		put_page(page[0]);
-- 
2.34.1

