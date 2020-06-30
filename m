Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE02420F44C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgF3MO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387550AbgF3MOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:14:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05449C03E979
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 05:14:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j18so13812123qvk.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=13Nxjjt7gA88fD/64KqpQ6UbZj/5+knzcwDIg15dRzg=;
        b=WI7GLlU7y3c/OMamW7qoYsw+wvescbXfP4t3lkkLWxrqFCKcZwfFeWfOyLSllRaRFV
         adChWUa6Z+fMBoHhSElG/vNUsoUeqlobS1egLz4WrXAuy5J9OVaddHNRsU8yzYwnIvkZ
         0hOvgR7GOGFuSwzAKfiimU+e2+qNTsSBpwD3YE1JFtDVrd/TkEh38OfRHonDzhIshoxp
         TRbrvxXgTfIBi79DfvEDXnXwiPDhxnANLWotxCq616oKdmLtSW4enu0NejdQqWkhWvjt
         fT5XE72nT5TX1nzyfyucpTM59FbUa7X6a2XS/Y+2o2LLkpCex84Xx69mnGB8Wwf+UPgi
         opOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=13Nxjjt7gA88fD/64KqpQ6UbZj/5+knzcwDIg15dRzg=;
        b=hs57cNXiGGDT4QHojXVyKkYIoOmvK4HPai7J/EudbxLnV/goetHW4FcYG1P1tAAYC6
         oAIsntVoskKPREW8ptYjNiLM9V67U98or2QHXmktVvZzNISueyuseZItFYsZuneFUtGP
         LHfp3YtnMBRRbfVXFnlIAdHT3fv7HGV1LSTo5pmAV0vq80u8ci0+KA7G1K4+EnR1gan3
         /SyKp0huHTPxwLroWTQh7nW2Zebd1OTB7TEao9E7niZD8VDdEfBiERPLIOrFXZJNCRmO
         vT54gFwElAyimDduKb+gYrnohjRXpghRH8LDS1Mwnc3KTeG37gBIdm+4MRsxCBSyVFvg
         3o/w==
X-Gm-Message-State: AOAM5313LUItYvhlLMXghOREmFZCIQz+alH5AWdZs3AEmsVjrAlp66dn
        q1uc3WURYGBhtCtxBlU3vJPHoyCTeCU=
X-Google-Smtp-Source: ABdhPJzAbMJad80cLWpnQnwbaTq4rlqf+wmp0nGuqAuL9lj7qse7SpjJK9JPA2Bv2Y2Ki+Ig65RKJ9kUXVM=
X-Received: by 2002:a0c:fdc5:: with SMTP id g5mr19923178qvs.125.1593519287022;
 Tue, 30 Jun 2020 05:14:47 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:14:36 +0000
In-Reply-To: <20200630121438.891320-1-satyat@google.com>
Message-Id: <20200630121438.891320-3-satyat@google.com>
Mime-Version: 1.0
References: <20200630121438.891320-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 2/4] fscrypt: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for inline encryption to fs/crypto/.  With "inline
encryption", the block layer handles the decryption/encryption as part
of the bio, instead of the filesystem doing the crypto itself via
Linux's crypto API. This model is needed in order to take advantage of
the inline encryption hardware present on most modern mobile SoCs.

To use inline encryption, the filesystem needs to be mounted with
'-o inlinecrypt'. Blk-crypto will then be used instead of the traditional
filesystem-layer crypto whenever possible to encrypt the contents
of any encrypted files in that filesystem. Fscrypt still provides the key
and IV to use, and the actual ciphertext on-disk is still the same;
therefore it's testable using the existing fscrypt ciphertext verification
tests.

Note that since blk-crypto has a fallback to Linux's crypto API, and
also supports all the encryption modes currently supported by fscrypt,
this feature is usable and testable even without actual inline
encryption hardware.

Per-filesystem changes will be needed to set encryption contexts when
submitting bios and to implement the 'inlinecrypt' mount option.  This
patch just adds the common code.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst |   3 +
 fs/crypto/Kconfig                     |   6 +
 fs/crypto/Makefile                    |   1 +
 fs/crypto/bio.c                       |  51 ++++
 fs/crypto/crypto.c                    |   2 +-
 fs/crypto/fname.c                     |   4 +-
 fs/crypto/fscrypt_private.h           | 115 +++++++-
 fs/crypto/inline_crypt.c              | 364 ++++++++++++++++++++++++++
 fs/crypto/keyring.c                   |   6 +-
 fs/crypto/keysetup.c                  |  70 +++--
 fs/crypto/keysetup_v1.c               |  16 +-
 include/linux/fscrypt.h               |  82 ++++++
 12 files changed, 673 insertions(+), 47 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f517af8ec11c..f5d8b0303ddf 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1255,6 +1255,7 @@ f2fs encryption using `kvm-xfstests
 <https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md>`_::
 
     kvm-xfstests -c ext4,f2fs -g encrypt
+    kvm-xfstests -c ext4,f2fs -g encrypt -m inlinecrypt
 
 UBIFS encryption can also be tested this way, but it should be done in
 a separate command, and it takes some time for kvm-xfstests to set up
@@ -1276,6 +1277,7 @@ This tests the encrypted I/O paths more thoroughly.  To do this with
 kvm-xfstests, use the "encrypt" filesystem configuration::
 
     kvm-xfstests -c ext4/encrypt,f2fs/encrypt -g auto
+    kvm-xfstests -c ext4/encrypt,f2fs/encrypt -g auto -m inlinecrypt
 
 Because this runs many more tests than "-g encrypt" does, it takes
 much longer to run; so also consider using `gce-xfstests
@@ -1283,3 +1285,4 @@ much longer to run; so also consider using `gce-xfstests
 instead of kvm-xfstests::
 
     gce-xfstests -c ext4/encrypt,f2fs/encrypt -g auto
+    gce-xfstests -c ext4/encrypt,f2fs/encrypt -g auto -m inlinecrypt
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
index 4fa18fff9c4e..b048a0e38516 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -41,6 +41,53 @@ void fscrypt_decrypt_bio(struct bio *bio)
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
+			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
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
+		if (num_pages == BIO_MAX_PAGES || !len ||
+		    !fscrypt_mergeable_bio(bio, inode, lblk)) {
+			err = submit_bio_wait(bio);
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
@@ -75,6 +122,10 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	if (len == 0)
 		return 0;
 
+	if (fscrypt_inode_uses_inline_crypto(inode))
+		return fscrypt_zeroout_range_inline_crypt(inode, lblk, pblk,
+							  len);
+
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_PAGES);
 	nr_pages = min_t(unsigned int, ARRAY_SIZE(pages),
 			 (len + blocks_per_page - 1) >> blocks_per_page_bits);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index ed015cb66c7c..a52cf32733ab 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -100,7 +100,7 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
 	struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_ctfm;
+	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	int res = 0;
 
 	if (WARN_ON_ONCE(len <= 0))
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 83ca5f1e7934..d828e3df898b 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -115,7 +115,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	const struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_ctfm;
+	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
 	int res;
@@ -171,7 +171,7 @@ static int fname_decrypt(const struct inode *inode,
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
 	const struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_ctfm;
+	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	int res;
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index eb7fcd2b7fb8..5bb40d0109c8 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -14,6 +14,7 @@
 #include <linux/fscrypt.h>
 #include <linux/siphash.h>
 #include <crypto/hash.h>
+#include <linux/blk-crypto.h>
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
 
@@ -166,6 +167,20 @@ struct fscrypt_symlink_data {
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
@@ -175,12 +190,20 @@ struct fscrypt_symlink_data {
  */
 struct fscrypt_info {
 
-	/* The actual crypto transform used for encryption and decryption */
-	struct crypto_skcipher *ci_ctfm;
+	/* The key in a form prepared for actual encryption/decryption */
+	struct fscrypt_prepared_key ci_enc_key;
 
-	/* True if the key should be freed when this fscrypt_info is freed */
+	/* True if ci_enc_key should be freed when this fscrypt_info is freed */
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
@@ -205,7 +228,7 @@ struct fscrypt_info {
 
 	/*
 	 * If non-NULL, then encryption is done using the master key directly
-	 * and ci_ctfm will equal ci_direct_key->dk_ctfm.
+	 * and ci_enc_key will equal ci_direct_key->dk_key.
 	 */
 	struct fscrypt_direct_key *ci_direct_key;
 
@@ -260,6 +283,7 @@ union fscrypt_iv {
 		u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
 	};
 	u8 raw[FSCRYPT_MAX_IV_SIZE];
+	__le64 dun[FSCRYPT_MAX_IV_SIZE / sizeof(__le64)];
 };
 
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
@@ -302,6 +326,75 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 
 void fscrypt_destroy_hkdf(struct fscrypt_hkdf *hkdf);
 
+/* inline_crypt.c */
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+int fscrypt_select_encryption_impl(struct fscrypt_info *ci);
+
+static inline bool
+fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
+{
+	return ci->ci_inlinecrypt;
+}
+
+int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
+				     const u8 *raw_key,
+				     const struct fscrypt_info *ci);
+
+void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key);
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
+static inline int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
+{
+	return 0;
+}
+
+static inline bool
+fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
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
@@ -395,9 +488,9 @@ struct fscrypt_master_key {
 	 * Per-mode encryption keys for the various types of encryption policies
 	 * that use them.  Allocated and derived on-demand.
 	 */
-	struct crypto_skcipher *mk_direct_keys[__FSCRYPT_MODE_MAX + 1];
-	struct crypto_skcipher *mk_iv_ino_lblk_64_keys[__FSCRYPT_MODE_MAX + 1];
-	struct crypto_skcipher *mk_iv_ino_lblk_32_keys[__FSCRYPT_MODE_MAX + 1];
+	struct fscrypt_prepared_key mk_direct_keys[__FSCRYPT_MODE_MAX + 1];
+	struct fscrypt_prepared_key mk_iv_ino_lblk_64_keys[__FSCRYPT_MODE_MAX + 1];
+	struct fscrypt_prepared_key mk_iv_ino_lblk_32_keys[__FSCRYPT_MODE_MAX + 1];
 
 	/* Hash key for inode numbers.  Initialized only when needed. */
 	siphash_key_t		mk_ino_hash_key;
@@ -461,13 +554,15 @@ struct fscrypt_mode {
 	int keysize;
 	int ivsize;
 	int logged_impl_name;
+	enum blk_crypto_mode_num blk_crypto_mode;
 };
 
 extern struct fscrypt_mode fscrypt_modes[];
 
-struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
-						  const u8 *raw_key,
-						  const struct inode *inode);
+int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
+			const u8 *raw_key, const struct fscrypt_info *ci);
+
+void fscrypt_destroy_prepared_key(struct fscrypt_prepared_key *prep_key);
 
 int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key);
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
new file mode 100644
index 000000000000..d7aecadf33c1
--- /dev/null
+++ b/fs/crypto/inline_crypt.c
@@ -0,0 +1,364 @@
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
+static int fscrypt_get_num_devices(struct super_block *sb)
+{
+	if (sb->s_cop->get_num_devices)
+		return sb->s_cop->get_num_devices(sb);
+	return 1;
+}
+
+static void fscrypt_get_devices(struct super_block *sb, int num_devs,
+				struct request_queue **devs)
+{
+	if (num_devs == 1)
+		devs[0] = bdev_get_queue(sb->s_bdev);
+	else
+		sb->s_cop->get_devices(sb, devs);
+}
+
+static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
+{
+	struct super_block *sb = ci->ci_inode->i_sb;
+	unsigned int flags = fscrypt_policy_flags(&ci->ci_policy);
+	int ino_bits = 64, lblk_bits = 64;
+
+	if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
+		return offsetofend(union fscrypt_iv, nonce);
+
+	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64)
+		return sizeof(__le64);
+
+	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)
+		return sizeof(__le32);
+
+	/* Default case: IVs are just the file logical block number */
+	if (sb->s_cop->get_ino_and_lblk_bits)
+		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
+	return DIV_ROUND_UP(lblk_bits, 8);
+}
+
+/* Enable inline encryption for this file if supported. */
+int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
+{
+	const struct inode *inode = ci->ci_inode;
+	struct super_block *sb = inode->i_sb;
+	struct blk_crypto_config crypto_cfg;
+	int num_devs;
+	struct request_queue **devs;
+	int i;
+
+	/* The file must need contents encryption, not filenames encryption */
+	if (!fscrypt_needs_contents_encryption(inode))
+		return 0;
+
+	/* The crypto mode must have a blk-crypto counterpart */
+	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
+		return 0;
+
+	/* The filesystem must be mounted with -o inlinecrypt */
+	if (!(sb->s_flags & SB_INLINECRYPT))
+		return 0;
+
+	/*
+	 * When a page contains multiple logically contiguous filesystem blocks,
+	 * some filesystem code only calls fscrypt_mergeable_bio() for the first
+	 * block in the page. This is fine for most of fscrypt's IV generation
+	 * strategies, where contiguous blocks imply contiguous IVs. But it
+	 * doesn't work with IV_INO_LBLK_32. For now, simply exclude
+	 * IV_INO_LBLK_32 with blocksize != PAGE_SIZE from inline encryption.
+	 */
+	if ((fscrypt_policy_flags(&ci->ci_policy) &
+	     FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
+	    sb->s_blocksize != PAGE_SIZE)
+		return 0;
+
+	/*
+	 * On all the filesystem's devices, blk-crypto must support the crypto
+	 * configuration that the file would use.
+	 */
+	crypto_cfg.crypto_mode = ci->ci_mode->blk_crypto_mode;
+	crypto_cfg.data_unit_size = sb->s_blocksize;
+	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
+	num_devs = fscrypt_get_num_devices(sb);
+	devs = kmalloc_array(num_devs, sizeof(*devs), GFP_NOFS);
+	if (!devs)
+		return -ENOMEM;
+	fscrypt_get_devices(sb, num_devs, devs);
+
+	for (i = 0; i < num_devs; i++) {
+		if (!blk_crypto_config_supported(devs[i], &crypto_cfg))
+			goto out_free_devs;
+	}
+
+	ci->ci_inlinecrypt = true;
+out_free_devs:
+	kfree(devs);
+
+	return 0;
+}
+
+int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
+				     const u8 *raw_key,
+				     const struct fscrypt_info *ci)
+{
+	const struct inode *inode = ci->ci_inode;
+	struct super_block *sb = inode->i_sb;
+	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
+	int num_devs = fscrypt_get_num_devices(sb);
+	int queue_refs = 0;
+	struct fscrypt_blk_crypto_key *blk_key;
+	int err;
+	int i;
+	unsigned int flags;
+
+	blk_key = kzalloc(struct_size(blk_key, devs, num_devs), GFP_NOFS);
+	if (!blk_key)
+		return -ENOMEM;
+
+	blk_key->num_devs = num_devs;
+	fscrypt_get_devices(sb, num_devs, blk_key->devs);
+
+	err = blk_crypto_init_key(&blk_key->base, raw_key, crypto_mode,
+				  fscrypt_get_dun_bytes(ci), sb->s_blocksize);
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
+bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return inode->i_crypt_info->ci_inlinecrypt;
+}
+EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
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
+ * fscrypt_set_bio_crypt_ctx() - prepare a file contents bio for inline crypto
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
+	bio_crypt_set_ctx(bio, &ci->ci_enc_key.blk_key->base, dun, gfp_mask);
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
+ * fscrypt_set_bio_crypt_ctx_bh() - prepare a file contents bio for inline
+ *				    crypto
+ * @bio: a bio which will eventually be submitted to the file
+ * @first_bh: the first buffer_head for which I/O will be submitted
+ * @gfp_mask: memory allocation flags
+ *
+ * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead
+ * of an inode and block number directly.
+ */
+void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
+				  const struct buffer_head *first_bh,
+				  gfp_t gfp_mask)
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
+ * fscrypt_mergeable_bio() - test whether data can be added to a bio
+ * @bio: the bio being built up
+ * @inode: the inode for the next part of the I/O
+ * @next_lblk: the next file logical block number in the I/O
+ *
+ * When building a bio which may contain data which should undergo inline
+ * encryption (or decryption) via fscrypt, filesystems should call this function
+ * to ensure that the resulting bio contains only contiguous data unit numbers.
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
+	if (bc->bc_key != &inode->i_crypt_info->ci_enc_key.blk_key->base)
+		return false;
+
+	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
+	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
+}
+EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
+
+/**
+ * fscrypt_mergeable_bio_bh() - test whether data can be added to a bio
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
index e24eb48bfbe1..7f8ac61a20d6 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -45,9 +45,9 @@ static void free_master_key(struct fscrypt_master_key *mk)
 	wipe_master_key_secret(&mk->mk_secret);
 
 	for (i = 0; i <= __FSCRYPT_MODE_MAX; i++) {
-		crypto_free_skcipher(mk->mk_direct_keys[i]);
-		crypto_free_skcipher(mk->mk_iv_ino_lblk_64_keys[i]);
-		crypto_free_skcipher(mk->mk_iv_ino_lblk_32_keys[i]);
+		fscrypt_destroy_prepared_key(&mk->mk_direct_keys[i]);
+		fscrypt_destroy_prepared_key(&mk->mk_iv_ino_lblk_64_keys[i]);
+		fscrypt_destroy_prepared_key(&mk->mk_iv_ino_lblk_32_keys[i]);
 	}
 
 	key_put(mk->mk_users);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 1129adfa097d..99d3e0d07fc6 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -19,6 +19,7 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
 		.ivsize = 16,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_256_XTS,
 	},
 	[FSCRYPT_MODE_AES_256_CTS] = {
 		.friendly_name = "AES-256-CTS-CBC",
@@ -31,6 +32,7 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.cipher_str = "essiv(cbc(aes),sha256)",
 		.keysize = 16,
 		.ivsize = 16,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
 	},
 	[FSCRYPT_MODE_AES_128_CTS] = {
 		.friendly_name = "AES-128-CTS-CBC",
@@ -43,6 +45,7 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.cipher_str = "adiantum(xchacha12,aes)",
 		.keysize = 32,
 		.ivsize = 32,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_ADIANTUM,
 	},
 };
 
@@ -64,9 +67,9 @@ select_encryption_mode(const union fscrypt_policy *policy,
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
@@ -109,30 +112,54 @@ struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
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
+	return fscrypt_prepare_key(&ci->ci_enc_key, raw_key, ci);
 }
 
 static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 				  struct fscrypt_master_key *mk,
-				  struct crypto_skcipher **tfms,
+				  struct fscrypt_prepared_key *keys,
 				  u8 hkdf_context, bool include_fs_uuid)
 {
 	const struct inode *inode = ci->ci_inode;
 	const struct super_block *sb = inode->i_sb;
 	struct fscrypt_mode *mode = ci->ci_mode;
 	const u8 mode_num = mode - fscrypt_modes;
-	struct crypto_skcipher *tfm;
+	struct fscrypt_prepared_key *prep_key;
 	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
 	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
 	unsigned int hkdf_infolen = 0;
@@ -141,16 +168,15 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 	if (WARN_ON(mode_num > __FSCRYPT_MODE_MAX))
 		return -EINVAL;
 
-	/* pairs with smp_store_release() below */
-	tfm = READ_ONCE(tfms[mode_num]);
-	if (likely(tfm != NULL)) {
-		ci->ci_ctfm = tfm;
+	prep_key = &keys[mode_num];
+	if (fscrypt_is_key_prepared(prep_key, ci)) {
+		ci->ci_enc_key = *prep_key;
 		return 0;
 	}
 
 	mutex_lock(&fscrypt_mode_key_setup_mutex);
 
-	if (tfms[mode_num])
+	if (fscrypt_is_key_prepared(prep_key, ci))
 		goto done_unlock;
 
 	BUILD_BUG_ON(sizeof(mode_num) != 1);
@@ -167,16 +193,12 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 				  mode_key, mode->keysize);
 	if (err)
 		goto out_unlock;
-	tfm = fscrypt_allocate_skcipher(mode, mode_key, inode);
+	err = fscrypt_prepare_key(prep_key, mode_key, ci);
 	memzero_explicit(mode_key, mode->keysize);
-	if (IS_ERR(tfm)) {
-		err = PTR_ERR(tfm);
+	if (err)
 		goto out_unlock;
-	}
-	/* pairs with READ_ONCE() above */
-	smp_store_release(&tfms[mode_num], tfm);
 done_unlock:
-	ci->ci_ctfm = tfm;
+	ci->ci_enc_key = *prep_key;
 	err = 0;
 out_unlock:
 	mutex_unlock(&fscrypt_mode_key_setup_mutex);
@@ -310,6 +332,10 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 	struct fscrypt_key_specifier mk_spec;
 	int err;
 
+	err = fscrypt_select_encryption_impl(ci);
+	if (err)
+		return err;
+
 	switch (ci->ci_policy.version) {
 	case FSCRYPT_POLICY_V1:
 		mk_spec.type = FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR;
@@ -402,7 +428,7 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
 	else if (ci->ci_owns_key)
-		crypto_free_skcipher(ci->ci_ctfm);
+		fscrypt_destroy_prepared_key(&ci->ci_enc_key);
 
 	key = ci->ci_master_key;
 	if (key) {
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 801b48c0cd7f..a52686729a67 100644
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
+	ci->ci_enc_key = dk->dk_key;
 	return 0;
 }
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 2862ca5fea33..bb257411365f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -69,6 +69,9 @@ struct fscrypt_operations {
 	bool (*has_stable_inodes)(struct super_block *sb);
 	void (*get_ino_and_lblk_bits)(struct super_block *sb,
 				      int *ino_bits_ret, int *lblk_bits_ret);
+	int (*get_num_devices)(struct super_block *sb);
+	void (*get_devices)(struct super_block *sb,
+			    struct request_queue **devs);
 };
 
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
@@ -537,6 +540,85 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 
 #endif	/* !CONFIG_FS_ENCRYPTION */
 
+/* inline_crypt.c */
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+
+bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode);
+
+void fscrypt_set_bio_crypt_ctx(struct bio *bio,
+			       const struct inode *inode, u64 first_lblk,
+			       gfp_t gfp_mask);
+
+void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
+				  const struct buffer_head *first_bh,
+				  gfp_t gfp_mask);
+
+bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
+			   u64 next_lblk);
+
+bool fscrypt_mergeable_bio_bh(struct bio *bio,
+			      const struct buffer_head *next_bh);
+
+#else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
+
+static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return false;
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
+/**
+ * fscrypt_inode_uses_inline_crypto() - test whether an inode uses inline
+ *					encryption
+ * @inode: an inode. If encrypted, its key must be set up.
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the block layer via blk-crypto rather
+ *	   than in the filesystem layer.
+ */
+static inline bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return fscrypt_needs_contents_encryption(inode) &&
+	       __fscrypt_inode_uses_inline_crypto(inode);
+}
+
+/**
+ * fscrypt_inode_uses_fs_layer_crypto() - test whether an inode uses fs-layer
+ *					  encryption
+ * @inode: an inode. If encrypted, its key must be set up.
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the filesystem layer rather than in the
+ *	   block layer via blk-crypto.
+ */
+static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
+{
+	return fscrypt_needs_contents_encryption(inode) &&
+	       !__fscrypt_inode_uses_inline_crypto(inode);
+}
+
 /**
  * fscrypt_require_key() - require an inode's encryption key
  * @inode: the inode we need the key for
-- 
2.27.0.212.ge8ba1cc988-goog

