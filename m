Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07375990C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 00:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiHRW4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHRW4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:56:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D50C888C
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 15:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6574DB824D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 22:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000B6C433B5;
        Thu, 18 Aug 2022 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660863395;
        bh=10JvjgLf/ER3jZ01HZWHxBsYAjsggAZS2r8cl8XnEJo=;
        h=From:To:Cc:Subject:Date:From;
        b=mMwQOdNTpWlG8ImqpOPP7Kp8NCzgjXK5h6dATuFVBvAq2cmx237jZj6FNnRtnlP7D
         SEx5hW09X2TT8MFq9f9G5OX1FxjmP3hSPtevNwmgLqtOEJUUyoejRCbZgqPC1AolVk
         58J/OjPY6b6ooqsXrYdPZCLk8AtipKGbfNu1w0nBKkyyx+VtOBgV7r42gwv0rPMSIb
         BNJ9E4385rtKuSUg095Mdok4VS7VhuqpLowSbjYhjqI8wdg8VlOTHxTsMn7DLPJJAr
         +pqNA3MKBOXJ0Zd+WlXylfwxfv1PZZSn1kcls+1kN5dLiEx6qbniMvJVjkpy3ZBoPR
         BNzLZEadeYYGA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] f2fs: use memcpy_{to,from}_page() where possible
Date:   Thu, 18 Aug 2022 15:54:50 -0700
Message-Id: <20220818225450.84090-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This is simpler, and as a side effect it replaces several uses of
kmap_atomic() with its recommended replacement kmap_local_page().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/inline.c |  7 ++-----
 fs/f2fs/super.c  | 10 ++--------
 fs/f2fs/verity.c | 10 ++--------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index bf46a7dfbea2fc..69bfd3b08645af 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -64,7 +64,6 @@ bool f2fs_may_inline_dentry(struct inode *inode)
 void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
 {
 	struct inode *inode = page->mapping->host;
-	void *src_addr, *dst_addr;
 
 	if (PageUptodate(page))
 		return;
@@ -74,11 +73,9 @@ void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
 	zero_user_segment(page, MAX_INLINE_DATA(inode), PAGE_SIZE);
 
 	/* Copy the whole inline data block */
-	src_addr = inline_data_addr(inode, ipage);
-	dst_addr = kmap_atomic(page);
-	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
+	memcpy_to_page(page, 0, inline_data_addr(inode, ipage),
+		       MAX_INLINE_DATA(inode));
 	flush_dcache_page(page);
-	kunmap_atomic(dst_addr);
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2451623c05a7a8..c9f9269a4e88f3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2465,7 +2465,6 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 	size_t toread;
 	loff_t i_size = i_size_read(inode);
 	struct page *page;
-	char *kaddr;
 
 	if (off > i_size)
 		return 0;
@@ -2498,9 +2497,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 			return -EIO;
 		}
 
-		kaddr = kmap_atomic(page);
-		memcpy(data, kaddr + offset, tocopy);
-		kunmap_atomic(kaddr);
+		memcpy_from_page(data, page, offset, tocopy);
 		f2fs_put_page(page, 1);
 
 		offset = 0;
@@ -2522,7 +2519,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	size_t towrite = len;
 	struct page *page;
 	void *fsdata = NULL;
-	char *kaddr;
 	int err = 0;
 	int tocopy;
 
@@ -2541,9 +2537,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 			break;
 		}
 
-		kaddr = kmap_atomic(page);
-		memcpy(kaddr + offset, data, tocopy);
-		kunmap_atomic(kaddr);
+		memcpy_to_page(page, offset, data, tocopy);
 		flush_dcache_page(page);
 
 		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 7b8f2b41c29b12..97ec60f39d6960 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -47,16 +47,13 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *addr;
 
 		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
 					 NULL);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		addr = kmap_atomic(page);
-		memcpy(buf, addr + offset_in_page(pos), n);
-		kunmap_atomic(addr);
+		memcpy_from_page(buf, page, offset_in_page(pos), n);
 
 		put_page(page);
 
@@ -85,16 +82,13 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
 		void *fsdata;
-		void *addr;
 		int res;
 
 		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
 		if (res)
 			return res;
 
-		addr = kmap_atomic(page);
-		memcpy(addr + offset_in_page(pos), buf, n);
-		kunmap_atomic(addr);
+		memcpy_to_page(page, offset_in_page(pos), buf, n);
 
 		res = aops->write_end(NULL, mapping, pos, n, n, page, fsdata);
 		if (res < 0)

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1

