Return-Path: <linux-fsdevel+bounces-74393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E58D3A05B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A5530164EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE863382DE;
	Mon, 19 Jan 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0O5AJ9T+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395F337BBF;
	Mon, 19 Jan 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808709; cv=none; b=gkGXGVzq1xZDu0ErDMta8KwQgWE45cZBWspMGDi1UC1TjNpAJpwTXpoCmHdjJU8spIR4lm7ir7yBUoUbmf8nNPseAf8n/VAGya3QwVbSi/xX7FZhWoaqM1qaklHQcZb6Yn5pazEBGp2kuOQZJ7AVj57WyuH6UAcsPfV2wFs8WZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808709; c=relaxed/simple;
	bh=ixY4LDcGVvh/08lPoxOnMev4OtiXv2pGCeiqH0+BOKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIMuOWiNVwbxcj4C7lHJ6qt6d8yYhdgMaUmX0PotszeMQ2gbW0wZ7tCbCmhDQFdluXwARf4ulvFE3uAFhMoBMABjAdzTS1To1EzVUZH/KQER88mK4J5YjZ6pTVOrz3goQQDZybogNR82bRNUJ+z7jrHLOGWOczsX66u5rEBBtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0O5AJ9T+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5w02D5j42/OrJmaJzJ0j67ts4lQV/SA8wsOHvs0Gjkg=; b=0O5AJ9T+YxtlpIsGuONCP1VlhE
	HhaW59r3iz9uvpgoGe5E/xi7eoEv2rNwMPVvet3BiSr2jkcnnDStWUkp2ncp82WWveZkA2NwAffI4
	YEHmueLMi2cxAf9NNBrm1OC01Y8Jvp63n3yUNkk+izjklXx858nWdSZdsaCQVwkmBQMtBSnTeMVKg
	AilKtq7XbcKcieont/dTJ7Ss6kYqovqo8wx/BJOYWdQ2eDpj52sGfGPTi9gfmtbrEk+eWvohOxLwi
	PCSMy3BOVjqqdCJOgZAT1kY9W7iifV8dFK0jjqEykVPqEgubzHTtj9weN5ynW0ZowGuMCdA+XrRoi
	Y8rLlNug==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwg-00000001WDz-0IYa;
	Mon, 19 Jan 2026 07:45:06 +0000
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
Subject: [PATCH 08/14] iomap: split out the per-bio logic from iomap_dio_bio_iter
Date: Mon, 19 Jan 2026 08:44:15 +0100
Message-ID: <20260119074425.4005867-9-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Factor out a separate helper that builds and submits a single bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 111 +++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 52 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index de03bc7cf4ed..bb79519dec65 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -302,6 +302,56 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	return 0;
 }
 
+static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
+		struct iomap_dio *dio, loff_t pos, unsigned int alignment,
+		blk_opf_t op)
+{
+	struct bio *bio;
+	ssize_t ret;
+
+	bio = iomap_dio_alloc_bio(iter, dio,
+			bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS),
+			op);
+	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
+			pos >> iter->inode->i_blkbits, GFP_KERNEL);
+	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
+	bio->bi_write_hint = iter->inode->i_write_hint;
+	bio->bi_ioprio = dio->iocb->ki_ioprio;
+	bio->bi_private = dio;
+	bio->bi_end_io = iomap_dio_bio_end_io;
+
+	ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);
+	if (unlikely(ret))
+		goto out_put_bio;
+	ret = bio->bi_iter.bi_size;
+
+	/*
+	 * An atomic write bio must cover the complete length.  If it doesn't,
+	 * error out.
+	 */
+	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
+		ret = -EINVAL;
+		goto out_put_bio;
+	}
+
+	if (dio->flags & IOMAP_DIO_WRITE)
+		task_io_account_write(ret);
+	else if (dio->flags & IOMAP_DIO_DIRTY)
+		bio_set_pages_dirty(bio);
+
+	/*
+	 * We can only poll for single bio I/Os.
+	 */
+	if (iov_iter_count(dio->submit.iter))
+		dio->iocb->ki_flags &= ~IOCB_HIPRI;
+	iomap_dio_submit_bio(iter, dio, bio, pos);
+	return ret;
+
+out_put_bio:
+	bio_put(bio);
+	return ret;
+}
+
 static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -310,12 +360,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
-	struct bio *bio;
 	bool need_zeroout = false;
-	int ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 	unsigned int alignment;
+	ssize_t ret = 0;
 
 	/*
 	 * File systems that write out of place and always allocate new blocks
@@ -441,68 +490,27 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	}
 
 	do {
-		size_t n;
-
 		/*
 		 * If completions already occurred and reported errors, give up now and
 		 * don't bother submitting more bios.
 		 */
-		if (unlikely(data_race(dio->error))) {
-			ret = 0;
+		if (unlikely(data_race(dio->error)))
 			goto out;
-		}
 
-		bio = iomap_dio_alloc_bio(iter, dio,
-				bio_iov_vecs_to_alloc(dio->submit.iter,
-						BIO_MAX_VECS), bio_opf);
-		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
-					  GFP_KERNEL);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-		bio->bi_write_hint = inode->i_write_hint;
-		bio->bi_ioprio = dio->iocb->ki_ioprio;
-		bio->bi_private = dio;
-		bio->bi_end_io = iomap_dio_bio_end_io;
-
-		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
-					     alignment - 1);
-		if (unlikely(ret)) {
+		ret = iomap_dio_bio_iter_one(iter, dio, pos, alignment, bio_opf);
+		if (unlikely(ret < 0)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
 			 * through to the sub-block tail zeroing here, otherwise
 			 * this short IO may expose stale data in the tail of
 			 * the block we haven't written data to.
 			 */
-			bio_put(bio);
-			goto zero_tail;
-		}
-
-		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
-			/*
-			 * An atomic write bio must cover the complete length,
-			 * which it doesn't, so error. We may need to zero out
-			 * the tail (complete FS block), similar to when
-			 * bio_iov_iter_get_pages() returns an error, above.
-			 */
-			ret = -EINVAL;
-			bio_put(bio);
-			goto zero_tail;
+			break;
 		}
-		if (dio->flags & IOMAP_DIO_WRITE)
-			task_io_account_write(n);
-		else if (dio->flags & IOMAP_DIO_DIRTY)
-			bio_set_pages_dirty(bio);
-
-		dio->size += n;
-		copied += n;
-
-		/*
-		 * We can only poll for single bio I/Os.
-		 */
-		if (iov_iter_count(dio->submit.iter))
-			dio->iocb->ki_flags &= ~IOCB_HIPRI;
-		iomap_dio_submit_bio(iter, dio, bio, pos);
-		pos += n;
+		dio->size += ret;
+		copied += ret;
+		pos += ret;
+		ret = 0;
 	} while (iov_iter_count(dio->submit.iter));
 
 	/*
@@ -511,7 +519,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	 * the block tail in the latter case, we can expose stale data via mmap
 	 * reads of the EOF block.
 	 */
-zero_tail:
 	if (need_zeroout ||
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
 		/* zero out from the end of the write to the end of the block */
-- 
2.47.3


