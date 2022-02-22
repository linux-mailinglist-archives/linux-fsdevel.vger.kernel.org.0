Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FDC4C024D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiBVTs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiBVTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C382B7C57
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/yoEhXEZnAhq2NRlbtpxqp7JFmDuXAB8X8kG8LFVfsE=; b=cSSN7jwmbo++BRDK3oMgjgYVvQ
        hNneo+4awO1auHGdWY+M48CvVZtlUx5Z+L0WaubViJLNZC8HDZXHl7CAtDpAP0wL5q1H69FpOXP3t
        bssmNcFIq1ohL8FHi4LRxleEavIxlExLpwLNK/Ti/sWKuathVrlKnVJcfsiSHrTai2BfrWgltI8Jn
        XExBhDIbs2A6QxOs5UfH5A4EbgqUFyFeWBbgTgOHhQEfeKbtNvk/zDe1ga0M5Slpxmw29sgeLjKvz
        GPPxJJ/ppfJeor118wOpxe8VZzOfkOuJfUysJ2wtOib8y9Qg1/e196zFQsWiyetAigX/AiPWlo+fc
        rB97fjlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zz-Qk; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/22] f2fs: Convert f2fs_grab_cache_page() to use scoped memory APIs
Date:   Tue, 22 Feb 2022 19:48:06 +0000
Message-Id: <20220222194820.737755-9-willy@infradead.org>
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

Prevent GFP_FS allocations by using memalloc_nofs_save() instead
of AOP_FLAG_NOFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51ba0f8ffd86..324553da3bdd 100644
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
@@ -2557,6 +2558,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 						pgoff_t index, bool for_write)
 {
 	struct page *page;
+	unsigned int flags;
 
 	if (IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION)) {
 		if (!for_write)
@@ -2576,7 +2578,12 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 
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

