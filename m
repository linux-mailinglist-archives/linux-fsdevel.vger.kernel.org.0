Return-Path: <linux-fsdevel+bounces-66569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A809C24320
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 101CC4F214C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350632ED25;
	Fri, 31 Oct 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TzEFMIl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC49329E52;
	Fri, 31 Oct 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903351; cv=none; b=GUqjm+k3TTptOUO+dSW92eehgY521wirVCWf4LVzb/nS49kXb4AEVIu2RlzupqQuDctOrTICXykAnmgO/7hm4RZKyfpZut0q0eQ9XAZSI/4r3qHabvtT7b7GrwynTKIALc9essH9oZ5JZEmqwAd9cWdgsbxSBW7cJS2CY9AleQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903351; c=relaxed/simple;
	bh=X9MLjma7uhZO/0i+DLzlMxafkdqc9buddltRkvQRWdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmAWGp2O1iwtcDi1M0apmZDpOvRMlch4IyHua8TqWTlZXNcXpW22fG+6SbfboaHjttDOy6vzvNJiQdPVwt7ovPEoI88IVeW65mwW2V+HUpocVEj3l6e/EjQBY7a0N+QVp86+m3Cj2vFamTQVB/DJaJ74qk7JtvAaB8O8BPzIOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TzEFMIl8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/eGr74zsRzAU6OL6XbDU9Oe1mu1cYgCgFsZlvySTvhg=; b=TzEFMIl8e7H9NR/1Vsg72X/oAk
	SMQswToabwncR98vtmyq7E5R+2eeB5n+b+ye5aIzQZHS4MPW63XYTRI61lj6eUbOUjE1P66GDJVS6
	Q3gZD3BmZcVkAtdbV6ENbbaxVYh7jqnXJXjuKnfQJKlPlppxNTF3Ieken9KjBBnplH7kQOew7t/NZ
	W30LDuIqAvbFjB+EeOMIf6II+08jJcIZj0Ud4pQFa9kSzUgYsYES3bvbegwTgKQlRO9e7ARdvAM5k
	7YYNVJleH9Mr1jFvcBswK7HvuBCZx9+17Dy9z73EqHWCpms87hqDqJyLppxoMUaAZAurwQjyEnNpX
	DksVzK5Q==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElXv-00000005or6-2pZf;
	Fri, 31 Oct 2025 09:35:48 +0000
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
Subject: [PATCH 5/9] fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
Date: Fri, 31 Oct 2025 10:34:35 +0100
Message-ID: <20251031093517.1603379-6-hch@lst.de>
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

This should slightly improve performance for large zeroing operations,
but more importantly prepares for blk-crypto refactoring that requires
all fscrypt users to call submit_bio directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 84 +++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 68b0424d879a..e59d342b4240 100644
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
+	struct fscrypt_zero_done done = {};
 
-	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
-			GFP_NOFS);
+	atomic_set(&done.pending, 1);
+	init_completion(&done.done);
 
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


