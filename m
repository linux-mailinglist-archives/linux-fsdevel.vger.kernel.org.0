Return-Path: <linux-fsdevel+bounces-74398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C54D3A067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2E4F301B660
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAC271450;
	Mon, 19 Jan 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IIvxS30a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23B3382DF;
	Mon, 19 Jan 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808738; cv=none; b=TxFm7lAlwzDn2WWsaVHLbB76v0HlKd9wMRJC3HvNCwl6Pj3mScaWxXuBAyIpeitpkebCrmIGIThkhLpGEDEPKE0FNVHb3QQ20weYIGXjrR34n1qEYpT3ajsH5cLs3TzGp9hc5TRyPe3mCzlCTmp0Pzni0OevQGDcI2yczFW9PlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808738; c=relaxed/simple;
	bh=Ust0SjjhLimkbL2DQ9rNRPfhKvMQsEYPlNXiFQ2BC58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=updkAJ9E69UaqLae7ILYzXQIOirFtBQdLSOVaUMsoZ73QPUWVyfClbFp86GGLk4jEnAl8syE8Nd3s8GwsFfdu9/3D32LuFbZ9xD7ynDskiQqgOyVRTOekgbXhr1lcFRGN91fD7JtYGorkvp1HIlSizfZ+jfWL2WI3edMdHSpTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IIvxS30a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+yB+VlpGXumhR0iGK480HTRNjW6Ju+LqR+vU9uBFQik=; b=IIvxS30aHopvpVVPVU2Y6Tq/O9
	1I7PMhrUpB34OEWacEGANy8nJ48oOhChaH8M/5rKh3PhCUSOr3QLTiGz3LIaWxNwfNEjP09kHsBQ1
	w4DdNSAanuXwjnlO6X/Ja99KMlvenOpUZ/6kZP/T74ql95+L3S4ncnQO9hJ7hoVf4InH7ojr3Q4Bc
	w+25XMpHR4pfva4uhD8BfepG7RHcvUfjTa+kdInCVV/KZIRKpbX5qSOLf+QZlGufNfIq+DwOr+Jbt
	FtFCYDc4SpDc1/OzmuAXQeX95qyHhMKE4FfAexPRoiqI0OYiPUkC0O0xGcJtnILVdsmxlDeXfibIz
	GIQa6Dxg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjx4-00000001WGp-3KEq;
	Mon, 19 Jan 2026 07:45:33 +0000
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
Subject: [PATCH 13/14] iomap: add a flag to bounce buffer direct I/O
Date: Mon, 19 Jan 2026 08:44:20 +0100
Message-ID: <20260119074425.4005867-14-hch@lst.de>
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

Add a new flag that request bounce buffering for direct I/O.  This is
needed to provide the stable pages requirement requested by devices
that need to calculate checksums or parity over the data and allows
file systems to properly work with things like T10 protection
information.  The implementation just calls out to the new bio bounce
buffering helpers to allocate a bounce buffer, which is used for
I/O and to copy to/from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c  | 30 ++++++++++++++++++++----------
 include/linux/iomap.h |  9 +++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index eca7adda595a..9c572de0d596 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -215,7 +215,11 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
-	if (dio->flags & IOMAP_DIO_USER_BACKED) {
+	if (dio->flags & IOMAP_DIO_BOUNCE) {
+		bio_iov_iter_unbounce(bio, !!dio->error,
+				dio->flags & IOMAP_DIO_USER_BACKED);
+		bio_put(bio);
+	} else if (dio->flags & IOMAP_DIO_USER_BACKED) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
@@ -303,12 +307,16 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		struct iomap_dio *dio, loff_t pos, unsigned int alignment,
 		blk_opf_t op)
 {
+	unsigned int nr_vecs;
 	struct bio *bio;
 	ssize_t ret;
 
-	bio = iomap_dio_alloc_bio(iter, dio,
-			bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS),
-			op);
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		nr_vecs = bio_iov_bounce_nr_vecs(dio->submit.iter, op);
+	else
+		nr_vecs = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
+
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, op);
 	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
 			pos >> iter->inode->i_blkbits, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
@@ -317,7 +325,11 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
+	else
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+					     alignment - 1);
 	if (unlikely(ret))
 		goto out_put_bio;
 	ret = bio->bi_iter.bi_size;
@@ -333,7 +345,8 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if (dio->flags & IOMAP_DIO_USER_BACKED)
+	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
+		 !(dio->flags & IOMAP_DIO_BOUNCE))
 		bio_set_pages_dirty(bio);
 
 	/*
@@ -662,7 +675,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = 0;
+	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;
@@ -671,9 +684,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
-		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
-
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 520e967cb501..cf152f638665 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -562,6 +562,15 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
 
+/*
+ * Bounce buffer instead of using zero copy access.
+ *
+ * This is needed if the device needs stable data to checksum or generate
+ * parity.  The file system must hook into the I/O submission and offload
+ * completions to user context for reads when this is set.
+ */
+#define IOMAP_DIO_BOUNCE		(1 << 4)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.47.3


