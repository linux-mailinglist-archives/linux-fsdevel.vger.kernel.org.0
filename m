Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0986F49481B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358986AbiATHQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358963AbiATHQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F6C061574;
        Wed, 19 Jan 2022 23:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D593CE1FFE;
        Thu, 20 Jan 2022 07:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E14C340EF;
        Thu, 20 Jan 2022 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642662975;
        bh=uVj1c8LpzrOMIafyi1Y9BE84r5VGaLUz8mtiVeWL7Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ad1EEixYJg4EzYsY4I7YdGlRV5zEpaWGSQqpm0KdN+F6YDMbVFJkbugFsizhGp2dV
         6BDVee4niP/qVIr0nS8VL9Jy2QpHO+USAPbFlw+e10QcBeG8ej6sz+lrsuaBJZuNh2
         Zw+nAD1Al7HeGkHWfwKxpZN2mCQKM93n416hqymbZLFPuHGZQ2y1HMBvvPOob1LGyW
         dyeIjma0u8GAjbyIwjd2h/6Vgjuv6EarWKTgW9jxgpO+G+k2u0YbHALPF168qRt++U
         EG60d3grANejWoomnSZNeTCtFCiqe9MPDQ5BsjYI1n3Vy0bdY/AEzCdacgLBPogqgt
         pUiNhJxhXg3ew==
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
Subject: [PATCH v10 3/5] ext4: support direct I/O with fscrypt using blk-crypto
Date:   Wed, 19 Jan 2022 23:12:13 -0800
Message-Id: <20220120071215.123274-4-ebiggers@kernel.org>
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

Therefore, make ext4 support DIO on files that are using inline
encryption.  Since ext4 uses iomap for DIO, and fscrypt support was
already added to iomap DIO, this just requires two small changes:

- Let DIO proceed when supported, by using fscrypt_dio_unsupported()
  instead of assuming that encrypted files never support DIO.

- In ext4_iomap_begin(), use fscrypt_limit_io_blocks() to limit the
  length of the mapping in the rare case where a DUN discontiguity
  occurs in the middle of an extent.  The iomap DIO implementation
  requires this, since it assumes that it can submit a bio covering (up
  to) the whole mapping, without checking fscrypt constraints itself.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/file.c  | 10 ++++++----
 fs/ext4/inode.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8cc11715518ac..2b520e99bee74 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -36,9 +36,11 @@
 #include "acl.h"
 #include "truncate.h"
 
-static bool ext4_dio_supported(struct inode *inode)
+static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
 {
-	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (fscrypt_dio_unsupported(iocb, iter))
 		return false;
 	if (fsverity_active(inode))
 		return false;
@@ -61,7 +63,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 	}
 
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, to)) {
 		inode_unlock_shared(inode);
 		/*
 		 * Fallback to buffered I/O if the operation being performed on
@@ -509,7 +511,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Fallback to buffered I/O if the inode does not support direct I/O. */
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, from)) {
 		if (ilock_shared)
 			inode_unlock_shared(inode);
 		else
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5f79d265d06a0..7af1bba34b8b8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3409,6 +3409,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 out:
+	/*
+	 * When inline encryption is enabled, sometimes I/O to an encrypted file
+	 * has to be broken up to guarantee DUN contiguity.  Handle this by
+	 * limiting the length of the mapping returned.
+	 */
+	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
+
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 
 	return 0;
-- 
2.34.1

