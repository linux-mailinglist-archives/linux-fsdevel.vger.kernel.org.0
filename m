Return-Path: <linux-fsdevel+bounces-49230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60AAB99D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1573BED20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C3236443;
	Fri, 16 May 2025 10:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144723184F;
	Fri, 16 May 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390288; cv=none; b=oapsMz0o/77Un2mqhu1yx8KCWnEp7zIilhsZ7a9JEJiQw3g26DEOFqE1JDsdWxFI0gILuI0OJTlGwkGAGnXESnHIm8gh1hMSgwCQx/wSDe0pYudls04TYlSFTimYqjx4okC7NM1CdxYF/iSjS204ButSVOfZ77cHipfoDsj4hLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390288; c=relaxed/simple;
	bh=YurZ2FzxP3Y4no0Ti7m/BM4bZkV94wobNRj9pR79ess=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hW4KkDBJgajYRIq0Q7cspNoL5bT31oiDFnghuT9uTk/1f3Z7lkSvh+4kdpDItg9minQd2QBDj3RTLVlazZGj/tr3pSUowsaxOrY/bE5jN4f9Yy2xP8JILteU2GRcoEuk5Sc6ZkVklOKHr81WP35ZUbkmy3otIOalFf1NanNCiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZzNCG6SMtz9tCG;
	Fri, 16 May 2025 12:11:22 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: "Darrick J . Wong" <djwong@kernel.org>,
	hch@lst.de,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 3/3] iomap: use LARGE_ZERO_PAGE in iomap_dio_zero()
Date: Fri, 16 May 2025 12:10:54 +0200
Message-ID: <20250516101054.676046-4-p.raghav@samsung.com>
In-Reply-To: <20250516101054.676046-1-p.raghav@samsung.com>
References: <20250516101054.676046-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZzNCG6SMtz9tCG

Use LARGE_ZERO_PAGE instead of custom allocated 64k zero pages. The
downside is we might end up using ZERO_PAGE on systems that do not
enable LARGE_ZERO_PAGE feature.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/iomap/direct-io.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 844261a31156..6a2b6726a156 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -29,13 +29,6 @@
 #define IOMAP_DIO_WRITE		(1U << 30)
 #define IOMAP_DIO_DIRTY		(1U << 31)
 
-/*
- * Used for sub block zeroing in iomap_dio_zero()
- */
-#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
-#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
-static struct page *zero_page;
-
 struct iomap_dio {
 	struct kiocb		*iocb;
 	const struct iomap_dio_ops *dops;
@@ -290,23 +283,29 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct bio *bio;
+	int nr_vecs = max(1, i_blocksize(inode) / ZERO_LARGE_PAGE_SIZE);
 
 	if (!len)
 		return 0;
 	/*
 	 * Max block size supported is 64k
 	 */
-	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
+	if (WARN_ON_ONCE(len > SZ_64K))
 		return -EINVAL;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, zero_page, len, 0);
+	while (len) {
+		unsigned int io_len = min_t(unsigned int, len, ZERO_LARGE_PAGE_SIZE);
+
+		__bio_add_page(bio, ZERO_LARGE_PAGE(0), len, 0);
+		len -= io_len;
+	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 	return 0;
 }
@@ -827,15 +826,3 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return iomap_dio_complete(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
-
-static int __init iomap_dio_init(void)
-{
-	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				IOMAP_ZERO_PAGE_ORDER);
-
-	if (!zero_page)
-		return -ENOMEM;
-
-	return 0;
-}
-fs_initcall(iomap_dio_init);
-- 
2.47.2


