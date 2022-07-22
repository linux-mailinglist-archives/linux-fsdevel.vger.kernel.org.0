Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CA57DAF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGVHOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiGVHOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:14:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59C951C5;
        Fri, 22 Jul 2022 00:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B13A8B8275D;
        Fri, 22 Jul 2022 07:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34631C36AF5;
        Fri, 22 Jul 2022 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658474043;
        bh=bUzs92DVo2pxGoJONrUnYF4b3YML6KUBgaBW3XjvwlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K99wkBlnFBxvWHrfMBlXbRWiyfaOUw3vDa5fRW5bWdMSqu3e54SarWdupUs+Sneb0
         kHz/pk40SNf1ucZDi4n47DOSLqzMhQVOVfEIaOA2JwvicyeCeAVstAGvLYAN2ujpry
         7YL0ps7ojz1JgGjPfL3rAl3Q4LUn32/uqClb8xQ4dckuw/8sTr3L1xPmLLGlEYliww
         C+HtZ+cp8ilhC57nG6NS1TUF+KCd0+u1siqPcihE2533dAKkmWjXDJoZu9oQXpmgRY
         DMe0XdBqh1YUkCksU0avuHIOreDCPCwEHQXMdXm6pFsSU0hgKNxYnuJC8E0PE4VLYS
         zg4PM/P4Hh4Sw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 3/9] fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
Date:   Fri, 22 Jul 2022 00:12:22 -0700
Message-Id: <20220722071228.146690-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

To prepare for STATX_DIOALIGN support, make two changes to
fscrypt_dio_supported().

First, remove the filesystem-block-alignment check and make the
filesystems handle it instead.  It previously made sense to have it in
fs/crypto/; however, to support STATX_DIOALIGN the alignment restriction
would have to be returned to filesystems.  It ends up being simpler if
filesystems handle this part themselves, especially for f2fs which only
allows fs-block-aligned DIO in the first place.

Second, make fscrypt_dio_supported() work on inodes whose encryption key
hasn't been set up yet, by making it set up the key if needed.  This is
required for statx(), since statx() doesn't require a file descriptor.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/inline_crypt.c | 49 ++++++++++++++++++++--------------------
 fs/ext4/file.c           |  9 ++++++--
 fs/f2fs/f2fs.h           |  2 +-
 include/linux/fscrypt.h  |  7 ++----
 4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 90f3e68f166e39..8d4bee5bccbf42 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -401,46 +401,45 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
 
 /**
- * fscrypt_dio_supported() - check whether a DIO (direct I/O) request is
- *			     supported as far as encryption is concerned
- * @iocb: the file and position the I/O is targeting
- * @iter: the I/O data segment(s)
+ * fscrypt_dio_supported() - check whether DIO (direct I/O) is supported on an
+ *			     inode, as far as encryption is concerned
+ * @inode: the inode in question
  *
  * Return: %true if there are no encryption constraints that prevent DIO from
  *	   being supported; %false if DIO is unsupported.  (Note that in the
  *	   %true case, the filesystem might have other, non-encryption-related
- *	   constraints that prevent DIO from actually being supported.)
+ *	   constraints that prevent DIO from actually being supported.  Also, on
+ *	   encrypted files the filesystem is still responsible for only allowing
+ *	   DIO when requests are filesystem-block-aligned.)
  */
-bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
+bool fscrypt_dio_supported(struct inode *inode)
 {
-	const struct inode *inode = file_inode(iocb->ki_filp);
-	const unsigned int blocksize = i_blocksize(inode);
+	int err;
 
 	/* If the file is unencrypted, no veto from us. */
 	if (!fscrypt_needs_contents_encryption(inode))
 		return true;
 
-	/* We only support DIO with inline crypto, not fs-layer crypto. */
-	if (!fscrypt_inode_uses_inline_crypto(inode))
-		return false;
-
 	/*
-	 * Since the granularity of encryption is filesystem blocks, the file
-	 * position and total I/O length must be aligned to the filesystem block
-	 * size -- not just to the block device's logical block size as is
-	 * traditionally the case for DIO on many filesystems.
+	 * We only support DIO with inline crypto, not fs-layer crypto.
 	 *
-	 * We require that the user-provided memory buffers be filesystem block
-	 * aligned too.  It is simpler to have a single alignment value required
-	 * for all properties of the I/O, as is normally the case for DIO.
-	 * Also, allowing less aligned buffers would imply that data units could
-	 * cross bvecs, which would greatly complicate the I/O stack, which
-	 * assumes that bios can be split at any bvec boundary.
+	 * To determine whether the inode is using inline crypto, we have to set
+	 * up the key if it wasn't already done.  This is because in the current
+	 * design of fscrypt, the decision of whether to use inline crypto or
+	 * not isn't made until the inode's encryption key is being set up.  In
+	 * the DIO read/write case, the key will always be set up already, since
+	 * the file will be open.  But in the case of statx(), the key might not
+	 * be set up yet, as the file might not have been opened yet.
 	 */
-	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), blocksize))
+	err = fscrypt_require_key(inode);
+	if (err) {
+		/*
+		 * Key unavailable or couldn't be set up.  This edge case isn't
+		 * worth worrying about; just report that DIO is unsupported.
+		 */
 		return false;
-
-	return true;
+	}
+	return fscrypt_inode_uses_inline_crypto(inode);
 }
 EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 109d07629f81fb..26d7426208970d 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -40,8 +40,13 @@ static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (!fscrypt_dio_supported(iocb, iter))
-		return false;
+	if (IS_ENCRYPTED(inode)) {
+		if (!fscrypt_dio_supported(inode))
+			return false;
+		if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
+				i_blocksize(inode)))
+			return false;
+	}
 	if (fsverity_active(inode))
 		return false;
 	if (ext4_should_journal_data(inode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d22a..7869e749700fc2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4453,7 +4453,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (!fscrypt_dio_supported(iocb, iter))
+	if (!fscrypt_dio_supported(inode))
 		return true;
 	if (fsverity_active(inode))
 		return true;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e60d57c99cb6f2..0f9f5ed5b34d35 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -763,7 +763,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh);
 
-bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter);
+bool fscrypt_dio_supported(struct inode *inode);
 
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks);
 
@@ -796,11 +796,8 @@ static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
 	return true;
 }
 
-static inline bool fscrypt_dio_supported(struct kiocb *iocb,
-					 struct iov_iter *iter)
+static inline bool fscrypt_dio_supported(struct inode *inode)
 {
-	const struct inode *inode = file_inode(iocb->ki_filp);
-
 	return !fscrypt_needs_contents_encryption(inode);
 }
 
-- 
2.37.0

