Return-Path: <linux-fsdevel+bounces-34157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE109C3338
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF013280F45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDE16190B;
	Sun, 10 Nov 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fpRWAWEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A480027
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252573; cv=none; b=JYkMPsTx3VQgOU7VfxYQVkIVmXSAFKOdzhbx/SPQljCp075HkUiltoq2HHkxsPPSW577m3DmXkTMuAS2iAimy8wuHk1rpSqyyGT3jRRamQB9YvBtMuO0kllLStyDYHQaG8dme4V4+W6DBraA0Z7nuMEpX9DhnQWyZl9Z2RueC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252573; c=relaxed/simple;
	bh=6ZSmJO+bG/O0VvG/m0Wnv2BJ9smDd+VmRMf5KfhKfrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN9Dm/1OxUjNdZ7pnSFZi1jtsRoC8faZxUn/fpvZ27A71jHfNqqntYkUh1FpkTw5taaezoVpEtNSajsIu1P0uOQyQnWVh8I1s50+0ql+02IYufbwsXFWiVu4r5OetsWSHuFELe4gpMlqf94I6GvbR2zOsL+54Y031STGiThiuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fpRWAWEC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2991507a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252571; x=1731857371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkS4Adcluut9E9TBSf0Q5Dr6BdVnPYdslAPkTGEhwiY=;
        b=fpRWAWECI5OtTQlcLOn/rgoWffS5D1nG5AfXfjwzuPyRLJ8+q4/d1VRom1qGPd9paI
         3wZm6TypwMh8/eeTb7hrykWDheH5TKWVjEdZP9S6jtkO3On+oPWhGGRz6L6nMgnRLyHg
         kRrTTdnBQoh9VNuPxK/nMU6aDLydSJNxkO1knvpLPPuGyqUuKkMg/HkYwFzpGgZnLcGa
         pJBW+xlqZuQb32kfOp190V4ODE7ol7jvjmZxNL0lPnzUsyqfe3xxdAvW1p5m1Trf+VCI
         Keiya1aYrm4Yqd4XZqCOH6zE7ywioLUtihFSRxR4uB5xQ/wKeN9IvJuATU6+sODzi3sL
         IOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252571; x=1731857371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkS4Adcluut9E9TBSf0Q5Dr6BdVnPYdslAPkTGEhwiY=;
        b=OjhrX+9aRuMsGRDXXBfJ7SQZvsqTYDBTsL8/mM2AtT5uzVSRN5Hu84qoTd+aMN7mp4
         x1iLEFq5g2Y7RGGnMIiWWkIiE2PcGVFfKQfXJ6h8PTeY8h8da5srGyzuIj+B3qQ4mHNC
         hK7Eq4sdLmCUZw5Lgmbf9BJQXr4UCODbkiNyCcavTEfOlB+v7MbXcRRQa/g9dDC949Vo
         Ivn0ku7ZT7otvSNfLGeViMqvPr4GKKNUP2CGTbK7DVezHoBkq0fmyBgFz1C6AN/X0RUW
         4/KZ+VGUyySBB0OnPjWXUxbW7xJPxs0i6xstS85o/qS163CekzJCVRWzCgCHEc1BsgW6
         +BtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY6FHwXxqefgYRdzif3+GbIa8raQOnGDlclKiQmGN0RcphzymaAdZcjfuZ0eJYfGFLDJVTo03YHrdqUrY/@vger.kernel.org
X-Gm-Message-State: AOJu0YxltErYGqFLPrSw1oIuwEQ0T7VFs2AzMXG99zxVMET6STo18jvi
	RL9ArVApIdzopJuiO3HdCLj8yIwWKoaysb74OKDxp1XjxFBujt+QdGsJJFv0srtruPtwzXqP+Q8
	kamE=
X-Google-Smtp-Source: AGHT+IHRHbLBUb09CwGoIXN66uipNoc+nR4rS0OGfJWtMF1GUwRkiOluIK+uk59p6smvN8SFsh8EQg==
X-Received: by 2002:a17:90b:2b8e:b0:2e2:b69c:2a9 with SMTP id 98e67ed59e1d1-2e9b1770362mr13736497a91.26.1731252571252;
        Sun, 10 Nov 2024 07:29:31 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/15] ext4: add RWF_UNCACHED write support
Date: Sun, 10 Nov 2024 08:28:04 -0700
Message-ID: <20241110152906.1747545-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
and hence need the worker punt that ext4 also does for unwritten
extents. Add an io_end flag to manage that.

If foliop is set to foliop_uncached in ext4_write_begin(), then set
FGP_UNCACHED so that __filemap_get_folio() will mark newly created
folios as uncached. That in turn will make writeback completion drop
these ranges from the page cache.

Now that ext4 supports both uncached reads and writes, add the fop_flag
FOP_UNCACHED to enable it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/file.c    |  2 +-
 fs/ext4/inline.c  |  7 ++++++-
 fs/ext4/inode.c   | 18 ++++++++++++++++--
 fs/ext4/page-io.c | 28 ++++++++++++++++------------
 5 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..60dc9ffae076 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -279,6 +279,7 @@ struct ext4_system_blocks {
  * Flags for ext4_io_end->flags
  */
 #define	EXT4_IO_END_UNWRITTEN	0x0001
+#define EXT4_IO_UNCACHED	0x0002
 
 struct ext4_io_end_vec {
 	struct list_head list;		/* list of io_end_vec */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..0ef39d738598 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -944,7 +944,7 @@ const struct file_operations ext4_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_DIO_PARALLEL_WRITE,
+			  FOP_DIO_PARALLEL_WRITE | FOP_UNCACHED,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..4089d0744164 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -667,6 +667,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	handle_t *handle;
 	struct folio *folio;
 	struct ext4_iloc iloc;
+	fgf_t fgp_flags;
 
 	if (pos + len > ext4_get_max_inline_size(inode))
 		goto convert;
@@ -702,7 +703,11 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	if (ret)
 		goto out;
 
-	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+	fgp_flags = FGP_WRITEBEGIN | FGP_NOFS;
+	if (*foliop == foliop_uncached)
+		fgp_flags |= FGP_UNCACHED;
+
+	folio = __filemap_get_folio(mapping, 0, fgp_flags,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		ret = PTR_ERR(folio);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..afae3ab64c9e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	int ret, needed_blocks;
 	handle_t *handle;
 	int retries = 0;
+	fgf_t fgp_flags;
 	struct folio *folio;
 	pgoff_t index;
 	unsigned from, to;
@@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 			return 0;
 	}
 
+	/*
+	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
+	 * foliop_uncached. That's how generic_perform_write() informs us
+	 * that this is an uncached write.
+	 */
+	fgp_flags = FGP_WRITEBEGIN;
+	if (*foliop == foliop_uncached)
+		fgp_flags |= FGP_UNCACHED;
+
 	/*
 	 * __filemap_get_folio() can take a long time if the
 	 * system is thrashing due to memory pressure, or if the folio
@@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * the folio (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
@@ -2903,6 +2913,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio;
 	pgoff_t index;
 	struct inode *inode = mapping->host;
+	fgf_t fgp_flags;
 
 	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
@@ -2926,8 +2937,11 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			return 0;
 	}
 
+	fgp_flags = FGP_WRITEBEGIN;
+	if (*foliop == foliop_uncached)
+		fgp_flags |= FGP_UNCACHED;
 retry:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index ad5543866d21..10447c3c4ff1 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -226,8 +226,6 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 	unsigned long flags;
 
 	/* Only reserved conversions from writeback should enter here */
-	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
-	WARN_ON(!io_end->handle && sbi->s_journal);
 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
 	wq = sbi->rsv_conversion_wq;
 	if (list_empty(&ei->i_rsv_conversion_list))
@@ -252,7 +250,7 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
 
 	while (!list_empty(&unwritten)) {
 		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
-		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
+		BUG_ON(!(io_end->flag & (EXT4_IO_END_UNWRITTEN|EXT4_IO_UNCACHED)));
 		list_del_init(&io_end->list);
 
 		err = ext4_end_io_end(io_end);
@@ -287,14 +285,15 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 {
-	if (refcount_dec_and_test(&io_end->count)) {
-		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
-				list_empty(&io_end->list_vec)) {
-			ext4_release_io_end(io_end);
-			return;
-		}
-		ext4_add_complete_io(io_end);
+	if (!refcount_dec_and_test(&io_end->count))
+		return;
+	if ((!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
+	    list_empty(&io_end->list_vec)) &&
+	    !(io_end->flag & EXT4_IO_UNCACHED)) {
+		ext4_release_io_end(io_end);
+		return;
 	}
+	ext4_add_complete_io(io_end);
 }
 
 int ext4_put_io_end(ext4_io_end_t *io_end)
@@ -348,7 +347,7 @@ static void ext4_end_bio(struct bio *bio)
 				blk_status_to_errno(bio->bi_status));
 	}
 
-	if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
+	if (io_end->flag & (EXT4_IO_END_UNWRITTEN|EXT4_IO_UNCACHED)) {
 		/*
 		 * Link bio into list hanging from io_end. We have to do it
 		 * atomically as bio completions can be racing against each
@@ -417,8 +416,13 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 submit_and_retry:
 		ext4_io_submit(io);
 	}
-	if (io->io_bio == NULL)
+	if (io->io_bio == NULL) {
 		io_submit_init_bio(io, bh);
+		if (folio_test_uncached(folio)) {
+			ext4_io_end_t *io_end = io->io_bio->bi_private;
+			io_end->flag |= EXT4_IO_UNCACHED;
+		}
+	}
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
-- 
2.45.2


