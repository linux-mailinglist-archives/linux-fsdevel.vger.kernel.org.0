Return-Path: <linux-fsdevel+bounces-66997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201EC32F8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F44EEB0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D12DC332;
	Tue,  4 Nov 2025 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGdGfkR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA42C0F8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289512; cv=none; b=SmnytSe+VD/feBfjWtQpaa1tkLk47SBAOyKsW3hLy5sOvCj4qit9wDlyhP8GjHqtPkMWKVuGOpuMJ+/g/i7aVef+G/bKfFhaBvSDRtAin/Qqdm1QHHAa/sOtkxKL7pmRmRFxMDTRoWAeB0A49BtsPg0LUlFq4fTpEYC4KEMUVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289512; c=relaxed/simple;
	bh=Iyls74rQT+EYCJC+VqVLhy1Toj81b+nHISudeOKuuJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J14/2gOgvwk6dEkfPJvpTFOs/U6AVQ8I+bh4dSV58ydo782dhIjvHOI3ZhGA6601G7WMLyIvTzScezpPqFlWhMp2AXIJEh8v4mfjGEriKtPMLUw5GTve3qd4Kojje181XaJPDsc4dgfXJTZ9pN4HB5F1vzPP43XhzECgCjVToSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGdGfkR6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso3544027b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289510; x=1762894310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZsaI+8U5K+LCzIBiYw5Q/ARHRU3sjYcDuF3x8VIPYY=;
        b=MGdGfkR6F90rffQvqAWhkM9D5LB0beMSWLkw2dy4x6oKi7/uqxJBnu5XrK4DtHHmLe
         3jLAtNmJ96TDL/IXIF/vWmJVcR88Y7Bl6ALr5cgEzQ+Qcs9mk+s0Oq2BxS0IFCxTT2gG
         1XSSHwnRWOsIIdwFkBg9voxV8349GHuCZ989+nV4qHrSIjOLmLYWaFRI0bV6XC82MlYG
         aAP33Skb5NcFbeXguCs3M90fypjU8iIuyL7ZkrA6MXKtxfB0MmO15nRcJUEx/2c/lJ7+
         t/yLgeWnHQlwrsZkERw8QZxSC1aAn5kOZSgfHFPSHB7Tex9SLfD84g426ZbtXU1HZIFq
         v0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289510; x=1762894310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZsaI+8U5K+LCzIBiYw5Q/ARHRU3sjYcDuF3x8VIPYY=;
        b=liquEHBic1u9M5CJmbFCD7B3aZnlUeOUywiW9HfsTRz+vX2qVcLqOMxnuEYJa9XOBv
         I9dtPfLZ86AdY9L1nFxajUtDw/6AKtuKuw+LtkBvE0gfPrPh6VkR+ZUar9SAoV9ff8Jv
         X4vszjDh2TmOYeTp1yV8jRsG+Tp0rnBjhzM2IWfvl5JC357n6wBKb6P0JFCLWpkAWUBX
         SakBv25kUguNvaiLy8d7zQvsRUrrbs+ies+oU6M8Y97J1IlJEjDKpjGNbInaXyn9aRt2
         d4ESNrG1BUiHbF/YuHb3NbuASkJtJHm/YQqOxH/cHoZ6ODlEfNGbcfuAoZZrWGtHd07P
         +YbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv3iUd0VnnbY4dltEOlZjZvi/9C8u/PlSCz1t9nValJefGV4amr0LICva+hBLsnuq2O0sfG9KPQ4OnL3LD@vger.kernel.org
X-Gm-Message-State: AOJu0YzQY2+8FNaPj0epXymJgI8rpIt0CFOgIn5G5I9escOY+LSiZ5+F
	+qhQASzQbtrrRLvURdiBYIgOOTHniddhDOgpnKSqFgsCjkZFnFeHpykT
X-Gm-Gg: ASbGncvnwf3GZBZClWlFz8FsTmZvZhBZSHYpymyiyysyZTjwIPvHJEyYqydyLS+4JAf
	nhWWKDo8t6c1/awwZTxruSpXe0wLnjm+6fopMq3n+Kq2L49P3tGeSHLfyt+qBMDoZye9ekMCIgd
	BjCyvyMiiKeQAznC52ihpTEvqeJgDzP7kPchlP4SOYbfW3RmadA6G66pIx/NbuXazR7WnK971gr
	hKaMR3Hsiov4O03jeHr1LDqKYdDyo2QUlYc6+03u2RDL+K7/+IsKqwgZBwq+zxeWhnIAHQ9W3kS
	OPVOc0lrR5VzjXJvPN9DvWs0ZoChjTeGIUr2P+a+IpxCq5470Ta3Q2aB3jSbTBQlHbGynrYlSbj
	IMh8RJwG/hie+NKzuFWBTRWf2aBOEtTpWhAb4j2orOwo+cX9guqDxnSPKvd/zEiPAFNK34tW+Eh
	f6DLPlkmwhZB8BCn5TTmcVa2ho99Q=
X-Google-Smtp-Source: AGHT+IHzvDtX20m7mqDOzUMfr0Cf5xOoGmhZ0wpdG6bjRQYTx3u27YZ600gNJUgcsl6D8FGh4paDDA==
X-Received: by 2002:a05:6a00:3cd4:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7ae1f2949a8mr717770b3a.19.1762289509874;
        Tue, 04 Nov 2025 12:51:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd623c55csm3854570b3a.52.2025.11.04.12.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:49 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 6/8] iomap: use loff_t for file positions and offsets in writeback code
Date: Tue,  4 Nov 2025 12:51:17 -0800
Message-ID: <20251104205119.1600045-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
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
index c02d33bff3d0..420fe2865927 100644
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
 
@@ -1677,7 +1678,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
+		struct folio *folio, loff_t pos, u32 rlen, loff_t end_pos,
 		size_t *bytes_submitted)
 {
 	do {
@@ -1709,7 +1710,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
 static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
-		u64 *end_pos)
+		loff_t *end_pos)
 {
 	u64 isize = i_size_read(inode);
 
@@ -1764,9 +1765,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
-	u64 pos = folio_pos(folio);
-	u64 end_pos = pos + folio_size(folio);
-	u64 end_aligned = 0;
+	loff_t pos = folio_pos(folio);
+	loff_t end_pos = pos + folio_size(folio);
+	loff_t end_aligned = 0;
 	size_t bytes_submitted = 0;
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
index 520e967cb501..351c7bd9653d 100644
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


