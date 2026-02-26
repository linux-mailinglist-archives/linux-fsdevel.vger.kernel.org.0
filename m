Return-Path: <linux-fsdevel+bounces-78512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOVdAixfoGmMiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:56:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2251A8163
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E363195835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CE83DA7CA;
	Thu, 26 Feb 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQ0AOaMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C73D6475;
	Thu, 26 Feb 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117406; cv=none; b=g3e/Po2OR7PELI+B1z3dYX9EYKJCzJUEbJo7f/0ZSAUDJTi5AJX5kBMWR0EpqZyYBKRGLixUZnCyevRx4g17eZSy6BK8uBOMa+fNC7jfQgtDxLkzjYMdOLs0cYV9M8Dm7sOF916PaEQpf75zHKREptBYCeg5ZMWu/e3aWmnC2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117406; c=relaxed/simple;
	bh=bIhCNrggXHP6clqPJnzPEHLMS77rwUDWv3GqKzF8TDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5Wol1d+jcZiDDeQpZPtsOiGYFljhKPi7dDYpXjxyFUbn3Bv33Gr9koiE7f0j/LZS1uA+WZfq33BBiGDCWE5lo6shurzjJWojMw93DUJ7de4Pd0H3MNBQUwHMBq1WuVXFmZ0bS7LYJJ7WmEA7nNLm3hsHbJ36VJae/PAHzvDdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PQ0AOaMC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=m4IuMQ2TKa0TzW/JDk2yMMJ5yw7sTmpwUoByvrFH3Sw=; b=PQ0AOaMCqWd/MVgd7LVXLRSBRQ
	N1+UacSd2UgHt8KP5OhqoO8Ks4gZH3m6mYtNSaI7HF3JLhYlplhxmwoZHnyL12iU08FwU9hbBM1k5
	SL0nikzUjO20PxCT3WZu2abuelWcStyZjhuPl5EszdvdUptOihKLTNcYLvlhO4hFJ/weMX8Kc+Emk
	0Ia9aIJY+OnSa8S3B1VyvnaQF4weudV2Iju0jT/dg+HW38Bv8cOhrUcvNqYdAQ2e4sHzjh1DuHpNY
	L/JVvOHgHIDZcP96iyeOZzy50SX74IGckj9nVCBcYoPoFXVBiT/QQGVYSBcq9+EYpu1jhBvs8fXaZ
	E5Dr94bg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgg-00000006Nbz-0C4x;
	Thu, 26 Feb 2026 14:49:58 +0000
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
Subject: [PATCH 10/14] fscrypt: pass a byte length to fscrypt_zeroout_range_inline_crypt
Date: Thu, 26 Feb 2026 06:49:30 -0800
Message-ID: <20260226144954.142278-11-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78512-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 9D2251A8163
X-Rspamd-Action: no action

Range lengths are usually expressed as bytes in the VFS, switch
fscrypt_zeroout_range_inline_crypt to this convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 7558b3e69701..36025ce7a264 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -73,8 +73,6 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 					      loff_t pos, sector_t sector,
 					      unsigned int len)
 {
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
 	struct fscrypt_zero_done done = {
 		.pending	= ATOMIC_INIT(1),
 		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
@@ -92,12 +90,10 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_NOFS);
 
 		for (n = 0; n < BIO_MAX_VECS; n++) {
-			unsigned int blocks_this_page =
-				min(len, blocks_per_page);
-			unsigned int bytes_this_page = blocks_this_page << blockbits;
+			unsigned int bytes_this_page = min(len, PAGE_SIZE);
 
 			__bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
-			len -= blocks_this_page;
+			len -= bytes_this_page;
 			pos += bytes_this_page;
 			sector += (bytes_this_page >> SECTOR_SHIFT);
 			if (!len || !fscrypt_mergeable_bio(bio, inode, pos))
@@ -155,7 +151,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
-							  len);
+				len << inode->i_blkbits);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
 	nr_pages = min_t(u64, ARRAY_SIZE(pages),
-- 
2.47.3


