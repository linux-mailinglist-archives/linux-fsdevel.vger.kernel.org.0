Return-Path: <linux-fsdevel+bounces-66568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B71C24311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5739D4ED17F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C384331A6C;
	Fri, 31 Oct 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wfBXma2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B9329E61;
	Fri, 31 Oct 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903346; cv=none; b=RsgcsnNJTHeD8XfOyZHy8TiDST5L+Y46YVUnmz0YSbO16O3F/HFDwAUCcKi6MxPuHCJBc2tLRDg07MTNnYutNxeuAl64NofOROa9kvrPuTifzBclageYrXtr7oi8Cz0G0cKgQ7ZQ4oTMOcVtlNhGQ5qMRhz6Ycccr1u4IFrAmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903346; c=relaxed/simple;
	bh=7YcNpSKXb7HcSDBHd3mSS9ssHEHOhNOJWIx6F0tBJRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTSNx0DirkCbhKBlMH+dU56hvLaDk0D47tdeB8LDurBjyWUD6C1qqsYf9q4UK2K6sqeU8DAasfDFNmmcLYF4QqYnorbhPMN+ndIQJhNU8awg/TOgLHzNAa5XWVgsDXYSoIz2+1VohH6kzjEFiw6F1DpJC9JyehBfX5pO2JiEuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wfBXma2O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HqWWMzp18VGGcYecVDBfzI6fZq+XM3nnYzuWuwwCLew=; b=wfBXma2O4xSHPIf78YwepIbpt8
	Fft5OS73hC4UWITZzqL1ZF6K42cJXgur5fTz9B1Oa5Z11NJxIIyYiDAgexqs5HQgCBemm04Ap4QE+
	bVoQ/dMvTVrIcjYFGOuDu1bWrQjfYgFpHICSC3BDmXjqJiFpLIaqoZGClY1KGw14eg3/sS8QvolFP
	+a4Oxfzd7ayE7o3Du05WVGBg4qRZHInN/U4Zyc2YIozg5taZw1Q3QwGI1bP6TA7M5z0SrxYbqLNEZ
	rkBKYvFAT4u7pgJOsYtafDjmfKLZXhURoyBrEo/gmHapPZ7tsQRDF080LRyqRJEub43ZFOdyJfBx+
	6TcFJRDQ==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElXq-00000005oqc-3nBe;
	Fri, 31 Oct 2025 09:35:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/9] fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
Date: Fri, 31 Oct 2025 10:34:34 +0100
Message-ID: <20251031093517.1603379-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031093517.1603379-1-hch@lst.de>
References: <20251031093517.1603379-1-hch@lst.de>
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


