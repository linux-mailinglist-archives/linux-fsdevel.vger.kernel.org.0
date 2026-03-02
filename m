Return-Path: <linux-fsdevel+bounces-78918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA/MJDafpWmuCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:31:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D91DAD60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABE8A306CC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9256407596;
	Mon,  2 Mar 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PIkQJOXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B34014AA;
	Mon,  2 Mar 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461177; cv=none; b=HE+w/Hu5FfYeOOvFJxulmNCvuqvSLySkVlsQxYjurxYb8YJAGEMEkVQd29KbVDMoMgwuIKn4PyiI0Z87MzerCeJaytFb6bp/Qo+co/AMYOw/STYyCNOL8gJpXnccJC8F0WKDbUDC3jgnSh8UbDDKjKxmFDPSwXXP4QtRX58MRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461177; c=relaxed/simple;
	bh=oG79DjicdtHF96m6uzSEIqehj/Frr/vcZ9R+KG08v08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoZ6LRb9OeFQzcoDgumsdGRocB++PcsjtLXaGQLN2/nXgj7d4J6LhpR5Uhv0Aah1PufZlhFuOKysa8D3InxQQOncPqwAdMFZtlBzs1IT8ehjyl723fdaVj8viMX5NNitwfyJtVx2DgrVU5PRUFbohNatnUpsCm0O2AKwvIT8ME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PIkQJOXQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XTewtAN5IH08vzcFdRmbWH5BD7u2IiMHdW7+cNMnZMQ=; b=PIkQJOXQTd1Yjawx4dB4WY93Xe
	VEeFxUxUm+aGsPyD9UtDoB1C7vZAEB2beQyJbFE4BDL/asmjtQT7KUyZl7WKGPUZpPw9xfNPBcCy2
	J+hSlgsPG95CQ5u26bW8XWsDVtNvHW6F7JgIAJgvmDmDbLmcp7olkQr2cIEA6XL3wqvy0GykwkND4
	Ijy+S0iwBdjNAQnxtbLZXS3zk+MhjJ1c50YIuArNWTqHL68Zg99elGxmycA8v+l9P9pAJ8R2TpkAi
	8NrlW3By5RUfENwS/mHDFYSv8DuDNMOaL8R1opTtDRI2ogU7c2CUi9oq1Tv6+SxWJcv8zAKhu+ZFP
	2tueLadQ==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47T-0000000DDTV-395K;
	Mon, 02 Mar 2026 14:19:35 +0000
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
Subject: [PATCH 11/14] fscrypt: pass a byte offset to fscrypt_zeroout_range
Date: Mon,  2 Mar 2026 06:18:16 -0800
Message-ID: <20260302141922.370070-12-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
References: <20260302141922.370070-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 988D91DAD60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78918-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Logical offsets into an inode are usually expressed as bytes in the VFS.
Switch fscrypt_zeroout_range to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c         | 7 +++----
 fs/ext4/inode.c         | 3 ++-
 fs/f2fs/file.c          | 4 +++-
 include/linux/fscrypt.h | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 303b5acc66a9..a07ac8dcf851 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -113,7 +113,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 /**
  * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
  * @inode: the file's inode
- * @lblk: the first file logical block to zero out
+ * @pos: the first file position (in bytes) to zero out
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
@@ -135,9 +135,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	const unsigned int du_size = 1U << du_bits;
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
 	const unsigned int du_per_page = 1U << du_per_page_bits;
-	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
+	u64 du_index = pos >> du_bits;
 	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
-	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
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
index 90f75fe0e1c9..9fc15e1fbe57 100644
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


