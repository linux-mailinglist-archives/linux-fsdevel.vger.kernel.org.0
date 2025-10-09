Return-Path: <linux-fsdevel+bounces-63695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3611BCB281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797943B20C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D328727C;
	Thu,  9 Oct 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKm9chsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314526A0BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050670; cv=none; b=Zn4fbGz1xR+ijgQe9Bo6EYeNrHtK8+xFpjjsCLxvMjHY659oLIC9VVW2whUY1n2gYtR40GVVAxtRc5PlZXQKeAFNUYp1kXysg57Hz2UdxdzMzJZ/Ytd9kwYBwY/gUaTfFZB2RaBk/Wkf0YagBTSVDA/tHf0HyUtW2iaOoJqOqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050670; c=relaxed/simple;
	bh=y8Wha30cK2892xKhBquvq1nFxtsjO0kUWfaITLs+alY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt8/bEUgM1izVE6v+k5sseJ0Ce8w6Io15tBTBEXF+DI7DCN6WRuJgPrgdDfLOADpRGa7QUzvoD0NDu/fmafNbm8lJz1mf62Ti/l8Drbr8Ma5N5QBBIK+kG7nFd8VDOQdnnLYBj8IkTZlVZgISVNcVYHkJT18kQU/yTB1vms8Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKm9chsg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so16569695ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050668; x=1760655468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0epLCP3Fw0g8denJGI8pq0BqUANFV6lTlXymoNTg2c=;
        b=aKm9chsgO+8TmV6qZlL2s5hl8vy1vcAPbpu+BuR6HX8xC8DBMlJ0rADO+961Q9uq4Q
         Ba5K7VJZpDYXukySq0ieW8mIM8UnvjBqkWVzEGd5/0MOlkDcD4XEhFkw10o8egmyef+z
         n9mqfYd/bDLlpSdEeJkVAllUdtXN2svnPpjA+qlzkArlUIXj+s/1qwwydJ7IMf0Q61Bf
         PplEnLQm7nkhlUjQb/c+JlFXX/F3fHyG8alGgcnLpLp2iPA1Ohsk/nZMIqkoD3caeo6N
         tU9NGyHillzUYhTFPdrOkv1LDzPYMdEWn033aFikjFIsBmWyxw4LUVvAN/B8QhuxeqbP
         4AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050668; x=1760655468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0epLCP3Fw0g8denJGI8pq0BqUANFV6lTlXymoNTg2c=;
        b=r4CSyykfnSvHDzp+ffeYsqLNa8YzOZqwJ68ZyNWpNpLHcpVO5I3QbkEn076DnIMrYT
         Lp47Fq/3nigcykjN92pR42Y04vjl9vveXk9ax8hufTXp/STB17i9Vn9L2SfY5w+9uNX6
         6qPlS33Y4Ico8nb4ME8vATpbj6T0ADJ70EcMMgCu6uBCfLr+4p/IQnXMGyn8kR5/wyHj
         HCVsRQai0qWh2t6ZN0fuMLBFOFrxA9vnA7W/hXtx9U6fiIPUmR89ree/f4dXkLbKE2aX
         xNFvwz/gJrt+RsjxakukhAtzTwx04B+ErIYoawcTsWE3efToOrkix3dHa6i4lXEOf0Ua
         cTjw==
X-Forwarded-Encrypted: i=1; AJvYcCVu2bBF68Lalip7K+fKR78O3X78OXCZaCmKoBm0zkSu8TPppovwad1ilx1AYSrT9x7ZUkaRXaX4J0mdv1PX@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCvCT0/LBMlmJYvG3X+NJGorqflJgRSV3RguFKhj9680W1LVx
	6rJ86rVl4/vkI6VX563iPNjC7Oc0xg9dyq4hfuZOmbvsN+3fcx6FSLrj
X-Gm-Gg: ASbGncvT9SOu0VMGL+iGPeHBJNzsZZ1l94Gw3xcUKJt8d1kiigG39RmS3WK4EE4f782
	QCnl0SFpT/HEn2pBFObMUfqbzRHxejgqnM9+553AF2yOVsrFdVPHc+YMTk0HrpfmHy1D1GHXiZe
	7dH0d1bCbOg9JstAKYijTMEgCOCKpJJD7iNHoZsmig/JejR2aJT8kGLnQegiJTg6/sDfNGek28n
	2p1oJuTxRTygqpXc5JZg2qj3/QrrEpDwImXfXi7CgxaUx9O04pwnqp3tyxSmVLdLFSaIlBMb/VI
	FjV3vyYHIX4DQ9ZFJOJ8l6b6f3WHc6SVo+FAl/FyGSOVtU6+vWsykd8IVeI0oKXTzc++BdB6WO/
	QZWNg8apESQnRowebidmkgifa9LY4yoijXq2rZLAf8mF67nY2jlUdDfD8aqgSQgk1n4q0Zzfovk
	l0JsYqpCi+
X-Google-Smtp-Source: AGHT+IH3i2HdpC3jLIXWpUx+cqB2mjzJO1QbIdNFsCbPFWH986BxtOlOV5k6snxnETBldBCV0gJObw==
X-Received: by 2002:a17:903:1b4d:b0:28e:9a74:7b58 with SMTP id d9443c01a7336-290273ecbb7mr105451285ad.31.1760050668194;
        Thu, 09 Oct 2025 15:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f089a3sm39030635ad.76.2025.10.09.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 7/9] iomap: use loff_t for file positions and offsets in writeback code
Date: Thu,  9 Oct 2025 15:56:09 -0700
Message-ID: <20251009225611.3744728-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009225611.3744728-1-joannelkoong@gmail.com>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use loff_t instead of u64 for file positions and offsets, consistent
with kernel VFS conventions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c         |  4 ++--
 fs/iomap/buffered-io.c | 17 +++++++++--------
 fs/xfs/xfs_aops.c      |  8 ++++----
 include/linux/iomap.h  |  4 ++--
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 591789adb00b..c44c058feeb0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2172,8 +2172,8 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 }
 
 static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
-					  struct folio *folio, u64 pos,
-					  unsigned len, u64 end_pos)
+					  struct folio *folio, loff_t pos,
+					  unsigned len, loff_t end_pos)
 {
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 372e14f7ab57..66c47404787f 100644
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
 
@@ -1603,7 +1604,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
-		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
+		struct folio *folio, loff_t pos, u32 rlen, loff_t end_pos,
 		unsigned *wb_bytes_pending)
 {
 	do {
@@ -1634,7 +1635,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
 static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
-		u64 *end_pos)
+		loff_t *end_pos)
 {
 	u64 isize = i_size_read(inode);
 
@@ -1689,9 +1690,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
-	u64 pos = folio_pos(folio);
-	u64 end_pos = pos + folio_size(folio);
-	u64 end_aligned = 0;
+	loff_t pos = folio_pos(folio);
+	loff_t end_pos = pos + folio_size(folio);
+	loff_t end_aligned = 0;
 	unsigned wb_bytes_pending = 0;
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
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c417bb8718e3..8045d4c430ae 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -438,8 +438,8 @@ struct iomap_writeback_ops {
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


