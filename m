Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4070B51F13B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiEHUeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiEHUd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6A101DA
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oOCFSTQjXi3I8TjZeXPYoY2HCI8zdIL+BInag5eurSU=; b=Vr6JlJj2cCX7SBNYjFbQTwat9h
        o98IGrUaq+/QGIMr6H+Mq/XTcArH4lYBZj44FauHAPhoJo1tPzuZ5z/482lgp5GHKqtca/9GWGoVb
        2uPvliXCLsvg6Szl8RPDNJDntMD7iYwLq7F0eHtq7AV0nc8T5mMHWk5T7GL0c2hWulf4WeujMeDm0
        LLeMw4T2WMCNt5XEkMdbXYGzyDxLQR6CX4092OAqlNDCzHp+pvw0CgdoTrqHg7YePbpI36JGB2h0K
        LBfXx08og15t/A8tEtS6vgBYZojcYqsZxZZmA0xPAPQVAV2fs2z3oZa8qF+qkWhwiuQ1YXNF84jKE
        Avn0bvqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nXz-2H; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/25] namei: Convert page_symlink() to use memalloc_nofs_save()
Date:   Sun,  8 May 2022 21:29:19 +0100
Message-Id: <20220508202941.667024-4-willy@infradead.org>
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

Stop using AOP_FLAG_NOFS in favour of the scoped memory API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6153581073b1..0c84b4326dc9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
+#include <linux/sched/mm.h>
 #include <linux/fsnotify.h>
 #include <linux/personality.h>
 #include <linux/security.h>
@@ -5008,13 +5009,15 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 	struct page *page;
 	void *fsdata;
 	int err;
-	unsigned int flags = 0;
-	if (nofs)
-		flags |= AOP_FLAG_NOFS;
+	unsigned int flags;
 
 retry:
+	if (nofs)
+		flags = memalloc_nofs_save();
 	err = pagecache_write_begin(NULL, mapping, 0, len-1,
-				flags, &page, &fsdata);
+				0, &page, &fsdata);
+	if (nofs)
+		memalloc_nofs_restore(flags);
 	if (err)
 		goto fail;
 
-- 
2.34.1

