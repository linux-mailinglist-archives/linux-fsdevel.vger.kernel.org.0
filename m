Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539EE51F136
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiEHUeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiEHUdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EADFEA
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=j+3bGVW2lhzCFFuW8GzV5oNJ7nLQ6ySvvt58EVwwUTQ=; b=qWHbXGKfdXXyfRsNIK6gTPSpVu
        KFhPUrWBbpi38W4kZQ/2e1LS4jQZ+x1pFYhoZEAgR6HdG3+28mUCESV778EK8le8I3JQkmM10hz5G
        smsT6HsEVfnsg7hWKOtyt7woUwjuh24HszIKpNsEBAvTaQr6oMwv7F+NCqhFDkD5G3cGLODkjE3/I
        RXClbsMW7HcQ87XBy0KK5OD1EpZoSNg2dnSEwTuORvrnWd4JWBe7Lxb2A+LIk3RmJtxWo5Tlb59y+
        YEL61CdyGOtOuXoz76Z2cxNJa5TmWtx5MK2MHZze2eJpZuMG97dqzOYhA5M/fMwuuMu1S3nOprwQx
        u4wb9S2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nYt-6f; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/25] fs: Remove aop flags parameter from nobh_write_begin()
Date:   Sun,  8 May 2022 21:29:30 +0100
Message-Id: <20220508202941.667024-15-willy@infradead.org>
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

