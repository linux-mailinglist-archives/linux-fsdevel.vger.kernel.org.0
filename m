Return-Path: <linux-fsdevel+bounces-67986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C50FAC4F9EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0B214E2F0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97E32A3EB;
	Tue, 11 Nov 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH6i7w1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B32329E4E
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889932; cv=none; b=MA3jL9wiND4FXCbWNAfvT1Q8flEUPc0AaUOxSIa+ZYxZ/z3v/Bhiw2iUI2b8wnh4XRTtDX2QnUfJTuwPsHXod7Xy1HOFldgcJ9Hh+o7P2dZ5dK6FQHqZ+mSLfve5SwyvPs5zHfIFFmhFs27H4ckIk3VgLRsVMJBPJRQvs9bItvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889932; c=relaxed/simple;
	bh=VzmVidlf2dd/on2ICTEi7idp/L+wK0kkkhFZkpJ5dbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc6m8PGHXBwkKjtagGYnD1TTiceHDYFB7r/SKNrc7IpAHVOqfk9aAPhxdtVweJC8/04DkG3j6e5frBFa13gRoIUUHl0IvIcsmGsmmxtzv+4sKoruK8vWwI0g5I+3+Oe7j4qimBW9fFJvgvpMJ87K4WgmyGJLqo/h95EGB6p+F+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH6i7w1Z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bbabfe5f2a2so46976a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889930; x=1763494730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzRDwO2Rou+jpO/5t0jHj4hCBUOT4ZDAzqSmHHm4LjQ=;
        b=UH6i7w1Z2vC477hoTaV7hoIDyfEksTr0BlvH2IL96nn+DyhOMHiWp7ViMNGNZptMYl
         uIDbH6MhX8oBvqMJ1aNmDPfrJBmP5ddj2IQ8RsgNrwFj8KmACrkeOL/Lnz4cyXlcyNXq
         jc0uCty/pX6s064RnrkaDQQxjK9Oodywi/mHs9wgBrjdWRQZ64MDTDHkwSxHqSx5yfEp
         FILYvCmRekj/6Ft1Ix/2FBjkp1iqiy6yM1UWC4ymH9eUzyrRfEmDPYLChsD6QB4Hg8yV
         V/0T/1bT0luPoLtR30xHshpzKDMaCAHfq8OiY92HHzLsGLuq3TExsqO5qcqEBDczpZMY
         raVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889930; x=1763494730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzRDwO2Rou+jpO/5t0jHj4hCBUOT4ZDAzqSmHHm4LjQ=;
        b=C/AM7cTxDccLyx44JtVZj8Z0PPvknDQg8Y2SCihG0EDD1ebWonTQPzQMu8KgLK0cQL
         G00nB71SYvK62RnBCKYwpAjnKuCAW4ECP7WD0eyPqA/ZjdlcM1RaZ8K1eNmELoguya3U
         +ZzXgeD4YpW5O3/b7axpf5zMWUCy1TxAsVOYw48jQNhaqtwf8kjmEypz1YEvkQPLEsmQ
         ymNY2PudTn2cymuvKkSrZJA12cOTdY7VNYe2mBJg1Nq4ke54NPc55GcpdKkgSgo8FFjH
         nKEr2GC2R+1zTuY36DdubtKbFg1MPga1EY36MCL7pUDMwIsp3xLpRYhy4PJZnUd+c39y
         GQOw==
X-Forwarded-Encrypted: i=1; AJvYcCUO5i3wHy++xkhLNU4qbSm4B1Hu+SMgXgpUbMsHDggCbSDxq6496zJRK3nBuHQTpXgW874nX0JQg34MdtyZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8nf7jC8eW8eMHZ45LvnXNRWzBQEl0Oi98CA+yZT4kbcZYTOA
	tX9+r/CmyDuLiHqDotMDlHdUKOZqw8ja5kAnmOg4sfRu9Hqbc8p0vIUB
X-Gm-Gg: ASbGncsBZJlXOqH4/zePmMe/9772hB8TnIhAMGS1Q0RJS4IvCcWqIfMOYpAfieXV1m7
	Lv88Rw/IHJ9tK5O6T+0YEqgbfB6bGTZjT3STeX0i8mfQWYKZaBCyw56XDhwW4u61tgeeQEHke8O
	U8tdC3aPB/rMNHUrF/5DqTC/HzrQIFJCiB3MmNdfu5CuX2IGn5RV9saarHN8kZilnOvj0hlbT4u
	ucFyuylZjYsSCZ/6AYDVcp0nhGmpF4Eux9C3Ez/PYhj4sOEzZXEy3DXqtWCJiV98P3Cjv6JeE13
	/8cgNJDTaAN2eslvHiUHUsrheg1vWQoBK0syyT7+mFHu/ZuicTS1OLUdMrc5gSj8WeyTGAGjRLD
	cq0qIUBiviIRhK4E/m9RiaJ2BusmAfg+MpGvJYb4cv568XE4HmwYE16K/lmLFtRYFerN1j7utX/
	9wZIkHMNP14FG1cfF0HcrfhFypwdK5mefvBa1n
X-Google-Smtp-Source: AGHT+IE5mrc5Ap2NKwQrcJKvPQE0cpzdaKhYCxtiU9FIrAeYOC6pEbi//ngRlCnZikKRe/UYyRhdsA==
X-Received: by 2002:a17:902:db0c:b0:295:586d:677d with SMTP id d9443c01a7336-2984edd22e0mr5170615ad.41.1762889930116;
        Tue, 11 Nov 2025 11:38:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf54e6sm5268965ad.37.2025.11.11.11.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:49 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets in writeback code
Date: Tue, 11 Nov 2025 11:36:56 -0800
Message-ID: <20251111193658.3495942-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
index 17449ea13420..98c4665addb2 100644
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
 
@@ -1683,7 +1684,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
+		struct folio *folio, loff_t pos, u32 rlen, loff_t end_pos,
 		size_t *bytes_submitted)
 {
 	do {
@@ -1715,7 +1716,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
 static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
-		u64 *end_pos)
+		loff_t *end_pos)
 {
 	u64 isize = i_size_read(inode);
 
@@ -1770,9 +1771,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
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


