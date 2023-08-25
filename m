Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AA788FA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHYUNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjHYUNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:13:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8B2689;
        Fri, 25 Aug 2023 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NhZK7lLhyk1gRe/kDzCl/6wBwOFUa/J4bfVtj1z1BGk=; b=BfG3iH95OkyxsHjnevHbNmBLJF
        xvKrvD7QQr1LEPQDNFzwzKYzIJkNROUQfDth4mjt811sQQwUOgPlcfqk6CK+9kVZAtttVOpZJRtRY
        v6fOi9ODw/OvVxpotx8yF90gmcFNJ8nVwf55iCLkLsvein5Mz1URQi3/7mdHQhjg5E7RWaJs3HQvu
        YbzSr7krevkEL/4TOAhOIU3s+zlXHuZybB9tDetftvI7q28cuBS4zFIotQG9UV0IdiUYrwbPhxhZs
        3ZuRpzHhX5iu8xvadXGlUYdqepYCnpPTCFYEWUSDEgKGzwUegB096fADo08sdd34jUaUJGuGw6F0o
        FbQKU4tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZi-9V; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/15] mm: Delete page_mkwrite_check_truncate()
Date:   Fri, 25 Aug 2023 21:12:13 +0100
Message-Id: <20230825201225.348148-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
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

All users of this function have been converted to
folio_mkwrite_check_truncate().  Remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 351c3b7f93a1..f43a0e05b092 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1491,34 +1491,6 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
 	return offset;
 }
 
-/**
- * page_mkwrite_check_truncate - check if page was truncated
- * @page: the page to check
- * @inode: the inode to check the page against
- *
- * Returns the number of bytes in the page up to EOF,
- * or -EFAULT if the page was truncated.
- */
-static inline int page_mkwrite_check_truncate(struct page *page,
-					      struct inode *inode)
-{
-	loff_t size = i_size_read(inode);
-	pgoff_t index = size >> PAGE_SHIFT;
-	int offset = offset_in_page(size);
-
-	if (page->mapping != inode->i_mapping)
-		return -EFAULT;
-
-	/* page is wholly inside EOF */
-	if (page->index < index)
-		return PAGE_SIZE;
-	/* page is wholly past EOF */
-	if (page->index > index || !offset)
-		return -EFAULT;
-	/* page is partially inside EOF */
-	return offset;
-}
-
 /**
  * i_blocks_per_folio - How many blocks fit in this folio.
  * @inode: The inode which contains the blocks.
-- 
2.40.1

