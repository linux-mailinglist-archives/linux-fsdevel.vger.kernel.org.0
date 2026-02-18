Return-Path: <linux-fsdevel+bounces-77523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAwLF2FZlWkqPQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:17:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70D153651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27C96306B3B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0032A30B524;
	Wed, 18 Feb 2026 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ST4LAGda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECB29BD8C;
	Wed, 18 Feb 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395384; cv=none; b=W1+NGMtxRS/vVUHezqPcyYv4rImPNLFnWlefs+cbB3o9X3y1WkLhPjjO3b+OCYsqkmJuZy3BCMDG5QeiXZSBSb1DXXIuiuEMPlMhHv+cK66K5Pyr3N09oSjErm31dFNqdThby+FklBEbG/JWz/O5Jit1wz2WUgSn2dTkiU2BvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395384; c=relaxed/simple;
	bh=BqUJteWLQUbC5yASL8jviCB7vcELDlrPpnMPHAwveRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZXHZrdxmMx7jdeWfzN+2J9cpuTJnYACnFl38XiEwRpaNW6QRFSp7veDMf+S6xfQNZSXZtQds+7zdyDxrl5T8f1SzsmDMsnaydj0SZugFeA1GzhAGer4bQ8X1fDJQs3u38w/UWOLuQdSnnhq5cyycxVIKYWpKh/E3ZGkp27yW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ST4LAGda; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VcvKWVedtLFNeUePzxyg9ziacX2X2/mCVUWs+sJncbQ=; b=ST4LAGdabcaNmy0VRLTitYXFkw
	mWwVBPp/gsZnpmmZpcS3jTLT0J0zb/LeFcDvjjb2vaPjTgm8hVa1eN15hdxJLqTrBkHw5q2jx+kX9
	DcbGDFq5rlqmfFmzARyHN+VH5F4fGRdL6XeWWLKpcylokcrUSKP3qcpV2mlaBvrG7QnSy5WEgwnK9
	dCY538bIGaf0x6wTTQ5a2nzG9Our6GukIF6hgN+xeSovhmIXee0IWOVxSQWRNz7CdWGrio77F9f4L
	COMGec3wOCeL6+BXgjacgK0r5dd0Rg88sRJBbq0LtewcMBycNbsNsW/xTs9pAdd8tnoB+ly9AWNO2
	ZIefMhQg==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsarG-00000009Lim-3CYJ;
	Wed, 18 Feb 2026 06:16:23 +0000
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
Subject: [PATCH 9/9] fscrypt: pass a real sector_t to fscrypt_zeroout_range
Date: Wed, 18 Feb 2026 07:14:47 +0100
Message-ID: <20260218061531.3318130-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218061531.3318130-1-hch@lst.de>
References: <20260218061531.3318130-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77523-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 1F70D153651
X-Rspamd-Action: no action

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
index cea931620c04..45fe74aa8366 100644
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
index 675ef741cb30..d0028d6d3de1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -406,7 +406,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 		return fscrypt_zeroout_range(inode,
-				(loff_t)lblk << inode->i_blkbits, pblk,
+				(loff_t)lblk << inode->i_blkbits,
+				pblk << (inode->i_blkbits - SECTOR_SHIFT),
 				len << inode->i_blkbits);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5b7013f7f6a1..ad435dea656a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4163,7 +4163,7 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
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


