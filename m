Return-Path: <linux-fsdevel+bounces-63691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39DBCB27D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60D93B09B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A75286D76;
	Thu,  9 Oct 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4fhS1Db"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B18285CBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050664; cv=none; b=eAHzTQmvfOaX+Ee0CMW++IDzkCpvGw1SBTHOIIqaPF/TifRNNAU26Uqwi09D9S6tIyS2ynzJeBcpCeNSef547y1I+6mWl3JkEDYjHYMP1yEFMGqkpG0kbeRYOCGRF7rhE7OglwKBOp9jCCYbuV4HJoGaIOzKEtx8Qj3VL/Te7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050664; c=relaxed/simple;
	bh=n4IVqlq8t0hbY9YHtkCg7ZL0cOTHHmiJwQWCRWoe/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn6dGv38aaVr4YhjNjtDuZUIfrJ1nRY1Srn9gm+BV0knCPBUYzq5k+iWPHN/oiBCGVL6uOHd+T8OUdn1LFfCW+jdpKBUrg/nDllSPDhOAg0jMUoCwIvPwCzfF5A/zZo9FLJtYSJCMqwZxvTcLdxXPi4553aPBLlcNGKStXaLOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4fhS1Db; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-793021f348fso1412281b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050662; x=1760655462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlfXx9s1YmQrV7yzJSac9OXNl/1heluIwcREBzBFPMg=;
        b=g4fhS1Db9VzRGCubTGViDXEv5GUpGOAAI3d8WlmtUPyaRtPvpZbuJ3/qurpEihLGAg
         j8eAatdOg4jqGOIZf1ILHwp8g/CuiqLud2fW3Aey2V4htus4lassy2q1C53XfMgRc7H0
         YYfxER0/x8blA6XgyHyHZ4sqqOBweoxmnY6KHi11jxs4vY9VuSvURLD3Y59JwDxQ7ZLI
         u7MeTo9WRAV3Rm4P70C11CxSRal5PQ8p7NUvL+FC/puCLS10mtv1YQCtq2lCHDJIgTsS
         GcxoIqt8ggTlWM13hJPpqel6Y0a4SHWJR7MhwdahQ2oSHsP3PgZIrvjOyTzjHORg6DiW
         c2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050662; x=1760655462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlfXx9s1YmQrV7yzJSac9OXNl/1heluIwcREBzBFPMg=;
        b=GKOHJ9Juzt3YZPys98N6deTme1P5D3fWWSM43jDCyFsIlM8WSFsmAM3u/bpI/Nyex7
         Rk7qbTZLKK96oVDqGWsBVecODPB/4RR7RdrGRGguVdILK+HOimlHtgTixUq5WqhrpLmi
         qe90ptm7ChH1CBVU6mZk/g3aldaD99HwV3pUBP3TSkGHK8DKEbg4pZqMZuT8a1s8tzXR
         GtYzG5JIp82Q/chDzKWn8v5W44MubQrN3nWHa3uUAv7boIv+eXdCYfr++PYriIhEz07x
         bfwpKVMxXRVkSDKALkC+Gmo5c+NLYV4IL/UiBXkQ57r2GMKFGJF2UI6eAL5UNRo9nAsB
         lVUg==
X-Forwarded-Encrypted: i=1; AJvYcCWmMiClx116LtvUCJmWpv1CPfJ8ldSW5YGxyqrIegk9w36D0BDYrJkXq6Amb9GbRQWfvtGL39fIVjkbUsOP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05OlGDAronUtzZgwNrN78wGVxV0eetHOUKPH7Uyv58wuktG8k
	9he/UWmfH9a4FQ/hk+2jQ0vRUD3qEXhnB1tWELd/F5rjreNrUDcmQNhS
X-Gm-Gg: ASbGncu8gGKRPz2l1ksedbhqDewq8NOPa8lPakBToFjEfR2Y4af4chtLCKN/5S19jri
	DaIq0L4IaPb3pPMLP6rmfNJKxRHqIqu9q68MkpAY/y2mhwDmN2UzC+AjGExri9x+JTflDyenHSY
	6RM7k+5RfWMCxQzPlPemi/GfAtqjZ5rc6o7GhU+PnswMcA5hiqLQuaGXBu2PN0hyD4tU9knNJut
	D6S7O//coaa0lsOwb+XeRxZXWRjMfB6ZqvevxzEE0rphqtNwzXDOyfJQOe+5Mq/mNbYE0ssrJep
	Yq9oDfOG/uyAKcvL8J9oBvNn+9kFVGP0Xigb2x2xeKpbe4GzIG1R6nQCn6OqURwYIHnGf0Oik9n
	B3F698CCg5cSCJyDqB89HeSN6yNWaHyAlHX7Im9Ub8r2RMZ23n/1EBQQITr4w0EaQh1sD4bpsyh
	OuUGMcecUc
X-Google-Smtp-Source: AGHT+IF8ckrXFpKayMaNbgV+xVTkKoDtgJqPVgngbDI5d00najufY0q8XoRMc7G60K41jgK2Bof9Zw==
X-Received: by 2002:a05:6a20:2585:b0:324:b245:bb8e with SMTP id adf61e73a8af0-32da81facc8mr12735891637.26.1760050661611;
        Thu, 09 Oct 2025 15:57:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd85317sm807312b3a.79.2025.10.09.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 3/9] iomap: optimize pending async writeback accounting
Date: Thu,  9 Oct 2025 15:56:05 -0700
Message-ID: <20251009225611.3744728-4-joannelkoong@gmail.com>
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
 fs/iomap/buffered-io.c | 45 +++++++++++++++++-------------------------
 fs/iomap/ioend.c       |  2 --
 include/linux/iomap.h  |  2 --
 4 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7c9c00784e33..01d378f8de18 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1883,7 +1883,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		iomap_finish_folio_write(inode, ap->folios[i], 1);
+		iomap_finish_folio_write(inode, ap->folios[i],
+					 ap->descs[i].length);
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		wb_writeout_inc(&bdi->wb);
 	}
@@ -2225,7 +2226,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		ap = &wpa->ia.ap;
 	}
 
-	iomap_start_folio_write(inode, folio, 1);
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
 				      offset, len);
 	data->nr_bytes += len;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1c6575b7e583..7f914d5ac25d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1552,16 +1552,16 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
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
@@ -1578,7 +1578,7 @@ EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
-		bool *wb_pending)
+		unsigned *wb_bytes_pending)
 {
 	do {
 		ssize_t ret;
@@ -1591,12 +1591,11 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		rlen -= ret;
 		pos += ret;
 
-		/*
-		 * Holes are not be written back by ->writeback_range, so track
+		/* Holes are not written back by ->writeback_range, so track
 		 * if we did handle anything that is not a hole here.
 		 */
 		if (wpc->iomap.type != IOMAP_HOLE)
-			*wb_pending = true;
+			*wb_bytes_pending += ret;
 	} while (rlen);
 
 	return 0;
@@ -1667,7 +1666,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	bool wb_pending = false;
+	unsigned wb_bytes_pending = 0;
 	int error = 0;
 	u32 rlen;
 
@@ -1687,14 +1686,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
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
@@ -1709,13 +1701,13 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
-				&wb_pending);
+				&wb_bytes_pending);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (wb_pending)
+	if (wb_bytes_pending)
 		wpc->nr_folios++;
 
 	/*
@@ -1732,13 +1724,12 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
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
+			folio_size(folio) - wb_bytes_pending);
+	else if (!wb_bytes_pending)
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
index e6fa812229dc..a156a9964938 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -474,8 +474,6 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
 void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		int error);
-void iomap_start_folio_write(struct inode *inode, struct folio *folio,
-		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 
-- 
2.47.3


