Return-Path: <linux-fsdevel+bounces-63849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3508BCFC90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 22:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C57AD4E50B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52522A80D;
	Sat, 11 Oct 2025 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdAQFONs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CD4594A;
	Sat, 11 Oct 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760212946; cv=none; b=rHozWHy4ozKxL3+mz68fTXG0hfRzpUuWyop7XO531hWI52AJysVu8ssdv5Twqryc31TP9LJpHz+RJf1QgDm569ESkY9vSt6mAyDpIQbY3UwdcwDhs56BtV8nEk2KNDhdbSaera6/cy859vN2WZBWDl+WqkI2X+7eGq6+7jgI05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760212946; c=relaxed/simple;
	bh=FJgyJcCrFtfLyut82DOD1FxEo6UczmkBlhsTQvcJtjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+XB/W1NLHlRJFSnXXih1B/h0CdSU4sxZpAhBWxeVpCwS7GTWNnGSqKoG0j4UN9pPdKGvHIspaHkDpcLLwXJEz3fBM+19h6yEc5/hBMkEKWjhkb7tWjylm1hsk5P114mDmKYPNDsKuPX+CbUmJO3pSB9x/Alj9FXmgsH4vCFLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdAQFONs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C03C4CEF4;
	Sat, 11 Oct 2025 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760212945;
	bh=FJgyJcCrFtfLyut82DOD1FxEo6UczmkBlhsTQvcJtjw=;
	h=From:To:Cc:Subject:Date:From;
	b=mdAQFONspnA6dXaGvjaUnd/Kuk+j4PEnbG716ng+af6vyo/3+Y7qjHYzxfDtl/oUH
	 AWVNrjMHNc4SoNWGufpbMLKBTUd0nZ6jphSGAWj2aSE9T41NHYbBJUkKipi3XbqCug
	 BXIQejfGVOygMqjSS6QzdyHiPB8KsVovf4bdNRXb1hi+GJDMHi4Ekfg+ZH9BTjhkRz
	 D2N3bqse0GEZS80aCy+Ktxna7fKG3Yv1GDlxJBix3LI7x51gUxDJfeKjzOUYL4+klv
	 5qw4XmKvdkAXS5BlCSQQRUgX8c5n//qaLMdY9q/aMmR9EAprPa4ap99O6y9OIa2mg/
	 H1D5tfbrQyr2A==
From: Eric Biggers <ebiggers@kernel.org>
To: ecryptfs@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: Tyler Hicks <code@tyhicks.com>,
	linux-fsdevel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] ecryptfs: Use MD5 library instead of crypto_shash
Date: Sat, 11 Oct 2025 13:00:10 -0700
Message-ID: <20251011200010.193140-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eCryptfs uses MD5 for a couple unusual purposes: to "mix" the key into
the IVs for file contents encryption (similar to ESSIV), and to prepend
some key-dependent bytes to the plaintext when encrypting filenames
(which is useless since eCryptfs encrypts the filenames with ECB).

Currently, eCryptfs computes these MD5 hashes using the crypto_shash
API.  Update it to instead use the MD5 library API.  This is simpler and
faster: the library doesn't require memory allocations, can't fail, and
provides direct access to MD5 without overhead such as indirect calls.

To preserve the existing behavior of eCryptfs support being disabled
when the kernel is booted with "fips=1", make ecryptfs_get_tree() check
fips_enabled itself.  Previously it relied on crypto_alloc_shash("md5")
failing.  I don't know for sure that this is actually needed; e.g., it
could be argued that eCryptfs's use of MD5 isn't for a security purpose
as far as FIPS is concerned.  But this preserves the existing behavior.

Tested by verifying that an existing eCryptfs can still be mounted with
a kernel that has this commit, with all the files matching.  Also tested
creating a filesystem with this commit and mounting+reading it without.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

I can take this through the libcrypto tree if no one else volunteers.
(It looks like eCryptfs doesn't have an active git tree anymore.)

 fs/ecryptfs/Kconfig           |  2 +-
 fs/ecryptfs/crypto.c          | 90 ++++-------------------------------
 fs/ecryptfs/ecryptfs_kernel.h | 13 ++---
 fs/ecryptfs/inode.c           |  7 +--
 fs/ecryptfs/keystore.c        | 65 +++++--------------------
 fs/ecryptfs/main.c            |  7 +++
 fs/ecryptfs/super.c           |  5 +-
 7 files changed, 35 insertions(+), 154 deletions(-)

diff --git a/fs/ecryptfs/Kconfig b/fs/ecryptfs/Kconfig
index 1bdeaa6d57900..c2f4fb41b4e6a 100644
--- a/fs/ecryptfs/Kconfig
+++ b/fs/ecryptfs/Kconfig
@@ -2,11 +2,11 @@
 config ECRYPT_FS
 	tristate "eCrypt filesystem layer support"
 	depends on KEYS && CRYPTO && (ENCRYPTED_KEYS || ENCRYPTED_KEYS=n)
 	select CRYPTO_ECB
 	select CRYPTO_CBC
-	select CRYPTO_MD5
+	select CRYPTO_LIB_MD5
 	help
 	  Encrypted filesystem that operates on the VFS layer.  See
 	  <file:Documentation/filesystems/ecryptfs.rst> to learn more about
 	  eCryptfs.  Userspace components are required and can be
 	  obtained from <http://ecryptfs.sf.net>.
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 69536cacdea8d..260f8a4938b01 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -7,11 +7,10 @@
  * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *   		Michael C. Thompson <mcthomps@us.ibm.com>
  */
 
-#include <crypto/hash.h>
 #include <crypto/skcipher.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/random.h>
@@ -46,36 +45,10 @@ void ecryptfs_from_hex(char *dst, char *src, int dst_size)
 		tmp[1] = src[x * 2 + 1];
 		dst[x] = (unsigned char)simple_strtol(tmp, NULL, 16);
 	}
 }
 
-/**
- * ecryptfs_calculate_md5 - calculates the md5 of @src
- * @dst: Pointer to 16 bytes of allocated memory
- * @crypt_stat: Pointer to crypt_stat struct for the current inode
- * @src: Data to be md5'd
- * @len: Length of @src
- *
- * Uses the allocated crypto context that crypt_stat references to
- * generate the MD5 sum of the contents of src.
- */
-static int ecryptfs_calculate_md5(char *dst,
-				  struct ecryptfs_crypt_stat *crypt_stat,
-				  char *src, int len)
-{
-	int rc = crypto_shash_tfm_digest(crypt_stat->hash_tfm, src, len, dst);
-
-	if (rc) {
-		printk(KERN_ERR
-		       "%s: Error computing crypto hash; rc = [%d]\n",
-		       __func__, rc);
-		goto out;
-	}
-out:
-	return rc;
-}
-
 static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
 						  char *cipher_name,
 						  char *chaining_modifier)
 {
 	int cipher_name_len = strlen(cipher_name);
@@ -102,17 +75,14 @@ static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
  * @crypt_stat: Pointer to crypt_stat struct for the current inode
  * @offset: Offset of the extent whose IV we are to derive
  *
  * Generate the initialization vector from the given root IV and page
  * offset.
- *
- * Returns zero on success; non-zero on error.
  */
-int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
-		       loff_t offset)
+void ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
+			loff_t offset)
 {
-	int rc = 0;
 	char dst[MD5_DIGEST_SIZE];
 	char src[ECRYPTFS_MAX_IV_BYTES + 16];
 
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "root iv:\n");
@@ -127,55 +97,32 @@ int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
 	snprintf((src + crypt_stat->iv_bytes), 16, "%lld", offset);
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "source:\n");
 		ecryptfs_dump_hex(src, (crypt_stat->iv_bytes + 16));
 	}
-	rc = ecryptfs_calculate_md5(dst, crypt_stat, src,
-				    (crypt_stat->iv_bytes + 16));
-	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "Error attempting to compute "
-				"MD5 while generating IV for a page\n");
-		goto out;
-	}
+	md5(src, crypt_stat->iv_bytes + 16, dst);
 	memcpy(iv, dst, crypt_stat->iv_bytes);
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "derived iv:\n");
 		ecryptfs_dump_hex(iv, crypt_stat->iv_bytes);
 	}
-out:
-	return rc;
 }
 
 /**
  * ecryptfs_init_crypt_stat
  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
  *
  * Initialize the crypt_stat structure.
  */
-int ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
+void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 {
-	struct crypto_shash *tfm;
-	int rc;
-
-	tfm = crypto_alloc_shash(ECRYPTFS_DEFAULT_HASH, 0, 0);
-	if (IS_ERR(tfm)) {
-		rc = PTR_ERR(tfm);
-		ecryptfs_printk(KERN_ERR, "Error attempting to "
-				"allocate crypto context; rc = [%d]\n",
-				rc);
-		return rc;
-	}
-
 	memset((void *)crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 	INIT_LIST_HEAD(&crypt_stat->keysig_list);
 	mutex_init(&crypt_stat->keysig_list_mutex);
 	mutex_init(&crypt_stat->cs_mutex);
 	mutex_init(&crypt_stat->cs_tfm_mutex);
-	crypt_stat->hash_tfm = tfm;
 	crypt_stat->flags |= ECRYPTFS_STRUCT_INITIALIZED;
-
-	return 0;
 }
 
 /**
  * ecryptfs_destroy_crypt_stat
  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
@@ -185,11 +132,10 @@ int ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 void ecryptfs_destroy_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
 
 	crypto_free_skcipher(crypt_stat->tfm);
-	crypto_free_shash(crypt_stat->hash_tfm);
 	list_for_each_entry_safe(key_sig, key_sig_tmp,
 				 &crypt_stat->keysig_list, crypt_stat_list) {
 		list_del(&key_sig->crypt_stat_list);
 		kmem_cache_free(ecryptfs_key_sig_cache, key_sig);
 	}
@@ -359,18 +305,11 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 	struct scatterlist src_sg, dst_sg;
 	size_t extent_size = crypt_stat->extent_size;
 	int rc;
 
 	extent_base = (((loff_t)page_index) * (PAGE_SIZE / extent_size));
-	rc = ecryptfs_derive_iv(extent_iv, crypt_stat,
-				(extent_base + extent_offset));
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error attempting to derive IV for "
-			"extent [0x%.16llx]; rc = [%d]\n",
-			(unsigned long long)(extent_base + extent_offset), rc);
-		goto out;
-	}
+	ecryptfs_derive_iv(extent_iv, crypt_stat, extent_base + extent_offset);
 
 	sg_init_table(&src_sg, 1);
 	sg_init_table(&dst_sg, 1);
 
 	sg_set_page(&src_sg, src_page, extent_size,
@@ -607,35 +546,24 @@ void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat)
  *
  * On error, sets the root IV to all 0's.
  */
 int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat *crypt_stat)
 {
-	int rc = 0;
 	char dst[MD5_DIGEST_SIZE];
 
 	BUG_ON(crypt_stat->iv_bytes > MD5_DIGEST_SIZE);
 	BUG_ON(crypt_stat->iv_bytes <= 0);
 	if (!(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
-		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING, "Session key not valid; "
 				"cannot generate root IV\n");
-		goto out;
-	}
-	rc = ecryptfs_calculate_md5(dst, crypt_stat, crypt_stat->key,
-				    crypt_stat->key_size);
-	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "Error attempting to compute "
-				"MD5 while generating root IV\n");
-		goto out;
-	}
-	memcpy(crypt_stat->root_iv, dst, crypt_stat->iv_bytes);
-out:
-	if (rc) {
 		memset(crypt_stat->root_iv, 0, crypt_stat->iv_bytes);
 		crypt_stat->flags |= ECRYPTFS_SECURITY_WARNING;
+		return -EINVAL;
 	}
-	return rc;
+	md5(crypt_stat->key, crypt_stat->key_size, dst);
+	memcpy(crypt_stat->root_iv, dst, crypt_stat->iv_bytes);
+	return 0;
 }
 
 static void ecryptfs_generate_new_key(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	get_random_bytes(crypt_stat->key, crypt_stat->key_size);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 9e6ab0b413376..62a2ea7f59eda 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -12,10 +12,11 @@
  */
 
 #ifndef ECRYPTFS_KERNEL_H
 #define ECRYPTFS_KERNEL_H
 
+#include <crypto/md5.h>
 #include <crypto/skcipher.h>
 #include <keys/user-type.h>
 #include <keys/encrypted-type.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -135,12 +136,10 @@ ecryptfs_get_key_payload_data(struct key *key)
 #define ECRYPTFS_FILE_SIZE_BYTES (sizeof(u64))
 #define ECRYPTFS_SIZE_AND_MARKER_BYTES (ECRYPTFS_FILE_SIZE_BYTES \
 					+ MAGIC_ECRYPTFS_MARKER_SIZE_BYTES)
 #define ECRYPTFS_DEFAULT_CIPHER "aes"
 #define ECRYPTFS_DEFAULT_KEY_BYTES 16
-#define ECRYPTFS_DEFAULT_HASH "md5"
-#define ECRYPTFS_TAG_70_DIGEST ECRYPTFS_DEFAULT_HASH
 #define ECRYPTFS_TAG_1_PACKET_TYPE 0x01
 #define ECRYPTFS_TAG_3_PACKET_TYPE 0x8C
 #define ECRYPTFS_TAG_11_PACKET_TYPE 0xED
 #define ECRYPTFS_TAG_64_PACKET_TYPE 0x40
 #define ECRYPTFS_TAG_65_PACKET_TYPE 0x41
@@ -161,12 +160,10 @@ ecryptfs_get_key_payload_data(struct key *key)
 				     */
 /* Constraint: ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTES >=
  * ECRYPTFS_MAX_IV_BYTES */
 #define ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTES 16
 #define ECRYPTFS_NON_NULL 0x42 /* A reasonable substitute for NULL */
-#define MD5_DIGEST_SIZE 16
-#define ECRYPTFS_TAG_70_DIGEST_SIZE MD5_DIGEST_SIZE
 #define ECRYPTFS_TAG_70_MIN_METADATA_SIZE (1 + ECRYPTFS_MIN_PKT_LEN_SIZE \
 					   + ECRYPTFS_SIG_SIZE + 1 + 1)
 #define ECRYPTFS_TAG_70_MAX_METADATA_SIZE (1 + ECRYPTFS_MAX_PKT_LEN_SIZE \
 					   + ECRYPTFS_SIG_SIZE + 1 + 1)
 #define ECRYPTFS_FEK_ENCRYPTED_FILENAME_PREFIX "ECRYPTFS_FEK_ENCRYPTED."
@@ -235,12 +232,10 @@ struct ecryptfs_crypt_stat {
 	size_t key_size;
 	size_t extent_shift;
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
 	struct crypto_skcipher *tfm;
-	struct crypto_shash *hash_tfm; /* Crypto context for generating
-					* the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
 	struct list_head keysig_list;
 	struct mutex keysig_list_mutex;
@@ -556,11 +551,11 @@ int ecryptfs_encrypt_and_encode_filename(
 void ecryptfs_dump_hex(char *data, int bytes);
 int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
 			int sg_size);
 int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_rotate_iv(unsigned char *iv);
-int ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
+void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_destroy_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_destroy_mount_crypt_stat(
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptfs_inode);
@@ -691,11 +686,11 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 			     size_t *packet_size,
 			     struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 			     char *data, size_t max_packet_size);
 int ecryptfs_set_f_namelen(long *namelen, long lower_namelen,
 			   struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
-int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
-		       loff_t offset);
+void ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
+			loff_t offset);
 
 extern const struct xattr_handler * const ecryptfs_xattr_handlers[];
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index ed1394da8d6bd..bae9011fa62ff 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -901,15 +901,12 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	struct inode *inode;
 	struct inode *lower_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
 
 	crypt_stat = &ecryptfs_inode_to_private(d_inode(dentry))->crypt_stat;
-	if (!(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED)) {
-		rc = ecryptfs_init_crypt_stat(crypt_stat);
-		if (rc)
-			return rc;
-	}
+	if (!(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
+		ecryptfs_init_crypt_stat(crypt_stat);
 	inode = d_inode(dentry);
 	lower_inode = ecryptfs_inode_to_lower(inode);
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	mutex_lock(&crypt_stat->cs_mutex);
 	if (d_is_dir(dentry))
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 7f9f68c00ef63..bbf8603242fa0 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -9,11 +9,10 @@
  *   Author(s): Michael A. Halcrow <mhalcrow@us.ibm.com>
  *              Michael C. Thompson <mcthomps@us.ibm.com>
  *              Trevor S. Highland <trevor.highland@gmail.com>
  */
 
-#include <crypto/hash.h>
 #include <crypto/skcipher.h>
 #include <linux/string.h>
 #include <linux/pagemap.h>
 #include <linux/key.h>
 #include <linux/random.h>
@@ -599,14 +598,11 @@ struct ecryptfs_write_tag_70_packet_silly_stack {
 	struct scatterlist src_sg[2];
 	struct scatterlist dst_sg[2];
 	struct crypto_skcipher *skcipher_tfm;
 	struct skcipher_request *skcipher_req;
 	char iv[ECRYPTFS_MAX_IV_BYTES];
-	char hash[ECRYPTFS_TAG_70_DIGEST_SIZE];
-	char tmp_hash[ECRYPTFS_TAG_70_DIGEST_SIZE];
-	struct crypto_shash *hash_tfm;
-	struct shash_desc *hash_desc;
+	char hash[MD5_DIGEST_SIZE];
 };
 
 /*
  * write_tag_70_packet - Write encrypted filename (EFN) packet against FNEK
  * @filename: NULL-terminated filename string
@@ -739,55 +735,19 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		rc = -EOPNOTSUPP;
 		printk(KERN_INFO "%s: Filename encryption only supports "
 		       "password tokens\n", __func__);
 		goto out_free_unlock;
 	}
-	s->hash_tfm = crypto_alloc_shash(ECRYPTFS_TAG_70_DIGEST, 0, 0);
-	if (IS_ERR(s->hash_tfm)) {
-			rc = PTR_ERR(s->hash_tfm);
-			printk(KERN_ERR "%s: Error attempting to "
-			       "allocate hash crypto context; rc = [%d]\n",
-			       __func__, rc);
-			goto out_free_unlock;
-	}
-
-	s->hash_desc = kmalloc(sizeof(*s->hash_desc) +
-			       crypto_shash_descsize(s->hash_tfm), GFP_KERNEL);
-	if (!s->hash_desc) {
-		rc = -ENOMEM;
-		goto out_release_free_unlock;
-	}
 
-	s->hash_desc->tfm = s->hash_tfm;
-
-	rc = crypto_shash_digest(s->hash_desc,
-				 (u8 *)s->auth_tok->token.password.session_key_encryption_key,
-				 s->auth_tok->token.password.session_key_encryption_key_bytes,
-				 s->hash);
-	if (rc) {
-		printk(KERN_ERR
-		       "%s: Error computing crypto hash; rc = [%d]\n",
-		       __func__, rc);
-		goto out_release_free_unlock;
-	}
+	md5(s->auth_tok->token.password.session_key_encryption_key,
+	    s->auth_tok->token.password.session_key_encryption_key_bytes,
+	    s->hash);
 	for (s->j = 0; s->j < (s->num_rand_bytes - 1); s->j++) {
 		s->block_aligned_filename[s->j] =
-			s->hash[(s->j % ECRYPTFS_TAG_70_DIGEST_SIZE)];
-		if ((s->j % ECRYPTFS_TAG_70_DIGEST_SIZE)
-		    == (ECRYPTFS_TAG_70_DIGEST_SIZE - 1)) {
-			rc = crypto_shash_digest(s->hash_desc, (u8 *)s->hash,
-						ECRYPTFS_TAG_70_DIGEST_SIZE,
-						s->tmp_hash);
-			if (rc) {
-				printk(KERN_ERR
-				       "%s: Error computing crypto hash; "
-				       "rc = [%d]\n", __func__, rc);
-				goto out_release_free_unlock;
-			}
-			memcpy(s->hash, s->tmp_hash,
-			       ECRYPTFS_TAG_70_DIGEST_SIZE);
-		}
+			s->hash[s->j % MD5_DIGEST_SIZE];
+		if ((s->j % MD5_DIGEST_SIZE) == (MD5_DIGEST_SIZE - 1))
+			md5(s->hash, MD5_DIGEST_SIZE, s->hash);
 		if (s->block_aligned_filename[s->j] == '\0')
 			s->block_aligned_filename[s->j] = ECRYPTFS_NON_NULL;
 	}
 	memcpy(&s->block_aligned_filename[s->num_rand_bytes], filename,
 	       filename_size);
@@ -796,20 +756,20 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 	if (rc < 1) {
 		printk(KERN_ERR "%s: Internal error whilst attempting to "
 		       "convert filename memory to scatterlist; rc = [%d]. "
 		       "block_aligned_filename_size = [%zd]\n", __func__, rc,
 		       s->block_aligned_filename_size);
-		goto out_release_free_unlock;
+		goto out_free_unlock;
 	}
 	rc = virt_to_scatterlist(&dest[s->i], s->block_aligned_filename_size,
 				 s->dst_sg, 2);
 	if (rc < 1) {
 		printk(KERN_ERR "%s: Internal error whilst attempting to "
 		       "convert encrypted filename memory to scatterlist; "
 		       "rc = [%d]. block_aligned_filename_size = [%zd]\n",
 		       __func__, rc, s->block_aligned_filename_size);
-		goto out_release_free_unlock;
+		goto out_free_unlock;
 	}
 	/* The characters in the first block effectively do the job
 	 * of the IV here, so we just use 0's for the IV. Note the
 	 * constraint that ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTES
 	 * >= ECRYPTFS_MAX_IV_BYTES. */
@@ -823,36 +783,33 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		       "encryption_key = [0x%p]; mount_crypt_stat->"
 		       "global_default_fn_cipher_key_bytes = [%zd]\n", __func__,
 		       rc,
 		       s->auth_tok->token.password.session_key_encryption_key,
 		       mount_crypt_stat->global_default_fn_cipher_key_bytes);
-		goto out_release_free_unlock;
+		goto out_free_unlock;
 	}
 	skcipher_request_set_crypt(s->skcipher_req, s->src_sg, s->dst_sg,
 				   s->block_aligned_filename_size, s->iv);
 	rc = crypto_skcipher_encrypt(s->skcipher_req);
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to encrypt filename; "
 		       "rc = [%d]\n", __func__, rc);
-		goto out_release_free_unlock;
+		goto out_free_unlock;
 	}
 	s->i += s->block_aligned_filename_size;
 	(*packet_size) = s->i;
 	(*remaining_bytes) -= (*packet_size);
-out_release_free_unlock:
-	crypto_free_shash(s->hash_tfm);
 out_free_unlock:
 	kfree_sensitive(s->block_aligned_filename);
 out_unlock:
 	mutex_unlock(s->tfm_mutex);
 out:
 	if (auth_tok_key) {
 		up_write(&(auth_tok_key->sem));
 		key_put(auth_tok_key);
 	}
 	skcipher_request_free(s->skcipher_req);
-	kfree_sensitive(s->hash_desc);
 	kfree(s);
 	return rc;
 }
 
 struct ecryptfs_parse_tag_70_packet_silly_stack {
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 16ea14dd2c62e..c12dc680f8fe2 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -10,10 +10,11 @@
  *              Tyler Hicks <code@tyhicks.com>
  */
 
 #include <linux/dcache.h>
 #include <linux/file.h>
+#include <linux/fips.h>
 #include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/skbuff.h>
 #include <linux/pagemap.h>
 #include <linux/key.h>
@@ -452,10 +453,16 @@ static int ecryptfs_get_tree(struct fs_context *fc)
 	if (rc) {
 		err = "Error validating options";
 		goto out;
 	}
 
+	if (fips_enabled) {
+		rc = -EINVAL;
+		err = "eCryptfs support is disabled due to FIPS";
+		goto out;
+	}
+
 	s = sget_fc(fc, NULL, set_anon_super_fc);
 	if (IS_ERR(s)) {
 		rc = PTR_ERR(s);
 		goto out;
 	}
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index e7b7f426fecfb..3bc21d677564d 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -39,14 +39,11 @@ static struct inode *ecryptfs_alloc_inode(struct super_block *sb)
 	struct inode *inode = NULL;
 
 	inode_info = alloc_inode_sb(sb, ecryptfs_inode_info_cache, GFP_KERNEL);
 	if (unlikely(!inode_info))
 		goto out;
-	if (ecryptfs_init_crypt_stat(&inode_info->crypt_stat)) {
-		kmem_cache_free(ecryptfs_inode_info_cache, inode_info);
-		goto out;
-	}
+	ecryptfs_init_crypt_stat(&inode_info->crypt_stat);
 	mutex_init(&inode_info->lower_file_mutex);
 	atomic_set(&inode_info->lower_file_count, 0);
 	inode_info->lower_file = NULL;
 	inode = &inode_info->vfs_inode;
 out:

base-commit: 0739473694c4878513031006829f1030ec850bc2
-- 
2.51.0


