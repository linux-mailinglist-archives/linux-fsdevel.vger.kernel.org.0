Return-Path: <linux-fsdevel+bounces-73629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB173D1CEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4363830B4B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F037B413;
	Wed, 14 Jan 2026 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nODbZWXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48437A498;
	Wed, 14 Jan 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376551; cv=none; b=Qa1zGTuJNfkBwWUMgdgxNYfIp7zobpqrFoR6KCDB9Fk1ByPhTtOPopgfO8N/5lAm8I22OFmF9mGFP4+wKzlM4T+hdo2jzAGb+t/biyjA7MSHEuw/rS+mlGe4FkumKTyolGwS5ymWuRbx6hgCaKITPH9+HPu55zxrTk6LlkmP8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376551; c=relaxed/simple;
	bh=lllj+z1vmzQvX+r3nAjBhZqtyvgdBPBf/WfmOvLpk9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOyJjt7dQV7Rg+q8jT/r1KrFcV8ocBnYCAK1qmYP0661SMb7tku9CDU/Aur1ouXwsWRyZ+GeY2bA3BJtHmKrF0GHhRd/JPGPS2Kny70OcXX2z2sQgvuXsaEDaTEYRm5I5z2RfRSbEstsWyciGl8aOJKNU8gxSwO0mE3lLGRRuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nODbZWXN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6G939NxWgnGZv4snSrhTZl3E6mEY2Dpwyvfnk6df14E=; b=nODbZWXNJPdwsuBS2MdAKOTkqT
	W1CVNHEwK+wYK8mJk24rV+0Ca7AA/POI7zXoKSyXAH04B33BPudgNpSvGObnI4/WV/5VSRpHL05kR
	nZZjt/tKTthRL/g8PpjBmY5UL787Jg2/Td4kgaC6f7EVQb0uFqXYfx7JDT0G9arviGnRK5X0EWjjK
	lP3sL4KmbwFLM0FMb63sGW27tj3ueHTtfsKCAmuL2CLM59iBuphvH9ropZFuOdj6mgWPjeOioF7aM
	Z6boFzPykxjGyJSI3N7l9VuSu1YJJhXgP/l3hRnUM5wAF83n+cz61/ITGW3WIwlJly/KqgHAvEc3L
	PsvI5UPA==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWN-00000008Dto-0zAi;
	Wed, 14 Jan 2026 07:42:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/14] iomap: simplify iomap_dio_bio_iter
Date: Wed, 14 Jan 2026 08:41:05 +0100
Message-ID: <20260114074145.3396036-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use iov_iter_count to check if we need to continue as that just reads
a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
the actual number of vectors to allocate for the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6ec4940e019c..1acdab7cf5f1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -311,7 +311,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	int nr_pages, ret = 0;
+	int ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 	unsigned int alignment;
@@ -439,7 +439,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
 
@@ -452,7 +451,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 		}
 
-		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
+		bio = iomap_dio_alloc_bio(iter, dio,
+				bio_iov_vecs_to_alloc(dio->submit.iter,
+						BIO_MAX_VECS), bio_opf);
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
@@ -494,16 +495,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		dio->size += n;
 		copied += n;
 
-		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_VECS);
 		/*
 		 * We can only poll for single bio I/Os.
 		 */
-		if (nr_pages)
+		if (iov_iter_count(dio->submit.iter))
 			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(iter, dio, bio, pos);
 		pos += n;
-	} while (nr_pages);
+	} while (iov_iter_count(dio->submit.iter));
 
 	/*
 	 * We need to zeroout the tail of a sub-block write if the extent type
-- 
2.47.3


