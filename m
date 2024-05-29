Return-Path: <linux-fsdevel+bounces-20443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C888D3846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C2428BF15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B8A4E1CE;
	Wed, 29 May 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="NUYJ7pDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA11CA85;
	Wed, 29 May 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990353; cv=none; b=QRiBEvNaafZXHolDdTGdIYJIVovHP4R/ZXINZl2vi0sTwrnfogM86ZMaSb1vSAaZL1nw5wgp7jBAsOHWkJbxPZChCptQgXRMVNB9u2cx8HDC3/t/u8aydi6TN4m2o9c7Xba6fwSWv+c+MJM1hGRaGvdEDAEAJbKh+hOpX3WAbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990353; c=relaxed/simple;
	bh=vSt7GzJ0ss7bCs3HEqvp3HU8bnYpr1BdYGsMVvbZNzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzEgMXhLHwaUbaDQN6jZlNcgRqrZpilw01XzFdHEgG3y81rd/qEs9j4OH7TdXYmDXxFOJzWfCn02MaPbkj33xdSrJqOVMl9LukoMZta8HaUTEIttZOMOZ7KsjBWLNLAqXcMMQKKkf8I0eFZG5xLpWlu185cEDd+HE1H+bTvHNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=NUYJ7pDe; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vq9d80z8Fz9sqr;
	Wed, 29 May 2024 15:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRJNlq7gVNU9I4tEFfojUYVu+p8wArfYUJ6q9izpCCA=;
	b=NUYJ7pDeclNdi7QRK++Dp5VL9zrEcwXU9xsGVgXvv2EEW23dQf7srN5Ji7vfC3d8WgJQko
	qAXJR123EPpxL8sX1KJaB0F4CA5JA5mkw8Z1nnxni24NQgV+OmmSHJbatQXqi2/QYRAL1j
	tmsToUP4sNiMFEz06xbIj2y2MfrAzroSgYT+SW46dv4/avjtoUmgRV3kSCHETds7CJpX5D
	WFFQh8Ec3CwYcRAD2QRHbx9MtSFAhaca5b2kCuG8C1kf6n1tPSoFBYnAEgJ8HeQFvGznXp
	o5wG4QUeS0m/kEhlHnzzWyvHFVtlh5O4nBS/xBDbfKb/kguGkgIHImCIH+LWyw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 07/11] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Wed, 29 May 2024 15:45:05 +0200
Message-Id: <20240529134509.120826-8-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9d80z8Fz9sqr

From: Pankaj Raghav <p.raghav@samsung.com>

iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
< fs block size. iomap_dio_zero() has an implicit assumption that fs block
size < page_size. This is true for most filesystems at the moment.

If the block size > page size, this will send the contents of the page
next to zero page(as len > PAGE_SIZE) to the underlying block device,
causing FS corruption.

iomap is a generic infrastructure and it should not make any assumptions
about the fs block size and the page size of the system.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---

After disucssing a bit in LSFMM about this, it was clear that using a
PMD sized zero folio might not be a good idea[0], especially in platforms
with 64k base page size, the huge zero folio can be as high as
512M just for zeroing small block sizes in the direct IO path.

The idea to use iomap_init to allocate 64k zero buffer was suggested by
Dave Chinner as it gives decent tradeoff between memory usage and efficiency.

This is a good enough solution for now as moving beyond 64k block size
in XFS might take a while. We can work on a more generic solution in the
future to offer different sized zero folio that can go beyond 64k.

[0] https://lore.kernel.org/linux-fsdevel/ZkdcAsENj2mBHh91@casper.infradead.org/

 fs/internal.h          | 8 ++++++++
 fs/iomap/buffered-io.c | 5 +++++
 fs/iomap/direct-io.c   | 9 +++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 84f371193f74..18eedbb82c50 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -35,6 +35,14 @@ static inline void bdev_cache_init(void)
 int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block, const struct iomap *iomap);
 
+/*
+ * iomap/buffered-io.c
+ */
+
+#define ZERO_FSB_SIZE (65536)
+#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
+extern struct page *zero_fs_block;
+
 /*
  * char_dev.c
  */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5802a459334..2c0149c827cd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,6 +42,7 @@ struct iomap_folio_state {
 };
 
 static struct bio_set iomap_ioend_bioset;
+struct page *zero_fs_block;
 
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs)
@@ -1998,6 +1999,10 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
 
 static int __init iomap_init(void)
 {
+	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
+	if (!zero_fs_block)
+		return -ENOMEM;
+
 	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
 			   offsetof(struct iomap_ioend, io_bio),
 			   BIOSET_NEED_BVECS);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..50c2bca8a347 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -236,17 +236,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
-	struct page *page = ZERO_PAGE(0);
 	struct bio *bio;
 
+	/*
+	 * Max block size supported is 64k
+	 */
+	WARN_ON_ONCE(len > ZERO_FSB_SIZE);
+
 	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
+
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, page, len, 0);
+	__bio_add_page(bio, zero_fs_block, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
 
-- 
2.34.1


