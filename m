Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95217924EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjIEQAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243930AbjIEBEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:04:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BAA1B8;
        Mon,  4 Sep 2023 18:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F02ACE0B18;
        Tue,  5 Sep 2023 01:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB4BC433C8;
        Tue,  5 Sep 2023 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693875867;
        bh=vQHLd6zbQvJWhjFFtDiZ4GFIAx/SbZHdT/9DwgQk31I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxeCRDYw22oJs2hGwXwQAEFG0me2UZMaXTpQLn3YHO7tB8vodeBOalKIWqfS1xGxn
         pNHH7OdbDOAD8FZ0hU1vtMFc+S2yPuzYnfR48eqeCvEq87BJXdhv1kKmhcfJx8tc15
         r/178XgE8duVtzXyPidDCA+KaefUpBcOVIgfWGISLWVS7bpShgfLyXfELjk3MPhJwX
         9DM6pVA+xA534Wa+NgS47dcYVmDF3qPyCuXzazV+53U3m+YzRmkpluEHg62V71/N4f
         obuXYIi2lKoV1V98t5dgHND6GaN9schPtIL3SFipnqJwgS1oIMRLWij4mbqSpJtqkU
         A+ipylGkTf9ww==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] fscrypt: support crypto data unit size less than filesystem block size
Date:   Mon,  4 Sep 2023 17:58:30 -0700
Message-ID: <20230905005830.365985-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905005830.365985-1-ebiggers@kernel.org>
References: <20230905005830.365985-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Until now, fscrypt has always used the filesystem block size as the
granularity of file contents encryption.  Two scenarios have come up
where a sub-block granularity of contents encryption would be useful:

1. Inline encryption hardware that only supports a crypto data unit size
   that is less than the filesystem block size.

2. Support for direct I/O at a granularity less than the filesystem
   block size, for example at the block device's logical block size in
   order to match the traditional direct I/O alignment requirement.

(1) first came up with older eMMC inline crypto hardware that only
supports a crypto data unit size of 512 bytes.  That specific case
ultimately went away because all systems with that hardware continued
using out of tree code and never actually upgraded to the upstream
inline crypto framework.  But, now it's coming back in a new way: some
current UFS controllers only support a data unit size of 4096 bytes, and
there is a proposal to increase the filesystem block size to 16K.

(2) was discussed as a "nice to have" feature, though not essential,
when support for direct I/O on encrypted files was being upstreamed.

Still, the fact that this feature has come up several times does suggest
it would be wise to have available.  Therefore, this patch implements it
by using one of the reserved bytes in fscrypt_policy_v2 to allow users
to select a sub-block data unit size.  Supported values are powers of 2
between 512 bytes and the filesystem block size, inclusively.  Support
is implemented for both the FS-layer and inline crypto cases.

This feature is incompatible with filesystems that encrypt variable
length blocks as a result of compression, i.e. UBIFS.  Therefore, this
feature is made available only for filesystems that opt in via their
fscrypt_operations.  Make ext4 and f2fs opt in.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 115 +++++++++++++++------
 fs/crypto/bio.c                       |  39 ++++----
 fs/crypto/crypto.c                    | 139 ++++++++++++++------------
 fs/crypto/fscrypt_private.h           |  49 ++++++---
 fs/crypto/inline_crypt.c              |  41 ++++++--
 fs/crypto/keysetup.c                  |  21 +++-
 fs/crypto/policy.c                    |  28 +++++-
 fs/ext4/crypto.c                      |   1 +
 fs/f2fs/super.c                       |   1 +
 include/linux/fscrypt.h               |  12 +++
 include/uapi/linux/fscrypt.h          |   3 +-
 11 files changed, 310 insertions(+), 139 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index a624e92f2687f..010c066cf384c 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -261,9 +261,9 @@ DIRECT_KEY policies
 
 The Adiantum encryption mode (see `Encryption modes and usage`_) is
 suitable for both contents and filenames encryption, and it accepts
-long IVs --- long enough to hold both an 8-byte logical block number
-and a 16-byte per-file nonce.  Also, the overhead of each Adiantum key
-is greater than that of an AES-256-XTS key.
+long IVs --- long enough to hold both an 8-byte data unit index and a
+16-byte per-file nonce.  Also, the overhead of each Adiantum key is
+greater than that of an AES-256-XTS key.
 
 Therefore, to improve performance and save memory, for Adiantum a
 "direct key" configuration is supported.  When the user has enabled
@@ -300,8 +300,8 @@ IV_INO_LBLK_32 policies
 
 IV_INO_LBLK_32 policies work like IV_INO_LBLK_64, except that for
 IV_INO_LBLK_32, the inode number is hashed with SipHash-2-4 (where the
-SipHash key is derived from the master key) and added to the file
-logical block number mod 2^32 to produce a 32-bit IV.
+SipHash key is derived from the master key) and added to the file data
+unit index mod 2^32 to produce a 32-bit IV.
 
 This format is optimized for use with inline encryption hardware
 compliant with the eMMC v5.2 standard, which supports only 32 IV bits
@@ -451,31 +451,62 @@ acceleration is recommended:
 Contents encryption
 -------------------
 
-For file contents, each filesystem block is encrypted independently.
-Starting from Linux kernel 5.5, encryption of filesystems with block
-size less than system's page size is supported.
-
-Each block's IV is set to the logical block number within the file as
-a little endian number, except that:
-
-- With CBC mode encryption, ESSIV is also used.  Specifically, each IV
-  is encrypted with AES-256 where the AES-256 key is the SHA-256 hash
-  of the file's data encryption key.
-
-- With `DIRECT_KEY policies`_, the file's nonce is appended to the IV.
-  Currently this is only allowed with the Adiantum encryption mode.
-
-- With `IV_INO_LBLK_64 policies`_, the logical block number is limited
-  to 32 bits and is placed in bits 0-31 of the IV.  The inode number
-  (which is also limited to 32 bits) is placed in bits 32-63.
-
-- With `IV_INO_LBLK_32 policies`_, the logical block number is limited
-  to 32 bits and is placed in bits 0-31 of the IV.  The inode number
-  is then hashed and added mod 2^32.
-
-Note that because file logical block numbers are included in the IVs,
-filesystems must enforce that blocks are never shifted around within
-encrypted files, e.g. via "collapse range" or "insert range".
+For contents encryption, each file's contents is divided into "data
+units".  Each data unit is encrypted independently.  The IV for each
+data unit incorporates the zero-based index of the data unit within
+the file.  This ensures that each data unit within a file is encrypted
+differently, which is essential to prevent leaking information.
+
+Note: the encryption depending on the offset into the file means that
+operations like "collapse range" and "insert range" that rearrange the
+extent mapping of files are not supported on encrypted files.
+
+There are two cases for the sizes of the data units:
+
+* Fixed-size data units.  This is how all filesystems other than UBIFS
+  work.  A file's data units are all the same size; the last data unit
+  is zero-padded if needed.  By default, the data unit size is equal
+  to the filesystem block size.  Since Linux 6.7, users can select a
+  sub-block data unit size via the ``log2_data_unit_size`` field of
+  the encryption policy; see `FS_IOC_SET_ENCRYPTION_POLICY`_.
+
+* Variable-size data units.  This is what UBIFS does.  Each "UBIFS
+  data node" is treated as a crypto data unit.  Each contains variable
+  length, possibly compressed data, zero-padded to the next 16-byte
+  boundary.  Users cannot select a sub-block data unit size on UBIFS.
+
+In the case of compression + encryption, the compressed data is
+encrypted.  UBIFS compression works as described above.  f2fs
+compression works a bit differently; it compresses a number of
+filesystem blocks into a smaller number of filesystem blocks.
+Therefore a f2fs-compressed file still uses fixed-size data units, and
+it is encrypted in a similar way to a file containing holes.
+
+As mentioned in `Key hierarchy`_, the default encryption setting uses
+per-file keys.  In this case, the IV for each data unit is simply the
+index of the data unit in the file.  However, users can select an
+encryption setting that does not use per-file keys.  For these, some
+kind of file identifier is incorporated into the IVs as follows:
+
+- With `DIRECT_KEY policies`_, the data unit index is placed in bits
+  0-63 of the IV, and the file's nonce is placed in bits 64-191.
+
+- With `IV_INO_LBLK_64 policies`_, the data unit index is placed in
+  bits 0-31 of the IV, and the file's inode number is placed in bits
+  32-63.  This setting is only allowed when data unit indices and
+  inode numbers fit in 32 bits.
+
+- With `IV_INO_LBLK_32 policies`_, the file's inode number is hashed
+  and added to the data unit index.  The resulting value is truncated
+  to 32 bits and placed in bits 0-31 of the IV.  This setting is only
+  allowed when data unit indices and inode numbers fit in 32 bits.
+
+The byte order of the IV is always little endian.
+
+If the user selects FSCRYPT_MODE_AES_128_CBC for the contents mode, an
+ESSIV layer is automatically included.  In this case, before the IV is
+passed to AES-128-CBC, it is encrypted with AES-256 where the AES-256
+key is the SHA-256 hash of the file's contents encryption key.
 
 Filenames encryption
 --------------------
@@ -544,7 +575,8 @@ follows::
             __u8 contents_encryption_mode;
             __u8 filenames_encryption_mode;
             __u8 flags;
-            __u8 __reserved[4];
+            __u8 log2_data_unit_size;
+            __u8 __reserved[3];
             __u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
     };
 
@@ -586,6 +618,27 @@ This structure must be initialized as follows:
   The DIRECT_KEY, IV_INO_LBLK_64, and IV_INO_LBLK_32 flags are
   mutually exclusive.
 
+- ``log2_data_unit_size`` is the log2 of the data unit size in bytes,
+  or 0 to select the default data unit size.  The data unit size is
+  the granularity of file contents encryption.  For example, setting
+  ``log2_data_unit_size`` to 12 causes file contents be passed to the
+  underlying encryption algorithm (such as AES-256-XTS) in 4096-byte
+  data units, each with its own IV.
+
+  Not all filesystems support setting ``log2_data_unit_size``.  On
+  filesystems that support it, the supported nonzero values are 9
+  through the log2 of the filesystem block size, inclusively.  The
+  default value of 0 selects the filesystem block size.
+
+  The main use case for ``log2_data_unit_size`` is for selecting a
+  data unit size smaller than the filesystem block size for
+  compatibility with inline encryption hardware that only supports
+  smaller data unit sizes.  ``/sys/block/$disk/queue/crypto/`` may be
+  useful for checking which data unit sizes are supported by a
+  particular system's inline encryption hardware.
+
+  Leave this field zeroed unless you are certain you need it.
+
 - For v2 encryption policies, ``__reserved`` must be zeroed.
 
 - For v1 encryption policies, ``master_key_descriptor`` specifies how
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 62e1a3dd83574..5c5aff66d10ab 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -111,10 +111,14 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len)
 {
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocksize = 1 << blockbits;
-	const unsigned int blocks_per_page_bits = PAGE_SHIFT - blockbits;
-	const unsigned int blocks_per_page = 1 << blocks_per_page_bits;
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const unsigned int du_bits = ci->ci_log2_data_unit_size;
+	const unsigned int du_size = 1U << du_bits;
+	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
+	const unsigned int du_per_page = 1U << du_per_page_bits;
+	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
+	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
 	unsigned int i;
@@ -130,8 +134,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 							  len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
-	nr_pages = min_t(unsigned int, ARRAY_SIZE(pages),
-			 (len + blocks_per_page - 1) >> blocks_per_page_bits);
+	nr_pages = min_t(u64, ARRAY_SIZE(pages),
+			 (du_remaining + du_per_page - 1) >> du_per_page_bits);
 
 	/*
 	 * We need at least one page for ciphertext.  Allocate the first one
@@ -154,21 +158,22 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	bio = bio_alloc(inode->i_sb->s_bdev, nr_pages, REQ_OP_WRITE, GFP_NOFS);
 
 	do {
-		bio->bi_iter.bi_sector = pblk << (blockbits - 9);
+		bio->bi_iter.bi_sector = sector;
 
 		i = 0;
 		offset = 0;
 		do {
-			err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
-						  ZERO_PAGE(0), pages[i],
-						  blocksize, offset, GFP_NOFS);
+			err = fscrypt_crypt_data_unit(ci, FS_ENCRYPT, du_index,
+						      ZERO_PAGE(0), pages[i],
+						      du_size, offset,
+						      GFP_NOFS);
 			if (err)
 				goto out;
-			lblk++;
-			pblk++;
-			len--;
-			offset += blocksize;
-			if (offset == PAGE_SIZE || len == 0) {
+			du_index++;
+			sector += 1U << (du_bits - SECTOR_SHIFT);
+			du_remaining--;
+			offset += du_size;
+			if (offset == PAGE_SIZE || du_remaining == 0) {
 				ret = bio_add_page(bio, pages[i++], offset, 0);
 				if (WARN_ON_ONCE(ret != offset)) {
 					err = -EIO;
@@ -176,13 +181,13 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 				}
 				offset = 0;
 			}
-		} while (i != nr_pages && len != 0);
+		} while (i != nr_pages && du_remaining != 0);
 
 		err = submit_bio_wait(bio);
 		if (err)
 			goto out;
 		bio_reset(bio, inode->i_sb->s_bdev, REQ_OP_WRITE);
-	} while (len != 0);
+	} while (du_remaining != 0);
 	err = 0;
 out:
 	bio_put(bio);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 803347a5d0a6d..e6af5f613a36f 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -77,14 +77,14 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
 EXPORT_SYMBOL(fscrypt_free_bounce_page);
 
 /*
- * Generate the IV for the given logical block number within the given file.
- * For filenames encryption, lblk_num == 0.
+ * Generate the IV for the given data unit index within the given file.
+ * For filenames encryption, index == 0.
  *
  * Keep this in sync with fscrypt_limit_io_blocks().  fscrypt_limit_io_blocks()
  * needs to know about any IV generation methods where the low bits of IV don't
- * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
+ * simply contain the data unit index (e.g., IV_INO_LBLK_32).
  */
-void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
+void fscrypt_generate_iv(union fscrypt_iv *iv, u64 index,
 			 const struct fscrypt_info *ci)
 {
 	u8 flags = fscrypt_policy_flags(&ci->ci_policy);
@@ -92,29 +92,29 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 	memset(iv, 0, ci->ci_mode->ivsize);
 
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
-		WARN_ON_ONCE(lblk_num > U32_MAX);
+		WARN_ON_ONCE(index > U32_MAX);
 		WARN_ON_ONCE(ci->ci_inode->i_ino > U32_MAX);
-		lblk_num |= (u64)ci->ci_inode->i_ino << 32;
+		index |= (u64)ci->ci_inode->i_ino << 32;
 	} else if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) {
-		WARN_ON_ONCE(lblk_num > U32_MAX);
-		lblk_num = (u32)(ci->ci_hashed_ino + lblk_num);
+		WARN_ON_ONCE(index > U32_MAX);
+		index = (u32)(ci->ci_hashed_ino + index);
 	} else if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		memcpy(iv->nonce, ci->ci_nonce, FSCRYPT_FILE_NONCE_SIZE);
 	}
-	iv->lblk_num = cpu_to_le64(lblk_num);
+	iv->index = cpu_to_le64(index);
 }
 
-/* Encrypt or decrypt a single filesystem block of file contents */
-int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
-			u64 lblk_num, struct page *src_page,
-			struct page *dest_page, unsigned int len,
-			unsigned int offs, gfp_t gfp_flags)
+/* Encrypt or decrypt a single "data unit" of file contents. */
+int fscrypt_crypt_data_unit(const struct fscrypt_info *ci,
+			    fscrypt_direction_t rw, u64 index,
+			    struct page *src_page, struct page *dest_page,
+			    unsigned int len, unsigned int offs,
+			    gfp_t gfp_flags)
 {
 	union fscrypt_iv iv;
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
-	struct fscrypt_info *ci = inode->i_crypt_info;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	int res = 0;
 
@@ -123,7 +123,7 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
 		return -EINVAL;
 
-	fscrypt_generate_iv(&iv, lblk_num, ci);
+	fscrypt_generate_iv(&iv, index, ci);
 
 	req = skcipher_request_alloc(tfm, gfp_flags);
 	if (!req)
@@ -144,28 +144,29 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 		res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
 	skcipher_request_free(req);
 	if (res) {
-		fscrypt_err(inode, "%scryption failed for block %llu: %d",
-			    (rw == FS_DECRYPT ? "De" : "En"), lblk_num, res);
+		fscrypt_err(ci->ci_inode,
+			    "%scryption failed for data unit %llu: %d",
+			    (rw == FS_DECRYPT ? "De" : "En"), index, res);
 		return res;
 	}
 	return 0;
 }
 
 /**
- * fscrypt_encrypt_pagecache_blocks() - Encrypt filesystem blocks from a
- *					pagecache page
- * @page:      The locked pagecache page containing the block(s) to encrypt
- * @len:       Total size of the block(s) to encrypt.  Must be a nonzero
- *		multiple of the filesystem's block size.
- * @offs:      Byte offset within @page of the first block to encrypt.  Must be
- *		a multiple of the filesystem's block size.
- * @gfp_flags: Memory allocation flags.  See details below.
+ * fscrypt_encrypt_pagecache_blocks() - Encrypt data from a pagecache page
+ * @page: the locked pagecache page containing the data to encrypt
+ * @len: size of the data to encrypt, in bytes
+ * @offs: offset within @page of the data to encrypt, in bytes
+ * @gfp_flags: memory allocation flags; see details below
  *
- * A new bounce page is allocated, and the specified block(s) are encrypted into
- * it.  In the bounce page, the ciphertext block(s) will be located at the same
- * offsets at which the plaintext block(s) were located in the source page; any
- * other parts of the bounce page will be left uninitialized.  However, normally
- * blocksize == PAGE_SIZE and the whole page is encrypted at once.
+ * This allocates a new bounce page and encrypts the given data into it.  The
+ * length and offset of the data must be aligned to the file's crypto data unit
+ * size.  Alignment to the filesystem block size fulfills this requirement, as
+ * the filesystem block size is always a multiple of the data unit size.
+ *
+ * In the bounce page, the ciphertext data will be located at the same offset at
+ * which the plaintext data was located in the source page.  Any other parts of
+ * the bounce page will be left uninitialized.
  *
  * This is for use by the filesystem's ->writepages() method.
  *
@@ -183,28 +184,29 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
 
 {
 	const struct inode *inode = page->mapping->host;
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocksize = 1 << blockbits;
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const unsigned int du_bits = ci->ci_log2_data_unit_size;
+	const unsigned int du_size = 1U << du_bits;
 	struct page *ciphertext_page;
-	u64 lblk_num = ((u64)page->index << (PAGE_SHIFT - blockbits)) +
-		       (offs >> blockbits);
+	u64 index = ((u64)page->index << (PAGE_SHIFT - du_bits)) +
+		    (offs >> du_bits);
 	unsigned int i;
 	int err;
 
 	if (WARN_ON_ONCE(!PageLocked(page)))
 		return ERR_PTR(-EINVAL);
 
-	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, blocksize)))
+	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, du_size)))
 		return ERR_PTR(-EINVAL);
 
 	ciphertext_page = fscrypt_alloc_bounce_page(gfp_flags);
 	if (!ciphertext_page)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = offs; i < offs + len; i += blocksize, lblk_num++) {
-		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num,
-					  page, ciphertext_page,
-					  blocksize, i, gfp_flags);
+	for (i = offs; i < offs + len; i += du_size, index++) {
+		err = fscrypt_crypt_data_unit(ci, FS_ENCRYPT, index,
+					      page, ciphertext_page,
+					      du_size, i, gfp_flags);
 		if (err) {
 			fscrypt_free_bounce_page(ciphertext_page);
 			return ERR_PTR(err);
@@ -231,30 +233,33 @@ EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
  * arbitrary page, not necessarily in the original pagecache page.  The @inode
  * and @lblk_num must be specified, as they can't be determined from @page.
  *
+ * This is not compatible with fscrypt_operations::supports_subblock_data_units.
+ *
  * Return: 0 on success; -errno on failure
  */
 int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num, gfp_t gfp_flags)
 {
-	return fscrypt_crypt_block(inode, FS_ENCRYPT, lblk_num, page, page,
-				   len, offs, gfp_flags);
+	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
+		return -EOPNOTSUPP;
+	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_ENCRYPT,
+				       lblk_num, page, page, len, offs,
+				       gfp_flags);
 }
 EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 
 /**
- * fscrypt_decrypt_pagecache_blocks() - Decrypt filesystem blocks in a
- *					pagecache folio
- * @folio:     The locked pagecache folio containing the block(s) to decrypt
- * @len:       Total size of the block(s) to decrypt.  Must be a nonzero
- *		multiple of the filesystem's block size.
- * @offs:      Byte offset within @folio of the first block to decrypt.  Must be
- *		a multiple of the filesystem's block size.
+ * fscrypt_decrypt_pagecache_blocks() - Decrypt data from a pagecache folio
+ * @folio: the pagecache folio containing the data to decrypt
+ * @len: size of the data to decrypt, in bytes
+ * @offs: offset within @folio of the data to decrypt, in bytes
  *
- * The specified block(s) are decrypted in-place within the pagecache folio,
- * which must still be locked and not uptodate.
- *
- * This is for use by the filesystem's ->readahead() method.
+ * Decrypt data that has just been read from an encrypted file.  The data must
+ * be located in a pagecache folio that is still locked and not yet uptodate.
+ * The length and offset of the data must be aligned to the file's crypto data
+ * unit size.  Alignment to the filesystem block size fulfills this requirement,
+ * as the filesystem block size is always a multiple of the data unit size.
  *
  * Return: 0 on success; -errno on failure
  */
@@ -262,25 +267,26 @@ int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
 				     size_t offs)
 {
 	const struct inode *inode = folio->mapping->host;
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocksize = 1 << blockbits;
-	u64 lblk_num = ((u64)folio->index << (PAGE_SHIFT - blockbits)) +
-		       (offs >> blockbits);
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const unsigned int du_bits = ci->ci_log2_data_unit_size;
+	const unsigned int du_size = 1U << du_bits;
+	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
+		    (offs >> du_bits);
 	size_t i;
 	int err;
 
 	if (WARN_ON_ONCE(!folio_test_locked(folio)))
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, blocksize)))
+	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, du_size)))
 		return -EINVAL;
 
-	for (i = offs; i < offs + len; i += blocksize, lblk_num++) {
+	for (i = offs; i < offs + len; i += du_size, index++) {
 		struct page *page = folio_page(folio, i >> PAGE_SHIFT);
 
-		err = fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page,
-					  page, blocksize, i & ~PAGE_MASK,
-					  GFP_NOFS);
+		err = fscrypt_crypt_data_unit(ci, FS_DECRYPT, index, page,
+					      page, du_size, i & ~PAGE_MASK,
+					      GFP_NOFS);
 		if (err)
 			return err;
 	}
@@ -302,14 +308,19 @@ EXPORT_SYMBOL(fscrypt_decrypt_pagecache_blocks);
  * arbitrary page, not necessarily in the original pagecache page.  The @inode
  * and @lblk_num must be specified, as they can't be determined from @page.
  *
+ * This is not compatible with fscrypt_operations::supports_subblock_data_units.
+ *
  * Return: 0 on success; -errno on failure
  */
 int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num)
 {
-	return fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page, page,
-				   len, offs, GFP_NOFS);
+	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
+		return -EOPNOTSUPP;
+	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_DECRYPT,
+				       lblk_num, page, page, len, offs,
+				       GFP_NOFS);
 }
 EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 4b113214b53af..acdb9c8a20d65 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -47,7 +47,8 @@ struct fscrypt_context_v2 {
 	u8 contents_encryption_mode;
 	u8 filenames_encryption_mode;
 	u8 flags;
-	u8 __reserved[4];
+	u8 log2_data_unit_size;
+	u8 __reserved[3];
 	u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
 	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
 };
@@ -165,6 +166,26 @@ fscrypt_policy_flags(const union fscrypt_policy *policy)
 	BUG();
 }
 
+static inline int
+fscrypt_policy_v2_log2_du_size(const struct fscrypt_policy_v2 *policy,
+			       const struct inode *inode)
+{
+	return policy->log2_data_unit_size ?: inode->i_blkbits;
+}
+
+static inline int
+fscrypt_policy_log2_du_size(const union fscrypt_policy *policy,
+			    const struct inode *inode)
+{
+	switch (policy->version) {
+	case FSCRYPT_POLICY_V1:
+		return inode->i_blkbits;
+	case FSCRYPT_POLICY_V2:
+		return fscrypt_policy_v2_log2_du_size(&policy->v2, inode);
+	}
+	BUG();
+}
+
 /*
  * For encrypted symlinks, the ciphertext length is stored at the beginning
  * of the string in little-endian format.
@@ -211,6 +232,9 @@ struct fscrypt_info {
 	bool ci_inlinecrypt;
 #endif
 
+	/* log2 of the data unit size used by this file */
+	u8 ci_log2_data_unit_size;
+
 	/*
 	 * Encryption mode used for this inode.  It corresponds to either the
 	 * contents or filenames encryption mode, depending on the inode type.
@@ -265,10 +289,11 @@ typedef enum {
 /* crypto.c */
 extern struct kmem_cache *fscrypt_info_cachep;
 int fscrypt_initialize(struct super_block *sb);
-int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
-			u64 lblk_num, struct page *src_page,
-			struct page *dest_page, unsigned int len,
-			unsigned int offs, gfp_t gfp_flags);
+int fscrypt_crypt_data_unit(const struct fscrypt_info *ci,
+			    fscrypt_direction_t rw, u64 index,
+			    struct page *src_page, struct page *dest_page,
+			    unsigned int len, unsigned int offs,
+			    gfp_t gfp_flags);
 struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags);
 
 void __printf(3, 4) __cold
@@ -283,8 +308,8 @@ fscrypt_msg(const struct inode *inode, const char *level, const char *fmt, ...);
 
 union fscrypt_iv {
 	struct {
-		/* logical block number within the file */
-		__le64 lblk_num;
+		/* zero-based index of data unit within the file */
+		__le64 index;
 
 		/* per-file nonce; only set in DIRECT_KEY mode */
 		u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
@@ -293,17 +318,17 @@ union fscrypt_iv {
 	__le64 dun[FSCRYPT_MAX_IV_SIZE / sizeof(__le64)];
 };
 
-void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
+void fscrypt_generate_iv(union fscrypt_iv *iv, u64 index,
 			 const struct fscrypt_info *ci);
 
 /*
- * Return the number of bits used by the maximum file logical block number that
- * is possible on the given filesystem.
+ * Return the number of bits used by the maximum file data unit index that is
+ * possible on the given filesystem, using the given data unit size.
  */
 static inline int
-fscrypt_max_file_lblk_bits(const struct super_block *sb)
+fscrypt_max_file_dun_bits(const struct super_block *sb, int log2_du_size)
 {
-	return fls64(sb->s_maxbytes - 1) - sb->s_blocksize_bits;
+	return fls64(sb->s_maxbytes - 1) - log2_du_size;
 }
 
 /* fname.c */
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 7d9f6c167de58..00616d97c742a 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -39,10 +39,16 @@ static struct block_device **fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
+static unsigned int fscrypt_get_du_size(const struct fscrypt_info *ci)
+{
+	return 1U << ci->ci_log2_data_unit_size;
+}
+
 static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 {
 	const struct super_block *sb = ci->ci_inode->i_sb;
 	unsigned int flags = fscrypt_policy_flags(&ci->ci_policy);
+	int dun_bits;
 
 	if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return offsetofend(union fscrypt_iv, nonce);
@@ -53,8 +59,9 @@ static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)
 		return sizeof(__le32);
 
-	/* Default case: IVs are just the file logical block number */
-	return DIV_ROUND_UP(fscrypt_max_file_lblk_bits(sb), 8);
+	/* Default case: IVs are just the file data unit index */
+	dun_bits = fscrypt_max_file_dun_bits(sb, ci->ci_log2_data_unit_size);
+	return DIV_ROUND_UP(dun_bits, 8);
 }
 
 /*
@@ -126,7 +133,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	 * crypto configuration that the file would use.
 	 */
 	crypto_cfg.crypto_mode = ci->ci_mode->blk_crypto_mode;
-	crypto_cfg.data_unit_size = sb->s_blocksize;
+	crypto_cfg.data_unit_size = fscrypt_get_du_size(ci);
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
 
 	devs = fscrypt_get_devices(sb, &num_devs);
@@ -165,7 +172,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 		return -ENOMEM;
 
 	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
-				  fscrypt_get_dun_bytes(ci), sb->s_blocksize);
+				  fscrypt_get_dun_bytes(ci),
+				  fscrypt_get_du_size(ci));
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
@@ -232,10 +240,12 @@ EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
 				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
 {
+	u64 index = lblk_num << (ci->ci_inode->i_blkbits -
+				 ci->ci_log2_data_unit_size);
 	union fscrypt_iv iv;
 	int i;
 
-	fscrypt_generate_iv(&iv, lblk_num, ci);
+	fscrypt_generate_iv(&iv, index, ci);
 
 	BUILD_BUG_ON(FSCRYPT_MAX_IV_SIZE > BLK_CRYPTO_MAX_IV_SIZE);
 	memset(dun, 0, BLK_CRYPTO_MAX_IV_SIZE);
@@ -454,7 +464,9 @@ EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 {
 	const struct fscrypt_info *ci;
+	int log2_du_per_block;
 	u32 dun;
+	u64 limit;
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return nr_blocks;
@@ -469,8 +481,23 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 
 	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
 
-	dun = ci->ci_hashed_ino + lblk;
+	/* Compute the DUN at lblk. */
+	log2_du_per_block = inode->i_blkbits - ci->ci_log2_data_unit_size;
+	dun = ci->ci_hashed_ino + (lblk << log2_du_per_block);
+
+	/* Compute the number of data units until the wraparound. */
+	limit = (u64)U32_MAX + 1 - dun;
+
+	/*
+	 * Translate the limit from data units to blocks.  It's guaranteed that
+	 * the limit is divisible by the filesystem block size, since the low
+	 * log2_du_per_block bits of ci_hashed_ino are zero.  I.e, it's
+	 * guaranteed that the DUN wraparound will occur on a block boundary.
+	 */
+	WARN_ON_ONCE(limit & ((1U << log2_du_per_block) - 1));
+	limit >>= log2_du_per_block;
 
-	return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
+	/* Cap the limit to the amount the caller actually wants to submit. */
+	return min(nr_blocks, limit);
 }
 EXPORT_SYMBOL_GPL(fscrypt_limit_io_blocks);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 361f41ef46c78..d8346a978b4e6 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -282,11 +282,23 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 			       const struct fscrypt_master_key *mk)
 {
-	WARN_ON_ONCE(ci->ci_inode->i_ino == 0);
+	const struct inode *inode = ci->ci_inode;
+	u32 hash;
+
+	WARN_ON_ONCE(inode->i_ino == 0);
 	WARN_ON_ONCE(!mk->mk_ino_hash_key_initialized);
 
-	ci->ci_hashed_ino = (u32)siphash_1u64(ci->ci_inode->i_ino,
-					      &mk->mk_ino_hash_key);
+	hash = (u32)siphash_1u64(inode->i_ino, &mk->mk_ino_hash_key);
+
+	/*
+	 * If data_unit_size < fs_block_size, clear some least significant bits
+	 * from the hash so that the wraparound from U32_MAX => 0 will only
+	 * occur at a filesystem block boundary.  This is needed to make it so
+	 * that filesystems are not required to do sub-block I/O.
+	 */
+	hash &= ~((1U << (inode->i_blkbits - ci->ci_log2_data_unit_size)) - 1);
+
+	ci->ci_hashed_ino = hash;
 }
 
 static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_info *ci,
@@ -580,6 +592,9 @@ fscrypt_setup_encryption_info(struct inode *inode,
 	WARN_ON_ONCE(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
 	crypt_info->ci_mode = mode;
 
+	crypt_info->ci_log2_data_unit_size =
+		fscrypt_policy_log2_du_size(&crypt_info->ci_policy, inode);
+
 	res = setup_file_encryption_key(crypt_info, need_dirhash_key, &mk);
 	if (res)
 		goto out;
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index c8072a634af8f..98a0279c6fb0c 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -123,6 +123,7 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 	const char *type = (policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64)
 				? "IV_INO_LBLK_64" : "IV_INO_LBLK_32";
 	struct super_block *sb = inode->i_sb;
+	int log2_du_size;
 
 	/*
 	 * IV_INO_LBLK_* exist only because of hardware limitations, and
@@ -165,10 +166,11 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 	}
 
 	/*
-	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file logical
-	 * block numbers fit in 32 bits.
+	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file data unit
+	 * indices fit in 32 bits.
 	 */
-	if (fscrypt_max_file_lblk_bits(sb) > 32) {
+	log2_du_size = fscrypt_policy_v2_log2_du_size(policy, inode);
+	if (fscrypt_max_file_dun_bits(sb, log2_du_size) > 32) {
 		fscrypt_warn(inode,
 			     "Can't use %s policy on filesystem '%s' because its maximum file size is too large",
 			     type, sb->s_id);
@@ -214,10 +216,11 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 					const struct inode *inode)
 {
+	const struct super_block *sb = inode->i_sb;
 	int count = 0;
 
 	if (!fscrypt_valid_enc_modes_v2(policy->contents_encryption_mode,
-				     policy->filenames_encryption_mode)) {
+					policy->filenames_encryption_mode)) {
 		fscrypt_warn(inode,
 			     "Unsupported encryption modes (contents %d, filenames %d)",
 			     policy->contents_encryption_mode,
@@ -243,6 +246,21 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		return false;
 	}
 
+	if (policy->log2_data_unit_size) {
+		if (!sb->s_cop->supports_subblock_data_units) {
+			fscrypt_warn(inode,
+				     "Filesystem does not support configuring crypto data unit size");
+			return false;
+		}
+		if (policy->log2_data_unit_size > inode->i_blkbits ||
+		    policy->log2_data_unit_size < SECTOR_SHIFT /* 9 */) {
+			fscrypt_warn(inode,
+				     "Unsupported log2_data_unit_size in encryption policy: %d",
+				     policy->log2_data_unit_size);
+			return false;
+		}
+	}
+
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
 					policy->filenames_encryption_mode))
@@ -329,6 +347,7 @@ static int fscrypt_new_context(union fscrypt_context *ctx_u,
 		ctx->filenames_encryption_mode =
 			policy->filenames_encryption_mode;
 		ctx->flags = policy->flags;
+		ctx->log2_data_unit_size = policy->log2_data_unit_size;
 		memcpy(ctx->master_key_identifier,
 		       policy->master_key_identifier,
 		       sizeof(ctx->master_key_identifier));
@@ -389,6 +408,7 @@ int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
 		policy->filenames_encryption_mode =
 			ctx->filenames_encryption_mode;
 		policy->flags = ctx->flags;
+		policy->log2_data_unit_size = ctx->log2_data_unit_size;
 		memcpy(policy->__reserved, ctx->__reserved,
 		       sizeof(policy->__reserved));
 		memcpy(policy->master_key_identifier,
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 2859d9569aa74..5013b9d67026a 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -235,6 +235,7 @@ static bool ext4_has_stable_inodes(struct super_block *sb)
 const struct fscrypt_operations ext4_cryptops = {
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
+	.supports_subblock_data_units = 1,
 	.legacy_key_prefix_for_backcompat = "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7e8e510ef77af..8e9b452c8b4b6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3226,6 +3226,7 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 static const struct fscrypt_operations f2fs_cryptops = {
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
+	.supports_subblock_data_units = 1,
 	.legacy_key_prefix_for_backcompat = "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index fb2a74e618a11..1c7484aadcec0 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -84,6 +84,18 @@ struct fscrypt_operations {
 	 */
 	unsigned int has_32bit_inodes : 1;
 
+	/*
+	 * If set, then fs/crypto/ will allow users to select a crypto data unit
+	 * size that is less than the filesystem block size.  This is done via
+	 * the log2_data_unit_size field of the fscrypt policy.  This feature is
+	 * not compatible with filesystems that encrypt variable-length blocks
+	 * (i.e. blocks that aren't all equal to filesystem's block size), for
+	 * example as a result of compression.  Filesystems mustn't set this
+	 * flag if they use fscrypt_encrypt_block_inplace() or
+	 * fscrypt_decrypt_block_inplace().
+	 */
+	unsigned int supports_subblock_data_units : 1;
+
 	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index fd1fb0d5389d3..7a8f4c2901873 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -71,7 +71,8 @@ struct fscrypt_policy_v2 {
 	__u8 contents_encryption_mode;
 	__u8 filenames_encryption_mode;
 	__u8 flags;
-	__u8 __reserved[4];
+	__u8 log2_data_unit_size;
+	__u8 __reserved[3];
 	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
 };
 
-- 
2.42.0

