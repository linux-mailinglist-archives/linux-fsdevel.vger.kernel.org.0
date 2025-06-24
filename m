Return-Path: <linux-fsdevel+bounces-52663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A45AE59D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A8F3BC2FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA204226D03;
	Tue, 24 Jun 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlziD0XG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F63222576;
	Tue, 24 Jun 2025 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731785; cv=none; b=I9Yir2Aa7a+qUBgFhGr6BwkTQiKiJxcPNSSOdLNZOsfl3+LDyT4lP4du00Z4R4qHh0cJxN7Xllq+K1ylZJVnqd7+6o9Mrn8qyPNt+k5p11MdbVLtldl7I5ImcBPimX+bnKYMsJoZ7hfS2nMpz//tzsPX0VSoS8o2ZmENOVsEAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731785; c=relaxed/simple;
	bh=gBUjZe2IbEnnR/HhWxrhGDm/uxgpn+4tjbqin8+9MJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUV3Zo3wryLMda6I2nOwCyXVk4pmaPvuyStU8+xFnozF8LZQ5Jk+dKEDE6xksdNOMzd79xv3/1/59OEVK4+LiwKSNqvbHLmj9BAGtkOep7pJVWZzko9jNquAseGTS9OjHW9Opij+rCuNMkC+zks3hSmkNZ+PaQvjJAO9xfKO7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlziD0XG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31d8dd18cbso5262134a12.3;
        Mon, 23 Jun 2025 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731782; x=1751336582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUyPUEueW4h3pZ3HsmWmKWmkeh5BG85AML4KBXavOKA=;
        b=DlziD0XGjV4xn2KDTGX6Hraib2NinQnVIs7BWAjUBrVMnpufZF2nxNmghXn0SIp2QO
         sKARZTjpICUPARnODTnC0mRtCQOUg5zrr47q5CUxB6EISpYZFrWTbA67nYI6dhevbGcX
         /OIwxLSI14b+vlCvzwO+XJsTIrQ3P7mOBvV0rsaSl2e9tffAe9wWGWq0VZYOk6QhLfFq
         EIEYRdNriWfhXcazRXFmrZ6DhnxVHR18LeJ9dMiFdbdkv7Oz4XSX4Zp3/qiwVt4K+4uw
         GP45JS1U0WQnl9w9zm946jvxYaqy+GtLo5Qc/QBV8I1dOUvAr3VVOXFYBbMR0awat4hO
         aDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731782; x=1751336582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUyPUEueW4h3pZ3HsmWmKWmkeh5BG85AML4KBXavOKA=;
        b=Ligh2lduzMDa4Ou9iyzP6xCb3b2sLH1IlDeElGM/yu5p72WoKNq7TLyZOTGzV7/1+f
         ZfD4CDsd6VA4f5qMftabkPW9EiRzObdxa/aT/6LU0Cid3PZuD2yEKO/TWHAzakKvVgJS
         Hrh4gDGG0O++onSLj5+6iKnMp/r2LENpgFy05RRiZNL+8c1ieemrazJKjgjQwOm63KsZ
         0AR//f6HRMrGFnbT6HYcY+5cn7d47BZHjTOo3nOhPHaYYyBM/H/0E43iuJCGQTbCHqsH
         3zzRGQlr0hb974Ft1bx+RT0OZf0xUZoEv5HCWF/hJ/zoiDIBJINP0WAKuhygbNNpayZz
         Vzeg==
X-Forwarded-Encrypted: i=1; AJvYcCWyjtn6yPzs6TWqh3w28jQLr4oTahudXVBmfZTbTRCe1+ZUxm5hWFu4d2Oz8vxwAqmTtovQgGK5B88k@vger.kernel.org, AJvYcCXFUhUocElkLR0xX8duSYuoc0wZrz3yrMIWABaIqvLpMfF473oTusP2uCoNP88qjGza0UpnIcbzlUiz@vger.kernel.org, AJvYcCXtnnoqQnDKD1ziwPD2C9BmGdnDxQUuj5bDKMrQuxC6CR4YcxIOkcx69Fw2VrmSqMBIhWwW+hqw6krv+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxclt/INLNGbDQB0SEiNmGleEpCCD0r/D6HeJgV21tIyqmUDmBn
	Zt0xSCvPGExGqcndpny4egBZTzxPoNL1mjLjRPwTLFRJz6bbIs+hycCLvDB5Qw==
X-Gm-Gg: ASbGncsBxFCjcNXGbuNC7P6zAiij9iY+xqcu9cagSooOjc+tIO8pIgkcWXuBr7nX/5N
	FkMfRU3qeP2CFCQIEBpvRwpGCD66kOMIqdHzhsOQfX/K1WWuPDuMsdhVtdIy+PV57oYPR46ey7B
	D+GI41R8ahEmIAdo2DdNM98WfqER3EQsfcDpFVWNfNCbNZltm6lMPeu3SD2Vj+2tmthysovAL2T
	hhOEU8mxY1g+EHu4IESlLZ0TrDdY0XNFk1htx1iWkbfjatnhTfpDBHVnLa2K6rS/x1c5peskMPc
	SnZGvFofcm6FRHpFPdc9eJBtgly6O2c8jXFfiAbxCKIFfcskXXl8ZWc1
X-Google-Smtp-Source: AGHT+IE/1A2G8zyHy8FNUz93+skLR2+HlfusjRG1jZmUEPS5MYU6iF3vBJq+xG3aJJHkGgFVgF/w9A==
X-Received: by 2002:a17:902:cf41:b0:235:5a9:976f with SMTP id d9443c01a7336-237d9852fcfmr284102235ad.24.1750731781944;
        Mon, 23 Jun 2025 19:23:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a36dsm94633855ad.126.2025.06.23.19.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:01 -0700 (PDT)
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
Subject: [PATCH v3 03/16] iomap: refactor the writeback interface
Date: Mon, 23 Jun 2025 19:21:22 -0700
Message-ID: <20250624022135.832899-4-joannelkoong@gmail.com>
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

Replace ->map_blocks with a new ->writeback_range, which differs in the
following ways:

 - it must also queue up the I/O for writeback, that is called into the
   slightly refactored and extended in scope iomap_add_to_ioend for
   each region
 - can handle only a part of the requested region, that is the retry
   loop for partial mappings moves to the caller
 - handles cleanup on failures as well, and thus also replaces the
   discard_folio method only implemented by XFS.

This will allow to use the iomap writeback code also for file systems
that are not block based like fuse.

Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/iomap/operations.rst          |  23 +--
 block/fops.c                                  |  25 ++-
 fs/gfs2/bmap.c                                |  26 +--
 fs/iomap/buffered-io.c                        |  93 +++++------
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/xfs_aops.c                             | 154 ++++++++++--------
 fs/zonefs/file.c                              |  28 ++--
 include/linux/iomap.h                         |  20 +--
 8 files changed, 187 insertions(+), 184 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 3b628e370d88..b28f215db6e5 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -271,7 +271,7 @@ writeback.
 It does not lock ``i_rwsem`` or ``invalidate_lock``.
 
 The dirty bit will be cleared for all folios run through the
-``->map_blocks`` machinery described below even if the writeback fails.
+``->writeback_range`` machinery described below even if the writeback fails.
 This is to prevent dirty folio clots when storage devices fail; an
 ``-EIO`` is recorded for userspace to collect via ``fsync``.
 
@@ -283,15 +283,14 @@ The ``ops`` structure must be specified and is as follows:
 .. code-block:: c
 
  struct iomap_writeback_ops {
-     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
-                       loff_t offset, unsigned len);
-     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
-     void (*discard_folio)(struct folio *folio, loff_t pos);
+    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
+    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
+    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
  };
 
 The fields are as follows:
 
-  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
+  - ``writeback_range``: Sets ``wpc->iomap`` to the space mapping of the file
     range (in bytes) given by ``offset`` and ``len``.
     iomap calls this function for each dirty fs block in each dirty folio,
     though it will `reuse mappings
@@ -316,18 +315,6 @@ The fields are as follows:
     transactions from process context before submitting the bio.
     This function is optional.
 
-  - ``discard_folio``: iomap calls this function after ``->map_blocks``
-    fails to schedule I/O for any part of a dirty folio.
-    The function should throw away any reservations that may have been
-    made for the write.
-    The folio will be marked clean and an ``-EIO`` recorded in the
-    pagecache.
-    Filesystems can use this callback to `remove
-    <https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/>`_
-    delalloc reservations to avoid having delalloc reservations for
-    clean pagecache.
-    This function is optional.
-
 Pagecache Writeback Completion
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/block/fops.c b/block/fops.c
index 3394263d942b..b500ff8f55dd 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -537,22 +537,29 @@ static void blkdev_readahead(struct readahead_control *rac)
 	iomap_readahead(rac, &blkdev_iomap_ops);
 }
 
-static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct inode *inode, loff_t offset, unsigned int len)
+static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
+		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
 {
-	loff_t isize = i_size_read(inode);
+	loff_t isize = i_size_read(wpc->inode);
 
 	if (WARN_ON_ONCE(offset >= isize))
 		return -EIO;
-	if (offset >= wpc->iomap.offset &&
-	    offset < wpc->iomap.offset + wpc->iomap.length)
-		return 0;
-	return blkdev_iomap_begin(inode, offset, isize - offset,
-				  IOMAP_WRITE, &wpc->iomap, NULL);
+
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int error;
+
+		error = blkdev_iomap_begin(wpc->inode, offset, isize - offset,
+				IOMAP_WRITE, &wpc->iomap, NULL);
+		if (error)
+			return error;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
 }
 
 static const struct iomap_writeback_ops blkdev_writeback_ops = {
-	.map_blocks		= blkdev_map_blocks,
+	.writeback_range	= blkdev_writeback_range,
 };
 
 static int blkdev_writepages(struct address_space *mapping,
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 7703d0471139..0cc41de54aba 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2469,23 +2469,25 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 	return error;
 }
 
-static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
-		loff_t offset, unsigned int len)
+static ssize_t gfs2_writeback_range(struct iomap_writepage_ctx *wpc,
+		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
 {
-	int ret;
-
-	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(inode))))
+	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(wpc->inode))))
 		return -EIO;
 
-	if (offset >= wpc->iomap.offset &&
-	    offset < wpc->iomap.offset + wpc->iomap.length)
-		return 0;
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int ret;
 
-	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
-	ret = gfs2_iomap_get(inode, offset, INT_MAX, &wpc->iomap);
-	return ret;
+		memset(&wpc->iomap, 0, sizeof(wpc->iomap));
+		ret = gfs2_iomap_get(wpc->inode, offset, INT_MAX, &wpc->iomap);
+		if (ret)
+			return ret;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
 }
 
 const struct iomap_writeback_ops gfs2_writeback_ops = {
-	.map_blocks		= gfs2_map_blocks,
+	.writeback_range	= gfs2_writeback_range,
 };
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 11a55da26a6f..80d8acfaa068 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1676,14 +1676,30 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
  * At the end of a writeback pass, there will be a cached ioend remaining on the
  * writepage context that the caller will need to submit.
  */
-static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, loff_t pos, loff_t end_pos, unsigned len)
+ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
+		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
+	unsigned int map_len = min_t(u64, dirty_len,
+		wpc->iomap.offset + wpc->iomap.length - pos);
 	int error;
 
+	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
+
+	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+
+	switch (wpc->iomap.type) {
+	case IOMAP_INLINE:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	case IOMAP_HOLE:
+		return map_len;
+	default:
+		break;
+	}
+
 	if (wpc->iomap.type == IOMAP_UNWRITTEN)
 		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
@@ -1701,11 +1717,11 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
 
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+	if (!bio_add_folio(&wpc->ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
 	if (ifs)
-		atomic_add(len, &ifs->write_bytes_pending);
+		atomic_add(map_len, &ifs->write_bytes_pending);
 
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
@@ -1748,63 +1764,34 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	 * Note that this defeats the ability to chain the ioends of
 	 * appending writes.
 	 */
-	wpc->ioend->io_size += len;
+	wpc->ioend->io_size += map_len;
 	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
 		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
 
-	wbc_account_cgroup_owner(wpc->wbc, folio, len);
-	return 0;
+	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
+	return map_len;
 }
+EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
 
-static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
+static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
+		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
 		bool *wb_pending)
 {
-	int error;
-
 	do {
-		unsigned map_len;
-
-		error = wpc->ops->map_blocks(wpc, wpc->inode, pos, dirty_len);
-		if (error)
-			break;
-		trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
-				&wpc->iomap);
-
-		map_len = min_t(u64, dirty_len,
-			wpc->iomap.offset + wpc->iomap.length - pos);
-		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+		ssize_t ret;
 
-		switch (wpc->iomap.type) {
-		case IOMAP_INLINE:
-			WARN_ON_ONCE(1);
-			error = -EIO;
-			break;
-		case IOMAP_HOLE:
-			break;
-		default:
-			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
-					map_len);
-			if (!error)
-				*wb_pending = true;
-			break;
-		}
-		dirty_len -= map_len;
-		pos += map_len;
-	} while (dirty_len && !error);
+		ret = wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
+		if (WARN_ON_ONCE(ret == 0 || ret > rlen))
+			return -EIO;
+		if (ret < 0)
+			return ret;
+		rlen -= ret;
+		pos += ret;
+		if (wpc->iomap.type != IOMAP_HOLE)
+			*wb_pending = true;
+	} while (rlen);
 
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
+	return 0;
 }
 
 /*
@@ -1916,8 +1903,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
-		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
-				rlen, &wb_pending);
+		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
+				&wb_pending);
 		if (error)
 			break;
 		pos += rlen;
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 455cc6f90be0..aaea02c9560a 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -169,7 +169,7 @@ DEFINE_EVENT(iomap_class, name,	\
 DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
 DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
 
-TRACE_EVENT(iomap_writepage_map,
+TRACE_EVENT(iomap_add_to_ioend,
 	TP_PROTO(struct inode *inode, u64 pos, unsigned int dirty_len,
 		 struct iomap *iomap),
 	TP_ARGS(inode, pos, dirty_len, iomap),
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 65485a52df3b..8157b6d92c8e 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -233,6 +233,47 @@ xfs_end_bio(
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 }
 
+/*
+ * We cannot cancel the ioend directly on error.  We may have already set other
+ * pages under writeback and hence we have to run I/O completion to mark the
+ * error state of the pages under writeback appropriately.
+ *
+ * If the folio has delalloc blocks on it, the caller is asking us to punch them
+ * out. If we don't, we can leave a stale delalloc mapping covered by a clean
+ * page that needs to be dirtied again before the delalloc mapping can be
+ * converted. This stale delalloc mapping can trip up a later direct I/O read
+ * operation on the same region.
+ *
+ * We prevent this by truncating away the delalloc regions on the folio. Because
+ * they are delalloc, we can do this without needing a transaction. Indeed - if
+ * we get ENOSPC errors, we have to be able to do this truncation without a
+ * transaction as there is no space left for block reservation (typically why
+ * we see a ENOSPC in writeback).
+ */
+static void
+xfs_discard_folio(
+	struct folio		*folio,
+	loff_t			pos)
+{
+	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (xfs_is_shutdown(mp))
+		return;
+
+	xfs_alert_ratelimited(mp,
+		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
+			folio, ip->i_ino, pos);
+
+	/*
+	 * The end of the punch range is always the offset of the first
+	 * byte of the next folio. Hence the end offset is only dependent on the
+	 * folio itself and not the start offset that is passed in.
+	 */
+	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
+				folio_pos(folio) + folio_size(folio), NULL);
+}
+
 /*
  * Fast revalidation of the cached writeback mapping. Return true if the current
  * mapping is valid, false otherwise.
@@ -275,16 +316,17 @@ xfs_imap_valid(
 	return true;
 }
 
-static int
-xfs_map_blocks(
+static ssize_t
+xfs_writeback_range(
 	struct iomap_writepage_ctx *wpc,
-	struct inode		*inode,
-	loff_t			offset,
-	unsigned int		len)
+	struct folio		*folio,
+	u64			offset,
+	unsigned int		len,
+	u64			end_pos)
 {
-	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_inode	*ip = XFS_I(wpc->inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	ssize_t			count = i_blocksize(inode);
+	ssize_t			count = i_blocksize(wpc->inode);
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
 	xfs_fileoff_t		cow_fsb;
@@ -292,7 +334,7 @@ xfs_map_blocks(
 	struct xfs_bmbt_irec	imap;
 	struct xfs_iext_cursor	icur;
 	int			retries = 0;
-	int			error = 0;
+	ssize_t			ret = 0;
 	unsigned int		*seq;
 
 	if (xfs_is_shutdown(mp))
@@ -316,7 +358,7 @@ xfs_map_blocks(
 	 * out that ensures that we always see the current value.
 	 */
 	if (xfs_imap_valid(wpc, ip, offset))
-		return 0;
+		goto map_blocks;
 
 	/*
 	 * If we don't have a valid map, now it's time to get a new one for this
@@ -351,7 +393,7 @@ xfs_map_blocks(
 	 */
 	if (xfs_imap_valid(wpc, ip, offset)) {
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
-		return 0;
+		goto map_blocks;
 	}
 
 	/*
@@ -389,7 +431,12 @@ xfs_map_blocks(
 
 	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
-	return 0;
+map_blocks:
+	ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+	if (ret < 0)
+		goto out_error;
+	return ret;
+
 allocate_blocks:
 	/*
 	 * Convert a dellalloc extent to a real one. The current page is held
@@ -402,9 +449,9 @@ xfs_map_blocks(
 	else
 		seq = &XFS_WPC(wpc)->data_seq;
 
-	error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
-				&wpc->iomap, seq);
-	if (error) {
+	ret = xfs_bmapi_convert_delalloc(ip, whichfork, offset, &wpc->iomap,
+			seq);
+	if (ret) {
 		/*
 		 * If we failed to find the extent in the COW fork we might have
 		 * raced with a COW to data fork conversion or truncate.
@@ -412,10 +459,10 @@ xfs_map_blocks(
 		 * the former case, but prevent additional retries to avoid
 		 * looping forever for the latter case.
 		 */
-		if (error == -EAGAIN && whichfork == XFS_COW_FORK && !retries++)
+		if (ret == -EAGAIN && whichfork == XFS_COW_FORK && !retries++)
 			goto retry;
-		ASSERT(error != -EAGAIN);
-		return error;
+		ASSERT(ret != -EAGAIN);
+		goto out_error;
 	}
 
 	/*
@@ -433,7 +480,11 @@ xfs_map_blocks(
 	ASSERT(wpc->iomap.offset <= offset);
 	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
 	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
-	return 0;
+	goto map_blocks;
+
+out_error:
+	xfs_discard_folio(folio, offset);
+	return ret;
 }
 
 static bool
@@ -488,47 +539,9 @@ xfs_submit_ioend(
 	return 0;
 }
 
-/*
- * If the folio has delalloc blocks on it, the caller is asking us to punch them
- * out. If we don't, we can leave a stale delalloc mapping covered by a clean
- * page that needs to be dirtied again before the delalloc mapping can be
- * converted. This stale delalloc mapping can trip up a later direct I/O read
- * operation on the same region.
- *
- * We prevent this by truncating away the delalloc regions on the folio. Because
- * they are delalloc, we can do this without needing a transaction. Indeed - if
- * we get ENOSPC errors, we have to be able to do this truncation without a
- * transaction as there is no space left for block reservation (typically why
- * we see a ENOSPC in writeback).
- */
-static void
-xfs_discard_folio(
-	struct folio		*folio,
-	loff_t			pos)
-{
-	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
-	struct xfs_mount	*mp = ip->i_mount;
-
-	if (xfs_is_shutdown(mp))
-		return;
-
-	xfs_alert_ratelimited(mp,
-		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
-			folio, ip->i_ino, pos);
-
-	/*
-	 * The end of the punch range is always the offset of the first
-	 * byte of the next folio. Hence the end offset is only dependent on the
-	 * folio itself and not the start offset that is passed in.
-	 */
-	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
-				folio_pos(folio) + folio_size(folio), NULL);
-}
-
 static const struct iomap_writeback_ops xfs_writeback_ops = {
-	.map_blocks		= xfs_map_blocks,
+	.writeback_range	= xfs_writeback_range,
 	.submit_ioend		= xfs_submit_ioend,
-	.discard_folio		= xfs_discard_folio,
 };
 
 struct xfs_zoned_writepage_ctx {
@@ -542,20 +555,22 @@ XFS_ZWPC(struct iomap_writepage_ctx *ctx)
 	return container_of(ctx, struct xfs_zoned_writepage_ctx, ctx);
 }
 
-static int
-xfs_zoned_map_blocks(
+static ssize_t
+xfs_zoned_writeback_range(
 	struct iomap_writepage_ctx *wpc,
-	struct inode		*inode,
-	loff_t			offset,
-	unsigned int		len)
+	struct folio		*folio,
+	u64			offset,
+	unsigned int		len,
+	u64			end_pos)
 {
-	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_inode	*ip = XFS_I(wpc->inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + len);
 	xfs_filblks_t		count_fsb;
 	struct xfs_bmbt_irec	imap, del;
 	struct xfs_iext_cursor	icur;
+	ssize_t			ret;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -586,7 +601,7 @@ xfs_zoned_map_blocks(
 		imap.br_state = XFS_EXT_NORM;
 		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, 0);
-		return 0;
+		goto map_blocks;
 	}
 	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
 	count_fsb = end_fsb - offset_fsb;
@@ -603,9 +618,13 @@ xfs_zoned_map_blocks(
 	wpc->iomap.offset = offset;
 	wpc->iomap.length = XFS_FSB_TO_B(mp, count_fsb);
 	wpc->iomap.flags = IOMAP_F_ANON_WRITE;
-
 	trace_xfs_zoned_map_blocks(ip, offset, wpc->iomap.length);
-	return 0;
+
+map_blocks:
+	ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+	if (ret < 0)
+		xfs_discard_folio(folio, offset);
+	return ret;
 }
 
 static int
@@ -621,9 +640,8 @@ xfs_zoned_submit_ioend(
 }
 
 static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
-	.map_blocks		= xfs_zoned_map_blocks,
+	.writeback_range	= xfs_zoned_writeback_range,
 	.submit_ioend		= xfs_zoned_submit_ioend,
-	.discard_folio		= xfs_discard_folio,
 };
 
 STATIC int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index edca4bbe4b72..c88e2c851753 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -124,29 +124,33 @@ static void zonefs_readahead(struct readahead_control *rac)
  * Map blocks for page writeback. This is used only on conventional zone files,
  * which implies that the page range can only be within the fixed inode size.
  */
-static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
-				   struct inode *inode, loff_t offset,
-				   unsigned int len)
+static ssize_t zonefs_writeback_range(struct iomap_writepage_ctx *wpc,
+		struct folio *folio, u64 offset, unsigned len, u64 end_pos)
 {
-	struct zonefs_zone *z = zonefs_inode_zone(inode);
+	struct zonefs_zone *z = zonefs_inode_zone(wpc->inode);
 
 	if (WARN_ON_ONCE(zonefs_zone_is_seq(z)))
 		return -EIO;
-	if (WARN_ON_ONCE(offset >= i_size_read(inode)))
+	if (WARN_ON_ONCE(offset >= i_size_read(wpc->inode)))
 		return -EIO;
 
 	/* If the mapping is already OK, nothing needs to be done */
-	if (offset >= wpc->iomap.offset &&
-	    offset < wpc->iomap.offset + wpc->iomap.length)
-		return 0;
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int error;
+
+		error = zonefs_write_iomap_begin(wpc->inode, offset,
+				z->z_capacity - offset, IOMAP_WRITE,
+				&wpc->iomap, NULL);
+		if (error)
+			return error;
+	}
 
-	return zonefs_write_iomap_begin(inode, offset,
-					z->z_capacity - offset,
-					IOMAP_WRITE, &wpc->iomap, NULL);
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
 }
 
 static const struct iomap_writeback_ops zonefs_writeback_ops = {
-	.map_blocks		= zonefs_write_map_blocks,
+	.writeback_range	= zonefs_writeback_range,
 };
 
 static int zonefs_writepages(struct address_space *mapping,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 00179c9387c5..063e18476286 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -416,18 +416,20 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
 
 struct iomap_writeback_ops {
 	/*
-	 * Required, maps the blocks so that writeback can be performed on
-	 * the range starting at offset.
+	 * Required, performs writeback on the passed in range
 	 *
-	 * Can return arbitrarily large regions, but we need to call into it at
+	 * Can map arbitrarily large regions, but we need to call into it at
 	 * least once per folio to allow the file systems to synchronize with
 	 * the write path that could be invalidating mappings.
 	 *
 	 * An existing mapping from a previous call to this method can be reused
 	 * by the file system if it is still valid.
+	 *
+	 * Returns the number of bytes processed or a negative errno.
 	 */
-	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
-			  loff_t offset, unsigned len);
+	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
+			struct folio *folio, u64 pos, unsigned int len,
+			u64 end_pos);
 
 	/*
 	 * Optional, allows the file systems to hook into bio submission,
@@ -438,12 +440,6 @@ struct iomap_writeback_ops {
 	 * the bio could not be submitted.
 	 */
 	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
-
-	/*
-	 * Optional, allows the file system to discard state on a page where
-	 * we failed to submit any I/O.
-	 */
-	void (*discard_folio)(struct folio *folio, loff_t pos);
 };
 
 struct iomap_writepage_ctx {
@@ -463,6 +459,8 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
+ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
+		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.1


