Return-Path: <linux-fsdevel+bounces-67983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F35C4F9EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A60189CA48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76D0329E74;
	Tue, 11 Nov 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvizOMZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B6329E6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889928; cv=none; b=ljdOvPKiWepHG27MIfnW3ZRc4rBK/VWk2cDYPGHZb43lWQRO7MmNrGHVaDTAY75Oy29z547CfOnwz2xMvEC3zH29n1pCaCOdvfi2B+88Cf6OU51oXO8cpDNyl9Ete7Wpp8KsZRpsxHwitU2X7lmnKLDzlw1eVRsI55s6qcthqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889928; c=relaxed/simple;
	bh=cyoTaLaottisMY1HnT5NSYot4BrYYwhIGZPvB5Lk7JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+G3JbLypeorfQrMLUoXZk8wspGwvoXtK/Bt6st8w6nAtlJX3TqGhpHDhazOXDmDtMr178bpFh8Z+Dr3c2wlc8kKJmytK5Prni6kxw1D5sdSpiwj0STMgdDDnlMzsjqeLGeSxCYsJbCbZ7B1i6JCn9xtytnxCmBdNNFwQicrzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvizOMZf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298250d7769so460915ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889926; x=1763494726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZec5BBmk2NNLD4sTOq2D6MRjgBTSjS+rNb+U3sQ1Cc=;
        b=LvizOMZf3wndW2Fm2IUsi5uFGJbe4skcY0R1m9SHhVUiPyzD80yzs5y5KabkQsf+fb
         Vjd5c71lVjTPT1SgsynS35xxocvBgKf73Ef7nw8eyc0n0myys+eiatEpebpia2TXp+Zc
         1ZYnumphe5DZB3SgKfQ8YzSySVTCJ6eodZrFk96++0sRCH7vLxf5S+Bzne18Kb3hO7ND
         20K/GMMHTZZr3ZxRI/wTu30gFyHyI9RkUa0MPdesjM/zrFNjcokaHe1e0Aj4cHwOF47r
         7OexxrqUGZfIsvP0Wzf+6TtuQPPOH+sdlMUegf52+BMyzezyeCfDNdiib6O+ohsRYKck
         E/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889926; x=1763494726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZec5BBmk2NNLD4sTOq2D6MRjgBTSjS+rNb+U3sQ1Cc=;
        b=Y9fKyXteqPCJPMA9TVOvFoVM2LP9Y1QWSXhy2QqZ8bMFrhFlhO2Ysu4wO3pAplC7MF
         M4w0f1b4u69nooTchngadD1Gw1dPg/0eYVFiHpvk0WzBSHf9sTcQHxEm8qEBuFh0SsbF
         YSHc7kk79u7m5GIx/SUyM37hXm54B4H8/lM86GiSD4ZTMbH0myFaQ5ibiYVqg2KeAwv2
         SmkCDw2OumL5D4Sb+zRBYACmf/hjCPAAci37X5vFukIhdmiYlgO6Yvq4OtMF2Yzkn5CX
         +km2QkMMR+mTn9nrhPQknrbWF4Ag+M68dX6I2stCgR8100y3udUejW1MK4MKay8meV7m
         J5jw==
X-Forwarded-Encrypted: i=1; AJvYcCVaRseDYYUJgrUDEwDqJSWO47Dm3SkwJ2lcMSMfQyHux+Q9dg+l6sFUjTB0WodGCYMu8kRN7I0eRBueieYM@vger.kernel.org
X-Gm-Message-State: AOJu0YztWr34/KuWGg8ibrK+XiVslYoewsDSGQ/guD3q6QpKwDfNWktz
	WU9TCLu1Lhwe64kycFKiUyA9ncPnW4qR4g0zMH9z5Nwors/zmy3NXkO6
X-Gm-Gg: ASbGncsyuB4VSXpTX7xb5w5t+LIVm/5kYxKP2U94F6kXe59YXT8uQxO04fqFrAoYPxA
	lvAFsfmgQY+7m0HIvCW282UbS+F04sHkzvJyeXttSILcdlct6Dkagn/ZUzKyH6eoeemv5+Gqcuw
	Pd4MohmX4S+DHjprp+na2VrKKImIeEOZtW9YZpft7cb3Sx3JQG1qO2gxYvRPlBo3/rIVIod2rJC
	I8ZKRCB0jJqnmhJ7yqXZ5AS6qsiuaa1Xs8mLizmPkaNsXOzoFw1quKMB/9yMGovUHZ/QEkzjtWm
	lg1arLfY+Q1s8f4InyXFZCc8VUsINk6OVoiBMsqc7fg7wxev/2mGTkcFrqcq26TxXSmJGLIToZC
	8iLxBezrEFj7x9JbyVv+5t0FLGjzV2k7EazZ+G0s8FEIoVALox+/IvFuKoH8YIsN0n9QIeMzoQ2
	h0TvzRUTxsagAdDvFPMTzQKjGfNSXNniw0E7i20Q==
X-Google-Smtp-Source: AGHT+IHeJAhB1wlFUc9LNWXM2VibNesOpzuAmxQDFoN3TreqIZ+BC/gMbNgPG8xlUojjdNnCgwQFyA==
X-Received: by 2002:a17:903:11c8:b0:297:e1f5:191b with SMTP id d9443c01a7336-2984ed2b8dbmr6206845ad.11.1762889925612;
        Tue, 11 Nov 2025 11:38:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd097fsm5165665ad.86.2025.11.11.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 4/9] iomap: optimize pending async writeback accounting
Date: Tue, 11 Nov 2025 11:36:53 -0800
Message-ID: <20251111193658.3495942-5-joannelkoong@gmail.com>
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

Pending writebacks must be accounted for to determine when all requests
have completed and writeback on the folio should be ended. Currently
this is done by atomically incrementing ifs->write_bytes_pending for
every range to be written back.

Instead, the number of atomic operations can be minimized by setting
ifs->write_bytes_pending to the folio size, internally tracking how many
bytes are written back asynchronously, and then after sending off all
the requests, decrementing ifs->write_bytes_pending by the number of
bytes not written back asynchronously. Now, for N ranges written back,
only N + 2 atomic operations are required instead of 2N + 2.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/fuse/file.c         |  4 +--
 fs/iomap/buffered-io.c | 58 +++++++++++++++++++++++++-----------------
 fs/iomap/ioend.c       |  2 --
 include/linux/iomap.h  |  2 --
 4 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8275b6681b9b..b343a6f37563 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1885,7 +1885,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		iomap_finish_folio_write(inode, ap->folios[i], 1);
+		iomap_finish_folio_write(inode, ap->folios[i],
+					 ap->descs[i].length);
 
 	wake_up(&fi->page_waitq);
 }
@@ -2221,7 +2222,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		ap = &wpa->ia.ap;
 	}
 
-	iomap_start_folio_write(inode, folio, 1);
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
 				      offset, len);
 	data->nr_bytes += len;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0eb439b523b1..1873a2f74883 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1641,16 +1641,25 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-void iomap_start_folio_write(struct inode *inode, struct folio *folio,
-		size_t len)
+static void iomap_writeback_init(struct inode *inode, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 
 	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
-	if (ifs)
-		atomic_add(len, &ifs->write_bytes_pending);
+	if (ifs) {
+		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
+		/*
+		 * Set this to the folio size. After processing the folio for
+		 * writeback in iomap_writeback_folio(), we'll subtract any
+		 * ranges not written back.
+		 *
+		 * We do this because otherwise, we would have to atomically
+		 * increment ifs->write_bytes_pending every time a range in the
+		 * folio needs to be written back.
+		 */
+		atomic_set(&ifs->write_bytes_pending, folio_size(folio));
+	}
 }
-EXPORT_SYMBOL_GPL(iomap_start_folio_write);
 
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
@@ -1667,7 +1676,7 @@ EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
-		bool *wb_pending)
+		size_t *bytes_submitted)
 {
 	do {
 		ssize_t ret;
@@ -1681,11 +1690,11 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		pos += ret;
 
 		/*
-		 * Holes are not be written back by ->writeback_range, so track
+		 * Holes are not written back by ->writeback_range, so track
 		 * if we did handle anything that is not a hole here.
 		 */
 		if (wpc->iomap.type != IOMAP_HOLE)
-			*wb_pending = true;
+			*bytes_submitted += ret;
 	} while (rlen);
 
 	return 0;
@@ -1756,7 +1765,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	bool wb_pending = false;
+	size_t bytes_submitted = 0;
 	int error = 0;
 	u32 rlen;
 
@@ -1776,14 +1785,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
 		}
 
-		/*
-		 * Keep the I/O completion handler from clearing the writeback
-		 * bit until we have submitted all blocks by adding a bias to
-		 * ifs->write_bytes_pending, which is dropped after submitting
-		 * all blocks.
-		 */
-		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
-		iomap_start_folio_write(inode, folio, 1);
+		iomap_writeback_init(inode, folio);
 	}
 
 	/*
@@ -1798,13 +1800,13 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
-				&wb_pending);
+				&bytes_submitted);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (wb_pending)
+	if (bytes_submitted)
 		wpc->nr_folios++;
 
 	/*
@@ -1822,12 +1824,20 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * bit ourselves right after unlocking the page.
 	 */
 	if (ifs) {
-		if (atomic_dec_and_test(&ifs->write_bytes_pending))
-			folio_end_writeback(folio);
-	} else {
-		if (!wb_pending)
-			folio_end_writeback(folio);
+		/*
+		 * Subtract any bytes that were initially accounted to
+		 * write_bytes_pending but skipped for writeback.
+		 */
+		size_t bytes_not_submitted = folio_size(folio) -
+				bytes_submitted;
+
+		if (bytes_not_submitted)
+			iomap_finish_folio_write(inode, folio,
+					bytes_not_submitted);
+	} else if (!bytes_submitted) {
+		folio_end_writeback(folio);
 	}
+
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab26..86f44922ed3b 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -194,8 +194,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
-	iomap_start_folio_write(wpc->inode, folio, map_len);
-
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
 	 * file size updates in the ioend completion are byte-accurate.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a5032e456079..b49e47f069db 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -478,8 +478,6 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
 void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		int error);
-void iomap_start_folio_write(struct inode *inode, struct folio *folio,
-		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 
-- 
2.47.3


