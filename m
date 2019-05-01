Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3731410F40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfEAWqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfEAWqH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:07 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6428321479;
        Wed,  1 May 2019 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750766;
        bh=q1kC+J41Ilz6M2LE4SlqzAEUaIYFUWvVH9qroisdU0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pb0L9/GmbMFin/U0fiVPAQA2ygMEs5Mmy7bYHDOiYfGHv4dvPSs3nglRRT2I5K8My
         aFApPiooqGKATR3BNHg3LGSMl6vw5gus8p9TBcS5rYsqt71948LHyRdDOfnYk9N5Ar
         TG7HaxjxlhWSi1Iho06ScKDdKUgoNFhKWxnVowXU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 05/13] fscrypt: introduce fscrypt_encrypt_block_inplace()
Date:   Wed,  1 May 2019 15:45:07 -0700
Message-Id: <20190501224515.43059-6-ebiggers@kernel.org>
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

fscrypt_encrypt_page() behaves very differently depending on whether the
filesystem set FS_CFLG_OWN_PAGES in its fscrypt_operations.  This makes
the function difficult to understand and document.  It also makes it so
that all callers have to provide inode and lblk_num, when fscrypt could
determine these itself for pagecache pages.

Therefore, move the FS_CFLG_OWN_PAGES behavior into a new function
fscrypt_encrypt_block_inplace().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c      | 52 +++++++++++++++++++++++++----------------
 fs/ubifs/crypto.c       | 12 +++++-----
 include/linux/fscrypt.h | 13 +++++++++++
 3 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 9cda0147fca95..e978541e2ec19 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -199,8 +199,7 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 /**
  * fscypt_encrypt_page() - Encrypts a page
  * @inode:     The inode for which the encryption should take place
- * @page:      The page to encrypt. Must be locked for bounce-page
- *             encryption.
+ * @page:      The page to encrypt. Must be locked.
  * @len:       Length of data to encrypt in @page and encrypted
  *             data in returned page.
  * @offs:      Offset of data within @page and returned
@@ -210,12 +209,11 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
  *             previously written data.
  * @gfp_flags: The gfp flag for memory allocation
  *
- * Encrypts @page.  If the filesystem set FS_CFLG_OWN_PAGES, then the data is
- * encrypted in-place and @page is returned.  Else, a bounce page is allocated,
- * the data is encrypted into the bounce page, and the bounce page is returned.
- * The caller is responsible for calling fscrypt_free_bounce_page().
+ * Encrypts @page.  A bounce page is allocated, the data is encrypted into the
+ * bounce page, and the bounce page is returned.  The caller is responsible for
+ * calling fscrypt_free_bounce_page().
  *
- * Return: A page containing the encrypted data on success, else an ERR_PTR()
+ * Return: A page containing the encrypted data on success; else an ERR_PTR()
  */
 struct page *fscrypt_encrypt_page(const struct inode *inode,
 				struct page *page,
@@ -224,24 +222,12 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 				u64 lblk_num, gfp_t gfp_flags)
 
 {
-	struct page *ciphertext_page = page;
+	struct page *ciphertext_page;
 	int err;
 
-	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
-		/* with inplace-encryption we just encrypt the page */
-		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num, page,
-					  ciphertext_page, len, offs,
-					  gfp_flags);
-		if (err)
-			return ERR_PTR(err);
-
-		return ciphertext_page;
-	}
-
 	if (WARN_ON_ONCE(!PageLocked(page)))
 		return ERR_PTR(-EINVAL);
 
-	/* The encryption operation will require a bounce page. */
 	ciphertext_page = fscrypt_alloc_bounce_page(gfp_flags);
 	if (!ciphertext_page)
 		return ERR_PTR(-ENOMEM);
@@ -258,6 +244,32 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 }
 EXPORT_SYMBOL(fscrypt_encrypt_page);
 
+/**
+ * fscrypt_encrypt_block_inplace() - Encrypt a filesystem block in-place
+ * @inode:     The inode to which this block belongs
+ * @page:      The page containing the block to encrypt
+ * @len:       Size of block to encrypt.  Doesn't need to be a multiple of the
+ *		fs block size, but must be a multiple of FS_CRYPTO_BLOCK_SIZE.
+ * @offs:      Byte offset within @page at which the block to encrypt begins
+ * @lblk_num:  Filesystem logical block number of the block, i.e. the 0-based
+ *		number of the block within the file
+ * @gfp_flags: Memory allocation flags
+ *
+ * Encrypt a possibly-compressed filesystem block that is located in an
+ * arbitrary page, not necessarily in the original pagecache page.  The @inode
+ * and @lblk_num must be specified, as they can't be determined from @page.
+ *
+ * Return: 0 on success; -errno on failure
+ */
+int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
+				  unsigned int len, unsigned int offs,
+				  u64 lblk_num, gfp_t gfp_flags)
+{
+	return fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num, page, page,
+				   len, offs, gfp_flags);
+}
+EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
+
 /**
  * fscrypt_decrypt_page() - Decrypts a page in-place
  * @inode:     The corresponding inode for the page to decrypt.
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 4aaedf2d7f442..032efdad2e668 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -29,8 +29,8 @@ int ubifs_encrypt(const struct inode *inode, struct ubifs_data_node *dn,
 {
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	void *p = &dn->data;
-	struct page *ret;
 	unsigned int pad_len = round_up(in_len, UBIFS_CIPHER_BLOCK_SIZE);
+	int err;
 
 	ubifs_assert(c, pad_len <= *out_len);
 	dn->compr_size = cpu_to_le16(in_len);
@@ -39,11 +39,11 @@ int ubifs_encrypt(const struct inode *inode, struct ubifs_data_node *dn,
 	if (pad_len != in_len)
 		memset(p + in_len, 0, pad_len - in_len);
 
-	ret = fscrypt_encrypt_page(inode, virt_to_page(&dn->data), pad_len,
-			offset_in_page(&dn->data), block, GFP_NOFS);
-	if (IS_ERR(ret)) {
-		ubifs_err(c, "fscrypt_encrypt_page failed: %ld", PTR_ERR(ret));
-		return PTR_ERR(ret);
+	err = fscrypt_encrypt_block_inplace(inode, virt_to_page(p), pad_len,
+					    offset_in_page(p), block, GFP_NOFS);
+	if (err) {
+		ubifs_err(c, "fscrypt_encrypt_block_inplace() failed: %d", err);
+		return err;
 	}
 	*out_len = pad_len;
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 11e7187fa2e52..fc5a81c674c20 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -106,6 +106,10 @@ extern void fscrypt_release_ctx(struct fscrypt_ctx *);
 extern struct page *fscrypt_encrypt_page(const struct inode *, struct page *,
 						unsigned int, unsigned int,
 						u64, gfp_t);
+extern int fscrypt_encrypt_block_inplace(const struct inode *inode,
+					 struct page *page, unsigned int len,
+					 unsigned int offs, u64 lblk_num,
+					 gfp_t gfp_flags);
 extern int fscrypt_decrypt_page(const struct inode *, struct page *, unsigned int,
 				unsigned int, u64);
 
@@ -288,6 +292,15 @@ static inline struct page *fscrypt_encrypt_page(const struct inode *inode,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline int fscrypt_encrypt_block_inplace(const struct inode *inode,
+						struct page *page,
+						unsigned int len,
+						unsigned int offs, u64 lblk_num,
+						gfp_t gfp_flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int fscrypt_decrypt_page(const struct inode *inode,
 				       struct page *page,
 				       unsigned int len, unsigned int offs,
-- 
2.21.0.593.g511ec345e18-goog

