Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9E51F147
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiEHUfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiEHUfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A2F11C21
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=24r5qBa2K9kdSpr8a5wiX6HOHkhvzVD8N6+FOaeX2XI=; b=vkhsR79jb+OpS/ovgIwuejgvez
        aVU2dfspvF/KhqZbamCFukVLIfcRPsgVIn/5MwVWHVztDenlYxAmhpOBoiVgpK6yk2eA/gcyJWCeS
        56W/Wd0Tkl8BO4c9DmDqirChoQasYoFGQ1E/tpKdOtgYCd50rOaW40ohL138SDUYPuYlSXJHF6duD
        CJbNY4tCcnlDRJzXuZjyR9Dnk7CHGLbaO1RnSyRJRL5eqdAR5dK/gieE8JwbQ427qrJ+od1huyNDh
        XcNMI/k5SFA2ozWCcF+H9g0y5p0iuK2UWkNb+9z1r5J2ZRFSwDDT0/q3l5hABwrwV4Y3LsgnxH/1k
        GIiMSQVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYL-002nhy-93; Sun, 08 May 2022 20:30:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] filemap: Remove obsolete comment in lock_page
Date:   Sun,  8 May 2022 21:30:46 +0100
Message-Id: <20220508203048.667631-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203048.667631-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203048.667631-1-willy@infradead.org>
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

From: Miaohe Lin <linmiaohe@huawei.com>

We no longer need the page's inode pinned.  This comment dates back to
commit db37648cd6ce ("[PATCH] mm: non syncing lock_page()") which added
lock_page_nosync().  That was removed by commit 7eaceaccab5f ("block:
remove per-queue plugging") which also made this comment obsolete.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 65ae8f96554b..ab47579af434 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -908,9 +908,6 @@ static inline void folio_lock(struct folio *folio)
 		__folio_lock(folio);
 }
 
-/*
- * lock_page may only be called if we have the page's inode pinned.
- */
 static inline void lock_page(struct page *page)
 {
 	struct folio *folio;
-- 
2.34.1

