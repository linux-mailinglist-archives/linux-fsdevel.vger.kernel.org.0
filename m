Return-Path: <linux-fsdevel+bounces-77521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIMaBzhZlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:16:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 035AE15358E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18C0230236B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D863093BF;
	Wed, 18 Feb 2026 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIGhpvD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11329BD8C;
	Wed, 18 Feb 2026 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395374; cv=none; b=G/7WfF27Qkb5FJg3qDnqjs/amgIKeX+OMk3gqgGHm8JXWvEI28neDgIvTk9YOqHqESrfGEk1P9QRrIIHB/A0DlEbnEB4dwDDnxUEFyznjftTjPkreHtghSNDNBryj/gbMwcxaDtaK9+WueiPUG4vnEWh2VRq7TsWlaiKvQSZUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395374; c=relaxed/simple;
	bh=7QeeOc1vORRQPpPDKI+Db/06sLEw+fDPHEWMSR1zLQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5m35ipZ9xcOHFpLbdfjo547loMeRjPDS8NV5xyUxiSR4M2oslbZnsP4TTN9Hp3MJwsNTCAQfaFW7er0gtpvNfAjVyro2bGsGEV90Gsveam06cXuj+/uS3FQJO1F+GGjkQPgxw0bVYJXZBcph0CFFGjH6zH+bn9fILQ3R28ENBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UIGhpvD+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+UxDPHpgLWPAQ48/oe5SjMgmPm5GDnzoABlzt1PeouA=; b=UIGhpvD+Fh1mQPvtisuEczdJq4
	vjNDcXGn+JbvJ9WUBDqJAC08lJ1rZjX2+m38VZx2fPQKNA1uwZ9QRycQwKHT7i6KdJryF1sI2JOJa
	ueABy0icfl7cSEShRm0gBhq+PCLT7eMmtce7J6WGz55Q1AdSlj2CJsqaGK+WbfUN5cnfSR7W2MG1m
	DYhZpg4dpCdsNRRy9zjiWDd/gG5pViQ1QdtRbj2JwiatLW1ETMD7CeoE61KMajry7GF0bhbUn91Y/
	jizXelkxDhRhIIQfmNClbMpRDcXtwbmx+hTmuO5kXImyu7+XHCtzdGhfLpIDyT4uy3H6Yd2xfRZdS
	ldbDMjyw==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsar6-00000009Li9-3jsx;
	Wed, 18 Feb 2026 06:16:13 +0000
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
Subject: [PATCH 7/9] fscrypt: pass a byte offset to fscrypt_zeroout_range
Date: Wed, 18 Feb 2026 07:14:45 +0100
Message-ID: <20260218061531.3318130-8-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77521-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 035AE15358E
X-Rspamd-Action: no action

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
index 36025ce7a264..e41e605cf7e6 100644
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
index 396dc3a5d16b..945613c95ffa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -405,7 +405,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 	KUNIT_STATIC_STUB_REDIRECT(ext4_issue_zeroout, inode, lblk, pblk, len);
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
-		return fscrypt_zeroout_range(inode, lblk, pblk, len);
+		return fscrypt_zeroout_range(inode,
+				(loff_t)lblk << inode->i_blkbits, pblk, len);
 
 	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
 	if (ret > 0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c8a2f17a8f11..239c2666ceb5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4162,7 +4162,9 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 
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


