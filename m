Return-Path: <linux-fsdevel+bounces-66674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45489C28155
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 16:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA371A20A6B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C62F8BFF;
	Sat,  1 Nov 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="tKMigP9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE215D1;
	Sat,  1 Nov 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762010753; cv=none; b=LN+krYV9iH34w5BZWlad6sKrHAEqnEh5Zx5QrO1htv7157zfsJQTDZnLzhx6jBvDN6VFNp8bL+Q8ePUh1a+8zMS68XBOMftc4am8/z4TwNYMRT8538m8vgZVAXYJ5prQ+6KkRMBkjjLrn45fYAw1i9fcmgtrwe+ICiiEkjALNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762010753; c=relaxed/simple;
	bh=65waWDRkFUkCMudD7Ks7TSXtVXuFYYMafHvuHBp1v6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyQ7Uu+9NoUU1FUqEcE9bqpoJdezgqQ9qRgLIBQAu1jQKCIZnf0qBvF19sW10Mz+R1hXw2/GyiRkNVRRVDbA23d/YeRaw8QMp2UU3iAQYR64MPXFAqGPtCAbT8n/i2Kk5ecml1hqaUv6/oZ3+QYcTR55QybfaQUxPSRWe2bq6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=tKMigP9L; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 895E41E1A;
	Sat,  1 Nov 2025 15:22:32 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=tKMigP9L;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 222541D1C;
	Sat,  1 Nov 2025 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1762010743;
	bh=ZthOa0kyCjgvXBBhaLjkCIJOWFNqc9W+tUF5tSS38K8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tKMigP9L/TaP2S3TP7T+TJ7RdkB5i4cO8mshRAOJv0P81oqppJOdRHaDxQeY0vopG
	 hjmcCpDTqWFwVekxiXVsOHAvMgWv60Zzd+RNsFiNXEnJad6OMbyAwR+ySOWSy0VhQq
	 7jh2ii4PD2nq9NwlUxX5feaPfZID3PShFZ6WbNtc=
Received: from localhost.localdomain (172.30.20.151) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 1 Nov 2025 18:25:42 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2] fs/ntfs3: remove ntfs_bio_pages and use page cache for compressed I/O
Date: Sat, 1 Nov 2025 16:25:34 +0100
Message-ID: <20251101152534.12316-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQTCoABT6usmY8iF@casper.infradead.org>
References: <aQTCoABT6usmY8iF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Replace the use of ntfs_bio_pages with the disk page cache for reading and
writing compressed files. This slightly improves performance when reading
compressed data and simplifies the I/O logic.

When an XPRESS or LZX compressed file is opened for writing, it is now
decompressed into a normal file before modification. A new argument (`int copy`)
is added to ni_read_frame() to handle writing of decompressed and mapped data.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  |   4 +-
 fs/ntfs3/file.c    |   6 +-
 fs/ntfs3/frecord.c | 152 ++++++++++++---------------------------------
 fs/ntfs3/fsntfs.c  | 123 ++++++++++++++++--------------------
 fs/ntfs3/inode.c   |   1 -
 fs/ntfs3/ntfs_fs.h |  20 ++++--
 6 files changed, 114 insertions(+), 192 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index eced9013a881..d0373254f82a 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1457,7 +1457,6 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 		pgoff_t index = vbo[i] >> PAGE_SHIFT;
 
 		if (index != folio->index) {
-			struct page *page = &folio->page;
 			u64 from = vbo[i] & ~(u64)(PAGE_SIZE - 1);
 			u64 to = min(from + PAGE_SIZE, wof_size);
 
@@ -1467,8 +1466,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 			if (err)
 				goto out1;
 
-			err = ntfs_bio_pages(sbi, run, &page, 1, from,
-					     to - from, REQ_OP_READ);
+			err = ntfs_read_run(sbi, run, addr, from, to - from);
 			if (err) {
 				folio->index = -1;
 				goto out1;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 7471a4bbb438..60eb90bff955 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -59,7 +59,7 @@ static int ntfs_ioctl_get_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
 
 static int ntfs_ioctl_set_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
 {
-	u8 user[FSLABEL_MAX] = {0};
+	u8 user[FSLABEL_MAX] = { 0 };
 	int len;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1039,7 +1039,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 
 		if (!frame_uptodate && off) {
 			err = ni_read_frame(ni, frame_vbo, pages,
-					    pages_per_frame);
+					    pages_per_frame, 0);
 			if (err) {
 				for (ip = 0; ip < pages_per_frame; ip++) {
 					folio = page_folio(pages[ip]);
@@ -1104,7 +1104,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (off || (to < i_size && (to & (frame_size - 1)))) {
 				err = ni_read_frame(ni, frame_vbo, pages,
-						    pages_per_frame);
+						    pages_per_frame, 0);
 				if (err) {
 					for (ip = 0; ip < pages_per_frame;
 					     ip++) {
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c3638f482393..87609a381ce5 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2105,7 +2105,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio)
 		pages[i] = pg;
 	}
 
-	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame);
+	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame, 0);
 
 out1:
 	for (i = 0; i < pages_per_frame; i++) {
@@ -2175,17 +2175,9 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	 */
 	index = 0;
 	for (vbo = 0; vbo < i_size; vbo += bytes) {
-		u32 nr_pages;
 		bool new;
 
-		if (vbo + frame_size > i_size) {
-			bytes = i_size - vbo;
-			nr_pages = (bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
-		} else {
-			nr_pages = pages_per_frame;
-			bytes = frame_size;
-		}
-
+		bytes = vbo + frame_size > i_size ? (i_size - vbo) : frame_size;
 		end = bytes_to_cluster(sbi, vbo + bytes);
 
 		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
@@ -2210,15 +2202,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 			pages[i] = pg;
 		}
 
-		err = ni_read_frame(ni, vbo, pages, pages_per_frame);
-
-		if (!err) {
-			down_read(&ni->file.run_lock);
-			err = ntfs_bio_pages(sbi, &ni->file.run, pages,
-					     nr_pages, vbo, bytes,
-					     REQ_OP_WRITE);
-			up_read(&ni->file.run_lock);
-		}
+		err = ni_read_frame(ni, vbo, pages, pages_per_frame, 1);
 
 		for (i = 0; i < pages_per_frame; i++) {
 			unlock_page(pages[i]);
@@ -2408,20 +2392,19 @@ static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
  * Pages - Array of locked pages.
  */
 int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
-		  u32 pages_per_frame)
+		  u32 pages_per_frame, int copy)
 {
 	int err;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	char *frame_ondisk = NULL;
 	char *frame_mem = NULL;
-	struct page **pages_disk = NULL;
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
 	u64 vbo_disk;
 	size_t unc_size;
-	u32 frame_size, i, npages_disk, ondisk_size;
+	u32 frame_size, i, ondisk_size;
 	struct page *pg;
 	struct ATTRIB *attr;
 	CLST frame, clst_data;
@@ -2513,7 +2496,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		err = attr_wof_frame_info(ni, attr, run, frame64, frames,
 					  frame_bits, &ondisk_size, &vbo_data);
 		if (err)
-			goto out2;
+			goto out1;
 
 		if (frame64 == frames) {
 			unc_size = 1 + ((i_size - 1) & (frame_size - 1));
@@ -2524,7 +2507,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 
 		if (ondisk_size > frame_size) {
 			err = -EINVAL;
-			goto out2;
+			goto out1;
 		}
 
 		if (!attr->non_res) {
@@ -2545,10 +2528,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 					   ARRAY_SIZE(WOF_NAME), run, vbo_disk,
 					   vbo_data + ondisk_size);
 		if (err)
-			goto out2;
-		npages_disk = (ondisk_size + (vbo_disk & (PAGE_SIZE - 1)) +
-			       PAGE_SIZE - 1) >>
-			      PAGE_SHIFT;
+			goto out1;
 #endif
 	} else if (is_attr_compressed(attr)) {
 		/* LZNT compression. */
@@ -2582,60 +2562,37 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		if (clst_data >= NTFS_LZNT_CLUSTERS) {
 			/* Frame is not compressed. */
 			down_read(&ni->file.run_lock);
-			err = ntfs_bio_pages(sbi, run, pages, pages_per_frame,
-					     frame_vbo, ondisk_size,
-					     REQ_OP_READ);
+			err = ntfs_read_run(sbi, run, frame_mem, frame_vbo,
+					    ondisk_size);
 			up_read(&ni->file.run_lock);
 			goto out1;
 		}
 		vbo_disk = frame_vbo;
-		npages_disk = (ondisk_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	} else {
 		__builtin_unreachable();
 		err = -EINVAL;
 		goto out1;
 	}
 
-	pages_disk = kcalloc(npages_disk, sizeof(*pages_disk), GFP_NOFS);
-	if (!pages_disk) {
+	/* Allocate memory to read compressed data to. */
+	frame_ondisk = kvmalloc(ondisk_size, GFP_KERNEL);
+	if (!frame_ondisk) {
 		err = -ENOMEM;
-		goto out2;
-	}
-
-	for (i = 0; i < npages_disk; i++) {
-		pg = alloc_page(GFP_KERNEL);
-		if (!pg) {
-			err = -ENOMEM;
-			goto out3;
-		}
-		pages_disk[i] = pg;
-		lock_page(pg);
+		goto out1;
 	}
 
 	/* Read 'ondisk_size' bytes from disk. */
 	down_read(&ni->file.run_lock);
-	err = ntfs_bio_pages(sbi, run, pages_disk, npages_disk, vbo_disk,
-			     ondisk_size, REQ_OP_READ);
+	err = ntfs_read_run(sbi, run, frame_ondisk, vbo_disk, ondisk_size);
 	up_read(&ni->file.run_lock);
 	if (err)
-		goto out3;
-
-	/*
-	 * To simplify decompress algorithm do vmap for source and target pages.
-	 */
-	frame_ondisk = vmap(pages_disk, npages_disk, VM_MAP, PAGE_KERNEL_RO);
-	if (!frame_ondisk) {
-		err = -ENOMEM;
-		goto out3;
-	}
+		goto out2;
 
-	/* Decompress: Frame_ondisk -> frame_mem. */
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 	if (run != &ni->file.run) {
 		/* LZX or XPRESS */
-		err = decompress_lzx_xpress(
-			sbi, frame_ondisk + (vbo_disk & (PAGE_SIZE - 1)),
-			ondisk_size, frame_mem, unc_size, frame_size);
+		err = decompress_lzx_xpress(sbi, frame_ondisk, ondisk_size,
+					    frame_mem, unc_size, frame_size);
 	} else
 #endif
 	{
@@ -2653,24 +2610,21 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		memset(frame_mem + ok, 0, frame_size - ok);
 	}
 
-	vunmap(frame_ondisk);
-
-out3:
-	for (i = 0; i < npages_disk; i++) {
-		pg = pages_disk[i];
-		if (pg) {
-			unlock_page(pg);
-			put_page(pg);
-		}
-	}
-	kfree(pages_disk);
-
 out2:
+	kvfree(frame_ondisk);
+out1:
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 	if (run != &ni->file.run)
 		run_free(run);
+	if (!err && copy) {
+		/* We are called from 'ni_decompress_file' */
+		/* Copy decompressed LZX or XPRESS data into new place. */
+		down_read(&ni->file.run_lock);
+		err = ntfs_write_run(sbi, &ni->file.run, frame_mem, frame_vbo,
+				     frame_size);
+		up_read(&ni->file.run_lock);
+	}
 #endif
-out1:
 	vunmap(frame_mem);
 out:
 	for (i = 0; i < pages_per_frame; i++) {
@@ -2697,13 +2651,10 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 	u64 frame_vbo = folio_pos(folio);
 	CLST frame = frame_vbo >> frame_bits;
 	char *frame_ondisk = NULL;
-	struct page **pages_disk = NULL;
 	struct ATTR_LIST_ENTRY *le = NULL;
 	char *frame_mem;
 	struct ATTRIB *attr;
 	struct mft_inode *mi;
-	u32 i;
-	struct page *pg;
 	size_t compr_size, ondisk_size;
 	struct lznt *lznt;
 
@@ -2738,34 +2689,18 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		goto out;
 	}
 
-	pages_disk = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
-	if (!pages_disk) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	for (i = 0; i < pages_per_frame; i++) {
-		pg = alloc_page(GFP_KERNEL);
-		if (!pg) {
-			err = -ENOMEM;
-			goto out1;
-		}
-		pages_disk[i] = pg;
-		lock_page(pg);
-	}
-
-	/* To simplify compress algorithm do vmap for source and target pages. */
-	frame_ondisk = vmap(pages_disk, pages_per_frame, VM_MAP, PAGE_KERNEL);
+	/* Allocate memory to write compressed data to. */
+	frame_ondisk = kvmalloc(frame_size, GFP_KERNEL);
 	if (!frame_ondisk) {
 		err = -ENOMEM;
-		goto out1;
+		goto out;
 	}
 
 	/* Map in-memory frame for read-only. */
 	frame_mem = vmap(pages, pages_per_frame, VM_MAP, PAGE_KERNEL_RO);
 	if (!frame_mem) {
 		err = -ENOMEM;
-		goto out2;
+		goto out1;
 	}
 
 	mutex_lock(&sbi->compress.mtx_lznt);
@@ -2781,7 +2716,7 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		if (!lznt) {
 			mutex_unlock(&sbi->compress.mtx_lznt);
 			err = -ENOMEM;
-			goto out3;
+			goto out2;
 		}
 
 		sbi->compress.lznt = lznt;
@@ -2818,25 +2753,16 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		goto out2;
 
 	down_read(&ni->file.run_lock);
-	err = ntfs_bio_pages(sbi, &ni->file.run,
-			     ondisk_size < frame_size ? pages_disk : pages,
-			     pages_per_frame, frame_vbo, ondisk_size,
-			     REQ_OP_WRITE);
+	err = ntfs_write_run(sbi, &ni->file.run,
+			     ondisk_size < frame_size ? frame_ondisk :
+							frame_mem,
+			     frame_vbo, ondisk_size);
 	up_read(&ni->file.run_lock);
 
-out3:
-	vunmap(frame_mem);
 out2:
-	vunmap(frame_ondisk);
+	vunmap(frame_mem);
 out1:
-	for (i = 0; i < pages_per_frame; i++) {
-		pg = pages_disk[i];
-		if (pg) {
-			unlock_page(pg);
-			put_page(pg);
-		}
-	}
-	kfree(pages_disk);
+	kvfree(frame_ondisk);
 out:
 	return err;
 }
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 5ae910e9ecbd..5f138f715835 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1479,99 +1479,86 @@ int ntfs_write_bh(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
 }
 
 /*
- * ntfs_bio_pages - Read/write pages from/to disk.
+ * ntfs_read_write_run - Read/Write disk's page cache.
  */
-int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-		   struct page **pages, u32 nr_pages, u64 vbo, u32 bytes,
-		   enum req_op op)
+int ntfs_read_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+			void *buf, u64 vbo, size_t bytes, int wr)
 {
-	int err = 0;
-	struct bio *new, *bio = NULL;
 	struct super_block *sb = sbi->sb;
-	struct block_device *bdev = sb->s_bdev;
-	struct page *page;
+	struct address_space *mapping = sb->s_bdev->bd_mapping;
 	u8 cluster_bits = sbi->cluster_bits;
-	CLST lcn, clen, vcn, vcn_next;
-	u32 add, off, page_idx;
+	CLST vcn_next, vcn = vbo >> cluster_bits;
+	CLST lcn, clen;
 	u64 lbo, len;
-	size_t run_idx;
-	struct blk_plug plug;
+	size_t idx;
+	u32 off, op;
+	struct folio *folio;
+	char *kaddr;
 
 	if (!bytes)
 		return 0;
 
-	blk_start_plug(&plug);
+	if (!run_lookup_entry(run, vcn, &lcn, &clen, &idx))
+		return -ENOENT;
 
-	/* Align vbo and bytes to be 512 bytes aligned. */
-	lbo = (vbo + bytes + 511) & ~511ull;
-	vbo = vbo & ~511ull;
-	bytes = lbo - vbo;
+	if (lcn == SPARSE_LCN)
+		return -EINVAL;
 
-	vcn = vbo >> cluster_bits;
-	if (!run_lookup_entry(run, vcn, &lcn, &clen, &run_idx)) {
-		err = -ENOENT;
-		goto out;
-	}
 	off = vbo & sbi->cluster_mask;
-	page_idx = 0;
-	page = pages[0];
+	lbo = ((u64)lcn << cluster_bits) + off;
+	len = ((u64)clen << cluster_bits) - off;
 
 	for (;;) {
-		lbo = ((u64)lcn << cluster_bits) + off;
-		len = ((u64)clen << cluster_bits) - off;
-new_bio:
-		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
-		bio->bi_iter.bi_sector = lbo >> 9;
+		/* Read range [lbo, lbo+len). */
+		folio = read_mapping_folio(mapping, lbo >> PAGE_SHIFT, NULL);
 
-		while (len) {
-			off = vbo & (PAGE_SIZE - 1);
-			add = off + len > PAGE_SIZE ? (PAGE_SIZE - off) : len;
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-			if (bio_add_page(bio, page, add, off) < add)
-				goto new_bio;
+		off = offset_in_page(lbo);
+		op = PAGE_SIZE - off;
 
-			if (bytes <= add)
-				goto out;
-			bytes -= add;
-			vbo += add;
+		if (op > len)
+			op = len;
+		if (op > bytes)
+			op = bytes;
 
-			if (add + off == PAGE_SIZE) {
-				page_idx += 1;
-				if (WARN_ON(page_idx >= nr_pages)) {
-					err = -EINVAL;
-					goto out;
-				}
-				page = pages[page_idx];
-			}
+		kaddr = kmap_local_folio(folio, 0);
+		if (wr) {
+			memcpy(kaddr + off, buf, op);
+			folio_mark_dirty(folio);
+		} else {
+			memcpy(buf, kaddr + off, op);
+			flush_dcache_folio(folio);
+		}
+		kunmap_local(kaddr);
+		folio_put(folio);
 
-			if (len <= add)
-				break;
-			len -= add;
-			lbo += add;
+		bytes -= op;
+		if (!bytes)
+			return 0;
+
+		buf += op;
+		len -= op;
+		if (len) {
+			/* next volume's page. */
+			lbo += op;
+			continue;
 		}
 
+		/* get next range. */
 		vcn_next = vcn + clen;
-		if (!run_get_entry(run, ++run_idx, &vcn, &lcn, &clen) ||
+		if (!run_get_entry(run, ++idx, &vcn, &lcn, &clen) ||
 		    vcn != vcn_next) {
-			err = -ENOENT;
-			goto out;
+			return -ENOENT;
 		}
-		off = 0;
-	}
-out:
-	if (bio) {
-		if (!err)
-			err = submit_bio_wait(bio);
-		bio_put(bio);
-	}
-	blk_finish_plug(&plug);
 
-	return err;
+		if (lcn == SPARSE_LCN)
+			return -EINVAL;
+
+		lbo = ((u64)lcn << cluster_bits);
+		len = ((u64)clen << cluster_bits);
+	}
 }
 
 /*
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index b0c557a6c115..74de82b8efe1 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2107,7 +2107,6 @@ const struct address_space_operations ntfs_aops = {
 
 const struct address_space_operations ntfs_aops_cmpr = {
 	.read_folio	= ntfs_read_folio,
-	.readahead	= ntfs_readahead,
 	.dirty_folio	= block_dirty_folio,
 	.direct_IO	= ntfs_direct_IO,
 };
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 6a7594d3f3eb..86f825cf1c29 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -570,7 +570,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio);
 int ni_decompress_file(struct ntfs_inode *ni);
 int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
-		  u32 pages_per_frame);
+		  u32 pages_per_frame, int copy);
 int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		   u32 pages_per_frame);
 int ni_remove_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
@@ -633,9 +633,21 @@ int ntfs_get_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
 		u32 bytes, struct ntfs_buffers *nb);
 int ntfs_write_bh(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
 		  struct ntfs_buffers *nb, int sync);
-int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-		   struct page **pages, u32 nr_pages, u64 vbo, u32 bytes,
-		   enum req_op op);
+int ntfs_read_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+			void *buf, u64 vbo, size_t bytes, int wr);
+static inline int ntfs_read_run(struct ntfs_sb_info *sbi,
+				const struct runs_tree *run, void *buf, u64 vbo,
+				size_t bytes)
+{
+	return ntfs_read_write_run(sbi, run, buf, vbo, bytes, 0);
+}
+static inline int ntfs_write_run(struct ntfs_sb_info *sbi,
+				 const struct runs_tree *run, void *buf,
+				 u64 vbo, size_t bytes)
+{
+	return ntfs_read_write_run(sbi, run, buf, vbo, bytes, 1);
+}
+
 int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run);
 int ntfs_vbo_to_lbo(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		    u64 vbo, u64 *lbo, u64 *bytes);
-- 
2.43.0


