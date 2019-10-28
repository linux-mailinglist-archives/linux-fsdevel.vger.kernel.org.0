Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F5E6D06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfJ1HU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:57 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46554 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbfJ1HU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:57 -0400
Received: by mail-pg1-f202.google.com with SMTP id 195so7655820pgc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZjHDwu3nbLW0lBmNY/DJlc3OwujKLVw8JCEXI/TvS+E=;
        b=nEBXpJ+Z5XzOh8CTC+gXI+CzvCbzSbJt8B3elgfBtzas2SSG6th6AH3E5NttD2fC4T
         Td3Qvqo1gllIc+8V2GO8PRFMC7b+vhrArLgz+pNBFmcInNbDypppChwQmDJ6NOD+DGCq
         MmrC0ocCfZBwprig+N8C7iS7gI8J1T1FhTmc0lYD+u9Ozs0tQsAUcG3BCv6zf8ZnDhY0
         qNjLu4rAkz3BO8sr5bKGKN/wRajFrWAX9HkFsppmK9+GyUUKtsV60V5Vxm3yPaOdPyzy
         xHnJ3KVD9Ht7IwetNl543B/mry0v+ZZcM5rbL9KtC2RUSUaDcMD+xKD/jvMTVOCZPJKo
         s2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZjHDwu3nbLW0lBmNY/DJlc3OwujKLVw8JCEXI/TvS+E=;
        b=czGvmT0AiI1JGh5K/0YSrLfJOvmE9sGBFB7KzJrwv4Gc40xbN6K4MvC7mtWdKDl+rt
         rEQgXdCqVVbk1+41ou5qYhIUdME2tzYVOi1ir0yA9a5mFpZPqB6Pp1fhrUh76GODFjQ7
         wXB58EU5vQoXJJJsiuXI2h9lZdHG5Vtgg+KcGFamgEdONZohbu89zmAqoJf/OWwYm9pI
         T32Jd+e+1kOPtl4uevezLuE6UsMvuK/nhfCLekrYdy17IbynfsRVPf1ExHJ4Hv7yGEtK
         rtI3I4WP0OB1Nzp6Cl2bc6iNP3H23/fsfSNPLje7oYM1qjq3UC4plLtWdLnIBrlDg0Wx
         YH2w==
X-Gm-Message-State: APjAAAUtrdmAQp2vS8Y8cQAtLjB4TlmJRsZaimImcrkCIHNgui8VQZh5
        oJ/s5pYdzhRTCbjazR447MxRmeIW3QE=
X-Google-Smtp-Source: APXvYqzzPcupWdzlWmHtet9wHutTkhOG5C1OoxvfJmMimROu+MWXa97sI5lwCbMBsDzQUKxrgrEbZ1m5Ano=
X-Received: by 2002:a63:200e:: with SMTP id g14mr19326954pgg.91.1572247255970;
 Mon, 28 Oct 2019 00:20:55 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:30 -0700
In-Reply-To: <20191028072032.6911-1-satyat@google.com>
Message-Id: <20191028072032.6911-8-satyat@google.com>
Mime-Version: 1.0
References: <20191028072032.6911-1-satyat@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 7/9] fscrypt: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for inline encryption to fs/crypto/.  With "inline
encryption", the block layer handles the decryption/encryption as part
of the bio, instead of the filesystem doing the crypto itself via
Linux's crypto API.  This model is needed in order to take advantage of
the inline encryption hardware present on most modern mobile SoCs.

To use inline encryption, the filesystem needs to be mounted with
'-o inlinecrypt'.  The contents of any AES-256-XTS encrypted files will
then be encrypted using blk-crypto, instead of using the traditional
filesystem-layer crypto.  fscrypt still provides the key and IV to use,
and the actual ciphertext on-disk is still the same; therefore it's
testable using the existing fscrypt ciphertext verification tests.

Note that since blk-crypto has a fallack to Linux's crypto API, this
feature is usable and testable even without actual inline encryption
hardware.

Per-filesystem changes will be needed to set encryption contexts when
submitting bios and to implement the 'inlinecrypt' mount option.  This
patch just adds the common code.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/crypto/Kconfig           |   6 +
 fs/crypto/Makefile          |   1 +
 fs/crypto/bio.c             |  31 ++-
 fs/crypto/fscrypt_private.h |  72 +++++++
 fs/crypto/inline_crypt.c    | 390 ++++++++++++++++++++++++++++++++++++
 fs/crypto/keyring.c         |   2 +
 fs/crypto/keysetup.c        |  18 +-
 include/linux/fscrypt.h     |  60 ++++++
 8 files changed, 566 insertions(+), 14 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index ff5a1746cbae..5061aa546202 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -16,3 +16,9 @@ config FS_ENCRYPTION
 	  efficient since it avoids caching the encrypted and
 	  decrypted pages in the page cache.  Currently Ext4,
 	  F2FS and UBIFS make use of this feature.
+
+config FS_ENCRYPTION_INLINE_CRYPT
+	bool "Enable fscrypt to use inline crypto"
+	depends on FS_ENCRYPTION && BLK_INLINE_ENCRYPTION
+	help
+	  Enable fscrypt to use inline encryption hardware if available.
diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
index 232e2bb5a337..652c7180ec6d 100644
--- a/fs/crypto/Makefile
+++ b/fs/crypto/Makefile
@@ -11,3 +11,4 @@ fscrypto-y := crypto.o \
 	      policy.o
 
 fscrypto-$(CONFIG_BLOCK) += bio.o
+fscrypto-$(CONFIG_FS_ENCRYPTION_INLINE_CRYPT) += inline_crypt.o
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 1f4b8a277060..956798debf71 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -46,26 +46,38 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 {
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocksize = 1 << blockbits;
+	const bool inlinecrypt = fscrypt_inode_uses_inline_crypto(inode);
 	struct page *ciphertext_page;
 	struct bio *bio;
 	int ret, err = 0;
 
-	ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
-	if (!ciphertext_page)
-		return -ENOMEM;
+	if (inlinecrypt) {
+		ciphertext_page = ZERO_PAGE(0);
+	} else {
+		ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
+		if (!ciphertext_page)
+			return -ENOMEM;
+	}
 
 	while (len--) {
-		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
-					  ZERO_PAGE(0), ciphertext_page,
-					  blocksize, 0, GFP_NOFS);
-		if (err)
-			goto errout;
+		if (!inlinecrypt) {
+			err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
+						  ZERO_PAGE(0), ciphertext_page,
+						  blocksize, 0, GFP_NOFS);
+			if (err)
+				goto errout;
+		}
 
 		bio = bio_alloc(GFP_NOWAIT, 1);
 		if (!bio) {
 			err = -ENOMEM;
 			goto errout;
 		}
+		err = fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOIO);
+		if (err) {
+			bio_put(bio);
+			goto errout;
+		}
 		bio_set_dev(bio, inode->i_sb->s_bdev);
 		bio->bi_iter.bi_sector = pblk << (blockbits - 9);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
@@ -87,7 +99,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	}
 	err = 0;
 errout:
-	fscrypt_free_bounce_page(ciphertext_page);
+	if (!inlinecrypt)
+		fscrypt_free_bounce_page(ciphertext_page);
 	return err;
 }
 EXPORT_SYMBOL(fscrypt_zeroout_range);
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index b44e445b43a8..c731bd4245c5 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -13,6 +13,9 @@
 
 #include <linux/fscrypt.h>
 #include <crypto/hash.h>
+#include <linux/bio-crypt-ctx.h>
+
+struct fscrypt_master_key;
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
 
@@ -163,6 +166,14 @@ struct fscrypt_info {
 	/* The actual crypto transform used for encryption and decryption */
 	struct crypto_skcipher *ci_ctfm;
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	/*
+	 * The raw key for inline encryption, if this file is using inline
+	 * encryption rather than the traditional filesystem layer encryption.
+	 */
+	const u8 *ci_inline_crypt_key;
+#endif
+
 	/* True if the key should be freed when this fscrypt_info is freed */
 	bool ci_owns_key;
 
@@ -293,6 +304,54 @@ extern int fscrypt_hkdf_expand(struct fscrypt_hkdf *hkdf, u8 context,
 
 extern void fscrypt_destroy_hkdf(struct fscrypt_hkdf *hkdf);
 
+/* inline_crypt.c */
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern bool fscrypt_should_use_inline_encryption(const struct fscrypt_info *ci);
+
+extern int fscrypt_set_inline_crypt_key(struct fscrypt_info *ci,
+					const u8 *derived_key);
+
+extern void fscrypt_free_inline_crypt_key(struct fscrypt_info *ci);
+
+extern int fscrypt_setup_per_mode_inline_crypt_key(
+					struct fscrypt_info *ci,
+					struct fscrypt_master_key *mk);
+
+extern void fscrypt_evict_inline_crypt_keys(struct fscrypt_master_key *mk);
+
+#else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
+static inline bool fscrypt_should_use_inline_encryption(
+					const struct fscrypt_info *ci)
+{
+	return false;
+}
+
+static inline int fscrypt_set_inline_crypt_key(struct fscrypt_info *ci,
+					       const u8 *derived_key)
+{
+	WARN_ON(1);
+	return -EOPNOTSUPP;
+}
+
+static inline void fscrypt_free_inline_crypt_key(struct fscrypt_info *ci)
+{
+}
+
+static inline int fscrypt_setup_per_mode_inline_crypt_key(
+					struct fscrypt_info *ci,
+					struct fscrypt_master_key *mk)
+{
+	WARN_ON(1);
+	return -EOPNOTSUPP;
+}
+
+static inline void fscrypt_evict_inline_crypt_keys(
+					struct fscrypt_master_key *mk)
+{
+}
+#endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
 /* keyring.c */
 
 /*
@@ -391,6 +450,16 @@ struct fscrypt_master_key {
 	 */
 	struct crypto_skcipher	*mk_iv_ino_lblk_64_tfms[__FSCRYPT_MODE_MAX + 1];
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	/* Raw keys for IV_INO_LBLK_64 policies, allocated on-demand */
+	u8			*mk_iv_ino_lblk_64_raw_keys[__FSCRYPT_MODE_MAX + 1];
+
+	/* The data unit size being used for inline encryption */
+	unsigned int		mk_data_unit_size;
+
+	/* The filesystem's block device */
+	struct block_device	*mk_bdev;
+#endif
 } __randomize_layout;
 
 static inline bool
@@ -445,9 +514,12 @@ struct fscrypt_mode {
 	const char *cipher_str;
 	int keysize;
 	int ivsize;
+	enum blk_crypto_mode_num blk_crypto_mode;
 	bool logged_impl_name;
 };
 
+extern struct fscrypt_mode fscrypt_modes[];
+
 static inline bool
 fscrypt_mode_supports_direct_key(const struct fscrypt_mode *mode)
 {
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
new file mode 100644
index 000000000000..e41c6d66ff0d
--- /dev/null
+++ b/fs/crypto/inline_crypt.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Inline encryption support for fscrypt
+ *
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * With "inline encryption", the block layer handles the decryption/encryption
+ * as part of the bio, instead of the filesystem doing the crypto itself via
+ * crypto API.  See Documentation/block/inline-encryption.rst.  fscrypt still
+ * provides the key and IV to use.
+ */
+
+#include <linux/blk-crypto.h>
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/keyslot-manager.h>
+
+#include "fscrypt_private.h"
+
+/* Return true iff inline encryption should be used for this file */
+bool fscrypt_should_use_inline_encryption(const struct fscrypt_info *ci)
+{
+	const struct inode *inode = ci->ci_inode;
+	struct super_block *sb = inode->i_sb;
+
+	/* The file must need contents encryption, not filenames encryption */
+	if (!S_ISREG(inode->i_mode))
+		return false;
+
+	/* blk-crypto must implement the needed encryption algorithm */
+	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
+		return false;
+
+	/* DIRECT_KEY needs a 24+ byte IV, so it can't work with 8-byte DUNs */
+	if (fscrypt_is_direct_key_policy(&ci->ci_policy))
+		return false;
+
+	/* The filesystem must be mounted with -o inlinecrypt */
+	if (!sb->s_cop->inline_crypt_enabled ||
+	    !sb->s_cop->inline_crypt_enabled(sb))
+		return false;
+
+	return true;
+}
+
+/* Set a per-file inline encryption key (for passing to blk-crypto) */
+int fscrypt_set_inline_crypt_key(struct fscrypt_info *ci, const u8 *derived_key)
+{
+	const struct fscrypt_mode *mode = ci->ci_mode;
+	const struct super_block *sb = ci->ci_inode->i_sb;
+
+	ci->ci_inline_crypt_key = kmemdup(derived_key, mode->keysize, GFP_NOFS);
+	if (!ci->ci_inline_crypt_key)
+		return -ENOMEM;
+	ci->ci_owns_key = true;
+
+	return blk_crypto_start_using_mode(mode->blk_crypto_mode,
+					   sb->s_blocksize,
+					   sb->s_bdev->bd_queue);
+}
+
+/* Free a per-file inline encryption key and evict it from blk-crypto */
+void fscrypt_free_inline_crypt_key(struct fscrypt_info *ci)
+{
+	if (ci->ci_inline_crypt_key != NULL) {
+		const struct fscrypt_mode *mode = ci->ci_mode;
+		const struct super_block *sb = ci->ci_inode->i_sb;
+
+		blk_crypto_evict_key(sb->s_bdev->bd_queue,
+				     ci->ci_inline_crypt_key,
+				     mode->blk_crypto_mode, sb->s_blocksize);
+		kzfree(ci->ci_inline_crypt_key);
+	}
+}
+
+/*
+ * Set up ->inline_crypt_key (for passing to blk-crypto) for inodes which use an
+ * IV_INO_LBLK_64 encryption policy.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fscrypt_setup_per_mode_inline_crypt_key(struct fscrypt_info *ci,
+					    struct fscrypt_master_key *mk)
+{
+	static DEFINE_MUTEX(inline_crypt_setup_mutex);
+	const struct super_block *sb = ci->ci_inode->i_sb;
+	struct block_device *bdev = sb->s_bdev;
+	const struct fscrypt_mode *mode = ci->ci_mode;
+	const u8 mode_num = mode - fscrypt_modes;
+	u8 *raw_key;
+	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
+	int err;
+
+	if (WARN_ON(mode_num > __FSCRYPT_MODE_MAX))
+		return -EINVAL;
+
+	/* pairs with smp_store_release() below */
+	raw_key = smp_load_acquire(&mk->mk_iv_ino_lblk_64_raw_keys[mode_num]);
+	if (raw_key) {
+		err = 0;
+		goto out;
+	}
+
+	mutex_lock(&inline_crypt_setup_mutex);
+
+	raw_key = mk->mk_iv_ino_lblk_64_raw_keys[mode_num];
+	if (raw_key) {
+		err = 0;
+		goto out_unlock;
+	}
+
+	raw_key = kmalloc(mode->keysize, GFP_NOFS);
+	if (!raw_key) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	BUILD_BUG_ON(sizeof(mode_num) != 1);
+	BUILD_BUG_ON(sizeof(sb->s_uuid) != 16);
+	BUILD_BUG_ON(sizeof(hkdf_info) != 17);
+	hkdf_info[0] = mode_num;
+	memcpy(&hkdf_info[1], &sb->s_uuid, sizeof(sb->s_uuid));
+
+	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+				  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
+				  hkdf_info, sizeof(hkdf_info),
+				  raw_key, mode->keysize);
+	if (err)
+		goto out_unlock;
+
+	err = blk_crypto_start_using_mode(mode->blk_crypto_mode,
+					  sb->s_blocksize, bdev->bd_queue);
+	if (err)
+		goto out_unlock;
+
+	/*
+	 * When a master key's first inline encryption key is set up, save a
+	 * reference to the filesystem's block device so that the inline
+	 * encryption keys can be evicted when the master key is destroyed.
+	 */
+	if (!mk->mk_bdev) {
+		mk->mk_bdev = bdgrab(bdev);
+		mk->mk_data_unit_size = sb->s_blocksize;
+	}
+
+	/* pairs with smp_load_acquire() above */
+	smp_store_release(&mk->mk_iv_ino_lblk_64_raw_keys[mode_num], raw_key);
+	err = 0;
+out_unlock:
+	mutex_unlock(&inline_crypt_setup_mutex);
+out:
+	if (err == 0) {
+		ci->ci_inline_crypt_key = raw_key;
+		/*
+		 * Since each struct fscrypt_master_key belongs to a particular
+		 * filesystem (a struct super_block), there should be only one
+		 * block device, and only one data unit size as it should equal
+		 * the filesystem's blocksize (i.e. s_blocksize).
+		 */
+		if (WARN_ON(mk->mk_bdev != bdev))
+			err = -EINVAL;
+		if (WARN_ON(mk->mk_data_unit_size != sb->s_blocksize))
+			err = -EINVAL;
+	} else {
+		kzfree(raw_key);
+	}
+	return err;
+}
+
+/*
+ * Evict per-mode inline encryption keys from blk-crypto when a master key is
+ * destroyed.
+ */
+void fscrypt_evict_inline_crypt_keys(struct fscrypt_master_key *mk)
+{
+	struct block_device *bdev = mk->mk_bdev;
+	size_t i;
+
+	if (!bdev) /* No inline encryption keys? */
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mk->mk_iv_ino_lblk_64_raw_keys); i++) {
+		u8 *raw_key = mk->mk_iv_ino_lblk_64_raw_keys[i];
+
+		if (raw_key != NULL) {
+			blk_crypto_evict_key(bdev->bd_queue, raw_key,
+					     fscrypt_modes[i].blk_crypto_mode,
+					     mk->mk_data_unit_size);
+			kzfree(raw_key);
+		}
+	}
+	bdput(bdev);
+}
+
+/**
+ * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline encryption
+ * @inode: an inode
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the block layer via blk-crypto rather
+ *	   than in the filesystem layer.
+ */
+bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+		inode->i_crypt_info->ci_inline_crypt_key != NULL;
+}
+EXPORT_SYMBOL_GPL(fscrypt_inode_uses_inline_crypto);
+
+/**
+ * fscrypt_inode_uses_fs_layer_crypto - test whether an inode uses fs-layer encryption
+ * @inode: an inode
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the filesystem layer rather than in the
+ *	   block layer via blk-crypto.
+ */
+bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+		inode->i_crypt_info->ci_inline_crypt_key == NULL;
+}
+EXPORT_SYMBOL_GPL(fscrypt_inode_uses_fs_layer_crypto);
+
+static inline u64 fscrypt_generate_dun(const struct fscrypt_info *ci,
+				       u64 lblk_num)
+{
+	union fscrypt_iv iv;
+
+	fscrypt_generate_iv(&iv, lblk_num, ci);
+	/*
+	 * fscrypt_should_use_inline_encryption() ensures we never get here if
+	 * more than the first 8 bytes of the IV are nonzero.
+	 */
+	BUG_ON(memchr_inv(&iv.raw[8], 0, ci->ci_mode->ivsize - 8));
+	return le64_to_cpu(iv.lblk_num);
+}
+
+/**
+ * fscrypt_set_bio_crypt_ctx - prepare a file contents bio for inline encryption
+ * @bio: a bio which will eventually be submitted to the file
+ * @inode: the file's inode
+ * @first_lblk: the first file logical block number in the I/O
+ * @gfp_mask: memory allocation flags
+ *
+ * If the contents of the file should be encrypted (or decrypted) with inline
+ * encryption, then assign the appropriate encryption context to the bio.
+ *
+ * Normally the bio should be newly allocated (i.e. no pages added yet), as
+ * otherwise fscrypt_mergeable_bio() won't work as intended.
+ *
+ * The encryption context will be freed automatically when the bio is freed.
+ *
+ * Return: 0 on success, -errno on failure.  If __GFP_NOFAIL is specified, this
+ *	   is guaranteed to succeed.
+ */
+int fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
+			      u64 first_lblk, gfp_t gfp_mask)
+{
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	u64 dun;
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return 0;
+
+	dun = fscrypt_generate_dun(ci, first_lblk);
+
+	return bio_crypt_set_ctx(bio, ci->ci_inline_crypt_key,
+				 ci->ci_mode->blk_crypto_mode,
+				 dun, inode->i_blkbits, gfp_mask);
+}
+EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
+
+/* Extract the inode and logical block number from a buffer_head. */
+static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
+				      const struct inode **inode_ret,
+				      u64 *lblk_num_ret)
+{
+	struct page *page = bh->b_page;
+	const struct address_space *mapping;
+	const struct inode *inode;
+
+	/*
+	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
+	 * for a non-pagecache page.  fscrypt doesn't care about these.
+	 */
+	mapping = page_mapping(page);
+	if (!mapping)
+		return false;
+	inode = mapping->host;
+
+	*inode_ret = inode;
+	*lblk_num_ret = ((u64)page->index << (PAGE_SHIFT - inode->i_blkbits)) +
+			(bh_offset(bh) >> inode->i_blkbits);
+	return true;
+}
+
+/**
+ * fscrypt_set_bio_crypt_ctx_bh - prepare a file contents bio for inline encryption
+ * @bio: a bio which will eventually be submitted to the file
+ * @first_bh: the first buffer_head for which I/O will be submitted
+ * @gfp_mask: memory allocation flags
+ *
+ * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead
+ * of an inode and block number directly.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
+				 const struct buffer_head *first_bh,
+				 gfp_t gfp_mask)
+{
+	const struct inode *inode;
+	u64 first_lblk;
+
+	if (!bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
+		return 0;
+
+	return fscrypt_set_bio_crypt_ctx(bio, inode, first_lblk, gfp_mask);
+}
+EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
+
+/**
+ * fscrypt_mergeable_bio - test whether data can be added to a bio
+ * @bio: the bio being built up
+ * @inode: the inode for the next part of the I/O
+ * @next_lblk: the next file logical block number in the I/O
+ *
+ * When building a bio which may contain data which should undergo inline
+ * encryption (or decryption) via fscrypt, filesystems should call this function
+ * to ensure that the resulting bio contains only logically contiguous data.
+ * This will return false if the next part of the I/O cannot be merged with the
+ * bio because either the encryption key would be different or the encryption
+ * data unit numbers would be discontiguous.
+ *
+ * fscrypt_set_bio_crypt_ctx() must have already been called on the bio.
+ *
+ * Return: true iff the I/O is mergeable
+ */
+bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
+			   u64 next_lblk)
+{
+	const struct bio_crypt_ctx *bc;
+	const u8 *next_key;
+	u64 next_dun;
+
+	if (bio_has_crypt_ctx(bio) != fscrypt_inode_uses_inline_crypto(inode))
+		return false;
+	if (!bio_has_crypt_ctx(bio))
+		return true;
+	bc = bio->bi_crypt_context;
+	next_key = inode->i_crypt_info->ci_inline_crypt_key;
+	next_dun = fscrypt_generate_dun(inode->i_crypt_info, next_lblk);
+
+	/*
+	 * Comparing the key pointers is good enough, as all I/O for each key
+	 * uses the same pointer.  I.e., there's currently no need to support
+	 * merging requests where the keys are the same but the pointers differ.
+	 */
+	return next_key == bc->raw_key &&
+		next_dun == bc->data_unit_num +
+			    (bio_sectors(bio) >>
+			     (bc->data_unit_size_bits - SECTOR_SHIFT));
+}
+EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
+
+/**
+ * fscrypt_mergeable_bio_bh - test whether data can be added to a bio
+ * @bio: the bio being built up
+ * @next_bh: the next buffer_head for which I/O will be submitted
+ *
+ * Same as fscrypt_mergeable_bio(), except this takes a buffer_head instead of
+ * an inode and block number directly.
+ *
+ * Return: true iff the I/O is mergeable
+ */
+bool fscrypt_mergeable_bio_bh(struct bio *bio,
+			      const struct buffer_head *next_bh)
+{
+	const struct inode *inode;
+	u64 next_lblk;
+
+	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &next_lblk))
+		return !bio_has_crypt_ctx(bio);
+
+	return fscrypt_mergeable_bio(bio, inode, next_lblk);
+}
+EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 040df1f5e1c8..7788adfa2dc4 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -48,6 +48,8 @@ static void free_master_key(struct fscrypt_master_key *mk)
 		crypto_free_skcipher(mk->mk_iv_ino_lblk_64_tfms[i]);
 	}
 
+	fscrypt_evict_inline_crypt_keys(mk);
+
 	key_put(mk->mk_users);
 	kzfree(mk);
 }
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f87ab930b92a..8070dad9a541 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -13,12 +13,13 @@
 
 #include "fscrypt_private.h"
 
-static struct fscrypt_mode available_modes[] = {
+struct fscrypt_mode fscrypt_modes[] = {
 	[FSCRYPT_MODE_AES_256_XTS] = {
 		.friendly_name = "AES-256-XTS",
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
 		.ivsize = 16,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_256_XTS,
 	},
 	[FSCRYPT_MODE_AES_256_CTS] = {
 		.friendly_name = "AES-256-CTS-CBC",
@@ -51,10 +52,10 @@ select_encryption_mode(const union fscrypt_policy *policy,
 		       const struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
-		return &available_modes[fscrypt_policy_contents_mode(policy)];
+		return &fscrypt_modes[fscrypt_policy_contents_mode(policy)];
 
 	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		return &available_modes[fscrypt_policy_fnames_mode(policy)];
+		return &fscrypt_modes[fscrypt_policy_fnames_mode(policy)];
 
 	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %lu, which is not encryptable (file type %d)\n",
 		  inode->i_ino, (inode->i_mode & S_IFMT));
@@ -111,6 +112,9 @@ int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 {
 	struct crypto_skcipher *tfm;
 
+	if (fscrypt_should_use_inline_encryption(ci))
+		return fscrypt_set_inline_crypt_key(ci, derived_key);
+
 	tfm = fscrypt_allocate_skcipher(ci->ci_mode, derived_key, ci->ci_inode);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
@@ -128,7 +132,7 @@ static int setup_per_mode_key(struct fscrypt_info *ci,
 	const struct inode *inode = ci->ci_inode;
 	const struct super_block *sb = inode->i_sb;
 	struct fscrypt_mode *mode = ci->ci_mode;
-	u8 mode_num = mode - available_modes;
+	const u8 mode_num = mode - fscrypt_modes;
 	struct crypto_skcipher *tfm, *prev_tfm;
 	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
 	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
@@ -204,6 +208,8 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
+		if (fscrypt_should_use_inline_encryption(ci))
+			return fscrypt_setup_per_mode_inline_crypt_key(ci, mk);
 		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
 					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					  true);
@@ -330,8 +336,10 @@ static void put_crypt_info(struct fscrypt_info *ci)
 
 	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
-	else if (ci->ci_owns_key)
+	else if (ci->ci_owns_key) {
 		crypto_free_skcipher(ci->ci_ctfm);
+		fscrypt_free_inline_crypt_key(ci);
+	}
 
 	key = ci->ci_master_key;
 	if (key) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 1a7bffe78ed5..9583837ca37b 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -64,6 +64,7 @@ struct fscrypt_operations {
 	bool (*has_stable_inodes)(struct super_block *sb);
 	void (*get_ino_and_lblk_bits)(struct super_block *sb,
 				      int *ino_bits_ret, int *lblk_bits_ret);
+	bool (*inline_crypt_enabled)(struct super_block *sb);
 };
 
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
@@ -529,6 +530,65 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 
 #endif	/* !CONFIG_FS_ENCRYPTION */
 
+/* inline_crypt.c */
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern bool fscrypt_inode_uses_inline_crypto(const struct inode *inode);
+
+extern bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode);
+
+extern int fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
+				     u64 first_lblk, gfp_t gfp_mask);
+
+extern int fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
+					const struct buffer_head *first_bh,
+					gfp_t gfp_mask);
+
+extern bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
+				  u64 next_lblk);
+
+extern bool fscrypt_mergeable_bio_bh(struct bio *bio,
+				     const struct buffer_head *next_bh);
+
+#else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+static inline bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return false;
+}
+
+static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode);
+}
+
+static inline int fscrypt_set_bio_crypt_ctx(struct bio *bio,
+					    const struct inode *inode,
+					    u64 first_lblk, gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline int fscrypt_set_bio_crypt_ctx_bh(
+					struct bio *bio,
+					const struct buffer_head *first_bh,
+					gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline bool fscrypt_mergeable_bio(struct bio *bio,
+					 const struct inode *inode,
+					 u64 next_lblk)
+{
+	return true;
+}
+
+static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
+					    const struct buffer_head *next_bh)
+{
+	return true;
+}
+#endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
 /**
  * fscrypt_require_key - require an inode's encryption key
  * @inode: the inode we need the key for
-- 
2.24.0.rc0.303.g954a862665-goog

