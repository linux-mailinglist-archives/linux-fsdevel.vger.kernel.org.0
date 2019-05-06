Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0199F1562D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfEFWmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 18:42:40 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33413 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfEFWmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 18:42:39 -0400
Received: by mail-pg1-f202.google.com with SMTP id s8so8936862pgk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0LhQ1jaPEPAlZYHqHp9vCn4wv6xZVEl5Ms4lRTgwJjw=;
        b=q3sY7gFafJfTVBH+6FzSYLG0Wr99ZocX38oWe/y4joZQzn1xEjfztwBaNOxyym27ng
         EDVZoIlbCgeRxAPVLPsFsQs0OazLQcOItKr7G9fVMvQnZ6/k+GIwp702D5UQ+arj7w4v
         ibGgfNdDR+WNd0ICE+NHn2FpyNw5/EXIVouUkUmOgJYQlXbgaG4L5ZNTyw6Db9RlBgzB
         eVqCiKipKGIePyJiWgYxJAlqj3e0urXYy85X1LsYR4Xe6IGeljT11YpydNK1BGKy5LiB
         PCzJl6UWTTcf0gh9eTyoaYt0ZmsK3S05C3ajwYBWBs9pN0YkNquCu6DliTpjVbcxLF8h
         PSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0LhQ1jaPEPAlZYHqHp9vCn4wv6xZVEl5Ms4lRTgwJjw=;
        b=PeuEYi/MLRMI6jZA+tW1HBzMfmhygIAT4B38vEX+f+aBpBGApWuMa9tsQoeKBEWelv
         v+aIN86WPNMYyiN/c3C4JZB58sSv1DBy+bhwVmRovn8SUCZ3DfwTGrXCKHdZkz1Yb+rW
         wzR548nPejAnr6Rq1Xm7hsf5Kv2puzguVyDNIqbQoAmnQAm+i5HZ1IOZlQG6NskDqPKJ
         6SuFYj2XmdOt+Jm5Af6WS4dJczgNZJCtPitva+6iNf0DNt9eHZ7tBgfQXMPLeBEO1fRx
         zEAeyHGWRKazapZUozJdW1fb+Ops4ycfZOy4AByavC6lIwyV0r2yp005zwadpv+4IH9C
         KBNg==
X-Gm-Message-State: APjAAAUCjMNfAVl0AyyZZKRppwd5FCeOQjhkzcNRT35r4QALt3Ek4zDy
        d8LXnJOddsKf2v2nNgRF51ha8BZOBZE=
X-Google-Smtp-Source: APXvYqziAE5sEUBQDs8H6mgI5C30uU77l/npvZKJZ5VPM2uAU23S7ohe899E/LEYi8A4748RmHEVIhQy/0Q=
X-Received: by 2002:a63:4820:: with SMTP id v32mr28716460pga.89.1557182557922;
 Mon, 06 May 2019 15:42:37 -0700 (PDT)
Date:   Mon,  6 May 2019 15:35:43 -0700
In-Reply-To: <20190506223544.195371-1-satyat@google.com>
Message-Id: <20190506223544.195371-4-satyat@google.com>
Mime-Version: 1.0
References: <20190506223544.195371-1-satyat@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 3/4] fscrypt: wire up fscrypt to use blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce fscrypt_set_bio_crypt_ctx for filesystems to call to set up
encryption contexts in bios, and fscrypt_evict_crypt_key to evict
the encryption context associated with an inode.

Inline encryption is controlled by a policy flag in the fscrypt_info
in the inode, and filesystems may check if an inode should use inline
encryption by calling fscrypt_inode_is_hw_encrypted. Files can be marked
as inline encrypted from userspace by appropriately modifying the flags
(OR-ing FS_POLICY_FLAGS_HW_ENCRYPTION to it) in the fscrypt_policy
passed to fscrypt_ioctl_set_policy.

To test inline encryption with the fscrypt dummy context, add
ctx.flags |= FS_POLICY_FLAGS_HW_ENCRYPTION
when setting up the dummy context in fs/crypto/keyinfo.c.

Note that blk-crypto will fall back to software en/decryption in the
absence of inline crypto hardware, so setting up the ctx.flags in the
dummy context without inline crypto hardware serves as a test for
the software fallback in blk-crypto.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c          |   1 -
 fs/crypto/Kconfig           |   7 ++
 fs/crypto/bio.c             | 156 +++++++++++++++++++++++++++++++-----
 fs/crypto/crypto.c          |   9 +++
 fs/crypto/fscrypt_private.h |  10 +++
 fs/crypto/keyinfo.c         |  69 +++++++++++-----
 fs/crypto/policy.c          |  10 +++
 include/linux/fscrypt.h     |  58 ++++++++++++++
 include/uapi/linux/fs.h     |  12 ++-
 9 files changed, 287 insertions(+), 45 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 503f9e3a770b..eb3a9736939f 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -77,7 +77,6 @@ static int blk_crypto_keyslot_program(void *priv, const u8 *key,
 		slot_mem[slot].tfm = tfm;
 	}
 
-
 	err = crypto_skcipher_setkey(tfm, key, keysize);
 
 	if (err) {
diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index f0de238000c0..54412f0c48be 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -14,3 +14,10 @@ config FS_ENCRYPTION
 	  efficient since it avoids caching the encrypted and
 	  decrypted pages in the page cache.  Currently Ext4,
 	  F2FS and UBIFS make use of this feature.
+
+config FS_ENCRYPTION_HW_CRYPT
+	tristate "Enable fscrypt to use inline crypto"
+	default n
+	depends on FS_ENCRYPTION && BLK_CRYPT_CTX
+	help
+	  Enables fscrypt to use inline crypto hardware if available.
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 5759bcd018cd..8e8706694246 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,9 +24,12 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <linux/keyslot-manager.h>
+#include <linux/blkdev.h>
+#include <crypto/algapi.h>
 #include "fscrypt_private.h"
 
-static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
+static void __fscrypt_decrypt_bio(struct bio *bio, bool done, bool decrypt)
 {
 	struct bio_vec *bv;
 	int i;
@@ -34,9 +37,12 @@ static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
 
 	bio_for_each_segment_all(bv, bio, i, iter_all) {
 		struct page *page = bv->bv_page;
-		int ret = fscrypt_decrypt_page(page->mapping->host, page,
-				PAGE_SIZE, 0, page->index);
+		int ret = 0;
 
+		if (decrypt) {
+			ret = fscrypt_decrypt_page(page->mapping->host, page,
+						   PAGE_SIZE, 0, page->index);
+		}
 		if (ret) {
 			WARN_ON_ONCE(1);
 			SetPageError(page);
@@ -50,7 +56,7 @@ static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
 
 void fscrypt_decrypt_bio(struct bio *bio)
 {
-	__fscrypt_decrypt_bio(bio, false);
+	__fscrypt_decrypt_bio(bio, false, true);
 }
 EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
@@ -60,16 +66,27 @@ static void completion_pages(struct work_struct *work)
 		container_of(work, struct fscrypt_ctx, r.work);
 	struct bio *bio = ctx->r.bio;
 
-	__fscrypt_decrypt_bio(bio, true);
+	__fscrypt_decrypt_bio(bio, true, true);
+	fscrypt_release_ctx(ctx);
+	bio_put(bio);
+}
+
+static void decrypt_bio_hwcrypt(struct fscrypt_ctx *ctx, struct bio *bio)
+{
+	__fscrypt_decrypt_bio(bio, true, false);
 	fscrypt_release_ctx(ctx);
 	bio_put(bio);
 }
 
 void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
 {
-	INIT_WORK(&ctx->r.work, completion_pages);
-	ctx->r.bio = bio;
-	fscrypt_enqueue_decrypt_work(&ctx->r.work);
+	if (bio_is_encrypted(bio)) {
+		decrypt_bio_hwcrypt(ctx, bio);
+	} else {
+		INIT_WORK(&ctx->r.work, completion_pages);
+		ctx->r.bio = bio;
+		fscrypt_enqueue_decrypt_work(&ctx->r.work);
+	}
 }
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
 
@@ -97,29 +114,33 @@ EXPORT_SYMBOL(fscrypt_pullback_bio_page);
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 				sector_t pblk, unsigned int len)
 {
-	struct fscrypt_ctx *ctx;
+	struct fscrypt_ctx *ctx = NULL;
 	struct page *ciphertext_page = NULL;
 	struct bio *bio;
 	int ret, err = 0;
 
 	BUG_ON(inode->i_sb->s_blocksize != PAGE_SIZE);
 
-	ctx = fscrypt_get_ctx(inode, GFP_NOFS);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+	if (!fscrypt_inode_is_hw_encrypted(inode)) {
+		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
 
-	ciphertext_page = fscrypt_alloc_bounce_page(ctx, GFP_NOWAIT);
-	if (IS_ERR(ciphertext_page)) {
-		err = PTR_ERR(ciphertext_page);
-		goto errout;
+		ciphertext_page = fscrypt_alloc_bounce_page(ctx, GFP_NOWAIT);
+		if (IS_ERR(ciphertext_page)) {
+			err = PTR_ERR(ciphertext_page);
+			goto errout;
+		}
 	}
 
 	while (len--) {
-		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk,
+		if (!fscrypt_inode_is_hw_encrypted(inode)) {
+			err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk,
 					     ZERO_PAGE(0), ciphertext_page,
 					     PAGE_SIZE, 0, GFP_NOFS);
-		if (err)
-			goto errout;
+			if (err)
+				goto errout;
+		}
 
 		bio = bio_alloc(GFP_NOWAIT, 1);
 		if (!bio) {
@@ -130,8 +151,14 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		bio->bi_iter.bi_sector =
 			pblk << (inode->i_sb->s_blocksize_bits - 9);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-		ret = bio_add_page(bio, ciphertext_page,
-					inode->i_sb->s_blocksize, 0);
+		if (!fscrypt_inode_is_hw_encrypted(inode)) {
+			ret = bio_add_page(bio, ciphertext_page,
+						inode->i_sb->s_blocksize, 0);
+		} else {
+			ret = bio_add_page(bio, ZERO_PAGE(0),
+						inode->i_sb->s_blocksize, 0);
+		}
+
 		if (ret != inode->i_sb->s_blocksize) {
 			/* should never happen! */
 			WARN_ON(1);
@@ -139,6 +166,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			err = -EIO;
 			goto errout;
 		}
+		fscrypt_set_bio_crypt_ctx(inode, bio, pblk);
 		err = submit_bio_wait(bio);
 		if (err == 0 && bio->bi_status)
 			err = -EIO;
@@ -150,7 +178,91 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	}
 	err = 0;
 errout:
-	fscrypt_release_ctx(ctx);
+	if (!fscrypt_inode_is_hw_encrypted(inode))
+		fscrypt_release_ctx(ctx);
 	return err;
 }
 EXPORT_SYMBOL(fscrypt_zeroout_range);
+
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+static enum blk_crypt_mode_index
+get_blk_crypto_alg_for_fscryptalg(u8 fscrypt_alg)
+{
+	switch (fscrypt_alg) {
+	case FS_ENCRYPTION_MODE_AES_256_XTS:
+		return BLK_ENCRYPTION_MODE_AES_256_XTS;
+	default: return -EINVAL;
+	}
+}
+
+int fscrypt_set_bio_crypt_ctx(const struct inode *inode,
+				 struct bio *bio, u64 data_unit_num)
+{
+	struct fscrypt_info *ci = inode->i_crypt_info;
+
+	/* If inode is not hw encrypted, nothing to do. */
+	if (!fscrypt_inode_is_hw_encrypted(inode))
+		return 0;
+
+	if (!fscrypt_valid_enc_modes(ci->ci_data_mode, ci->ci_filename_mode))
+		return -1;
+
+	bio_crypt_set_ctx(bio, ci->ci_master_key->mk_raw,
+			  get_blk_crypto_alg_for_fscryptalg(ci->ci_data_mode),
+			  data_unit_num,
+			  PAGE_SHIFT);
+	return 0;
+}
+EXPORT_SYMBOL(fscrypt_set_bio_crypt_ctx);
+
+int fscrypt_evict_crypt_key(struct inode *inode)
+{
+	struct request_queue *q;
+	struct fscrypt_info *ci;
+
+	if (!inode)
+		return 0;
+
+	q = inode->i_sb->s_bdev->bd_queue;
+	ci = inode->i_crypt_info;
+
+	if (!q || !q->ksm || !ci ||
+	    !fscrypt_inode_is_hw_encrypted(inode)) {
+		return 0;
+	}
+
+	return keyslot_manager_evict_key(q->ksm,
+					 ci->ci_master_key->mk_raw,
+					 get_blk_crypto_alg_for_fscryptalg(
+						ci->ci_data_mode),
+					 PAGE_SIZE);
+}
+EXPORT_SYMBOL(fscrypt_evict_crypt_key);
+
+bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+				   const struct inode *inode_2)
+{
+	struct fscrypt_info *ci_1, *ci_2;
+	bool enc_1 = fscrypt_inode_is_hw_encrypted(inode_1);
+	bool enc_2 = fscrypt_inode_is_hw_encrypted(inode_2);
+
+	if (enc_1 != enc_2)
+		return false;
+
+	if (!enc_1)
+		return true;
+
+	if (inode_1 == inode_2)
+		return true;
+
+	ci_1 = inode_1->i_crypt_info;
+	ci_2 = inode_2->i_crypt_info;
+
+	return ci_1->ci_data_mode == ci_2->ci_data_mode &&
+	       crypto_memneq(ci_1->ci_master_key->mk_raw,
+			     ci_2->ci_master_key->mk_raw,
+			     ci_1->ci_master_key->mk_mode->keysize) == 0;
+}
+EXPORT_SYMBOL(fscrypt_inode_crypt_mergeable);
+
+#endif /* FS_ENCRYPTION_HW_CRYPT */
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 4dc788e3bc96..164824d2ea3c 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -245,6 +245,11 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 
 	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
 
+	/* If HW encryption, then pretend we did in place encryption */
+	if (fscrypt_inode_is_hw_encrypted(inode)) {
+		return ciphertext_page;
+	}
+
 	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
 		/* with inplace-encryption we just encrypt the page */
 		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
@@ -307,6 +312,10 @@ int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
 	if (!(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES))
 		BUG_ON(!PageLocked(page));
 
+	/* If we have HW encryption, then this page is already decrypted */
+	if (fscrypt_inode_is_hw_encrypted(inode))
+		return 0;
+
 	return fscrypt_do_page_crypto(inode, FS_DECRYPT, lblk_num, page, page,
 				      len, offs, GFP_NOFS);
 }
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 7da276159593..d6d65c88a629 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -49,6 +49,16 @@ struct fscrypt_symlink_data {
 	char encrypted_path[1];
 } __packed;
 
+/* Master key referenced by FS_POLICY_FLAG_DIRECT_KEY policy */
+struct fscrypt_master_key {
+	struct hlist_node mk_node;
+	refcount_t mk_refcount;
+	const struct fscrypt_mode *mk_mode;
+	struct crypto_skcipher *mk_ctfm;
+	u8 mk_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+	u8 mk_raw[FS_MAX_KEY_SIZE];
+};
+
 /*
  * fscrypt_info - the "encryption key" for an inode
  *
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 322ce9686bdb..04d808d8ff30 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -25,6 +25,21 @@ static struct crypto_shash *essiv_hash_tfm;
 static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
 static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+static inline bool __flags_hw_encrypted(u8 flags,
+					const struct inode *inode)
+{
+	return inode && (flags & FS_POLICY_FLAGS_HW_ENCRYPTION) &&
+	       S_ISREG(inode->i_mode);
+}
+#else
+static inline bool __flags_hw_encrypted(u8 flags,
+					const struct inode *inode)
+{
+	return false;
+}
+#endif /* CONFIG_FS_ENCRYPTION_HW_CRYPT */
+
 /*
  * Key derivation function.  This generates the derived key by encrypting the
  * master key with AES-128-ECB using the inode's nonce as the AES key.
@@ -220,6 +235,9 @@ static int find_and_derive_key(const struct inode *inode,
 			memcpy(derived_key, payload->raw, mode->keysize);
 			err = 0;
 		}
+	} else if (__flags_hw_encrypted(ctx->flags, inode)) {
+		memcpy(derived_key, payload->raw, mode->keysize);
+		err = 0;
 	} else {
 		err = derive_key_aes(payload->raw, ctx, derived_key,
 				     mode->keysize);
@@ -269,16 +287,6 @@ allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
 	return ERR_PTR(err);
 }
 
-/* Master key referenced by FS_POLICY_FLAG_DIRECT_KEY policy */
-struct fscrypt_master_key {
-	struct hlist_node mk_node;
-	refcount_t mk_refcount;
-	const struct fscrypt_mode *mk_mode;
-	struct crypto_skcipher *mk_ctfm;
-	u8 mk_descriptor[FS_KEY_DESCRIPTOR_SIZE];
-	u8 mk_raw[FS_MAX_KEY_SIZE];
-};
-
 static void free_master_key(struct fscrypt_master_key *mk)
 {
 	if (mk) {
@@ -287,13 +295,15 @@ static void free_master_key(struct fscrypt_master_key *mk)
 	}
 }
 
-static void put_master_key(struct fscrypt_master_key *mk)
+static void put_master_key(struct fscrypt_master_key *mk,
+			   struct inode *inode)
 {
 	if (!refcount_dec_and_lock(&mk->mk_refcount, &fscrypt_master_keys_lock))
 		return;
 	hash_del(&mk->mk_node);
 	spin_unlock(&fscrypt_master_keys_lock);
 
+	fscrypt_evict_crypt_key(inode);
 	free_master_key(mk);
 }
 
@@ -360,11 +370,13 @@ fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&mk->mk_refcount, 1);
 	mk->mk_mode = mode;
-	mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
-	if (IS_ERR(mk->mk_ctfm)) {
-		err = PTR_ERR(mk->mk_ctfm);
-		mk->mk_ctfm = NULL;
-		goto err_free_mk;
+	if (!__flags_hw_encrypted(ci->ci_flags, inode)) {
+		mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
+		if (IS_ERR(mk->mk_ctfm)) {
+			err = PTR_ERR(mk->mk_ctfm);
+			mk->mk_ctfm = NULL;
+			goto err_free_mk;
+		}
 	}
 	memcpy(mk->mk_descriptor, ci->ci_master_key_descriptor,
 	       FS_KEY_DESCRIPTOR_SIZE);
@@ -457,7 +469,8 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	struct crypto_skcipher *ctfm;
 	int err;
 
-	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) {
+	if ((ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) ||
+	    __flags_hw_encrypted(ci->ci_flags, inode)) {
 		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
 		if (IS_ERR(mk))
 			return PTR_ERR(mk);
@@ -487,13 +500,13 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	return 0;
 }
 
-static void put_crypt_info(struct fscrypt_info *ci)
+static void put_crypt_info(struct fscrypt_info *ci, struct inode *inode)
 {
 	if (!ci)
 		return;
 
 	if (ci->ci_master_key) {
-		put_master_key(ci->ci_master_key);
+		put_master_key(ci->ci_master_key, inode);
 	} else {
 		crypto_free_skcipher(ci->ci_ctfm);
 		crypto_free_cipher(ci->ci_essiv_tfm);
@@ -578,7 +591,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
 out:
 	if (res == -ENOKEY)
 		res = 0;
-	put_crypt_info(crypt_info);
+	put_crypt_info(crypt_info, NULL);
 	kzfree(raw_key);
 	return res;
 }
@@ -586,7 +599,21 @@ EXPORT_SYMBOL(fscrypt_get_encryption_info);
 
 void fscrypt_put_encryption_info(struct inode *inode)
 {
-	put_crypt_info(inode->i_crypt_info);
+	put_crypt_info(inode->i_crypt_info, inode);
 	inode->i_crypt_info = NULL;
 }
 EXPORT_SYMBOL(fscrypt_put_encryption_info);
+
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+bool fscrypt_inode_is_hw_encrypted(const struct inode *inode)
+{
+	struct fscrypt_info *ci;
+
+	if (!inode)
+		return false;
+	ci = inode->i_crypt_info;
+
+	return ci && __flags_hw_encrypted(ci->ci_flags, inode);
+}
+EXPORT_SYMBOL(fscrypt_inode_is_hw_encrypted);
+#endif /* CONFIG_FS_ENCRYPTION_HW_CRYPT */
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index bd7eaf9b3f00..210116fb2173 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -36,6 +36,7 @@ static int create_encryption_context_from_policy(struct inode *inode,
 	struct fscrypt_context ctx;
 
 	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+
 	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
 					FS_KEY_DESCRIPTOR_SIZE);
 
@@ -46,8 +47,17 @@ static int create_encryption_context_from_policy(struct inode *inode,
 	if (policy->flags & ~FS_POLICY_FLAGS_VALID)
 		return -EINVAL;
 
+	/**
+	 * TODO: expose HW encryption via some toggleable knob
+	 * instead of as a policy?
+	 */
+	if (!inode->i_sb->s_cop->hw_crypt_supp &&
+	    (policy->flags & FS_POLICY_FLAGS_HW_ENCRYPTION))
+		return -EINVAL;
+
 	ctx.contents_encryption_mode = policy->contents_encryption_mode;
 	ctx.filenames_encryption_mode = policy->filenames_encryption_mode;
+
 	ctx.flags = policy->flags;
 	BUILD_BUG_ON(sizeof(ctx.nonce) != FS_KEY_DERIVATION_NONCE_SIZE);
 	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e5194fc3983e..a357a13bec27 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -60,6 +60,9 @@ struct fscrypt_operations {
 	bool (*dummy_context)(struct inode *);
 	bool (*empty_dir)(struct inode *);
 	unsigned int max_namelen;
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+	bool hw_crypt_supp;
+#endif
 };
 
 struct fscrypt_ctx {
@@ -115,6 +118,22 @@ extern int fscrypt_inherit_context(struct inode *, struct inode *,
 extern int fscrypt_get_encryption_info(struct inode *);
 extern void fscrypt_put_encryption_info(struct inode *);
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+extern bool fscrypt_inode_is_hw_encrypted(const struct inode *inode);
+extern bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+					  const struct inode *inode_2);
+#else
+static inline bool fscrypt_inode_is_hw_encrypted(const struct inode *inode)
+{
+	return false;
+}
+static inline bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+						 const struct inode *inode_2)
+{
+	return true;
+}
+#endif /* CONFIG_FS_ENCRYPTION_HW_CRYPT */
+
 /* fname.c */
 extern int fscrypt_setup_filename(struct inode *, const struct qstr *,
 				int lookup, struct fscrypt_name *);
@@ -211,6 +230,22 @@ extern void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx,
 extern void fscrypt_pullback_bio_page(struct page **, bool);
 extern int fscrypt_zeroout_range(const struct inode *, pgoff_t, sector_t,
 				 unsigned int);
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+extern int fscrypt_set_bio_crypt_ctx(const struct inode *inode,
+				     struct bio *bio, u64 data_unit_num);
+extern int fscrypt_evict_crypt_key(struct inode *inode);
+#else
+static inline int fscrypt_set_bio_crypt_ctx(const struct inode *inode,
+					    struct bio *bio, u64 data_unit_num)
+{
+	return 0;
+}
+
+static inline int fscrypt_evict_crypt_key(struct inode *inode)
+{
+	return 0;
+}
+#endif
 
 /* hooks.c */
 extern int fscrypt_file_open(struct inode *inode, struct file *filp);
@@ -322,6 +357,17 @@ static inline void fscrypt_put_encryption_info(struct inode *inode)
 	return;
 }
 
+static inline bool fscrypt_inode_is_hw_encrypted(const struct inode *inode)
+{
+	return false;
+}
+
+static inline bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+						 const struct inode *inode_2)
+{
+	return true;
+}
+
  /* fname.c */
 static inline int fscrypt_setup_filename(struct inode *dir,
 					 const struct qstr *iname,
@@ -392,6 +438,18 @@ static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_set_bio_crypt_ctx(const struct inode *inode,
+					    struct bio *bio,
+					    u64 data_unit_num)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fscrypt_evict_crypt_key(struct inode *inode)
+{
+	return 0;
+}
+
 /* hooks.c */
 
 static inline int fscrypt_file_open(struct inode *inode, struct file *filp)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 121e82ce296b..60d0963c389c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -224,7 +224,17 @@ struct fsxattr {
 #define FS_POLICY_FLAGS_PAD_32		0x03
 #define FS_POLICY_FLAGS_PAD_MASK	0x03
 #define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
-#define FS_POLICY_FLAGS_VALID		0x07
+#define FS_POLICY_FLAGS_VALID_BASE	0x07
+
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
+#define FS_POLICY_FLAGS_HW_ENCRYPTION	0x08
+#else
+#define FS_POLICY_FLAGS_HW_ENCRYPTION	0x00
+#endif
+
+
+#define FS_POLICY_FLAGS_VALID (FS_POLICY_FLAGS_VALID_BASE | \
+			       FS_POLICY_FLAGS_HW_ENCRYPTION)
 
 /* Encryption algorithms */
 #define FS_ENCRYPTION_MODE_INVALID		0
-- 
2.21.0.1020.gf2820cf01a-goog

