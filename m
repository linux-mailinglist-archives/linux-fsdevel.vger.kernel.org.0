Return-Path: <linux-fsdevel+bounces-72431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D7CF70F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C8713033F98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997730BB8E;
	Tue,  6 Jan 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQRz3pNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D430AAD6;
	Tue,  6 Jan 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685022; cv=none; b=Fof1GGCUPE+4XHYBXVAIt2JxjmHR6SPHgksTX27XQMGOMGkqdOAf567hmTvFfKbHTbC//tLZ0KxpQwdmctOKZ+WNrIA7Z5dXQTSvoFLS1uSu91qtZjevqQMaks3W50JqXugy5nv5B2cfUW0zSDFKpVzSiTF4P0knMb/wzcPc64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685022; c=relaxed/simple;
	bh=1gzmHIoEkFm4z6kmBVCGjRL1igGStJt/isu8E06b6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN/RGs0903T/OyOq8Lp2WiTEpuMGjdNERpWOOeJBwuln15n1nUhoST4JdJH/qQThqIUgUZX8DVc87jql6DeRn9XlRmRs15/PIntr9Yv8bXfaCpVk/np8X5/VAGWvfL/pS5C7dj+iNlkMUJ+hXcDtZpWaMBMxukEN00/3uroPKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tQRz3pNS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N7zWXEuamRYFXAsXaiU69QdqNZY6RmV6pFikJMUdeew=; b=tQRz3pNSEtPKtCch/eqeBfY5FW
	kl+EVpKD1xpeEYnLGQhDacQKzWvpc7ZJfMx9+l/MtcvY3awz11TWk/vhadZCE1VHF3wLeV8DVNTmX
	0XVzOh1gGgUYQpUOSe4V958ftLgIuUbXmOdxQtc/cVQLoZ3bW2J+qzGQwP7LX5eFUpJv5qocONe+X
	djXMOMxIj60KmdvR4RW4WRF38ijnIuOL3rp8JdgbmP/DZuMHdC80kBHe2GWHgW0ZDDgoaNMUdJ8cp
	gfxdJgWEq27O/+2OaZ3I/BPYB9b7Hjo85vKhxaaGwNGug2Iq4i6xts0Y9Ty7mgNJTB555bE5F5M/Z
	cztJ53DA==;
Received: from [213.208.157.59] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1cg-0000000CWeU-3tlm;
	Tue, 06 Jan 2026 07:36:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 1/9] fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
Date: Tue,  6 Jan 2026 08:36:24 +0100
Message-ID: <20260106073651.1607371-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106073651.1607371-1-hch@lst.de>
References: <20260106073651.1607371-1-hch@lst.de>
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


