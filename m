Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8184C024C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiBVTs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiBVTsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB06B6D09
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KX2Y1rXpj6EfP6YlYQuQzg8BK6rB+Vq37BTP0E9iaHE=; b=OBG+vI0ixhND0HS/B/016uo6kM
        68i2OdMK+DBidQpYIu2giiQPf/0W0kWjHm8Rl9AwNLHRof1aaKjS0BgkXg1onjyE6734Pxzp7WdWu
        lw8wMmzbqcinG9jB0HxVjKpxaOwWUcvXgYoixlyJ6bWgQnL/bTN8vTifynmB4xUFvWbg/9YyEOnFc
        VTSaZttXAOF8J0Iklf9T6MI70ElierZA96HWKkSRInITlwBLY5TrwQ8BC3W/RwAyEUJPypVOCF9Uc
        FOIomtERonTSnsfMT0sFyXITMh6Ex0WbxU38oUu9aX78LBsYXXATsaWvKmS4E0glF3/rxlbr6X0xt
        0qHxJ2jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zu-N8; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/22] namei: Convert page_symlink() to use memalloc_nofs_save()
Date:   Tue, 22 Feb 2022 19:48:05 +0000
Message-Id: <20220222194820.737755-8-willy@infradead.org>
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

Stop using AOP_FLAG_NOFS in favour of the scoped memory API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8335dad105b4..4f5c07d5579f 100644
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
@@ -5010,13 +5011,15 @@ int page_symlink(struct inode *inode, const char *symname, int len)
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

