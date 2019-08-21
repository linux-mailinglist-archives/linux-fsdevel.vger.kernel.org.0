Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B297438
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHUH5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:57:37 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47287 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfHUH5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:57:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id l11so812854pgc.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJks2ByAGz5isWsWsG+cQFtjLu6PTmx1yKPNg7Wu/oY=;
        b=oP57VYhNVm6fJqGnzvPq0MNG2DWSwlgDOiAzthsXlw7IVzuD9Lu3eK5Ady0RdkNKZH
         YkURe8SghpiWMhIsGkcT+OE9aCWVEG+VzHZBvXs1I2C/Onvw0S9x0ZD7mmOP5hUXhejw
         WKnoglXhIX94ie3MwN1PASFFs3sCCYdy/Bv1eGsjNYxzizzHvo1L8GbX58SCl6ykti2X
         1lHXWi+qUBSDDRni3JCH7DTYyU5PYu7WxtUHAdjUl+Svn1k2UConM0Zxek7nbuO4CLfj
         gN99inDMS8e0hiR29nyisHqJR+SYjMIoSWvTi6bH9h44Ww7s9IZ8fo78lpxhvc46D+aT
         2DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJks2ByAGz5isWsWsG+cQFtjLu6PTmx1yKPNg7Wu/oY=;
        b=iksD8Le8+RPfEmBln201bdkcb9vyjWNFIPir3ZkruXoUPTk/NuBGpYTgqzB133RKqU
         b/aHzUwR35fW6V+9nwoWsqVRMvK8g5rMcxFDFK0++kmOniClpjjbdrzXiBMAZa4ZpbGw
         VBIPrFqJPIDlqniR4pDUOt+78EyFEvpuhmq44w7I2o7xbJcFlVcRgOpp45gJbA2K8q87
         mEQWD1K3sf3BbH1o9lKvOWzOy3Mr/ajpK9Vqo1kcj3T07kmo3KSVR6NH3bouRfEZWaJU
         9OPssAHQHxb2tzcYDUnvFARKA8FHG6O0qWPYmmA8DvWTn3l7Mh4KNWpjUgjcnpJy7ekb
         vkYg==
X-Gm-Message-State: APjAAAWsLuoZdBVrhK5JRV7aaOs+oyxmk/Ypkunn7awSZIhp+ElEHJbS
        q5GBkwebq4iC4bmEg+J0frQTXTwQ2MQ=
X-Google-Smtp-Source: APXvYqylPopODeHLkGe/8JEp0Q1XIZ7ymywBgm2XRsA++xT7WBIRp1ouWAnk1hPMNEJA5UAk4ysPzIue7QI=
X-Received: by 2002:a63:ff65:: with SMTP id s37mr27579097pgk.102.1566374255829;
 Wed, 21 Aug 2019 00:57:35 -0700 (PDT)
Date:   Wed, 21 Aug 2019 00:57:13 -0700
In-Reply-To: <20190821075714.65140-1-satyat@google.com>
Message-Id: <20190821075714.65140-8-satyat@google.com>
Mime-Version: 1.0
References: <20190821075714.65140-1-satyat@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v4 7/8] fscrypt: wire up fscrypt to use blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
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
encryption by calling fscrypt_inode_is_inline_crypted. Files can be marked
as inline encrypted from userspace by appropriately modifying the flags
(OR-ing FS_POLICY_FLAGS_INLINE_ENCRYPTION to it) in the fscrypt_policy
passed to fscrypt_ioctl_set_policy.

To test inline encryption with the fscrypt dummy context, add
ctx.flags |= FS_POLICY_FLAGS_INLINE_ENCRYPTION
when setting up the dummy context in fs/crypto/keyinfo.c.

Note that blk-crypto will fall back to software en/decryption in the
absence of inline crypto hardware, so setting up the ctx.flags in the
dummy context without inline crypto hardware serves as a test for
the software fallback in blk-crypto.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/crypto/Kconfig           |   6 ++
 fs/crypto/bio.c             | 137 ++++++++++++++++++++++++++++++++----
 fs/crypto/fscrypt_private.h |  23 ++++++
 fs/crypto/keyinfo.c         | 107 +++++++++++++++++++++-------
 fs/crypto/policy.c          |   6 ++
 include/linux/fscrypt.h     |  72 +++++++++++++++++++
 include/uapi/linux/fs.h     |   3 +-
 7 files changed, 316 insertions(+), 38 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 5fdf24877c17..8191e0ff5014 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -14,3 +14,9 @@ config FS_ENCRYPTION
 	  efficient since it avoids caching the encrypted and
 	  decrypted pages in the page cache.  Currently Ext4,
 	  F2FS and UBIFS make use of this feature.
+
+config FS_ENCRYPTION_INLINE_CRYPT
+	bool "Enable fscrypt to use inline crypto"
+	depends on FS_ENCRYPTION && BLK_INLINE_ENCRYPTION
+	help
+	  Enables fscrypt to use inline crypto hardware if available.
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 82da2510721f..d3c3f63ec109 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,6 +24,9 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <linux/keyslot-manager.h>
+#include <linux/blkdev.h>
+#include <crypto/algapi.h>
 #include "fscrypt_private.h"
 
 static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
@@ -76,17 +79,24 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	struct page *ciphertext_page;
 	struct bio *bio;
 	int ret, err = 0;
+	bool need_fscrypt_crypto = fscrypt_needs_fs_layer_crypto(inode);
 
-	ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
-	if (!ciphertext_page)
-		return -ENOMEM;
+	if (need_fscrypt_crypto) {
+		ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
+		if (!ciphertext_page)
+			return -ENOMEM;
+	} else {
+		ciphertext_page = ZERO_PAGE(0);
+	}
 
 	while (len--) {
-		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
-					  ZERO_PAGE(0), ciphertext_page,
-					  blocksize, 0, GFP_NOFS);
-		if (err)
-			goto errout;
+		if (need_fscrypt_crypto) {
+			err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
+						  ZERO_PAGE(0), ciphertext_page,
+						  blocksize, 0, GFP_NOFS);
+			if (err)
+				goto errout;
+		}
 
 		bio = bio_alloc(GFP_NOWAIT, 1);
 		if (!bio) {
@@ -103,9 +113,12 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			err = -EIO;
 			goto errout;
 		}
-		err = submit_bio_wait(bio);
-		if (err == 0 && bio->bi_status)
-			err = -EIO;
+		err = fscrypt_set_bio_crypt_ctx(bio, inode, pblk, GFP_NOIO);
+		if (!err) {
+			err = submit_bio_wait(bio);
+			if (err == 0 && bio->bi_status)
+				err = -EIO;
+		}
 		bio_put(bio);
 		if (err)
 			goto errout;
@@ -114,7 +127,107 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	}
 	err = 0;
 errout:
-	fscrypt_free_bounce_page(ciphertext_page);
+	if (need_fscrypt_crypto)
+		fscrypt_free_bounce_page(ciphertext_page);
 	return err;
 }
 EXPORT_SYMBOL(fscrypt_zeroout_range);
+
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+enum blk_crypto_mode_num
+get_blk_crypto_mode_for_fscryptalg(u8 fscrypt_alg)
+{
+	switch (fscrypt_alg) {
+	case FS_ENCRYPTION_MODE_AES_256_XTS:
+		return BLK_ENCRYPTION_MODE_AES_256_XTS;
+	default: return BLK_ENCRYPTION_MODE_INVALID;
+	}
+}
+
+int fscrypt_set_bio_crypt_ctx(struct bio *bio,
+			      const struct inode *inode,
+			      u64 data_unit_num,
+			      gfp_t gfp_mask)
+{
+	struct fscrypt_info *ci = inode->i_crypt_info;
+	int err;
+	enum blk_crypto_mode_num blk_crypto_mode;
+
+
+	/* If inode is not inline encrypted, nothing to do. */
+	if (!fscrypt_inode_is_inline_crypted(inode))
+		return 0;
+
+	blk_crypto_mode = get_blk_crypto_mode_for_fscryptalg(ci->ci_data_mode);
+	if (blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
+		return -EINVAL;
+
+	err = bio_crypt_set_ctx(bio, ci->ci_master_key->mk_raw,
+				blk_crypto_mode,
+				data_unit_num,
+				inode->i_blkbits,
+				gfp_mask);
+	if (err)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(fscrypt_set_bio_crypt_ctx);
+
+void fscrypt_unset_bio_crypt_ctx(struct bio *bio)
+{
+	bio_crypt_free_ctx(bio);
+}
+EXPORT_SYMBOL(fscrypt_unset_bio_crypt_ctx);
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
+	    !fscrypt_inode_is_inline_crypted(inode)) {
+		return 0;
+	}
+
+	return keyslot_manager_evict_key(q->ksm,
+					 ci->ci_master_key->mk_raw,
+					 get_blk_crypto_mode_for_fscryptalg(
+						ci->ci_data_mode),
+					 1 << inode->i_blkbits);
+}
+EXPORT_SYMBOL(fscrypt_evict_crypt_key);
+
+bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+				   const struct inode *inode_2)
+{
+	struct fscrypt_info *ci_1, *ci_2;
+	bool enc_1 = !inode_1 || fscrypt_inode_is_inline_crypted(inode_1);
+	bool enc_2 = !inode_2 || fscrypt_inode_is_inline_crypted(inode_2);
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
+#endif /* FS_ENCRYPTION_INLINE_CRYPT */
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 8978eec9d766..3079405a2b12 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -14,6 +14,7 @@
 
 #include <linux/fscrypt.h>
 #include <crypto/hash.h>
+#include <linux/blk-crypto.h>
 
 /* Encryption parameters */
 #define FS_KEY_DERIVATION_NONCE_SIZE	16
@@ -49,6 +50,17 @@ struct fscrypt_symlink_data {
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
+	struct super_block *mk_sb;
+};
+
 /*
  * fscrypt_info - the "encryption key" for an inode
  *
@@ -113,6 +125,17 @@ static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 	return false;
 }
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern enum blk_crypto_mode_num
+get_blk_crypto_mode_for_fscryptalg(u8 fscrypt_alg);
+#else
+static inline enum blk_crypto_mode_num
+get_blk_crypto_mode_for_fscryptalg(u8 fscrypt_alg)
+{
+	return BLK_ENCRYPTION_MODE_INVALID;
+}
+#endif
+
 /* crypto.c */
 extern struct kmem_cache *fscrypt_info_cachep;
 extern int fscrypt_initialize(unsigned int cop_flags);
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 207ebed918c1..989cf12217df 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -12,6 +12,7 @@
 #include <keys/user-type.h>
 #include <linux/hashtable.h>
 #include <linux/scatterlist.h>
+#include <linux/keyslot-manager.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/sha.h>
@@ -24,6 +25,21 @@ static struct crypto_shash *essiv_hash_tfm;
 static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
 static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+static inline bool flags_inline_crypted(u8 flags,
+					const struct inode *inode)
+{
+	return (flags & FS_POLICY_FLAGS_INLINE_CRYPT_OPTIMIZED) &&
+	       S_ISREG(inode->i_mode);
+}
+#else
+static inline bool flags_inline_crypted(u8 flags,
+					const struct inode *inode)
+{
+	return false;
+}
+#endif /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
 /*
  * Key derivation function.  This generates the derived key by encrypting the
  * master key with AES-128-ECB using the inode's nonce as the AES key.
@@ -219,6 +235,9 @@ static int find_and_derive_key(const struct inode *inode,
 			memcpy(derived_key, payload->raw, mode->keysize);
 			err = 0;
 		}
+	} else if (flags_inline_crypted(ctx->flags, inode)) {
+		memcpy(derived_key, payload->raw, mode->keysize);
+		err = 0;
 	} else {
 		err = derive_key_aes(payload->raw, ctx, derived_key,
 				     mode->keysize);
@@ -268,16 +287,6 @@ allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
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
@@ -286,13 +295,15 @@ static void free_master_key(struct fscrypt_master_key *mk)
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
 
@@ -305,7 +316,9 @@ static void put_master_key(struct fscrypt_master_key *mk)
 static struct fscrypt_master_key *
 find_or_insert_master_key(struct fscrypt_master_key *to_insert,
 			  const u8 *raw_key, const struct fscrypt_mode *mode,
-			  const struct fscrypt_info *ci)
+			  const struct fscrypt_info *ci,
+			  bool should_have_ctfm,
+			  struct super_block *sb)
 {
 	unsigned long hash_key;
 	struct fscrypt_master_key *mk;
@@ -328,6 +341,10 @@ find_or_insert_master_key(struct fscrypt_master_key *to_insert,
 			continue;
 		if (crypto_memneq(raw_key, mk->mk_raw, mode->keysize))
 			continue;
+		if (should_have_ctfm != (bool)mk->mk_ctfm)
+			continue;
+		if (sb != mk->mk_sb)
+			continue;
 		/* using existing tfm with same (descriptor, mode, raw_key) */
 		refcount_inc(&mk->mk_refcount);
 		spin_unlock(&fscrypt_master_keys_lock);
@@ -347,9 +364,11 @@ fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 {
 	struct fscrypt_master_key *mk;
 	int err;
+	bool inline_crypted = flags_inline_crypted(ci->ci_flags, inode);
 
 	/* Is there already a tfm for this key? */
-	mk = find_or_insert_master_key(NULL, raw_key, mode, ci);
+	mk = find_or_insert_master_key(NULL, raw_key, mode, ci, !inline_crypted,
+				       inode->i_sb);
 	if (mk)
 		return mk;
 
@@ -359,17 +378,21 @@ fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&mk->mk_refcount, 1);
 	mk->mk_mode = mode;
-	mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
-	if (IS_ERR(mk->mk_ctfm)) {
-		err = PTR_ERR(mk->mk_ctfm);
-		mk->mk_ctfm = NULL;
-		goto err_free_mk;
+	if (!inline_crypted) {
+		mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
+		if (IS_ERR(mk->mk_ctfm)) {
+			err = PTR_ERR(mk->mk_ctfm);
+			mk->mk_ctfm = NULL;
+			goto err_free_mk;
+		}
 	}
 	memcpy(mk->mk_descriptor, ci->ci_master_key_descriptor,
 	       FS_KEY_DESCRIPTOR_SIZE);
 	memcpy(mk->mk_raw, raw_key, mode->keysize);
+	mk->mk_sb = inode->i_sb;
 
-	return find_or_insert_master_key(mk, raw_key, mode, ci);
+	return find_or_insert_master_key(mk, raw_key, mode, ci, !inline_crypted,
+					 inode->i_sb);
 
 err_free_mk:
 	free_master_key(mk);
@@ -455,7 +478,8 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	struct crypto_skcipher *ctfm;
 	int err;
 
-	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) {
+	if ((ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) ||
+	    flags_inline_crypted(ci->ci_flags, inode)) {
 		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
 		if (IS_ERR(mk))
 			return PTR_ERR(mk);
@@ -485,13 +509,13 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
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
@@ -506,6 +530,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	struct fscrypt_mode *mode;
 	u8 *raw_key = NULL;
 	int res;
+	enum blk_crypto_mode_num blk_crypto_mode;
 
 	if (fscrypt_has_encryption_key(inode))
 		return 0;
@@ -571,12 +596,26 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	if (res)
 		goto out;
 
-	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL)
+	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL) {
 		crypt_info = NULL;
+		if (!flags_inline_crypted(ctx.flags, inode))
+			goto out;
+		blk_crypto_mode = get_blk_crypto_mode_for_fscryptalg(
+			inode->i_crypt_info->ci_mode - available_modes);
+
+		if (keyslot_manager_rq_crypto_mode_supported(
+						inode->i_sb->s_bdev->bd_queue,
+						blk_crypto_mode,
+						(1 << inode->i_blkbits))) {
+			goto out;
+		}
+
+		blk_crypto_mode_alloc_ciphers(blk_crypto_mode);
+	}
 out:
 	if (res == -ENOKEY)
 		res = 0;
-	put_crypt_info(crypt_info);
+	put_crypt_info(crypt_info, NULL);
 	kzfree(raw_key);
 	return res;
 }
@@ -590,7 +629,7 @@ EXPORT_SYMBOL(fscrypt_get_encryption_info);
  */
 void fscrypt_put_encryption_info(struct inode *inode)
 {
-	put_crypt_info(inode->i_crypt_info);
+	put_crypt_info(inode->i_crypt_info, inode);
 	inode->i_crypt_info = NULL;
 }
 EXPORT_SYMBOL(fscrypt_put_encryption_info);
@@ -609,3 +648,21 @@ void fscrypt_free_inode(struct inode *inode)
 	}
 }
 EXPORT_SYMBOL(fscrypt_free_inode);
+
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+bool fscrypt_inode_is_inline_crypted(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+	       flags_inline_crypted(inode->i_crypt_info->ci_flags, inode);
+}
+EXPORT_SYMBOL(fscrypt_inode_is_inline_crypted);
+
+#endif /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
+bool fscrypt_needs_fs_layer_crypto(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+	       !fscrypt_inode_is_inline_crypted(inode);
+}
+EXPORT_SYMBOL(fscrypt_needs_fs_layer_crypto);
+
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 4941fe8471ce..573407a2cda3 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -36,6 +36,7 @@ static int create_encryption_context_from_policy(struct inode *inode,
 	struct fscrypt_context ctx;
 
 	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+
 	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
 					FS_KEY_DESCRIPTOR_SIZE);
 
@@ -46,8 +47,13 @@ static int create_encryption_context_from_policy(struct inode *inode,
 	if (policy->flags & ~FS_POLICY_FLAGS_VALID)
 		return -EINVAL;
 
+	if (!inode->i_sb->s_cop->inline_crypt_supp &&
+	    (policy->flags & FS_POLICY_FLAGS_INLINE_CRYPT_OPTIMIZED))
+		return -EINVAL;
+
 	ctx.contents_encryption_mode = policy->contents_encryption_mode;
 	ctx.filenames_encryption_mode = policy->filenames_encryption_mode;
+
 	ctx.flags = policy->flags;
 	BUILD_BUG_ON(sizeof(ctx.nonce) != FS_KEY_DERIVATION_NONCE_SIZE);
 	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index bd8f207a2fb6..6db1c7c5009d 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -61,6 +61,7 @@ struct fscrypt_operations {
 	bool (*dummy_context)(struct inode *);
 	bool (*empty_dir)(struct inode *);
 	unsigned int max_namelen;
+	bool inline_crypt_supp;
 };
 
 /* Decryption work */
@@ -141,6 +142,23 @@ extern int fscrypt_inherit_context(struct inode *, struct inode *,
 extern int fscrypt_get_encryption_info(struct inode *);
 extern void fscrypt_put_encryption_info(struct inode *);
 extern void fscrypt_free_inode(struct inode *);
+extern bool fscrypt_needs_fs_layer_crypto(const struct inode *inode);
+
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern bool fscrypt_inode_is_inline_crypted(const struct inode *inode);
+extern bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+					  const struct inode *inode_2);
+#else
+static inline bool fscrypt_inode_is_inline_crypted(const struct inode *inode)
+{
+	return false;
+}
+static inline bool fscrypt_inode_crypt_mergeable(const struct inode *inode_1,
+						 const struct inode *inode_2)
+{
+	return true;
+}
+#endif /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 /* fname.c */
 extern int fscrypt_setup_filename(struct inode *, const struct qstr *,
@@ -237,6 +255,29 @@ extern void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx,
 					struct bio *bio);
 extern int fscrypt_zeroout_range(const struct inode *, pgoff_t, sector_t,
 				 unsigned int);
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern int fscrypt_set_bio_crypt_ctx(struct bio *bio,
+				     const struct inode *inode,
+				     u64 data_unit_num,
+				     gfp_t gfp_mask);
+extern void fscrypt_unset_bio_crypt_ctx(struct bio *bio);
+extern int fscrypt_evict_crypt_key(struct inode *inode);
+#else
+static inline int fscrypt_set_bio_crypt_ctx(struct bio *bio,
+					    const struct inode *inode,
+					    u64 data_unit_num,
+					    gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline void fscrypt_unset_bio_crypt_ctx(struct bio *bio) { }
+
+static inline int fscrypt_evict_crypt_key(struct inode *inode)
+{
+	return 0;
+}
+#endif
 
 /* hooks.c */
 extern int fscrypt_file_open(struct inode *inode, struct file *filp);
@@ -381,6 +422,17 @@ static inline void fscrypt_free_inode(struct inode *inode)
 {
 }
 
+static inline bool fscrypt_inode_is_inline_crypted(const struct inode *inode)
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
@@ -446,6 +498,26 @@ static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	return -EOPNOTSUPP;
 }
 
+static inline bool fscrypt_needs_fs_layer_crypto(const struct inode *inode)
+{
+	return false;
+}
+
+static inline int fscrypt_set_bio_crypt_ctx(struct bio *bio,
+					    const struct inode *inode,
+					    u64 data_unit_num,
+					    gfp_t gfp_mask)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fscrypt_unset_bio_crypt_ctx(struct bio *bio) { }
+
+static inline int fscrypt_evict_crypt_key(struct inode *inode)
+{
+	return 0;
+}
+
 /* hooks.c */
 
 static inline int fscrypt_file_open(struct inode *inode, struct file *filp)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 59c71fa8c553..dea16d0f9d2e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -224,7 +224,8 @@ struct fsxattr {
 #define FS_POLICY_FLAGS_PAD_32		0x03
 #define FS_POLICY_FLAGS_PAD_MASK	0x03
 #define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
-#define FS_POLICY_FLAGS_VALID		0x07
+#define FS_POLICY_FLAGS_INLINE_CRYPT_OPTIMIZED	0x08
+#define FS_POLICY_FLAGS_VALID		0x0F
 
 /* Encryption algorithms */
 #define FS_ENCRYPTION_MODE_INVALID		0
-- 
2.23.0.rc1.153.gdeed80330f-goog

