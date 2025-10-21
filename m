Return-Path: <linux-fsdevel+bounces-64973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2AFBF7C44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A9B54050C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628A36CE0C;
	Tue, 21 Oct 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knO+HsZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A30344CE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065115; cv=none; b=lEmzGgEiH4nH/+FihkB8Bix/SLOO7j/pje4RodVd9VQk/hpyKpsj0ePdDss7/Nl7u/LceM2FMqbducAcVCk/v+gOD/NDH1yzityMG6K8G53GTjpXgOlOyXy0G/vOuek/ocmVLqyKRAoBQWuP+w6gRjKY2gmo13WfcrxFwUNyvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065115; c=relaxed/simple;
	bh=9/FAVEdAZo2OEeSG8jqQF5gtO+4N45Z0XihVINBXB1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvMhJxRXUssMKUeqYfsylKMW0FjcbBxiy6i/WxXjO3NKeLNZ/nZoQV4U3nwREJzyJuyxoI5KJGTeSF0bLaKFJqaeKr2gDksARTZLNuNJRHp/SBAIdrmY5pfVUlaCmnaQj+LUklI3QGk8HsfWbtZnIbCJS4/lT2psSdbhL1g6U0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knO+HsZ/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4055798a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065113; x=1761669913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fjrJc0WkSF8x4AtQLGPldjUZdu0aQ+x3kz2h12VQTc=;
        b=knO+HsZ/IorAKC7uOklIxpceGYPR22JM98B8MfvomanqQNhIiv3H60DC6ySTcxwsut
         BWxs1715PzJoGd7u6gD8pm+UenVdoKsmrgd2YD2pyJdiNGKZeX/igLdg7gWeo6QoBjq4
         z3aoyOPKTNo2NOvJV1g+YhE9qNDf3d2MopxfiemozprWwzXvn2aOeCa+g2MmClBUtvJF
         VDtJRWpk7IxL6bxuKzzfUv1ArNsYOf9bG9yjNRitd8OGsBT371BfPpKivOTmpnTAI9s6
         Jdg68AOwhV3L13I98r+IORxKsreBbmT7V95/INOQYaGuX8mxOE8kw63nOEPVP72AtGSu
         dsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065113; x=1761669913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fjrJc0WkSF8x4AtQLGPldjUZdu0aQ+x3kz2h12VQTc=;
        b=IC8b8dW/WUdZmwN9QPeyfM6W+wzZ7B0VDwP+BdJ0pidK1kFNXmriLWe6v0Q3jEcJrz
         VwHW/3kZOrXkOBnQwz1frkH33xDcN5X+C2b2kgkjiYu2pRPxt/J0Lg83DnlXVWLky1Yw
         AsMV+GTN0EdhKCx7S09Q8N3ZO80k9VxcvanM5mx6DQXHuuLBqSH9m2AEcSQ3rW+GRzJ8
         UbRU6dLyqpGgQXYxPDbHGsaf+zRCpujiVuEER6Uz3YV711JGD28I//TSBR32AGKnPICI
         f6dJ1NJmrl8h1Pi8HCEOk3I8JPjx6cl3ARbTbl5aKoTDvlbsqgcJ8TIXmqcIpAU9zvUb
         QhUw==
X-Forwarded-Encrypted: i=1; AJvYcCXdTrbFPBu/ITeuve0DIT2Tsn/QJ6u1r4pDcGQqIqs0WzFYaMexrMoG6akdEpPrWaxt0gzn65fD5RNquXUC@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjbpkpvJ6ve5nMaKjo/+p1Kfh8ZrjrX7bMH7g7SFdhPY6s1nG
	97V/AkwVmK4qkBxu0YEiHGv2OmErzepwJ6EtXV9/tgf9vIpG5LviQYIRFphWSQ==
X-Gm-Gg: ASbGncuPWhS+La+jGAa4aSJpjCpdT6pZ39V1EEdpeDol0Z01C4L2hCOxwfM0gR4zOKb
	j9c7XoWEWIBMWHzdnQNrVAe9c6biYWqhSTrjAL9EyzJmHlxKfcMj2UzTXwA2e5hxYkzeCt2j4QD
	oRZEPWA7zi/cmNYY2RQxtY+vvWG/jmpQ6W2Ab/inA+y+Vo4bExiM5m8+NHgF/ieqIypRGRYhzlJ
	7UC4xgx3yf1QNLxXSH97WwqLckemalbEt/7iFFZ4ncuaIigF4HAO5shlKXGEUwoHyf665GgqoBT
	GsIYof1szlbPaDzS9w7doT8Ny12g+ImmjrCoUI4bec5/StHEo9sidBERSSQJb+2RdGU9lNi+jvk
	rhiNe55R7m41nPX0dSlRBHgBhTT2kU+yYSgCqWSm8bJbrnuY2UKwi0E3IIvE71y3cxyPdnStR2F
	XRs31f8gOcp0AmjEBQoYUEqRyPacw/LrwwHqHQhnd/nPqIopU=
X-Google-Smtp-Source: AGHT+IEZV4tQk45TH+4RLUXDWWACZKUCrwMsNTPYKntqaCqGOM0FARhv8fh+OmTqZCbfy6pgP2aHDQ==
X-Received: by 2002:a17:902:d587:b0:269:8fa3:c227 with SMTP id d9443c01a7336-290c9c8a5f1mr184060845ad.8.1761065112758;
        Tue, 21 Oct 2025 09:45:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6cfsm114181045ad.107.2025.10.21.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 3/8] iomap: optimize pending async writeback accounting
Date: Tue, 21 Oct 2025 09:43:47 -0700
Message-ID: <20251021164353.3854086-4-joannelkoong@gmail.com>
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
---
 fs/fuse/file.c         |  4 ++--
 fs/iomap/buffered-io.c | 44 +++++++++++++++++-------------------------
 fs/iomap/ioend.c       |  2 --
 include/linux/iomap.h  |  2 --
 4 files changed, 20 insertions(+), 32 deletions(-)

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
index 636d2398c9b4..06d6abda5f75 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1603,16 +1603,16 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
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
+		atomic_set(&ifs->write_bytes_pending, folio_size(folio));
+	}
 }
-EXPORT_SYMBOL_GPL(iomap_start_folio_write);
 
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
@@ -1629,7 +1629,7 @@ EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
-		bool *wb_pending)
+		unsigned *bytes_pending)
 {
 	do {
 		ssize_t ret;
@@ -1643,11 +1643,11 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		pos += ret;
 
 		/*
-		 * Holes are not be written back by ->writeback_range, so track
+		 * Holes are not written back by ->writeback_range, so track
 		 * if we did handle anything that is not a hole here.
 		 */
 		if (wpc->iomap.type != IOMAP_HOLE)
-			*wb_pending = true;
+			*bytes_pending += ret;
 	} while (rlen);
 
 	return 0;
@@ -1718,7 +1718,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	bool wb_pending = false;
+	unsigned bytes_pending = 0;
 	int error = 0;
 	u32 rlen;
 
@@ -1738,14 +1738,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
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
@@ -1760,13 +1753,13 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
-				&wb_pending);
+				&bytes_pending);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (wb_pending)
+	if (bytes_pending)
 		wpc->nr_folios++;
 
 	/*
@@ -1783,13 +1776,12 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	if (ifs) {
-		if (atomic_dec_and_test(&ifs->write_bytes_pending))
-			folio_end_writeback(folio);
-	} else {
-		if (!wb_pending)
-			folio_end_writeback(folio);
-	}
+	if (ifs)
+		iomap_finish_folio_write(inode, folio,
+			folio_size(folio) - bytes_pending);
+	else if (!bytes_pending)
+		folio_end_writeback(folio);
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
index d1a1e993cfe7..655f60187f8f 100644
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


