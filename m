Return-Path: <linux-fsdevel+bounces-77520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHqcE0VZlWkqPQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:16:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A791535DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F15305BF7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA0308F34;
	Wed, 18 Feb 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RGjG0yTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19C224FA;
	Wed, 18 Feb 2026 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395369; cv=none; b=P92eI3w12+z2O3yOUv+7QErjj+OfY4rDmMBGHsLYmxOr6r3uCyJkhnc2FRhpN5TYJNaO69/EONCIvfOLrRk2B4TTu+EtC5qI4VQCYsqSwu1P206fJRXJys2Qn0Reb+jRulsi/1isxu/46gz50apzUKS94xJmWr7vrnlrwTZc1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395369; c=relaxed/simple;
	bh=2KHLS6BDlzwYIvHFleKARAD0jO1535kYzzRb00+4ryU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx4ztsSKxBSZgaa6DV7ZM8PvaUB1saBnaw+AxP3BwYgqJmbeo42DvgC/jFrTJIULnGfjgIzUCxcYcg3sfY3Za1wVnPAf8JD4SBpcBvIJGJDn5N5ovUdX1uev4lIsNiec4/7p61Yy1xlcnQVP0KX3WZqT0SZ6z6fNrU3KkCAg3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RGjG0yTH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=riklaYaC8o2tdvy7FpPnqNZFcL07vFEnM3jtWWsAF2U=; b=RGjG0yTHXxQd8Fj6Gc2HmsoegA
	0QRWzXXW8WbtkZZs4gdCcl29FG4LYrjIgjc+aTsJ2ydtwm6oZgkSwEG147jYBbKts7090rqdQFGrc
	WD+AfiwFl+XNemv3RFqPn+e2fIBvbF+dvD+hkubmNr0wQDhqZkGlElXnb2eTrAFSB7YXaNCwKdJMy
	D6hNuL6DuARxlKJ1JRFdn9PW+DdGiOr0S1pWSY5WC8ORGnUmFyzc53ne8rVL9QSjADe+mvAV0RRVW
	vAMbVkrzZC5VXzELtoztCXLdktA3TesnFy6OEa2Fk3FXNRlGxpktOvYbcLeTW3xPRoTNIZfzeuPYU
	f6gAaJLw==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsar1-00000009Lhz-2toS;
	Wed, 18 Feb 2026 06:16:08 +0000
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
Subject: [PATCH 6/9] fscrypt: return a byte offset from bh_get_inode_and_lblk_num
Date: Wed, 18 Feb 2026 07:14:44 +0100
Message-ID: <20260218061531.3318130-7-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-77520-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03A791535DB
X-Rspamd-Action: no action

All the callers now want a byte offset into the inode, so return
that from bh_get_inode_and_lblk_num.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/inline_crypt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index c069958c4819..128268adf960 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -315,7 +315,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
 /* Extract the inode and logical block number from a buffer_head. */
 static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 				      const struct inode **inode_ret,
-				      u64 *lblk_num_ret)
+				      loff_t *pos_ret)
 {
 	struct folio *folio = bh->b_folio;
 	const struct address_space *mapping;
@@ -331,7 +331,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 	inode = mapping->host;
 
 	*inode_ret = inode;
-	*lblk_num_ret = (folio_pos(folio) + bh_offset(bh)) >> inode->i_blkbits;
+	*pos_ret = folio_pos(folio) + bh_offset(bh);
 	return true;
 }
 
@@ -350,11 +350,10 @@ void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 				  gfp_t gfp_mask)
 {
 	const struct inode *inode;
-	u64 first_lblk;
+	loff_t pos;
 
-	if (bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
-		fscrypt_set_bio_crypt_ctx(bio, inode,
-			first_lblk << inode->i_blkbits, gfp_mask);
+	if (bh_get_inode_and_lblk_num(first_bh, &inode, &pos))
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
 
@@ -419,13 +418,12 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh)
 {
 	const struct inode *inode;
-	u64 next_lblk;
+	loff_t pos;
 
-	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &next_lblk))
+	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &pos))
 		return !bio->bi_crypt_context;
 
-	return fscrypt_mergeable_bio(bio, inode,
-		(loff_t)next_lblk << inode->i_blkbits);
+	return fscrypt_mergeable_bio(bio, inode, pos);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
 
-- 
2.47.3


