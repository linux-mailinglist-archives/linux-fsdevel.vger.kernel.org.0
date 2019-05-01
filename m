Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7910F25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEAWqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfEAWqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F802177B;
        Wed,  1 May 2019 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750767;
        bh=9tCtO1UhKlgNaKQ4Vo2fY/f/tx4tAYmrmesoV/TRatQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8YG9UO8QblgY/00eAdvCLakpbi8O0KF/TT7iY9sSVn4VQSaeYjTXnwNvrqb6gLsV
         jDMN2y3lQSJj/kWEUMrDu4UhojbkBtQDeQGQ5Iv6RT5xF2rYqfSBwvJtSmZDrMw+OC
         YDAdVpODu1ImUru9vpD37QOyT59qQ/n5Mofd5ExY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 09/13] fscrypt: support decrypting multiple filesystem blocks per page
Date:   Wed,  1 May 2019 15:45:11 -0700
Message-Id: <20190501224515.43059-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Rename fscrypt_decrypt_page() to fscrypt_decrypt_pagecache_blocks() and
redefine its behavior to decrypt all filesystem blocks in the given
region of the given page, rather than assuming that the region consists
of just one filesystem block.  Also remove the 'inode' and 'lblk_num'
parameters, since they can be retrieved from the page as it's already
assumed to be a pagecache page.

This is in preparation for allowing encryption on ext4 filesystems with
blocksize != PAGE_SIZE.

This is based on work by Chandan Rajendra.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/bio.c         |  5 ++---
 fs/crypto/crypto.c      | 46 ++++++++++++++++++++++++++++-------------
 fs/ext4/inode.c         |  7 +++----
 include/linux/fscrypt.h | 12 +++++------
 4 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index e67e9d4d342b3..b4f47b98ee6d9 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -34,9 +34,8 @@ static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
 
 	bio_for_each_segment_all(bv, bio, i, iter_all) {
 		struct page *page = bv->bv_page;
-		int ret = fscrypt_decrypt_page(page->mapping->host, page,
-				PAGE_SIZE, 0, page->index);
-
+		int ret = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
+							   bv->bv_offset);
 		if (ret)
 			SetPageError(page);
 		else if (done)
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 2e6fb5e4f7a7f..dcf630d7e4460 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -282,29 +282,47 @@ int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 
 /**
- * fscrypt_decrypt_page() - Decrypts a page in-place
- * @inode:     The corresponding inode for the page to decrypt.
- * @page:      The page to decrypt. Must be locked.
- * @len:       Number of bytes in @page to be decrypted.
- * @offs:      Start of data in @page.
- * @lblk_num:  Logical block number.
+ * fscrypt_decrypt_pagecache_blocks() - Decrypt filesystem blocks in a pagecache page
+ * @page:      The locked pagecache page containing the block(s) to decrypt
+ * @len:       Total size of the block(s) to decrypt.  Must be a nonzero
+ *		multiple of the filesystem's block size.
+ * @offs:      Byte offset within @page of the first block to decrypt.  Must be
+ *		a multiple of the filesystem's block size.
  *
- * Decrypts page in-place using the ctx encryption context.
+ * The specified block(s) are decrypted in-place within the pagecache page,
+ * which must still be locked and not uptodate.  Normally, blocksize ==
+ * PAGE_SIZE and the whole page is decrypted at once.
  *
- * Called from the read completion callback.
+ * This is for use by the filesystem's ->readpages() method.
  *
- * Return: Zero on success, non-zero otherwise.
+ * Return: 0 on success; -errno on failure
  */
-int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
-			unsigned int len, unsigned int offs, u64 lblk_num)
+int fscrypt_decrypt_pagecache_blocks(struct page *page, unsigned int len,
+				     unsigned int offs)
 {
+	const struct inode *inode = page->mapping->host;
+	const unsigned int blockbits = inode->i_blkbits;
+	const unsigned int blocksize = 1 << blockbits;
+	u64 lblk_num = ((u64)page->index << (PAGE_SHIFT - blockbits)) +
+		       (offs >> blockbits);
+	unsigned int i;
+	int err;
+
 	if (WARN_ON_ONCE(!PageLocked(page)))
 		return -EINVAL;
 
-	return fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page, page,
-				   len, offs, GFP_NOFS);
+	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, blocksize)))
+		return -EINVAL;
+
+	for (i = offs; i < offs + len; i += blocksize, lblk_num++) {
+		err = fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page,
+					  page, blocksize, i, GFP_NOFS);
+		if (err)
+			return err;
+	}
+	return 0;
 }
-EXPORT_SYMBOL(fscrypt_decrypt_page);
+EXPORT_SYMBOL(fscrypt_decrypt_pagecache_blocks);
 
 /**
  * fscrypt_decrypt_block_inplace() - Decrypt a filesystem block in-place
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b32a57bc5d5d6..1ef5d791834fc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1228,8 +1228,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	if (unlikely(err))
 		page_zero_new_buffers(page, from, to);
 	else if (decrypt)
-		err = fscrypt_decrypt_page(page->mapping->host, page,
-				PAGE_SIZE, 0, page->index);
+		err = fscrypt_decrypt_pagecache_blocks(page, PAGE_SIZE, 0);
 	return err;
 }
 #endif
@@ -4062,8 +4061,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
 			BUG_ON(blocksize != PAGE_SIZE);
-			WARN_ON_ONCE(fscrypt_decrypt_page(page->mapping->host,
-						page, PAGE_SIZE, 0, page->index));
+			WARN_ON_ONCE(fscrypt_decrypt_pagecache_blocks(
+						page, PAGE_SIZE, 0));
 		}
 	}
 	if (ext4_should_journal_data(inode)) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index f4890870ca984..4d6528351f25c 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -112,8 +112,9 @@ extern int fscrypt_encrypt_block_inplace(const struct inode *inode,
 					 struct page *page, unsigned int len,
 					 unsigned int offs, u64 lblk_num,
 					 gfp_t gfp_flags);
-extern int fscrypt_decrypt_page(const struct inode *, struct page *, unsigned int,
-				unsigned int, u64);
+
+extern int fscrypt_decrypt_pagecache_blocks(struct page *page, unsigned int len,
+					    unsigned int offs);
 extern int fscrypt_decrypt_block_inplace(const struct inode *inode,
 					 struct page *page, unsigned int len,
 					 unsigned int offs, u64 lblk_num);
@@ -305,10 +306,9 @@ static inline int fscrypt_encrypt_block_inplace(const struct inode *inode,
 	return -EOPNOTSUPP;
 }
 
-static inline int fscrypt_decrypt_page(const struct inode *inode,
-				       struct page *page,
-				       unsigned int len, unsigned int offs,
-				       u64 lblk_num)
+static inline int fscrypt_decrypt_pagecache_blocks(struct page *page,
+						   unsigned int len,
+						   unsigned int offs)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.21.0.593.g511ec345e18-goog

