Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5820ADB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgFZIA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 04:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgFZIA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:00:26 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BD9C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ezhqco10KeOfjAoiIeJp8ZFsUZZv4klRDxl4978wMIU=; b=W9AwD1LlVam+C8rBjLB1BojlUJ
        Jkg6Segj5i29ucFF8BN4PG2vl7jdAb/ua+4Wqj+4K0NDu7NMBKgvWx8AyYd7xLCpqIReqOsQZbZIC
        VsIpAqRIVxk2wgA26HdL3YnoCtZoumF+OODKyEwdE4IMNXj1hnHYYOk6nVnhF0cWDWbsZURK7ysn/
        i1p5Znl8w9aSciHgCha3rM67f4Sg39db9fkNwe2TbVXp5MWqOSclsZClR9VWorjwgnYBceUCqhLaY
        QUsRFIo9RN3y5MAJn1l+W7PACIaw9ThYYuqKJziOLD0XLhH8Dncikk7IQt42lTRtYAj7jiOQOc0SW
        GfuU/bBg==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojHO-0007LZ-9J; Fri, 26 Jun 2020 08:00:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: remove the block_size_bits helper
Date:   Fri, 26 Jun 2020 10:00:09 +0200
Message-Id: <20200626080009.1998346-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a trivial wrapper around ilog2, with a totally confusing comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 64fe82ec65ff1f..c89eb509d6049c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1658,19 +1658,6 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 }
 EXPORT_SYMBOL(clean_bdev_aliases);
 
-/*
- * Size is a power-of-two in the range 512..PAGE_SIZE,
- * and the case we care about most is PAGE_SIZE.
- *
- * So this *could* possibly be written with those
- * constraints in mind (relevant mostly if some
- * architecture has a slow bit-scan instruction)
- */
-static inline int block_size_bits(unsigned int blocksize)
-{
-	return ilog2(blocksize);
-}
-
 static struct buffer_head *create_page_buffers(struct page *page, struct inode *inode, unsigned int b_state)
 {
 	BUG_ON(!PageLocked(page));
@@ -1737,7 +1724,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 
 	bh = head;
 	blocksize = bh->b_size;
-	bbits = block_size_bits(blocksize);
+	bbits = ilog2(blocksize);
 
 	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
 	last_block = (i_size_read(inode) - 1) >> bbits;
@@ -1990,7 +1977,7 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 
 	head = create_page_buffers(page, inode, 0);
 	blocksize = head->b_size;
-	bbits = block_size_bits(blocksize);
+	bbits = ilog2(blocksize);
 
 	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
 
@@ -2268,7 +2255,7 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 
 	head = create_page_buffers(page, inode, 0);
 	blocksize = head->b_size;
-	bbits = block_size_bits(blocksize);
+	bbits = ilog2(blocksize);
 
 	iblock = (sector_t)page->index << (PAGE_SHIFT - bbits);
 	lblock = (i_size_read(inode)+blocksize-1) >> bbits;
-- 
2.26.2

