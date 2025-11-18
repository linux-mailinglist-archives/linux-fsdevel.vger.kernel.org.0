Return-Path: <linux-fsdevel+bounces-68895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D60C67B52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id E1E67242DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984372E7F1E;
	Tue, 18 Nov 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wqeu3qz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3723231A32;
	Tue, 18 Nov 2025 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446970; cv=none; b=qj5n39PmVB7JQVzSdrr5m6v2ysiKG/0KEyxu6770+mwwrbxo0S+RQPTkPLq46Jnr5JpqW2tJ4bpck+9B+bSRp44VP1GSslvcsdiW+A9izhSKPLo+HsS+tHH5deTWcQ37UTROhjFgOo76sLzPbpQEgzRYSnEe3cydpOl6KZFMTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446970; c=relaxed/simple;
	bh=2KHLS6BDlzwYIvHFleKARAD0jO1535kYzzRb00+4ryU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6S/wq8ymnxuEhb++An8Xcg1OgaiXDSRzks7gVfS8hqs4WfkJiHEa6MH3dLXQguVlvBc6yOLYbJtfqBB1Bb24FEr8VlwPCNrSvV5C1voJ0fx25mVNr0Od7fA0gxIsyPhDEevlZ2C04nMl+B3rMEkRScGk74kWwaAKrNcoy4UDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wqeu3qz3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=riklaYaC8o2tdvy7FpPnqNZFcL07vFEnM3jtWWsAF2U=; b=wqeu3qz3TvBGdOaSMIBRfmhDMu
	RX+u60EalaYpNmlrPNdXsZcJcyIQhlrzhzbIL4FNB30wnw7UMid+vUzpBDPnPdjY8RbOkka3BviRk
	Y/bHNf7/i2Nio4PZt2WvimHNjXBQdZv8mME9rGQV1A2ZMmdu7kicmeUUYLRqB1s9k4IJev5cVZimw
	YNci+UHOm1j0T9BWojmEF7Yg0h4yhhwa4Mjewb6t7g8Xq1o2/vgVEF6P5gXc1aHHc4BGYC99MXh6f
	2A0lyP1lNR+E4EFZTj6lnqYzKqSmeGN2KYKzeBddgwrGHs5EozsNg1MYIAqZzAsnAyxzMNIco6LKV
	cH7oaCQg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF70-0000000HUQo-0nDu;
	Tue, 18 Nov 2025 06:22:48 +0000
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
Subject: [PATCH 08/11] fscrypt: return a byte offset from bh_get_inode_and_lblk_num
Date: Tue, 18 Nov 2025 07:21:51 +0100
Message-ID: <20251118062159.2358085-9-hch@lst.de>
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


