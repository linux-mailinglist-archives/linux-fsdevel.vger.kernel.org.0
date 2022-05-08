Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7351F139
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiEHUeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiEHUdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C2FD14
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KXbqSvumSVrPe8vjC4VZrIVjZd7wuuA9EJ+sQnxubXQ=; b=iweou21U6QlCnmDrLdZE3EA3xN
        CiqNZ+rBRi12PvfegyIs3/id9PhaPjdxGvhd4qH1tydwL3P7UZ5CprC7M54HN6pH4lcG4pmtPRyRU
        RuDi16qqhUCiZJ3TVeYGVIARAmrKGC3Pw6d2Z80z6IHy1Q2YC3HCnq34H9LxJ2kLGQnoL8x5vGDDc
        GpwQ/3a+78DePpGrgsHTRypTC6Bd0Akg8tWnOPs/LBK0TfPO5ENd45ng/lPqw5a5eXSrxjmS4A++z
        OFh3gMl0+tKWt2QDryUnYVZ9p+U+Q4k2GtJNESMI0og4UzCB+Qiw77F1HVdQQP3JTQ9m/4p4y8ets
        zLO0sDgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nY2-4B; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/25] f2fs: Convert f2fs_grab_cache_page() to use scoped memory APIs
Date:   Sun,  8 May 2022 21:29:20 +0100
Message-Id: <20220508202941.667024-5-willy@infradead.org>
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

Prevent GFP_FS allocations by using memalloc_nofs_save() instead
of AOP_FLAG_NOFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/f2fs.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8c570de21ed5..74929ade4b5e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -18,6 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
+#include <linux/sched/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -2654,6 +2655,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 						pgoff_t index, bool for_write)
 {
 	struct page *page;
+	unsigned int flags;
 
 	if (IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION)) {
 		if (!for_write)
@@ -2673,7 +2675,12 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 
 	if (!for_write)
 		return grab_cache_page(mapping, index);
-	return grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
+
+	flags = memalloc_nofs_save();
+	page = grab_cache_page_write_begin(mapping, index, 0);
+	memalloc_nofs_restore(flags);
+
+	return page;
 }
 
 static inline struct page *f2fs_pagecache_get_page(
-- 
2.34.1

