Return-Path: <linux-fsdevel+bounces-68893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDCC67B7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 882C43674D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662D2E88B7;
	Tue, 18 Nov 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uD17qYyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589792E6100;
	Tue, 18 Nov 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446960; cv=none; b=c/0aGo9tpD701CvUbrt8yXDSSjDMcn3kFg0CsBDcWdS1zSdoJrqCA86jT9L6j/OFKof1XrJzObGaui2oYs0q9tt3ZZNdt1XrxtJLtZF6XX+ergYQMce4pOYJbNVnL828qKaH/Grj3LEHNF1MuODO0PX3wtOQ1e/TAMUbGmn59L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446960; c=relaxed/simple;
	bh=K5Vl8jwh01P93UJlqzatMo8V7K6qmAwTKaaz8P7o6c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crz4GYys71Y2tpsYXvBjFRWKKQMdN8l3s/i3yeGbxmu+iAjVEGDhCNQRUj70TdoTCQSO2tK6VUg5JPaLvAtFrfzPI2gTqtvm8anzVJPV76nWAV4zVILS5Xyqcw3zekbJqESfPvLtTh0AM1mfZZ9ybsC+1yOwuQJelXzBIYcN8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uD17qYyA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0nsosK/PAB2sVu6ITCStCv+c85xQl1rhOQZNi3xidD8=; b=uD17qYyAkPr12eR7Ljzry1k6R3
	LeCeoWqZiI/+KE1rKQVEqICKIwQot0s7G7DUwJpUuDkvaOmJPITMkbzWWIAM3i12LcWg/p+bWZMiW
	isXXCPEioFYHXNd+gxgzXAoWSW69Ts3W3RUuRMLPlBbO8uJ5jnch+j8FHKp+UsXgGoVPZUUWFHhEv
	CuCjNlE/aiaKoPmwzdVnhUUKvWep0fwpA4/UGXcCPRCKdmiUsam+hoSH/CDaLfFd2zITdvdNWS03o
	OPIJO0lxSjg7z63hIq8mNQlXTrYoildrHINAFwO1Bf/iPcyt+ctCunqNve0mYj56z2HbbQnukSwXz
	g+nVwmGg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6r-0000000HUPu-27MI;
	Tue, 18 Nov 2025 06:22:37 +0000
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
Subject: [PATCH 06/11] fscrypt: pass a byte offset to fscrypt_zeroout_range_inline_crypt
Date: Tue, 18 Nov 2025 07:21:49 +0100
Message-ID: <20251118062159.2358085-7-hch@lst.de>
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

Logical offsets into an inode are usually expresssed as bytes in the VFS.
Switch fscrypt_zeroout_range_inline_crypt to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 3a7e3b37ac02..07d757d2777e 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -70,12 +70,11 @@ static void fscrypt_zeroout_range_end_io(struct bio *bio)
 }
 
 static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
-					      pgoff_t lblk, sector_t sector,
+					      loff_t pos, sector_t sector,
 					      unsigned int len)
 {
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
-	loff_t pos = (loff_t)lblk << blockbits;
 	struct fscrypt_zero_done done = {
 		.pending	= ATOMIC_INIT(1),
 		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
@@ -142,6 +141,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
 	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
@@ -154,7 +154,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return 0;
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
-		return fscrypt_zeroout_range_inline_crypt(inode, lblk, sector,
+		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
 							  len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
-- 
2.47.3


