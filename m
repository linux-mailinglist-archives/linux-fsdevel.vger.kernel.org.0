Return-Path: <linux-fsdevel+bounces-24316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B293D2B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3551C217CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909E17C230;
	Fri, 26 Jul 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JdIOde58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3B17C20A;
	Fri, 26 Jul 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995243; cv=none; b=Lxvcgv2VZkrOzJ0Ubr314Voa/WAO8O1CrpWHmFT2FHsZqr2P4/7T+qkBKI9ctOZvSJ3SpCL2xaELb4mgf0fl87Lv6vdWmaKMjGj8vcx4FgonLl+/CSFfLsx1merhwyvgRlrTFBzVsMxQSx4llicPalqXnnOX68gQhsy8M3upcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995243; c=relaxed/simple;
	bh=wMW80ui6itXUIfuxu/w/BUL0KSHPMmQcEGz9AF7yD5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYqpkSCDGPckTQaJ/PSUylBRZTp83eB57KTzVHaxe/DW13GTIagNVR7i/uBvGj3otGWCvvh/LmO6UlHvvnMm/KL/+iZ3aTYZVZ1s062gI457ngSVw4JyJgQj7GeimBe+tcnN0u6+p167Snm1NIYBTxu10F9Qlb46RJpqGUI1DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JdIOde58; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WVmXw2Gq6z9scY;
	Fri, 26 Jul 2024 14:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721995232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92ifPOSk+9xMdQXjuWHjR+cARiQXMVhXQNki2unPXuQ=;
	b=JdIOde58VBAj2fkp/TpLSqvA4CB7syv6NihQWUQIPHWoe1mCge7hwFXUnes0Ts6ZSjKVGG
	W6YN1FaIHWe8VMN3FfrRoa8z9AZgUiH1qaZIrT7XkEzvDNGcCOC3WOb03+vl346+GUeyjc
	KEqK7oSuGPLmQDIrYgIjGXlqY7aaO59QbVgWeZem9CkKWmKWzF9nGRg96mtW5wc8mIL/M0
	5mIz769OOStN7yKtnverR+89bsHtms8eD97GIGfPjcJvn16IS0eUjCJcINvkO/0VTfn28N
	7MuFZWwaLgJRw32CHpeKgmHS5QsGaAzmWpYwn5YH4Ymj2/29hBakOE4tVN1aEQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v11 06/10] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Fri, 26 Jul 2024 13:59:52 +0200
Message-ID: <20240726115956.643538-7-kernel@pankajraghav.com>
In-Reply-To: <20240726115956.643538-1-kernel@pankajraghav.com>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WVmXw2Gq6z9scY

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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c |  4 ++--
 fs/iomap/direct-io.c   | 45 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86acc..d745f718bcde8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -2007,10 +2007,10 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
-static int __init iomap_init(void)
+static int __init iomap_buffered_init(void)
 {
 	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
 			   offsetof(struct iomap_ioend, io_bio),
 			   BIOSET_NEED_BVECS);
 }
-fs_initcall(iomap_init);
+fs_initcall(iomap_buffered_init);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46e..c02b266bba525 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -11,6 +11,7 @@
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
+#include <linux/set_memory.h>
 #include <linux/task_io_accounting_ops.h>
 #include "trace.h"
 
@@ -27,6 +28,13 @@
 #define IOMAP_DIO_WRITE		(1U << 30)
 #define IOMAP_DIO_DIRTY		(1U << 31)
 
+/*
+ * Used for sub block zeroing in iomap_dio_zero()
+ */
+#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
+#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
+static struct page *zero_page;
+
 struct iomap_dio {
 	struct kiocb		*iocb;
 	const struct iomap_dio_ops *dops;
@@ -232,13 +240,20 @@ void iomap_dio_bio_end_io(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
-static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
+static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
-	struct page *page = ZERO_PAGE(0);
 	struct bio *bio;
 
+	if (!len)
+		return 0;
+	/*
+	 * Max block size supported is 64k
+	 */
+	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
+		return -EINVAL;
+
 	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
@@ -246,8 +261,9 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, page, len, 0);
+	__bio_add_page(bio, zero_page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
+	return 0;
 }
 
 /*
@@ -356,8 +372,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
-		if (pad)
-			iomap_dio_zero(iter, dio, pos - pad, pad);
+
+		ret = iomap_dio_zero(iter, dio, pos - pad, pad);
+		if (ret)
+			goto out;
 	}
 
 	/*
@@ -431,7 +449,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
 		if (pad)
-			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
+			ret = iomap_dio_zero(iter, dio, pos,
+					     fs_block_size - pad);
 	}
 out:
 	/* Undo iter limitation to current extent */
@@ -753,3 +772,17 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return iomap_dio_complete(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
+
+static int __init iomap_dio_init(void)
+{
+	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
+				IOMAP_ZERO_PAGE_ORDER);
+
+	if (!zero_page)
+		return -ENOMEM;
+
+	set_memory_ro((unsigned long)page_address(zero_page),
+		      1U << IOMAP_ZERO_PAGE_ORDER);
+	return 0;
+}
+fs_initcall(iomap_dio_init);
-- 
2.44.1


