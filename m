Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB410F36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfEAWqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfEAWqH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:07 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7404208C4;
        Wed,  1 May 2019 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750766;
        bh=X/mYD3int+IFjsGHKyVvU/ocytwbsaEUU4yVz/voQ5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwN46aKRhM8wHF0N8z7GG9yN6XRMEgGVua2A1lLv+wZTxx1ZsgmjycpjxjLg19zJ7
         seEDN6xn96mScG/TqNq1xrO9UjEdhmZ76+/2+2GNoKavI055ZFfen/JdRrEJiA2NHR
         BYTwPdmChKRJx8noNAm8LE9s6AnT7lPv5oNsif74=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 03/13] fscrypt: rename fscrypt_do_page_crypto() to fscrypt_crypt_block()
Date:   Wed,  1 May 2019 15:45:05 -0700
Message-Id: <20190501224515.43059-4-ebiggers@kernel.org>
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

fscrypt_do_page_crypto() only does a single encryption or decryption
operation, with a single logical block number (single IV).  So it
actually operates on a filesystem block, not a "page" per se.  To
reflect this, rename it to fscrypt_crypt_block().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/bio.c             |  6 +++---
 fs/crypto/crypto.c          | 24 ++++++++++++------------
 fs/crypto/fscrypt_private.h | 11 +++++------
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 548ec6bb569cf..bcab8822217b0 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -84,9 +84,9 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return -ENOMEM;
 
 	while (len--) {
-		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk,
-					     ZERO_PAGE(0), ciphertext_page,
-					     PAGE_SIZE, 0, GFP_NOFS);
+		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
+					  ZERO_PAGE(0), ciphertext_page,
+					  PAGE_SIZE, 0, GFP_NOFS);
 		if (err)
 			goto errout;
 
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index ebfa13cfecb7d..e6802d7aca3c7 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -147,10 +147,11 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 		crypto_cipher_encrypt_one(ci->ci_essiv_tfm, iv->raw, iv->raw);
 }
 
-int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
-			   u64 lblk_num, struct page *src_page,
-			   struct page *dest_page, unsigned int len,
-			   unsigned int offs, gfp_t gfp_flags)
+/* Encrypt or decrypt a single filesystem block of file contents */
+int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
+			u64 lblk_num, struct page *src_page,
+			struct page *dest_page, unsigned int len,
+			unsigned int offs, gfp_t gfp_flags)
 {
 	union fscrypt_iv iv;
 	struct skcipher_request *req = NULL;
@@ -227,9 +228,9 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 
 	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
 		/* with inplace-encryption we just encrypt the page */
-		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
-					     ciphertext_page, len, offs,
-					     gfp_flags);
+		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num, page,
+					  ciphertext_page, len, offs,
+					  gfp_flags);
 		if (err)
 			return ERR_PTR(err);
 
@@ -243,9 +244,8 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 	if (!ciphertext_page)
 		return ERR_PTR(-ENOMEM);
 
-	err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
-				     page, ciphertext_page, len, offs,
-				     gfp_flags);
+	err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num, page,
+				  ciphertext_page, len, offs, gfp_flags);
 	if (err) {
 		fscrypt_free_bounce_page(ciphertext_page);
 		return ERR_PTR(err);
@@ -277,8 +277,8 @@ int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
 	if (!(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES))
 		BUG_ON(!PageLocked(page));
 
-	return fscrypt_do_page_crypto(inode, FS_DECRYPT, lblk_num, page, page,
-				      len, offs, GFP_NOFS);
+	return fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page, page,
+				   len, offs, GFP_NOFS);
 }
 EXPORT_SYMBOL(fscrypt_decrypt_page);
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index a5a5486979ff7..8565536feb2b8 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -117,12 +117,11 @@ static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 /* crypto.c */
 extern struct kmem_cache *fscrypt_info_cachep;
 extern int fscrypt_initialize(unsigned int cop_flags);
-extern int fscrypt_do_page_crypto(const struct inode *inode,
-				  fscrypt_direction_t rw, u64 lblk_num,
-				  struct page *src_page,
-				  struct page *dest_page,
-				  unsigned int len, unsigned int offs,
-				  gfp_t gfp_flags);
+extern int fscrypt_crypt_block(const struct inode *inode,
+			       fscrypt_direction_t rw, u64 lblk_num,
+			       struct page *src_page, struct page *dest_page,
+			       unsigned int len, unsigned int offs,
+			       gfp_t gfp_flags);
 extern struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags);
 extern const struct dentry_operations fscrypt_d_ops;
 
-- 
2.21.0.593.g511ec345e18-goog

