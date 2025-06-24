Return-Path: <linux-fsdevel+bounces-52664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5088BAE59DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11A07A3F12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0A22CBFE;
	Tue, 24 Jun 2025 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k17GyvtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9712248B3;
	Tue, 24 Jun 2025 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731786; cv=none; b=egyU+1kxTq6ZvrdBLT3/CODfZCMiMi9cwR9yRu0vzsv4Hx7WWSXX5utfINgP8odTt+eqdsqY1vGOU1/9scnSZOR8FcBFt54g4Fshn+D2RhLXS9rj7S5CGnipAi8WFTp1Kyva4kQBOKm42uzpyMTnzyRIpeduk6XHMQp5UKMbaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731786; c=relaxed/simple;
	bh=SzxiPsOMPsZzge1AL1NtaYw2gcvuZTve4Tc4FJndV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrcsxMMKgfEjPjNJgzXJ51FGoBTTRupAN4W3li19ubQnqgtJAOBeAtGnLrFCHquYVoY9yjYUkiQRTPh3ydlMKv73ewu3AKyMXao5SYNurBYzA2rSl8kViZ2Vt2YozQ67e+YiR/mKFgJ4Qr6PJSKyWRq4qJpLWNC/ZuQ5xcTmRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k17GyvtD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2366e5e4dbaso40123905ad.1;
        Mon, 23 Jun 2025 19:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731783; x=1751336583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzVF9EyXemWfxxz5SgYDGPu3I4Il1lP7vqiSQqYjpI0=;
        b=k17GyvtDeMPPCcJZP3PFH9z30+1hA34faOKSxqybz7YHUiXdf/5znIc3gVj2wgI+Ns
         nfp/+zqOgHgTpNzwXSKRbA1Hcn4nMBn6s9IcHBW2cGEaG8v4yk3o+xPdBVq6h//pHFGp
         AWo0eijj/UbOBJuCz7v54iezVwIgcqi9nzOjYZiL5+3oMtKx3ROYkQSTyd4fWeiMYQNR
         ycYur4y75l+sQVdUYHwRjUHgqpBbo7Kz2M6LcEiQwOuc6UBqI1gRhmopFPZVZzxjqqLe
         wJbYsM6PL158wbMTiJmQlVHuRVkBquaK5EG5+W0GDfXP7iPyhl2IYfShUOmoVcB3rrHd
         xgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731783; x=1751336583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzVF9EyXemWfxxz5SgYDGPu3I4Il1lP7vqiSQqYjpI0=;
        b=PlfILgjusFeWzjqtpDGDOdPXowT0kDKr95ANylVWhExD1/jRDlv7bIyXakdQv2TNPd
         GVZVzQIHKOoxfGrbRw6lmwKWGkDdP91o+dKlvazdMSpOfwEHHiHDI2+XpIR8Ym/gPCPI
         99tZgQ3d68gj9YsMtIbYz2kQzSvj5BCIDJOXebagYMi6qalr/4YWXuXXNT/4BgN3K7/J
         qUhsMu+cz9U7L8JkXdZBRM46FU5/XiEYrY3FOo2fgMkys9+ZtD8152IqeBuMmEYSQu+I
         OgFNyY3P8o9sqTglrJF1L7K3sRMaZhZz00vXsD1OlegZ6eYuXZ0IsAr43yHTAE0VnkaP
         Q8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU/m+cxyypwWPhiFPZ88X4m1WljqTkAxTyWTCKxL2p3bGYTdSLTZUA3S+T3VbBXF3JhEDpX+7YiW2Sp@vger.kernel.org, AJvYcCUKmwn/yRhA916yIE1wwIbAGFs3GpVMX95Y51gaWA6ZCWWaq0/uvoxAJKbhxvvPQV/5T1eOF8MWDKK7XQ==@vger.kernel.org, AJvYcCX1yBpyRcE9M0iz416Coj8lA45l7ECcZzeVhip1ZmOnqwtUf/nZ5wRFS4mkCmNZ6o5kYPVlvn5CnYgf@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvoPl9FgThHy7i8i//5FqVdp4kiox4+oQ8FYh0MxmJG9J0FXH
	8RuLN+MOxhrfD+o+JLhyD9KpK2Hgcq2H1n0jQKEWZwoHkNlIg8Va9XvFkth/kg==
X-Gm-Gg: ASbGncsMv9HMKENRgTFAjzuHicOEFxQdS53/61M7GouuNNF28NP4/7deZKVsoyGL/hz
	9JwQ2dx1J5Sac6jox+ZvWkT202REIbPvNvP+UgKkaDNMmX6tpw5ZYXpkFNmG7UZ6S55FdeqJ8hX
	wRgEOyE6xytQQNHVCCL05z/LzOc6alnh/5qEwwNagNxAhtyJjLdLhAPNnS6I1Xr+3AqDThztZ1W
	5mP1DhIrkVFXt31/3t/foTI+hKEzsLLneuO+kFqwbm2dn1SpZ4yyAU7PCfHJ5Skms6wrugiWRkt
	JKrVuj1gvpqVYBuPbajyMEZRM0utsFLplka2BYtouDyv6XC3I+hL55m6
X-Google-Smtp-Source: AGHT+IHWyVHgzpM2/6ezM6Jc9O4Puh1NRRwLDmwUM3+rKyeaqPyptbmGkrXYqX8YDjubaP6y3x1QOA==
X-Received: by 2002:a17:902:d507:b0:236:15b7:62e3 with SMTP id d9443c01a7336-2380246a077mr25213695ad.9.1750731783395;
        Mon, 23 Jun 2025 19:23:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86e975esm96294495ad.218.2025.06.23.19.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 04/16] iomap: hide ioends from the generic writeback code
Date: Mon, 23 Jun 2025 19:21:23 -0700
Message-ID: <20250624022135.832899-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
one to facilitate non-block, non-ioend writeback for use.  Rename
the submit_ioend method to writeback_submit and make it mandatory so
that the generic writeback code stops seeing ioends and bios.

Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/iomap/operations.rst          | 16 +---
 block/fops.c                                  |  1 +
 fs/gfs2/bmap.c                                |  1 +
 fs/iomap/buffered-io.c                        | 91 ++++++++++---------
 fs/xfs/xfs_aops.c                             | 60 ++++++------
 fs/zonefs/file.c                              |  1 +
 include/linux/iomap.h                         | 19 ++--
 7 files changed, 93 insertions(+), 96 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index b28f215db6e5..ead56b27ec3f 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -285,7 +285,7 @@ The ``ops`` structure must be specified and is as follows:
  struct iomap_writeback_ops {
     int (*writeback_range)(struct iomap_writepage_ctx *wpc,
     		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
-    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+    int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
  };
 
 The fields are as follows:
@@ -307,13 +307,7 @@ The fields are as follows:
     purpose.
     This function must be supplied by the filesystem.
 
-  - ``submit_ioend``: Allows the file systems to hook into writeback bio
-    submission.
-    This might include pre-write space accounting updates, or installing
-    a custom ``->bi_end_io`` function for internal purposes, such as
-    deferring the ioend completion to a workqueue to run metadata update
-    transactions from process context before submitting the bio.
-    This function is optional.
+  - ``writeback_submit``: Submit the previous built writeback context.
 
 Pagecache Writeback Completion
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -328,12 +322,6 @@ the address space.
 This can happen in interrupt or process context, depending on the
 storage device.
 
-Filesystems that need to update internal bookkeeping (e.g. unwritten
-extent conversions) should provide a ``->submit_ioend`` function to
-set ``struct iomap_end::bio::bi_end_io`` to its own function.
-This function should call ``iomap_finish_ioends`` after finishing its
-own work (e.g. unwritten extent conversion).
-
 Some filesystems may wish to `amortize the cost of running metadata
 transactions
 <https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/>`_
diff --git a/block/fops.c b/block/fops.c
index b500ff8f55dd..cf79cbcf80f0 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -560,6 +560,7 @@ static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
 
 static const struct iomap_writeback_ops blkdev_writeback_ops = {
 	.writeback_range	= blkdev_writeback_range,
+	.writeback_submit	= ioend_writeback_submit,
 };
 
 static int blkdev_writepages(struct address_space *mapping,
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0cc41de54aba..3cd46a09e820 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2490,4 +2490,5 @@ static ssize_t gfs2_writeback_range(struct iomap_writepage_ctx *wpc,
 
 const struct iomap_writeback_ops gfs2_writeback_ops = {
 	.writeback_range	= gfs2_writeback_range,
+	.writeback_submit	= ioend_writeback_submit,
 };
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 80d8acfaa068..50cfddff1393 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1579,7 +1579,7 @@ u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 	return folio_count;
 }
 
-static void iomap_writepage_end_bio(struct bio *bio)
+static void ioend_writeback_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
 
@@ -1588,42 +1588,30 @@ static void iomap_writepage_end_bio(struct bio *bio)
 }
 
 /*
- * Submit an ioend.
- *
- * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we've marked pages for writeback.
- * We cannot cancel ioend directly in that case, so call the bio end I/O handler
- * with the error status here to run the normal I/O completion handler to clear
- * the writeback bit and let the file system proess the errors.
+ * We cannot cancel the ioend directly in case of an error, so call the bio end
+ * I/O handler with the error status here to run the normal I/O completion
+ * handler.
  */
-static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 {
-	if (!wpc->ioend)
-		return error;
+	struct iomap_ioend *ioend = wpc->wb_ctx;
 
-	/*
-	 * Let the file systems prepare the I/O submission and hook in an I/O
-	 * comletion handler.  This also needs to happen in case after a
-	 * failure happened so that the file system end I/O handler gets called
-	 * to clean up.
-	 */
-	if (wpc->ops->submit_ioend) {
-		error = wpc->ops->submit_ioend(wpc, error);
-	} else {
-		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
-			error = -EIO;
-		if (!error)
-			submit_bio(&wpc->ioend->io_bio);
-	}
+	if (!ioend->io_bio.bi_end_io)
+		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
+
+	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
+		error = -EIO;
 
 	if (error) {
-		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
-		bio_endio(&wpc->ioend->io_bio);
+		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_endio(&ioend->io_bio);
+		return error;
 	}
 
-	wpc->ioend = NULL;
-	return error;
+	submit_bio(&ioend->io_bio);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(ioend_writeback_submit);
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 		loff_t pos, u16 ioend_flags)
@@ -1634,7 +1622,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
-	bio->bi_end_io = iomap_writepage_end_bio;
 	bio->bi_write_hint = wpc->inode->i_write_hint;
 	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
@@ -1644,16 +1631,17 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 		u16 ioend_flags)
 {
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
 	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
 		return false;
 	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
+	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
 		return false;
-	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
+	if (pos != ioend->io_offset + ioend->io_size)
 		return false;
 	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
-	    iomap_sector(&wpc->iomap, pos) !=
-	    bio_end_sector(&wpc->ioend->io_bio))
+	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
 		return false;
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
@@ -1679,6 +1667,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
+	struct iomap_ioend *ioend = wpc->wb_ctx;
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
@@ -1709,15 +1698,17 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
 new_ioend:
-		error = iomap_submit_ioend(wpc, 0);
-		if (error)
-			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
+		if (ioend) {
+			error = wpc->ops->writeback_submit(wpc, 0);
+			if (error)
+				return error;
+		}
+		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
 
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, map_len, poff))
+	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
 	if (ifs)
@@ -1764,9 +1755,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	 * Note that this defeats the ability to chain the ioends of
 	 * appending writes.
 	 */
-	wpc->ioend->io_size += map_len;
-	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
-		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
+	ioend->io_size += map_len;
+	if (ioend->io_offset + ioend->io_size > end_pos)
+		ioend->io_size = end_pos - ioend->io_offset;
 
 	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
 	return map_len;
@@ -1956,6 +1947,18 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
 		error = iomap_writepage_map(wpc, folio);
-	return iomap_submit_ioend(wpc, error);
+
+	/*
+	 * If @error is non-zero, it means that we have a situation where some
+	 * part of the submission process has failed after we've marked pages
+	 * for writeback.
+	 *
+	 * We cannot cancel the writeback directly in that case, so always call
+	 * ->writeback_submit to run the I/O completion handler to clear the
+	 * writeback bit and let the file system proess the errors.
+	 */
+	if (wpc->wb_ctx)
+		return wpc->ops->writeback_submit(wpc, error);
+	return error;
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8157b6d92c8e..35ff2cfcd7e7 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -507,41 +507,40 @@ xfs_ioend_needs_wq_completion(
 }
 
 static int
-xfs_submit_ioend(
-	struct iomap_writepage_ctx *wpc,
-	int			status)
+xfs_writeback_submit(
+	struct iomap_writepage_ctx	*wpc,
+	int				error)
 {
-	struct iomap_ioend	*ioend = wpc->ioend;
-	unsigned int		nofs_flag;
+	struct iomap_ioend		*ioend = wpc->wb_ctx;
 
 	/*
-	 * We can allocate memory here while doing writeback on behalf of
-	 * memory reclaim.  To avoid memory allocation deadlocks set the
-	 * task-wide nofs context for the following operations.
+	 * Convert CoW extents to regular.
+	 *
+	 * We can allocate memory here while doing writeback on behalf of memory
+	 * reclaim.  To avoid memory allocation deadlocks, set the task-wide
+	 * nofs context.
 	 */
-	nofs_flag = memalloc_nofs_save();
+	if (!error && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
+		unsigned int		nofs_flag;
 
-	/* Convert CoW extents to regular */
-	if (!status && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
-		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
+		nofs_flag = memalloc_nofs_save();
+		error = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
 				ioend->io_offset, ioend->io_size);
+		memalloc_nofs_restore(nofs_flag);
 	}
 
-	memalloc_nofs_restore(nofs_flag);
-
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction to the completion wq.
+	 */
 	if (xfs_ioend_needs_wq_completion(ioend))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 
-	if (status)
-		return status;
-	submit_bio(&ioend->io_bio);
-	return 0;
+	return ioend_writeback_submit(wpc, error);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
 	.writeback_range	= xfs_writeback_range,
-	.submit_ioend		= xfs_submit_ioend,
+	.writeback_submit	= xfs_writeback_submit,
 };
 
 struct xfs_zoned_writepage_ctx {
@@ -628,20 +627,25 @@ xfs_zoned_writeback_range(
 }
 
 static int
-xfs_zoned_submit_ioend(
-	struct iomap_writepage_ctx *wpc,
-	int			status)
+xfs_zoned_writeback_submit(
+	struct iomap_writepage_ctx	*wpc,
+	int				error)
 {
-	wpc->ioend->io_bio.bi_end_io = xfs_end_bio;
-	if (status)
-		return status;
-	xfs_zone_alloc_and_submit(wpc->ioend, &XFS_ZWPC(wpc)->open_zone);
+	struct iomap_ioend		*ioend = wpc->wb_ctx;
+
+	ioend->io_bio.bi_end_io = xfs_end_bio;
+	if (error) {
+		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_endio(&ioend->io_bio);
+		return error;
+	}
+	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
 	return 0;
 }
 
 static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 	.writeback_range	= xfs_zoned_writeback_range,
-	.submit_ioend		= xfs_zoned_submit_ioend,
+	.writeback_submit	= xfs_zoned_writeback_submit,
 };
 
 STATIC int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c88e2c851753..0c64185325d3 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -151,6 +151,7 @@ static ssize_t zonefs_writeback_range(struct iomap_writepage_ctx *wpc,
 
 static const struct iomap_writeback_ops zonefs_writeback_ops = {
 	.writeback_range	= zonefs_writeback_range,
+	.writeback_submit	= ioend_writeback_submit,
 };
 
 static int zonefs_writepages(struct address_space *mapping,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 063e18476286..047100f94092 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -391,8 +391,7 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 /*
  * Structure for writeback I/O completions.
  *
- * File systems implementing ->submit_ioend (for buffered I/O) or ->submit_io
- * for direct I/O) can split a bio generated by iomap.  In that case the parent
+ * File systems can split a bio generated by iomap.  In that case the parent
  * ioend it was split from is recorded in ioend->io_parent.
  */
 struct iomap_ioend {
@@ -416,7 +415,7 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
 
 struct iomap_writeback_ops {
 	/*
-	 * Required, performs writeback on the passed in range
+	 * Performs writeback on the passed in range
 	 *
 	 * Can map arbitrarily large regions, but we need to call into it at
 	 * least once per folio to allow the file systems to synchronize with
@@ -432,23 +431,22 @@ struct iomap_writeback_ops {
 			u64 end_pos);
 
 	/*
-	 * Optional, allows the file systems to hook into bio submission,
-	 * including overriding the bi_end_io handler.
+	 * Submit a writeback context previously build up by ->writeback_range.
 	 *
-	 * Returns 0 if the bio was successfully submitted, or a negative
-	 * error code if status was non-zero or another error happened and
-	 * the bio could not be submitted.
+	 * Returns 0 if the context was successfully submitted, or a negative
+	 * error code if not.  If @error is non-zero a failure occurred, and
+	 * the writeback context should be completed with an error.
 	 */
-	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+	int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
 };
 
 struct iomap_writepage_ctx {
 	struct iomap		iomap;
 	struct inode		*inode;
 	struct writeback_control *wbc;
-	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
+	void			*wb_ctx;	/* pending writeback context */
 };
 
 struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
@@ -461,6 +459,7 @@ void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 void iomap_sort_ioends(struct list_head *ioend_list);
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
+int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.1


