Return-Path: <linux-fsdevel+bounces-73631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6542D1CEA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B3C530183BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E32FCBE3;
	Wed, 14 Jan 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1zcWhrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88837A49F;
	Wed, 14 Jan 2026 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376569; cv=none; b=VUUimwW3DP4WgkONm3HqvlWE8B29DhxE1rzji1NlJ2RXWYrJGHZndie5Op9e1uaCQ0BPupRYi1+zJ60w3xdFdenuZvZk8F2ncxDF7ecarXOGSr4/kO6I01XZMZyzs7TMHWQB8W5siuRXKmfyOEBJb3oiC90dMW/+9K4ALA9bMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376569; c=relaxed/simple;
	bh=vR/s5Q7QZjL6F8aEFJ31ettwJl60CR/zygPa3lg+4y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coVa4EAfOkBBzl/aA1V8+GD2zlR1a3GRqEziKKMuFudzdDz17nsPK58o1g1yYnD7uUG79cZ3nun0+OXR+x0srt8dxQyu4UOcfqzA5vdZPRtMMQrw7TPSNI9BEvHbvGuF41VrCt9p6xIFizjgDYLmGeSJPTCevxrU7IQ3f5xL2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f1zcWhrj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kMv9d8QdYMM4xsW8Vb//iYg+ilW0QrjA3ZcksDZVNnI=; b=f1zcWhrjPlyYeTq4JtDsksUnY1
	vxgee7i73XG743hK+lXbp87KqMmHm68Fhq9a+DZ1YTEqk2/FX71MMYwwSwoYRQ56v9TcmbXjVLLVo
	DLOG01QelT1QuxtBMpeEsWpn+bciRM21W6Ra1b1sIEvra+CHiVMvPFuAwccJ9SkCJZhH5iSPuryNN
	gvhyGNcvDYwuDBzuUQbZoByVSpYFp8e2RGe/4owS9hHf7u48rnDS5flcjdjvdIpt4DyEyCaRvyR/q
	/IGeBANbEnRQuG4J3H6UtjroKYqMf5YluZi81wMt4nVEXEDA8Z6ujJ33ZkUUZV2HdloVICrLpEy0T
	e4fkgAXQ==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWY-00000008Dw9-0qAo;
	Wed, 14 Jan 2026 07:42:39 +0000
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
Subject: [PATCH 09/14] iomap: share code between iomap_dio_bio_end_io and iomap_finish_ioend_direct
Date: Wed, 14 Jan 2026 08:41:07 +0100
Message-ID: <20260114074145.3396036-10-hch@lst.de>
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

Refactor the two per-bio completion handlers to share common code using
a new helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 63374ba83b55..bf59241a090b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -210,16 +210,20 @@ static void iomap_dio_done(struct iomap_dio *dio)
 	iomap_dio_complete_work(&dio->aio.work);
 }
 
-void iomap_dio_bio_end_io(struct bio *bio)
+static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 
-	if (bio->bi_status)
-		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
-
-	if (atomic_dec_and_test(&dio->ref))
+	if (atomic_dec_and_test(&dio->ref)) {
+		/*
+		 * Avoid another context switch for the completion when already
+		 * called from the ioend completion workqueue.
+		 */
+		if (inline_completion)
+			dio->flags &= ~IOMAP_DIO_COMP_WORK;
 		iomap_dio_done(dio);
+	}
 
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
@@ -228,33 +232,25 @@ void iomap_dio_bio_end_io(struct bio *bio)
 		bio_put(bio);
 	}
 }
+
+void iomap_dio_bio_end_io(struct bio *bio)
+{
+	struct iomap_dio *dio = bio->bi_private;
+
+	if (bio->bi_status)
+		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
+	__iomap_dio_bio_end_io(bio, false);
+}
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 {
 	struct iomap_dio *dio = ioend->io_bio.bi_private;
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 	u32 vec_count = ioend->io_bio.bi_vcnt;
 
 	if (ioend->io_error)
 		iomap_dio_set_error(dio, ioend->io_error);
-
-	if (atomic_dec_and_test(&dio->ref)) {
-		/*
-		 * Try to avoid another context switch for the completion given
-		 * that we are already called from the ioend completion
-		 * workqueue.
-		 */
-		dio->flags &= ~IOMAP_DIO_COMP_WORK;
-		iomap_dio_done(dio);
-	}
-
-	if (should_dirty) {
-		bio_check_pages_dirty(&ioend->io_bio);
-	} else {
-		bio_release_pages(&ioend->io_bio, false);
-		bio_put(&ioend->io_bio);
-	}
+	__iomap_dio_bio_end_io(&ioend->io_bio, true);
 
 	/*
 	 * Return the number of bvecs completed as even direct I/O completions
-- 
2.47.3


