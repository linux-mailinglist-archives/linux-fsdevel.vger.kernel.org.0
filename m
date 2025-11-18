Return-Path: <linux-fsdevel+bounces-68896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8FC67B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1735828BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE822E8B98;
	Tue, 18 Nov 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTDutz6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810E231A32;
	Tue, 18 Nov 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446973; cv=none; b=U9Wm7QTyARq6ZSWrB4FhPNFcnNhH508vOcRKTunA2MAG40mGMModoPJGif660efqgnyBQf9lAcs7suCLFKLt83gk/COnhPdGK1yy9+fpw6ipaHJARxb0S3mWvS0AeGV9LK4vYctAGU0i4eUsbYAdP4OmD8naBHifBP9BAoJE3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446973; c=relaxed/simple;
	bh=JgPnQ4RUcT87E2MFvx5VCCFQVFz+mNr4V/q7QDcnuMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNMJNRMwcYW748wU925zcMsNYkvBeHXIu9hQwt8Gvf6HKAMOoOiauUZkaGk8LVBffrbg35wMlQ/uBLei2tMSMJu6Hz1JVa8F2fD7kwwGmLh3Qv/MXzNKuhXuC8zLF3N1+aqlK6RvMw5GBKNdkx2mQpws8q64CFuqpsOOld/cEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTDutz6+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G2zb3Q2fyVSCliM2H0fGzNDzGDdxeCfjnBDHQEp6ApQ=; b=nTDutz6+Z8LtXzEP+vHWwbwu8s
	px7nF7SjtWbcHcEY6JuU0K5iUjMtmx+yi/bv2PrQ7DkXG55Dy0/Z9ihmHjuH2J6XLS6XX0S9flB6T
	OUmc7TkHJV83OvKvpEqcguD8VvjZ8+9JSBz5nVjfqrNBQOq688Jxl4WY45UdjIYe2FoZvyVmX22RH
	v3SJr/Z+CHcGBP2hI181hcEpDjovAk+cIpoFqWTX4KUqESt+CmhpTqOZABU9iF9t4GtebdH/O2MjL
	F6mS+T3LOqrYIudjk5NIwmcKkc3tesgxKwjLEa6jonHSh++67MwRwUQU44Vd5VG5ZqDbbtXi9eEPl
	jKKq68IQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF75-0000000HURD-3vFW;
	Tue, 18 Nov 2025 06:22:52 +0000
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
Subject: [PATCH 09/11] fscrypt: pass a byte offset to fscrypt_zeroout_range
Date: Tue, 18 Nov 2025 07:21:52 +0100
Message-ID: <20251118062159.2358085-10-hch@lst.de>
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

Logical offsets into an inode are usually expresssed as bytes in the VFS.
Switch fscrypt_zeroout_range to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c         | 6 +++---
 fs/ext4/inode.c         | 3 ++-
 fs/f2fs/file.c          | 4 +++-
 include/linux/fscrypt.h | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index be751bcd2976..235dd1c3d443 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -113,7 +113,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 /**
  * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
  * @inode: the file's inode
- * @lblk: the first file logical block to zero out
+ * @pos: the first file logical offset (in bytes) to zero out
  * @pblk: the first filesystem physical block to zero out
  * @len: number of blocks to zero out
  *
@@ -127,7 +127,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  *
  * Return: 0 on success; -errno on failure.
  */
-int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 			  sector_t pblk, unsigned int len)
 {
 	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
@@ -135,7 +135,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	const unsigned int du_size = 1U << du_bits;
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
 	const unsigned int du_per_page = 1U << du_per_page_bits;
-	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
+	u64 du_index = pos >> du_bits;
 	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
 	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..209d326b8be9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -402,7 +402,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 	int ret;
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
-		return fscrypt_zeroout_range(inode, lblk, pblk, len);
+		return fscrypt_zeroout_range(inode,
+				(loff_t)lblk << inode->i_blkbits, pblk, len);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
 	if (ret > 0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffa045b39c01..150c3eb15f51 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4142,7 +4142,9 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 
 	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
 		if (IS_ENCRYPTED(inode))
-			ret = fscrypt_zeroout_range(inode, off, block, len);
+			ret = fscrypt_zeroout_range(inode,
+					(loff_t)off << inode->i_blkbits, block,
+					len);
 		else
 			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
 					GFP_NOFS, 0);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 5b86d7d0d367..065f909ebda2 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -450,7 +450,7 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 			  sector_t pblk, unsigned int len);
 
 /* hooks.c */
@@ -755,7 +755,7 @@ static inline bool fscrypt_decrypt_bio(struct bio *bio)
 	return true;
 }
 
-static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
+static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 					sector_t pblk, unsigned int len)
 {
 	return -EOPNOTSUPP;
-- 
2.47.3


