Return-Path: <linux-fsdevel+bounces-78510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL7zE2lkoGnrjAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:19:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A56111A877E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 908B030E9B61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470853E9F8C;
	Thu, 26 Feb 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDdcwxsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A13AEF29;
	Thu, 26 Feb 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117405; cv=none; b=Lc0C9qLbE8Qlk9U1aQlahuEYTOrnKFFc0An7mXZcXeE19Gi+JSHbpXngXGsOgks1PJ/FW54bHrpDyQPzRmrPaoMessv1lHtoCRdlJmh3kcNMmlPNCmE6LgqrRB6qiuGKYTQQAnUVD1okpTLeiHqKKSn/JEiE66gDhyBMalsF0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117405; c=relaxed/simple;
	bh=xrZ56GwN0DxtCOcCCQXmr+B+xIIiunz1BcHYsiIyL+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHTQM4+naYeiKRp7a9eaq5uESJaieeppa+sIGSurJtobKGB3Un3on3aLpQSmDQgMQFRGDZVF+wVBBqPgPSVICQmUBuNR5nLtdO8ePGSs0Y9zp3xAzDkLVSvU0b5HKpx2Gr1XijccKDLX4Hw5+HumWMr1CsZuF7PUrz6FPT/Sl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jDdcwxsD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=prullTp9LHQrqh8Xt6O1yFS0g5pZcBygbWXiKMvvhew=; b=jDdcwxsDnRBxmI58i9QfsXcGMX
	fa3h4t5/BKNG+M8VGQ8Ir0uruXkUUMxCEAOUjQGt330hcivLliF8STs9c7tEWFqOn71enK46Vt2cm
	8h5SpoM1/88SWDju4QsYp/BHyR9nyQ0XVX4IrhAbf/Dle9tI+kRW1nRINDyZJ6UM8Zd8/9+9ucW2p
	+mpcZFF0n+LNryoFtkX0G5DaBWVykdj0PDHGH3enekzRmGo0XcKfCLSyOYXe3xvoeSQQYum8LbJWu
	oUOFVJWyTvqAHkjMwHTJROyQICuqzeja8jAomJkrOlHIsWU1ERgy+hMaZe0a+p8wT0G1XucNWXNQA
	hJCxXE9g==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgf-00000006Nb7-0tfZ;
	Thu, 26 Feb 2026 14:49:57 +0000
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
Subject: [PATCH 06/14] fscrypt: pass a byte offset to fscrypt_generate_dun
Date: Thu, 26 Feb 2026 06:49:26 -0800
Message-ID: <20260226144954.142278-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78510-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: A56111A877E
X-Rspamd-Action: no action

Logical offsets into an inode are usually expressed as bytes in the VFS.
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
index 702d13d138aa..5279565e9846 100644
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
@@ -356,7 +354,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
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


