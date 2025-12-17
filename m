Return-Path: <linux-fsdevel+bounces-71510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35CCC6246
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F42730707B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01372D5C67;
	Wed, 17 Dec 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ml9VLXQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545A2D6409;
	Wed, 17 Dec 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951675; cv=none; b=jLvlPdxFIjlje35U5o4OVGdxn7FmaVM6hFEUQdVh6g9hVHWl4i+9hwis+rYkRldkFEOuS3iL7Hi+KY1fUq+hXvv3lpBQXoN11Osasnkjw/8D5sQpyK+V1yWuA4d9qT7kPDVfoITPMKOsCvSdB1RFCqRgrANxcALrUMtgVr2WMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951675; c=relaxed/simple;
	bh=kem2m2eUDE4k+KhL2rN3cSp7QaY3fXSsl80MWZLtFpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poyO1/sYxIcTYo0kYVQMDYKa5Dwp4dEzV//HAIgnp7VyTGGvRSMyZCmQLrQZX4AEBzyYh9Kh3PPGDuOzyNDd2+pOE+WmMhWHI9WY3RpPxvNrBfjiTbciSpXF54SXzIuQ0gD3cD5TdZy5PgWzs+HzNX8JGzVM8vJyqqUc8cayoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ml9VLXQq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NwDc3eWt44SMvPQrlSWqoaKOT+KSCiuB5doX9517C78=; b=ml9VLXQqGKYu9hhWtBYc77SAjh
	oRPKKOzVIAnE/lg8qZazHr2NQ1o2Qm3lznE8/NkLZrBJcg9zoOVzUUY9gnF04nkuDSh3kybXz8V8Y
	apLsDMaVBgKM1Vj+j2MaNR9gRO2no95BBlPXpXq7JiYGCJi5jUwKmQVH1/zmKHi897jqJqWnP/uoN
	F8Y+q2niYwI3ka/qqfW+BRkbKQT5BaSnNz5MOuIjxUa4o7a9QlivaLzypsCVjKAvsr+0FoBNMh2Dg
	p3DXtjz8kFGgHi+Kgmv8f5VOrfJJH4gxbrvvI6QF76+XuQIK1Fjyt/A4UTWVBBI16Z9vIRn1jJ9cv
	B18ZTZOA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhU-00000006DDB-3Cm1;
	Wed, 17 Dec 2025 06:07:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 2/9] fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
Date: Wed, 17 Dec 2025 07:06:45 +0100
Message-ID: <20251217060740.923397-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217060740.923397-1-hch@lst.de>
References: <20251217060740.923397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This should slightly improve performance for large zeroing operations,
but more importantly prepares for blk-crypto refactoring that requires
all fscrypt users to call submit_bio directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/bio.c | 86 +++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 68b0424d879a..c2b3ca100f8d 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -47,49 +47,71 @@ bool fscrypt_decrypt_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
+struct fscrypt_zero_done {
+	atomic_t		pending;
+	blk_status_t		status;
+	struct completion	done;
+};
+
+static void fscrypt_zeroout_range_done(struct fscrypt_zero_done *done)
+{
+	if (atomic_dec_and_test(&done->pending))
+		complete(&done->done);
+}
+
+static void fscrypt_zeroout_range_end_io(struct bio *bio)
+{
+	struct fscrypt_zero_done *done = bio->bi_private;
+
+	if (bio->bi_status)
+		cmpxchg(&done->status, 0, bio->bi_status);
+	fscrypt_zeroout_range_done(done);
+	bio_put(bio);
+}
+
 static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 					      pgoff_t lblk, sector_t sector,
 					      unsigned int len)
 {
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
-	struct bio *bio;
-	int ret, err = 0;
-	int num_pages = 0;
-
-	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
-			GFP_NOFS);
+	struct fscrypt_zero_done done = {
+		.pending	= ATOMIC_INIT(1),
+		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
+	};
 
 	while (len) {
-		unsigned int blocks_this_page = min(len, blocks_per_page);
-		unsigned int bytes_this_page = blocks_this_page << blockbits;
+		struct bio *bio;
+		unsigned int n;
 
-		if (num_pages == 0) {
-			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
-			bio->bi_iter.bi_sector = sector;
-		}
-		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
-		if (WARN_ON_ONCE(ret != bytes_this_page)) {
-			err = -EIO;
-			goto out;
-		}
-		num_pages++;
-		len -= blocks_this_page;
-		lblk += blocks_this_page;
-		sector += (bytes_this_page >> SECTOR_SHIFT);
-		if (num_pages == BIO_MAX_VECS || !len ||
-		    !fscrypt_mergeable_bio(bio, inode, lblk)) {
-			err = submit_bio_wait(bio);
-			if (err)
-				goto out;
-			bio_reset(bio, inode->i_sb->s_bdev, REQ_OP_WRITE);
-			num_pages = 0;
+		bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
+				GFP_NOFS);
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_private = &done;
+		bio->bi_end_io = fscrypt_zeroout_range_end_io;
+		fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
+
+		for (n = 0; n < BIO_MAX_VECS; n++) {
+			unsigned int blocks_this_page =
+				min(len, blocks_per_page);
+			unsigned int bytes_this_page = blocks_this_page << blockbits;
+
+			__bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
+			len -= blocks_this_page;
+			lblk += blocks_this_page;
+			sector += (bytes_this_page >> SECTOR_SHIFT);
+			if (!len || !fscrypt_mergeable_bio(bio, inode, lblk))
+				break;
 		}
+
+		atomic_inc(&done.pending);
+		submit_bio(bio);
 	}
-out:
-	bio_put(bio);
-	return err;
+
+	fscrypt_zeroout_range_done(&done);
+
+	wait_for_completion(&done.done);
+	return blk_status_to_errno(done.status);
 }
 
 /**
-- 
2.47.3


