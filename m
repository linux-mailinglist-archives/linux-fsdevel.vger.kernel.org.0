Return-Path: <linux-fsdevel+bounces-56253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4DB14F98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B3D4E59BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2628540F;
	Tue, 29 Jul 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y7/uY5/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873F216392
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800829; cv=none; b=YF5UTrij/Oyn6XqYYulPlh+LaL+h9JwWkms0ithnhurtjUFliPT1xzeoenL1MVNl9uGBUpRrruU9iBjCJjWuRJCiUb3rVf53vhSRTYkf4meHuFwteav2p65Sioof7IiJOs3IqPNQv1Lk2tP+V+KN6WkXO928ocf6PIwHpbxfvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800829; c=relaxed/simple;
	bh=o1iNxiea1yPNDV468NhHStuurG2ZNWDi6wuDUZmy6h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=o6JSUifRBTzZ1UIHJ92zTchx/k+muyhvkK3717p47OkxRGlJZI2+tnNkXYX6PrmfVGtbkAuDXCm8aVAWMOHpoQfop6wkwa05f/ucn15/BXeJPTbM5HuN26fO6ff1Fl68T8gV4/gUvxhg2UIV4GwUhyA3Ivs3+rY+uEJtcf5F5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y7/uY5/X; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250729145340epoutp03391f7d670e061973c94496037b3d92b6~WwI3cAm0y0526905269epoutp03H
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250729145340epoutp03391f7d670e061973c94496037b3d92b6~WwI3cAm0y0526905269epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753800820;
	bh=e/zcp77E7dbMucCpgAp1l5zCiD2ETfEq7Ro/y/RNnm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7/uY5/XV2rsuU/43a9EPS5xjp9hn3/hAY6mrKfmgXSyZti/6HovqPD19SVPgS76o
	 Y090QtownHBuwGz6m+uULO+Xg8ToWivw3t/J6kcy3t0HZF+/Cn1939baMCAbVh3d9u
	 lFIHYF/ZjBOSO3qePfesDz9y0w4vaGgDoMlHhFro=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250729145339epcas5p233e0b18649240bdeb57acf157196da9e~WwI3AVJna3059330593epcas5p22;
	Tue, 29 Jul 2025 14:53:39 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bryyq22wqz2SSKZ; Tue, 29 Jul
	2025 14:53:39 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250729145338epcas5p4da42906a341577997f39aa8453252ea3~WwI14eGyq1518815188epcas5p4E;
	Tue, 29 Jul 2025 14:53:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729145337epsmtip28b1a0ac10d20eb43c587ea50a68dea22~WwI0dwJ-V3271832718epsmtip2f;
	Tue, 29 Jul 2025 14:53:37 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 4/5] fs: propagate write stream
Date: Tue, 29 Jul 2025 20:21:34 +0530
Message-Id: <20250729145135.12463-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729145135.12463-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729145338epcas5p4da42906a341577997f39aa8453252ea3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145338epcas5p4da42906a341577997f39aa8453252ea3
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145338epcas5p4da42906a341577997f39aa8453252ea3@epcas5p4.samsung.com>

bio->bi_write_stream is not set by the filesystem code.
Use inode's write stream value to do that.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/btrfs/extent_io.c |  1 +
 fs/buffer.c          | 14 +++++++++-----
 fs/direct-io.c       |  1 +
 fs/ext4/page-io.c    |  1 +
 fs/iomap/direct-io.c |  1 +
 fs/iomap/ioend.c     |  1 +
 fs/mpage.c           |  1 +
 7 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1dc931c4937f..280fdfcfd855 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -666,6 +666,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 			       bio_ctrl->end_io_func, NULL);
 	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	bbio->bio.bi_write_hint = inode->vfs_inode.i_write_hint;
+	bbio->bio.bi_write_stream = inode->vfs_inode.i_write_stream;
 	bbio->inode = inode;
 	bbio->file_offset = file_offset;
 	bio_ctrl->bbio = bbio;
diff --git a/fs/buffer.c b/fs/buffer.c
index ead4dc85debd..6b85e9992036 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -55,7 +55,8 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  enum rw_hint hint, struct writeback_control *wbc);
+			  enum rw_hint hint, u8 write_stream,
+			  struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1931,7 +1932,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
-				      inode->i_write_hint, wbc);
+				      inode->i_write_hint,
+				      inode->i_write_stream, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1986,7 +1988,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
 			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
-				      inode->i_write_hint, wbc);
+				      inode->i_write_hint,
+				      inode->i_write_stream, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -2778,7 +2781,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 }
 
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  enum rw_hint write_hint,
+			  enum rw_hint write_hint, u8 write_stream,
 			  struct writeback_control *wbc)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
@@ -2807,6 +2810,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_write_hint = write_hint;
+	bio->bi_write_stream = write_stream;
 
 	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
 
@@ -2826,7 +2830,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
+	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, 0, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 1694ee9a9382..f086d21b5b1c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -410,6 +410,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	if (dio->is_pinned)
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	bio->bi_write_hint = file_inode(dio->iocb->ki_filp)->i_write_hint;
+	bio->bi_write_stream = file_inode(dio->iocb->ki_filp)->i_write_stream;
 
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 179e54f3a3b6..573093ecd7d9 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -447,6 +447,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 	if (io->io_bio == NULL) {
 		io_submit_init_bio(io, bh);
 		io->io_bio->bi_write_hint = inode->i_write_hint;
+		io->io_bio->bi_write_stream = inode->i_write_stream;
 	}
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6f25d4cfea9f..ba304109da72 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -430,6 +430,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = inode->i_write_hint;
+		bio->bi_write_stream = inode->i_write_stream;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab26..652525c93fdd 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -107,6 +107,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_write_hint = wpc->inode->i_write_hint;
+	bio->bi_write_stream = wpc->inode->i_write_stream;
 	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
 	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
diff --git a/fs/mpage.c b/fs/mpage.c
index c5fd821fd30e..6a50bbe38adc 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -595,6 +595,7 @@ static int mpage_write_folio(struct writeback_control *wbc, struct folio *folio,
 		bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
 		bio->bi_write_hint = inode->i_write_hint;
+		bio->bi_write_stream = inode->i_write_stream;
 	}
 
 	/*
-- 
2.25.1


