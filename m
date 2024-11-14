Return-Path: <linux-fsdevel+bounces-34816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116449C8FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04047B35ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B91B140D;
	Thu, 14 Nov 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rR9DGWuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F61AF0C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598104; cv=none; b=OI6p9A30EUtIOIyz6O2wFGCL4LXK1ytntlv0hxH2xFsd8wA8EEn2+QOnhF62Un3GwcCps5NCDFMPtxGvR/Xcuo9MGgZgzTeGSiCVdn5lfopbl6N/l6JStMuNCX0RhGQwj+l6gui/Tspn8mYQd7X1ucqxaF4bDSvpBj0oLtJofrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598104; c=relaxed/simple;
	bh=4XXew23gq3OoMMOZOjmCtGgMeRxntUp+Fg61kUdG93Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFGD3kocaTobHDiD1nFCM+tTH6VGI0b2McX8lCwHzR70vY8tM5peFirRJ2TlB8EtmDjkGXfQKuclNl5rBKqVqS0TqFSX18++TjFZQNfNEKkSrpnwIGW0lK6U7nfoWATgCllMvLlcoI62ly/wHhwLl3y2vD3SWiZ9M9WjApR1aNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rR9DGWuk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-295cee3a962so418719fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598101; x=1732202901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnydZ5ahnoTDPrjopxRhuD9AlpgfRxt1ZJ34FZKhxI0=;
        b=rR9DGWuknEzGNqxGZH8Mcf0el13yrZ8xjZUBdN2I07qYtdGuKwk4Swbs+uU4K5pFuD
         GDj+muRTfHfnOkFG+a5VLKPByoEelfPv4ch4QaA1TOviM3IXSVId0fAd4+foDltKO9HR
         v/izHstC3jCHfbc0gbMDAeOBCBaMaXBZ+CD987zHFcNm2f9qJxhXsNYUIizvt+oWGjxC
         OKiJGwLBqrOfmwAPv9tDY82rPiK1HjH/PPkL45+Wl6MOPvAdxuI/rnnTGVDgtbGT2iov
         F0fSvTrNi3gfhu44gZrTR4SRFx/a7uwtINZpmAvRau03e8esVC7cXBSPuuAahtXvS0+u
         DCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598101; x=1732202901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnydZ5ahnoTDPrjopxRhuD9AlpgfRxt1ZJ34FZKhxI0=;
        b=tj22V2s8FuGhqCQzo7AmyCCu6zYfTyJ/0FS1ctZ9qdzCzn3Kzq0qSMQNFxu0AMRNJQ
         pBJ/wt2q4CXwlSt9O1y5+VQYiwpXd+u/kNAiHT6suLggQluBkJAkwySnLkysyytI2J2H
         ri365WeyTIy0xnc2/1E6yooWWSjUVP1bvC96uoQ3ARbO6dFxjbH96s3hW3zB5ik0gNQe
         51TjxQliNJHt7Ne94vtMDdqyBSYubEYzbcEJqzKzvaUOXsL0U1wa/DYQ4JXZXjvKyu5r
         h3PXpVyl+Y3XKVw4UBz7QmMEekSI/qO5UxEPQ/MeN6w7XXVh0roSeUBlj7artW7g3D5d
         DNUA==
X-Forwarded-Encrypted: i=1; AJvYcCUUmyd7Nx8ucfwzW7qkyS6Hhan3FPZCq1HOHgzURgLfoHJ/9yn2aNBBrp0ogQVSAwXfKNqmGfF5ezYm79Jg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34H1pvbzHh8lDIOW6Fnrs9unGVuNh1tgd0513GD0CouycRohl
	vxXP8d7M9zFNksH44nCG/S/b6aRbzUFKyo1RO7sETue8GRraOf0bNZUbAXBjYNA=
X-Google-Smtp-Source: AGHT+IGNabSsCKonQoe8b+3leqigUS1MxYLou4wkGKabmMMQ9sy0zqR8b1138Alaw/M4bLorq8cnFg==
X-Received: by 2002:a05:6870:e2d5:b0:288:2fb6:a385 with SMTP id 586e51a60fabf-295600dc985mr21855599fac.20.1731598101550;
        Thu, 14 Nov 2024 07:28:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:20 -0800 (PST)
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
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/17] iomap: make buffered writes work with RWF_UNCACHED
Date: Thu, 14 Nov 2024 08:25:18 -0700
Message-ID: <20241114152743.2381672-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
set for a write, mark the folios being written as uncached. Then
writeback completion will drop the pages. The write_iter handler simply
kicks off writeback for the pages, and writeback completion will take
care of the rest.

This still needs the user of the iomap buffered write helpers to call
iocb_uncached_write() upon successful issue of the writes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/buffered-io.c | 15 +++++++++++++--
 include/linux/iomap.h  |  8 +++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..2f2a5db04a68 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -603,6 +603,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	if (iter->flags & IOMAP_UNCACHED)
+		fgp |= FGP_UNCACHED;
 	fgp |= fgf_set_order(len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
@@ -1023,8 +1025,9 @@ ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		const struct iomap_ops *ops, void *private)
 {
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct iomap_iter iter = {
-		.inode		= iocb->ki_filp->f_mapping->host,
+		.inode		= mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
@@ -1034,9 +1037,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		iter.flags |= IOMAP_UNCACHED;
 
-	while ((ret = iomap_iter(&iter, ops)) > 0)
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			iter.iomap.flags |= IOMAP_F_UNCACHED;
 		iter.processed = iomap_write_iter(&iter, i);
+	}
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
@@ -1770,6 +1778,9 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	size_t poff = offset_in_folio(folio, pos);
 	int error;
 
+	if (folio_test_uncached(folio))
+		wpc->iomap.flags |= IOMAP_F_UNCACHED;
+
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
 new_ioend:
 		error = iomap_submit_ioend(wpc, 0);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f61407e3b121..0a88043676f2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -74,9 +74,14 @@ struct vm_fault;
  * IOMAP_F_STALE indicates that the iomap is not valid any longer and the file
  * range it covers needs to be remapped by the high level before the operation
  * can proceed.
+ *
+ * IOMAP_F_UNCACHED is set to indicate that writes to the page cache (and
+ * hence writeback) will result in folios being evicted as soon as the
+ * updated bytes are written back to the storage.
  */
 #define IOMAP_F_SIZE_CHANGED	(1U << 8)
 #define IOMAP_F_STALE		(1U << 9)
+#define IOMAP_F_UNCACHED	(1U << 10)
 
 /*
  * Flags from 0x1000 up are for file system specific usage:
@@ -173,8 +178,9 @@ struct iomap_folio_ops {
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
 #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
 #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
+#define IOMAP_UNCACHED		(1 << 8) /* uncached IO */
 #ifdef CONFIG_FS_DAX
-#define IOMAP_DAX		(1 << 8) /* DAX mapping */
+#define IOMAP_DAX		(1 << 9) /* DAX mapping */
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-- 
2.45.2


