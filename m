Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA310F20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEAWqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfEAWqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4971721743;
        Wed,  1 May 2019 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750767;
        bh=op7neLGMp7Te1ALKc0V1hrozSTyp60fX7lfPi8NT21I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRdjWLhoP/2CDy++MB+DZ6bT7iYuP96VSERBpNyyeOoagRC5/h/KUUaulTlY9qRE9
         OzpIJgd/i+De5yeFj7QKy1Z0lnJjdMsbCrwouf7LdHIcBgrXMZp/aDMEMns2t/s13m
         PRfIqJmq35X+LbjE9K9bIsFqNNdfU+aRPEO4CrFw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 08/13] fscrypt: introduce fscrypt_decrypt_block_inplace()
Date:   Wed,  1 May 2019 15:45:10 -0700
Message-Id: <20190501224515.43059-9-ebiggers@kernel.org>
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

fscrypt_decrypt_page() behaves very differently depending on whether the
filesystem set FS_CFLG_OWN_PAGES in its fscrypt_operations.  This makes
the function difficult to understand and document.  It also makes it so
that all callers have to provide inode and lblk_num, when fscrypt could
determine these itself for pagecache pages.

Therefore, move the FS_CFLG_OWN_PAGES behavior into a new function
fscrypt_decrypt_block_inplace().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c      | 31 +++++++++++++++++++++++++++----
 fs/ubifs/crypto.c       |  7 ++++---
 include/linux/fscrypt.h | 11 +++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 7bdb985126d97..2e6fb5e4f7a7f 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -284,8 +284,7 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 /**
  * fscrypt_decrypt_page() - Decrypts a page in-place
  * @inode:     The corresponding inode for the page to decrypt.
- * @page:      The page to decrypt. Must be locked in case
- *             it is a writeback page (FS_CFLG_OWN_PAGES unset).
+ * @page:      The page to decrypt. Must be locked.
  * @len:       Number of bytes in @page to be decrypted.
  * @offs:      Start of data in @page.
  * @lblk_num:  Logical block number.
@@ -299,8 +298,7 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
 			unsigned int len, unsigned int offs, u64 lblk_num)
 {
-	if (WARN_ON_ONCE(!PageLocked(page) &&
-			 !(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES)))
+	if (WARN_ON_ONCE(!PageLocked(page)))
 		return -EINVAL;
 
 	return fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page, page,
@@ -308,6 +306,31 @@ int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
 }
 EXPORT_SYMBOL(fscrypt_decrypt_page);
 
+/**
+ * fscrypt_decrypt_block_inplace() - Decrypt a filesystem block in-place
+ * @inode:     The inode to which this block belongs
+ * @page:      The page containing the block to decrypt
+ * @len:       Size of block to decrypt.  Doesn't need to be a multiple of the
+ *		fs block size, but must be a multiple of FS_CRYPTO_BLOCK_SIZE.
+ * @offs:      Byte offset within @page at which the block to decrypt begins
+ * @lblk_num:  Filesystem logical block number of the block, i.e. the 0-based
+ *		number of the block within the file
+ *
+ * Decrypt a possibly-compressed filesystem block that is located in an
+ * arbitrary page, not necessarily in the original pagecache page.  The @inode
+ * and @lblk_num must be specified, as they can't be determined from @page.
+ *
+ * Return: 0 on success; -errno on failure
+ */
+int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
+				  unsigned int len, unsigned int offs,
+				  u64 lblk_num)
+{
+	return fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page, page,
+				   len, offs, GFP_NOFS);
+}
+EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
+
 /*
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 032efdad2e668..22be7aeb96c4f 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -64,10 +64,11 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 	}
 
 	ubifs_assert(c, dlen <= UBIFS_BLOCK_SIZE);
-	err = fscrypt_decrypt_page(inode, virt_to_page(&dn->data), dlen,
-			offset_in_page(&dn->data), block);
+	err = fscrypt_decrypt_block_inplace(inode, virt_to_page(&dn->data),
+					    dlen, offset_in_page(&dn->data),
+					    block);
 	if (err) {
-		ubifs_err(c, "fscrypt_decrypt_page failed: %i", err);
+		ubifs_err(c, "fscrypt_decrypt_block_inplace() failed: %d", err);
 		return err;
 	}
 	*out_len = clen;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 39229fcdfac5c..f4890870ca984 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -114,6 +114,9 @@ extern int fscrypt_encrypt_block_inplace(const struct inode *inode,
 					 gfp_t gfp_flags);
 extern int fscrypt_decrypt_page(const struct inode *, struct page *, unsigned int,
 				unsigned int, u64);
+extern int fscrypt_decrypt_block_inplace(const struct inode *inode,
+					 struct page *page, unsigned int len,
+					 unsigned int offs, u64 lblk_num);
 
 static inline bool fscrypt_is_bounce_page(struct page *page)
 {
@@ -310,6 +313,14 @@ static inline int fscrypt_decrypt_page(const struct inode *inode,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_decrypt_block_inplace(const struct inode *inode,
+						struct page *page,
+						unsigned int len,
+						unsigned int offs, u64 lblk_num)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool fscrypt_is_bounce_page(struct page *page)
 {
 	return false;
-- 
2.21.0.593.g511ec345e18-goog

