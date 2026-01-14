Return-Path: <linux-fsdevel+bounces-73633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E2D1CEEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 392533026A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24437A48D;
	Wed, 14 Jan 2026 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QmvlzNkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FE37A4BA;
	Wed, 14 Jan 2026 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376576; cv=none; b=t8RJP7hU3a+ox2FDGeJzcMN8PQbxi3CPIwzCYzyMQjHNdPbHNFoDEMXK41Mg2JSc4o5PYscHwDeDBkURhi1gDKl+GKEHvqMlA2o7pTv5lzOfi5L0H+2iwXffo5QjNKgB0ogc+spUrf+48P2tedLizTsJ5RDWSWQfDbZvgta7oTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376576; c=relaxed/simple;
	bh=5VQgOGXiZXcrRwSJPx/MNAnwonvazbXL90avC/MZJQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+YprgZD8kwPdzhehv0FMgvWtQiFjI4jozWcz3rjAoBLblkEYwxTQKFAeEEqv8859YWXMYwbB/N9uTb4UnWT12w8lRnmt8+Dv7DwMP6OCN+pVeX/u0o9EefTcELx2H759f3j9ttSFQGdZUmXRPa/BaF7DesXVRifEsTpxwzjPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QmvlzNkh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NVd/w2lP89V0pNSIqN7l1P0a3hfcAKXMuZIg+thPkfk=; b=QmvlzNkhTsRk30K0c9n2TaS3mj
	WFgohdGTQ0u4YLGiMeEwfoIdKEKFCxXmuZzbTJtD5/LDVdI5gTkyefRzsTiMVG6Eguy08iX9Pzgeo
	eQKMvHTasc1tR1PTNkR1hq67aJfwnoZD+3AbhFPZUU4B/c75jhSZsILSnZ8C8O1pvwyF/+8saKL5X
	1EFGcb/a6TFN2E9DmvjGd9xjOO+PurM/m33oeBYI2FzG7KN3b6ghCoC/rKN2GFb47tK6nV5QboA86
	g/hvacWcVg6tKPzfLeNIsL4ryJfvRgJ1S4aUHFFROUjsGcNnoXVw2+rFEL3pzxqaNO5QHY6/hiF6P
	ZG6oYPcg==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWk-00000008Dyp-3L48;
	Wed, 14 Jan 2026 07:42:51 +0000
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
Subject: [PATCH 11/14] iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
Date: Wed, 14 Jan 2026 08:41:09 +0100
Message-ID: <20260114074145.3396036-12-hch@lst.de>
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

Match the more descriptive iov_iter terminology instead of encoding
what we do with them for reads only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6f7036e72b23..3f552245ecc2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -21,7 +21,7 @@
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
 #define IOMAP_DIO_NEED_SYNC	(1U << 29)
 #define IOMAP_DIO_WRITE		(1U << 30)
-#define IOMAP_DIO_DIRTY		(1U << 31)
+#define IOMAP_DIO_USER_BACKED	(1U << 31)
 
 struct iomap_dio {
 	struct kiocb		*iocb;
@@ -214,7 +214,7 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
-	if (dio->flags & IOMAP_DIO_DIRTY) {
+	if (dio->flags & IOMAP_DIO_USER_BACKED) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
@@ -330,7 +330,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if (dio->flags & IOMAP_DIO_DIRTY)
+	else if (dio->flags & IOMAP_DIO_USER_BACKED)
 		bio_set_pages_dirty(bio);
 
 	/*
@@ -676,7 +676,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 
 		if (user_backed_iter(iter))
-			dio->flags |= IOMAP_DIO_DIRTY;
+			dio->flags |= IOMAP_DIO_USER_BACKED;
 
 		ret = kiocb_write_and_wait(iocb, iomi.len);
 		if (ret)
-- 
2.47.3


