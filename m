Return-Path: <linux-fsdevel+bounces-64976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A882CBF7C35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 470794F5B63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6C3473FA;
	Tue, 21 Oct 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9Bt1RHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06A347400
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065119; cv=none; b=NkPSOzWie/2DYvmkdHSuJqdUZiDp3tIel1VlIZT09eqSDnyPJt60K9c2QIKTzid6NByd5BrzgCF0fwDV211UAAgE5cX4FMUM/+qS5V9By1MC86Ske5BJ7YNcyg31N/T2wlD/98Uv/hM2TsHHn9o/ayUud8OJ31IwAclTGFEQK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065119; c=relaxed/simple;
	bh=lXIsXmcAXYAwnN8v/i047AAwg4YNI+NNq/QO7PsmS6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHZ08AVt/1qUdAgCQLd28uBYHx8VVp7z1mLXyGH5C0VLFtABdVD7Pll6T7Jj13CYy/NtubBELIAJcsjidOh6Q8HUrS02swa8ui1wGZBH2SnaZJu/fgWTj5Nkb8G0LKztqKKkE90NGhDnLgAxZEi5rh79EqsUQBvzcnYDm/+8x4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9Bt1RHh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so7154496a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065117; x=1761669917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1UEknu6+AqhuYpVkCF+ytOITBbhN1ZcxY9rGAbRl1o=;
        b=e9Bt1RHh80/PUEJ/7uXwRsJWQbFWd9z2kc7GPykz2s93WNqPp8Bwcstt9HLb+1dbIl
         J6tknw1W3dpgcIKGWK/WphH9UEmf1/qC5tr1D8/Ac5mCMCxEJF5qEZCoIDB8tlO6CVuG
         OJpysEVAvsD/WRMus89VkrHwIchChEux5HUpYcSZIXi1yZcN4w2gX29W99xvj6V/5y6W
         T+fKBzi675RuFLbYCpG9lvcHP6G/nnm9wLSRWYRpGGruqYkL0872Z3teIY4Lh85xSb0j
         c8elLnj7fLr/zlK6iKp2092oODvE8kVxIGrLlHFm/zF1Qr8UInVkRTMP7G0ZGCboe4dG
         8ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065117; x=1761669917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1UEknu6+AqhuYpVkCF+ytOITBbhN1ZcxY9rGAbRl1o=;
        b=VqWOhRkyVHZ8S1fG35ZqjLMwY1A8Fx63SRqKf2BLyvA123Y8aLMCF51mhZz19e5gES
         QTRWqE4kPxCuU5T5px+/cwZW9grayS7qdCEA7XMncFeFRYCVHi1D88RbdmO5zbt++uXv
         0D8Tu28txf0E7YbnX/nvhzKQfqMjQDeLQWuR3zdmBAbHRCBUdlc8qz/14+Brj+1kuq1L
         0JN1xsEKLniWtKvfyfzQtguZ++lHssxflk8ihah/WqYBWQL7CqTOB/V2hJ4nGiyMiFGa
         n2aUutZJMS+mteKmuhRBUnbCPx0UDgJVcBSB2mw22TtDy3KiKCx7nHiIKUHFHpLqbkMj
         odZg==
X-Forwarded-Encrypted: i=1; AJvYcCVROn5CUrkpGDWA88DNFQFRixeypBoqlTlTN0ICz+RhtFQwt0cTIRugM1ii24RACuu122DYrD0iRLxV1uLj@vger.kernel.org
X-Gm-Message-State: AOJu0YycOU0+8bj49B5N+t0w1ynljd2EOj+SAYrEeZ0e/UxvaTtdUhBa
	dEkSGK2VvdcIl/e9sAN7ZKO+0WEYI0aha7ys6C3TeJrJSeWNU1JN+Eqr
X-Gm-Gg: ASbGncs1bmT4LzrT2E+SnePYf+I6lxgy7ETO3XVrArgCPPf1+hoMZMTfSQntfMwqYmw
	WP4lw9Ad2bcsNtmqTsXuT0lkxs8b/y/b25LoUbBUP8fA4Gifr7weNZhykDIWJyHuWZV8sycPwit
	f5JM0s2pQXGzOcAM0uCjeqevl0GfC6zZ5QOj9GnR845DlQxh0bt6wtcKXpe7xdcIoUgxzRyAMZe
	mBBgLLXqbC0a8bdRl48VdHn3U9z/VXqxNDraj75rxYc7bkBs0NwGDlXqAFlECKOtS/0dto934Ci
	/K1Rr/hz3XxAqWaDcypQ//8p8HWG3jghvZpaVcTRqh9INl8eIG29TxV2ujUoSUkbHFA7zPrYt6b
	CVgIhtRMqsgdds9HbNu5DGlA3TELH1UR9eSuGCDIdf+yJWx1YI4NCd8R6+Mwmekna+NYWUNisOQ
	QS5T5um/6Q2b7nVmm320CfrQswGR/ohGY33D0ABw==
X-Google-Smtp-Source: AGHT+IGAUpa81okMfzff6n6qfuJXPuY/MPl8GrgX0FQzxxW8jTBY75N0SrsAUHeOPuLfVrjNrCvtSQ==
X-Received: by 2002:a17:90b:3911:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-33bcf91b8demr27608606a91.33.1761065117174;
        Tue, 21 Oct 2025 09:45:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a34esm43828a91.15.2025.10.21.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 6/8] iomap: use loff_t for file positions and offsets in writeback code
Date: Tue, 21 Oct 2025 09:43:50 -0700
Message-ID: <20251021164353.3854086-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021164353.3854086-1-joannelkoong@gmail.com>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use loff_t instead of u64 for file positions and offsets to be
consistent with kernel VFS conventions. Both are 64-bit types. loff_t is
signed for historical reasons but this has no practical effect.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c           |  3 ++-
 fs/fuse/file.c         |  4 ++--
 fs/gfs2/bmap.c         |  3 ++-
 fs/iomap/buffered-io.c | 17 +++++++++--------
 fs/xfs/xfs_aops.c      |  8 ++++----
 fs/zonefs/file.c       |  3 ++-
 include/linux/iomap.h  |  4 ++--
 7 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 4dad9c2d5796..d2b96143b40f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -550,7 +550,8 @@ static void blkdev_readahead(struct readahead_control *rac)
 }
 
 static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
+		struct folio *folio, loff_t offset, unsigned int len,
+		loff_t end_pos)
 {
 	loff_t isize = i_size_read(wpc->inode);
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7bcb650a9f26..6d5e44cbd62e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2168,8 +2168,8 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 }
 
 static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
-					  struct folio *folio, u64 pos,
-					  unsigned len, u64 end_pos)
+					  struct folio *folio, loff_t pos,
+					  unsigned len, loff_t end_pos)
 {
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 131091520de6..2b61b057151b 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2473,7 +2473,8 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 }
 
 static ssize_t gfs2_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
+		struct folio *folio, loff_t offset, unsigned int len,
+		loff_t end_pos)
 {
 	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(wpc->inode))))
 		return -EIO;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f1bc191beca..a8baf62fef30 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -86,7 +86,8 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
 }
 
 static unsigned ifs_find_dirty_range(struct folio *folio,
-		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
+		struct iomap_folio_state *ifs, loff_t *range_start,
+		loff_t range_end)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned start_blk =
@@ -110,8 +111,8 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
 	return nblks << inode->i_blkbits;
 }
 
-static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
-		u64 range_end)
+static unsigned iomap_find_dirty_range(struct folio *folio, loff_t *range_start,
+		loff_t range_end)
 {
 	struct iomap_folio_state *ifs = folio->private;
 
@@ -1629,7 +1630,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
+		struct folio *folio, loff_t pos, u32 rlen, loff_t end_pos,
 		unsigned *bytes_pending)
 {
 	do {
@@ -1661,7 +1662,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
 static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
-		u64 *end_pos)
+		loff_t *end_pos)
 {
 	u64 isize = i_size_read(inode);
 
@@ -1716,9 +1717,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
-	u64 pos = folio_pos(folio);
-	u64 end_pos = pos + folio_size(folio);
-	u64 end_aligned = 0;
+	loff_t pos = folio_pos(folio);
+	loff_t end_pos = pos + folio_size(folio);
+	loff_t end_aligned = 0;
 	unsigned bytes_pending = 0;
 	int error = 0;
 	u32 rlen;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 0c2ed00733f2..593a34832116 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -480,9 +480,9 @@ static ssize_t
 xfs_writeback_range(
 	struct iomap_writepage_ctx *wpc,
 	struct folio		*folio,
-	u64			offset,
+	loff_t			offset,
 	unsigned int		len,
-	u64			end_pos)
+	loff_t			end_pos)
 {
 	ssize_t			ret;
 
@@ -630,9 +630,9 @@ static ssize_t
 xfs_zoned_writeback_range(
 	struct iomap_writepage_ctx *wpc,
 	struct folio		*folio,
-	u64			offset,
+	loff_t			offset,
 	unsigned int		len,
-	u64			end_pos)
+	loff_t			end_pos)
 {
 	ssize_t			ret;
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c1e5e30e90a0..d748ed99ac2d 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -126,7 +126,8 @@ static void zonefs_readahead(struct readahead_control *rac)
  * which implies that the page range can only be within the fixed inode size.
  */
 static ssize_t zonefs_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 offset, unsigned len, u64 end_pos)
+		struct folio *folio, loff_t offset, unsigned len,
+		loff_t end_pos)
 {
 	struct zonefs_zone *z = zonefs_inode_zone(wpc->inode);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b999f900e23b..cc8c85140b00 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -442,8 +442,8 @@ struct iomap_writeback_ops {
 	 * Returns the number of bytes processed or a negative errno.
 	 */
 	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
-			struct folio *folio, u64 pos, unsigned int len,
-			u64 end_pos);
+			struct folio *folio, loff_t pos, unsigned int len,
+			loff_t end_pos);
 
 	/*
 	 * Submit a writeback context previously build up by ->writeback_range.
-- 
2.47.3


