Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D115364EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353096AbiE0Put (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348214AbiE0Puo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2745134E1B
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/scZq8fB5tdsLNMW65ChH7dPhcyWv6zstS+3cc3hsxY=; b=urDGnyxvX8yXiBntCrqDbG+kik
        bTATo/TsnGYgW+eT8sVwSjzWII/uwrfzwA77CQNR3VViFlgQgj9sNn4ubHmW26v5gIdnqy6H29/cU
        dNEYvGhmuOpddHVSMPnldrTT5ATdBJWJhzNTcQuTzhxzU0t2KSCT8VRNmoFG/41icFy7vrsCN6ZSM
        oxjGflq+96BlbzU5J/SuBTPCJhalvYx4qWDtg8Kv7yiU25eCYY1znpVZmCqvTSLK1HGOPL23m+zMD
        wynkpG0i2m9kgPlRP6t/lWmgrMWhWctsuMetu/rKkLjXLlB06ocSrIMdsqMnO2UrvEwQJDZx8p7g6
        oCem3qDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CWu-7e; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 13/24] ufs: Remove checks for PageError
Date:   Fri, 27 May 2022 16:50:25 +0100
Message-Id: <20220527155036.524743-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

If read_mapping_page() encounters an error, it returns an errno, not
a page with PageError set, or a page that is not Uptodate, so this is
dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c  |  2 +-
 fs/ufs/util.c | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index b721d0bda5e5..391efaf1d528 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -193,7 +193,7 @@ static struct page *ufs_get_page(struct inode *dir, unsigned long n)
 	if (!IS_ERR(page)) {
 		kmap(page);
 		if (unlikely(!PageChecked(page))) {
-			if (PageError(page) || !ufs_check_page(page))
+			if (!ufs_check_page(page))
 				goto fail;
 		}
 	}
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 4fa633f84274..08ddf41eaaad 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -264,17 +264,6 @@ struct page *ufs_get_locked_page(struct address_space *mapping,
 			put_page(page);
 			return NULL;
 		}
-
-		if (!PageUptodate(page) || PageError(page)) {
-			unlock_page(page);
-			put_page(page);
-
-			printk(KERN_ERR "ufs_change_blocknr: "
-			       "can not read page: ino %lu, index: %lu\n",
-			       inode->i_ino, index);
-
-			return ERR_PTR(-EIO);
-		}
 	}
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, 1 << inode->i_blkbits, 0);
-- 
2.34.1

