Return-Path: <linux-fsdevel+bounces-51630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE1AD97BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4783A4A29ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA228EA76;
	Fri, 13 Jun 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZUhcCp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70328EA65;
	Fri, 13 Jun 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851466; cv=none; b=MVdRR7VpJv7i9GZUArc0Fi/hHOInAG+hK3jQxiH+AcsGcdIHpeHLRZ4E8qkD/x5IaV8IKi/OHfyUcpp5+pjRXcjyRF24cui+UjLqPMsty8MbQJEMhuRGjEdVwSHyRJRDE3Leg+icFKiVe2Hf8t6bSq2yu8nJR6dqwxC/iDDE7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851466; c=relaxed/simple;
	bh=NbVcWNErDUPJ0b/YyMi/QMe5DBSGxpQBZsgfxILjfSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erJOx5cVrbpOFpaNQoCIqkob1LW7jl9+aBLXHmc5O5OSxf9hVQIF7Rz11t0pFb2Sohdftm0LY8g9Wjjf5fOn+9Hb074fiQXy3O6tOiYSlggIR8wLP1ND97O5bR5kX630FiYbUhWdncfM4TTFn193OdfbJHnpJ5wMw8sJL79lmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZUhcCp8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9e87f78so27761425ad.2;
        Fri, 13 Jun 2025 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851463; x=1750456263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfcfku3VSZ/Zj0uP5QIqk4w/+NsJ7WJQ4W48WZy1pqw=;
        b=TZUhcCp8ovw3CGDNRBiEPTAnJHEBfM42qrKO9l7s23fTNGRkAoK1BxntPnRFoE1NhJ
         U0NOv+54rq4BAWboabQsvHtDAFUO+RJ1B1oGKqLscSuDMnrOHcGLlG1Ggsm1L4lIHaIA
         MLEsoUGLe1QxCIRRboN3YPb65av+UIlqYKNK8vvVXdQTzGGnVeSZHVTy6cwmjNivZjAV
         qeyNvFG8/HG2SeXA7+P4Np7s1g4reC52/GeEJ0yFEw5E4+7FvV3/LGhtlgV7I/Fu0mWF
         w4W//41YvYkjk83j5ZgyCFh1KnPHmnq9Hg6J3UpPkBpRRzNbF7zzO21Pj9pVHR2elnLo
         CShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851463; x=1750456263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfcfku3VSZ/Zj0uP5QIqk4w/+NsJ7WJQ4W48WZy1pqw=;
        b=Go+hjGtcwkhSqB2/ky9l3/k393pBAJW+ot7mBBQEAgdbYr/TEnAFQveAxm8VLfFxNH
         zSsPUmB3AJRMb0Cb772d/RZ/v9IX7GZ8JyFBiHPD4+jbCrxoTvFeZpcfT+05y7SeILHc
         nSCVb6Pt3qa/YFfw/669RvdjEaPkaMqndOQOdm8D8V949BRRHwsIH2wt0JxHiwduKsq7
         8CZ0GgWiUb3uF1HECjwtZxBpP+RNVIOJtMAjr35Z2a7W3nDoUS+kpHyaV3ixEuccMuY8
         UKlVxCzLVyiZJD2kwl/IQYSJCmwzTe/7eJRwleliJTecD1hSJBfG1AvUJgjApDQsDMb1
         uu3A==
X-Forwarded-Encrypted: i=1; AJvYcCXnzROZv53k6LmAhwWPRYUMZutShpA6hKM7sqOFiynFSaXs1ZRIJkekHRVnqqNfMNTTpgBsxVtBptE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy571NhuvQkssnULk4n+GvJD9xi1HJ5aQu8PuHzJbNnqo9xqWbP
	yNbDm51qDdFrik1Xuph2yoYntzwHunHwOv+jZYok5SkoGna1n9FGKY5/GLnAcQ==
X-Gm-Gg: ASbGncvMkbigLe27xYdbUCrsqWEa8JeMzgoyKUUXkCD/HiEY9UA4iBXCgZWu7+BQHAl
	Yit4bLYbzaTh/+ZQQ+cQ7Swmyl2M5biV3OH6aPdJXif6s6ApGtMLqm/YSZSk7LHG35EA8eXDBNe
	iT6aIHVa8ONoGqHSJ6H0WORuhtHjD80qFyi3e8nz0z5RIk9lvIBcgSE6nJcUxFTJjC0o05hbmxz
	RB/wkToLmbCdoGRofEM6A9O0+eMyC1w60h5qz8Ky/gTGUyc6ceNHild8KPHvyETQERM2QeiPcnU
	5cz48E7WXsFaoCboyysbCoHzxWGw3A0+iD9CK2aIVRp5YYSGvo/LVLb5
X-Google-Smtp-Source: AGHT+IHmLwKkL6d/1slxGCwzulr4InRZwxLV8ZN9PVWcYCy1oH7+EezbzXHeeukDTDrOND8RY+vC0w==
X-Received: by 2002:a17:902:db11:b0:235:ecf2:397 with SMTP id d9443c01a7336-2366b1364admr14130755ad.33.1749851462902;
        Fri, 13 Jun 2025 14:51:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c6ab91sm3896326a91.48.2025.06.13.14.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:02 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 10/16] iomap: replace ->map_blocks() with generic ->writeback_folio() for writeback
Date: Fri, 13 Jun 2025 14:46:35 -0700
Message-ID: <20250613214642.2903225-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the larger effort to have iomap buffered io code support
generic io, replace map_blocks() with writeback_folio() and move the
bio writeback code into a helper function, iomap_bio_writeback_folio(),
that callers using bios can directly invoke.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          | 38 +++++-----
 block/fops.c                                  |  7 +-
 fs/gfs2/bmap.c                                |  7 +-
 fs/iomap/buffered-io-bio.c                    | 49 +++++++++++-
 fs/iomap/buffered-io.c                        | 74 +++++--------------
 fs/iomap/internal.h                           |  4 -
 fs/xfs/xfs_aops.c                             | 14 +++-
 fs/zonefs/file.c                              |  7 +-
 include/linux/iomap.h                         | 42 ++++++++---
 9 files changed, 148 insertions(+), 94 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 9f0e8a46cc8c..5d018d504145 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -278,7 +278,7 @@ writeback.
 It does not lock ``i_rwsem`` or ``invalidate_lock``.
 
 The dirty bit will be cleared for all folios run through the
-``->map_blocks`` machinery described below even if the writeback fails.
+``->writeback_folio`` machinery described below even if the writeback fails.
 This is to prevent dirty folio clots when storage devices fail; an
 ``-EIO`` is recorded for userspace to collect via ``fsync``.
 
@@ -290,29 +290,33 @@ The ``ops`` structure must be specified and is as follows:
 .. code-block:: c
 
  struct iomap_writeback_ops {
-     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
-                       loff_t offset, unsigned len);
+     int (*writeback_folio)(struct iomap_writeback_folio_range *ctx);
      int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
      void (*discard_folio)(struct folio *folio, loff_t pos);
  };
 
 The fields are as follows:
 
-  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
-    range (in bytes) given by ``offset`` and ``len``.
-    iomap calls this function for each dirty fs block in each dirty folio,
-    though it will `reuse mappings
+  - ``writeback_folio``: iomap calls this function for each dirty fs block
+    in each dirty folio, though it will `reuse mappings
     <https://lore.kernel.org/all/20231207072710.176093-15-hch@lst.de/>`_
     for runs of contiguous dirty fsblocks within a folio.
-    Do not return ``IOMAP_INLINE`` mappings here; the ``->iomap_end``
-    function must deal with persisting written data.
-    Do not return ``IOMAP_DELALLOC`` mappings here; iomap currently
-    requires mapping to allocated space.
-    Filesystems can skip a potentially expensive mapping lookup if the
-    mappings have not changed.
-    This revalidation must be open-coded by the filesystem; it is
-    unclear if ``iomap::validity_cookie`` can be reused for this
-    purpose.
+    For blocks that need to be mapped first, please take a look at
+    ``iomap_bio_writeback_folio`` which takes in a ``iomap_map_blocks_t``
+    mapping function. For that mapping function,
+
+      * Set ``wpc->iomap`` to the space mapping of the file range (in bytes)
+        given by ``offset`` and ``len``.
+      * Do not return ``IOMAP_INLINE`` mappings here; the ``->iomap_end``
+        function must deal with persisting written data.
+      * Do not return ``IOMAP_DELALLOC`` mappings here; iomap currently
+        requires mapping to allocated space.
+      * Filesystems can skip a potentially expensive mapping lookup if the
+        mappings have not changed.
+      * This revalidation must be open-coded by the filesystem; it is
+        unclear if ``iomap::validity_cookie`` can be reused for this
+        purpose.
+
     This function must be supplied by the filesystem.
 
   - ``submit_ioend``: Allows the file systems to hook into writeback bio
@@ -323,7 +327,7 @@ The fields are as follows:
     transactions from process context before submitting the bio.
     This function is optional.
 
-  - ``discard_folio``: iomap calls this function after ``->map_blocks``
+  - ``discard_folio``: iomap calls this function after ``->writeback_folio``
     fails to schedule I/O for any part of a dirty folio.
     The function should throw away any reservations that may have been
     made for the write.
diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..c35fe1495fd2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -551,8 +551,13 @@ static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
 				  IOMAP_WRITE, &wpc->iomap, NULL);
 }
 
+static int blkdev_writeback_folio(struct iomap_writeback_folio_range *ctx)
+{
+	return iomap_bio_writeback_folio(ctx, blkdev_map_blocks);
+}
+
 static const struct iomap_writeback_ops blkdev_writeback_ops = {
-	.map_blocks		= blkdev_map_blocks,
+	.writeback_folio	= blkdev_writeback_folio,
 };
 
 static int blkdev_writepages(struct address_space *mapping,
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 7703d0471139..d13dfa986e18 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2486,6 +2486,11 @@ static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
 	return ret;
 }
 
+static int gfs2_writeback_folio(struct iomap_writeback_folio_range *ctx)
+{
+	return iomap_bio_writeback_folio(ctx, gfs2_map_blocks);
+}
+
 const struct iomap_writeback_ops gfs2_writeback_ops = {
-	.map_blocks		= gfs2_map_blocks,
+	.writeback_folio	= gfs2_writeback_folio,
 };
diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index d5dfa1b3eef7..e052fc8b46c1 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -9,6 +9,7 @@
 #include <linux/writeback.h>
 
 #include "internal.h"
+#include "trace.h"
 
 static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
@@ -208,7 +209,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
  * At the end of a writeback pass, there will be a cached ioend remaining on the
  * writepage context that the caller will need to submit.
  */
-int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
+static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, loff_t pos, loff_t end_pos,
 		unsigned len)
@@ -290,3 +291,49 @@ int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	wbc_account_cgroup_owner(wbc, folio, len);
 	return 0;
 }
+
+int iomap_bio_writeback_folio(struct iomap_writeback_folio_range *ctx,
+		iomap_map_blocks_t map_blocks)
+{
+	struct iomap_writepage_ctx *wpc = ctx->wpc;
+	struct folio *folio = ctx->folio;
+	u64 pos = ctx->pos;
+	u64 end_pos = ctx->end_pos;
+	u32 dirty_len = ctx->dirty_len;
+	struct writeback_control *wbc = ctx->wbc;
+	struct inode *inode = folio->mapping->host;
+	int error;
+
+	do {
+		unsigned map_len;
+
+		error = map_blocks(wpc, inode, pos, dirty_len);
+		if (error)
+			break;
+		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
+
+		map_len = min_t(u64, dirty_len,
+			wpc->iomap.offset + wpc->iomap.length - pos);
+		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+
+		switch (wpc->iomap.type) {
+		case IOMAP_INLINE:
+			WARN_ON_ONCE(1);
+			error = -EIO;
+			break;
+		case IOMAP_HOLE:
+			break;
+		default:
+			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
+					end_pos, map_len);
+			if (!error)
+				ctx->async_writeback = true;
+			break;
+		}
+		dirty_len -= map_len;
+		pos += map_len;
+	} while (dirty_len && !error);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(iomap_bio_writeback_folio);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2f620ebe20e2..2b8d733f65da 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1486,57 +1486,6 @@ int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 	return error;
 }
 
-static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, u64 end_pos,
-		unsigned dirty_len, bool *async_writeback)
-{
-	int error;
-
-	do {
-		unsigned map_len;
-
-		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
-		if (error)
-			break;
-		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
-
-		map_len = min_t(u64, dirty_len,
-			wpc->iomap.offset + wpc->iomap.length - pos);
-		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
-
-		switch (wpc->iomap.type) {
-		case IOMAP_INLINE:
-			WARN_ON_ONCE(1);
-			error = -EIO;
-			break;
-		case IOMAP_HOLE:
-			break;
-		default:
-			error = iomap_bio_add_to_ioend(wpc, wbc, folio, inode,
-					pos, end_pos, map_len);
-			if (!error)
-				*async_writeback = true;
-			break;
-		}
-		dirty_len -= map_len;
-		pos += map_len;
-	} while (dirty_len && !error);
-
-	/*
-	 * We cannot cancel the ioend directly here on error.  We may have
-	 * already set other pages under writeback and hence we have to run I/O
-	 * completion to mark the error state of the pages under writeback
-	 * appropriately.
-	 *
-	 * Just let the file system know what portion of the folio failed to
-	 * map.
-	 */
-	if (error && wpc->ops->discard_folio)
-		wpc->ops->discard_folio(folio, pos);
-	return error;
-}
-
 /*
  * Check interaction of the folio with the file end.
  *
@@ -1603,9 +1552,14 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	bool async_writeback = false;
 	int error = 0;
 	u32 rlen;
+	struct iomap_writeback_folio_range ctx = {
+		.wpc = wpc,
+		.wbc = wbc,
+		.folio = folio,
+		.end_pos = end_pos,
+	};
 
 	WARN_ON_ONCE(!folio_test_locked(folio));
 	WARN_ON_ONCE(folio_test_dirty(folio));
@@ -1646,14 +1600,20 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
-		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
-				pos, end_pos, rlen, &async_writeback);
-		if (error)
+		ctx.pos = pos;
+		ctx.dirty_len = rlen;
+		WARN_ON(!wpc->ops->writeback_folio);
+		error = wpc->ops->writeback_folio(&ctx);
+
+		if (error) {
+			if (wpc->ops->discard_folio)
+				wpc->ops->discard_folio(folio, pos);
 			break;
+		}
 		pos += rlen;
 	}
 
-	if (async_writeback)
+	if (ctx.async_writeback)
 		wpc->nr_folios++;
 
 	/*
@@ -1675,7 +1635,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!async_writeback)
+		if (!ctx.async_writeback)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 27e8a174dc3f..6efb5905bf4f 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -37,9 +37,6 @@ int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error);
 #ifdef CONFIG_BLOCK
 int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 		size_t poff, size_t plen, const struct iomap *iomap);
-int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, loff_t end_pos, unsigned len);
 void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
 		struct iomap_readpage_ctx *ctx, size_t poff, size_t plen,
 		loff_t length);
@@ -47,7 +44,6 @@ void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error);
 void iomap_submit_bio(struct bio *bio);
 #else
 #define iomap_bio_read_folio_sync(...)		(-ENOSYS)
-#define iomap_bio_add_to_ioend(...)		(-ENOSYS)
 #define iomap_bio_readpage(...)		((void)0)
 #define iomap_bio_ioend_error(...)		((void)0)
 #define iomap_submit_bio(...)			((void)0)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 63151feb9c3f..8878c015bd48 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -455,6 +455,11 @@ xfs_ioend_needs_wq_completion(
 	return false;
 }
 
+static int xfs_writeback_folio(struct iomap_writeback_folio_range *ctx)
+{
+	return iomap_bio_writeback_folio(ctx, xfs_map_blocks);
+}
+
 static int
 xfs_submit_ioend(
 	struct iomap_writepage_ctx *wpc,
@@ -526,7 +531,7 @@ xfs_discard_folio(
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
-	.map_blocks		= xfs_map_blocks,
+	.writeback_folio	= xfs_writeback_folio,
 	.submit_ioend		= xfs_submit_ioend,
 	.discard_folio		= xfs_discard_folio,
 };
@@ -608,6 +613,11 @@ xfs_zoned_map_blocks(
 	return 0;
 }
 
+static int xfs_zoned_writeback_folio(struct iomap_writeback_folio_range *ctx)
+{
+	return iomap_bio_writeback_folio(ctx, xfs_zoned_map_blocks);
+}
+
 static int
 xfs_zoned_submit_ioend(
 	struct iomap_writepage_ctx *wpc,
@@ -621,7 +631,7 @@ xfs_zoned_submit_ioend(
 }
 
 static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
-	.map_blocks		= xfs_zoned_map_blocks,
+	.writeback_folio	= xfs_zoned_writeback_folio,
 	.submit_ioend		= xfs_zoned_submit_ioend,
 	.discard_folio		= xfs_discard_folio,
 };
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 42e2c0065bb3..11901e40e810 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -145,8 +145,13 @@ static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
 					IOMAP_WRITE, &wpc->iomap, NULL);
 }
 
+static int zonefs_writeback_folio(struct iomap_writeback_folio_range *ctx)
+{
+	return iomap_bio_writeback_folio(ctx, zonefs_write_map_blocks);
+}
+
 static const struct iomap_writeback_ops zonefs_writeback_ops = {
-	.map_blocks		= zonefs_write_map_blocks,
+	.writeback_folio	= zonefs_writeback_folio,
 };
 
 static int zonefs_writepages(struct address_space *mapping,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 51cf3e863caf..fe827948035d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -16,6 +16,7 @@ struct inode;
 struct iomap_iter;
 struct iomap_dio;
 struct iomap_writepage_ctx;
+struct iomap_writeback_folio_range;
 struct iov_iter;
 struct kiocb;
 struct page;
@@ -427,18 +428,13 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
 
 struct iomap_writeback_ops {
 	/*
-	 * Required, maps the blocks so that writeback can be performed on
-	 * the range starting at offset.
+	 * Required.
 	 *
-	 * Can return arbitrarily large regions, but we need to call into it at
-	 * least once per folio to allow the file systems to synchronize with
-	 * the write path that could be invalidating mappings.
-	 *
-	 * An existing mapping from a previous call to this method can be reused
-	 * by the file system if it is still valid.
+	 * If the writeback is done asynchronously, the caller is responsible
+	 * for ending writeback on the folio once all the dirty ranges have been
+	 * written out and the caller should set ctx->async_writeback to true.
 	 */
-	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
-			  loff_t offset, unsigned len);
+	int (*writeback_folio)(struct iomap_writeback_folio_range *ctx);
 
 	/*
 	 * Optional, allows the file systems to hook into bio submission,
@@ -464,6 +460,16 @@ struct iomap_writepage_ctx {
 	u32			nr_folios;	/* folios added to the ioend */
 };
 
+struct iomap_writeback_folio_range {
+	struct iomap_writepage_ctx *wpc;
+	struct writeback_control *wbc;
+	struct folio *folio;
+	u64 pos;
+	u64 end_pos;
+	u32 dirty_len;
+	bool async_writeback; /* should get set to true if writeback is async */
+};
+
 struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
 		loff_t file_offset, u16 ioend_flags);
 struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
@@ -541,4 +547,20 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 
 extern struct bio_set iomap_ioend_bioset;
 
+/*
+ * Maps the blocks so that writeback can be performed on the range
+ * starting at offset.
+ *
+ * Can return arbitrarily large regions, but we need to call into it at
+ * least once per folio to allow the file systems to synchronize with
+ * the write path that could be invalidating mappings.
+ *
+ * An existing mapping from a previous call to this method can be reused
+ * by the file system if it is still valid.
+ */
+typedef int iomap_map_blocks_t(struct iomap_writepage_ctx *wpc,
+		struct inode *inode, loff_t offset, unsigned int len);
+int iomap_bio_writeback_folio(struct iomap_writeback_folio_range *ctx,
+		iomap_map_blocks_t map_blocks);
+
 #endif /* LINUX_IOMAP_H */
-- 
2.47.1


