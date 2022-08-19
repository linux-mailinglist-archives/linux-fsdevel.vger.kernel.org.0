Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5588659A8B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 00:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiHSWeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbiHSWeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B945C9E2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 15:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C319614AB
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 22:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EFDC433C1;
        Fri, 19 Aug 2022 22:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660948453;
        bh=9Jq3sz2Ydj4Z5XHUsMfrEyIV1Huah4b/zVHLCatoY1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ACdBuLxUIXjgNh0HV/SvAATF+/CZ0juRfx9dlgk9UcyBsqGxTRdsHc1qkPiVcy1DT
         dMeakeRdn1Dz1Fi7Vte5cCyPMxeyW1l9Mzd4ncoHQt7jHKRJ+9VxpUlcVyywJiuIle
         sq4x0PunK0PdzKEFhiLVsBWB5musWCJSenyIGUTP6VEUWWzjBfynDJAnJVoulm8LUG
         lY0YzOpvF1NrVCUWhiZvSv6WSya24GcKXLYVbQfOZ3HLISmwgkJXa3vHnPy2BRH7s0
         NzsmiMwl4Unoi74chWUn8FaX0TQfUcDHYlcnOU2Fq/JZfe4wuiHE7oPpiRDwj/GIG1
         a/dmUD1IFxFeg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] f2fs: use memcpy_{to,from}_page() where possible
Date:   Fri, 19 Aug 2022 15:33:00 -0700
Message-Id: <20220819223300.9128-1-ebiggers@kernel.org>
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

v2: remove unneeded calls to flush_dcache_page(),
    and convert the kmap_atomic() in f2fs_write_inline_data().

 fs/f2fs/inline.c | 15 ++++-----------
 fs/f2fs/super.c  | 11 ++---------
 fs/f2fs/verity.c | 10 ++--------
 3 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index bf46a7dfbea2fc..73da9331803696 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -64,7 +64,6 @@ bool f2fs_may_inline_dentry(struct inode *inode)
 void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
 {
 	struct inode *inode = page->mapping->host;
-	void *src_addr, *dst_addr;
 
 	if (PageUptodate(page))
 		return;
@@ -74,11 +73,8 @@ void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
 	zero_user_segment(page, MAX_INLINE_DATA(inode), PAGE_SIZE);
 
 	/* Copy the whole inline data block */
-	src_addr = inline_data_addr(inode, ipage);
-	dst_addr = kmap_atomic(page);
-	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
-	flush_dcache_page(page);
-	kunmap_atomic(dst_addr);
+	memcpy_to_page(page, 0, inline_data_addr(inode, ipage),
+		       MAX_INLINE_DATA(inode));
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 }
@@ -246,7 +242,6 @@ int f2fs_convert_inline_inode(struct inode *inode)
 
 int f2fs_write_inline_data(struct inode *inode, struct page *page)
 {
-	void *src_addr, *dst_addr;
 	struct dnode_of_data dn;
 	int err;
 
@@ -263,10 +258,8 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	f2fs_bug_on(F2FS_I_SB(inode), page->index);
 
 	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true, true);
-	src_addr = kmap_atomic(page);
-	dst_addr = inline_data_addr(inode, dn.inode_page);
-	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
-	kunmap_atomic(src_addr);
+	memcpy_from_page(inline_data_addr(inode, dn.inode_page),
+			 page, 0, MAX_INLINE_DATA(inode));
 	set_page_dirty(dn.inode_page);
 
 	f2fs_clear_page_cache_dirty_tag(page);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2451623c05a7a8..3e5743b2538240 100644
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
 
@@ -2541,10 +2537,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 			break;
 		}
 
-		kaddr = kmap_atomic(page);
-		memcpy(kaddr + offset, data, tocopy);
-		kunmap_atomic(kaddr);
-		flush_dcache_page(page);
+		memcpy_to_page(page, offset, data, tocopy);
 
 		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
 						page, fsdata);
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

