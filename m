Return-Path: <linux-fsdevel+bounces-21245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC490080D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDE31F22155
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54719DF54;
	Fri,  7 Jun 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="G8rJmHPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299C19DF44;
	Fri,  7 Jun 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772384; cv=none; b=NsPGIlAsHGyJtY0hp0uHYHj5qX3Rh+zXolKwui+h59tJ3qbmGVnkCnMAa4rLJXfQUQJ6b2EG89LyHGf50KNGQN7smRaa9uLMMApbdxdmGRDwZ3W/WAnz2rKR57VZIkrR2u0mEEH9O47UQhOQGutid2TAeRPg4Ie7dquM0Qmt7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772384; c=relaxed/simple;
	bh=ov2TaelLlm3wME5xgPGGulvGW/SCE21E2+YFkubwphg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fy6vCVQd46Cvlz0ocVT8Nj7pyzqjVYIsDFOS0SIUp+JUkDh9fGwpuGjckZPPw9ZsVEOYBN35VSQv0o0fEBcvwHJzHVx2ki3yU3fJHE5SXnXj/Bl81xASN+CnfiIKo3Yx1ZKJQ9WnS3EWuv2uLEJGWoSOndLdX6Ta1wOEoSn9AKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=G8rJmHPP; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vwkr96mtFz9sQg;
	Fri,  7 Jun 2024 16:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717772377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sLXh3ItwEq5TYZ7rJHrfyrYcE/YpAXA+GtXY9esiOQ=;
	b=G8rJmHPPcxHDWg9xX/dktQ9HwiydrWEABafRT0DQVy8yun8SAsiK2HjYovvsfD5tVewnLU
	e7vCv0u+F3IDEkMs18wVCelFF2ytkEpFlyJ2UHfSCGpjQgl9Zm3XPmXkOE5Stwz+ivsiu5
	s+6IBi9WHp6kYkf1WfMmcP0yU+306PvjCpL45362UtPH2MixOdqebdY0grac6KOrRpEREn
	sDu5S4JegDjd8Q8z7xfpbF4Xr8wwvQb7z40XHmLfgquiHYp3yZLjhvhi6mEZEtWImeg/ph
	Do6WmwQ31Zv2BMk8zutT+kBCCfXWK0y9kDt1dRtkeBNviEt4xKtPZ6E304xGqQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: [PATCH v7 07/11] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Fri,  7 Jun 2024 14:58:58 +0000
Message-ID: <20240607145902.1137853-8-kernel@pankajraghav.com>
In-Reply-To: <20240607145902.1137853-1-kernel@pankajraghav.com>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vwkr96mtFz9sQg

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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 fs/internal.h          |  5 +++++
 fs/iomap/buffered-io.c |  6 ++++++
 fs/iomap/direct-io.c   | 26 ++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 84f371193f74..30217f0ff4c6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -35,6 +35,11 @@ static inline void bdev_cache_init(void)
 int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block, const struct iomap *iomap);
 
+/*
+ * iomap/direct-io.c
+ */
+int iomap_dio_init(void);
+
 /*
  * char_dev.c
  */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 49938419fcc7..9f791db473e4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1990,6 +1990,12 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
 
 static int __init iomap_init(void)
 {
+	int ret;
+
+	ret = iomap_dio_init();
+	if (ret)
+		return ret;
+
 	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
 			   offsetof(struct iomap_ioend, io_bio),
 			   BIOSET_NEED_BVECS);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..b95600b254a3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -27,6 +27,13 @@
 #define IOMAP_DIO_WRITE		(1U << 30)
 #define IOMAP_DIO_DIRTY		(1U << 31)
 
+/*
+ * Used for sub block zeroing in iomap_dio_zero()
+ */
+#define ZERO_FSB_SIZE (65536)
+#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
+static struct page *zero_fs_block;
+
 struct iomap_dio {
 	struct kiocb		*iocb;
 	const struct iomap_dio_ops *dops;
@@ -52,6 +59,16 @@ struct iomap_dio {
 	};
 };
 
+int iomap_dio_init(void)
+{
+	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
+
+	if (!zero_fs_block)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
@@ -236,17 +253,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
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
2.44.1


