Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0D494818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358940AbiATHQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358967AbiATHQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3DC06173F;
        Wed, 19 Jan 2022 23:16:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8505CE2002;
        Thu, 20 Jan 2022 07:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0133C36AED;
        Thu, 20 Jan 2022 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642662976;
        bh=ph1/Sf1vAvLLnRVPqg6wcJR3tN5BBAVSOQUtRJJNGMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEPkK4BaFjBz70Y77oE3Qz6BW4JjuUpQr3QPpjgTGrUftG6cUSu2XXDNdX2YiPx45
         3j+SuaGWHfhV+nCpaXv47duc8jsIY4qaCTQIpKU8bCeawShrhATjhGiZ9H4iHz0mIu
         DHKuL/OouUZwqvKs1aVKPqghNls/dgi+YOhMCIatSEOm1F7y/BNpGEQmiwGVzekvZg
         hF7SbbMoniCYZ6E24FCN/iHqYUrP4vyZb0zJ6S9itfptYhjLpTw9ZRbTjXLJdi5REr
         RT54antUOb3MbXKXEiksFxiHI0dd7Caxw2vOXbhHAqoSl/6pRFnltu9ZcWD6UiX06m
         Wfv1vbfNZBnig==
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
Subject: [PATCH v10 4/5] f2fs: support direct I/O with fscrypt using blk-crypto
Date:   Wed, 19 Jan 2022 23:12:14 -0800
Message-Id: <20220120071215.123274-5-ebiggers@kernel.org>
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

Therefore, make f2fs support DIO on files that are using inline
encryption.  Since f2fs uses iomap for DIO, and fscrypt support was
already added to iomap DIO, this just requires two small changes:

- Let DIO proceed when supported, by using fscrypt_dio_unsupported()
  instead of assuming that encrypted files never support DIO.

- In f2fs_iomap_begin(), use fscrypt_limit_io_blocks() to limit the
  length of the mapping in the rare case where a DUN discontiguity
  occurs in the middle of an extent.  The iomap DIO implementation
  requires this, since it assumes that it can submit a bio covering (up
  to) the whole mapping, without checking fscrypt constraints itself.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 7 +++++++
 fs/f2fs/f2fs.h | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a1d236212f85..90669c0d16c37 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4057,6 +4057,13 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->offset = blks_to_bytes(inode, map.m_lblk);
 
+	/*
+	 * When inline encryption is enabled, sometimes I/O to an encrypted file
+	 * has to be broken up to guarantee DUN contiguity.  Handle this by
+	 * limiting the length of the mapping returned.
+	 */
+	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
+
 	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		if (map.m_flags & F2FS_MAP_MAPPED) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb22fa91c2b26..97f9e53969ece 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4371,7 +4371,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (fscrypt_dio_unsupported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 
 	/* disallow direct IO if any of devices has unaligned blksize */
-- 
2.34.1

