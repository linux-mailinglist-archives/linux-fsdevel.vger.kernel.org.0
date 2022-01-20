Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2649480D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358968AbiATHQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52854 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiATHQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0500B81902;
        Thu, 20 Jan 2022 07:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7C0C340E9;
        Thu, 20 Jan 2022 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642662974;
        bh=AisQShPpFV3Eliyeb/P+Zfoyyi9GVLa7kPFiEZALl0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHAvIpo1+755z5fv7ooM7Nesr4mQJSyaBUqw8X6GRahDTVAr1bAMg5yTVoE+3z8Xq
         Eb2PU+2Mq4r6EUCZayEIC7VKcw/9UJovPV8pt1f/K2jRVa2KGSTYVmzUdS/RZw7mdX
         NDUz3XkTnhsSfwHJWuuctR3i9DPzzEd9x8KhMwD9b/uerU6kCSD5NO/RN8satfzmQ6
         u+NF61eQFHva2iPADFlVLnjoSQ1G4/z1HBfUexL8UPjIuDC7xcj4zFcSAeBoxbdTN8
         YeNlqI95xW6mPlzucXxAdGclB62r0wc/TyJSDNeyawGapMu4LwmbAIwBl8qA1x60fI
         ZFUpTsHtfOIGA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v10 1/5] fscrypt: add functions for direct I/O support
Date:   Wed, 19 Jan 2022 23:12:11 -0800
Message-Id: <20220120071215.123274-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120071215.123274-1-ebiggers@kernel.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Encrypted files traditionally haven't supported DIO, due to the need to
encrypt/decrypt the data.  However, when the encryption is implemented
using inline encryption (blk-crypto) instead of the traditional
filesystem-layer encryption, it is straightforward to support DIO.

In preparation for supporting this, add the following functions:

- fscrypt_dio_unsupported() checks whether a DIO request is unsupported
  due to encryption constraints.  Encrypted files will only support DIO
  when inline encryption is used and the I/O request is properly
  aligned; this function checks these preconditions.

- fscrypt_limit_io_blocks() limits the length of a bio to avoid crossing
  a place in the file that a bio with an encryption context cannot
  cross due to a DUN discontiguity.  This function is needed by
  filesystems that use the iomap DIO implementation (which operates
  directly on logical ranges, so it won't use fscrypt_mergeable_bio())
  and that support FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c       |  8 ++++
 fs/crypto/inline_crypt.c | 90 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscrypt.h  | 18 ++++++++
 3 files changed, 116 insertions(+)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 4ef3f714046aa..4fcca79f39aeb 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -69,6 +69,14 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
 }
 EXPORT_SYMBOL(fscrypt_free_bounce_page);
 
+/*
+ * Generate the IV for the given logical block number within the given file.
+ * For filenames encryption, lblk_num == 0.
+ *
+ * Keep this in sync with fscrypt_limit_io_blocks().  fscrypt_limit_io_blocks()
+ * needs to know about any IV generation methods where the low bits of IV don't
+ * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
+ */
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci)
 {
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index c57bebfa48fea..304ae414cbbf2 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -17,6 +17,7 @@
 #include <linux/buffer_head.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
+#include <linux/uio.h>
 
 #include "fscrypt_private.h"
 
@@ -315,6 +316,10 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
  *
  * fscrypt_set_bio_crypt_ctx() must have already been called on the bio.
  *
+ * This function isn't required in cases where crypto-mergeability is ensured in
+ * another way, such as I/O targeting only a single file (and thus a single key)
+ * combined with fscrypt_limit_io_blocks() to ensure DUN contiguity.
+ *
  * Return: true iff the I/O is mergeable
  */
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
@@ -363,3 +368,88 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
 	return fscrypt_mergeable_bio(bio, inode, next_lblk);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
+
+/**
+ * fscrypt_dio_unsupported() - check whether a DIO (direct I/O) request is
+ *			       unsupported due to encryption constraints
+ * @iocb: the file and position the I/O is targeting
+ * @iter: the I/O data segment(s)
+ *
+ * Return: true if DIO is unsupported
+ */
+bool fscrypt_dio_unsupported(struct kiocb *iocb, struct iov_iter *iter)
+{
+	const struct inode *inode = file_inode(iocb->ki_filp);
+	const unsigned int blocksize = i_blocksize(inode);
+
+	/* If the file is unencrypted, no veto from us. */
+	if (!fscrypt_needs_contents_encryption(inode))
+		return false;
+
+	/* We only support DIO with inline crypto, not fs-layer crypto. */
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return true;
+
+	/*
+	 * Since the granularity of encryption is filesystem blocks, the file
+	 * position and total I/O length must be aligned to the filesystem block
+	 * size -- not just to the block device's logical block size as is
+	 * traditionally the case for DIO on many filesystems (not including
+	 * f2fs, which only allows filesystem block aligned DIO anyway).
+	 *
+	 * We also require that the user-provided memory buffers be block
+	 * aligned too.  It is simpler to have a single alignment value required
+	 * for all properties of the I/O, as is normally the case for DIO.
+	 * Also, allowing less aligned buffers would also imply that a data unit
+	 * could cross bvecs, which would greatly complicate the I/O stack,
+	 * which assumes that bios can be split at any bvec boundary.
+	 */
+	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), blocksize))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(fscrypt_dio_unsupported);
+
+/**
+ * fscrypt_limit_io_blocks() - limit I/O blocks to avoid discontiguous DUNs
+ * @inode: the file on which I/O is being done
+ * @lblk: the block at which the I/O is being started from
+ * @nr_blocks: the number of blocks we want to submit starting at @lblk
+ *
+ * Determine the limit to the number of blocks that can be submitted in a bio
+ * targeting @lblk without causing a data unit number (DUN) discontiguity.
+ *
+ * This is normally just @nr_blocks, as normally the DUNs just increment along
+ * with the logical blocks.  (Or the file is not encrypted.)
+ *
+ * In rare cases, fscrypt can be using an IV generation method that allows the
+ * DUN to wrap around within logically contiguous blocks, and that wraparound
+ * will occur.  If this happens, a value less than @nr_blocks will be returned
+ * so that the wraparound doesn't occur in the middle of a bio, which would
+ * cause encryption/decryption to produce the wrong results.
+ *
+ * Return: the actual number of blocks that can be submitted
+ */
+u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
+{
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	u32 dun;
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return nr_blocks;
+
+	if (nr_blocks <= 1)
+		return nr_blocks;
+
+	if (!(fscrypt_policy_flags(&ci->ci_policy) &
+	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
+		return nr_blocks;
+
+	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
+
+	dun = ci->ci_hashed_ino + lblk;
+
+	return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
+}
+EXPORT_SYMBOL_GPL(fscrypt_limit_io_blocks);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 91ea9477e9bd2..87ec5f63b0a82 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -714,6 +714,10 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh);
 
+bool fscrypt_dio_unsupported(struct kiocb *iocb, struct iov_iter *iter);
+
+u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks);
+
 #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
@@ -742,6 +746,20 @@ static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
 {
 	return true;
 }
+
+static inline bool fscrypt_dio_unsupported(struct kiocb *iocb,
+					   struct iov_iter *iter)
+{
+	const struct inode *inode = file_inode(iocb->ki_filp);
+
+	return fscrypt_needs_contents_encryption(inode);
+}
+
+static inline u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk,
+					  u64 nr_blocks)
+{
+	return nr_blocks;
+}
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 /**
-- 
2.34.1

