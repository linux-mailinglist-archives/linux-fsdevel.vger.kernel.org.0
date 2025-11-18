Return-Path: <linux-fsdevel+bounces-68898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690EC67B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D924E1361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA002E973C;
	Tue, 18 Nov 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rG7bh+AR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDF2D9787;
	Tue, 18 Nov 2025 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446982; cv=none; b=oOmR7Smb9+vHJGabii2S53sQLRQiYJpaIXnH7IrKdcLKmzgB/f04O/14Ohx865ihKPGUCDq2SKErm87g22zzM8p19uRf5O/pobC8xwD5z7TPPfY1F58Aj8iWlWJnKCbLJBh8piJr+JwCC3FqFd0S1VtRtJjtZrta8r9rHo0RsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446982; c=relaxed/simple;
	bh=DRUg08tPNIbEXSFUWcxJlSLxrGKsbEQwv4xqnlsG6gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lpmv4fr6IvkYWUsEWu8e3l6MHOgrKljFOmVW2yrGSmCNk9o84Iky/t+EeQ2iekEoCLSPI7N6UUCDdhA/zGt2DddKtJIQFI3pU214MyStNVY5AjE9ACgXTA31ZENEjl8PVbeP7WcYVVDiQgQYjx5Lk0Xdib9HLbly8KcnkIMX+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rG7bh+AR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=maKopu2ueksKXHtq1fc6D/pIVzIQjjOXmEvWcRyAhDQ=; b=rG7bh+ARUqJdOqoyrjC/caIkr3
	zZteJG5gaJIXz8GFA0EXypEhTWiAQQ7eMClmcognNt2wwpLAfmNh8PP0ePK6nRoJWxDpUrPvV5p6/
	FpYzw+rpQDSPMcLhQKxaIgVwqUIJROVcpY6Lg2dQ1o0wUT93P9KHVdRXFLCRFzg2CmxhDtS8a/fCp
	yygaSAhL5LCdxZQ/1PXF6TXdf7c56ME6fUu1J51jm3ZTbRQa4YntPWNeA2J8rteE2TXR7CRk58EBB
	SGK4eSyxUbnhMmumpQAakxdqFHw4Hdg59urW8c4pbEOtP4OGtsMzST82bZeUe9aZVi5t/14728de6
	fLdlvhiw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF7E-0000000HUS0-1oBS;
	Tue, 18 Nov 2025 06:23:00 +0000
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
Subject: [PATCH 11/11] fscrypt: pass a real sector_t to fscrypt_zeroout_range
Date: Tue, 18 Nov 2025 07:21:54 +0100
Message-ID: <20251118062159.2358085-12-hch@lst.de>
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

While the pblk argument to fscrypt_zeroout_range is declared as a
sector_t, it actually is interpreted as a logical block size unit, which
is highly unusual.  Switch to passing the 512 byte units that sector_t is
defined for.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c         | 6 ++----
 fs/ext4/inode.c         | 3 ++-
 fs/f2fs/file.c          | 2 +-
 include/linux/fscrypt.h | 4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 4e9893664c0f..63bb53aeac4a 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -114,7 +114,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
  * @inode: the file's inode
  * @pos: the first file logical offset (in bytes) to zero out
- * @pblk: the first filesystem physical block to zero out
+ * @sector: the first sector to zero out
  * @len: bytes to zero out
  *
  * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
@@ -128,7 +128,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * Return: 0 on success; -errno on failure.
  */
 int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-			  sector_t pblk, unsigned int len)
+			  sector_t sector, unsigned int len)
 {
 	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
@@ -137,8 +137,6 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = pos >> du_bits;
 	u64 du_remaining = len >> du_bits;
-	loff_t pos = (loff_t)lblk << inode->i_blkbits;
-	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
 	unsigned int i;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3743260b70d4..d8a845da2881 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -403,7 +403,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 		return fscrypt_zeroout_range(inode,
-				(loff_t)lblk << inode->i_blkbits, pblk,
+				(loff_t)lblk << inode->i_blkbits,
+				pblk << (inode->i_blkbits - SECTOR_SHIFT),
 				len << inode->i_blkbits);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 45ec6f83fcda..315816ac07be 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4143,7 +4143,7 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
 		if (IS_ENCRYPTED(inode))
 			ret = fscrypt_zeroout_range(inode,
-					(loff_t)off << inode->i_blkbits, block,
+					(loff_t)off << inode->i_blkbits, sector,
 					len << inode->i_blkbits);
 		else
 			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 065f909ebda2..11464bf0a241 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -451,7 +451,7 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
 int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-			  sector_t pblk, unsigned int len);
+			  sector_t sector, unsigned int len);
 
 /* hooks.c */
 int fscrypt_file_open(struct inode *inode, struct file *filp);
@@ -756,7 +756,7 @@ static inline bool fscrypt_decrypt_bio(struct bio *bio)
 }
 
 static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-					sector_t pblk, unsigned int len)
+					sector_t sector, unsigned int len)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.47.3


