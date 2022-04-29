Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AEF5151CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379236AbiD2R3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359830AbiD2R3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D797BAE
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oOCFSTQjXi3I8TjZeXPYoY2HCI8zdIL+BInag5eurSU=; b=hBU+Wpmqa6wAtE97xy8l3furtm
        fcJ1GHhvjVXPx3RYOdkuqfWgrDOUd+ZRNfiPJjmIlpcZSbyhoGZ/RT1WLUtYh4NZMRTLpJ7x3/Jvw
        1lNJ6q4Qrxx5PfVQiyGKYPsQasWjvOZgwczFnlaOIuFHUE0hJGXTqvZnyCr3CHzaUXukzwoJzQkce
        t97zDVNAEYJGeqoyYNidqqtccRdyeBUjQdzOKEL3Yi859CSPRQCxUzZY8dF4Xyp1+o2ZWqpPhtelF
        P/SzuhRk9fxjbXMVw76lc20V4lGoTF2XEaOpFMGKtBuBZr+kZeEOpOxDfppiDl6EiRayYes+Z3bJn
        SbxomobA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNW-00CdXD-G8; Fri, 29 Apr 2022 17:26:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/69] namei: Convert page_symlink() to use memalloc_nofs_save()
Date:   Fri, 29 Apr 2022 18:24:51 +0100
Message-Id: <20220429172556.3011843-5-willy@infradead.org>
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

