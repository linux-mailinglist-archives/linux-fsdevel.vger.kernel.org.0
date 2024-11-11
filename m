Return-Path: <linux-fsdevel+bounces-34355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048AC9C4A58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDFAB2EB23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1351CF7B7;
	Mon, 11 Nov 2024 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vE3j3An1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE81CEAB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368948; cv=none; b=uxQYt2a4pIli1HAvJARDtYIklfqp3+ZppMwtOjpJysnGW/In6d7oWarE/ixDiSDmKpL5kyEnQriviFXHZyjZ2OduohQ3/Y0GQQXUF/rmcg2vFl5Jo0gu3Rc+5Z/j5CGS4bvWcLGOy1fdUL5Wx2IjE6pTFgvPh2NDe3OZ7EtX4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368948; c=relaxed/simple;
	bh=6ZSmJO+bG/O0VvG/m0Wnv2BJ9smDd+VmRMf5KfhKfrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l40o1DVaCQC0I/spcN7YBLixIY1CLik5h9TN5dfETaSxBP8wilX5RPfmsFmYqfpYIstxpTJ6Je3txAxc8BklXQW6JR9aAiA8QUybRyXphIP3MtHRHjuH681GCKfMLXocPUPpX2J1nz89kzzlzLVcxHai0PmkkKdagEHXkqx3y38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vE3j3An1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e681bc315so3584365b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368946; x=1731973746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkS4Adcluut9E9TBSf0Q5Dr6BdVnPYdslAPkTGEhwiY=;
        b=vE3j3An1o1a7juNKlP82+dNAyPgLPKFuMomn/kw1a1d465mo9/z/0nXwn5MgU3Q9xZ
         jcZoDXoAOfWm+7jdxIVAnELsZSgLhGQCuTAphBN/IVn8Q7C4dcaogpcy880gowwi0McJ
         1iTGHXmqZON4Ul7EhVdfYEsA3UWunG4MZJiumZrzxzisvXHY7MmUvsV3FAXCUehpV3oO
         n2p0/Gysf2w/LMm9Gd3IxkgUc553CO7pbVJPepDNq1Np2OX3bQF9mUBc/o7ZjTrXNINr
         HvFw0WYsG9OpQz0tl2OL4qL+gACl7zUJEeDYYR+iDW+Yij8YmYeDpO7RYsXw7IG0DCrh
         eWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368946; x=1731973746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkS4Adcluut9E9TBSf0Q5Dr6BdVnPYdslAPkTGEhwiY=;
        b=isMRf0CutW7wqqXXAQQl//rDopP9iJxexRHt4sAIgV5AEyX4qNMMOpAWlKcHGjcQZq
         tJ88DZzAHdi7imc6ezN2tROnj+FSz44p1HUbWRrMigpGVu904AyPWn2eJNURfJ0LDDLe
         tK7MNnRfwpoPtZHtSudAmVFL+hsdMdCQlEI2isa9PR/ySIQnyKdqcYTf3KnuhkpiZPZA
         UAjN2V36CNfZOYbU8drDl2PNuf2/9gd6G7UfuW8N7NJujmXY3VEu0p5z31dI1wD8eqN7
         dxedaxnpJf/gxicMMuWOjRgdAlcgB62exp0K0K2YXelXOICIMbkYvXpwI8aMwsn2Tejn
         /WQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT8gFnN94YKAc2TCh6nm8N7MHpMM1lA6GpNKg2JumcSjOQ787gN2AMOoYGBgb7CYq1jT6OqfkVWdrzt2O4@vger.kernel.org
X-Gm-Message-State: AOJu0YzXL3hWf7myCNyJRT4o90pYDQ+lJ51+lWtW7LlzvRGyBgAPygC6
	uv9xqv0SX0+JjngggAP36Ghb5xYfAIxhWf342JvH7IGK0KOWtkFQQut9oS7Huxk=
X-Google-Smtp-Source: AGHT+IH28qnmC+d/sJZ3EdxK+NK8za6V+wXT31dNckiLvxFVwcmETmxIGu/BBIMvr9bfEpwgK4E2eA==
X-Received: by 2002:a05:6a00:a1a:b0:71e:71ba:9056 with SMTP id d2e1a72fcca58-7241407b632mr20781928b3a.10.1731368946274;
        Mon, 11 Nov 2024 15:49:06 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/16] ext4: add RWF_UNCACHED write support
Date: Mon, 11 Nov 2024 16:37:39 -0700
Message-ID: <20241111234842.2024180-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
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


