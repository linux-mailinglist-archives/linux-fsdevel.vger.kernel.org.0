Return-Path: <linux-fsdevel+bounces-77515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLvhGR5ZlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB711534E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 028DE300E68B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD1308F34;
	Wed, 18 Feb 2026 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbnHG8Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E82C0F8C;
	Wed, 18 Feb 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395343; cv=none; b=RMJRLWw3dVVKsdaE4fYhaOH4hPHM5zxO11n9n7Pv1OlXTZYXSZdpP6zzy6KQmFYqsBeASUvCaNsocjPs+Mf0+/qW/LgLbqnTImubNrI3LLsef/TB5NBCx/mOlxtEbB803YncSSOJneUPw/PqACLCAjdjWhhEOpeJMOLyUA1eGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395343; c=relaxed/simple;
	bh=Zh/fggMwn6Lfcw40q/PEojNJD7gTvWikxt1sBWBuVgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ9wt5tECxTrAAdqoS7iZRBLutgtVmxutdZGkWwY/Uua7dlfIVyr/RVXyBlZWzvM7Xg1FCM162S1iG+lRy6NxeKjM1td4sOR1qRD8OiKG0haZAIWm7PEMcskmlRVsGE476S0pX07C3fa1EBGe9z/f1dxa1rWObHielTxTzm5dIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EbnHG8Iy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fLk9zPxCHjgA7o3Jv3x/8UsJXoxlSctDFNj7ITNPZxs=; b=EbnHG8IyWDNDhDW5D56W8BHVRt
	n0pRGExEJ3BLQsecChVKgPpP9RzWnByCHWFO2xpeqOY/B/LVMF0zvkjM9vkFu7sehrSdxdSzQbtsi
	/tAAvMy3zJzZ7KR/Sj16vs3uaON2WlSwMAmm0CGkjIDKd7LTNVhxlMWVFQeqnox4o54olY+cDGIPO
	w6fO/TDp9d4SYgJKZiZD4kfomgj+EO1Eik+ZIX3Z1tCFybBishfdbG4+dvc0xxzChRePoqLxAxVmA
	11vGH6KLKDv2KjJUn56iPayckF4x1W9xd514cvLcjARv3UnrpC0appLxgyfDkry92AfVhZTVqYis5
	1IwwhduQ==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaqb-00000009Lf5-3hm5;
	Wed, 18 Feb 2026 06:15:42 +0000
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
Subject: [PATCH 1/9] fscrypt: pass a byte offset to fscrypt_generate_dun
Date: Wed, 18 Feb 2026 07:14:39 +0100
Message-ID: <20260218061531.3318130-2-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77515-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: DAB711534E8
X-Rspamd-Action: no action

Logical offsets into an inode are usually expresssed as bytes in the VFS.
Switch fscrypt_generate_dun to that convention and remove the
ci_data_units_per_block_bits member in struct fscrypt_inode_info that
was only used to cache the DUN shift based on the logical block size
granularity.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/fscrypt_private.h |  3 ---
 fs/crypto/inline_crypt.c    | 10 ++++------
 fs/crypto/keysetup.c        |  2 --
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 4e8e82a9ccf9..8d3c278a7591 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -278,9 +278,6 @@ struct fscrypt_inode_info {
 	 */
 	u8 ci_data_unit_bits;
 
-	/* Cached value: log2 of number of data units per FS block */
-	u8 ci_data_units_per_block_bits;
-
 	/* Hashed inode number.  Only set for IV_INO_LBLK_32 */
 	u32 ci_hashed_ino;
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index ed6e926226b5..1773dd7ea7cf 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -268,14 +268,12 @@ bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
 static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
-				 u64 lblk_num,
-				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
+				 loff_t pos, u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
 {
-	u64 index = lblk_num << ci->ci_data_units_per_block_bits;
 	union fscrypt_iv iv;
 	int i;
 
-	fscrypt_generate_iv(&iv, index, ci);
+	fscrypt_generate_iv(&iv, pos >> ci->ci_data_unit_bits, ci);
 
 	BUILD_BUG_ON(FSCRYPT_MAX_IV_SIZE > BLK_CRYPTO_MAX_IV_SIZE);
 	memset(dun, 0, BLK_CRYPTO_MAX_IV_SIZE);
@@ -309,7 +307,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 		return;
 	ci = fscrypt_get_inode_info_raw(inode);
 
-	fscrypt_generate_dun(ci, first_lblk, dun);
+	fscrypt_generate_dun(ci, first_lblk << inode->i_blkbits, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
@@ -401,7 +399,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (bc->bc_key != ci->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(ci, next_lblk, next_dun);
+	fscrypt_generate_dun(ci, next_lblk << inode->i_blkbits, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 40fa05688d3a..d83257e9945e 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -609,8 +609,6 @@ fscrypt_setup_encryption_info(struct inode *inode,
 
 	crypt_info->ci_data_unit_bits =
 		fscrypt_policy_du_bits(&crypt_info->ci_policy, inode);
-	crypt_info->ci_data_units_per_block_bits =
-		inode->i_blkbits - crypt_info->ci_data_unit_bits;
 
 	res = setup_file_encryption_key(crypt_info, need_dirhash_key, &mk);
 	if (res)
-- 
2.47.3


