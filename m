Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD46167CA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBULvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:51:20 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43214 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBULvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:51:18 -0500
Received: by mail-pg1-f201.google.com with SMTP id v14so1052855pgo.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GfTgM1ABOQuPK5Tv+3ToRKXWxqRk1vfDWSwT9JIRcEw=;
        b=PQBb4iS4mKw979lBP3/7vMlwjqV2y4sTRqpg87Pja20IQdl2m83NUHDD1jzB2eunZu
         8lpbGUAXnzVldS691759e9XFql8lCb01178lwkcqB0GCqL92QaSVqj96eUxLQmftYLQM
         qtLthIbII0w58jQeVGYo/xE9zaUChHhhZ+khScVXAeRsx+gAnVK/9fDrtT0MhkYpuu/A
         hh5MVJ+ebwhACMQ6oKHjBWcQ/eTxDkbwLnMgqwGQE/MwId7g1p7hL6hN3RhAY+0/H7kX
         cI1e1R9OJ+IIKcSdiq8XtszVKvz3UgIoSeHkMmj2X/fe+Hs6mHqNIWiFriWqv2cww+hd
         lQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GfTgM1ABOQuPK5Tv+3ToRKXWxqRk1vfDWSwT9JIRcEw=;
        b=JTOscqH2Y9AFD9OZNLg+4arZkDoZKUVK3Xv3Vz9ZF042sjjO8AcuKuAV4fJc/wyeBe
         4eIkovJtjYpsSd5qWXHIK9Y2R7iKmerTxOCNrCaP13+uZO6jJun9tK7l6kgEhnQhwgMO
         7bW+yTN2yRJWDGJpf3X3wUJXNAsHyMmESRZy1Kc79OBYaRju3hrvGwvxMwkhPIjxULNl
         OBz9ANTY6wYk6sdiq7rqci1nLTl5PpD5nq10bj45NC7237cQkfJXY7O+ebEG37WgK406
         rEodbiWQtsEU2kRfO2StJirYHD7O3t2R9YPg9pt7WunnXDrwr1hLAus2yBacTbHc134e
         crqw==
X-Gm-Message-State: APjAAAW4vdBhkK2RgrT8x3p13Im5768vMbE8Y+sAIsJpa3usf7PzLnxK
        aUt8e8aOz5QrRRLwXDufb5djL7VaNpI=
X-Google-Smtp-Source: APXvYqzaLMGlYfZb+b4yoeKptJ4V06qPSkW0VxgvcBbBPShK50lFuhFOtkHrI/QXNcmpwUVLE+6KMJUneNE=
X-Received: by 2002:a63:7b5e:: with SMTP id k30mr4896809pgn.276.1582285877783;
 Fri, 21 Feb 2020 03:51:17 -0800 (PST)
Date:   Fri, 21 Feb 2020 03:50:48 -0800
In-Reply-To: <20200221115050.238976-1-satyat@google.com>
Message-Id: <20200221115050.238976-8-satyat@google.com>
Mime-Version: 1.0
References: <20200221115050.238976-1-satyat@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 7/9] fscrypt: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
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
'-o inlinecrypt'.  The contents of any encrypted files will then be
encrypted using blk-crypto, instead of using the traditional
filesystem-layer crypto. Fscrypt still provides the key and IV to use,
and the actual ciphertext on-disk is still the same; therefore it's
testable using the existing fscrypt ciphertext verification tests.

Note that since blk-crypto has a fallack to Linux's crypto API, and
also supports all the encryption modes currently supported by fscrypt,
this feature is usable and testable even without actual inline
encryption hardware.

Per-filesystem changes will be needed to set encryption contexts when
submitting bios and to implement the 'inlinecrypt' mount option.  This
patch just adds the common code.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/crypto/Kconfig           |   6 +
 fs/crypto/Makefile          |   1 +
 fs/crypto/bio.c             |  55 ++++++
 fs/crypto/crypto.c          |   2 +-
 fs/crypto/fname.c           |   4 +-
 fs/crypto/fscrypt_private.h | 121 ++++++++++++--
 fs/crypto/inline_crypt.c    | 324 ++++++++++++++++++++++++++++++++++++
 fs/crypto/keyring.c         |   4 +-
 fs/crypto/keysetup.c        |  95 +++++++----
 fs/crypto/keysetup_v1.c     |  16 +-
 include/linux/fs.h          |   1 +
 include/linux/fscrypt.h     |  57 +++++++
 12 files changed, 629 insertions(+), 57 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 8046d7c7a3e9..f1f11a6228eb 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -24,3 +24,9 @@ config FS_ENCRYPTION_ALGS
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_XTS
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
index 4fa18fff9c4e..82d06cf4b94a 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <linux/fscrypt.h>
+#include <linux/blkdev.h>
 #include "fscrypt_private.h"
 
 void fscrypt_decrypt_bio(struct bio *bio)
@@ -41,6 +43,54 @@ void fscrypt_decrypt_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
+static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
+					      pgoff_t lblk, sector_t pblk,
+					      unsigned int len)
+{
+	const unsigned int blockbits = inode->i_blkbits;
+	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
+	struct bio *bio;
+	int ret, err = 0;
+	int num_pages = 0;
+
+	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
+	bio = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
+
+	while (len) {
+		unsigned int blocks_this_page = min(len, blocks_per_page);
+		unsigned int bytes_this_page = blocks_this_page << blockbits;
+
+		if (num_pages == 0) {
+			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOIO);
+			bio_set_dev(bio, inode->i_sb->s_bdev);
+			bio->bi_iter.bi_sector =
+					pblk << (blockbits - SECTOR_SHIFT);
+			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		}
+		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
+		if (WARN_ON(ret != bytes_this_page)) {
+			err = -EIO;
+			goto out;
+		}
+		num_pages++;
+		len -= blocks_this_page;
+		lblk += blocks_this_page;
+		pblk += blocks_this_page;
+		if (num_pages == BIO_MAX_PAGES || !len) {
+			err = submit_bio_wait(bio);
+			if (!err && bio->bi_status)
+				err = -EIO;
+			if (err)
+				goto out;
+			bio_reset(bio);
+			num_pages = 0;
+		}
+	}
+out:
+	bio_put(bio);
+	return err;
+}
+
 /**
  * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
  * @inode: the file's inode
@@ -69,12 +119,17 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	unsigned int nr_pages;
 	unsigned int i;
 	unsigned int offset;
+	const bool inlinecrypt = fscrypt_inode_uses_inline_crypto(inode);
 	struct bio *bio;
 	int ret, err;
 
 	if (len == 0)
 		return 0;
 
+	if (inlinecrypt)
+		return fscrypt_zeroout_range_inline_crypt(inode, lblk, pblk,
+							  len);
+
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_PAGES);
 	nr_pages = min_t(unsigned int, ARRAY_SIZE(pages),
 			 (len + blocks_per_page - 1) >> blocks_per_page_bits);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 1ecaac7ee3cb..263bc676c73d 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -95,7 +95,7 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
 	struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_ctfm;
+	struct crypto_skcipher *tfm = ci->ci_key.tfm;
 	int res = 0;
 
 	if (WARN_ON_ONCE(len <= 0))
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 4c212442a8f7..0fca2d7a5645 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -117,7 +117,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	const struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_ctfm;
+	struct crypto_skcipher *tfm = ci->ci_key.tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
 	int res;
@@ -170,7 +170,7 @@ static int fname_decrypt(const struct inode *inode,
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
 	const struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_ctfm;
+	struct crypto_skcipher *tfm = ci->ci_key.tfm;
 	union fscrypt_iv iv;
 	int res;
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 9aae851409e5..46e1db6c6220 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -14,6 +14,7 @@
 #include <linux/fscrypt.h>
 #include <linux/siphash.h>
 #include <crypto/hash.h>
+#include <linux/blk-crypto.h>
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
 
@@ -146,6 +147,20 @@ struct fscrypt_symlink_data {
 	char encrypted_path[1];
 } __packed;
 
+/**
+ * struct fscrypt_prepared_key - a key prepared for actual encryption/decryption
+ * @tfm: crypto API transform object
+ * @blk_key: key for blk-crypto
+ *
+ * Normally only one of the fields will be non-NULL.
+ */
+struct fscrypt_prepared_key {
+	struct crypto_skcipher *tfm;
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	struct fscrypt_blk_crypto_key *blk_key;
+#endif
+};
+
 /*
  * fscrypt_info - the "encryption key" for an inode
  *
@@ -155,12 +170,20 @@ struct fscrypt_symlink_data {
  */
 struct fscrypt_info {
 
-	/* The actual crypto transform used for encryption and decryption */
-	struct crypto_skcipher *ci_ctfm;
+	/* The key in a form prepared for actual encryption/decryption */
+	struct fscrypt_prepared_key	ci_key;
 
 	/* True if the key should be freed when this fscrypt_info is freed */
 	bool ci_owns_key;
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	/*
+	 * True if this inode will use inline encryption (blk-crypto) instead of
+	 * the traditional filesystem-layer encryption.
+	 */
+	bool ci_inlinecrypt;
+#endif
+
 	/*
 	 * Encryption mode used for this inode.  It corresponds to either the
 	 * contents or filenames encryption mode, depending on the inode type.
@@ -185,7 +208,7 @@ struct fscrypt_info {
 
 	/*
 	 * If non-NULL, then encryption is done using the master key directly
-	 * and ci_ctfm will equal ci_direct_key->dk_ctfm.
+	 * and ci_key will equal ci_direct_key->dk_key.
 	 */
 	struct fscrypt_direct_key *ci_direct_key;
 
@@ -238,6 +261,7 @@ union fscrypt_iv {
 		u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
 	};
 	u8 raw[FSCRYPT_MAX_IV_SIZE];
+	__le64 dun[FSCRYPT_MAX_IV_SIZE / sizeof(__le64)];
 };
 
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
@@ -280,6 +304,76 @@ extern int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 
 extern void fscrypt_destroy_hkdf(struct fscrypt_hkdf *hkdf);
 
+/* inline_crypt.c */
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern void fscrypt_select_encryption_impl(struct fscrypt_info *ci);
+
+static inline bool
+fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
+{
+	return ci->ci_inlinecrypt;
+}
+
+extern int fscrypt_prepare_inline_crypt_key(
+					struct fscrypt_prepared_key *prep_key,
+					const u8 *raw_key,
+					const struct fscrypt_info *ci);
+
+extern void fscrypt_destroy_inline_crypt_key(
+					struct fscrypt_prepared_key *prep_key);
+
+/*
+ * Check whether the crypto transform or blk-crypto key has been allocated in
+ * @prep_key, depending on which encryption implementation the file will use.
+ */
+static inline bool
+fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
+			const struct fscrypt_info *ci)
+{
+	/*
+	 * The READ_ONCE() here pairs with the smp_store_release() in
+	 * fscrypt_prepare_key().  (This only matters for the per-mode keys,
+	 * which are shared by multiple inodes.)
+	 */
+	if (fscrypt_using_inline_encryption(ci))
+		return READ_ONCE(prep_key->blk_key) != NULL;
+	return READ_ONCE(prep_key->tfm) != NULL;
+}
+
+#else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
+static inline void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
+{
+}
+
+static inline bool fscrypt_using_inline_encryption(
+					const struct fscrypt_info *ci)
+{
+	return false;
+}
+
+static inline int
+fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
+				 const u8 *raw_key,
+				 const struct fscrypt_info *ci)
+{
+	WARN_ON(1);
+	return -EOPNOTSUPP;
+}
+
+static inline void
+fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key)
+{
+}
+
+static inline bool
+fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
+			const struct fscrypt_info *ci)
+{
+	return READ_ONCE(prep_key->tfm) != NULL;
+}
+#endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
 /* keyring.c */
 
 /*
@@ -369,14 +463,11 @@ struct fscrypt_master_key {
 	struct list_head	mk_decrypted_inodes;
 	spinlock_t		mk_decrypted_inodes_lock;
 
-	/* Crypto API transforms for DIRECT_KEY policies, allocated on-demand */
-	struct crypto_skcipher	*mk_direct_tfms[__FSCRYPT_MODE_MAX + 1];
+	/* Per-mode keys for DIRECT_KEY policies, allocated on-demand */
+	struct fscrypt_prepared_key mk_direct_keys[__FSCRYPT_MODE_MAX + 1];
 
-	/*
-	 * Crypto API transforms for filesystem-layer implementation of
-	 * IV_INO_LBLK_64 policies, allocated on-demand.
-	 */
-	struct crypto_skcipher	*mk_iv_ino_lblk_64_tfms[__FSCRYPT_MODE_MAX + 1];
+	/* Per-mode keys for IV_INO_LBLK_64 policies, allocated on-demand */
+	struct fscrypt_prepared_key mk_iv_ino_lblk_64_keys[__FSCRYPT_MODE_MAX + 1];
 
 } __randomize_layout;
 
@@ -433,13 +524,17 @@ struct fscrypt_mode {
 	int keysize;
 	int ivsize;
 	int logged_impl_name;
+	enum blk_crypto_mode_num blk_crypto_mode;
+	unsigned int blk_crypto_dun_bytes_required;
 };
 
 extern struct fscrypt_mode fscrypt_modes[];
 
-extern struct crypto_skcipher *
-fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
-			  const struct inode *inode);
+extern int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
+			       const u8 *raw_key,
+			       const struct fscrypt_info *ci);
+
+extern void fscrypt_destroy_prepared_key(struct fscrypt_prepared_key *prep_key);
 
 extern int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci,
 					const u8 *raw_key);
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
new file mode 100644
index 000000000000..72692366795a
--- /dev/null
+++ b/fs/crypto/inline_crypt.c
@@ -0,0 +1,324 @@
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
+#include <linux/sched/mm.h>
+
+#include "fscrypt_private.h"
+
+struct fscrypt_blk_crypto_key {
+	struct blk_crypto_key base;
+	int num_devs;
+	struct request_queue *devs[];
+};
+
+/* Enable inline encryption for this file if supported. */
+void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
+{
+	const struct inode *inode = ci->ci_inode;
+	struct super_block *sb = inode->i_sb;
+
+	/* The file must need contents encryption, not filenames encryption */
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	/* blk-crypto must implement the needed encryption algorithm */
+	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
+		return;
+
+	/* The filesystem must be mounted with -o inlinecrypt */
+	if (!(sb->s_flags & SB_INLINE_CRYPT))
+		return;
+
+	ci->ci_inlinecrypt = true;
+}
+
+int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
+				     const u8 *raw_key,
+				     const struct fscrypt_info *ci)
+{
+	const struct inode *inode = ci->ci_inode;
+	struct super_block *sb = inode->i_sb;
+	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
+	unsigned int blk_crypto_dun_bytes =
+				ci->ci_mode->blk_crypto_dun_bytes_required;
+	int num_devs = 1;
+	int queue_refs = 0;
+	struct fscrypt_blk_crypto_key *blk_key;
+	int err;
+	int i;
+	unsigned int flags;
+
+	if (sb->s_cop->get_num_devices)
+		num_devs = sb->s_cop->get_num_devices(sb);
+	if (WARN_ON(num_devs < 1))
+		return -EINVAL;
+
+	blk_key = kzalloc(struct_size(blk_key, devs, num_devs), GFP_NOFS);
+	if (!blk_key)
+		return -ENOMEM;
+
+	blk_key->num_devs = num_devs;
+	if (num_devs == 1)
+		blk_key->devs[0] = bdev_get_queue(sb->s_bdev);
+	else
+		sb->s_cop->get_devices(sb, blk_key->devs);
+
+	err = blk_crypto_init_key(&blk_key->base, raw_key, crypto_mode,
+				  blk_crypto_dun_bytes, sb->s_blocksize);
+	if (err) {
+		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
+		goto fail;
+	}
+
+	/*
+	 * We have to start using blk-crypto on all the filesystem's devices.
+	 * We also have to save all the request_queue's for later so that the
+	 * key can be evicted from them.  This is needed because some keys
+	 * aren't destroyed until after the filesystem was already unmounted
+	 * (namely, the per-mode keys in struct fscrypt_master_key).
+	 */
+	for (i = 0; i < num_devs; i++) {
+		if (!blk_get_queue(blk_key->devs[i])) {
+			fscrypt_err(inode, "couldn't get request_queue");
+			err = -EAGAIN;
+			goto fail;
+		}
+		queue_refs++;
+
+		flags = memalloc_nofs_save();
+		err = blk_crypto_start_using_key(&blk_key->base,
+						 blk_key->devs[i]);
+		memalloc_nofs_restore(flags);
+		if (err) {
+			fscrypt_err(inode,
+				    "error %d starting to use blk-crypto", err);
+			goto fail;
+		}
+	}
+	/*
+	 * Pairs with READ_ONCE() in fscrypt_is_key_prepared().  (Only matters
+	 * for the per-mode keys, which are shared by multiple inodes.)
+	 */
+	smp_store_release(&prep_key->blk_key, blk_key);
+	return 0;
+
+fail:
+	for (i = 0; i < queue_refs; i++)
+		blk_put_queue(blk_key->devs[i]);
+	kzfree(blk_key);
+	return err;
+}
+
+void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key)
+{
+	struct fscrypt_blk_crypto_key *blk_key = prep_key->blk_key;
+	int i;
+
+	if (blk_key) {
+		for (i = 0; i < blk_key->num_devs; i++) {
+			blk_crypto_evict_key(blk_key->devs[i], &blk_key->base);
+			blk_put_queue(blk_key->devs[i]);
+		}
+		kzfree(blk_key);
+	}
+}
+
+/**
+ * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline
+ *				      encryption
+ * @inode: an inode
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the block layer via blk-crypto rather
+ *	   than in the filesystem layer.
+ */
+bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+		inode->i_crypt_info->ci_inlinecrypt;
+}
+EXPORT_SYMBOL_GPL(fscrypt_inode_uses_inline_crypto);
+
+/**
+ * fscrypt_inode_uses_fs_layer_crypto - test whether an inode uses fs-layer
+ *					encryption
+ * @inode: an inode
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the filesystem layer rather than in the
+ *	   block layer via blk-crypto.
+ */
+bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+		!inode->i_crypt_info->ci_inlinecrypt;
+}
+EXPORT_SYMBOL_GPL(fscrypt_inode_uses_fs_layer_crypto);
+
+static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
+				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
+{
+	union fscrypt_iv iv;
+	int i;
+
+	fscrypt_generate_iv(&iv, lblk_num, ci);
+
+	BUILD_BUG_ON(FSCRYPT_MAX_IV_SIZE > BLK_CRYPTO_MAX_IV_SIZE);
+	memset(dun, 0, BLK_CRYPTO_MAX_IV_SIZE);
+	for (i = 0; i < ci->ci_mode->ivsize/sizeof(dun[0]); i++)
+		dun[i] = le64_to_cpu(iv.dun[i]);
+}
+
+/**
+ * fscrypt_set_bio_crypt_ctx - prepare a file contents bio for inline encryption
+ * @bio: a bio which will eventually be submitted to the file
+ * @inode: the file's inode
+ * @first_lblk: the first file logical block number in the I/O
+ * @gfp_mask: memory allocation flags - these must be a waiting mask so that
+ *					bio_crypt_set_ctx can't fail.
+ *
+ * If the contents of the file should be encrypted (or decrypted) with inline
+ * encryption, then assign the appropriate encryption context to the bio.
+ *
+ * Normally the bio should be newly allocated (i.e. no pages added yet), as
+ * otherwise fscrypt_mergeable_bio() won't work as intended.
+ *
+ * The encryption context will be freed automatically when the bio is freed.
+ */
+void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
+			       u64 first_lblk, gfp_t gfp_mask)
+{
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return;
+
+	fscrypt_generate_dun(ci, first_lblk, dun);
+	bio_crypt_set_ctx(bio, &ci->ci_key.blk_key->base, dun, gfp_mask);
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
+ * fscrypt_set_bio_crypt_ctx_bh - prepare a file contents bio for inline
+ *				  encryption
+ * @bio: a bio which will eventually be submitted to the file
+ * @first_bh: the first buffer_head for which I/O will be submitted
+ * @gfp_mask: memory allocation flags
+ *
+ * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead
+ * of an inode and block number directly.
+ */
+void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
+				 const struct buffer_head *first_bh,
+				 gfp_t gfp_mask)
+{
+	const struct inode *inode;
+	u64 first_lblk;
+
+	if (bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
+		fscrypt_set_bio_crypt_ctx(bio, inode, first_lblk, gfp_mask);
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
+	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+
+	if (!!bc != fscrypt_inode_uses_inline_crypto(inode))
+		return false;
+	if (!bc)
+		return true;
+
+	/*
+	 * Comparing the key pointers is good enough, as all I/O for each key
+	 * uses the same pointer.  I.e., there's currently no need to support
+	 * merging requests where the keys are the same but the pointers differ.
+	 */
+	if (bc->bc_key != &inode->i_crypt_info->ci_key.blk_key->base)
+		return false;
+
+	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
+	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
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
+		return !bio->bi_crypt_context;
+
+	return fscrypt_mergeable_bio(bio, inode, next_lblk);
+}
+EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index ab41b25d4fa1..d8ab33f631ba 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -44,8 +44,8 @@ static void free_master_key(struct fscrypt_master_key *mk)
 	wipe_master_key_secret(&mk->mk_secret);
 
 	for (i = 0; i <= __FSCRYPT_MODE_MAX; i++) {
-		crypto_free_skcipher(mk->mk_direct_tfms[i]);
-		crypto_free_skcipher(mk->mk_iv_ino_lblk_64_tfms[i]);
+		fscrypt_destroy_prepared_key(&mk->mk_direct_keys[i]);
+		fscrypt_destroy_prepared_key(&mk->mk_iv_ino_lblk_64_keys[i]);
 	}
 
 	key_put(mk->mk_users);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 65cb09fa6ead..7c157130c16a 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -19,6 +19,8 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
 		.ivsize = 16,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_256_XTS,
+		.blk_crypto_dun_bytes_required = 8,
 	},
 	[FSCRYPT_MODE_AES_256_CTS] = {
 		.friendly_name = "AES-256-CTS-CBC",
@@ -31,6 +33,8 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.cipher_str = "essiv(cbc(aes),sha256)",
 		.keysize = 16,
 		.ivsize = 16,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
+		.blk_crypto_dun_bytes_required = 8,
 	},
 	[FSCRYPT_MODE_AES_128_CTS] = {
 		.friendly_name = "AES-128-CTS-CBC",
@@ -43,6 +47,8 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.cipher_str = "adiantum(xchacha12,aes)",
 		.keysize = 32,
 		.ivsize = 32,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_ADIANTUM,
+		.blk_crypto_dun_bytes_required = 24,
 	},
 };
 
@@ -62,9 +68,9 @@ select_encryption_mode(const union fscrypt_policy *policy,
 }
 
 /* Create a symmetric cipher object for the given encryption mode and key */
-struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
-						  const u8 *raw_key,
-						  const struct inode *inode)
+static struct crypto_skcipher *
+fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
+			  const struct inode *inode)
 {
 	struct crypto_skcipher *tfm;
 	int err;
@@ -107,30 +113,55 @@ struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
 	return ERR_PTR(err);
 }
 
-/* Given a per-file encryption key, set up the file's crypto transform object */
-int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key)
+/*
+ * Prepare the crypto transform object or blk-crypto key in @prep_key, given the
+ * raw key, encryption mode, and flag indicating which encryption implementation
+ * (fs-layer or blk-crypto) will be used.
+ */
+int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
+			const u8 *raw_key, const struct fscrypt_info *ci)
 {
 	struct crypto_skcipher *tfm;
 
+	if (fscrypt_using_inline_encryption(ci))
+		return fscrypt_prepare_inline_crypt_key(prep_key, raw_key, ci);
+
 	tfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key, ci->ci_inode);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
+	/*
+	 * Pairs with READ_ONCE() in fscrypt_is_key_prepared().  (Only matters
+	 * for the per-mode keys, which are shared by multiple inodes.)
+	 */
+	smp_store_release(&prep_key->tfm, tfm);
+	return 0;
+}
+
+/* Destroy a crypto transform object and/or blk-crypto key. */
+void fscrypt_destroy_prepared_key(struct fscrypt_prepared_key *prep_key)
+{
+	crypto_free_skcipher(prep_key->tfm);
+	fscrypt_destroy_inline_crypt_key(prep_key);
+}
 
-	ci->ci_ctfm = tfm;
+/* Given a per-file encryption key, set up the file's crypto transform object */
+int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key)
+{
 	ci->ci_owns_key = true;
-	return 0;
+	return fscrypt_prepare_key(&ci->ci_key, raw_key, ci);
 }
 
 static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 				  struct fscrypt_master_key *mk,
-				  struct crypto_skcipher **tfms,
+				  struct fscrypt_prepared_key *keys,
 				  u8 hkdf_context, bool include_fs_uuid)
 {
+	static DEFINE_MUTEX(mode_key_setup_mutex);
 	const struct inode *inode = ci->ci_inode;
 	const struct super_block *sb = inode->i_sb;
 	struct fscrypt_mode *mode = ci->ci_mode;
 	const u8 mode_num = mode - fscrypt_modes;
-	struct crypto_skcipher *tfm, *prev_tfm;
+	struct fscrypt_prepared_key *prep_key;
 	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
 	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
 	unsigned int hkdf_infolen = 0;
@@ -139,10 +170,16 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 	if (WARN_ON(mode_num > __FSCRYPT_MODE_MAX))
 		return -EINVAL;
 
-	/* pairs with cmpxchg() below */
-	tfm = READ_ONCE(tfms[mode_num]);
-	if (likely(tfm != NULL))
-		goto done;
+	prep_key = &keys[mode_num];
+	if (fscrypt_is_key_prepared(prep_key, ci)) {
+		ci->ci_key = *prep_key;
+		return 0;
+	}
+
+	mutex_lock(&mode_key_setup_mutex);
+
+	if (fscrypt_is_key_prepared(prep_key, ci))
+		goto done_unlock;
 
 	BUILD_BUG_ON(sizeof(mode_num) != 1);
 	BUILD_BUG_ON(sizeof(sb->s_uuid) != 16);
@@ -157,21 +194,17 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 				  hkdf_context, hkdf_info, hkdf_infolen,
 				  mode_key, mode->keysize);
 	if (err)
-		return err;
-	tfm = fscrypt_allocate_skcipher(mode, mode_key, inode);
+		goto out_unlock;
+	err = fscrypt_prepare_key(prep_key, mode_key, ci);
 	memzero_explicit(mode_key, mode->keysize);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	/* pairs with READ_ONCE() above */
-	prev_tfm = cmpxchg(&tfms[mode_num], NULL, tfm);
-	if (prev_tfm != NULL) {
-		crypto_free_skcipher(tfm);
-		tfm = prev_tfm;
-	}
-done:
-	ci->ci_ctfm = tfm;
-	return 0;
+	if (err)
+		goto out_unlock;
+done_unlock:
+	ci->ci_key = *prep_key;
+	err = 0;
+out_unlock:
+	mutex_unlock(&mode_key_setup_mutex);
+	return err;
 }
 
 int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
@@ -203,7 +236,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * encryption key.  This ensures that the master key is
 		 * consistently used only for HKDF, avoiding key reuse issues.
 		 */
-		err = setup_per_mode_enc_key(ci, mk, mk->mk_direct_tfms,
+		err = setup_per_mode_enc_key(ci, mk, mk->mk_direct_keys,
 					     HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
@@ -213,7 +246,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
-		err = setup_per_mode_enc_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+		err = setup_per_mode_enc_key(ci, mk, mk->mk_iv_ino_lblk_64_keys,
 					     HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					     true);
 	} else {
@@ -261,6 +294,8 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 	struct fscrypt_key_specifier mk_spec;
 	int err;
 
+	fscrypt_select_encryption_impl(ci);
+
 	switch (ci->ci_policy.version) {
 	case FSCRYPT_POLICY_V1:
 		mk_spec.type = FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR;
@@ -353,7 +388,7 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
 	else if (ci->ci_owns_key)
-		crypto_free_skcipher(ci->ci_ctfm);
+		fscrypt_destroy_prepared_key(&ci->ci_key);
 
 	key = ci->ci_master_key;
 	if (key) {
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 801b48c0cd7f..59c520b200cb 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -146,7 +146,7 @@ struct fscrypt_direct_key {
 	struct hlist_node		dk_node;
 	refcount_t			dk_refcount;
 	const struct fscrypt_mode	*dk_mode;
-	struct crypto_skcipher		*dk_ctfm;
+	struct fscrypt_prepared_key	dk_key;
 	u8				dk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 	u8				dk_raw[FSCRYPT_MAX_KEY_SIZE];
 };
@@ -154,7 +154,7 @@ struct fscrypt_direct_key {
 static void free_direct_key(struct fscrypt_direct_key *dk)
 {
 	if (dk) {
-		crypto_free_skcipher(dk->dk_ctfm);
+		fscrypt_destroy_prepared_key(&dk->dk_key);
 		kzfree(dk);
 	}
 }
@@ -199,6 +199,8 @@ find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
 			continue;
 		if (ci->ci_mode != dk->dk_mode)
 			continue;
+		if (!fscrypt_is_key_prepared(&dk->dk_key, ci))
+			continue;
 		if (crypto_memneq(raw_key, dk->dk_raw, ci->ci_mode->keysize))
 			continue;
 		/* using existing tfm with same (descriptor, mode, raw_key) */
@@ -231,13 +233,9 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&dk->dk_refcount, 1);
 	dk->dk_mode = ci->ci_mode;
-	dk->dk_ctfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key,
-						ci->ci_inode);
-	if (IS_ERR(dk->dk_ctfm)) {
-		err = PTR_ERR(dk->dk_ctfm);
-		dk->dk_ctfm = NULL;
+	err = fscrypt_prepare_key(&dk->dk_key, raw_key, ci);
+	if (err)
 		goto err_free_dk;
-	}
 	memcpy(dk->dk_descriptor, ci->ci_policy.v1.master_key_descriptor,
 	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	memcpy(dk->dk_raw, raw_key, ci->ci_mode->keysize);
@@ -259,7 +257,7 @@ static int setup_v1_file_key_direct(struct fscrypt_info *ci,
 	if (IS_ERR(dk))
 		return PTR_ERR(dk);
 	ci->ci_direct_key = dk;
-	ci->ci_ctfm = dk->dk_ctfm;
+	ci->ci_key = dk->dk_key;
 	return 0;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..2331ff0464b2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1370,6 +1370,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINE_CRYPT	(1<<17)	/* inodes in SB use blk-crypto */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 556f4adf5dc5..2a84131ab270 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -64,6 +64,9 @@ struct fscrypt_operations {
 	bool (*has_stable_inodes)(struct super_block *sb);
 	void (*get_ino_and_lblk_bits)(struct super_block *sb,
 				      int *ino_bits_ret, int *lblk_bits_ret);
+	int (*get_num_devices)(struct super_block *sb);
+	void (*get_devices)(struct super_block *sb,
+			    struct request_queue **devs);
 };
 
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
@@ -497,6 +500,60 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 
 #endif	/* !CONFIG_FS_ENCRYPTION */
 
+/* inline_crypt.c */
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+extern bool fscrypt_inode_uses_inline_crypto(const struct inode *inode);
+
+extern bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode);
+
+extern void fscrypt_set_bio_crypt_ctx(struct bio *bio,
+				      const struct inode *inode,
+				      u64 first_lblk, gfp_t gfp_mask);
+
+extern void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
+					 const struct buffer_head *first_bh,
+					 gfp_t gfp_mask);
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
+static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
+					     const struct inode *inode,
+					     u64 first_lblk, gfp_t gfp_mask) { }
+
+static inline void fscrypt_set_bio_crypt_ctx_bh(
+					 struct bio *bio,
+					 const struct buffer_head *first_bh,
+					 gfp_t gfp_mask) { }
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
2.25.0.265.gbab2e86ba0-goog

