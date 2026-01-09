Return-Path: <linux-fsdevel+bounces-73001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24848D07554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 07:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB3F304E5F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 06:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49562C1589;
	Fri,  9 Jan 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fn29MKgc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6528934F;
	Fri,  9 Jan 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938907; cv=none; b=avSOo2b7izGwcDbQUTumLCep4gESY5TGY+eVVompvLomdwNFD8dFEh7fa5OowmYCdP4pcn0S0g0frFZAZ9DHl7y9aPtE1kJTomwSPTJrtXVvu43D1qLO0Ukx2yo0d5in7Bqy1MkuwQdRbqvgXOV0n6l2HcByesCF6kKVbQ2WkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938907; c=relaxed/simple;
	bh=kem2m2eUDE4k+KhL2rN3cSp7QaY3fXSsl80MWZLtFpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXOD+HuSLUHCizLr9CBYEN3sq7b61lAiz+jsmnCVEhSj9StPNmzYc3qF9HPnLOAVhS2SG/QpAxM2C/WCu3K9CNktbLxLuJ8oDXD9jLx9FdjVSxEC9LNT5/nIM0jfib20bMI1RsPWBe34S6MAFPcuGZiDeqfrMEu3dmyuSWsMI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fn29MKgc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NwDc3eWt44SMvPQrlSWqoaKOT+KSCiuB5doX9517C78=; b=fn29MKgcNtldnr6Sdqwc5W7t/F
	7+cA4ylhRAfrD03msG+SQ/gtALtcCDBkOM1d5mheuh+00gVHeE2uTaBw9Vlo/UDb+p7CPYe1sd9Wq
	qad73zfGdll/VnQXgP2bTLzdYULUdOX0glNWEXhTaEHxvzyUHe5w7YCmpZQ6q3eP3olPhykI/zkhD
	LYhQGk56cB2QTbjQoqwpErCDlEvvhIgMbFQgfdvy7vt+aq7fOa6P6vE4d1BxONQnGt4SdiD34l0Sr
	DV96ZBqoj4rdfqRkGaMtZ6AgMpbCbpH0CIeKMvJ5AVjlUCO2P5cO5rxZfNdKHRLUaxbBJtorC8u5i
	J8wPD6xg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5fd-00000001WTc-0zpJ;
	Fri, 09 Jan 2026 06:08:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 2/9] fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
Date: Fri,  9 Jan 2026 07:07:42 +0100
Message-ID: <20260109060813.2226714-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109060813.2226714-1-hch@lst.de>
References: <20260109060813.2226714-1-hch@lst.de>
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


