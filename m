Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90A10F27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEAWqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfEAWqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC76621670;
        Wed,  1 May 2019 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750766;
        bh=PUpKArGPn9SS/6uxDCAxb/HQvA3EmlN1/zSjmpEtnsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/KO5PuGvgtnEauMrPqONBD48VMeBvJRukIcAlBZviCPy/9cRwWD2FSSTRX+pUZ4g
         mN5B+XuuQU6k+mIYqdkENYWlkjBet6UiYLiHtWMEZWScsKUur8t5hXhUIeKdvn84rs
         N+liaUwfiw/0/1MJ7rgQq9czRG3a8aTXBhydubgw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 06/13] fscrypt: support encrypting multiple filesystem blocks per page
Date:   Wed,  1 May 2019 15:45:08 -0700
Message-Id: <20190501224515.43059-7-ebiggers@kernel.org>
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

Rename fscrypt_encrypt_page() to fscrypt_encrypt_pagecache_blocks() and
redefine its behavior to encrypt all filesystem blocks from the given
region of the given page, rather than assuming that the region consists
of just one filesystem block.  Also remove the 'inode' and 'lblk_num'
parameters, since they can be retrieved from the page as it's already
assumed to be a pagecache page.

This is in preparation for allowing encryption on ext4 filesystems with
blocksize != PAGE_SIZE.

This is based on work by Chandan Rajendra.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c      | 67 ++++++++++++++++++++++++-----------------
 fs/ext4/page-io.c       |  4 +--
 fs/f2fs/data.c          |  5 +--
 include/linux/fscrypt.h | 17 ++++++-----
 4 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index e978541e2ec19..7bdb985126d97 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -121,8 +121,8 @@ struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags)
 /**
  * fscrypt_free_bounce_page() - free a ciphertext bounce page
  *
- * Free a bounce page that was allocated by fscrypt_encrypt_page(), or by
- * fscrypt_alloc_bounce_page() directly.
+ * Free a bounce page that was allocated by fscrypt_encrypt_pagecache_blocks(),
+ * or by fscrypt_alloc_bounce_page() directly.
  */
 void fscrypt_free_bounce_page(struct page *bounce_page)
 {
@@ -197,52 +197,63 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 }
 
 /**
- * fscypt_encrypt_page() - Encrypts a page
- * @inode:     The inode for which the encryption should take place
- * @page:      The page to encrypt. Must be locked.
- * @len:       Length of data to encrypt in @page and encrypted
- *             data in returned page.
- * @offs:      Offset of data within @page and returned
- *             page holding encrypted data.
- * @lblk_num:  Logical block number. This must be unique for multiple
- *             calls with same inode, except when overwriting
- *             previously written data.
- * @gfp_flags: The gfp flag for memory allocation
+ * fscrypt_encrypt_pagecache_blocks() - Encrypt filesystem blocks from a pagecache page
+ * @page:      The locked pagecache page containing the block(s) to encrypt
+ * @len:       Total size of the block(s) to encrypt.  Must be a nonzero
+ *		multiple of the filesystem's block size.
+ * @offs:      Byte offset within @page of the first block to encrypt.  Must be
+ *		a multiple of the filesystem's block size.
+ * @gfp_flags: Memory allocation flags
+ *
+ * A new bounce page is allocated, and the specified block(s) are encrypted into
+ * it.  In the bounce page, the ciphertext block(s) will be located at the same
+ * offsets at which the plaintext block(s) were located in the source page; any
+ * other parts of the bounce page will be left uninitialized.  However, normally
+ * blocksize == PAGE_SIZE and the whole page is encrypted at once.
  *
- * Encrypts @page.  A bounce page is allocated, the data is encrypted into the
- * bounce page, and the bounce page is returned.  The caller is responsible for
- * calling fscrypt_free_bounce_page().
+ * This is for use by the filesystem's ->writepages() method.
  *
- * Return: A page containing the encrypted data on success; else an ERR_PTR()
+ * Return: the new encrypted bounce page on success; an ERR_PTR() on failure
  */
-struct page *fscrypt_encrypt_page(const struct inode *inode,
-				struct page *page,
-				unsigned int len,
-				unsigned int offs,
-				u64 lblk_num, gfp_t gfp_flags)
+struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
+					      unsigned int len,
+					      unsigned int offs,
+					      gfp_t gfp_flags)
 
 {
+	const struct inode *inode = page->mapping->host;
+	const unsigned int blockbits = inode->i_blkbits;
+	const unsigned int blocksize = 1 << blockbits;
 	struct page *ciphertext_page;
+	u64 lblk_num = ((u64)page->index << (PAGE_SHIFT - blockbits)) +
+		       (offs >> blockbits);
+	unsigned int i;
 	int err;
 
 	if (WARN_ON_ONCE(!PageLocked(page)))
 		return ERR_PTR(-EINVAL);
 
+	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, blocksize)))
+		return ERR_PTR(-EINVAL);
+
 	ciphertext_page = fscrypt_alloc_bounce_page(gfp_flags);
 	if (!ciphertext_page)
 		return ERR_PTR(-ENOMEM);
 
-	err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num, page,
-				  ciphertext_page, len, offs, gfp_flags);
-	if (err) {
-		fscrypt_free_bounce_page(ciphertext_page);
-		return ERR_PTR(err);
+	for (i = offs; i < offs + len; i += blocksize, lblk_num++) {
+		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num,
+					  page, ciphertext_page,
+					  blocksize, i, gfp_flags);
+		if (err) {
+			fscrypt_free_bounce_page(ciphertext_page);
+			return ERR_PTR(err);
+		}
 	}
 	SetPagePrivate(ciphertext_page);
 	set_page_private(ciphertext_page, (unsigned long)page);
 	return ciphertext_page;
 }
-EXPORT_SYMBOL(fscrypt_encrypt_page);
+EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
 
 /**
  * fscrypt_encrypt_block_inplace() - Encrypt a filesystem block in-place
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index b86082d653208..457ddf051608f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -472,8 +472,8 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		gfp_t gfp_flags = GFP_NOFS;
 
 	retry_encrypt:
-		bounce_page = fscrypt_encrypt_page(inode, page, PAGE_SIZE, 0,
-						   page->index, gfp_flags);
+		bounce_page = fscrypt_encrypt_pagecache_blocks(page, PAGE_SIZE,
+							       0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
 			if (ret == -ENOMEM && wbc->sync_mode == WB_SYNC_ALL) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7e2e3f36c7706..757f050c650a4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1692,8 +1692,9 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
 retry_encrypt:
-	fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
-			PAGE_SIZE, 0, fio->page->index, gfp_flags);
+	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(fio->page,
+							       PAGE_SIZE, 0,
+							       gfp_flags);
 	if (IS_ERR(fio->encrypted_page)) {
 		/* flush pending IOs and wait for a while in the ENOMEM case */
 		if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index fc5a81c674c20..39229fcdfac5c 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -103,9 +103,11 @@ static inline void fscrypt_handle_d_move(struct dentry *dentry)
 extern void fscrypt_enqueue_decrypt_work(struct work_struct *);
 extern struct fscrypt_ctx *fscrypt_get_ctx(gfp_t);
 extern void fscrypt_release_ctx(struct fscrypt_ctx *);
-extern struct page *fscrypt_encrypt_page(const struct inode *, struct page *,
-						unsigned int, unsigned int,
-						u64, gfp_t);
+
+extern struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
+						     unsigned int len,
+						     unsigned int offs,
+						     gfp_t gfp_flags);
 extern int fscrypt_encrypt_block_inplace(const struct inode *inode,
 					 struct page *page, unsigned int len,
 					 unsigned int offs, u64 lblk_num,
@@ -283,11 +285,10 @@ static inline void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
 	return;
 }
 
-static inline struct page *fscrypt_encrypt_page(const struct inode *inode,
-						struct page *page,
-						unsigned int len,
-						unsigned int offs,
-						u64 lblk_num, gfp_t gfp_flags)
+static inline struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
+							    unsigned int len,
+							    unsigned int offs,
+							    gfp_t gfp_flags)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.21.0.593.g511ec345e18-goog

