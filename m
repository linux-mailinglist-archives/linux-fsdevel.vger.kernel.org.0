Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843792EEB57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 03:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAHCh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 21:37:26 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56864 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbhAHCh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:37:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UL0x81H_1610073402;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UL0x81H_1610073402)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Jan 2021 10:36:43 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     miklos@szeredi.hu, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap: Remove unused parameter and change to void type for replace_page_cache_page()
Date:   Fri,  8 Jan 2021 10:36:34 +0800
Message-Id: <609c30e5274ba15d8b90c872fd0d8ac437a9b2bb.1610071401.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 74d609585d8b ("page cache: Add and replace pages using the XArray")
was merged, the replace_page_cache_page() can not fail and always return
0, we can remove the redundant return value and void it. Moreover remove
the unused gfp_mask.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 fs/fuse/dev.c           | 6 +-----
 include/linux/pagemap.h | 2 +-
 mm/filemap.c            | 7 +------
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 588f8d1..c6636b4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -844,11 +844,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(PageMlocked(oldpage)))
 		goto out_fallback_unlock;
 
-	err = replace_page_cache_page(oldpage, newpage, GFP_KERNEL);
-	if (err) {
-		unlock_page(newpage);
-		goto out_put_old;
-	}
+	replace_page_cache_page(oldpage, newpage);
 
 	get_page(newpage);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d5570de..74e466e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -757,7 +757,7 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern void delete_from_page_cache(struct page *page);
 extern void __delete_from_page_cache(struct page *page, void *shadow);
-int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
+void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 5c9d564..e4906f5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -775,7 +775,6 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
  * replace_page_cache_page - replace a pagecache page with a new one
  * @old:	page to be replaced
  * @new:	page to replace with
- * @gfp_mask:	allocation mode
  *
  * This function replaces a page in the pagecache with a new one.  On
  * success it acquires the pagecache reference for the new page and
@@ -784,10 +783,8 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
  * caller must do that.
  *
  * The remove + add is atomic.  This function cannot fail.
- *
- * Return: %0
  */
-int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
+void replace_page_cache_page(struct page *old, struct page *new)
 {
 	struct address_space *mapping = old->mapping;
 	void (*freepage)(struct page *) = mapping->a_ops->freepage;
@@ -822,8 +819,6 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	if (freepage)
 		freepage(old);
 	put_page(old);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-- 
1.8.3.1

