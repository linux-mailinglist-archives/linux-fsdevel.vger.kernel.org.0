Return-Path: <linux-fsdevel+bounces-75433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJSlLBcCd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:56:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97B844DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DB59301CFB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D502367B5;
	Mon, 26 Jan 2026 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOzLpeDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4082253AB;
	Mon, 26 Jan 2026 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406897; cv=none; b=gtysTaEqRLA4+QynZgSAYeO6YCpOTFzIFuWPEZTUfauzTHhcEHg/rpP2UcLAZfIaIB4loXjjcVJY0K1b5rNNGy7QBRmGRMsDUuMY2jfjoOuis1nJoGslMIKJVl5JA7ZBAGSXmtygLT/n1GZG0OF1sJoMBp4Twjd/YygsPNtBZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406897; c=relaxed/simple;
	bh=JQI1+SHkTgmtPgGAUhB6DqCW/eW4YpKc5RgM7ntOUmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJ9f+1ZGI7X8aE6KaqGEf1wn1sKoHGMlEMtWcKa9cY7E6Q5Spke938h6g5VdshTjPlaG7epVf6pohktFlfVgHWIbfrPMfl8yAinwthN1idDWQjxKdE12K+R0Bv63iXC5QoTv9kIJP41LRndfQoYPxqsdGF7K/ibQQkygZTAoV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bOzLpeDR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F4tvsRwPwfrA8ZOJiY8aPM5yP4SxwEv17+JqySinbl8=; b=bOzLpeDRSrKidO/2NVQvJjALeD
	8bw8KKNvznT0oi3KZfOjcWpb8gGXDaiGbPe8ZZC6KuDbHvrw6O53kl4YMbeaDVl9O1FUxFiOqg7dn
	guNfUOAsS4RCZ49/VbelHokoQ8oDj7qCO/dk4LpyeoZ4dOe4jHn9Hh6CDbr5OHbqZxqbv+DG3mTzh
	TX8SW9MZBdhGeW/O0kdJkKTOG9EYEe7jWBKf2y1nBw+ubnl6BA3TmJqoCLBGCQQMEWDFN7QYAQiAD
	cT5Bl6gOxdMbKGsQ1dtvvS0lujwunJKNppqO8rcVZTEJgLxLYQtGgEOjXKZMkkZYW7W9JKz7wugVB
	bDdn75bA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFYs-0000000BxHq-3mhH;
	Mon, 26 Jan 2026 05:54:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 09/15] iomap: split out the per-bio logic from iomap_dio_bio_iter
Date: Mon, 26 Jan 2026 06:53:40 +0100
Message-ID: <20260126055406.1421026-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
References: <20260126055406.1421026-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75433-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,samsung.com:email,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A97B844DB
X-Rspamd-Action: no action

Factor out a separate helper that builds and submits a single bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
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


