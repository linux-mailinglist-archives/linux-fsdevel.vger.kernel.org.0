Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB444A0457
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 00:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiA1XkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 18:40:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47534 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiA1XkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:40:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBF6B61DD5;
        Fri, 28 Jan 2022 23:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01578C340FA;
        Fri, 28 Jan 2022 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413203;
        bh=oM29BnV9ToRiA87Xa8vy8Ps9akFPyNK8+ftmkwPDABQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByH2OKYnBLJShtun1wY2/hje/k3qpSBktCbkbBFhJt+I1eDSwYZWhncN+2YEBotgp
         UieLA//E4zlEzUBKKNk1wboM8vHakppCj1SxDrPiZJ8gaxbWvhjA3Ir/ks+dpkFEqF
         VdiJpDiUSsdUlzylaZgoSJc4u0Km2ZB7ynv7ytUoeRp5HGW9d39cp7+t0VStVRxLdM
         R5g4Hel17nV1LzVP9xq+LXqrArP2ONxbnIefYXlqmhwLrGa4FkAF8wmYalUlyoLPnH
         uimhJD1dOK94KVt8Zhj1wwvVIozrMrt/b5kACue/LgRmkRRy9yn2Z3AbOd+wQ5t4uX
         MNMGudgBTVO+g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v11 3/5] ext4: support direct I/O with fscrypt using blk-crypto
Date:   Fri, 28 Jan 2022 15:39:38 -0800
Message-Id: <20220128233940.79464-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128233940.79464-1-ebiggers@kernel.org>
References: <20220128233940.79464-1-ebiggers@kernel.org>
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

- Let DIO proceed when supported, by checking fscrypt_dio_supported()
  instead of assuming that encrypted files never support DIO.

- In ext4_iomap_begin(), use fscrypt_limit_io_blocks() to limit the
  length of the mapping in the rare case where a DUN discontiguity
  occurs in the middle of an extent.  The iomap DIO implementation
  requires this, since it assumes that it can submit a bio covering (up
  to) the whole mapping, without checking fscrypt constraints itself.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/file.c  | 10 ++++++----
 fs/ext4/inode.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8cc11715518ac..8bd66cdc41be2 100644
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
+	if (!fscrypt_dio_supported(iocb, iter))
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
2.35.0

