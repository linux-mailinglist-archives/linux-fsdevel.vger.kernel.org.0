Return-Path: <linux-fsdevel+bounces-68897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E13C67B61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50F7D4E4E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5F2E8DEC;
	Tue, 18 Nov 2025 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Ml19sqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C8231A32;
	Tue, 18 Nov 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446978; cv=none; b=X+a8STggxd6GIAJZLn/saIeJUCsyOVTNLZGwamq5H7Q2uzmvqucGhDINsbAqD1MQWbsJ6Qh7QsndemMLLnkXWVMcsqB380R9s0Cyvo8kq6nK/ZCPiB+mktMlQ2pzPiVcLN8uGpA3qkwMKCQSJVrKuEUfSyH+af4IS/M3aq+QHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446978; c=relaxed/simple;
	bh=AwRSr7JUG1qwZHnVmkoQN6JUVfsF05aYXLzRqnuKWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4JfQLWKg3DHAZLsqis1SdUTB6Ea8tn5dqmir2yAuTuvHM4RQVmWXqfg2FCdkIoVhM7CKG/B71Zj+sa8n4lkwgf5uwv4leVArC6apjUELlwHYMTkwO9vntLWWBnjdGIIcvNXoBt6XuTjxWBBEfc0hk63mg3luyZvdmhw6jGqbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Ml19sqA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZZkZjOQnGyIUghYGVRozjYOsML6G45CL7u5dxj9Y0EA=; b=2Ml19sqAktZtwBKiLfjaJ0xyNL
	zpHZ/h+EH1BFP0ecXlUAz95B4puJdWSp6HZWem4P6mCBF238XrPn4oiAD07rC1ADqYfx6U65JJ3oV
	O0/+lgv5xTpy7fVQ5OILy5Rp2QUmAgbxEWyPYLEnRBq5hjSbS8AKcgEZAbZRqlvNIc5Q+M+vMh071
	OJTvCcyU4ynuj+zclqApLxPe1PLEiy34+NFOVEm5VgkFjIeTEb86zLOqzow0YRTWeKuv0i/TCJXPg
	MG7vaQYV9zdijOpUIdDIWkXzJob+EdD54li4lHAxxxiHDf3GO23Q98/H3QpaGe+r+o0OE150HQazw
	IKbtsw5g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF7A-0000000HURc-0pK9;
	Tue, 18 Nov 2025 06:22:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] fscrypt: pass a byte length to fscrypt_zeroout_range
Date: Tue, 18 Nov 2025 07:21:53 +0100
Message-ID: <20251118062159.2358085-11-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118062159.2358085-1-hch@lst.de>
References: <20251118062159.2358085-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Range lengths are usually expressed as bytes in the VFS, switch
fscrypt_zeroout_range to this convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 6 +++---
 fs/ext4/inode.c | 3 ++-
 fs/f2fs/file.c  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 235dd1c3d443..4e9893664c0f 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -115,7 +115,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * @inode: the file's inode
  * @pos: the first file logical offset (in bytes) to zero out
  * @pblk: the first filesystem physical block to zero out
- * @len: number of blocks to zero out
+ * @len: bytes to zero out
  *
  * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
  * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
@@ -136,7 +136,7 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = pos >> du_bits;
-	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	u64 du_remaining = len >> du_bits;
 	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
@@ -151,7 +151,7 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
-				len << inode->i_blkbits);
+				len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
 	nr_pages = min_t(u64, ARRAY_SIZE(pages),
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 209d326b8be9..3743260b70d4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -403,7 +403,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 		return fscrypt_zeroout_range(inode,
-				(loff_t)lblk << inode->i_blkbits, pblk, len);
+				(loff_t)lblk << inode->i_blkbits, pblk,
+				len << inode->i_blkbits);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
 	if (ret > 0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 150c3eb15f51..45ec6f83fcda 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4144,7 +4144,7 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 		if (IS_ENCRYPTED(inode))
 			ret = fscrypt_zeroout_range(inode,
 					(loff_t)off << inode->i_blkbits, block,
-					len);
+					len << inode->i_blkbits);
 		else
 			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
 					GFP_NOFS, 0);
-- 
2.47.3


