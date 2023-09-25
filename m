Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506797ACFCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 07:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjIYF77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjIYF7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:59:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B0D1B7;
        Sun, 24 Sep 2023 22:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9010C433C9;
        Mon, 25 Sep 2023 05:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695621540;
        bh=D7Nwy0zbMI1Yfu4euJD/sNBZA0byXF5N//r2wJV0wrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFxytuXhqhr0v+0+8+GjyXBdpIzjA/vFsWoBUoAbdpj9FcanyH9XRvyNy0NyRHaSs
         TxZVVrkUCYx0FtUEYRIVmmBJ7734AQ0byWf4TcnhtPd0bGArhrbMG79u9xak+4iXov
         iJQE/sMx8HsZGZWH1Okhe10ZTflVRr5Ea5Nt+l83YSHTqJKROTAfsl6dbH4NUb4pIv
         HLmbIubElSUXSQ9p9+Haes144tf/JgVyrae5zFt+iaXooO7nfVQki3laTDaZf97fst
         QQoPcSmBOzpXCF89ghq47l9E8koK+DKFSXfoj6WQwr8M4TvvLpuKpAxctKP6fDJr/N
         rzuY3v9L2ISdQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 5/5] fscrypt: support crypto data unit size less than filesystem block size
Date:   Sun, 24 Sep 2023 22:54:51 -0700
Message-ID: <20230925055451.59499-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925055451.59499-1-ebiggers@kernel.org>
References: <20230925055451.59499-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

1. Inline crypto hardware that only supports a crypto data unit size
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
to select a sub-block data unit size.  Supported data unit sizes are
powers of 2 between 512 and the filesystem block size, inclusively.
Support is implemented for both the FS-layer and inline crypto cases.

This patch focuses on the basic support for sub-block data units.  Some
things are out of scope for this patch but may be addressed later:

- Supporting sub-block data units in combination with
  FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64, in most cases.  Unfortunately this
  combination usually causes data unit indices to exceed 32 bits, and
  thus fscrypt_supported_policy() correctly disallows it.  The users who
  potentially need this combination are using f2fs.  To support it, f2fs
  would need to provide an option to slightly reduce its max file size.

- Supporting sub-block data units in combination with
  FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32.  This has the same problem
  described above, but also it will need special code to make DUN
  wraparound still happen on a FS block boundary.

- Supporting use case (2) mentioned above.  The encrypted direct I/O
  code will need to stop requiring and assuming FS block alignment.
  This won't be hard, but it belongs in a separate patch.

- Supporting this feature on filesystems other than ext4 and f2fs.
  (Filesystems declare support for it via their fscrypt_operations.)
  On UBIFS, sub-block data units don't make sense because UBIFS encrypts
  variable-length blocks as a result of compression.  CephFS could
  support it, but a bit more work would be needed to make the
  fscrypt_*_block_inplace functions play nicely with sub-block data
  units.  I don't think there's a use case for this on CephFS anyway.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 117 ++++++++++++++++------
 fs/crypto/bio.c                       |  39 ++++----
 fs/crypto/crypto.c                    | 139 ++++++++++++++------------
 fs/crypto/fscrypt_private.h           |  56 ++++++++---
 fs/crypto/inline_crypt.c              |  14 ++-
 fs/crypto/keysetup.c                  |   5 +
 fs/crypto/policy.c                    |  34 ++++++-
 fs/ext4/crypto.c                      |   1 +
 fs/f2fs/super.c                       |   1 +
 include/linux/fscrypt.h               |  12 +++
 include/uapi/linux/fscrypt.h          |   3 +-
 11 files changed, 288 insertions(+), 133 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index a624e92f2687f..28700fb41a00b 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -254,23 +254,23 @@ significant advantages to key wrapping.  In particular, currently
 there is no requirement to support unlocking a file with multiple
 alternative master keys or to support rotating master keys.  Instead,
 the master keys may be wrapped in userspace, e.g. as is done by the
 `fscrypt <https://github.com/google/fscrypt>`_ tool.
 
 DIRECT_KEY policies
 -------------------
 
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
 this by setting FSCRYPT_POLICY_FLAG_DIRECT_KEY in the fscrypt policy,
 per-file encryption keys are not used.  Instead, whenever any data
 (contents or filenames) is encrypted, the file's 16-byte nonce is
 included in the IV.  Moreover:
 
 - For v1 encryption policies, the encryption is done directly with the
   master key.  Because of this, users **must not** use the same master
@@ -293,22 +293,22 @@ Consequently, shrinking the filesystem may not be allowed.
 
 This format is optimized for use with inline encryption hardware
 compliant with the UFS standard, which supports only 64 IV bits per
 I/O request and may have only a small number of keyslots.
 
 IV_INO_LBLK_32 policies
 -----------------------
 
 IV_INO_LBLK_32 policies work like IV_INO_LBLK_64, except that for
 IV_INO_LBLK_32, the inode number is hashed with SipHash-2-4 (where the
-SipHash key is derived from the master key) and added to the file
-logical block number mod 2^32 to produce a 32-bit IV.
+SipHash key is derived from the master key) and added to the file data
+unit index mod 2^32 to produce a 32-bit IV.
 
 This format is optimized for use with inline encryption hardware
 compliant with the eMMC v5.2 standard, which supports only 32 IV bits
 per I/O request and may have only a small number of keyslots.  This
 format results in some level of IV reuse, so it should only be used
 when necessary due to hardware limitations.
 
 Key identifiers
 ---------------
 
@@ -444,45 +444,76 @@ fscrypt also uses HMAC-SHA512 for key derivation, so enabling SHA-512
 acceleration is recommended:
 
 - SHA-512
     - Recommended:
         - arm64: CONFIG_CRYPTO_SHA512_ARM64_CE
         - x86: CONFIG_CRYPTO_SHA512_SSSE3
 
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
+  to the filesystem block size.  On some filesystems, users can select
+  a sub-block data unit size via the ``log2_data_unit_size`` field of
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
 
 For filenames, each full filename is encrypted at once.  Because of
 the requirements to retain support for efficient directory lookups and
 filenames of up to 255 bytes, the same IV is used for every filename
 in a directory.
 
 However, each encrypted directory still uses a unique key, or
@@ -537,21 +568,22 @@ follows::
     };
     #define fscrypt_policy  fscrypt_policy_v1
 
     #define FSCRYPT_POLICY_V2               2
     #define FSCRYPT_KEY_IDENTIFIER_SIZE     16
     struct fscrypt_policy_v2 {
             __u8 version;
             __u8 contents_encryption_mode;
             __u8 filenames_encryption_mode;
             __u8 flags;
-            __u8 __reserved[4];
+            __u8 log2_data_unit_size;
+            __u8 __reserved[3];
             __u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
     };
 
 This structure must be initialized as follows:
 
 - ``version`` must be FSCRYPT_POLICY_V1 (0) if
   struct fscrypt_policy_v1 is used or FSCRYPT_POLICY_V2 (2) if
   struct fscrypt_policy_v2 is used. (Note: we refer to the original
   policy version as "v1", though its version code is really 0.)
   For new encrypted directories, use v2 policies.
@@ -579,20 +611,43 @@ This structure must be initialized as follows:
     policies`_.
   - FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32: See `IV_INO_LBLK_32
     policies`_.
 
   v1 encryption policies only support the PAD_* and DIRECT_KEY flags.
   The other flags are only supported by v2 encryption policies.
 
   The DIRECT_KEY, IV_INO_LBLK_64, and IV_INO_LBLK_32 flags are
   mutually exclusive.
 
+- ``log2_data_unit_size`` is the log2 of the data unit size in bytes,
+  or 0 to select the default data unit size.  The data unit size is
+  the granularity of file contents encryption.  For example, setting
+  ``log2_data_unit_size`` to 12 causes file contents be passed to the
+  underlying encryption algorithm (such as AES-256-XTS) in 4096-byte
+  data units, each with its own IV.
+
+  Not all filesystems support setting ``log2_data_unit_size``.  ext4
+  and f2fs support it since Linux v6.7.  On filesystems that support
+  it, the supported nonzero values are 9 through the log2 of the
+  filesystem block size, inclusively.  The default value of 0 selects
+  the filesystem block size.
+
+  The main use case for ``log2_data_unit_size`` is for selecting a
+  data unit size smaller than the filesystem block size for
+  compatibility with inline encryption hardware that only supports
+  smaller data unit sizes.  ``/sys/block/$disk/queue/crypto/`` may be
+  useful for checking which data unit sizes are supported by a
+  particular system's inline encryption hardware.
+
+  Leave this field zeroed unless you are certain you need it.  Using
+  an unnecessarily small data unit size reduces performance.
+
 - For v2 encryption policies, ``__reserved`` must be zeroed.
 
 - For v1 encryption policies, ``master_key_descriptor`` specifies how
   to find the master key in a keyring; see `Adding keys`_.  It is up
   to userspace to choose a unique ``master_key_descriptor`` for each
   master key.  The e4crypt and fscrypt tools use the first 8 bytes of
   ``SHA-512(SHA-512(master_key))``, but this particular scheme is not
   required.  Also, the master key need not be in the keyring yet when
   FS_IOC_SET_ENCRYPTION_POLICY is executed.  However, it must be added
   before any files can be created in the encrypted directory.
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 62e1a3dd83574..c8cf77065272e 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -104,41 +104,45 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * filesystem only uses a single block device, ->s_bdev.
  *
  * Note that since each block uses a different IV, this involves writing a
  * different ciphertext to each block; we can't simply reuse the same one.
  *
  * Return: 0 on success; -errno on failure.
  */
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len)
 {
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocksize = 1 << blockbits;
-	const unsigned int blocks_per_page_bits = PAGE_SHIFT - blockbits;
-	const unsigned int blocks_per_page = 1 << blocks_per_page_bits;
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const unsigned int du_bits = ci->ci_data_unit_bits;
+	const unsigned int du_size = 1U << du_bits;
+	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
+	const unsigned int du_per_page = 1U << du_per_page_bits;
+	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
+	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
 	unsigned int i;
 	unsigned int offset;
 	struct bio *bio;
 	int ret, err;
 
 	if (len == 0)
 		return 0;
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return fscrypt_zeroout_range_inline_crypt(inode, lblk, pblk,
 							  len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
-	nr_pages = min_t(unsigned int, ARRAY_SIZE(pages),
-			 (len + blocks_per_page - 1) >> blocks_per_page_bits);
+	nr_pages = min_t(u64, ARRAY_SIZE(pages),
+			 (du_remaining + du_per_page - 1) >> du_per_page_bits);
 
 	/*
 	 * We need at least one page for ciphertext.  Allocate the first one
 	 * from a mempool, with __GFP_DIRECT_RECLAIM set so that it can't fail.
 	 *
 	 * Any additional page allocations are allowed to fail, as they only
 	 * help performance, and waiting on the mempool for them could deadlock.
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = fscrypt_alloc_bounce_page(i == 0 ? GFP_NOFS :
@@ -147,47 +151,48 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			break;
 	}
 	nr_pages = i;
 	if (WARN_ON_ONCE(nr_pages <= 0))
 		return -EINVAL;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
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
 					goto out;
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
 	for (i = 0; i < nr_pages; i++)
 		fscrypt_free_bounce_page(pages[i]);
 	return err;
 }
 EXPORT_SYMBOL(fscrypt_zeroout_range);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index aed0c5ea75781..85e2f66dd663f 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -70,148 +70,150 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
 {
 	if (!bounce_page)
 		return;
 	set_page_private(bounce_page, (unsigned long)NULL);
 	ClearPagePrivate(bounce_page);
 	mempool_free(bounce_page, fscrypt_bounce_page_pool);
 }
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
 
 	if (WARN_ON_ONCE(len <= 0))
 		return -EINVAL;
 	if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
 		return -EINVAL;
 
-	fscrypt_generate_iv(&iv, lblk_num, ci);
+	fscrypt_generate_iv(&iv, index, ci);
 
 	req = skcipher_request_alloc(tfm, gfp_flags);
 	if (!req)
 		return -ENOMEM;
 
 	skcipher_request_set_callback(
 		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
 		crypto_req_done, &wait);
 
 	sg_init_table(&dst, 1);
 	sg_set_page(&dst, dest_page, len, offs);
 	sg_init_table(&src, 1);
 	sg_set_page(&src, src_page, len, offs);
 	skcipher_request_set_crypt(req, &src, &dst, len, &iv);
 	if (rw == FS_DECRYPT)
 		res = crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
 	else
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
  * The bounce page allocation is mempool-backed, so it will always succeed when
  * @gfp_flags includes __GFP_DIRECT_RECLAIM, e.g. when it's GFP_NOFS.  However,
  * only the first page of each bio can be allocated this way.  To prevent
  * deadlocks, for any additional pages a mask like GFP_NOWAIT must be used.
  *
  * Return: the new encrypted bounce page on success; an ERR_PTR() on failure
  */
 struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
 					      unsigned int len,
 					      unsigned int offs,
 					      gfp_t gfp_flags)
 
 {
 	const struct inode *inode = page->mapping->host;
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocksize = 1 << blockbits;
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const unsigned int du_bits = ci->ci_data_unit_bits;
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
 		}
 	}
 	SetPagePrivate(ciphertext_page);
 	set_page_private(ciphertext_page, (unsigned long)page);
 	return ciphertext_page;
 }
 EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
@@ -224,70 +226,74 @@ EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
  *		FSCRYPT_CONTENTS_ALIGNMENT.
  * @offs:      Byte offset within @page at which the block to encrypt begins
  * @lblk_num:  Filesystem logical block number of the block, i.e. the 0-based
  *		number of the block within the file
  * @gfp_flags: Memory allocation flags
  *
  * Encrypt a possibly-compressed filesystem block that is located in an
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
 int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
 				     size_t offs)
 {
 	const struct inode *inode = folio->mapping->host;
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocksize = 1 << blockbits;
-	u64 lblk_num = ((u64)folio->index << (PAGE_SHIFT - blockbits)) +
-		       (offs >> blockbits);
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const unsigned int du_bits = ci->ci_data_unit_bits;
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
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_decrypt_pagecache_blocks);
 
 /**
  * fscrypt_decrypt_block_inplace() - Decrypt a filesystem block in-place
  * @inode:     The inode to which this block belongs
@@ -295,28 +301,33 @@ EXPORT_SYMBOL(fscrypt_decrypt_pagecache_blocks);
  * @len:       Size of block to decrypt.  This must be a multiple of
  *		FSCRYPT_CONTENTS_ALIGNMENT.
  * @offs:      Byte offset within @page at which the block to decrypt begins
  * @lblk_num:  Filesystem logical block number of the block, i.e. the 0-based
  *		number of the block within the file
  *
  * Decrypt a possibly-compressed filesystem block that is located in an
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
 
 /**
  * fscrypt_initialize() - allocate major buffers for fs encryption.
  * @sb: the filesystem superblock
  *
  * We only call this when we start accessing encrypted files, since it
  * results in memory getting allocated that wouldn't otherwise be used.
  *
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 4b113214b53af..9c5e83baa3f12 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -40,21 +40,22 @@ struct fscrypt_context_v1 {
 	u8 flags;
 	u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
 };
 
 struct fscrypt_context_v2 {
 	u8 version; /* FSCRYPT_CONTEXT_V2 */
 	u8 contents_encryption_mode;
 	u8 filenames_encryption_mode;
 	u8 flags;
-	u8 __reserved[4];
+	u8 log2_data_unit_size;
+	u8 __reserved[3];
 	u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
 	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
 };
 
 /*
  * fscrypt_context - the encryption context of an inode
  *
  * This is the on-disk equivalent of an fscrypt_policy, stored alongside each
  * encrypted file usually in a hidden extended attribute.  It contains the
  * fields from the fscrypt_policy, in order to identify the encryption algorithm
@@ -158,20 +159,40 @@ fscrypt_policy_flags(const union fscrypt_policy *policy)
 {
 	switch (policy->version) {
 	case FSCRYPT_POLICY_V1:
 		return policy->v1.flags;
 	case FSCRYPT_POLICY_V2:
 		return policy->v2.flags;
 	}
 	BUG();
 }
 
+static inline int
+fscrypt_policy_v2_du_bits(const struct fscrypt_policy_v2 *policy,
+			  const struct inode *inode)
+{
+	return policy->log2_data_unit_size ?: inode->i_blkbits;
+}
+
+static inline int
+fscrypt_policy_du_bits(const union fscrypt_policy *policy,
+		       const struct inode *inode)
+{
+	switch (policy->version) {
+	case FSCRYPT_POLICY_V1:
+		return inode->i_blkbits;
+	case FSCRYPT_POLICY_V2:
+		return fscrypt_policy_v2_du_bits(&policy->v2, inode);
+	}
+	BUG();
+}
+
 /*
  * For encrypted symlinks, the ciphertext length is stored at the beginning
  * of the string in little-endian format.
  */
 struct fscrypt_symlink_data {
 	__le16 len;
 	char encrypted_path[];
 } __packed;
 
 /**
@@ -204,20 +225,30 @@ struct fscrypt_info {
 	bool ci_owns_key;
 
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 	/*
 	 * True if this inode will use inline encryption (blk-crypto) instead of
 	 * the traditional filesystem-layer encryption.
 	 */
 	bool ci_inlinecrypt;
 #endif
 
+	/*
+	 * log2 of the data unit size (granularity of contents encryption) of
+	 * this file.  This is computable from ci_policy and ci_inode but is
+	 * cached here for efficiency.  Only used for regular files.
+	 */
+	u8 ci_data_unit_bits;
+
+	/* Cached value: log2 of number of data units per FS block */
+	u8 ci_data_units_per_block_bits;
+
 	/*
 	 * Encryption mode used for this inode.  It corresponds to either the
 	 * contents or filenames encryption mode, depending on the inode type.
 	 */
 	struct fscrypt_mode *ci_mode;
 
 	/* Back-pointer to the inode */
 	struct inode *ci_inode;
 
 	/*
@@ -258,59 +289,60 @@ struct fscrypt_info {
 };
 
 typedef enum {
 	FS_DECRYPT = 0,
 	FS_ENCRYPT,
 } fscrypt_direction_t;
 
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
 fscrypt_msg(const struct inode *inode, const char *level, const char *fmt, ...);
 
 #define fscrypt_warn(inode, fmt, ...)		\
 	fscrypt_msg((inode), KERN_WARNING, fmt, ##__VA_ARGS__)
 #define fscrypt_err(inode, fmt, ...)		\
 	fscrypt_msg((inode), KERN_ERR, fmt, ##__VA_ARGS__)
 
 #define FSCRYPT_MAX_IV_SIZE	32
 
 union fscrypt_iv {
 	struct {
-		/* logical block number within the file */
-		__le64 lblk_num;
+		/* zero-based index of data unit within the file */
+		__le64 index;
 
 		/* per-file nonce; only set in DIRECT_KEY mode */
 		u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
 	};
 	u8 raw[FSCRYPT_MAX_IV_SIZE];
 	__le64 dun[FSCRYPT_MAX_IV_SIZE / sizeof(__le64)];
 };
 
-void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
+void fscrypt_generate_iv(union fscrypt_iv *iv, u64 index,
 			 const struct fscrypt_info *ci);
 
 /*
- * Return the number of bits used by the maximum file logical block number that
- * is possible on the given filesystem.
+ * Return the number of bits used by the maximum file data unit index that is
+ * possible on the given filesystem, using the given log2 data unit size.
  */
 static inline int
-fscrypt_max_file_lblk_bits(const struct super_block *sb)
+fscrypt_max_file_dun_bits(const struct super_block *sb, int du_bits)
 {
-	return fls64(sb->s_maxbytes - 1) - sb->s_blocksize_bits;
+	return fls64(sb->s_maxbytes - 1) - du_bits;
 }
 
 /* fname.c */
 bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				    u32 orig_len, u32 max_len,
 				    u32 *encrypted_len_ret);
 
 /* hkdf.c */
 struct fscrypt_hkdf {
 	struct crypto_shash *hmac_tfm;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 7d9f6c167de58..8c6d37d6225a8 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -36,32 +36,34 @@ static struct block_device **fscrypt_get_devices(struct super_block *sb,
 		return ERR_PTR(-ENOMEM);
 	devs[0] = sb->s_bdev;
 	*num_devs = 1;
 	return devs;
 }
 
 static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 {
 	const struct super_block *sb = ci->ci_inode->i_sb;
 	unsigned int flags = fscrypt_policy_flags(&ci->ci_policy);
+	int dun_bits;
 
 	if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return offsetofend(union fscrypt_iv, nonce);
 
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64)
 		return sizeof(__le64);
 
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)
 		return sizeof(__le32);
 
-	/* Default case: IVs are just the file logical block number */
-	return DIV_ROUND_UP(fscrypt_max_file_lblk_bits(sb), 8);
+	/* Default case: IVs are just the file data unit index */
+	dun_bits = fscrypt_max_file_dun_bits(sb, ci->ci_data_unit_bits);
+	return DIV_ROUND_UP(dun_bits, 8);
 }
 
 /*
  * Log a message when starting to use blk-crypto (native) or blk-crypto-fallback
  * for an encryption mode for the first time.  This is the blk-crypto
  * counterpart to the message logged when starting to use the crypto API for the
  * first time.  A limitation is that these messages don't convey which specific
  * filesystems or files are using each implementation.  However, *usually*
  * systems use just one implementation per mode, which makes these messages
  * helpful for debugging problems where the "wrong" implementation is used.
@@ -119,21 +121,21 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	if ((fscrypt_policy_flags(&ci->ci_policy) &
 	     FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
 	    sb->s_blocksize != PAGE_SIZE)
 		return 0;
 
 	/*
 	 * On all the filesystem's block devices, blk-crypto must support the
 	 * crypto configuration that the file would use.
 	 */
 	crypto_cfg.crypto_mode = ci->ci_mode->blk_crypto_mode;
-	crypto_cfg.data_unit_size = sb->s_blocksize;
+	crypto_cfg.data_unit_size = 1U << ci->ci_data_unit_bits;
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
 
 	devs = fscrypt_get_devices(sb, &num_devs);
 	if (IS_ERR(devs))
 		return PTR_ERR(devs);
 
 	for (i = 0; i < num_devs; i++) {
 		if (!blk_crypto_config_supported(devs[i], &crypto_cfg))
 			goto out_free_devs;
 	}
@@ -158,21 +160,22 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	struct block_device **devs;
 	unsigned int num_devs;
 	unsigned int i;
 	int err;
 
 	blk_key = kmalloc(sizeof(*blk_key), GFP_KERNEL);
 	if (!blk_key)
 		return -ENOMEM;
 
 	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
-				  fscrypt_get_dun_bytes(ci), sb->s_blocksize);
+				  fscrypt_get_dun_bytes(ci),
+				  1U << ci->ci_data_unit_bits);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
 	}
 
 	/* Start using blk-crypto on all the filesystem's block devices. */
 	devs = fscrypt_get_devices(sb, &num_devs);
 	if (IS_ERR(devs)) {
 		err = PTR_ERR(devs);
 		goto fail;
@@ -225,24 +228,25 @@ void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
 	return inode->i_crypt_info->ci_inlinecrypt;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
 static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
 				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
 {
+	u64 index = lblk_num << ci->ci_data_units_per_block_bits;
 	union fscrypt_iv iv;
 	int i;
 
-	fscrypt_generate_iv(&iv, lblk_num, ci);
+	fscrypt_generate_iv(&iv, index, ci);
 
 	BUILD_BUG_ON(FSCRYPT_MAX_IV_SIZE > BLK_CRYPTO_MAX_IV_SIZE);
 	memset(dun, 0, BLK_CRYPTO_MAX_IV_SIZE);
 	for (i = 0; i < ci->ci_mode->ivsize/sizeof(dun[0]); i++)
 		dun[i] = le64_to_cpu(iv.dun[i]);
 }
 
 /**
  * fscrypt_set_bio_crypt_ctx() - prepare a file contents bio for inline crypto
  * @bio: a bio which will eventually be submitted to the file
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 361f41ef46c78..608599f8aa574 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -573,20 +573,25 @@ fscrypt_setup_encryption_info(struct inode *inode,
 	memcpy(crypt_info->ci_nonce, nonce, FSCRYPT_FILE_NONCE_SIZE);
 
 	mode = select_encryption_mode(&crypt_info->ci_policy, inode);
 	if (IS_ERR(mode)) {
 		res = PTR_ERR(mode);
 		goto out;
 	}
 	WARN_ON_ONCE(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
 	crypt_info->ci_mode = mode;
 
+	crypt_info->ci_data_unit_bits =
+		fscrypt_policy_du_bits(&crypt_info->ci_policy, inode);
+	crypt_info->ci_data_units_per_block_bits =
+		inode->i_blkbits - crypt_info->ci_data_unit_bits;
+
 	res = setup_file_encryption_key(crypt_info, need_dirhash_key, &mk);
 	if (res)
 		goto out;
 
 	/*
 	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
 	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
 	 * fscrypt_get_info().  I.e., here we publish ->i_crypt_info with a
 	 * RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 32709dad9762b..2fb3f6a1258e0 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -158,24 +158,25 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 	 * So for now the implementation limit is 32 bits.
 	 */
 	if (!sb->s_cop->has_32bit_inodes) {
 		fscrypt_warn(inode,
 			     "Can't use %s policy on filesystem '%s' because its inode numbers are too long",
 			     type, sb->s_id);
 		return false;
 	}
 
 	/*
-	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file logical
-	 * block numbers fit in 32 bits.
+	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file data unit
+	 * indices fit in 32 bits.
 	 */
-	if (fscrypt_max_file_lblk_bits(sb) > 32) {
+	if (fscrypt_max_file_dun_bits(sb,
+			fscrypt_policy_v2_du_bits(policy, inode)) > 32) {
 		fscrypt_warn(inode,
 			     "Can't use %s policy on filesystem '%s' because its maximum file size is too large",
 			     type, sb->s_id);
 		return false;
 	}
 	return true;
 }
 
 static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 					const struct inode *inode)
@@ -236,20 +237,45 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 
 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64);
 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32);
 	if (count > 1) {
 		fscrypt_warn(inode, "Mutually exclusive encryption flags (0x%02x)",
 			     policy->flags);
 		return false;
 	}
 
+	if (policy->log2_data_unit_size) {
+		if (!inode->i_sb->s_cop->supports_subblock_data_units) {
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
+		if (policy->log2_data_unit_size != inode->i_blkbits &&
+		    (policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)) {
+			/*
+			 * Not safe to enable yet, as we need to ensure that DUN
+			 * wraparound can only occur on a FS block boundary.
+			 */
+			fscrypt_warn(inode,
+				     "Sub-block data units not yet supported with IV_INO_LBLK_32");
+			return false;
+		}
+	}
+
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
 					policy->filenames_encryption_mode))
 		return false;
 
 	if ((policy->flags & (FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 |
 			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)) &&
 	    !supported_iv_ino_lblk_policy(policy, inode))
 		return false;
 
@@ -322,20 +348,21 @@ static int fscrypt_new_context(union fscrypt_context *ctx_u,
 	case FSCRYPT_POLICY_V2: {
 		const struct fscrypt_policy_v2 *policy = &policy_u->v2;
 		struct fscrypt_context_v2 *ctx = &ctx_u->v2;
 
 		ctx->version = FSCRYPT_CONTEXT_V2;
 		ctx->contents_encryption_mode =
 			policy->contents_encryption_mode;
 		ctx->filenames_encryption_mode =
 			policy->filenames_encryption_mode;
 		ctx->flags = policy->flags;
+		ctx->log2_data_unit_size = policy->log2_data_unit_size;
 		memcpy(ctx->master_key_identifier,
 		       policy->master_key_identifier,
 		       sizeof(ctx->master_key_identifier));
 		memcpy(ctx->nonce, nonce, FSCRYPT_FILE_NONCE_SIZE);
 		return sizeof(*ctx);
 	}
 	}
 	BUG();
 }
 
@@ -382,20 +409,21 @@ int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
 	case FSCRYPT_CONTEXT_V2: {
 		const struct fscrypt_context_v2 *ctx = &ctx_u->v2;
 		struct fscrypt_policy_v2 *policy = &policy_u->v2;
 
 		policy->version = FSCRYPT_POLICY_V2;
 		policy->contents_encryption_mode =
 			ctx->contents_encryption_mode;
 		policy->filenames_encryption_mode =
 			ctx->filenames_encryption_mode;
 		policy->flags = ctx->flags;
+		policy->log2_data_unit_size = ctx->log2_data_unit_size;
 		memcpy(policy->__reserved, ctx->__reserved,
 		       sizeof(policy->__reserved));
 		memcpy(policy->master_key_identifier,
 		       ctx->master_key_identifier,
 		       sizeof(policy->master_key_identifier));
 		return 0;
 	}
 	}
 	/* unreachable */
 	return -EINVAL;
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 9e36731701baa..7ae0b61258a7f 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -228,17 +228,18 @@ static const union fscrypt_policy *ext4_get_dummy_policy(struct super_block *sb)
 }
 
 static bool ext4_has_stable_inodes(struct super_block *sb)
 {
 	return ext4_has_feature_stable_inodes(sb);
 }
 
 const struct fscrypt_operations ext4_cryptops = {
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
+	.supports_subblock_data_units = 1,
 	.legacy_key_prefix	= "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
 	.get_dummy_policy	= ext4_get_dummy_policy,
 	.empty_dir		= ext4_empty_dir,
 	.has_stable_inodes	= ext4_has_stable_inodes,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c449157132643..66a5bf4216b71 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3219,20 +3219,21 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 
 	for (i = 0; i < sbi->s_ndevs; i++)
 		devs[i] = FDEV(i).bdev;
 	*num_devs = sbi->s_ndevs;
 	return devs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
+	.supports_subblock_data_units = 1,
 	.legacy_key_prefix	= "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
 	.get_dummy_policy	= f2fs_get_dummy_policy,
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_devices		= f2fs_get_devices,
 };
 #endif
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 09a3cacbf62ad..b559e6f777070 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -78,20 +78,32 @@ struct fscrypt_operations {
 	 * If set, then fs/crypto/ will allow the use of encryption settings
 	 * that assume inode numbers fit in 32 bits (i.e.
 	 * FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64}), provided that the other
 	 * prerequisites for these settings are also met.  This is only useful
 	 * if the filesystem wants to support inline encryption hardware that is
 	 * limited to 32-bit or 64-bit data unit numbers and where programming
 	 * keyslots is very slow.
 	 */
 	unsigned int has_32bit_inodes : 1;
 
+	/*
+	 * If set, then fs/crypto/ will allow users to select a crypto data unit
+	 * size that is less than the filesystem block size.  This is done via
+	 * the log2_data_unit_size field of the fscrypt policy.  This flag is
+	 * not compatible with filesystems that encrypt variable-length blocks
+	 * (i.e. blocks that aren't all equal to filesystem's block size), for
+	 * example as a result of compression.  It's also not compatible with
+	 * the fscrypt_encrypt_block_inplace() and
+	 * fscrypt_decrypt_block_inplace() functions.
+	 */
+	unsigned int supports_subblock_data_units : 1;
+
 	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It
 	 * contains the filesystem-specific key description prefix that is
 	 * accepted for "logon" keys for v1 fscrypt policies.  This
 	 * functionality is deprecated in favor of the generic prefix
 	 * "fscrypt:", which itself is deprecated in favor of the filesystem
 	 * keyring ioctls such as FS_IOC_ADD_ENCRYPTION_KEY.  Filesystems that
 	 * are newly adding fscrypt support should not set this field.
 	 */
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index fd1fb0d5389d3..7a8f4c2901873 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -64,21 +64,22 @@ struct fscrypt_key {
 /*
  * New policy version with HKDF and key verification (recommended).
  */
 #define FSCRYPT_POLICY_V2		2
 #define FSCRYPT_KEY_IDENTIFIER_SIZE	16
 struct fscrypt_policy_v2 {
 	__u8 version;
 	__u8 contents_encryption_mode;
 	__u8 filenames_encryption_mode;
 	__u8 flags;
-	__u8 __reserved[4];
+	__u8 log2_data_unit_size;
+	__u8 __reserved[3];
 	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
 };
 
 /* Struct passed to FS_IOC_GET_ENCRYPTION_POLICY_EX */
 struct fscrypt_get_policy_ex_arg {
 	__u64 policy_size; /* input/output */
 	union {
 		__u8 version;
 		struct fscrypt_policy_v1 v1;
 		struct fscrypt_policy_v2 v2;
-- 
2.42.0

