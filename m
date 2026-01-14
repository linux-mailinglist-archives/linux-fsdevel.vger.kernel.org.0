Return-Path: <linux-fsdevel+bounces-73635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E371D1CEF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7F5F301987B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19137BE94;
	Wed, 14 Jan 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KpdvRPs+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CE37B40C;
	Wed, 14 Jan 2026 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376586; cv=none; b=ka/LXJhZLA6w0W7lz/X247Zj4E+zK/Gy3yr6vrH+tmXm/wua8vq5egj5bJcn+VwLdIUeK2P7gJdkTyjwmSKEZ5+vEa6xTvwpqahYcUTYHqK5foOlb5Amlg6ZZdXy9eHK1cwBiC3tns5+Dv8jred2vvvC26f2i2P0yBGeetUOTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376586; c=relaxed/simple;
	bh=8E4Li0VZiCImyO00ZQPpgTtK4y4Rg+szb423ol0X7Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtBMe9kEKWecxSGMh4ulwCzHhXYDbQjHrByGDLUQE1Bo0WUntSKaLSP1awAcAmxEqwTQRRPPauGeS/W5GFCakkSkFUKozPhzIdfwDRz5Yja89gifOqWlDJoJpQ6rMIZd7sPaUGiCcj4VXqRcGOBuORa5qZo64qQ1/5JClWa954E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KpdvRPs+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y9CrtdnZzPRLgqfqHK3t33AcCsmiURplLB317zA48bg=; b=KpdvRPs+Py28JHfjULi6xRaEDu
	1QEnUmst6WHCmLp/DZImblA0che+H87qhbz6EorKN2c0HOpxZEZDU+/RmblFPPqwdN+gSyxAOZ1yp
	0POSQ+tg8OdcFqEPzo1CC5KsHGiJaehhy10poNu8VGtfvUiJOibWbMMgZ6iFMwI9NZ/XlRhm28PCP
	LAAoQZxowfOKWvwTBy8IobZbX4m+x/UwGJ290Cu1A/KOtgv2bII3HXerIDnoILtTfz8rff5KQFhdg
	vLqmSR61ymvFa0vm8Morl9W4DcRj5JVSpaJ99+/164YMEIHixbz9JJP/EWR3xp9gbrJ/BD5ILInO7
	6GDMS3Sw==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWt-00000008E1C-1UJ8;
	Wed, 14 Jan 2026 07:42:59 +0000
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
Date: Wed, 14 Jan 2026 08:41:11 +0100
Message-ID: <20260114074145.3396036-14-hch@lst.de>
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

Add a new flag that request bounce buffering for direct I/O.  This is
needed to provide the stable pages requirement requested by devices
that need to calculate checksums or parity over the data and allows
file systems to properly work with things like T10 protection
information.  The implementation just calls out to the new bio bounce
buffering helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 30 ++++++++++++++++++++----------
 include/linux/iomap.h |  9 +++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 3f552245ecc2..83fef3210e2b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -214,7 +214,11 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
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
@@ -300,12 +304,16 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
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
@@ -314,7 +322,11 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
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
@@ -330,7 +342,8 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if (dio->flags & IOMAP_DIO_USER_BACKED)
+	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
+		 !(dio->flags & IOMAP_DIO_BOUNCE))
 		bio_set_pages_dirty(bio);
 
 	/*
@@ -659,7 +672,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = 0;
+	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;
@@ -668,9 +681,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
-		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
-
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6bb941707d12..ea79ca9c2d6b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -566,6 +566,15 @@ struct iomap_dio_ops {
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


