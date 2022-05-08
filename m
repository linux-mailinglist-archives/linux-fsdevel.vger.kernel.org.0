Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1E51F141
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiEHUef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiEHUeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:34:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FE2DFEA
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fs3yjOFU7Is8zXjtGhR6ALd+llANqAadapxJ56oler4=; b=R5gF7mhvclarDN6yQfsbFOwibX
        FvC1lrNybSJ97m1CCRSpNPBe4A8wT/shoNbyw3TrsLaOxcsKl0xaLswsw4ekbFg873e7MUpS91XLG
        YiSwe6TkOBMV/Mr2PyWlRpypwuUcEnJ3749i9JKrJ1qjziO5wp3jxiIyxa091K5jxQQeRbVmLNQ96
        bcZ01KGrHAgpGvfWeIjikHtGrr6vBj/AXY4w7m+aW9EZ4nQUfKFs2MJMDLOEXnVKSHPDBoiI/pnO5
        zv+FAQqrcbfw9sj4zmZs20FQH43O13zDTkkmt1F7zokyd/LxPvKF6TgHbw+Wap3RftyFInx353o1e
        rZkW4JOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nYB-A9; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 06/25] ext4: Use scoped memory API in mext_page_double_lock()
Date:   Sun,  8 May 2022 21:29:22 +0100
Message-Id: <20220508202941.667024-7-willy@infradead.org>
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

Replace use of AOP_FLAG_NOFS with calls to memalloc_nofs_save()
and memalloc_nofs_restore().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
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

