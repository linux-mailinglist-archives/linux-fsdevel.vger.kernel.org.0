Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971315151D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379620AbiD2R3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379288AbiD2R3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32B9AE5E
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=j+3bGVW2lhzCFFuW8GzV5oNJ7nLQ6ySvvt58EVwwUTQ=; b=klXAgMOy7K0g61XphDkuIqIRqi
        JcJYY+x4vyHvBxe2fKlU5j2xtxO7qFbBFaGmHo8JAq01q/z6wHP6o64TmxIuBJ3FtOtHAbW/o5bMs
        XpPwfF7xZLR/l0sca5b7AO/ryphM06rMl6wne8fhWtXMv99LcOh4LLteTgHO2MUp5bwk3dLitcmiV
        ax0ajMzDAIexcLoODpXm1AKq8KvM/U2iSWgps0skVK8pz7b56fkLVsfLBWy7sWxgbhY8TgDXxbjcb
        IhGg5BruRx+cQ7vTA28j6ODoanzXJ+lBcK8oO+M2F9qta6HFU+rB8+oqRd/e/o47OrN5QghN8UNtQ
        4HOYcsww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNX-00CdYA-LK; Fri, 29 Apr 2022 17:26:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/69] fs: Remove aop flags parameter from nobh_write_begin()
Date:   Fri, 29 Apr 2022 18:25:02 +0100
Message-Id: <20220429172556.3011843-16-willy@infradead.org>
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

There are no more aop flags left, so remove the parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c                 | 3 +--
 fs/ext2/inode.c             | 2 +-
 fs/jfs/inode.c              | 3 +--
 include/linux/buffer_head.h | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 01630218c75f..02b50e3e4fbb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2568,8 +2568,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
  * On exit the page is fully uptodate in the areas outside (from,to)
  * The filesystem needs to handle block truncation upon failure.
  */
-int nobh_write_begin(struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+int nobh_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata,
 			get_block_t *get_block)
 {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 97192932ea56..bfa69c52ce2c 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -917,7 +917,7 @@ ext2_nobh_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = nobh_write_begin(mapping, pos, len, flags, pagep, fsdata,
+	ret = nobh_write_begin(mapping, pos, len, pagep, fsdata,
 			       ext2_get_block);
 	if (ret < 0)
 		ext2_write_failed(mapping, pos + len);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index d1943a7b4b04..e16f77b4e84c 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -319,8 +319,7 @@ static int jfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = nobh_write_begin(mapping, pos, len, flags, pagep, fsdata,
-				jfs_get_block);
+	ret = nobh_write_begin(mapping, pos, len, pagep, fsdata, jfs_get_block);
 	if (unlikely(ret))
 		jfs_write_failed(mapping, pos + len);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 127b60fad77e..6e5a64005fef 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -258,7 +258,7 @@ static inline vm_fault_t block_page_mkwrite_return(int err)
 }
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
-int nobh_write_begin(struct address_space *, loff_t, unsigned, unsigned,
+int nobh_write_begin(struct address_space *, loff_t, unsigned len,
 				struct page **, void **, get_block_t*);
 int nobh_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
-- 
2.34.1

