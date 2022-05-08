Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891FF51F176
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiEHUgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiEHUd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CCE03D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mjyfBTpOJgCBlOyjPfFUjVzjlrihQGqwX4FhlGxYBRo=; b=Y1dxK57aYXMNMEA75aZHSm7ZDe
        MRfh+5b8AzD7HJWlGScFfyL8ywqi5vW+nRCeHzggNucYikeDkk6LZ5+y2ckCiSxRkGwOnszXN3tfg
        uF/007czMdtgjUGYsmt7f42ZWw+O8jT+xGb4ILA8vmGZnvcyHvBsFvuKiZb/g7ndr4v2QeFb8D5QV
        TH28S4IWPG0RtqaXXRFPZvzWHXWcFi97aVmObckYRkbLBDfttohptMGqfkL9XNE5bW8NSPYwnWQVJ
        8uUs/JJULIK/zXT2aPoq4yZfqEA/Q5YV5zhhxMCWX9iIA5CFRj+a+IeYyCEtC/FsDxvrQ6THmO8gv
        dpqiL51w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXU-002na4-JA; Sun, 08 May 2022 20:30:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 25/25] fs: Remove pagecache_write_begin() and pagecache_write_end()
Date:   Sun,  8 May 2022 21:29:41 +0100
Message-Id: <20220508202941.667024-26-willy@infradead.org>
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

These wrappers have no more users; remove them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 12 ------------
 mm/filemap.c       | 20 --------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a0e73432526f..b35ce086a7a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -380,18 +380,6 @@ struct address_space_operations {
 
 extern const struct address_space_operations empty_aops;
 
-/*
- * pagecache_write_begin/pagecache_write_end must be used by general code
- * to write into the pagecache.
- */
-int pagecache_write_begin(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata);
-
-int pagecache_write_end(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
-
 /**
  * struct address_space - Contents of a cacheable, mappable object.
  * @host: Owner, either the inode or the block_device.
diff --git a/mm/filemap.c b/mm/filemap.c
index 0751843b052f..c15cfc28f9ce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3622,26 +3622,6 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
 }
 EXPORT_SYMBOL(read_cache_page_gfp);
 
-int pagecache_write_begin(struct file *file, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata)
-{
-	const struct address_space_operations *aops = mapping->a_ops;
-
-	return aops->write_begin(file, mapping, pos, len, pagep, fsdata);
-}
-EXPORT_SYMBOL(pagecache_write_begin);
-
-int pagecache_write_end(struct file *file, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata)
-{
-	const struct address_space_operations *aops = mapping->a_ops;
-
-	return aops->write_end(file, mapping, pos, len, copied, page, fsdata);
-}
-EXPORT_SYMBOL(pagecache_write_end);
-
 /*
  * Warn about a page cache invalidation failure during a direct I/O write.
  */
-- 
2.34.1

