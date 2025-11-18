Return-Path: <linux-fsdevel+bounces-68888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCDC67B01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 9FFE124299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD82D9787;
	Tue, 18 Nov 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iD6ozSBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0A231A32;
	Tue, 18 Nov 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446935; cv=none; b=hkKSkUqJ+VNwZlE2KRwOFbj+wJ2scBwQtMK4x6Zvhp/NLRUO5q84G8pwNausEWZqEQVXxw4g8F+cGXffGOJnnWHdpsJHL1SSe4cq9/PwBGfRMSTjcpP2s4SUuBKvZqTXTJt9wpRb+jhrvPVbraVbWrjFauGsMZaSFYv/eNiRSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446935; c=relaxed/simple;
	bh=1gzmHIoEkFm4z6kmBVCGjRL1igGStJt/isu8E06b6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG6bTer0miSnbq5oU3m3U8FrPC3WMAEESHEHKDamyEReOWEYsRsVy1KdKebHlB4Ul9V96fh/51MZBjp5xk6824PbcKuxScFlORsUVpekm255yVckk66fcCSIGZIppEp/VtF7ssyfT5cdfs/licnhx6FUiXZS7gNWeXX7fh9KyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iD6ozSBQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N7zWXEuamRYFXAsXaiU69QdqNZY6RmV6pFikJMUdeew=; b=iD6ozSBQSSN0rzRtCU4Dz2kjGu
	Xag3Q2nreEmFxT3BvQoGcg0dbdzgvzFAzJFIaTDOlkQMaWxVtoGrHOMakGllc/8Ibbb4UMqRUfjY7
	ZSDvwNrhI/0YPm4ZmOurYtZ1qicemkA2sA0q4Zk/rwJJn6+NGXo0kPt4niNA/+y7n6YumCnHHyuRR
	Jxe9RByp4/dJAmzRHNuAkWdqY3tV73yxRdyck0jAJ6IIUr8O3o+xEJ1ulIPUiJKU7mjKjxogpQpEB
	0nwTNOfOJU8muKpOGWx1Fv2JRgP8jSrKx5+XK70c2ieYe/1J+SdVUBXOUPTYLpbgKDpcA6x8poTgv
	cxP57T/g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6S-0000000HUOB-1pjA;
	Tue, 18 Nov 2025 06:22:13 +0000
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
Subject: [PATCH 01/11] fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
Date: Tue, 18 Nov 2025 07:21:44 +0100
Message-ID: <20251118062159.2358085-2-hch@lst.de>
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

While the pblk argument to fscrypt_zeroout_range_inline_crypt is
declared as a sector_t it actually is interpreted as a logical block
size unit, which is highly unusual.  Switch to passing the 512 byte
units that sector_t is defined for.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/bio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 5f5599020e94..68b0424d879a 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -48,7 +48,7 @@ bool fscrypt_decrypt_bio(struct bio *bio)
 EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
 static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
-					      pgoff_t lblk, sector_t pblk,
+					      pgoff_t lblk, sector_t sector,
 					      unsigned int len)
 {
 	const unsigned int blockbits = inode->i_blkbits;
@@ -67,8 +67,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 
 		if (num_pages == 0) {
 			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
-			bio->bi_iter.bi_sector =
-					pblk << (blockbits - SECTOR_SHIFT);
+			bio->bi_iter.bi_sector = sector;
 		}
 		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
 		if (WARN_ON_ONCE(ret != bytes_this_page)) {
@@ -78,7 +77,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		num_pages++;
 		len -= blocks_this_page;
 		lblk += blocks_this_page;
-		pblk += blocks_this_page;
+		sector += (bytes_this_page >> SECTOR_SHIFT);
 		if (num_pages == BIO_MAX_VECS || !len ||
 		    !fscrypt_mergeable_bio(bio, inode, lblk)) {
 			err = submit_bio_wait(bio);
@@ -132,7 +131,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return 0;
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
-		return fscrypt_zeroout_range_inline_crypt(inode, lblk, pblk,
+		return fscrypt_zeroout_range_inline_crypt(inode, lblk, sector,
 							  len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
-- 
2.47.3


