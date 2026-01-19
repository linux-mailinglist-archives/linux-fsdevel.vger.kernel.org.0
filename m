Return-Path: <linux-fsdevel+bounces-74392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1BD3A052
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FAC2300D80A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2963375CB;
	Mon, 19 Jan 2026 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xeCMvocX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A19337BA1;
	Mon, 19 Jan 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808702; cv=none; b=MpZcqfSO+ihd178TV9XCNyuOX3d+7o7BiAbHDP/teBR7oj//aHk/FD9wPZy/Y6GkocDB09+Bs5VNzg+NECTZLVpW0d1aCcnkEXmMHsP5ogV8o5YSBTs/ls+j7+MzwAyxmeq3ZACoxnZeQLxpKCobmonL1bdytjYyuK1gxNA5Eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808702; c=relaxed/simple;
	bh=kIdyT9uMba8ax7w9baNLVCHpPvhLJjsv564X4kkBAIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUQ+ptUpmicVLjTw7InAF2saCSLU/DyNz6MHeLCcVvhVkgf2G9czeNgIvM5g42UFeKXIhLebTlzOq0E0RZuwkfgyCAXOBUY17QusZdtrTE45ZzEgzQQhsl3LhnL3aXgqKkTXJou+Gzj0Vh792CCrJ2/QzWq0eWgVLtDO64U4X1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xeCMvocX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OCn6Agn3dxTtCCj8uKqwtExI0Gh45qGZRi4fUORJaB8=; b=xeCMvocXxpO2zPyTKilIr5qoY+
	HU1mwBuzPHdD8CoUv7ahMB02o3P1tEl2VsE7+l+5Th1XYElUEajf1vNklaTugZrnEgH3VU1FAyHdU
	AYfMghM8I43vHjvmbaUDMP7VjKZbIKi8V84iZDmNrF/ZOi7lLjCXXpZJQjhBXiEBtRLDnuOG6XHkN
	5GVlxLoA6IYdiClO5aZ6J4qGD1YSF9uQrMsv9xZmMa02SGk50Sob2VgDGEoOv0u1tMHXFWhaxyNzE
	nrTUvydxj01+bM/LGJ7CbqdhpAqMh8Ia6yHTxcJK4EuptTY2+FdRsR+ZKT2OYH+YbQYhbOndTnfFc
	ZqlNw0Ow==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwZ-00000001WCV-2O8h;
	Mon, 19 Jan 2026 07:45:00 +0000
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
Date: Mon, 19 Jan 2026 08:44:14 +0100
Message-ID: <20260119074425.4005867-8-hch@lst.de>
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

Use iov_iter_count to check if we need to continue as that just reads
a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
the actual number of vectors to allocate for the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 867c0ac6df8f..de03bc7cf4ed 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -312,7 +312,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	int nr_pages, ret = 0;
+	int ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 	unsigned int alignment;
@@ -440,7 +440,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
 
@@ -453,7 +452,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 		}
 
-		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
+		bio = iomap_dio_alloc_bio(iter, dio,
+				bio_iov_vecs_to_alloc(dio->submit.iter,
+						BIO_MAX_VECS), bio_opf);
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
@@ -495,16 +496,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
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


